import 'package:biller/components/mainButton.dart';
import 'package:biller/screens/invoice_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class LayoutScreen extends StatefulWidget {
  LayoutScreen({Key key}) : super(key: key);
  static String id = "layout_screen_id";
  @override
  _LayoutScreenState createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {

  int current=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Which layout would you prefer?",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20,),
          CarouselSlider(items: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                image: DecorationImage(
                  image: AssetImage('https://www.google.com/url?sa=i&url=https%3A%2F%2Funsplash.com%2Fs%2Fphotos%2Fmusic&psig=AOvVaw1I3tT8PGH_TsX1PBb4r1No&ust=1611120365622000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCJj7tJmhp-4CFQAAAAAdAAAAABAD'),
                  fit: BoxFit.cover,
                )
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  image: DecorationImage(
                    image: AssetImage('https://www.google.com/url?sa=i&url=https%3A%2F%2Funsplash.com%2Fs%2Fphotos%2Fmusic&psig=AOvVaw1I3tT8PGH_TsX1PBb4r1No&ust=1611120365622000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCJj7tJmhp-4CFQAAAAAdAAAAABAD'),
                    fit: BoxFit.cover,
                  )
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  image: DecorationImage(
                    image: AssetImage('https://www.google.com/url?sa=i&url=https%3A%2F%2Funsplash.com%2Fs%2Fphotos%2Fmusic&psig=AOvVaw1I3tT8PGH_TsX1PBb4r1No&ust=1611120365622000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCJj7tJmhp-4CFQAAAAAdAAAAABAD'),
                    fit: BoxFit.cover,
                  )
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  image: DecorationImage(
                    image: AssetImage('https://www.google.com/url?sa=i&url=https%3A%2F%2Funsplash.com%2Fs%2Fphotos%2Fmusic&psig=AOvVaw1I3tT8PGH_TsX1PBb4r1No&ust=1611120365622000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCJj7tJmhp-4CFQAAAAAdAAAAABAD'),
                    fit: BoxFit.cover,
                  )
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  image: DecorationImage(
                    image: AssetImage('https://www.google.com/url?sa=i&url=https%3A%2F%2Funsplash.com%2Fs%2Fphotos%2Fmusic&psig=AOvVaw1I3tT8PGH_TsX1PBb4r1No&ust=1611120365622000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCJj7tJmhp-4CFQAAAAAdAAAAABAD'),
                    fit: BoxFit.cover,
                  )
              ),
            )
          ],
              options: CarouselOptions(
                height: 200,
                autoPlayCurve: Curves.easeInOut,
                enlargeCenterPage: true,
                reverse: true,
              )),
          SizedBox(height: 20,),
          MainButton(
            buttonText: "Continue",
            onPressed: (){
              Navigator.pushNamed(context, InvoiceScreen.id);

            },
          ),
          ],
      ),
    );
  }
}
