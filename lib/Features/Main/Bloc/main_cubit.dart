import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trks/Repositories/Repositories.dart';
import 'package:trks/Utilities/Initializer.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  Future loadData() async {
    if(!ShopItemRepository().isInit){
      await Initializer.init();
    }
    emit(MainLoaded());
  }
}
