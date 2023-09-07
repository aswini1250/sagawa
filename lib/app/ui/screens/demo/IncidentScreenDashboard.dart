import 'dart:convert';
import 'dart:io';

import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:open_filex/open_filex.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sofproject/app/ui/widgets/common_button.dart';
import 'package:sofproject/app/ui/widgets/popup_loading.dart';

import '../../../config/app_config.dart';
import '../../../controllers/incident_controller.dart';
import '../../../services/FCM_service.dart';
import '../../themes/MyColors.dart';
import '../../widgets/commonTextManpowerField.dart';
import '../../widgets/common_searchable_dropdown/MainCommonSearchableDropDown.dart';
import '../../widgets/progress_loading.dart';
import '../Error/incidentDashboardMyForm.dart';
import '../inicident_dashboardForms.dart';
import 'incident_view_form_screen.dart';
import 'package:path_provider/path_provider.dart';

import 'package:cr_file_saver/file_saver.dart';
//TODO Support server side filter in example
//First update server side to include a filter
//Add search bar
//Update remote data source to use filter

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class IncidentScreenDashboard extends StatefulWidget {
  const IncidentScreenDashboard({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  _IncidentScreenDashboardState createState() =>
      _IncidentScreenDashboardState();
}

class _IncidentScreenDashboardState extends State<IncidentScreenDashboard> {
  var _rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage;
  var _sortIndex = 0;
  var _sortAsc = true;
  final _searchController = TextEditingController();
  var _customFooter = false;
  String user_type="1";
  init()async{

    SharedPreferences aswiniPrefs=await SharedPreferences.getInstance();
  String  type=aswiniPrefs.getString("user_type")??"1";
   setState(() {
     user_type=type;
     debugPrint("uytugfhfbsjdbjfugre*************${user_type}");
   });



  }
  @override
  void initState() {
    super.initState();
    init();

    _searchController.text = '';
    IncidentController.to.getDashboard();
    IncidentController.to.geReportByList();
    IncidentController.to.getPreparedByList();
  }
  Future<String> showLoginPage() async {
    var sharedPreferences = await SharedPreferences.getInstance();

    // sharedPreferences.setString('user', 'hasuser');

    String? user = sharedPreferences.getString('user_type');

    return user??"nil";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: new Text('Vehicle Incident'),
        elevation: 0.0,
      ),
      body: _buildButton(context),
    );
  }

  Widget _buildButton(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                child: new Container(
                    width: Get.width,
                    child: _buildSearchBox()),
              ),
              Obx(() => IncidentController.to.viewDropdown == true
                    ? Wrap(
                        children: [
                          Obx(
                            () => IncidentController.to.reportByLoading == true
                                ? Container(
                                    height: 60,
                                    width: 60,
                                    child: ProgressLoading())
                                : Container(
                                    width: Get.width ,
                                    child: MainSearchableDropDown(
                                      title: 'incident_id',
                                      items: IncidentController.to.reportByList,
                                      label: 'Report No'.tr,
                                      isRequired: true,
                                      controller:
                                          IncidentController.to.reportby,
                                      onChanged: (data) {
                                        IncidentController.to.reportCont =
                                            data['incident_id'];
                                        IncidentController.to.getDashboard();
                                      },
                                      cb: () {},
                                    ),
                                  ),
                          ),
                          Container(
                            width: Get.width ,
                            child: CommonTextFormManPowerField(
                              controller: IncidentController.to.subject,
                              lableText: "Subject Title",
                              hintText: "Enter Subject title",
                              onChanged: (data) {
                                IncidentController.to.subjectCont =
                                    IncidentController.to.subject.text;
                                IncidentController.to.getDashboard();
                              },
                              validator: (data) {},
                            ),
                          ),
                          Obx(
                            () => IncidentController.to.preparadByLoading ==
                                    true
                                ? Container(
                                    height: 60,
                                    width: 60,
                                    child: ProgressLoading())
                                : Container(
                                    width: Get.width ,
                                    child: MainSearchableDropDown(
                                      title: 'full_name',
                                      items: IncidentController.to.preparadBy,
                                      label: 'Praparated By'.tr,
                                      isRequired: true,
                                      controller:
                                          IncidentController.to.preparedby,
                                      onChanged: (data) {
                                        IncidentController.to.preparadCont =
                                            data['id'];
                                        IncidentController.to.getDashboard();
                                      },
                                      cb: () {},
                                    ),
                                  ),
                          ),
                          Obx(
                            () => IncidentController.to.statusLoading == true
                                ? Container(
                                    height: 60,
                                    width: 60,
                                    child: ProgressLoading())
                                : Container(
                                    width: Get.width ,
                                    child: MainSearchableDropDown(
                                      title: 'status',
                                      items: [
                                        {
                                          "id": "1",
                                          "status": "Manager-Pending",
                                        },
                                        {
                                          "id": "2",
                                          "status": "Completed",
                                        },
                                        {
                                          "id": "3",
                                          "status": "Rejected",
                                        },
                                      ],
                                      label: 'Status'.tr,
                                      isRequired: true,
                                      controller: IncidentController.to.status,
                                      onChanged: (data) {
                                        IncidentController.to.statusCont =
                                            data['id'];
                                        IncidentController.to.getDashboard();
                                      },
                                      cb: () {},
                                    ),
                                  ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: ()async{
                                    await IncidentController.to.clearFilter();
                                    await IncidentController.to.clearFilterVariable();
                                    IncidentController.to.getDashboard();
                                  },
                                  child: Container(
                                    decoration: commonButtonDecoration(),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 7),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.clear,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 10,),
                                          Text("Clear",
                                            style: TextStyle(
                                                color: Colors.white
                                            ),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      )
                    : SizedBox(),
              ),
              new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[


                FutureBuilder<String>(
                  future: showLoginPage(),
                  builder: (buildContext, snapshot) {
                    if(snapshot.hasData) {
                      if(snapshot.data!=null){
                        // Return your login here
                       if(snapshot.data=="nil"){
                         return SizedBox();
                       }else{
                         if(snapshot.data=="1"){
                           return           Padding(
                             padding: const EdgeInsets.all(10.0),
                             child: InkWell(
                               onTap: ()async{
                                 IncidentController.to.clearFormField();
                                 IncidentController.to.selectedFiles=<File>[];
                                 Get.to(() =>
                                 //  MyApp()
                                 IncidentDashboardMyForms());
                               },
                               child: Container(
                                 decoration: commonButtonDecoration(),
                                 child: Padding(
                                   padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 7),
                                   child: Row(
                                     // Replace with a Row for horizontal icon + text
                                     children: <Widget>[
                                       Icon(
                                         Icons.add,
                                         color: Colors.white,
                                       ),
                                       Text("Add", style: TextStyle(color: Colors.white))
                                     ],
                                   ),
                                 ),
                               ),
                             ),
                           );
                         }
                       }
                      }
                      // Return your home here
                      return SizedBox();
                    } else {

                      // Return loading screen while reading preferences
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                )


              ]),
              Obx(
                () => IncidentController.to.dashboardLoading == true
                    ? ProgressLoading()
                    : dataTableFormat(context),
              )
            ],
          ),
        ],
      ),
    );
  }


  AdvancedPaginatedDataTable dataTableFormat(BuildContext context) {
    return AdvancedPaginatedDataTable(
      addEmptyRows: false,

      source: CommonSourceForTable(
          list: IncidentController.to.incidentDashboardList,
          columnNames: [
            'incident_id',
            'subject',
            'date_and_time',
            'full_name',
            'incident_status',
          ], user_type: '$user_type'),
      showHorizontalScrollbarAlways: true,
      sortAscending: _sortAsc,

      sortColumnIndex: _sortIndex,
      showFirstLastButtons: true,
      rowsPerPage: _rowsPerPage,
      availableRowsPerPage: const [10, 20, 30, 50],
      onRowsPerPageChanged: (newRowsPerPage) {
        if (newRowsPerPage != null) {
          setState(() {
            _rowsPerPage = newRowsPerPage;
          });
        }
      },
      columns: [
        DataColumn(
          label: const Text('Incident Id'),

          // numeric: true,
          onSort: setSort,
        ),
        DataColumn(
          label: const Text('Subject'),
          onSort: setSort,
        ),
        DataColumn(
          label: const Text('Date and Time'),
          onSort: setSort,
        ),
        DataColumn(
          label: const Text('Preparated By'),
          onSort: setSort,
        ),
        DataColumn(
          label: const Text('Status'),
          onSort: setSort,
        ),
        DataColumn(
          label: const Text('Actions'),
          onSort: setSort,
        ),
        DataColumn(
          label: const Text(''),
          onSort: setSort,
        ),
      ],
      //Optianl override to support custom data row text / translation
      getFooterRowText:
          (startRow, pageSize, totalFilter, totalRowsWithoutFilter) {
        final localizations = MaterialLocalizations.of(context);
        var amountText = localizations.pageRowsInfoTitle(
          startRow,
          pageSize,
          totalFilter ?? totalRowsWithoutFilter,
          false,
        );

        if (totalFilter != null) {
          //Filtered data source show addtional information
          amountText += ' filtered from ($totalRowsWithoutFilter)';
        }

        return amountText;
      },
      customTableFooter: _customFooter
          ? (source, offset) {
              const maxPagesToShow = 6;
              const maxPagesBeforeCurrent = 3;
              final lastRequestDetails = source.lastDetails!;
              final rowsForPager = lastRequestDetails.filteredRows ??
                  lastRequestDetails.totalRows;
              final totalPages = rowsForPager ~/ _rowsPerPage;
              final currentPage = (offset ~/ _rowsPerPage) + 1;
              final List<int> pageList = [];
              if (currentPage > 1) {
                pageList.addAll(
                  List.generate(currentPage - 1, (index) => index + 1),
                );
                //Keep up to 3 pages before current in the list
                pageList.removeWhere(
                  (element) => element < currentPage - maxPagesBeforeCurrent,
                );
              }
              pageList.add(currentPage);
              //Add reminding pages after current to the list
              pageList.addAll(
                List.generate(
                  maxPagesToShow - (pageList.length - 1),
                  (index) => (currentPage + 1) + index,
                ),
              );
              pageList.removeWhere((element) => element > totalPages);

              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: pageList
                    .map(
                      (e) => TextButton(
                        onPressed: e != currentPage
                            ? () {
                                //Start index is zero based
                                source.setNextView(
                                  startIndex: (e - 1) * _rowsPerPage,
                                );
                              }
                            : null,
                        child: Text(
                          e.toString(),
                        ),
                      ),
                    )
                    .toList(),
              );
            }
          : null,
    );
  }

  // ignore: avoid_positional_boolean_parameters
  void setSort(int i, bool asc) => setState(() {
        _sortIndex = i;
        _sortAsc = asc;
      });
}

