import 'package:emma_flutter_sdk/emma_flutter_sdk.dart';
import 'package:emma_flutter_sdk/src/start_session.dart';
import 'dart:io';

/// Clase para llamar a los servicios de EMMA
/// 
/// Iniciar sesión
/// Llamar a un NativeAd
class EmmaServices {
  
  // --- Iniciar sesión --- //
  static Future<void> startSession() async {
    final params = StartSession(
      sessionKey: "3DBF55A0B7BC550874edfbac6d5dc49f8",
      queueTime: 10,
      isDebug: true,
      trackScreenEvents: false,
    );

    await EmmaFlutterSdk.shared.startSession(params);

    // iniciar sistema de push
    await EmmaFlutterSdk.shared.startPushSystem('logo_emma_50');

    // obtener el deeplink o powlink
    EmmaFlutterSdk.shared.setDeepLinkHandler((url) {
      print(url);
      EmmaFlutterSdk.shared.handleLink(url); // enviarlo a EMMA
    });

    // permiso de notificaciones
    if (Platform.isAndroid) {
      EmmaFlutterSdk.shared.setPermissionStatusHandler((status) {
      print('Notifications permission status: ' + status.toString());
    });

    await EmmaFlutterSdk.shared.requestNotificationsPermission();
    }

  }

  // --- LLamar a un native ad --- //
  static Future<void> requestNativeAd({
    required void Function(String title, String body, String imageUrl, int id) onAdReceived,
    required void Function() onNoAd,
  }) async {
    final request = EmmaInAppMessageRequest(InAppType.nativeAd)
      ..batch = false
      ..templateId = "plantilla-prueba-celia";

    EmmaFlutterSdk.shared.setReceivedNativeAdsHandler((nativeAds) async {
      if (nativeAds.isNotEmpty) {
        final ad = nativeAds.first;
        final map = ad.toMap();
        final fields = map['fields'] as Map<String, dynamic>? ?? {};

        onAdReceived(
          fields['Title'] ?? 'No title',
          fields['Body'] ?? 'No body',
          fields['Main picture'] ?? '',
          ad.id,
        );
      } else {
        onNoAd();
      }
    });

    await EmmaFlutterSdk.shared.inAppMessage(request);
  }

  static Future<void> sendImpression(int adId) async {
    await EmmaFlutterSdk.shared.sendInAppImpression(InAppType.nativeAd, adId);
  }

  static Future<void> sendClick(int adId) async {
    await EmmaFlutterSdk.shared.sendInAppClick(InAppType.nativeAd, adId);
  }


}
