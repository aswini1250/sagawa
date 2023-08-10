import 'dart:convert';

import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../../../controllers/DashboardController.dart';
import '../../../controllers/incident_controller.dart';
import '../../themes/MyColors.dart';
import '../../widgets/common_searchable_dropdown/MainCommonSearchableDropDown.dart';
import '../../widgets/progress_loading.dart';
import '../Error/incidentDashboardMyForm.dart';
import '../inicident_dashboardForms.dart';

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
  _IncidentScreenDashboardState createState() => _IncidentScreenDashboardState();
}

class _IncidentScreenDashboardState extends State<IncidentScreenDashboard> {
  var _rowsPerPage = AdvancedPaginatedDataTable.defaultRowsPerPage;
  var _sortIndex = 0;
  var _sortAsc = true;
  final _searchController = TextEditingController();
  var _customFooter = false;

  @override
  void initState() {
    super.initState();
    _searchController.text = '';
    IncidentController.to.getDashboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: new Text('Vehicles Incident'),
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
                padding: const EdgeInsets.all(8.0),
                child: new Container(
                    width: Get.width*.9, child: _buildSearchBox()),
              ),
              Obx(()=>IncidentController.to.viewDropdown==true?
                Wrap(
                  children: [
                    Obx(()=>IncidentController.to.preparadByLoading == true
                        ? Container(
                        height: 60, width: 60, child: ProgressLoading())
                        :
                    Container(
                      width:   Get.width*.9,

                      child: MainSearchableDropDown(
                        title: 'Praparated By',
                        items: IncidentController.to.preparadBy,                label: 'Praparated By'.tr,

                        isRequired: true,
                        controller:IncidentController.to.preparedby,
                        onChanged: (data) {
                        }, cb: (){

                      },
                      ),
                    ),
                    ),

                    Obx(()=>IncidentController.to.statusLoading == true
                        ? Container(
                        height: 60, width: 60, child: ProgressLoading())
                        :
                    Container(
                      width:   Get.width*.9,

                      child: MainSearchableDropDown(
                        title: 'Status',
                        items: IncidentController.to.statusList,                label: 'Status'.tr,

                        isRequired: true,
                        controller:IncidentController.to.status,
                        onChanged: (data) {
                        }, cb: (){

                      },
                      ),
                    ),
                    ),
                    Obx(()=>IncidentController.to.reportByLoading == true
                        ? Container(
                        height: 60, width: 60, child: ProgressLoading())
                        :
                    Container(
                      width:   Get.width*.9,

                      child: MainSearchableDropDown(
                        title: 'Report No',
                        items: IncidentController.to.geReportByList,                label: 'Report No'.tr,

                        isRequired: true,
                        controller:IncidentController.to.reportby,
                        onChanged: (data) {
                        }, cb: (){

                      },
                      ),
                    ),
                    ),
                    SizedBox(height: 10,),
                  ],
                ):SizedBox(),
              ),
              new Row(children: <Widget>[
                new Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                ),
                new Container(
                  alignment: Alignment.topCenter,
                  margin: const EdgeInsets.all(0.0),
                  width: 110,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () => {
                        Get.to(()=>
                        //  MyApp()
                        IncidentDashboardMyForms()
                        )
                      },
                      style: ElevatedButton.styleFrom(
                          primary:AppColors.primaryColor, minimumSize: Size(110, 0)),
                      // minWidth: 110,
                      //color: primarytext,
                      //padding: EdgeInsets.all(10.0),
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

              ]),

  Obx(()=>
    IncidentController.to.dashboardLoading==true?
        ProgressLoading():
      dataTableFormat(context),)
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
      columnNames:  [
        'incident_id',
        'subject',
        'date_and_time',
        'employee_name',
        'status',
      ]
      ),
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
                (element) =>
            element < currentPage - maxPagesBeforeCurrent,
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
  CommonSourceForTable({required this.list,
  required this.columnNames});
  List<String> selectedIds = [];
  String lastSearchTerm = '';
  List<Map<String, dynamic>> list; // Change `List` type to a map of dynamic values

  List<String> columnNames;


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
              Text(currentRowData[fieldName].toString()),
            );
          }).toList(),
          DataCell(
            IconButton(
              icon: Icon(Icons.edit,color: AppColors.primaryColor,),
              onPressed: () {
                // Handle edit button click here
                print('Edit button clicked for index $index');
              },
            ),
          ),
          DataCell(
            IconButton(
              icon: Icon(Icons.delete,color: AppColors.primaryColor,),
              onPressed: () {
                // Handle delete button click here
                print('Delete button clicked for index $index');
              },
            ),
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
  Future<RemoteDataSourceDetails<Map<String,dynamic>>> getNextPage(
      NextPageRequest pageRequest,
      ) async {


        return RemoteDataSourceDetails(
          list.length,
          list,
          filteredRows: lastSearchTerm.isNotEmpty
              ? list.length
              : null,
        );


  }
}

Widget _buildSearchBox() {
  return Row(
    children: [
      Container(
        width: Get.width*.78,
        child:  Card(
          child:  ListTile(
            leading:  Icon(Icons.search),
            title:  TextField(
              controller: DashboardController.to.searchController,
              decoration:  InputDecoration(
                  hintText: 'Search', border: InputBorder.none),
              onChanged:(value){

                DashboardController.to.searchValue=value;
                IncidentController.to.dashboardLoading=true;
                IncidentController.to.incidentDashboardList=      getFilteredIncidentData(
                    list: IncidentController.to.incidentDashboardList,
                    searchQuery:value
                );
                IncidentController.to.dashboardLoading=false;
              },
            ),
            trailing:  IconButton(
              icon:  Icon(Icons.cancel),
              onPressed: () {
                IncidentController.to.incidentDashboardList=IncidentController.to.incidentDashboardListDummy;
                DashboardController.to.searchValue="";

              },
            ),
          ),
        ),
      ),
      InkWell(
        onTap: (){
          IncidentController.to.viewDropdown=! IncidentController.to.viewDropdown;
        },
        child: Container(
          height: 60,
          width: 40,
          decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.primaryColor)),
          child: Center(
            child: const Icon(
              Icons.filter_alt_outlined,
              color: AppColors.primaryColor,
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
    return
      searchQuery.isEmpty?IncidentController.to.incidentDashboardListDummy:
      list
        .where((incident) =>
    incident['subject'].toLowerCase().contains(searchQuery) ||
        incident['customer_name'].toLowerCase().contains(searchQuery) ||
        incident['place_of_occurrence'].toLowerCase().contains(searchQuery) ||
        incident['remarks'].toLowerCase().contains(searchQuery))
        .toList();
  }
