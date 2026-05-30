import 'package:flutter/material.dart';
import 'survey_page.dart';
import 'dart:async';
class HomePage extends StatefulWidget{
  const HomePage ({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
  }
  class _HomePageState extends State<HomePage> {
  final PageController controller = PageController();
  
  int pageIndex = 0; 
  Timer? timer;
  final List <String> images = [
    "assets/images/cicek.jpg",
    "assets/images/dag.jpg",
    "assets/images/deniz.jpg",
    "assets/images/orman.jpg",

  ]; 
  @override
  void initState(){
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 3),(t){
        pageIndex = (pageIndex + 1) % images.length;
      controller.animateToPage(
        pageIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      setState(() {});
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
  backgroundColor: const Color(0xFFEFF7F1),
  body: Stack(
    children: [
      Positioned.fill(
        child: Image.asset(
          "assets/images/soft.jpg", 
          fit: BoxFit.cover,
        ),
      ),
      Positioned.fill(
        child: Container(
          color: Colors.white.withOpacity(0.85),
        ),
      ),SafeArea(
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                
               
                
              ],
            ),
            const SizedBox(height: 10),
            Center(
              child: ConstrainedBox(
    constraints: const BoxConstraints(
      maxWidth: 650,
    ),
    child: Container(
      width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:  BorderRadius.circular(42),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.10),
                    blurRadius: 22,
                    offset:  const Offset(0, 10),
                  ),
              
                ],
              ),
              child: Column(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: SizedBox(
                    height: 185,
                    width: double.infinity,

                    child: PageView.builder(
                      controller: controller,
                      onPageChanged: (index){
                        setState(() {
                          pageIndex =index; 
                        });
                      }, 
                      itemCount: images.length,

                      itemBuilder:(context, index){
                        return Image.asset(
                          images[index],
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(images.length, 
                (index)=> Container(
                  margin: 
                  const EdgeInsets.symmetric(
                    horizontal: 4,
                  ),
                  width: 10,
                  height: 10,

                  decoration: BoxDecoration(
                    color: pageIndex == index
                    ? const Color(0xFF2E7D32)
                    : Colors.grey.shade400,

                    shape: BoxShape.circle,
                  ),

                ),
                ),
                ),
                const SizedBox(height: 6),
                const Text("Karbon Ayak İzinizi Keşfedin",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0B3D2E),

                ),
                ),
              
                const SizedBox(height:10),

                const Text(
                "Günlük alışkanlıklarınızı analiz edin,\nçevreye katkınızı görün.",
                textAlign: TextAlign.center,  
                style: TextStyle(
                  fontSize: 11,
                  height: 1.4,
                  color: Color(0xFF4B5563),
                ),

                ),
              
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  height: 40,

                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                      
                      MaterialPageRoute(
                        builder:(context)=> const SurveyPage(),
                        ),
                        );
                    },
                    style:
                    ElevatedButton.styleFrom(
                      backgroundColor: 
                      const Color(0xFF2E7D32),

                      foregroundColor:  Colors.white,
                      elevation: 5,
                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(18),
                         ),
                      ),
                  
                      child: const Text( "Hesaplamaya Başla",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                  

                    ),
                  ),
              ],
              ),

                ),
                ),
            ),
            
                const SizedBox(height: 8),
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const[
                  Expanded(child: Divider(
                    color: Color(0xFFC8D8C9),
                  ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(
                  horizontal: 14,  
                  ),
                  child: Text(
                    "Neden Önemli?",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0B3D2E),
                    ),
                  ),
                  ),
                  Expanded(child: Divider(
                    color:Color(0xFFC8D8C9),
                    ),
                    ),
                ],
                ),
                ),
                const SizedBox(height: 4), 
                Row(
  children: const [
    Expanded(
      child: InfoCard(
        icon: Icons.public,
        title: "Dünyamızı Koru",
        text: "Karbon ayak izinizi azaltarak daha yaşanabilir bir gelecek inşa edin.",
      ),
    ),
    SizedBox(width: 8),
    Expanded(
      child: InfoCard(
        icon: Icons.bar_chart,
        title: "Etkinizi Görün",
        text: "Alışkanlıklarınızın çevreye etkisini ölçün ve ilerletmenizi takip edin.",
      ),
    ),
    SizedBox(width: 8),
    Expanded(
      child: InfoCard(
        icon: Icons.eco,
        title: "Sürdürülebilir Yaşa",
        text: "Küçük değişikliklerle büyük etkiler yaratabilirsiniz.",
      ),
    ),
  ],
),

        ],
        ), 
        
        ),
        

              ),
    ],
  ),
            );
      
    
  }
  }
class InfoCard extends StatelessWidget{
  final IconData icon;
  final String title;
  final String text; 

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.text,
  });
  @override
  Widget build(BuildContext context) {
      return Container(
        height: 155,
        padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 12,
        ),

        decoration: BoxDecoration(
         color: Colors.white,
         borderRadius: BorderRadius.circular(18),

         boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 14,
            offset: const Offset(0, 7),
          ),
         ] ,
        ),
        child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
          CircleAvatar(
          radius: 18,
          backgroundColor: const Color(0xFFE2F0E3) ,

          child: Icon(
            icon,
            color: const Color(0xFF2E7D32),
            size: 18,

          ),  
          ),
          const SizedBox(height: 6),

          Text(
            title,
            textAlign: TextAlign.center,

            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0B3D2E),
            ),
          ),
          const SizedBox(height: 4),

          Text(
            text, 
            textAlign: TextAlign.center,

            style: const TextStyle(
              fontSize: 13,
              height: 1.25,
              color:  Color(0xFF4B5563),

            ),
          ),
        ],
        ),
      
      );
    }
  }


   
