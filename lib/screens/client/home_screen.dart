import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/models/jobs.dart';
import '/screens/client/details/screens/job_details.dart';
import '/screens/client/services/client_services.dart';

import '../../constants/appColors.dart';
import '../admin/jobs/services/jobServices.dart';
import 'widgets/search_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Job> jobsList = [];
  List<Job> recoJobsList = [];

  final JobServices _jobServices = JobServices();
  final ClientServices _clientServices = ClientServices();

  void getAllJobs() async {
    jobsList = await _jobServices.getAllJobs(context: context);

    if (mounted) {
      setState(() {});
    }
  }

  void getRecommendedJobs() async {
    recoJobsList = await _clientServices.getRecommendedJobs(context: context);

    if (mounted) {
      setState(() {});
    }
  }

  void bookmarkJob(String id) {
    _clientServices.bookmarkJob(context: context, onError: () {}, id: id);
  }

  @override
  void initState() {
    getAllJobs();
    getRecommendedJobs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.grid_view_outlined),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              child: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.person_2_outlined)),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: size.height * 0.01,
              ),
              const SearchBox(),
              SizedBox(
                height: size.height * 0.03,
              ),
              const Text(
                'For you',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    color: AppColors.primarycolor),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "assets/job_banner.png",
                  fit: BoxFit.fitHeight,
                  height: 200,
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              const Text(
                'Popular Jobs',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    color: AppColors.primarycolor),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              _buildPopukarJobs(size),
              SizedBox(
                height: size.height * 0.03,
              ),
              const Text(
                'Recomended for your',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    color: AppColors.primarycolor),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              _buildRecomendedJobs(size),
              SizedBox(
                height: size.height * 0.03,
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildPopukarJobs(Size size) {
    return SizedBox(
      height: size.height * 0.17,
      child: jobsList.isEmpty
          ? ListView.builder(
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: CardLoading(
                    height: size.height * 0.25,
                    width: size.width * 0.75,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                );
              },
            )
          : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: jobsList.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                var job = jobsList[index];
                return GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => JobDetailsScreen(job: job))),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        width: size.width * 0.75,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Image.network(
                                job.companyLogoUrl,
                                width: 40,
                              ),
                              title: Text(
                                job.title,
                                style: const TextStyle(
                                    color: AppColors.primarycolor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    job.company,
                                    style: const TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '\$${job.salary} - \$${job.salary}',
                                    style: const TextStyle(
                                        color: AppColors.secondaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              trailing: IconButton(
                                  onPressed: () =>
                                      bookmarkJob(job.id.toString()),
                                  icon: const Icon(
                                    Icons.bookmark_add,
                                    color: Colors.black54,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  Flexible _buildRecomendedJobs(Size size) {
    return Flexible(
      child: recoJobsList.isEmpty
          ? ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: CardLoading(
                    height: size.height * 0.25,
                    width: size.width * 0.75,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                );
              },
            )
          : ListView.builder(
              itemCount: recoJobsList.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                var job = recoJobsList[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Card(
                    surfaceTintColor: Colors.white,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 6),
                          leading: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                job.companyLogoUrl,
                                width: 25,
                              ),
                            ),
                          ),
                          title: Text(job.title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: AppColors.primarycolor)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(job.company,
                                  style:
                                      const TextStyle(color: Colors.black54)),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(job.city,
                                          style: const TextStyle(
                                              color: Colors.grey)),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: Colors.grey.shade200,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(job.jobType,
                                          style: const TextStyle(
                                              color: Colors.grey)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            onPressed: () => bookmarkJob(job.id.toString()),
                            icon: const Icon(
                              Icons.bookmark_add,
                              color: Colors.black54,
                            ),
                          )),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
