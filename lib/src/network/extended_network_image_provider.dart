import 'dart:async';
import 'dart:typed_data';
import 'package:extended_image_library/src/extended_image_provider.dart';
import 'package:flutter/painting.dart';
import 'package:http_client_helper/http_client_helper.dart';
import 'network_image_io.dart'
    if (dart.library.js_util) 'network_image_web.dart'
    as network_image;

/// [NetworkImage]
abstract class ExtendedNetworkImageProvider
    extends ImageProvider<ExtendedNetworkImageProvider>
    with ExtendedImageProvider<ExtendedNetworkImageProvider> {
  /// Creates an object that fetches the image at the given URL.
  ///
  /// The arguments [url] and [scale] must not be null.
  factory ExtendedNetworkImageProvider(
    String url, {
    double scale,
    Map<String, String>? headers,
    bool cache,
    int retries,
    Duration? timeLimit,
    Duration timeRetry,
    CancellationToken? cancelToken,
    String? cacheKey,
    bool printError,
    bool cacheRawData,
    String? imageCacheName,
    Duration? cacheMaxAge,
    WebHtmlElementStrategy webHtmlElementStrategy,
    FutureOr<Uint8List> Function(void Function(ImageChunkEvent) chunkEvent)?
    bytesLoader,
  }) = network_image.ExtendedNetworkImageProvider;

  /// Time Limit to request image
  Duration? get timeLimit;

  /// The time to retry to request
  int get retries;

  /// The time duration to retry to request
  Duration get timeRetry;

  /// Whether cache image to local
  bool get cache;

  /// The URL from which the image will be fetched.
  String get url;

  /// The scale to place in the [ImageInfo] object of the image.
  double get scale;

  /// The HTTP headers that will be used with [HttpClient.get] to fetch image from network.
  Map<String, String>? get headers;

  /// Token to cancel network request
  CancellationToken? get cancelToken;

  /// Custom cache key
  String? get cacheKey;

  /// print error
  bool get printError;

  /// The max duration to cahce image.
  /// After this time the cache is expired and the image is reloaded.
  Duration? get cacheMaxAge;

  /// On the Web platform, specifies when the image is loaded as a
  /// [WebImageInfo], which causes [Image.network] to display the image in an
  /// HTML element in a platform view.
  ///
  /// See [Image.network] for more explanation.
  ///
  /// Defaults to [WebHtmlElementStrategy.never].
  ///
  /// Has no effect on other platforms, which always fetch bytes.
  WebHtmlElementStrategy get webHtmlElementStrategy;

  FutureOr<Uint8List> Function(void Function(ImageChunkEvent chunkEvent))?
  get bytesLoader;

  ///get network image data from cached
  Future<Uint8List?> getNetworkImageData({
    StreamController<ImageChunkEvent>? chunkEvents,
  });

  ///HttpClient for network, it's null on web
  static dynamic get httpClient =>
      network_image.ExtendedNetworkImageProvider.httpClient;
}
