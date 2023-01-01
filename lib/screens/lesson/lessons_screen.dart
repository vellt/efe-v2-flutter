import 'package:efe_v2_flutter/controllers/lessons_controller.dart';
import 'package:efe_v2_flutter/models/book.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class LessonScreen extends StatelessWidget {
  LessonScreen(Book book, {Key? key}) : super(key: key) {
    this.book = Book(
      id: book.id,
      name: book.name,
      route: book.route,
    );
    lessonsController = Get.put(LessonsController(book));
  }

  late Book book;
  late LessonsController lessonsController;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: lessonsController.onInit(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return DefaultTabController(
                length: lessonsController.getLessons().length,
                initialIndex: lessonsController.indexOfSelectedLesson.value,
                child: Scaffold(
                  backgroundColor: Colors.black,
                  appBar: AppBar(
                    backgroundColor: Colors.black,
                    leading: Padding(
                      padding: EdgeInsets.only(left: 15.sp, bottom: 10.sp),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios, size: 15.sp),
                        onPressed: () => Get.back(),
                      ),
                    ),
                  ),
                  body: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: 20.sp,
                            right: 80.sp,
                          ),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              book.name,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 14.sp, vertical: 10.sp),
                          child: SizedBox(
                            height: 40.sp,
                            child: Container(
                              color: Colors.white10,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5.sp),
                          child: TabBar(
                            tabs: List<Tab>.generate(
                              lessonsController.getLessons().length,
                              (index) => Tab(
                                text: lessonsController
                                    .getLesson(index: index)
                                    .name,
                              ),
                            ),
                            isScrollable: true,
                            indicatorColor: Colors.transparent,
                            physics: const BouncingScrollPhysics(),
                            labelStyle: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            unselectedLabelStyle: TextStyle(fontSize: 18.sp),
                            overlayColor:
                                MaterialStateProperty.resolveWith((states) {
                              return Colors.transparent;
                            }),
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            physics: const BouncingScrollPhysics(),
                            children: List<Widget>.generate(
                              lessonsController.getLessons().length,
                              (index) => SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Padding(
                                  padding: EdgeInsets.all(10.sp),
                                  child: SizedBox(
                                    height: 500.sp,
                                    child: Container(
                                      color: Colors.white10,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  right: 18.sp, left: 18.sp, top: 10.sp),
                              child: Text(
                                "Canadian",
                                style: TextStyle(fontSize: 20.sp),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 18.sp),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Cerebration",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 7.sp),
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      onPressed: () => {},
                                      iconSize: 22.sp,
                                      icon: const Icon(
                                        Icons.shuffle,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Slider(
                                activeColor: Colors.white,
                                inactiveColor: Colors.white12,
                                value: 0.7,
                                min: 0.0,
                                max: 1.0,
                                onChanged: (double value) {
                                  //
                                }),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 18.sp),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "0:00",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  Text(
                                    "0:09",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    right: 18.sp,
                                    left: 18.sp,
                                    top: 5.sp,
                                    bottom: 5.sp),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () => {},
                                      iconSize: 22.sp,
                                      icon: const Icon(
                                        Icons.repeat,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => {},
                                      iconSize: 40.sp,
                                      icon: const Icon(
                                        Icons.skip_previous,
                                        color: Colors.white,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => {},
                                      iconSize: 40.sp,
                                      icon: const Icon(
                                        Icons.pause,
                                        color: Colors.white,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => {},
                                      iconSize: 40.sp,
                                      icon: const Icon(
                                        Icons.skip_next,
                                        color: Colors.white,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => {},
                                      iconSize: 22.sp,
                                      icon: const Icon(
                                        Icons.favorite_border,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ));
          } else {
            return Container(
              color: Colors.black,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
            );
          }
        });
  }
}
