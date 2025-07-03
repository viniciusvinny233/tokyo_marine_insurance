abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final String userName;
  final String avatarUrl;
  
  HomeLoadedState({required this.userName, required this.avatarUrl});
}

class HomeErrorState extends HomeState {
  final String message;
  
  HomeErrorState({required this.message});
}