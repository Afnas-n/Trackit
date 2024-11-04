import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackit/Model/user_model.dart';
import 'package:trackit/controller/user_display_controller.dart';

class UserDisplay extends StatelessWidget {
  const UserDisplay({super.key});

  Future<void> _showMyDialog(
      BuildContext context, UserModel user, UserProvider userProvider) async {
    TextEditingController usernameController =
        TextEditingController(text: user.username);

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Username'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                // Get the updated username
                String updatedUsername = usernameController.text;

                // Update the user's username in the provider
                userProvider.updateUsername(user.id, updatedUsername);

                // Close the dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          StreamBuilder<List<UserModel>>(
            stream: userProvider.userStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("No users found."));
              }

              return Expanded(
                // Use Expanded to make the ListView take up remaining space
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var user = snapshot.data![index];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          // Pass the current user and the provider to the dialog
                          _showMyDialog(context, user, userProvider);
                        },
                        child: Container(
                          width: double.infinity, // Make the container fill the available width
                          height: 100, // Set a fixed height for each item
                          color: Colors.blue[400],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                user.email,
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                user.username,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
