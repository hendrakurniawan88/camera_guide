import 'package:camera_guide/src/features/camera_guide/domain/repository/selfie_repsitory.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selfie_controller.g.dart';

@riverpod
class SelfieController extends _$SelfieController {
  FutureOr<void> build() {}

  Future<void> signInAnonymously() async {
    final selfieRepository = ref.read(selfieRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(selfieRepository.getSelfie);
  }
}
