import 'package:edufund_test/model/testimonial.dart';

abstract class HomeState {}

class TestimonialsInitial extends HomeState {}

class TestimonialsLoaded extends HomeState {
  final int page;
  final List<Testimonial> testimonials;
  TestimonialsLoaded(this.testimonials, this.page);
}

class TestimonialsLoading extends HomeState {}

class TestimonialPagedError extends HomeState {
  final String error;
  TestimonialPagedError(this.error);
}

class TestimonialsSliderLoaded extends HomeState {
  final List<Testimonial> testimonials;
  TestimonialsSliderLoaded(this.testimonials);
}

class TestimonialsSliderLoading extends HomeState {}

class TestimonialsSliderError extends HomeState {
  final String error;
  TestimonialsSliderError(this.error);
}
