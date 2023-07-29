import 'dart:convert';

import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../../../controllers/DashboardController.dart';
import '../../themes/MyColors.dart';
import '../../widgets/contact_name.dart';
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
  final _source = ExampleSource();
  var _sortIndex = 0;
  var _sortAsc = true;
  final _searchController = TextEditingController();
  var _customFooter = false;

  @override
  void initState() {
    super.initState();
    _searchController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: new Text('General Permit to Work List'),
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
                        Get.to(()=>                  IncidentDashboardMyForms()
                        )
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xff354144), minimumSize: Size(110, 0)),
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


              dataTableFormat(context),
            ],
          ),
        ],
      ),
    );
  }

  AdvancedPaginatedDataTable dataTableFormat(BuildContext context) {
    return AdvancedPaginatedDataTable(
              addEmptyRows: false,
              source: _source,
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
                  label: const Text('ID'),
                  numeric: true,
                  onSort: setSort,
                ),
                DataColumn(
                  label: const Text('Company'),
                  onSort: setSort,
                ),
                DataColumn(
                  label: const Text('First name'),
                  onSort: setSort,
                ),
                DataColumn(
                  label: const Text('Last name'),
                  onSort: setSort,
                ),
                DataColumn(
                  label: const Text('Phone'),
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

class ExampleSource extends AdvancedDataTableSource<CompanyContact> {
  List<String> selectedIds = [];
  String lastSearchTerm = '';

  @override
  DataRow? getRow(int index) =>
      lastDetails!.rows[index].getRow(selectedRow, selectedIds);

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
  Future<RemoteDataSourceDetails<CompanyContact>> getNextPage(
      NextPageRequest pageRequest,
      ) async {
    //the remote data source has to support the pagaing and sorting
    final queryParameter = <String, dynamic>{
      'offset': pageRequest.offset.toString(),
      'pageSize': pageRequest.pageSize.toString(),
      'sortIndex': ((pageRequest.columnSortIndex ?? 0) + 1).toString(),
      'sortAsc': ((pageRequest.sortAscending ?? true) ? 1 : 0).toString(),
      if (lastSearchTerm.isNotEmpty) 'companyFilter': lastSearchTerm,
    };

    final requestUri = Uri.https(
      'example.devowl.de',
      '',
      queryParameter,
    );

    final response = await http.get(requestUri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return RemoteDataSourceDetails(
        int.parse(data['totalRows'].toString()),
        (data['rows'] as List<dynamic>)
            .map(
              (json) => CompanyContact.fromJson(json as Map<String, dynamic>),
        )
            .toList(),
        filteredRows: lastSearchTerm.isNotEmpty
            ? (data['rows'] as List<dynamic>).length
            : null,
      );
    } else {
      throw Exception('Unable to query remote server');
    }
  }
}

Widget _buildSearchBox() {
  return Container(
    width: Get.width,
    child:  Card(
      child:  ListTile(
        leading:  Icon(Icons.search),
        title:  TextField(
          controller: DashboardController.to.searchController,
          decoration:  InputDecoration(
              hintText: 'Search', border: InputBorder.none),
          onChanged:(value){
            DashboardController.to.searchValue=value;
          },
        ),
        trailing:  IconButton(
          icon:  Icon(Icons.cancel),
          onPressed: () {

          },
        ),
      ),
    ),
  );
}