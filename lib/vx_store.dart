import 'package:velocity_x/velocity_x.dart';

class MyStore extends VxStore {
  int currentPage = 0;
}

class IncrementPage extends VxMutation<MyStore> {
  final index;
  IncrementPage(this.index);

  @override
  perform() {
    store.currentPage = index;
  }
}


