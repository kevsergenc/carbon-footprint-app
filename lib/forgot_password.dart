
import 'package:flutter/material.dart';
class ForgotPasswordPage extends  StatelessWidget {
  const ForgotPasswordPage({super.key});
@override
  Widget build(BuildContext context){

const Color greenColor =Color (0xFF1B5E20);
return Scaffold(
  backgroundColor: const  Color(0xFFF7F7F7),
  appBar: AppBar(
    backgroundColor: const  Color(0xFF1B5E20),
    elevation: 0,
    title: const Text("Şifremi Unuttum"),
    centerTitle: true,

  ),
  body :Center(
    child: Padding(padding: const EdgeInsets.all(25),
    child:Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color:Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color:Colors.black12,
            blurRadius: 8,
          )
        ]
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children:[
          const Icon( Icons.lock_reset,
          size:60,
          color: greenColor,
          ),
          const SizedBox(height:16),

          const Text("Şifrenizi mi unuttunuz?",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,

          ),
          ),
          const SizedBox(height:12),
          const Text(
            "E-posta adresinizi girin, sıfırlama bağlantınızı gönderelim.",
            textAlign: TextAlign.center,
            style: TextStyle(color:Colors.grey),
          ),
          const SizedBox(height: 16),

          TextField(
            decoration: InputDecoration(
              hintText: "E-posta",
              prefixIcon: const Icon(Icons.email),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 22),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1B5E20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed:() {
                showDialog(context:context,
                builder: (context)=> AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), 
                  ),
                  content:Column(
                    mainAxisSize: MainAxisSize.min,
                    children:const[
                      Icon(Icons.check_circle,color: greenColor, 
                      size:60),
                      SizedBox(height:10),
                      Text(
                     "Bağlantı Gönderildi",
                     style:TextStyle(
                      fontWeight: FontWeight.w500)   
                      ),
                      SizedBox(height:5),
                     Text("E-posta adresinizi kontrol edin.",
                     textAlign: TextAlign.center,
          ),
                    ],
                  ),
                  actions:[
                    TextButton(
                      onPressed:() {
                        Navigator.pop(context);
                      },
                      child: const Text("Tamam"),
                    )
                  ],
                ),
                );
              },
              child: const Text("Sıfırlama Bağlantısı Gönder"),

            ),
          ),
          const SizedBox(height:15),
          TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: const Text("Giriş ekranına geri dön"),
          )

        
      
      ],
      ),
     ),
   ),
 ),
  );
}
}
