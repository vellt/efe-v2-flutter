import 'package:efe_v2_flutter/controllers/lessons_controller.dart';
import 'package:efe_v2_flutter/controllers/tab_state_controller.dart';
import 'package:efe_v2_flutter/models/book.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:text_scroll/text_scroll.dart';

class LessonsScreen extends StatelessWidget {
  LessonsScreen(Book book, {Key? key}) : super(key: key) {
    // first of all we insert the data of the current book into the lesson Controller inside the constructor
    lessonsController = Get.put(LessonsController(Book(
      id: book.id,
      name: book.name,
      route: book.route,
    )));
  }

  late LessonsController lessonsController;
  TabStateController tabStateController = Get.put(TabStateController());

  @override
  Widget build(BuildContext context) {
    TextEditingController textContr = TextEditingController();
    return FutureBuilder(
        future: lessonsController.onInit(),
        builder: (context, snapshot1) {
          if (snapshot1.connectionState == ConnectionState.done) {
            return DefaultTabController(
              length: lessonsController.getLessons().length,
              initialIndex: lessonsController.indexOfSelectedLesson.value,
              child: Builder(builder: (context) {
                var _ = DefaultTabController.of(context);
                _?.animation!.addListener(() {
                  int temp = _.animation!.value.round();
                  if (tabStateController.index != temp) {
                    tabStateController.change(newValue: temp);
                    print(temp);
                    print(lessonsController.getLesson(index: temp).codeName);
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
                          padding: EdgeInsets.only(
                              left: 20.sp, right: 80.sp, bottom: 4.sp),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              lessonsController.getBook().name,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        GetBuilder<TabStateController>(
                            init: tabStateController,
                            builder: (_) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 14.sp, vertical: 10.sp),
                                child: Builder(builder: (context) {
                                  textContr.text = lessonsController
                                      .getLesson(index: _.index)
                                      .codeName;
                                  return TextField(
                                    onEditingComplete: () {
                                      int? index = lessonsController
                                          .getLessonID(code: textContr.text);
                                      if (index != null) {
                                        //tabContr.index = index;
                                        // todo: NAVIGATION TO ANOTHER SIDE! BECAUSE OF JUPMING!!!!
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
                                    textAlignVertical: TextAlignVertical.bottom,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            signed: false, decimal: true),
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white10,
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: BorderSide(
                                                color: Colors.blue,
                                                width: 1.5.sp)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        contentPadding: EdgeInsets.only(
                                          left: 20.sp,
                                          right: 20.sp,
                                          top: 12.sp,
                                          bottom: 10.sp,
                                        ),
                                        suffixIcon: Padding(
                                          padding:
                                              EdgeInsets.only(right: 13.sp),
                                          child: const Icon(Icons.search,
                                              color: Colors.grey),
                                        )),
                                  );
                                }),
                              );
                            }),
                        Padding(
                          padding: EdgeInsets.only(left: 5.sp),
                          child: TabBar(
                            tabs: List.generate(
                              lessonsController.getLessons().length,
                              (index) => Tab(
                                text: lessonsController
                                    .getLesson(index: index)
                                    .name,
                              ),
                            ),
                            onTap: (value) {
                              if (tabStateController.index != value) {
                                tabStateController.change(newValue: value);
                              }
                              textContr.text =
                                  lessonsController.getLesson().codeName;
                            },
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
                              clipBehavior: Clip.hardEdge,
                              physics: const BouncingScrollPhysics(),
                              children: List.generate(
                                lessonsController.getLessons().length,
                                (index) => Padding(
                                  padding: EdgeInsets.all(10.sp),
                                  child: ListView(
                                    physics: const BouncingScrollPhysics(),
                                    primary: true,
                                    shrinkWrap: true,
                                    children: [
                                      Builder(builder: (context) {
                                        var audios =
                                            lessonsController.getAudios(
                                          lesson: lessonsController.getLesson(
                                            index: index,
                                          ),
                                        );
                                        return (audios.isEmpty)
                                            ? IconButton(
                                                icon: const Icon(
                                                  Icons.texture,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () {
                                                  print(
                                                      "index: ${tabStateController.index} is audio empty: ${audios.isEmpty}");
                                                },
                                              )
                                            : Wrap(
                                                spacing: 8.sp,
                                                runSpacing: 3.sp,
                                                children: List.generate(
                                                    audios.length, (int index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      print(
                                                          "index: ${tabStateController.index} is audio empty: ${audios.isEmpty}");
                                                    },
                                                    child: Chip(
                                                      backgroundColor: (index ==
                                                              lessonsController
                                                                  .indexOfSelectedAudio
                                                                  .value)
                                                          ? Colors.blue
                                                          : Colors.black45,
                                                      label: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 5.sp,
                                                                bottom: 5.sp,
                                                                right: 5.sp,
                                                                left: 5.sp),
                                                        child: TextScroll(
                                                          audios[index].name,
                                                          mode: TextScrollMode
                                                              .endless,
                                                          velocity: Velocity(
                                                              pixelsPerSecond:
                                                                  Offset(
                                                                      30, 0)),
                                                          pauseBetween:
                                                              Duration(
                                                                  milliseconds:
                                                                      3500),
                                                          style: TextStyle(
                                                              fontSize: 14.sp,
                                                              color: (index ==
                                                                      lessonsController
                                                                          .indexOfSelectedAudio
                                                                          .value)
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .grey),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                              );
                                      }),
                                    ],
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
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
            );
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
