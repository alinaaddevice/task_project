import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_project/component/app_bar_widget.dart';
import 'package:task_project/component/button_widget.dart';
import 'package:task_project/component/title_widget.dart';
import 'package:task_project/screens/name/form_field_widget.dart';
import 'package:task_project/screens/name/bloc/name_screen_bloc.dart';
import 'package:task_project/screens/name/bloc/name_screen_event.dart';
import 'package:task_project/screens/name/bloc/name_screen_state.dart';
import 'package:task_project/shared/constants/app_colors.dart';
import 'package:task_project/shared/repositories/user_repository.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<NameScreen> {
  late NameScreenBloc _bloc;

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NameScreenBloc>(
        create: ((context) =>
            _bloc = NameScreenBloc(repository: SharedPreferenceRepository())),
        child: BlocListener<NameScreenBloc, NameScreenState>(
            listener: _listener,
            child: Scaffold(
                body: SafeArea(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const AppBarWidget(showPrefix: false),
                              const TitleWidget(title: 'Welcome onboard!'),
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 24),
                                  child: Text(
                                      'First off, what should I call you?',
                                      style: TextStyle(
                                          color: ColorAddition.woodsmokeColor,
                                          fontSize: 16,
                                          height: 24 / 16))),
                              const FormFieldWidget(title: 'Your name'),
                              ButtonWidget(
                                  title: 'Next',
                                  buttonState: ButtonState.active,
                                  onTap: _onTap)
                            ]))))));
  }
}

extension _ActionState on _State {
  void _listener(context, state) {
    if (state is NameSavedState) {
      Navigator.pushNamed(context, '/ageRange');
    }
  }

  void _onTap() => _bloc.add(SaveNameEvent());
}
