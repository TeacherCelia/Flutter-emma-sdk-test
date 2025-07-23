import 'package:flutter/material.dart';
import '/services/emma_services.dart';
import 'package:emma_flutter_sdk/emma_flutter_sdk.dart';
import '/widgets/section_header.dart'; // header
import '/widgets/custom_button.dart'; // botón custom
import '/widgets/native_ad_dialog.dart'; // dialog de NativeAD
import '/widgets/custom_toast.dart'; // toast
import '/widgets/age_dialog.dart'; // age dialog
import '/widgets/cart.dart'; // carrito

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // opciones de idioma
  String? _selectedLanguage;
  final Map<String, String> _languages = {
    'es': 'Spanish',
    'en': 'English',
    'fr': 'French',
    'de': 'German',
    'it': 'Italian',
  };

  // para el carrito
  late final Cart _cart;

  @override
  void initState() {
    super.initState();
    _initEMMA();
    _cart = Cart(onCartUpdated: () => setState(() {}));
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
              Image.asset(
                'assets/emma_banner.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
        // ---- IN APP MESSAGES ---- //
              const SizedBox(height: 20),
              const SectionHeader(
                title: 'In-App Messages',
                description: 'Here you can obtain ads in-app by clicking on the following buttons:',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    text: 'NativeAd',
                    onPressed: _requestNativeAd,
                  ),
                  const SizedBox(width: 15),
                  CustomButton(
                    text: 'StartView', 
                    onPressed: () async {
                      await EmmaFlutterSdk.shared.inAppMessage(EmmaInAppMessageRequest(InAppType.startview));
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    text: 'AdBall',
                    onPressed: () async {
                      await EmmaFlutterSdk.shared.inAppMessage(EmmaInAppMessageRequest(InAppType.adBall));
                    },
                  ),
                  const SizedBox(width: 15),
                  CustomButton(
                    text: 'Banner', 
                    onPressed: () async {
                      await EmmaFlutterSdk.shared.inAppMessage(EmmaInAppMessageRequest(InAppType.banner));
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CustomButton(
                text: 'Strip', 
                onPressed: () async {
                  await EmmaFlutterSdk.shared.inAppMessage(EmmaInAppMessageRequest(InAppType.strip));
                },
              ),
        // ---- EVENTS ---- //
              const SectionHeader(
              title: 'Events',
              description: 'Here you can try events such as: tracking a custom event, test a register, test a login or change an user tag value'
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // -- TRACK EVENT
                  CustomButton(
                    text: 'Track Event',
                    onPressed: () async {
                      await EmmaFlutterSdk.shared.trackEvent("4137f3a184bb5de977da43f90546b1f8");
                      CustomToast.showSuccess('Custom event tracked');
                    },
                  ),
                  const SizedBox(width: 15),
                  // -- REGISTER
                  CustomButton(
                    text: 'Register', 
                    onPressed: () async {
                      await EmmaFlutterSdk.shared
                        .registerUser("flutterUser", "flutter@emma.io");
                      CustomToast.showSuccess('User registered.');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // -- LOGIN
                  CustomButton(
                    text: 'Login',
                    onPressed: () async {
                      await EmmaFlutterSdk.shared
                        .loginUser("flutterUser", "flutter@emma.io");
                      CustomToast.showSuccess('User logged in');
                    },
                  ),
                  const SizedBox(width: 15),
                  // -- CHANGE TAG
                  CustomButton(
                    text: 'Change tag', 
                    onPressed: () async {
                      final edad = await showDialog<int>(
                        context: context,
                        builder: (context) => const AgeDialog(),
                      );

                      if (edad != null) {
                        await EmmaFlutterSdk.shared.trackExtraUserInfo({'AGE': edad.toString()});
                        CustomToast.showSuccess('New age tag value: $edad');
                      }
                    },
                  ),
                ],
              ),
        // ---- SHOPPING ---- //
              const SizedBox(height: 10),
              const SectionHeader(
              title: 'Shopping',
              description: 'Here you can simulate to buy products, first starting an order, then adding products, and then validating the order or cancelling it.'
              ),
              const SizedBox(width: 15),
              CustomButton(
                text: 'Add product', 
                onPressed: () => _cart.addProduct(context),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    text: 'Track Order',
                    onPressed: _cart.productCount > 0 ? () => _cart.trackOrder(context) : null,
                  ),
                  const SizedBox(width: 15),
                  CustomButton(
                    text: 'Cancel order', 
                    onPressed: _cart.productCount > 0 ? () => _cart.cancelOrder(context) : null,
                  ),
                ],
              ),
        // ---- LANGUAGE ---- //
              const SizedBox(height: 10),
              const SectionHeader(
              title: 'Language',
              description: 'This method allows overwriting the default language of the device to set a custom language to be used in all SDK requests.'
              ),
              const SizedBox(height: 5),
              DropdownButton<String>(
                value: _selectedLanguage, // declarado en el state
                hint: const Text('Choose language'),
                items: _languages.entries.map((entry) {
                  return DropdownMenuItem<String>(
                    value: entry.key,
                    child: Text('${entry.value} (${entry.key})'),
                  );
                }).toList(),
                onChanged: (String? newLang) async {
                  if (newLang != null) {
                    setState(() {
                      _selectedLanguage = newLang;
                    });
                    await EmmaFlutterSdk.shared.setUserLanguage(newLang);
                    CustomToast.showSuccess('Language set to ${_languages[newLang]}');
                  }
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
