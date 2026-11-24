// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.



import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:andresmoreira_leccion_6sx/main.dart';

void main() {

  // Prueba de los elementos principales de la interfaz.
  testWidgets('Verificar formulario de registro',
          (WidgetTester tester) async {

        await tester.pumpWidget(const MiAplicacion());

        expect(
          find.text('Empresa XYZ - Registro'),
          findsOneWidget,
        );

        expect(
          find.byType(TextFormField),
          findsNWidgets(4),
        );

        expect(
          find.text('MOSTRAR DATOS'),
          findsOneWidget,
        );
      });

  // Prueba de validación de campos obligatorios.
  testWidgets('Validar campos vacíos',
          (WidgetTester tester) async {

        await tester.pumpWidget(const MiAplicacion());

        final boton = find.text('MOSTRAR DATOS');

        await tester.ensureVisible(boton);
        await tester.tap(boton);
        await tester.pumpAndSettle();

        expect(
          find.text('Este campo es obligatorio'),
          findsNWidgets(4),
        );

        expect(
          find.text('DATOS REGISTRADOS'),
          findsNothing,
        );
      });
}

