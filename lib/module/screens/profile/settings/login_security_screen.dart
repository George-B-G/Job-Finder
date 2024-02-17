import 'package:amit_job_finder/module/screens/profile/settings/Email_address_screen.dart';
import 'package:amit_job_finder/module/screens/profile/settings/change_password_screen.dart';
import 'package:amit_job_finder/module/screens/profile/settings/edit_phone_number.dart';
import 'package:amit_job_finder/shared/components/components.dart';
import 'package:flutter/material.dart';

class LoginSecurityScreen extends StatelessWidget {
  const LoginSecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appbarWithLogo(
                    title: 'Login and security',
                  ),
      body: ListView(
        children: [
          screenSeparator(title: 'Account access'),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                ListTile(
                  title: const Text('Email address'),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () => pushToPage(
                      context: context, screenName: EmailAdressScreen()),
                ),
                const Divider(),
                ListTile(
                  title: const Text('phone number'),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () => pushToPage(
                      context: context, screenName: EditPhoneNumberScreen()),
                ),
                const Divider(),
                ListTile(
                  title: const Text('change password'),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () => pushToPage(
                      context: context, screenName: ChangePasswordScreen()),
                ),
                const Divider(),
                ListTile(
                  title: const Text('two-step verification'),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {},
                ),
                const Divider(),
                ListTile(
                  title: const Text('face ID'),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
