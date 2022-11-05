// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selfie_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// ignore_for_file: avoid_private_typedef_functions, non_constant_identifier_names, subtype_of_sealed_class, invalid_use_of_internal_member, unused_element, constant_identifier_names, unnecessary_raw_strings, library_private_types_in_public_api

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

String $SelfieControllerHash() => r'3c6b09c847d4e126a9e87755e2391eff607d53d2';

/// See also [SelfieController].
final selfieControllerProvider =
    AutoDisposeAsyncNotifierProvider<SelfieController, void>(
  SelfieController.new,
  name: r'selfieControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : $SelfieControllerHash,
);
typedef SelfieControllerRef = AutoDisposeAsyncNotifierProviderRef<void>;

abstract class _$SelfieController extends AutoDisposeAsyncNotifier<void> {
  @override
  FutureOr<void> build();
}
