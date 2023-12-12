import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';


    SnackBar buildSnackBar(
     { required BuildContext context,
     required String title,
      required String message,
      required ContentType contentType
     }
    
    ) {
    return SnackBar(
                  /// need to set following properties for best effect of awesome_snackbar_content
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: title,
                    message:
                        message,
                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                    contentType: contentType,
                  ),
                );
  }

  showSnackBar({
    required BuildContext context,
    required String title,
    required String message,
    required ContentType contentType,
  }) {
    final snackBar = buildSnackBar(
      context: context,
      title: title,
      message: message,
      contentType: contentType,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
