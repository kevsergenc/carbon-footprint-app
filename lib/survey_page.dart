import 'package:flutter/material.dart';
import 'result_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SurveyPage extends StatefulWidget {
  const SurveyPage({super.key});

  @override
  State<SurveyPage> createState()=> _SurveyPageState();
}
  class _SurveyPageState extends State<SurveyPage>{
    String? transport;
    String? diet ;
    String? heating;
    String? efficiency;
    String? wasteBag;
    int? clothes;
  
    bool recycleAll = false;
    bool recyclePaper = false;
    bool recycleMetal = false;
    bool recycleNone = false;

Future<void> saveSurveyAnswers() async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    return;
  }

  await FirebaseFirestore.instance.collection('survey_answers').add({
    'uid': user.uid,
    'transport': transport,
    'diet': diet,
    'heating': heating,
    'efficiency': efficiency,
    'wasteBag': wasteBag,
    'clothes': clothes,
    'recycleAll': recycleAll,
    'recyclePaper': recyclePaper,
    'recycleMetal': recycleMetal,
    'recycleNone': recycleNone,
    'createdAt': Timestamp.now(),
  });
}
    final Map<String, String>dietDescriptions = {
      "omnivore":"Hem et hem sebze tüketen beslenme tipi.",
      "pescatarian": "Kırmızı et yerine balık tüketen beslenme tipi.",
      "vegetarian": "Et tüketmeyen beslenme tipi.",
      "vegan": "Hiçbir hayvansal ürün tüketmeyen beslenme tipi.",
    
    };
    Widget categoryCard({
      required String title,
      required Color color,
      required List<Widget> children,

    })
    { return Card(
      color: color,
      elevation:3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),

      ),
      margin: const EdgeInsets.only(bottom:18),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children :[
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1B5E20),
              ),
            ),
            const SizedBox(height:10),
            ...children,

          ],
        ),
      ),
    );

    }
    Widget buildDietOption(String title, String value){
      return RadioListTile<String>(
        value : value,
        groupValue: diet,
        onChanged: (newValue){
          setState((){
           diet= newValue;
          });
        },
        title: Row(children: [
          Text(title),
          const SizedBox(width:6),
          Tooltip( message: dietDescriptions[value] ?? "",
          child: const Icon(
            Icons.info_outline,
            size:20,
            color:Colors.grey,
          ),
          ),
        ],
        ),
      );
    }
