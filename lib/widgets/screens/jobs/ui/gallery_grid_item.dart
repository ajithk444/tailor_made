import 'package:flutter/material.dart';
import 'package:tailor_made/models/image.dart';
import 'package:tailor_made/widgets/screens/gallery/gallery_view.dart';

const _kGridWidth = 70.0;

class GalleryGridItem extends StatelessWidget {
  GalleryGridItem({
    Key key,
    @required this.tag,
    @required this.image,
    this.onTapDelete,
    double size,
  })  : size = Size.square(size ?? _kGridWidth),
        super(key: key);

  final String tag;
  final ImageModel image;
  final Size size;
  final void Function(ImageModel image) onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Container(
        width: size.width,
        margin: EdgeInsets.only(right: 8.0),
        child: Stack(
          children: [
            Positioned.fill(
              child: Material(
                color: Colors.white,
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                child: Ink.image(
                  image: NetworkImage(image.src),
                  fit: BoxFit.cover,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push<dynamic>(
                        PageRouteBuilder<dynamic>(
                          opaque: false,
                          pageBuilder: (BuildContext context, _, __) =>
                              GalleryView(image: image),
                          transitionsBuilder: (_, Animation<double> animation,
                              __, Widget child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: onTapDelete != null
                        ? Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                              onTap: () => onTapDelete(image),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Icon(Icons.cancel, color: Colors.red),
                              ),
                            ),
                          )
                        : SizedBox(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}