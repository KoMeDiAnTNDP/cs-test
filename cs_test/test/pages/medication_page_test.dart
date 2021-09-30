import 'dart:convert';

import 'package:cs_test/api/apis.dart';
import 'package:cs_test/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mockito/mockito.dart';

import '../mocks.dart';


void main() {
  group("Medication Page", () {
    testWidgets("should render empty page on today", (tester) async {
      var api = MockMedicationApi();
      when(api.getAll(any))
          .thenAnswer((_) => Future.value(APIResponse(isOk: true, result: [])));

      var widgetToPump = makeWidgetToPump(api, tester, 0);
      await tester.pumpWidget(widgetToPump);
      expect(find.byKey(Key("list-today-empty")), findsOneWidget);
    });

    testWidgets("should render empty page on active", (tester) async {
      var api = MockMedicationApi();
      when(api.getAll(any))
          .thenAnswer((_) => Future.value(APIResponse(isOk: true, result: [])));

      var widgetToPump = makeWidgetToPump(api, tester, 1);
      await tester.pumpWidget(widgetToPump);
      expect(find.byKey(Key("list-active-empty")), findsOneWidget);
    });

    testWidgets("should render empty page on expired", (tester) async {
      var api = MockMedicationApi();
      when(api.getAll(any))
          .thenAnswer((_) => Future.value(APIResponse(isOk: true, result: [])));

      var widgetToPump = makeWidgetToPump(api, tester, 2);
      await tester.pumpWidget(widgetToPump);
      expect(find.byKey(Key("list-expired-empty")), findsOneWidget);
    });

    testWidgets("should render expired list", (tester) async {
      var api = MockMedicationApi();
      dynamic expiredMedicationsJson = json.decode(expiredMedications);
      List<Medication> medications = [];
      for(Map medicationDto in expiredMedicationsJson) {
        medications.add(Medication.fromJson(medicationDto));
      }
      when(api.getAll(any))
          .thenAnswer((_) => Future.value(APIResponse(isOk: true, result: medications)));

      var widgetToPump = makeWidgetToPump(api, tester, 2);
      await tester.pumpWidget(widgetToPump);
      await tester.pump(Duration(milliseconds: 500));

      expect(find.byKey(Key("list-expired")), findsOneWidget);
      expect(find.byKey(Key("list-expired-0")), findsOneWidget);
      expect(find.byKey(Key("list-expired-1")), findsOneWidget);
      expect(medications.length, 2);
    });

    testWidgets("should render active list", (tester) async {
      var api = MockMedicationApi();
      dynamic expiredMedicationsJson = json.decode(expiredMedications);
      List<Medication> medications = [];
      var now = DateTime.now().toUtc();
      for(Map medicationDto in expiredMedicationsJson) {
        medicationDto['start'] = now.add(Duration(days: -10));
        medicationDto['expiry'] = now.add(Duration(days: 10));
        medications.add(Medication.fromJson(medicationDto));
      }

      when(api.getAll(any))
          .thenAnswer((_) => Future.value(APIResponse(isOk: true, result: medications)));

      var widgetToPump = makeWidgetToPump(api, tester, 1);
      await tester.pumpWidget(widgetToPump);
      await tester.pump(Duration(milliseconds: 500));
      expect(find.byKey(Key("list-active")), findsOneWidget);
      expect(find.byKey(Key("list-active-0")), findsOneWidget);
      expect(find.byKey(Key("list-active-1")), findsOneWidget);
      expect(medications.length, 2);
    });

    testWidgets("should render today list", (tester) async {
      var api = MockMedicationApi();
      dynamic expiredMedicationsJson = json.decode(expiredMedications);
      List<Medication> medications = [];
      var now = DateTime.now();
      for(Map medicationDto in expiredMedicationsJson) {
        medicationDto['start'] = now.add(Duration(days: -10));
        medicationDto['expiry'] = now.add(Duration(days: 10));
        // may break on day/night change
        medicationDto['interval'] = DateFormat("HH:mm").format(now.add(Duration(minutes: 10)));
        medications.add(Medication.fromJson(medicationDto));
      }

      when(api.getAll(any))
          .thenAnswer((_) => Future.value(APIResponse(isOk: true, result: medications)));

      var widgetToPump = makeWidgetToPump(api, tester, 0);
      await tester.pumpWidget(widgetToPump);
      await tester.pump(Duration(milliseconds: 1000));
      expect(find.byKey(Key("list-today")), findsOneWidget);
      expect(find.byKey(Key("list-today-0")), findsOneWidget);
      expect(find.byKey(Key("list-today-1")), findsOneWidget);
      expect(medications.length, 2);
    });
  });
}
