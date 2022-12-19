import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_project/component/title_widget.dart';
import 'package:task_project/screens/age/age_button.dart';
import 'package:task_project/component/app_bar_widget.dart';
import 'package:task_project/component/button_widget.dart';
import 'package:task_project/screens/age/bloc/age_screen_bloc.dart';
import 'package:task_project/screens/age/bloc/age_screen_event.dart';
import 'package:task_project/screens/age/bloc/age_screen_state.dart';
import 'package:task_project/screens/age/age_enum.dart';
import 'package:task_project/shared/repositories/user_repository.dart';

class AgeRangeScreen extends StatefulWidget {
  const AgeRangeScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<AgeRangeScreen> {
  late AgeScreenBloc _bloc;

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AgeScreenBloc>(
        create: (context) =>
            _bloc = AgeScreenBloc(userRepository: SharedPreferenceRepository()),
        child: BlocBuilder<AgeScreenBloc, AgeScreenState>(
            builder: (context, state) => Scaffold(
                    body: SafeArea(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                      const AppBarWidget(),
                      Expanded(
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const TitleWidget(
                                        padding:
                                            EdgeInsets.only(top: 8, bottom: 24),
                                        title: 'How old are you?'),
                                    Expanded(
                                        child: _AgeRangesList(
                                            currentAge: state
                                                    is AgeRangeSavedState
                                                ? state.ageRange
                                                : state is AgeRangeSelectedState
                                                    ? state.ageRange
                                                    : null,
                                            onTap: (AgeRange age) => _bloc.add(
                                                SelectAgeRangeEvent(
                                                    ageRange: age)))),
                                    ButtonWidget(
                                        buttonState:
                                            state is AgeRangeSelectedState ||
                                                    state is AgeRangeSavedState
                                                ? ButtonState.active
                                                : ButtonState.inactive,
                                        title: 'Save',
                                        onTap: () =>
                                            _bloc.add(SaveAgeRangeEvent()))
                                  ])))
                    ])))));
  }
}

class _AgeRangesList extends StatelessWidget {
  const _AgeRangesList(
      {required this.currentAge, required this.onTap, Key? key})
      : super(key: key);

  final AgeRange? currentAge;
  final _OnTapInput onTap;

  @override
  Widget build(BuildContext context) {
    final children = AgeRange.values
        .map((age) => Row(mainAxisSize: MainAxisSize.min, children: [
              AgeButton(
                  age: age,
                  isSelected: currentAge == age,
                  onTap: () => onTap(age))
            ]))
        .toList();

    return ListView(physics: const ClampingScrollPhysics(), children: children);
  }
}

typedef _OnTapInput = void Function(AgeRange name);