typedef SelectedCallBack = Function(String id, bool newSelectState);

class CommonSourceForTable extends AdvancedDataTableSource<dynamic> {
  CommonSourceForTable({required this.list, required this.columnNames,required this.user_type});
  List<String> selectedIds = [];
  String lastSearchTerm = '';
  List<Map<String, dynamic>>
      list; // Change `List` type to a map of dynamic values

  List<String> columnNames;
  String user_type;

  @override
  DataRow? getRow(int index) {
    if (index >= 0 && index < list.length) {
      final currentRowData = list[index];
      return DataRow(
        color: index % 2 == 0
            ? MaterialStateProperty.all<Color>(Colors.white)
            : MaterialStateProperty.all<Color>(Colors.grey.shade200),
        cells: [
          ...columnNames.map((fieldName) {
            return DataCell(
              Text("$fieldName" == "incident_status"
                  ? "${currentRowData[fieldName]}" == "1"
                      ? "Manager- Pending"
                      :  "${currentRowData[fieldName]}" == "2"
                  ? "Completed"
                  :
              "${currentRowData[fieldName]}" == "3"
                  ? "Rejected"
                  :
              currentRowData[fieldName].toString()
                  : currentRowData[fieldName].toString(),style: TextStyle(color:"$fieldName" == "incident_status"
                  ? "${currentRowData[fieldName]}" == "1"
                  ? Colors.purple
                  :  "${currentRowData[fieldName]}" == "2"
                  ?  Colors.green
                  :
              "${currentRowData[fieldName]}" == "3"
                  ?  Colors.red
                  :
            Colors.black:Colors.black),
              ),
            );
          }).toList(),
          DataCell(
            Row(
              children: [
                InkWell(
                  child: Icon(
                    Icons.remove_red_eye_outlined,
                    color: AppColors.primaryColor,
                  ),
                  onTap: () async {
                    String Id = currentRowData["id"];
                    // String Id= " gettingChoosenId :${currentRowData["id"]}";

                    await IncidentController.to.setDataForUpdate(ID: '${Id}', ignoring: true,
                        canShowSection2ForApprovals:true);
                    // Handle edit button click here
                    debugPrint('CHECKKK IDD $Id');
                    IncidentController.to.showButton = true;
                    IncidentController.to.showImage = true;
                    await IncidentController.to.getDataForApprovals(
                      incident_user_id: '${Id}',
                    );
                    IncidentController.to.viewButton=true;

                  },
                ),
                "${currentRowData["incident_status"]}" == "1"
                    ?
                IconButton(
                  icon: Icon(
                    user_type =="1"?  LineIcons.edit:Icons.person,
                    color: AppColors.primaryColor,
                  ),
                  onPressed: () async {
                    String Id = currentRowData["id"];
                    await IncidentController.to.setDataForUpdate(ID: '${Id}', ignoring: false,
                        canShowSection2ForApprovals:user_type =="1"?false:true
                    );
                    SharedPreferences aswiniPrefs=await SharedPreferences.getInstance();
                    debugPrint("dhhugdftyewfduewfrufvru");
                    IncidentController.to.designationApp.text=aswiniPrefs.getString("designation_name")??"";
                    IncidentController.to.subjectApp.text=aswiniPrefs.getString("user_name")??"";
                    IncidentController.to.dateAndTimeApp.text="${DateFormat("yyyy-MM-dd  hh:mm:ss").format(DateTime.now())}";
                    debugPrint("test subject ${IncidentController.to.subjectApp.text}");

                    IncidentController.to.showImage = false;
                    IncidentController.to.showButton = false;
                    IncidentController.to.viewButton=false;               },
                ):
                SizedBox(),
                IconButton(
                  icon: Icon(
                    Icons.download,
                    color: AppColors.primaryColor,
                  ),
                  onPressed: () async {



                    debugPrint("checking whether is workin on pressed or not");
                    debugPrint("test url chether is workin on pressed or not${currentRowData['pdf_link']}");


                    final http.Response responseData = await http.get(Uri.parse("${currentRowData['pdf_link']}"));
                    Uint8List uint8list = responseData.bodyBytes;
                    var buffer = uint8list.buffer;
                    ByteData byteData = ByteData.view(buffer);
                    var tempDir = await getTemporaryDirectory();
                    File fileData = await File('${tempDir.path}/${currentRowData['incident_id']}.pdf').writeAsBytes(
                        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
                    try {
                      final file = await CRFileSaver.saveFile(
                        fileData.path,
                        destinationFileName: "${currentRowData['incident_id']}.pdf",
                      );
                      debugPrint('Saved to $file');
                      RemoteMessage message=RemoteMessage(
                        notification: RemoteNotification(
                            body: "${currentRowData['incident_id']} file downloaded successfully",
                            title: "Incident File download",
                            android: AndroidNotification(

                            )
                        ),

                      );
                      FcmService().localNotification(message: message);
                    } on PlatformException catch (e) {
                      debugPrint('file saving error: ${e}');
                    }

                  },
                )
              ],
            ),
          ),
          DataCell(
           SizedBox(width: 5,)
          ),
        ],
      );
    }
    return null;
  }

  @override
  int get selectedRowCount => selectedIds.length;

// ignore: avoid_positional_boolean_parameters
  void selectedRow(String id, bool newSelectState) {
    if (selectedIds.contains(id)) {
      selectedIds.remove(id);
    } else {
      selectedIds.add(id);
    }
    notifyListeners();
  }

  void filterServerSide(String filterQuery) {
    lastSearchTerm = filterQuery.toLowerCase().trim();
    setNextView();
  }

  @override
  Future<RemoteDataSourceDetails<Map<String, dynamic>>> getNextPage(
    NextPageRequest pageRequest,
  ) async {
    return RemoteDataSourceDetails(
      list.length,
      list,
      filteredRows: lastSearchTerm.isNotEmpty ? list.length : null,
    );
  }
}

Widget _buildSearchBox() {
  return Row(
    children: [
      Container(
        width: Get.width * .76,

        child: Card(
          child: ListTile(
            leading: Icon(Icons.search),
            title: TextField(
              controller: IncidentController.to.searchController,
              decoration:
                  InputDecoration(hintText: 'Search', border: InputBorder.none),
              onChanged: (value) {
                IncidentController.to.searchValue = value;
                IncidentController.to.dashboardLoading = true;
                IncidentController.to.incidentDashboardList =
                    getFilteredIncidentData(
                        list: IncidentController.to.incidentDashboardList,
                        searchQuery: value);
                IncidentController.to.dashboardLoading = false;
              },
            ),
            trailing: IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () {
                IncidentController.to.searchController.text="";
                IncidentController.to.incidentDashboardList =
                    IncidentController.to.incidentDashboardListDummy;
                IncidentController.to.searchValue = "";
              },
            ),
          ),
        ),
      ),
      SizedBox(width: 7,),
      InkWell(
        onTap: () {
          IncidentController.to.viewDropdown = !IncidentController.to.viewDropdown;
        },
        child: Container(
          decoration: commonButtonDecoration(),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child:  Icon(
                LineIcons.filter,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

List<Map<String, dynamic>> getFilteredIncidentData({
  required list,
  required String searchQuery,
}) {
  return searchQuery.isEmpty
      ? IncidentController.to.incidentDashboardListDummy
      :  IncidentController.to.incidentDashboardListDummy
          .where((incident) =>
             "${incident['subject']??""}".toLowerCase().contains(searchQuery) ||
                 "${incident['incident_id']??""}".toLowerCase().contains(searchQuery) ||
                 "${incident['date_and_time']??""}"
                  .toLowerCase()
                  .contains(searchQuery) ||
                 "${incident['incident_status']??""}".toLowerCase().contains(searchQuery))
          .toList();
}
BoxDecoration commonButtonDecoration() {
  return BoxDecoration(
      gradient: LinearGradient(colors: [
        AppColors.primaryColor,
        AppColors.blue
      ]

      ),
      borderRadius: BorderRadius.circular(10)
  );
}
