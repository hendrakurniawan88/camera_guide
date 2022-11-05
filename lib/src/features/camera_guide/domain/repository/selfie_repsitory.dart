import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/repository/selfie_repository_impl.dart';
import '../entities/selfie.dart';

abstract class SelfieRepository {
  Future<Either<String, Selfie?>> getSelfie();
  Future<Either<String, Selfie?>> saveSelfie(Selfie selfie);
}

final selfieRepositoryProvider = Provider<SelfieRepository>((ref) {
  return SelfieRepositoryImpl();
});
