import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bio_state.dart';

class BioCubit extends Cubit<BioState> {
  BioCubit() : super(BioInitial());
}
