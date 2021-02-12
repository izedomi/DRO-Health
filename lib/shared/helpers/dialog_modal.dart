import 'package:DRHealth/shared/widgets/dialog_modal_widget.dart';
import 'package:flutter/material.dart';

showDialogModal({BuildContext context, String msg, String action}){
      showDialog(
        barrierDismissible: false,
        context: context, 
        builder: (context) => AddToBagDialog(msg, action)
      );
  }