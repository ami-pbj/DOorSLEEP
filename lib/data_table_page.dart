import 'package:do_or_sleep/edit_dialog_box.dart';
import 'package:do_or_sleep/to_do_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DataTablePage extends StatefulWidget {
  DataTablePage() : super();

  final String title = "DO || SLEEP";

  @override
  DataTablePageState createState() => DataTablePageState();
}

// by 🅟🅑🅙
class DataTablePageState extends State<DataTablePage> {
  late List<ToDoData> tododata;
  late List<ToDoData> selectedData;
  late bool sort;

  // Selectable Text
  String selectedText ="";

  final String _selectableText = "The Most Easiest Way to Organised in Order of Priority.";




  @override
  void initState() {
    sort = false;
    selectedData = [];
    tododata = ToDoData.getToDoData();
    super.initState();
  }

  onSortColum(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        tododata.sort((a, b) => a.title.compareTo(b.title));
      } else {
        tododata.sort((a, b) => b.title.compareTo(a.title));
      }
    }
  }

  onSelectedRow(bool selected, ToDoData data) async {
    setState(() {
      if (selected) {
        selectedData.add(data);
      } else {
        selectedData.remove(data);
      }
    });
  }

  deleteSelected() async {
    setState(() {
      if (selectedData.isNotEmpty) {
        List<ToDoData> temp = [];
        temp.addAll(selectedData);
        for (ToDoData data in temp) {
          tododata.remove(data);
          selectedData.remove(data);
        }
      }
    });
  }

  SingleChildScrollView dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        sortAscending: sort,
        sortColumnIndex: 0,
        columns: [
          DataColumn(
              label: Text("TITLE",
                style: GoogleFonts.lato(
                  color: const Color(0xff000000),
                  textStyle: Theme.of(context).textTheme.headlineLarge,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  // fontStyle: FontStyle.italic,
                  letterSpacing: 1.0,
                ),
              ),
              numeric: false,
              onSort: (columnIndex, ascending) {
                setState(() {
                  sort = !sort;
                });
                onSortColum(columnIndex, ascending);
              }),
          DataColumn(
            label: Text("DESCRIPTION",
              style: GoogleFonts.lato(
                color: const Color(0xff000000),
                textStyle: Theme.of(context).textTheme.headlineLarge,
                fontSize: 15,
                fontWeight: FontWeight.w800,
                // fontStyle: FontStyle.italic,
                letterSpacing: 1.0,
              ),
            ),
            numeric: false,
          ),
        ],
        rows: tododata
          .map(
            (data) => DataRow(
            selected: selectedData.contains(data),
            onSelectChanged: (b) {
              onSelectedRow(b!, data);
            },
            cells: [
              DataCell(
                Container(
                  width: 80,
                    child: Text(data.title,
                      style: GoogleFonts.lato(
                        color: const Color(0xff000000),
                        textStyle: Theme.of(context).textTheme.headlineLarge,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        // fontStyle: FontStyle.italic,
                        letterSpacing: 0.6,
                      ),
                    ),
                ),
                  showEditIcon: true,
                onTap: (){
                  // editDescription(data);
                  showTextDialog(context, title: "Edit Title", value: data.title);
                },
              ),
              DataCell(
                Container(
                  width: 170,
                    child: Text(data.description,
                      style: GoogleFonts.lato(
                        color: const Color(0xff000000),
                        textStyle: Theme.of(context).textTheme.headlineLarge,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        // fontStyle: FontStyle.italic,
                        letterSpacing: 0.6,
                      ),
                    ),
                ),
                  showEditIcon: true,
                  onTap: (){
                    // editDescription(data);
                    showTextDialog(context, title: "Edit Description", value: data.description);
                  },
              ),
            ]),
          )
            .toList(),
      ),
    );
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // App Bar
      appBar: AppBar(
        toolbarHeight: 50,
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.blueGrey,

        // ! means => to any variable tells
        // the compiler that the variable is not null
        // and can be used safely
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(54, 0, 0, 10),
              child: Text("DO ! SLEEP",
                textAlign: TextAlign.center,
                style: GoogleFonts.oswald(
                  color: const Color(0xfff7ff00),
                  textStyle: Theme.of(context).textTheme.headlineLarge,
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  // fontStyle: FontStyle.italic,
                  letterSpacing: 5.0,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              height: 40,
              width: 40,
              alignment: Alignment.centerRight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.asset('assets/images/me.png'),
              ),
            )
          ],
        ),

      ),



      backgroundColor: Color(0xfff4ecfc),
      // Body
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          verticalDirection: VerticalDirection.down,

          children: <Widget>[
            Container(
              color: Color(0xffb4cfdc),
              child: Column(
                children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),

                      child: Column(
                        children: [
                          // Text(
                          //   selectedText,
                          //   // style: (),
                          // ),
                          Center(
                              child: SelectableText(
                              _selectableText,
                                style: GoogleFonts.lato(
                                  color: const Color(0xff190294),
                                  textStyle: Theme.of(context).textTheme.headlineLarge,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                  // fontStyle: FontStyle.italic,
                                  letterSpacing: 1.0,
                                ),
                                onSelectionChanged: (selection, cause){
                                  setState(() {
                                    selectedText = _selectableText.substring(
                                      selection.start,
                                      selection.end,
                                    );
                                  });
                                },
                              )
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 20),

                      child: Center(
                          child: Text("Make a list of tasks you need to complete.",
                            style: GoogleFonts.lato(
                              color: Colors.black87,
                              textStyle: Theme.of(context).textTheme.headlineLarge,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              // fontStyle: FontStyle.italic,
                              letterSpacing: 1.0,
                            ),
                          )
                      ),
                    ),
                ],
              ),
            ),



            Expanded(
              child: dataBody(),
            ),
            Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),

                    child: Text(
                      selectedText,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.yellow,
                        backgroundColor: Color(0xff000000),
                      ),
                    ),
                  ),

                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 50, 20, 5),
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.deepPurple, width: 1),
                            ),
                            child: Text("SELECTED  ${selectedData.length}",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 50, 20, 5),

                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.deepPurple, width: 1),
                            ),
                            child: Text("REMOVE SELECTED",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            onPressed: selectedData.isEmpty
                                ? null
                                : () {
                              deleteSelected();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 40),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.black,
                        side: BorderSide(color: Colors.black, width: 5),
                      ),

                      onPressed: () {},

                      child: const Text("+ ADD Topics to TO-DO List",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.lightGreenAccent,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Drawer

      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Color(0xff3e4256),
          //other styles
        ),

        child: Drawer(
          elevation: 20.0,
          // backgroundColor: Color(0xFF032730),
          child: Column(

            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: const Text("21MCA2473"),
                accountEmail: const Text("PURNENDU BIKASH JANA"),

                decoration: const BoxDecoration(
                  color: Color(0xff4f798c),
                ),
                currentAccountPicture: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.transparent,
                  child: Image.asset('assets/images/me.png'),
                ),
              ),

              const ListTile(
                title: Text("Recently Added TO-DO", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white)),
                leading: Icon(Icons.add_circle_outline,color: Colors.white,),
              ),

              const Divider( height: 0.1, color: Color(0xffa9a9a9),),
              const ListTile(
                title: Text("Completed TO-DO", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white)),
                leading: Icon(Icons.remove_circle_outline,color: Colors.white,),
              ),

              const Divider( height: 0.1, color: Color(0xffa9a9a9),),
              const ListTile(
                title: Text("Your Profile", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white)),
                leading: Icon(Icons.account_circle_outlined,color: Colors.white,),
              ),

              const Divider( height: 0.1, color: Color(0xffa9a9a9),),
              ListTile(
                  title: const Text("Send Email", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white)),
                  leading: const Icon(Icons.contact_mail_outlined,color: Colors.white,),

              ),
              const Divider( height: 0.1, color: Color(0xffa9a9a9),),
              ListTile(
                title: const Text("Connect Me", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white)),
                leading: const Icon(Icons.people_outline, color: Colors.white,),
              ),
              const Divider( height: 0.1, color: Color(0xffa9a9a9),),
              ListTile(
                title: const Text("About Me", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white)),
                leading: const Icon(Icons.details_rounded, color: Colors.white,),
              ),
              const Divider( height: 0.1, color: Color(0xffa9a9a9),),
            ],
          ),
        ),
      ),
    );
  }

}