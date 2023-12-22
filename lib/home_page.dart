
import 'package:allen/feature_box.dart';
import 'package:allen/openai_service.dart';
import 'package:allen/pellete.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final speechToText= SpeechToText();
  String lastWords="";
  final OpenAIService openAIService=OpenAIService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSpeechToText();
  }
  Future<void> initSpeechToText() async{
      await speechToText.initialize();
      setState(() {});
  }
  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Allen"),
        leading: Icon(Icons.menu),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if(await speechToText.hasPermission && speechToText.isNotListening){
            await startListening();
          }else if(speechToText.isListening){
            final sppech =await openAIService.isArtPromptAPI(lastWords);
            print(sppech);
            await stopListening();
          }else{
            initSpeechToText();
          }
        },
        child: Icon(Icons.mic),
        backgroundColor: Pallete.firstSuggestionBoxColor,

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                    height: 120,
                      width: 120,
                      margin: const EdgeInsets.only(top:4),
                    decoration: BoxDecoration(
                      color: Pallete.assistantCircleColor,
                      shape: BoxShape.circle
                    ),
                  ),
                ),
                Container(
                  height: 123,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image:AssetImage("assets/images/virtualAssistant.png"))
                  ),
                )
              ],
            ),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical:10 ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Pallete.borderColor
                ),
                borderRadius: BorderRadius.circular(20).copyWith(
                  topLeft: Radius.zero
                )
              ),
              margin: const EdgeInsets.symmetric(horizontal:40).copyWith(
                top: 30
              ),
              child: const Padding(
                padding:  EdgeInsets.symmetric(vertical: 10.0),
                child: Text("Good Morning, What task can I do for you",style: TextStyle(
                  color: Pallete.mainFontColor,
                  fontSize: 25,
                  fontFamily: 'Cera Pro'
                ),),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(top:10,left:22),
              alignment: Alignment.centerLeft,
              child: const Text("Here are a few Features",style: TextStyle(
                fontFamily: 'Cera Pro',
                color: Pallete.mainFontColor,
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),),
            ),
            Column(
              children: [
                FeatureBox(color: Pallete.firstSuggestionBoxColor, headerText: 'ChatGPT',
                  descriptionText: 'A smarter way to stay organised and informed with ChatGPT',),
                FeatureBox(color: Pallete.secondSuggestionBoxColor, headerText: 'Dall-E',
                  descriptionText: 'Get inspired and stay creative with your personal assistant powered by Dall-E',),
                FeatureBox(color: Pallete.thirdSuggestionBoxColor, headerText: 'Smart Voice Assistant',
                  descriptionText: 'Get the best of both worlds with a voice assistant powered by Dall-E and ChatGPT',),
              ],
            )
          ],
        ),
      ),
    );
  }
}
