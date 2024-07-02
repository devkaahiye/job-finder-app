import 'package:flutter/material.dart';
import 'package:job_findder_app/constants/global_variables.dart';

class ProfileWidget extends StatelessWidget {
  final String name;
  final String email;
  final VoidCallback onPressed;
  const ProfileWidget({super.key, required this.name, required this.email, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      child: Row(
        children: [
          const Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Profile',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8,
                ),
                CircleAvatar(
                  backgroundColor: GlobalVariables.secondaryColor,
                  foregroundColor: Colors.white,
                  radius: 35,
                  child: Icon(
                    Icons.person_3,
                    size: 35,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 6,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    email,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: GlobalVariables.secondaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    onPressed: onPressed,
                    child: const Text('Edit Your Profile')),
              ),
            ),
          )
        ],
      ),
    );
  }
}
