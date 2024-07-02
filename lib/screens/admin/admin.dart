import 'package:flutter/material.dart';
import '/screens/admin/jobs/services/jobServices.dart';
import '/screens/admin/services/admin_services.dart';
import '/screens/admin/widgets/customContainer.dart';

import '../../constants/global_variables.dart';
import '../../models/jobs.dart';
import 'jobs/screens/update_jobs.dart';
import 'jobs/widgets/jobWidget.dart';
import 'widgets/navigation.dart';

class AdminScreen extends StatefulWidget {
  static const String routeName = '/admin';
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List<Job>? jobsList;
  List<dynamic> counts = [];
  final JobServices _jobServices = JobServices();
  final AdminServices _adminServices = AdminServices();

  void getRecentJobs() async {
    jobsList = await _jobServices.getRecentJobs(context: context);

    if (context.mounted) {
      setState(() {});
    }
  }

  void getCounts() async {
    counts = await _adminServices.getCounts(context: context);

    if (context.mounted) {
      setState(() {});
    }
  }

  void deleteJobs(String id, int index) async {
    _jobServices.delete(
        id: id,
        context: context,
        onSuccess: () {
          jobsList!.removeAt(index);
          setState(() {});
        });

    if (context.mounted) {
      setState(() {});
    }
  }

  void navigateToUpdateJobScreen(Job job) async {
    var res = await Navigator.pushNamed(context, UpdateJobsScreen.routeName,
        arguments: job);

    if (res == 'refresh') {
      getRecentJobs();
    }
  }

  @override
  void initState() {
    getCounts();
    getRecentJobs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      drawer: const NavigatorDDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: size.height * 0.03,
              ),
              _buildDashboardContainerRow(
                totalJobs: counts.isNotEmpty ? counts[0] : 0,
                totalJoobSeekers: counts.isNotEmpty ? counts[1] : 0,
                size: size,
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              _buildDashboardContainerRow2(
                  totalCategries: counts.isNotEmpty ? counts[2] : 0,
                  totalSubCategries: counts.isNotEmpty ? counts[3] : 0,
                  size: size),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Recent jobs',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text('see all',
                                style: TextStyle(
                                  color: GlobalVariables.secondaryColor,
                                ))
                          ]),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Divider(
                        color: Colors.grey.shade200,
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView.builder(
                  itemCount: jobsList == null ? 0 : jobsList!.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    var job = jobsList![index];
                    return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: JobWidget(
                            job: job,
                            navigateToUpdateJobScreen: () {
                              navigateToUpdateJobScreen(job);
                            },
                            deleteJobs: () {
                              deleteJobs(job.id.toString(), index);
                            }));
                  },
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Row _buildDashboardContainerRow(
      {required Size size,
      required int totalJobs,
      required int totalJoobSeekers}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: size.height * 0.15,
          width: size.width * 0.43,
          child: CustomContainer(
            title: 'Total Jobs',
            value: totalJobs,
            color: GlobalVariables.pistachio,
          ),
        ),
        SizedBox(
            height: size.height * 0.15,
            width: size.width * 0.43,
            // ignore: prefer_const_constructors
            child: CustomContainer(
              title: 'Job Seekers',
              value: totalJoobSeekers,
              color: GlobalVariables.paradisePink,
            )),
      ],
    );
  }

  Row _buildDashboardContainerRow2(
      {required Size size,
      required int totalCategries,
      required int totalSubCategries}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            height: size.height * 0.15,
            width: size.width * 0.43,
            child: CustomContainer(
              title: 'Total Categories',
              value: totalCategries,
              color: GlobalVariables.crayola,
            )),
        SizedBox(
            height: size.height * 0.15,
            width: size.width * 0.43,
            child: CustomContainer(
              title: 'Total SubCategories',
              value: totalSubCategries,
              color: GlobalVariables.unitedNationsBlue,
            )),
      ],
    );
  }
}
