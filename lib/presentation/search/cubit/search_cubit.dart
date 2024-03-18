import 'package:edufund_test/data/repository/repository.dart';
import 'package:edufund_test/presentation/search/cubit/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(TestimonialsInitial());

  final Repository repo = Repository();

  void getTestimonials(String? search) async {
    try {
      emit(TestimonialsLoading());
      repo.getTestimonialsSearch(search).then((value) {
        emit(TestimonialsLoaded(value));
      }).catchError((e) {
        emit(TestimonialsError(e.toString()));
      });
    } catch (e) {
      emit(TestimonialsError(e.toString()));
    }
  }
}
