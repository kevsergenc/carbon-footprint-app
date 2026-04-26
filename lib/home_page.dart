
import 'package:flutter/material.dart';
import 'dart:async';
import 'view_suggestions.dart';
import 'survey_page.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() =>  _HomePageState();
}
  class _HomePageState extends State<HomePage>{
    final PageController controller = PageController();
    int pageIndex = 0;
    Timer? timer;

    final List<String> images = [
       "assets/images/world.jpg",
    "assets/images/forest1.jpg",
    "assets/images/forest2.jpg",

    ];
    @override
void initState(){
  super.initState();

  timer=Timer.periodic(const Duration(seconds:3), (t){
    pageIndex = (pageIndex+1) % images.length;
    controller.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
     );
     setState((){});

   });
  }
  @override
  void dispose(){
    timer?.cancel();
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:Stack(
        children: [
          Positioned.fill(
            child:  Image.asset(
              "assets/images/world.jpg",
              fit:BoxFit.cover,

            ),
          ),
          Positioned.fill(child:Container(color:Colors.black.withOpacity(0.3),
          ),
            ),
            SafeArea(child:Padding(padding: EdgeInsets.all(20),
            child:Column(children: [
              const Spacer(),
              Container(
                padding:const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color:Colors.white,
                borderRadius: BorderRadius.circular(25),

              ),
              child: Column(
                children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child:SizedBox(
                    height:220,
                    width: double.infinity,
                    child: PageView.builder(
                      controller:controller,
                    onPageChanged: (index){
                      setState((){
                        pageIndex=index;
                      
                      });
                    },
                    itemCount: images.length,
                    itemBuilder:(context,index)
                    
                    {
                      return Image.asset(
                        images[index],
                      fit:BoxFit.cover,
                      );
                    },

                  

                   ) ),
                ),
             
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                images.length,
                (index) =>Container(
                 margin: const EdgeInsets.symmetric(horizontal: 4),
                 width:10,
                 height:10,
                 decoration: BoxDecoration(
                  color:pageIndex==index ?Colors.green :Colors.grey,
                  shape:BoxShape.circle,
                 ),
                ),
              ),
              ),

       
      const SizedBox(height: 12),

      const Text("Doğaya Katkı Sağla",
      style:TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      ),
      ),
      const SizedBox(height:10),
       const Text(
                        "Karbon ayak izini azaltmak için küçük adımlar bile büyük fark yaratır.",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SurveyPage(),
      ),
    );
                      
                        },
                        icon: const Icon(Icons.assessment_outlined),
                        label: const Text("Ankete Git"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ViewSuggestions(),
      ),
    );

                        },
                        icon: const Icon(Icons.lightbulb_outline),
                        label: const Text("Önerileri Gör"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1B5E20),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
        ), ),),],),);
  }
  }
  
  