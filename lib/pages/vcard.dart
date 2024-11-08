import 'package:flutter/material.dart';
import '../pages/coursee.dart';

class VCard extends StatefulWidget {
  const VCard({Key? key, required this.course}) : super(key: key);

  final CourseModel course;

  @override
  State<VCard> createState() => _VCardState();
}

class _VCardState extends State<VCard> {
  final avatars = [4, 5, 6];

  @override
  void initState() {
    avatars.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 260, maxHeight: 310),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [widget.course.color, widget.course.color.withOpacity(0.5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
        boxShadow: [
          BoxShadow(
            color: widget.course.color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 12),
          ),
          BoxShadow(
            color: widget.course.color.withOpacity(0.3),
            blurRadius: 2,
            offset: const Offset(0, 1),
          )
        ],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: const BoxConstraints(maxWidth: 170),
                child: Text(
                  widget.course.title,
                  style: const TextStyle(
                      fontSize: 24,
                      fontFamily: "Poppins",
                      color: Color.fromARGB(255, 99, 13, 13)),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.course.subtitle!,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                softWrap: false,
                style: TextStyle(
                    color:
                        const Color.fromARGB(255, 161, 53, 53).withOpacity(0.7),
                    fontSize: 15),
              ),
              const SizedBox(height: 8),
              Text(
                widget.course.caption.toUpperCase(),
                style: const TextStyle(
                    fontSize: 13,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 144, 27, 27)),
              ),
              const Spacer(),
              Wrap(
                spacing: 8,
                children: List.generate(
                  avatars.length,
                  (index) => Transform.translate(
                    offset: Offset(index * -20, 0),
                    child: ClipRRect(
                      key: Key(index.toString()),
                      borderRadius: BorderRadius.circular(22),
                      child: Image.asset('assets/images/london.jpeg',
                          width: 44, height: 44),
                    ),
                  ),
                ),
              )
            ],
          ),
          // Positioned(
          //     right: -10,
          //     top: -10,
          //     child: Image.asset('assets/images/london.jpeg'))
        ],
      ),
    );
  }
}
