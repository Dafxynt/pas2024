import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'logContoller.dart';
import 'package:pas_mobile_11pplg1_10/reuse_component/CustomTextField.dart';
import 'package:pas_mobile_11pplg1_10/reuse_component/CustomButton.dart';
import 'package:pas_mobile_11pplg1_10/reuse_component/statuscard.dart';

class LogView extends StatelessWidget {
  final LogController logController = Get.put(LogController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.teal[400]!, Colors.teal[800]!],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.account_circle,
                      size: 80,
                      color: Colors.teal,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    // Reuse CustomTextField
                    CustomTextField(
                      controller: logController.usernameController,
                      label: 'Username',
                      icon: Icons.person,
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      controller: logController.passwordController,
                      label: 'Password',
                      icon: Icons.lock,
                      isPassword: true,
                    ),
                    SizedBox(height: 24),
                    // Reuse CustomButton
                    CustomButton(
                      label: 'Login',
                      onPressed: () {
                        logController.loginUser(
                          logController.usernameController.text,
                          logController.passwordController.text,
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    Obx(() {
                      if (logController.isLoading.value) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (logController.postList.isNotEmpty) {
                        final status = logController.postList.last;
                        // Reuse StatusCard
                        return StatusCard(
                          status: status.status,
                          message: status.message,
                        );
                      }

                      return SizedBox();
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
