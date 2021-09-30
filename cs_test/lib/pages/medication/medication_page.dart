import 'package:cs_test/models/models.dart';
import 'package:cs_test/pages/medication/medication_cell.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:redux/redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:cs_test/pages/medication/medication_view_model.dart';
import 'package:cs_test/state.dart';

class MedicationPage extends StatelessWidget {
  final TabController tabController;

  MedicationPage({Key key, this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<GlobalAppState, MedicationViewModel>(
        distinct: true,
        converter: (Store<GlobalAppState> store) =>
            MedicationViewModel.create(store),
        onInitialBuild: (MedicationViewModel viewModel) {
          viewModel.getAll();
        },
        builder: (BuildContext context, MedicationViewModel viewModel) =>
            buildContent(context, viewModel));
  }

  Widget buildContent(BuildContext context, MedicationViewModel viewModel) =>
      TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: <Widget>[
          buildTodaysContent(context, viewModel),
          buildActiveContent(context, viewModel),
          buildExpiredContent(context, viewModel)
        ],
      );

  Widget buildTodaysContent(
      BuildContext context, MedicationViewModel viewModel) => buildMedications(context, viewModel.todayMedications, "list-today");


  Widget buildActiveContent(
      BuildContext context, MedicationViewModel viewModel) => buildMedications(context, viewModel.activeMedications, "list-active");


  Widget buildExpiredContent(
          BuildContext context, MedicationViewModel viewModel) => buildMedications(context, viewModel.expiredMedications, "list-expired");

  Widget buildMedications(BuildContext context, List<Medication> medications, String key) =>
    medications.length == 0 ? buildEmptyState(context, Key("$key-empty")) : Container(
        key: Key(key),
        alignment: Alignment.center,
        child: ListView.separated(
            padding: EdgeInsets.all(16),
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 16,
              );
            },
            itemCount: medications.length,
            itemBuilder: (context, index) {
              var medication = medications[index];
              return MedicationCell(key: Key("$key-$index"), medication: medication);
            }));

  Widget buildEmptyState(BuildContext context, Key key) => Container(
    key: key,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 80, bottom: 32),
            child: SvgPicture.asset(
              "assets/icons/medication.svg",
              color: Color.fromARGB(255, 218, 218, 218),
              height: 144,
            ),
          ),
          Text("None Currently Listed")
        ],
      ));
}