@override
Widget build(BuildContext context){
  return Scaffold(appBar: AppBar(
    title: const Text("Karbon Ayak İzi Anketi"),
    backgroundColor: const Color (0xFF1B5E20),
    foregroundColor: Colors.white,
  ),
  body: SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child:Column(children: [
      categoryCard(
        title:"Ulaşım",
        color: const Color(0xFFE3F2FD),
        children:[
          const Text("Günlük ulaşımda hangi yolu kullanıyorsun?"),
          RadioListTile<String>(
           title: const Text("Özel Araç"),
           value:"private",
           groupValue: transport,
           onChanged: (value){
            setState((){
           transport= value;
            });
           } ,
          ),
           RadioListTile<String>(
            title: const Text("Yürüyüş/Bisiklet"),
            value: "walk/bicycle",
            groupValue: transport,
            onChanged: (value) {
              setState((){
                transport=value;
              });
            },
           ),
           RadioListTile<String>(
            title: const Text ("Toplu taşıma"),
            value:"public",
            groupValue: transport,
            onChanged: (value){
              setState((){
                transport=value;
              });
            },
           ),
        ],
      ),
      categoryCard(
        title: "Diyet",
        color: const Color (0xFFE8F5E9),
        children:[
          const Text("Beslenme tipin nedir?"),
          buildDietOption("Omnivore", "omnivore"),
          buildDietOption("Pescatarian", "pescatarian"),
          buildDietOption("Vegetarian", "vegetarian"),
          buildDietOption("Vegan", "vegan"),
          

        ],

      ),
      categoryCard(
        title:"Enerji Tüketimi",
        color:const Color (0xFFE0F2F1),
        children:[
          const Text("Evinizde hangi enerji kaynağını kullanıyorsunuz?"),
          RadioListTile<String>(
            title: const Text ("Kömür"),
            value:"coal",
            groupValue:heating,
            onChanged: (value) {
              setState((){
                heating= value;

              });
            },
          ),
           RadioListTile<String>(
            title: const Text("Odun"),
            value:"wood",
            groupValue: heating,
            onChanged: (value) {
              setState((){
                heating=value;
              });
            },
           ),
          RadioListTile<String>(
            title: const Text("Doğalgaz"),
            value:"natural gas",
            groupValue: heating,
            onChanged: (value) {
              setState((){
                heating=value;
              });
            },
          ),
          RadioListTile<String>(
           title: const Text("Elektrik"),
            value:"electricity",
            groupValue: heating, 
            onChanged: (value) {
              setState((){
                heating=value;
              });
            },
          ),
          const SizedBox(height:10),
          const Text("Evinde enerji verimliliğine dikkat ediyor musunuz?"),
          RadioListTile<String>(
            title: const Text("Hayır"),
            value:"No",
            groupValue: efficiency,
            onChanged: (value){
              setState((){
                efficiency= value;
              });
              
            },
          ),
          RadioListTile<String>(
            title: const Text ("Bazen"),
            value: "Sometimes",
            groupValue: efficiency,
            onChanged:(value){
              setState((){
                efficiency=value;

              });
            },
          ),
          RadioListTile<String>(
            title: const Text("Evet"),
            value:"Yes",
            groupValue: efficiency,
            onChanged: (value) {
              setState((){
                efficiency= value;
              });
            },
          ),
        ],
      ),
    
    
        
  
        categoryCard(
          title: "Tüketim Alışkanlıkları",
          color: const Color(0xFFF1F8E9),
          children:[
            const Text("Haftalık çöp torbası sayınız ne kadar?"),
            RadioListTile<String>(
              title: const Text("Küçük"),
              value: "small",
              groupValue: wasteBag,
              onChanged: (value) {
                setState((){
                  wasteBag= value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text("Orta"),
              value: "medium",
              groupValue: wasteBag,
              onChanged: (value) {
                setState((){
                  wasteBag= value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text("Büyük"),
              value: "large",
              groupValue: wasteBag,
              onChanged: (value) {
                setState((){
                  wasteBag= value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text("Çok Büyük"),
              value: "extra large",
              groupValue: wasteBag,
              onChanged: (value) {
                setState((){
                  wasteBag= value;
                });
              },
            ),
            const SizedBox(height:10),
            const Text("Ayda kaç yeni kıyafet alıyorsunuz?"),
            const SizedBox(height:8),
          DropdownButtonFormField<int>(
                  value: clothes,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 0, child: Text("0")),
                    DropdownMenuItem(value: 5, child: Text("5")),
                    DropdownMenuItem(value: 10, child: Text("10")),
                    DropdownMenuItem(value: 20, child: Text("20")),


                  ],
                  onChanged: (value) {
                    setState((){
                      clothes= value;
                    });
                  },
          
        ),
        const SizedBox(height:12),
        const Text ("Hangi materyalleri geri dönüştürüyorsunuz?"),
        CheckboxListTile(
          title: const Text ("Hepsi"),
          value: recycleAll,
          onChanged: ( value){
            setState((){
              recycleAll= value ?? false;
            });
          },
        ),
       CheckboxListTile(
          title: const Text ("Kağıt"),
          value: recyclePaper,
          onChanged: ( value){
            setState((){
              recyclePaper= value ?? false;
            });
          },
        ),
        CheckboxListTile(
          title: const Text ("Metal"),
          value: recycleMetal,
          onChanged: ( value){
            setState((){
              recycleMetal= value ?? false;
            });
          },
        ), 
        CheckboxListTile(
          title: const Text ("Yok"),
          value: recycleNone,
          onChanged: ( value){
            setState((){
              recycleNone= value ?? false;
            });
          },
        ),
    ],
      ),
      SizedBox(
        width:double.infinity,
        child:ElevatedButton(
          onPressed: () async {
  await saveSurveyAnswers();

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const ResultPage(),
    ),
  );
},
          style: ElevatedButton.styleFrom(
            backgroundColor:  const Color (0xFF1B5E20),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity,50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text("Anketi Tamamla"),
          ),
         ),
        ],
       ),
    
    ),
   );

  
}


  }