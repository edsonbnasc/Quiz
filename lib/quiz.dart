import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz/home_page.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int _currentQuestionIndex = 0;
  int _ponto = 0;
  String? _selectedAnswer;
  bool? _isCorrect;

  final List<Map<String, dynamic>> _questions = [
    {
      'question':
          'Qual destes animais é conhecido por sua impressonante capacidade de mudar de cor?',
      'answers': ['Golfinho', 'Polvo', 'Tubarão', 'Baleia'],
      'correctAnswer': 'Polvo',
      
    },
    {
      'question':
          'Qual animal marinho é famoso por sua carapaça dura e longa vida?',
      'answers': [
        'Baleia Azul',
        'Caranguejo',
        'Tartaruga Marinha',
        'Estrela do Mar'
      ],
      'correctAnswer': 'Tartaruga Marinha',
      
    },
    {
      'question':
          'Qual animal marinho é famoso em filmes  por ser o "Mostro da Bacia do Pacífico"?',
      'answers': ['Caranguejo', 'Tartaruga Marinha', 'Estrela do Mar', 'Orca'],
      'correctAnswer': 'Orca',
      
    },
    //adiciona mais perguntas
  ];

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswer = null;
        _isCorrect = null;
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Quiz TERMINADO'),
            content: Text('SEUS PONTOS: $_ponto'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const HomePage()));
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _handleAnswer(String answer) {
    setState(() {
      _selectedAnswer = answer;
      _isCorrect = answer == _questions[_currentQuestionIndex]['correctAnswer'];
    });

    if (_isCorrect!) {
      _ponto += 500;
      _nextQuestion();
    } else {
      _erroAlerta();
      _ponto-=1000;
    }
  }

  

  void _erroAlerta() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Resposta Errada'),
          content: Text('tente novamente.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  Widget meuBtn(String resposta, VoidCallback onPressed, Color? color) =>
      Container(
        margin: const EdgeInsets.all(16),
        width: 160,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
          ),
          child: Text(resposta),
        ),
      );
//principal
  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz maritimo!',
            style: GoogleFonts.roboto(fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            color: Colors.deepPurple[50],
            width: double.infinity,
            height: 400,
            child: Center(
              child: Text(
                currentQuestion['question'],
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
          Wrap(
            children: currentQuestion['answers'].map<Widget>((resposta) {
              bool isSelected = _selectedAnswer == resposta;
              Color? buttonColor;
              if (isSelected) {
                buttonColor = _isCorrect! ? Colors.green : Colors.red;
              }
              return meuBtn(
                  resposta, () => _handleAnswer(resposta), buttonColor);
            }).toList(),
          ),
        ],
      ),
    );
  }
}

