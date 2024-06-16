import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterdatatest/screen/data/user_data_model.dart';
import 'package:flutterdatatest/utils/services.dart';
import 'package:hive/hive.dart';
import '../../utils/core.dart';
import 'app_common_button.dart';
import 'custom_card.dart';
import 'empty_data.dart';
import 'input_text_field.dart';
import 'title_text.dart';

class FormDetails extends StatefulWidget {
  const FormDetails({super.key});

  @override
  State<FormDetails> createState() => _FormDetailsState();
}

class _FormDetailsState extends State<FormDetails> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var myBox = Hive.box(AppString.hiveOpenDatabaseName);
  List myUserDataList = [];

  // CollectionReference messages = FirebaseFirestore.instance.collection('messages');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  addUserData(data) async {
    await myBox.add(data);
    debugPrint("${myBox.values}");
    getUserData();
  }

  void _clearTextFields() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    messageController.clear();
  }

  getUserData() {
    setState(() {
      myUserDataList = myBox.keys.map(
        (e) {
          var res = myBox.get(e);
          var getData = {
            'key': e,
            'firstName': res['firstName'],
            'lastName': res['lastName'],
            'email': res['email'],
            'message': res['message'],
            'dateAndTime': res['dateAndTime'],
          };
          return getData;
        },
      ).toList();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// first & lost name
          Row(
            children: [
              Expanded(
                child: TitleTextFormField(
                    controller: firstNameController,
                    title: AppString.firstName,
                    keyboardType: TextInputType.text,
                    validator: (value) =>
                        AppValidator.validateEmptyText("First Name", value),
                    titleHint: AppString.firstNameHint),
              ),
              const SizedBox(width: AppSizes.spaceBtwItems),
              Expanded(
                child: TitleTextFormField(
                  keyboardType: TextInputType.text,
                    controller: lastNameController,
                    validator: (value) =>
                        AppValidator.validateEmptyText("Last Name", value),
                    title: AppString.lastName,
                    titleHint: AppString.lastNameHint),
              ),
            ],
          ),

          /// email & message
          const SizedBox(height: AppSizes.spaceBtwItems),
          TitleTextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) => AppValidator.validateEmail(value),
              title: AppString.email,
              titleHint: AppString.emailHint),
          const SizedBox(height: AppSizes.spaceBtwItems),
          TitleTextFormField(
              controller: messageController,
              title: AppString.yourMessage,
              keyboardType: TextInputType.text,
              validator: (value) =>
                  AppValidator.validateEmptyText("Message", value),
              titleHint: AppString.yourMessageHint,
              maxLines: 5),

          /// Submit Button
          const SizedBox(height: AppSizes.spaceBtwItems),
          CommButton(
            btnTitle: "SUBMIT",
            onPressed: () async {

              //
              try {

                /// Start Loader
                CustomDialogBox.openLoader(context);

                // /// Internet check
                // final bool isConnected = ConnectionStatusSingleton.getInstance().checkConnection as bool;
                // if(!isConnected ){
                //   CustomDialogBox.stopLoadingDialog(context);
                //   return;
                // }

                if (!_formKey.currentState!.validate()) {
                  CustomDialogBox.stopLoadingDialog(context);
                  CustomSnackBar.warningSnackBar(context: context, title: 'Ops',msg: 'Please check field data');
                   return ;
                }



               final map = {
                  'firstName': firstNameController.text,
                  'lastName': lastNameController.text,
                  'email': emailController.text,
                  'message': messageController.text,
                  'dateAndTime': DateTime.now().toString(),
                };

                UserDetails userDetails = UserDetails(
                    firstName: firstNameController.text,
                    lastName: lastNameController.text,
                    email: emailController.text,
                    message: messageController.text,
                    dateAndTime: DateTime.now(),
                );

                debugPrint("------------------ User Data ----------------");
                debugPrint("First  : ${firstNameController.text}");
                debugPrint("last : ${lastNameController.text}");
                debugPrint("Email : ${emailController.text}");
                debugPrint("message : ${messageController.text}");
                debugPrint("dateAndTime : ${DateTime.now()}");

                // save data offline first
                // debugPrint(
                //     "------------------ Open loader ----------------");
                // CustomDialogBox.openLoadingDialogWithTimer(context,3);
                addUserData(map);

                debugPrint(
                    "------------------ Save To offline success ----------------");

                String jsoneData = jsonEncode( userDetails);
                debugPrint("------------------ Json Data ----------------");

                print(jsoneData);
                final UserRepository userRepository = UserRepository();
                await userRepository.addUserDetails(userDetails);
                _clearTextFields();
                debugPrint(
                    "------------------ all Controller clear ----------------");
                // CustomDialogBox.stopLoadingDialog(context);
                // debugPrint(
                //     "------------------ Stop Loader ----------------");
                CustomSnackBar.successSnackBar(context: context, title: 'Congratulation',msg: 'Your information has been added!');
                CustomDialogBox.stopLoadingDialog(context);
              } catch (e) {
                debugPrint("no error $e");
                CustomDialogBox.stopLoadingDialog(context);

              }
            },
          ),

          /// Form Report & title & delete button
          if (myUserDataList.isNotEmpty)
            const SizedBox(height: AppSizes.spaceBtwSections),
          if (myUserDataList.isNotEmpty)
            Row(
              children: [
                const TitleText(title: AppString.submittedMessage),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Delete All Local Data"),
                            content: const Text(
                                "Are you sure you want to delete all data?"),
                            actions: [
                              TextButton(
                                child: const Text("Cancel"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                  onPressed: () async {
                                    await myBox.clear();
                                    Navigator.of(context).pop();
                                    setState(() {
                                      print('delete all data');
                                      getUserData();

                                    });

                                  },
                                  child: const Text("Delete")),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                      size: 30,
                    ))
              ],
            ),
          if (myUserDataList.isNotEmpty)
            const SizedBox(height: AppSizes.spaceBtwItems),

          /// Form Report
          myUserDataList.isEmpty
              ? const EmptyData()
              : ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: myUserDataList.length,
                  itemBuilder: (context, index) => MyUserDataList(
                    email: "${myUserDataList[index]['email']}",
                    message: "${myUserDataList[index]['message']}",
                    name: "${myUserDataList[index]['firstName']}",
                    dateAndTime: "${myUserDataList[index]['dateAndTime']}",
                  ),
                )
        ],
      ),
    );
  }
}
