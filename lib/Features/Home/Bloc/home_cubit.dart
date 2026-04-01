import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trks/Models/Models.dart';
import 'package:trks/Repositories/Repositories.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeInitial> {
  HomeCubit() :
        super(
          HomeInitial(
            listFeaturettes: FeaturetteRepository().listFeaturettes
          )
      );
}
