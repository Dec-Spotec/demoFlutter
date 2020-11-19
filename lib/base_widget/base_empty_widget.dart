import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseEmptyWidget extends StatelessWidget {
  final Widget child;
  final BaseEmptyVM vm;
  BaseEmptyWidget(this.child, this.vm);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: vm,
      builder: (context, child) {
        var data = Provider.of<BaseEmptyVM>(context).data;
        if (data.isLoading) {
          return Center(
            child: Container(
              child: Column(
                children: [Text("暂无数据")],
              ),
            ),
          );
        } else {
          return child;
        }
      },
      child: child,
    );
  }
}

class BaseEmptyVM extends ChangeNotifier {
  BaseEmptyData data = BaseEmptyData();
  void updateData(BaseEmptyData data) {
    this.data = data;
    notifyListeners();
  }
}

class BaseEmptyData {
  bool isLoading = true;
}
