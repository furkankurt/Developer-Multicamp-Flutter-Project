import 'package:fk_haber/src/config/base/base_state.dart';
import 'package:fk_haber/src/config/constants/route_constants.dart';
import 'package:fk_haber/src/config/navigation/navigation_service.dart';
import 'package:fk_haber/src/config/theme/app_colors.dart';
import 'package:fk_haber/src/provider/auth_provider.dart';
import 'package:fk_haber/src/ui/shared/custom_button.dart';
import 'package:fk_haber/src/utils/handlers/auth_exception_handler.dart';
import 'package:fk_haber/src/utils/my_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseState<RegisterPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  FocusNode _emailFocus = FocusNode();
  FocusNode _passwordFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          KeyboardAvoider(
            autoScroll: true,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FeatherIcons.feather,
                    size: dynamicWidth(0.23),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Kayıt Ol",
                    style: GoogleFonts.exo2(fontSize: 30),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        FormBuilder(
                          autovalidateMode: _autoValidate,
                          key: _formKey,
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FormBuilderTextField(
                                  name: "email",
                                  decoration:
                                      myDecoration(label: "E-Posta Adresi"),
                                  focusNode: _emailFocus,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  onSubmitted: (_) => FocusScope.of(context)
                                      .requestFocus(_passwordFocus),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(context,
                                        errorText: "Bu alan boş bırakılamaz!"),
                                    FormBuilderValidators.email(context,
                                        errorText:
                                            "Lütfen geçerli bir e-posta adresi giriniz.")
                                  ]),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FormBuilderTextField(
                                  name: "password",
                                  decoration: myDecoration(label: "Şifre"),
                                  focusNode: _passwordFocus,
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.done,
                                  obscureText: true,
                                  onSubmitted: (_) => _submit(),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(context,
                                        errorText: "Bu alan boş bırakılamaz!"),
                                    FormBuilderValidators.minLength(context, 8,
                                        errorText:
                                            "Şifre en az 8 karakter olmalı.")
                                  ]),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: CustomButton(
                                    title: "Kayıt Ol",
                                    onPressed: () => _submit()),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Consumer<AuthProvider>(builder: (_, provider, child) {
            if (provider.isLoading) {
              return Scaffold(
                backgroundColor: AppColors.primaryBlueColor,
                body: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                ),
              );
            } else {
              return Container();
            }
          }),
        ],
      ),
    );
  }

  InputDecoration myDecoration({String label, bool isError = false}) {
    return InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(width: 1.2)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.red)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.red, width: 1.2)),
      labelText: label,
      labelStyle: GoogleFonts.exo2(),
    );
  }

  Future _submit() async {
    if (_formKey.currentState.saveAndValidate()) {
      var status = await authProvider.register(
        email: _formKey.currentState.value['email'].toString().trim(),
        password: _formKey.currentState.value['password'].toString().trim(),
      );
      if (status != AuthResultStatus.successful) {
        final errorMsg = AuthExceptionHandler.generateExceptionMessage(status);
        showMyDialog(context, errorMsg);
      } else {
        NavigationService.instance.navigateToReset(k_ROUTE_SPLASH);
      }
    } else {
      setState(() {
        _autoValidate = AutovalidateMode.always;
      });
    }
  }
}
