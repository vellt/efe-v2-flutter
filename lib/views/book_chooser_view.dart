import 'package:efe_v2_flutter/views/book_chooser/book_chooser_controller.dart';
import 'package:efe_v2_flutter/views/book_details_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BookScreen extends StatelessWidget {
  BookScreen({Key? key}) : super(key: key);
  BookChooserController contr = Get.put(BookChooserController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: contr.onInit(),
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(70.sp),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.sp),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "English For Everyone",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 6.sp),
                        Text(
                          "Choose a book",
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        SizedBox(height: 20.sp),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: (snapshot.connectionState == ConnectionState.done)
                ? ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: contr.getBooks().length,
                    separatorBuilder: (BuildContext context, int index) =>
                        Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.sp),
                      child: Divider(height: 1.sp),
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return TextButton(
                        style:
                            TextButton.styleFrom(foregroundColor: Colors.grey),
                        onPressed: () => contr.selectBook(index),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.sp, vertical: 1.sp),
                          child: Obx(
                            () => ListTile(
                              title: Text(contr.getBook(index: index).name,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color:
                                          (contr.indexOfSelectedBook == index)
                                              ? Colors.white
                                              : Colors.white30)),
                              trailing: (contr.indexOfSelectedBook == index)
                                  ? Icon(Icons.check,
                                      color: Colors.white, size: 18.sp)
                                  : null,
                            ),
                          ),
                        ),
                      );
                    },
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
