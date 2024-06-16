import 'dart:async';



import 'package:flutter/material.dart';

import 'package:hive/hive.dart';

import '../utils/core.dart';
import 'widget/form_details.dart';
import 'widget/internet_checker.dart';
import 'widget/title_text.dart';

class ApplicationForm extends StatefulWidget {
  const ApplicationForm({super.key});

  @override
  State<ApplicationForm> createState() => _ApplicationFormState();
}

class _ApplicationFormState extends State<ApplicationForm> {

  late StreamSubscription connectionChangeStream;
  bool isConnected = false;
  var myBox = Hive.box(AppString.hiveOpenDatabaseName);
  List myUserDataList = [];

  @override
  void initState() {
    super.initState();
    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    connectionChangeStream =
        connectionStatus.connectionChange.listen(connectionChanged);
  }

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isConnected = !hasConnection;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: AppScreenDefaultPadding.paddingWithAppbarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TitleText(
                      title: AppString.userDetails, textSize: TextSizes.large),
                  Icon(
                    !isConnected ? Icons.check_circle : Icons.error,
                    size: 50,
                    color: !isConnected ? Colors.green : Colors.red,
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.spaceBtwSections - 14),

              /// Application Form Details
              const FormDetails(),
            ],
          ),
        ),
      ),
    );
  }
}
