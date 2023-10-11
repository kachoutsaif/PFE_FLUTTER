import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn/Interventions/add_task_bar.dart';
import 'package:learn/Interventions/button.dart';
import 'package:learn/Interventions/modoles/task_controller.dart';
import 'package:learn/Interventions/modoles/task_tile.dart';
import 'package:learn/Interventions/notification_sevices.dart';
import 'package:learn/Interventions/theme.dart';
import 'package:learn/Interventions/theme_sevices.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'modoles/task.dart';


 class Planning extends StatefulWidget {
  const Planning({super.key});

     
   @override
     _PlanningState createState() => _PlanningState(); 
   }
 class _PlanningState extends State<Planning> {
    
     DateTime _selectedDate = DateTime.now() ;
     final _taskController = Get.put(TaskController());
     var notifyHelper;

  @override
  void initState(){
    super.initState();
    notifyHelper=NotifyHelper();
    notifyHelper.initializeNotification();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: context.theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          _addTaskBar(),
          _addDateBar(),
          const SizedBox(height: 10,),
          _showTasks(),
          Container(
            margin: const EdgeInsets.only(top: 20,left: 20),
            child: DatePicker(
              DateTime.now(),
              height: 100,
              width: 80,
              initialSelectedDate: DateTime.now(),
              selectionColor: primaryClr,
              selectedTextColor: Colors.white,
              dateTextStyle: GoogleFonts.lato(
                textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
              ),
              dayTextStyle: GoogleFonts.lato(
                textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
              ),
              monthTextStyle: GoogleFonts.lato(
                textStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
              ),
              onDateChange: (date){
                    _selectedDate=date;
              },
            ),
          )
      ]),
    );
  }

  _showTasks(){
    return Expanded(
      child: Obx((){
        return ListView.builder(
          itemCount: _taskController.taskList.length,
          itemBuilder: (_ ,  index) {
            print(_taskController.taskList.length);
            Task task = _taskController.taskList[index];
            if(task.repeat == 'Daily') {
              DateTime date = DateFormat.jm().parse(task.startTime.toString());
              var myTime = DateFormat("HH:mm").format(date);
               //notifyHelper.scheduledNotification(
                //int.parse(myTime.toString().split(":")[0]),
                //int.parse(myTime.toString().split(":")[1]),
                //task
              //);
              return AnimationConfiguration.staggeredList(
              position:index,
              child : SlideAnimation(
                child: FadeInAnimation(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          __showBottomSheet(context,task);
                        },
                        child: TaskTile(task),
                      ),
                    ]) ,)
                )
                );
            }
            if(task.date == DateFormat.yMd().format(_selectedDate)){
              return AnimationConfiguration.staggeredList(
              position:index,
              child : SlideAnimation(
                child: FadeInAnimation(
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          __showBottomSheet(context,task);
                        },
                        child: TaskTile(task),
                      ),
                    ]) ,)
                )
                );
            }else {
              return Container();

            }
          }
        );
      }),
      );
  }


 __showBottomSheet (BuildContext context, Task task){
   Get.bottomSheet(
    Container(
      padding: const EdgeInsets.only(top: 4),
      height: task.isCompleted==1?
      MediaQuery.of(context).size.height*0.24:
      MediaQuery.of(context).size.height*0.32,
      color: Get.isDarkMode?darkGreyClr:Colors.white,
      child: Column(
        children: [
          Container(
            height: 4,
            width: 120 ,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Get.isDarkMode?Colors.grey[600]:Colors.grey[300]
            ),
          ),
          const Spacer(),
          task.isCompleted==1
          ?Container()
            : _bottomSheetButton(
              label: "Event Completed", 
              onTap: (){
                _taskController.markTaskCompleted(task.id!);
                Get.back();
              }, 
              clr:primaryClr,
              context:context
              ),
              const SizedBox(height: 20,),
              _bottomSheetButton(
              label: "Delete Event", 
              onTap: (){
                _taskController.delete(task);
                Get.back();
              }, 
              clr:Colors.red[300]!,
              context:context
              ),
              const SizedBox(height: 20,),
               _bottomSheetButton(
              label: "Close", 
              onTap: (){
                Get.back();
              }, 
              clr:Colors.red[300]!,
              isClose:true,
              context:context
              ),
              const SizedBox(height: 10,)
        ],
      ),
    )
   );

 }

 _bottomSheetButton({
  required String label,
  required Function()? onTap,
  required Color clr,
  bool isClose = false,
  required BuildContext context,
 }) {
        return GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            height: 55,
            width: MediaQuery.of(context).size.width*0.9,
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: isClose==true?Get.isDarkMode?Colors.grey[600]!:Colors.grey[300]!:clr,
              ),
              borderRadius: BorderRadius.circular(20),
                color:  isClose==true?Colors.transparent:clr,
            ),

            child: Center(
              child: Text(
                label,
                style: isClose?titleStyle:titleStyle.copyWith(color: Colors.white),
              ),
            ),
          ),
        );
 }

  _addDateBar(){
    return  Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.grey
          )
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey
          )
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey
          )
        ),
        onDateChange: (date){
          setState(() {
            _selectedDate=date;
          });
        },
        ),
      );
  }

_addTaskBar(){
  return Container(
            margin: const EdgeInsets.only(left: 20 , right: 20 , top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DateFormat.yMMMEd().format(DateTime.now()),
                    style : subHeadingStyle,
                    ),
                    Text("Today",
                    style: headingStyle,
                    ),
                  ],
                ),
                MyButtonTask(onTap: () async {
                 await  Get.to(const AddTaskPage());
                 _taskController.getTasks();
                  },
                  label:"+ Add Event")
              ],
            ),
          ); 
}
_appBar() {
  return  AppBar(
    elevation: 0,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        leading: GestureDetector(
          onTap: () {
            ThemeService().switchTheme();
            NotifyHelper().displayNotification(
              title: "Theme Changed",
              body: Get.isDarkMode?"Activated Light Theme":"Activated Dark Theme"
            );
           //notifyHelper().scheduledNotification();
          },
          child: Icon( Get.isDarkMode ?Icons.wb_sunny_outlined :Icons.nightlight_round ,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        actions:  const [
          CircleAvatar(
            backgroundImage:AssetImage(
              "lib/images/profile.png"
            ),
          ),
          SizedBox(height: 20,),
        ],
      );
 }
 }