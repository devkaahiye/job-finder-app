import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:job_findder_app/constants/appColors.dart';

import '../../../../models/jobs.dart';
import '../widgets/circleImage.dart';

class JobDetailsScreen extends StatefulWidget {
  final Job job;
  static const String routeName = '/job-details';

  const JobDetailsScreen({super.key, required this.job});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/gradient-wave-colorful.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Column(
              children: [
                Expanded(
                    flex: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.bookmark_rounded,
                              color: Colors.white),
                        )
                      ],
                    )),
                Expanded(
                  flex: 26,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        top: 40,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: AppColors.backgroundColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(60),
                              topRight: Radius.circular(60),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: CircleImageWithBorder(
                            imageUrl: widget.job.companyLogoUrl,
                            borderWidth: 4.0,
                          ),
                        ),
                      ),
                      Positioned.fill(
                        top: 140,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Center(
                                  child: Text(
                                    widget.job.title,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Center(
                                  child: Text(
                                    widget.job.company,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const ListTile(
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 8,
                                          ),
                                          leading: CircleAvatar(
                                            backgroundColor:
                                                AppColors.secondaryColor,
                                            child: Icon(
                                              Icons.monetization_on,
                                              color: Colors.white,
                                            ),
                                          ),
                                          title: Text(
                                            'Salary',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          subtitle: Text(
                                            '\$600 - \$800',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: ListTile(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 8,
                                          ),
                                          leading: const CircleAvatar(
                                            backgroundColor:
                                                AppColors.secondaryColor,
                                            child: Icon(
                                              Icons.work_history,
                                              color: Colors.white,
                                            ),
                                          ),
                                          title: const Text(
                                            'Job type',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          subtitle: Text(
                                            widget.job.jobType,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 30),
                                const Text(
                                  "Job Details",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  widget.job.description,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 30),
                                const Text(
                                  "Requirrments",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                for (var item
                                    in widget.job.experienceRequirements)
                                  Text(
                                    "* $item",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                const SizedBox(height: 30),
                                const Text(
                                  "Resonsibilities",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                for (var item in widget.job.responsibilities)
                                  Text(
                                    "* $item",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                const SizedBox(height: 30),
                                const Text(
                                  "Qualifications",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                for (var item in widget.job.qualifications)
                                  Text(
                                    "* $item",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                const SizedBox(height: 30),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                backgroundColor: AppColors.secondaryColor,
                foregroundColor: Colors.white),
            onPressed: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Text('Apply Now'),
            )),
      ),
    );
  }
}



 // body: Column(
      //   children: [
      //     SizedBox(
      //       height: size.height * 0.4,
      //       child: Stack(children: [
      //         Positioned(
      //           left: 20,
      //           right: 20,
      //           top: 50,
      //           child: Container(
      //             height: size.height * 0.3,
      //             width: double.infinity,
      //             decoration: BoxDecoration(
      //                 color: Colors.white,
      //                 borderRadius: BorderRadius.circular(20)),
      //           ),
      //         ),
      //         Positioned(
      //           top: 20,
      //           left: 0,
      //           right: 0,
      //           child: Column(
      //             children: [
      //               Image.network(
      //                 widget.job.companyLogoUrl,
      //                 height: 80,
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.only(right: 10),
      //                 child: Container(
      //                   padding: const EdgeInsets.symmetric(horizontal: 8),
      //                   width: size.width * 0.84,
      //                   decoration: BoxDecoration(
      //                     color: Colors.white,
      //                     borderRadius: BorderRadius.circular(18),
      //                   ),
      //                   child: Column(
      //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                     children: [
      //                       const SizedBox(height: 20),
      //                       Column(
      //                         children: [
      //                           Text(
      //                             widget.job.title,
      //                             style: const TextStyle(
      //                                 color: AppColors.primarycolor,
      //                                 fontSize: 20,
      //                                 fontWeight: FontWeight.w700),
      //                           ),
      //                           const SizedBox(
      //                             height: 8,
      //                           ),
      //                           Text(widget.job.company,
      //                               style: const TextStyle(
      //                                 color: Colors.black54,
      //                               )),
      //                           const SizedBox(
      //                             height: 8,
      //                           ),
      //                         ],
      //                       ),
      //                       Row(
      //                         mainAxisAlignment: MainAxisAlignment.center,
      //                         children: [
      //                           const Icon(
      //                             Icons.location_on,
      //                             size: 18,
      //                           ),
      //                           const SizedBox(width: 4),
      //                           Text(
      //                             widget.job.city,
      //                             style: const TextStyle(
      //                                 color: AppColors.primarycolor,
      //                                 fontSize: 16,
      //                                 fontWeight: FontWeight.w500),
      //                           ),
      //                         ],
      //                       ),
      //                       const SizedBox(
      //                         height: 12,
      //                       ),
      //                       Row(
      //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                         children: [
      //                           Container(
      //                             decoration: BoxDecoration(
      //                                 shape: BoxShape.rectangle,
      //                                 color: Colors.grey.shade200,
      //                                 borderRadius: BorderRadius.circular(8)),
      //                             child: Padding(
      //                               padding: const EdgeInsets.all(8.0),
      //                               child: Text(widget.job.city,
      //                                   style: const TextStyle(
      //                                       color: Colors.grey)),
      //                             ),
      //                           ),
      //                           const SizedBox(width: 8),
      //                           Container(
      //                             decoration: BoxDecoration(
      //                                 shape: BoxShape.rectangle,
      //                                 color: Colors.grey.shade200,
      //                                 borderRadius: BorderRadius.circular(8)),
      //                             child: Padding(
      //                               padding: const EdgeInsets.all(8.0),
      //                               child: Text(
      //                                   DateFormat.yMMMMd('en_US')
      //                                       .format(widget.job.postedDate!),
      //                                   maxLines: 1,
      //                                   overflow: TextOverflow.ellipsis,
      //                                   style: const TextStyle(
      //                                       color: Colors.grey)),
      //                             ),
      //                           ),
      //                           const SizedBox(width: 8),
      //                           Container(
      //                             decoration: BoxDecoration(
      //                                 shape: BoxShape.rectangle,
      //                                 color: Colors.grey.shade200,
      //                                 borderRadius: BorderRadius.circular(8)),
      //                             child: Padding(
      //                               padding: const EdgeInsets.all(8.0),
      //                               child: Text(widget.job.jobType,
      //                                   style: const TextStyle(
      //                                       color: Colors.grey)),
      //                             ),
      //                           )
      //                         ],
      //                       ),
      //                       const Row(
      //                         mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                         children: [
      //                           Text('Mogadishu, Somalia',
      //                               style: TextStyle(
      //                                   color: Colors.white,
      //                                   fontWeight: FontWeight.w700)),
      //                           Text('\$900/month',
      //                               style: TextStyle(
      //                                   color: Colors.white,
      //                                   fontWeight: FontWeight.w700)),
      //                         ],
      //                       )
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ]),
      //     ),
      //     const SizedBox(height: 30),
      //     Expanded(
      //       child: DefaultTabController(
      //         length: 3,
      //         child: Column(
      //           children: [
      //             const TabBar(
      //               indicatorSize: TabBarIndicatorSize.label,
      //               indicatorColor: AppColors.primarycolor,
      //               unselectedLabelColor: Colors.grey,
      //               labelStyle: TextStyle(
      //                   fontSize: 18,
      //                   fontWeight: FontWeight.bold,
      //                   color: AppColors.primarycolor),
      //               tabs: [
      //                 Tab(text: 'Overview'),
      //                 Tab(text: 'Experience'),
      //                 Tab(text: 'More'),
      //               ],
      //             ),
      //             Expanded(
      //               child: TabBarView(
      //                 children: [
      //                   // Content for Tab 1
      //                   Padding(
      //                     padding: const EdgeInsets.symmetric(
      //                         horizontal: 20, vertical: 10),
      //                     child: Column(
      //                       crossAxisAlignment: CrossAxisAlignment.start,
      //                       children: [
      //                         Text(widget.job.jobOverview,
      //                             style: const TextStyle(
      //                                 fontSize: 18,
      //                                 fontWeight: FontWeight.w400)),
      //                       ],
      //                     ),
      //                   ),
      //                   // Content for Tab 2
      //                   Padding(
      //                     padding: const EdgeInsets.symmetric(
      //                         horizontal: 20, vertical: 10),
      //                     child: ListView.builder(
      //                       itemCount: widget.job.experienceRequirements.length,
      //                       itemBuilder: (BuildContext context, int index) {
      //                         var req =
      //                             widget.job.experienceRequirements[index];
      //                         return Row(
      //                           crossAxisAlignment: CrossAxisAlignment.start,
      //                           children: [
      //                             const Text(
      //                               "*",
      //                               style: TextStyle(
      //                                   fontWeight: FontWeight.bold,
      //                                   fontSize: 22),
      //                             ),
      //                             const SizedBox(width: 10),
      //                             Expanded(
      //                               child: Text(
      //                                 req,
      //                                 style: const TextStyle(
      //                                     fontSize: 18,
      //                                     fontWeight: FontWeight.w400),
      //                               ),
      //                             ),
      //                           ],
      //                         );
      //                       },
      //                     ),
      //                   ),
      //                   // Content for Tab 3
      //                   Padding(
      //                     padding: const EdgeInsets.symmetric(
      //                         horizontal: 20, vertical: 10),
      //                     child: Column(
      //                       children: [
      //                         Flexible(
      //                           child: ListView.builder(
      //                             physics: const NeverScrollableScrollPhysics(),
      //                             shrinkWrap: true,
      //                             itemCount: widget.job.qualifications.length,
      //                             itemBuilder:
      //                                 (BuildContext context, int index) {
      //                               var qualifications =
      //                                   widget.job.qualifications[index];
      //                               return Row(
      //                                 crossAxisAlignment:
      //                                     CrossAxisAlignment.start,
      //                                 children: [
      //                                   const Text(
      //                                     "*",
      //                                     style: TextStyle(
      //                                         fontWeight: FontWeight.bold,
      //                                         fontSize: 22),
      //                                   ),
      //                                   const SizedBox(width: 10),
      //                                   Expanded(
      //                                     child: Text(
      //                                       qualifications,
      //                                       style: const TextStyle(
      //                                           fontSize: 18,
      //                                           fontWeight: FontWeight.w400),
      //                                     ),
      //                                   ),
      //                                 ],
      //                               );
      //                             },
      //                           ),
      //                         ),
      //                         const SizedBox(height: 10),
      //                         const Text('Responsibilities'),
      //                         Flexible(
      //                           child: ListView.builder(
      //                             physics: const NeverScrollableScrollPhysics(),
      //                             shrinkWrap: true,
      //                             itemCount: widget.job.responsibilities.length,
      //                             itemBuilder:
      //                                 (BuildContext context, int index) {
      //                               var responsibilities =
      //                                   widget.job.responsibilities[index];
      //                               return Row(
      //                                 crossAxisAlignment:
      //                                     CrossAxisAlignment.start,
      //                                 children: [
      //                                   const Text(
      //                                     "*",
      //                                     style: TextStyle(
      //                                         fontWeight: FontWeight.bold,
      //                                         fontSize: 22),
      //                                   ),
      //                                   const SizedBox(width: 10),
      //                                   Expanded(
      //                                     child: Text(
      //                                       responsibilities,
      //                                       style: const TextStyle(
      //                                           fontSize: 18,
      //                                           fontWeight: FontWeight.w400),
      //                                     ),
      //                                   ),
      //                                 ],
      //                               );
      //                             },
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),