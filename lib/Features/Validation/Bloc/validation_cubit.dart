import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:trks/Repositories/FeaturetteRepository.dart';

part 'validation_state.dart';

class ValidationCubit extends Cubit<ValidationState> {
  ValidationCubit() : super(ValidationInitial());
}
