import 'package:flutter/material.dart';

import 'package:gdtest/common/palette.dart';
import 'package:gdtest/data/models/movie.dart';
import '../screens/movie_details_screen.dart';

class MovieCard extends StatefulWidget {
  final Movie selectedMovie;
  final bool isDetailed;

  const MovieCard({
    Key? key,
    required this.selectedMovie,
    this.isDetailed = false,
  }) : super(key: key);

  @override
  _MovieCardState createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  late TextEditingController _commentController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(4),
      child: Container(
        padding: EdgeInsets.all(4),
        color: Palette.lightBlack,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: openMovieDetails,
              child: Image.asset(
                widget.selectedMovie.imagePath,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: openMovieDetails,
                  child: Text(
                    widget.selectedMovie.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _toggleCommentsVisibility();
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.comment,
                          color: widget.selectedMovie.isCommentAllowed
                              ? Colors.green
                              : Colors.grey,
                        ),
                        SizedBox(width: 12),
                        Text(
                          widget.selectedMovie.isCommentAllowed ? 'ON' : 'OFF',
                          style: TextStyle(
                            color: widget.selectedMovie.isCommentAllowed
                                ? Colors.green
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            if (widget.isDetailed && widget.selectedMovie.isCommentAllowed) ...[
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var comment in widget.selectedMovie.comments) ...[
                        Card(
                          elevation: 2,
                          color: Palette.almostBlack,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ListTile(
                              leading: Icon(Icons.account_circle,
                                  color: Colors.white),
                              title: Text(comment,
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    labelText: 'Add Comment',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: _addComment,
                    ),
                  ),
                ),
              ),
            ] else ...[
              SizedBox(height: 0),
            ],
          ],
        ),
      ),
    );
  }

  void _toggleCommentsVisibility() {
    setState(() {
      widget.selectedMovie.isCommentAllowed =
          !widget.selectedMovie.isCommentAllowed;
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(widget.selectedMovie.isCommentAllowed
              ? 'Comments On'
              : 'Comments Off'),
          content: Text(widget.selectedMovie.isCommentAllowed
              ? 'Comments are now enabled for this video.'
              : 'Comments are now disabled for this video.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _addComment() {
    setState(() {
      widget.selectedMovie.comments.add(_commentController.text);
      _commentController.clear();
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void openMovieDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailsScreen(movie: widget.selectedMovie),
      ),
    );
  }
}
