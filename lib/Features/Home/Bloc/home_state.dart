part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {
  List<Featurette> listFeaturettes;

  HomeInitial({required this.listFeaturettes});
}
