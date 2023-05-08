import 'package:flutter/material.dart';
import 'package:kataku/app/components/show_item.dart';
import 'package:kataku/app/modules/utils/imageitem.dart';

class ImageButtonItemBuilder extends StatelessWidget {
  final List<ImageItem> data;
  const ImageButtonItemBuilder(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (BuildContext ctx, int index) {
        return Material(
          type: MaterialType.transparency,
          child: Ink(
            child: InkWell(
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShowItemImage(
                            data[index].namaItem,
                            data[index].gambarItem,
                            audioSrcItem: data[index].audioSrcItem,
                          )),
                );
                // Get
              },
              child: Padding(
                padding: EdgeInsets.all(1.0),
                child: Image.asset(data[index].gambarItem),
              ),
            ),
          ),
        );
      },
      itemCount: data.length,
    );
  }
}
