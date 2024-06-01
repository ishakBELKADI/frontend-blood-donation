import 'notification.dart';
import 'utilisateur.dart';

class NotifEnvoyer {
  Utilisateur utilisateur;
  Notification notification;

  NotifEnvoyer({
    required this.utilisateur,
    required this.notification,
  });

  factory NotifEnvoyer.fromJson(Map<String, dynamic> json) {
    return NotifEnvoyer(
      utilisateur: Utilisateur.fromJson(json['utilisateur']),
      notification: Notification.fromJson(json['notification']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'utilisateur': utilisateur.toJson(),
      'notification': notification.toJson(),
    };
  }
}
