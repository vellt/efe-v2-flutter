import 'package:efe_v2_flutter/controllers/lessons_controller.dart';
import 'package:efe_v2_flutter/models/book.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class LessonsScreen extends StatelessWidget {
  LessonsScreen(Book book, {Key? key}) : super(key: key) {
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
    //final lessonsController= Get.lazyPut(() => LessonsController(book));
    return FutureBuilder(
        future: lessonsController.onInit(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return DefaultTabController(
                length: lessonsController.getLessons().length,
                initialIndex: lessonsController.indexOfSelectedLesson.value,
                child: Builder(builder: (context) {
                  final TabController tabContr =
                      DefaultTabController.of(context)!;
                  tabContr.animation!.addListener(() {
                    if (tabContr.index != tabContr.animation!.value.round()) {
                      lessonsController.indexOfSelectedLesson.value =
                          tabContr.animation!.value.round();
                      lessonsController.update();
                    }
                  });
                  return Scaffold(
                    resizeToAvoidBottomInset: false,
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
                            padding: EdgeInsets.only(left: 20.sp, right: 80.sp),
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
                            child: GetBuilder<LessonsController>(
                                init: lessonsController,
                                builder: (controller) {
                                  return Builder(builder: (context) {
                                    TextEditingController textContr =
                                        TextEditingController();
                                    textContr.text =
                                        controller.getLesson().codeName;

                                    return TextFormField(
                                      onFieldSubmitted: (value) {
                                        int? index = controller.getLessonID(
                                            code: textContr.text);
                                        if (index != null) {
                                          tabContr.index = index;
                                        } else {
                                          //todo: hiba uzenetet a felhasználónak!!!
                                        }
                                      },
                                      onTap: () {
                                        textContr.selection =
                                            TextSelection.fromPosition(
                                          TextPosition(
                                            offset: textContr.text.length,
                                          ),
                                        );
                                      },
                                      controller: textContr,
                                      style: TextStyle(
                                          fontSize: 16.sp, color: Colors.grey),
                                      textAlignVertical:
                                          TextAlignVertical.bottom,
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              signed: false, decimal: true),
                                      decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white10,
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide(
                                                  color: Colors.blue,
                                                  width: 1.5.sp)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          contentPadding: EdgeInsets.only(
                                            left: 15.sp,
                                            right: 10.sp,
                                            top: 14.sp,
                                            bottom: 12.sp,
                                          ),
                                          suffixIcon: const Icon(Icons.search,
                                              color: Colors.grey)),
                                    );
                                  });
                                }),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5.sp),
                            child: TabBar(
                              controller: tabContr,
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
                                controller: tabContr,
                                physics: const BouncingScrollPhysics(),
                                children: List<Widget>.generate(
                                  tabContr.length,
                                  (index) => SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Padding(
                                      padding: EdgeInsets.all(10.sp),
                                      child: SizedBox(
                                        height: 500.sp,
                                        child: Container(
                                          color: Colors.white10,
                                          child: Text(
                                              "${lessonsController.getLesson(index: index).codeName}"),
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
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
                                padding:
                                    EdgeInsets.symmetric(horizontal: 18.sp),
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
                                padding:
                                    EdgeInsets.symmetric(horizontal: 18.sp),
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
                  );
                }));
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
