import 'package:flutter/material.dart';
import 'package:job_findder_app/models/jobs.dart';
import 'package:job_findder_app/screens/client/bookmark/widgets/recommendedProduct.dart';
import 'package:provider/provider.dart';

import '../../../../constants/appColors.dart';
import '../../../../provider/userProvider.dart';
import '../../details/screens/job_details.dart';

class BookMark extends StatefulWidget {
  const BookMark({super.key});

  @override
  State<BookMark> createState() => _BookMarkState();
}

class _BookMarkState extends State<BookMark> {
  List<Job> jobsList = [];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final jobsList = context.watch<UserProvider>().user.bookMarks;
    return PopScope(
      canPop: false,
      child: Scaffold(
          appBar: AppBar(
            elevation: 3,
            automaticallyImplyLeading: false,
            title: const Text('Bookmarks'),
          ),
          backgroundColor: Colors.grey.shade200,
          body: jobsList == [] ? Center(child: Text('No'),) :ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            itemCount: jobsList!.length,
            itemBuilder: (BuildContext context, int index) {
              var job = jobsList[index];
              return GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => JobDetailsScreen(job: job))),
                child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: RecommendedJob(index: index)),
              );
            },
          )),
    );
  }
}
