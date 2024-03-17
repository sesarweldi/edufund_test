import 'package:edufund_test/data/repository/repository.dart';
import 'package:edufund_test/presentation/home/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(TestimonialsInitial());

  final Repository repo = Repository();

  void getTestimonials(int page) async {
    emit(TestimonialsLoading());
    try {
      repo.getTestimonials(page, null).then((value) {
        emit(TestimonialsLoaded(value, page));
      });
    } catch (e) {
      emit(TestimonialPagedError(e.toString()));
    }
  }

  void getSliderTestimonials() async {
    emit(TestimonialsSliderLoading());
    try {
      repo.getTestimonials(1, null).then((value) {
        emit(TestimonialsSliderLoaded(value));
      });
    } catch (e) {
      emit(TestimonialsSliderError(e.toString()));
    }
  }
}
