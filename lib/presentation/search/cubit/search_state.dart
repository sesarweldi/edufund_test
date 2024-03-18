import 'package:edufund_test/model/testimonial.dart';

abstract class SearchState {}

class TestimonialsInitial extends SearchState {}

class TestimonialsLoaded extends SearchState {
  final List<Testimonial> testimonials;
  TestimonialsLoaded(this.testimonials);
}

class TestimonialsLoading extends SearchState {}

class TestimonialsError extends SearchState {
  final String error;
  TestimonialsError(this.error);
}
