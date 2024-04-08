import 'package:flutter/material.dart';
import 'package:gdtest/data/models/movie.dart';
import 'package:gdtest/presentation/screens/movie_details_screen.dart';

class MoviePreviewCard extends StatelessWidget {
  final Movie movie;

  const MoviePreviewCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsScreen(movie: movie),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // Movie Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                movie.imagePath,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            // Related Movie Tag
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green, // Customize color as needed
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Related \n Movie',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Colored Layer with Movie Title
            Container(
              width: double.infinity,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                ),
                color: Colors.black.withOpacity(0.5),
              ),
              child: Text(
                movie.title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
