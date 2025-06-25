import 'package:cached_network_image/cached_network_image.dart';
import 'package:dumbdumb_flutter_app/app/assets/exporter/importer_app_general.dart';
import 'package:dumbdumb_flutter_app/app/widgets/conditional_wrapper.dart';

class NetworkImageLoader extends StatelessWidget {
  const NetworkImageLoader({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.cacheWidth,
    this.cacheHeight,
    this.fit,
    this.alignment = Alignment.center,
    this.previewEnabled = false,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final int? cacheWidth;
  final int? cacheHeight;
  final BoxFit? fit;
  final Alignment alignment;
  final bool previewEnabled;

  @override
  Widget build(BuildContext context) {
    return ConditionalWrapper(
      shouldWrap: previewEnabled,
      wrapper: (child) => TouchableOpacity(
        // TODO: Implement image preview (optional)
        // onPressed: () {},
        child: child,
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fit,
        width: width,
        height: height,
        memCacheHeight: cacheHeight,
        memCacheWidth: cacheWidth,
        alignment: alignment,
        errorWidget: (context, url, error) {
          return const Icon(Icons.error);
        },
        progressIndicatorBuilder: (context, url, downloadProgress) {
          /// If the total size is not available, the progress is indeterminate.
          if (downloadProgress.totalSize == null || downloadProgress.totalSize == 0) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          return Center(
            child: CircularProgressIndicator.adaptive(
              value: downloadProgress.progress,
            ),
          );
        },
      ),
    );
  }
}
