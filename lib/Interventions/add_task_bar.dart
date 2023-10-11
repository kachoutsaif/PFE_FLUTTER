import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:learn/Interventions/button.dart';
import 'package:learn/Interventions/input_field.dart';
import 'package:learn/Interventions/modoles/task.dart';
import 'package:learn/Interventions/modoles/task_controller.dart';
import 'package:learn/Interventions/theme.dart';

class AddTaskPage extends StatefulWidget {
 const AddTaskPage({ Key? key }) : super(key: key);
 @override
 _AddTaskPageState createState() => _AddTaskPageState();
 
}

 class _AddTaskPageState extends State<AddTaskPage> {
   final TaskController _taskController = Get.put(TaskController());
   final TextEditingController _titleController = TextEditingController();
   final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _endTime = "4:30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
   int _selectedRemind= 5;
   List<int> remindList = [
    5,
    10,
    15,
    20,
  ];

   String _selectedRepeat = "None";
   List<String> repeatList = [
    "None",
    "Daily",
    "Weekly ",
    "Montly",
  ];
 int _selectedColor = 0;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.only(left: 20,right: 20 ),
        child: SingleChildScrollView(
          child : Column(
            children:  [
              Text(
                " Add Event",
                style: headingStyle,
                ),
                MyInputField(title: 'Title', hint: "Enter your Title",controller: _titleController,),
                MyInputField(title: 'Note', hint: "Enter your note",controller: _noteController,),  
                MyInputField(title: 'Date', hint: DateFormat.yMd().format(_selectedDate),
               widget: IconButton(
                icon: const Icon(Icons.calendar_today_outlined),
                color: Colors.grey,
                 onPressed: () { 
                  _getDateFromUser();
                  },),),
               Row(
                children: [
                  Expanded(
                    child: MyInputField(
                      title: "Start Date",
                       hint: _startTime,
                       widget: IconButton(
                        onPressed: (){
                          _getTimeFromUser(isStarTime: true);
                        },
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        )
                       ),
                       ), 
                  ),
                  const SizedBox(width: 12,),
                  Expanded(
                    child: MyInputField(
                      title: "End Date",
                       hint: _endTime,
                       widget: IconButton(
                        onPressed: (){
                          _getTimeFromUser(isStarTime: false);
                        },
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        )
                       ),
                       ), 
                  ),
                ],
              ),
               MyInputField(
                title: 'Remind', 
                hint: "$_selectedRemind minutes early ",
                widget: DropdownButton(
                  icon:const Icon(Icons.keyboard_arrow_down,
                  color:Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: subtitleStyle,
                  underline: Container(height: 0,),
                  onChanged : (String? newValue) {
                    setState(() {
                      _selectedRemind= int .parse(newValue!);
                    });
                  },
                  items: remindList.map<DropdownMenuItem<String>>((int value){
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(value.toString()),
                    );
                  }
                  ).toList(), 
                ),
               ),
               MyInputField(
                  title: 'Repeat', 
                  hint: "$_selectedRepeat minutes early ",
                widget: DropdownButton(
                  icon:const Icon(Icons.keyboard_arrow_down,
                  color:Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: subtitleStyle,
                  underline: Container(height: 0,),
                  onChanged : (String? newValue) {
                    setState(() {
                      _selectedRepeat= newValue!;
                    });
                  },
                  items: repeatList.map<DropdownMenuItem<String>>((String? value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value!,style: const TextStyle(color: Colors.grey)),
                    );
                  }
                  ).toList(), 
                ),
               ),
               const SizedBox(height: 18,),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 _colorPallete(),
                 MyButtonTask(
                  onTap: (){
                    _vlidateDate();
                  },
                  label: "Create Event",)
            ],
            )
            ],
        ),
       ),
      ),
    );
  }

  _vlidateDate(){
    if(_titleController.text.isNotEmpty &&_noteController.text.isNotEmpty){
      _addTaskToDb();
      Get.back();
    }else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar("Required", "All fields are required !",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        icon: const Icon(Icons.warning_amber_rounded)
      );
    }
    }

_addTaskToDb() async {
 int value = await _taskController.addTask(
    task:Task(
    note: _noteController.text,
    title: _titleController.text,
    date: DateFormat.yMd().format(_selectedDate),
    startTime: _startTime,
    endTime: _endTime,
    remind: _selectedRemind,
    repeat: _selectedRepeat,
    color: _selectedColor,
    isCompleted: 0
  ),
  );
  print("My id is "+"$value");
}


_colorPallete (){
  return  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Color",
                      style: titleStyle,
                      ),
                      const SizedBox(height: 8.0,),
                      Wrap( 
                        children: List<Widget>.generate(3,
                         (int index)  {
                          return   GestureDetector(
                            onTap: (){
                             setState(() {
                                _selectedColor=index;
                             });
                            },
                            child: Padding(
                              padding:  const EdgeInsets.only(right :8.0),
                              child: CircleAvatar(
                                radius: 14,
                                backgroundColor: index==0 ? primaryClr :index==1?pinkClr:yellowClr,
                                child: _selectedColor==index?const Icon(Icons.done,
                                color: Colors.white,
                                size: 16,
                                ):Container(),

                              ),
                            ),
                          );  
                         })
                  )
                ],
  );
}

_appBar(BuildContext context) {
  return  AppBar(
    elevation: 0,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon( Icons.arrow_back,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        actions: const [
          CircleAvatar(
            backgroundColor:Color(0xFFFF) ,
          ),
          SizedBox(height: 20,),
        ],
      );
 }
 
 _getDateFromUser() async{
  DateTime? pickerDate =await showDatePicker(
    context: context  ,
     initialDate: DateTime.now(), 
    firstDate: DateTime(2015), 
    lastDate: DateTime(2121)
    );

    if (pickerDate != null) {
      setState(() {
        _selectedDate = pickerDate;
      });
    }else {
      print("it's null or somthing is wrong");
    }
 }

 _getTimeFromUser({required bool isStarTime}) async {
   var pickedTime = await _showTimePiker();
   String formatedTime = pickedTime.format(context);
   if (pickedTime == null){
      print("Time canceled");
   }else if(isStarTime == true){
      setState(() {
        _startTime=formatedTime;
      });
   }else if (isStarTime == false){
     setState(() {
        _endTime=formatedTime;
     });
   }
 }


 _showTimePiker() {
  return  showTimePicker(
    initialEntryMode: TimePickerEntryMode.input,
    context: context, 
    initialTime: TimeOfDay(
      hour: int.parse(_startTime.split(":")[0]), 
      minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
      )
    );
 }
 }
 