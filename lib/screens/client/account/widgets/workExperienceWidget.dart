import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../provider/userProvider.dart';

class WorkExperienceWidget extends StatefulWidget {
  static const String routeName = "/work-experience-details";
  const WorkExperienceWidget({super.key});

  @override
  State<WorkExperienceWidget> createState() => _WorkExperienceWidgetState();
}

class _WorkExperienceWidgetState extends State<WorkExperienceWidget> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context, listen: false).user;
    print(user.workExperience);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Work Experience List'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        itemCount: user.workExperience!.length,
        itemBuilder: (BuildContext context, int index) {
          var wex = user.workExperience![index];
          String stdate = wex.startDate.toString();
          String enddate = wex.endDate.toString();
          var startTime = DateTime.parse(stdate);
          var endTime = DateTime.parse(enddate);
          // int.parse(wex['startDate'].replaceAll(RegExp(r'[^0-9]'), ''));
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          flex: 6,
                          child: Text(
                            "Title: ",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Text(
                            wex.title,
                            style: const TextStyle(fontSize: 18),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Expanded(
                          flex: 6,
                          child: Text(
                            "Category: ",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Text(
                            wex.category,
                            style: const TextStyle(fontSize: 18),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Expanded(
                          flex: 6,
                          child: Text(
                            "EmploymentType: ",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Text(
                            wex.employmentType,
                            style: const TextStyle(fontSize: 18),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Expanded(
                          flex: 6,
                          child: Text(
                            "CompanyName: ",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Text(
                            wex.companyName,
                            style: const TextStyle(fontSize: 18),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Expanded(
                          flex: 6,
                          child: Text(
                            "Location: ",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Text(
                            wex.location,
                            style: const TextStyle(fontSize: 18),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Expanded(
                          flex: 6,
                          child: Text(
                            "CurrentlyWork: ",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Text(
                            wex.currentlyWorking ? "NO" : "YES",
                            style: const TextStyle(fontSize: 18),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Expanded(
                          flex: 6,
                          child: Text(
                            "Start Date: ",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Text(
                            " ${DateFormat.yMMMMd('en_US').format(startTime)}",
                            style: const TextStyle(fontSize: 18),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Expanded(
                          flex: 6,
                          child: Text(
                            "End Date: ",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Text(
                            " ${DateFormat.yMMMMd('en_US').format(endTime)}",
                            style: const TextStyle(fontSize: 18),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
