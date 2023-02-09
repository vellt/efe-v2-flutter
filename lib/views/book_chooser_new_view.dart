import 'package:efe_v2_flutter/controllers/books_controller.dart';
import 'package:efe_v2_flutter/views/book_details_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BookChooserView extends StatelessWidget {
  BookChooserView({Key? key}) : super(key: key);
  BooksController contr = Get.put(BooksController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: contr.onInit(),
        builder: (context, snapshot) {
          return Scaffold(
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
                                ],
                              ),
                              Row(
                                children: [
                                  CupertinoButton(
                                    minSize: double.minPositive,
                                    padding: EdgeInsets.zero,
                                    child: const Icon(
                                      Icons.supervised_user_circle,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {},
                                  ),
                                  SizedBox(
                                    width: 10.sp,
                                  ),
                                  CupertinoButton(
                                    minSize: double.minPositive,
                                    padding: EdgeInsets.zero,
                                    child: const Icon(
                                      Icons.light_mode,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {},
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 13.sp),
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
                          Expanded(
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemCount: contr.getBooks().length,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      SizedBox(height: 7.sp),
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  height: 45.sp,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFF8F8F8),
                                      borderRadius:
                                          BorderRadius.circular(8.sp)),
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.black,
                                    ),
                                    onPressed: () =>
                                        contr.indexOfSelectedBook.value = index,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.sp),
                                      child: Row(
                                        children: [
                                          Text(
                                              contr.getBook(index: index).name),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
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
