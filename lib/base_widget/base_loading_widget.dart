import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseLoadingWidget extends StatelessWidget {
  final Widget child;
  final BaseLoadingVM vm;
  BaseLoadingWidget(this.child, this.vm);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: vm,
      builder: (context, child) {
        var data = Provider.of<BaseLoadingVM>(context).data;
        if (data.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return child;
        }
      },
      child: child,
    );
  }
}

class BaseLoadingVM extends ChangeNotifier {
  BaseLoadingData data = BaseLoadingData();
  void updateData(BaseLoadingData data) {
    this.data = data;
    notifyListeners();
  }
}

class BaseLoadingData {
  bool isLoading = true;
}
