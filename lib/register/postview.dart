import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'post_controller.dart';
import 'package:pas_mobile_11pplg1_10/reuse_component/CustomTextField.dart';
import 'package:pas_mobile_11pplg1_10/reuse_component/CustomButton.dart';
import 'package:pas_mobile_11pplg1_10/reuse_component/StatusCard.dart';
import 'package:pas_mobile_11pplg1_10/login/logView.dart';

class PostView extends StatelessWidget {
  final PostController postController = Get.put(PostController());

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
                      Icons.assignment_rounded,
                      size: 80,
                      color: Colors.teal,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    // Reuse CustomTextField
                    CustomTextField(
                      controller: postController.usernameController,
                      label: 'Username',
                      icon: Icons.person,
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      controller: postController.passwordController,
                      label: 'Password',
                      icon: Icons.lock,
                      isPassword: true,
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      controller: postController.fullNameController,
                      label: 'Full Name',
                      icon: Icons.person_outline,
                    ),
                    SizedBox(height: 16),
                    CustomTextField(
                      controller: postController.emailController,
                      label: 'Email',
                      icon: Icons.email,
                    ),
                    SizedBox(height: 24),
                    // Reuse CustomButton
                    CustomButton(
                      label: 'Submit',
                      onPressed: () {
                        postController.registerUser(
                          postController.usernameController.text,
                          postController.passwordController.text,
                          postController.fullNameController.text,
                          postController.emailController.text,
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    Obx(() {
                      if (postController.isLoading.value) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (postController.postList.isEmpty) {
                        return Text(
                          'No data available',
                          style: TextStyle(color: Colors.grey),
                        );
                      }

                      return Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: postController.postList.length,
                            itemBuilder: (context, index) {
                              final status = postController.postList[index];
                              // Reuse StatusCard
                              return StatusCard(
                                status: status.status,
                                message: status.message,
                              );
                            },
                          ),
                          SizedBox(height: 20),
                          // Reuse CustomButton
                          CustomButton(
                            label: 'Go to Login Page',
                            icon: Icons.login,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LogView()),
                              );
                            },
                            color: Colors.green,
                          ),
                        ],
                      );
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
