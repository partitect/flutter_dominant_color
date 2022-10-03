import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsScreen extends StatelessWidget {
  final String title;
  final String desc;
  final String image;
  final Color bgColor;
  final Color titleColor;
  final Color textColor;
  const DetailsScreen({
    super.key,
    required this.title,
    required this.image,
    required this.bgColor,
    required this.desc,
    required this.textColor,
    required this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_sharp,
            color: textColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Details",
          style: TextStyle(
            color: titleColor,
          ),
        ),
        backgroundColor: bgColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.anton(
                  textStyle: TextStyle(
                    color: titleColor,
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 350,
                child: CachedNetworkImage(
                  imageUrl: image,
                  imageBuilder: (context, imageProvider) => Container(
                    width: double.infinity,
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                desc,
                style: GoogleFonts.dosis(
                  textStyle: TextStyle(
                    color: textColor,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
