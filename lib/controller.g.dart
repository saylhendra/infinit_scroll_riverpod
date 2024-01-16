// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getDataPaginateHash() => r'7dfc48b880386c96bdf01358a86dbdf3bb1efd23';

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

abstract class _$GetDataPaginate extends BuildlessAsyncNotifier<List?> {
  late final int page;

  FutureOr<List?> build({
    required int page,
  });
}

/// See also [GetDataPaginate].
@ProviderFor(GetDataPaginate)
const getDataPaginateProvider = GetDataPaginateFamily();

/// See also [GetDataPaginate].
class GetDataPaginateFamily extends Family<AsyncValue<List?>> {
  /// See also [GetDataPaginate].
  const GetDataPaginateFamily();

  /// See also [GetDataPaginate].
  GetDataPaginateProvider call({
    required int page,
  }) {
    return GetDataPaginateProvider(
      page: page,
    );
  }

  @override
  GetDataPaginateProvider getProviderOverride(
    covariant GetDataPaginateProvider provider,
  ) {
    return call(
      page: provider.page,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getDataPaginateProvider';
}

/// See also [GetDataPaginate].
class GetDataPaginateProvider
    extends AsyncNotifierProviderImpl<GetDataPaginate, List?> {
  /// See also [GetDataPaginate].
  GetDataPaginateProvider({
    required int page,
  }) : this._internal(
          () => GetDataPaginate()..page = page,
          from: getDataPaginateProvider,
          name: r'getDataPaginateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getDataPaginateHash,
          dependencies: GetDataPaginateFamily._dependencies,
          allTransitiveDependencies:
              GetDataPaginateFamily._allTransitiveDependencies,
          page: page,
        );

  GetDataPaginateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.page,
  }) : super.internal();

  final int page;

  @override
  FutureOr<List?> runNotifierBuild(
    covariant GetDataPaginate notifier,
  ) {
    return notifier.build(
      page: page,
    );
  }

  @override
  Override overrideWith(GetDataPaginate Function() create) {
    return ProviderOverride(
      origin: this,
      override: GetDataPaginateProvider._internal(
        () => create()..page = page,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        page: page,
      ),
    );
  }

  @override
  AsyncNotifierProviderElement<GetDataPaginate, List?> createElement() {
    return _GetDataPaginateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetDataPaginateProvider && other.page == page;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetDataPaginateRef on AsyncNotifierProviderRef<List?> {
  /// The parameter `page` of this provider.
  int get page;
}

class _GetDataPaginateProviderElement
    extends AsyncNotifierProviderElement<GetDataPaginate, List?>
    with GetDataPaginateRef {
  _GetDataPaginateProviderElement(super.provider);

  @override
  int get page => (origin as GetDataPaginateProvider).page;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
