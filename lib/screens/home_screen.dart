// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '/services/emma_services.dart';
import '/widgets/native_ad_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _initEMMA();
  }
   // llamada al inicio de sesión de EMMAServices
  Future<void> _initEMMA() async {
    await EmmaServices.startSession();
  }
  
  // petición de native ad a EMMAServices
  Future<void> _requestNativeAd() async {
    await EmmaServices.requestNativeAd(
      onAdReceived: (title, body, imageUrl, adId) async {
        await EmmaServices.sendImpression(adId);

        showDialog(
          context: context,
          builder: (_) => NativeAdDialog(
            title: title,
            body: body,
            imageUrl: imageUrl,
            onClose: () async {
              await EmmaServices.sendClick(adId);
              Navigator.of(context).pop();
            },
          ),
        );
      },
      onNoAd: () => print("No se recibió native ad"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EMMA Flutter test app')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              const Text(
                'In-App Messages',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'Here you can obtain ads in-app by clicking on the following buttons:',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _requestNativeAd,
                child: const Text('NativeAd'),
              ),
              // Aquí puedes seguir añadiendo botones, textos, imágenes...
            ],
          ),
        ),
      ),
    );
  }
}
