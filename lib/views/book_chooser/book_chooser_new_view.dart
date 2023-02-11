import 'package:efe_v2_flutter/views/book_chooser/book_chooser_controller.dart';
import 'package:efe_v2_flutter/views/book_details_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';

class BookChooserView extends StatelessWidget {
  BookChooserView({Key? key}) : super(key: key);
  BookChooserController contr = Get.put(BookChooserController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: contr.onInit(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: AppBar(
                //backgroundColor: Colors.white,
                elevation: 0,
              ),
            ),
            backgroundColor: Colors.white,
            body: (snapshot.connectionState == ConnectionState.done)
                ? SafeArea(
                    child: Padding(
                      padding: EdgeInsets.all(16.sp),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "English 4 Everyone",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 21.sp,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  SizedBox(height: 7.sp),
                                  Text(
                                    "Choose a book",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontSize: 18.sp),
                                  ),
                                  SizedBox(height: 7.sp),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 30.sp,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.supervised_user_circle,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30.sp,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.light_mode,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 5.sp),
                          Container(
                            padding: EdgeInsets.only(right: 15.sp),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Color(0xFFF8F8F8),
                                borderRadius: BorderRadius.circular(8.sp)),
                            child: const TextField(
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  hintText: "Search",
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.black,
                                  ),
                                  border: InputBorder.none,
                                  //focusedBorder: myfocusborder(),
                                )),
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          Divider(
                            color: Color(0xFFF3F3F3),
                            height: 2.sp,
                          ),
                          GetBuilder<BookChooserController>(
                              init: contr,
                              builder: (_) {
                                return Expanded(
                                  child: ListView.separated(
                                    padding: EdgeInsets.only(
                                        bottom: 50.sp, top: 10.sp),
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: _.getBooks().length,
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            SizedBox(height: 7.sp),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        height: 38.sp,
                                        decoration: BoxDecoration(
                                            color: Color(0xFFF8F8F8),
                                            borderRadius:
                                                BorderRadius.circular(8.sp)),
                                        child: TextButton(
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.black,
                                            padding: EdgeInsets.zero,
                                          ),
                                          onPressed: () => _.selectBook(index),
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 15.sp, right: 3.sp),
                                            child: Row(
                                              children: [
                                                (_.indexOfSelectedBook == index)
                                                    ? Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 12.sp),
                                                        child: Container(
                                                          height: 5.sp,
                                                          width: 5.sp,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.blue,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50.sp)),
                                                        ),
                                                      )
                                                    : Container(),
                                                Expanded(
                                                  child: Text(
                                                    _
                                                        .getBook(index: index)
                                                        .name,
                                                    style: TextStyle(
                                                        color:
                                                            (_.indexOfSelectedBook ==
                                                                    index)
                                                                ? Colors.black
                                                                : Color(
                                                                    0xFF2C2C2C),
                                                        fontWeight:
                                                            (_.indexOfSelectedBook ==
                                                                    index)
                                                                ? FontWeight
                                                                    .w500
                                                                : FontWeight
                                                                    .normal),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 38.sp,
                                                  child: Listener(
                                                    onPointerDown: (details) {
                                                      _.changeTappedValue(
                                                          true, index);
                                                    },
                                                    onPointerUp: (details) {
                                                      _.changeTappedValue(
                                                          false, index);
                                                    },
                                                    child: IconButton(
                                                      onPressed: () {
                                                        _.downloadBook(index);
                                                      },
                                                      icon: Icon(
                                                        Icons.download,
                                                        color: (_.isTapped &&
                                                                _.indexOfTappedIcon ==
                                                                    index)
                                                            ? Colors.blue
                                                            : Colors.grey[300],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  ),
            floatingActionButton:
                (snapshot.connectionState == ConnectionState.done)
                    ? FloatingActionButton(
                        backgroundColor: Colors.blue,
                        child: const Icon(
                          CupertinoIcons.chevron_forward,
                          color: Colors.white,
                        ),
                        onPressed: () => Get.to(
                            () => LessonsScreen(contr.getBook()),
                            transition: Transition.cupertino),
                      )
                    : null,
          );
        });
  }
}

// todo: megcsinálni, mikor nincs internetkapcsolat
// vlmi kifinomultabb megoldás kell amivel ellernőrzöm ha nem jött le adat
// akk a floating button egy refresh-ként működjön, és kapjon hibaüzenetet
// a felhasználó, vlmiért az emulátor nem engedi kikapcsolni a wifi-t :(
