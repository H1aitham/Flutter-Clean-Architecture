
import 'package:clean_architecture/features/posts/domain/usecases/get_post.dart';
import 'package:clean_architecture/features/posts/presentaion/bloc/post/remote/remote_post_event.dart';
import 'package:clean_architecture/features/posts/presentaion/bloc/post/remote/remote_post_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetPostsUseCase _getPostsUseCase;

  PostBloc(this._getPostsUseCase) : super(PostInitial()) {
    on<GetPosts>(
      (event, emit) async {
        final result = await _getPostsUseCase.call();

        result.fold((error) {
          emit(PostError(errorMessage: error.errorMessage));
        }, (posts) {
          emit(
            PostSuccess(
              posts: posts,
            ),
          );
        });
      },
    );
  }
}