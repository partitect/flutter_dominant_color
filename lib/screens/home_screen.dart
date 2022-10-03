import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dominant_color/data/image_list.dart';
import 'package:flutter_dominant_color/models/image_model.dart';
import 'package:flutter_dominant_color/screens/details_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palette_generator/palette_generator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  List<ImageModel> list = [];

  Future<List<ImageModel>> getPalette() async {
    for (var i in imageList) {
      list.add(ImageModel.fromJson(i));
    }

    for (var item in list) {
      await PaletteGenerator.fromImageProvider(
        Image.network(item.image!).image,
      ).then((value) => {
            item.bgColor = value.dominantColor!.color,
            item.titleColor = value.dominantColor!.titleTextColor,
            item.textColor = value.dominantColor!.bodyTextColor,
          });
    }
    setState(() {
      isLoading = false;
    });
    return list;
  }

  @override
  void initState() {
    getPalette();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dominant Color")),
      body: !isLoading
          ? ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                                title: list[index].title!,
                                desc: list[index].desc!,
                                image: list[index].image!,
                                bgColor: list[index].bgColor!,
                                titleColor: list[index].titleColor!,
                                textColor: list[index].textColor!,
                              )),
                    );
                  },
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: list[index].bgColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 350,
                            child: CachedNetworkImage(
                              imageUrl: list[index].image!,
                              imageBuilder: (context, imageProvider) =>
                                  ShaderMask(
                                shaderCallback: (bound) {
                                  return LinearGradient(
                                    end: FractionalOffset.topCenter,
                                    begin: FractionalOffset.bottomCenter,
                                    colors: [
                                      list[index].bgColor!.withOpacity(1),
                                      Colors.transparent,
                                    ],
                                    stops: const [
                                      0.0,
                                      1,
                                    ],
                                  ).createShader(bound);
                                },
                                blendMode: BlendMode.dstOut,
                                child: Container(
                                  width: double.infinity,
                                  height: 400,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  list[index].title!,
                                  style: GoogleFonts.anton(
                                    textStyle: TextStyle(
                                      color: list[index].titleColor,
                                      fontSize: 40,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                Text(
                                  list[index].desc!,
                                  style: GoogleFonts.dosis(
                                    textStyle: TextStyle(
                                      color: list[index].textColor,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
