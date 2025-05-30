import 'package:flutter/material.dart';

void main() {
  runApp(PresionApp());
}

class PresionApp extends StatelessWidget {
  const PresionApp({super.key});

  @override
  Widget build(BuildContext contex) {
    return MaterialApp(
      title: 'Control de Presión',
      theme: ThemeData(primarySwatch: Colors.red),
      home: PresionForm(),
    );
  }
}

class PresionForm extends StatefulWidget {
  const PresionForm({super.key});

  @override
  _PresionFormState createState() => _PresionFormState();
}

class _PresionFormState extends State<PresionForm> {
  final _systolicController = TextEditingController();
  final _diastolicController = TextEditingController();
  final _pulseController = TextEditingController();
  String _diagnostico = '';
  Color _colorDiagnostico = Colors.grey[300]!;
  Color color = Colors.grey;

  void _analizarPresion() {
    //"final" se usa para variables de un solo uso.
    final int? sys = int.tryParse(_systolicController.text);
    final int? dia = int.tryParse(_diastolicController.text);
    final int? pulso = int.tryParse(_pulseController.text);
    String resultado = '';
    String observacionPulso = '';

    if (sys == null || dia == null || pulso == null) {
      setState(() {
        _diagnostico = 'Por favor, ingrese todos los valores correctamente.';
        _colorDiagnostico = Colors.grey[300]!;
      });
      return;
    }

    if (sys < 90 || dia < 60) {
      resultado = 'Presión baja (hipotención).';
      color = Colors.lightBlueAccent;
    } else if (sys <= 120 && dia <= 80) {
      resultado = 'Presión normal.';
      color = Colors.green;
    } else if (sys <= 129 && dia <= 80) {
      resultado = 'Presión elevada.';
      color = Colors.orangeAccent;
    } else if ((sys >= 130 && sys <= 139) || (dia >= 80 && dia <= 89)) {
      resultado = 'Hipertensión etapa 1.';
      color = Colors.deepOrange;
    } else if (sys >= 140 || dia >= 90) {
      resultado = 'Hipertensión etapa 2.';
      color = Colors.red;
    } else {
      resultado = 'Consulta médica recomendada.';
      color = Colors.grey;
    }

    if (pulso < 60) {
      observacionPulso = 'Observación: Pulso bajo (bradicardia).';
    } else if (pulso > 100) {
      observacionPulso = 'Observación: Pulso alto (taquicardia).';
    } else {
      observacionPulso = 'Observación: Pulso estable.';
    }

    setState(() {
      _diagnostico =
          'Diagnóstico: $resultado\nPulso: $pulso lpm. $observacionPulso';
      _colorDiagnostico = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Control de Presión')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _systolicController,
              decoration: InputDecoration(labelText: 'Sistólica (SYS)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _diastolicController,
              decoration: InputDecoration(labelText: 'Diastólica (DIA)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _pulseController,
              decoration: InputDecoration(labelText: 'Pulso (lpm)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _analizarPresion,
              child: Text('Diagnosticar'),
            ),
            SizedBox(height: 20),
            //Text(_diagnostico, style: TextStyle(fontSize: 18)),
            if (_diagnostico.isNotEmpty)
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _colorDiagnostico,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _diagnostico,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            Spacer(), // Esto empuja el footer hacia abajo
            Text(
              'Desarrollado por: Juan Samuel Zelaya Reconco\nGitHub: https://github.com/JuanZR-Projects',
              style: TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

//Ejecutar con "flutter run"

// Edita el archivo: android/app/src/main/AndroidManifest.xml

// Busca esta línea: <application , Luego: android:label="Nombre App"

// Instala el paquete flutter_launcher_icons:
// Agrega esto a tu pubspec.yaml: dev_dependencies:

//   flutter_launcher_icons: ^0.13.1

// flutter_launcher_icons:
//   android: true
//   image_path: "imagenes/icono.png" //Por ejemplo

// Luego, ejecutar en la terminal:

// flutter pub get
// flutter pub run flutter_launcher_icons:main

//<<flutter build apk --release>> en la terminal para crear .apk

//......................................
//<<git config --global --add safe.directory C:/flutter>> para que Git tenga confianza en flutter.
