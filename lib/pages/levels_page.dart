import 'package:flutter/material.dart';
import 'package:mind_sage/pages/pics_page.dart';
import 'package:mind_sage/pages/profile_page.dart';

class LevelsPage extends StatelessWidget {
  final int depressionScore;
  final int anxietyScore;
  final int stressScore;

  const LevelsPage({
    required this.depressionScore,
    required this.anxietyScore,
    required this.stressScore,
  });

  // Funções para calcular os níveis
  String getLevelAnxiety(int score) {
    if (score <= 7) {
      return 'Leve';
    } else if (score <= 9) {
      return 'Moderada';
    } else if (score <= 14) {
      return 'Grave';
    } else if (score <= 19) {
      return 'Muito Grave';
    } else {
      return 'Extremamente Severo';
    }
  }

  String getLevelDepression(int score) {
    if (score <= 9) {
      return 'Leve';
    } else if (score <= 13) {
      return 'Moderada';
    } else if (score <= 20) {
      return 'Grave';
    } else if (score <= 27) {
      return 'Muito Grave';
    } else {
      return 'Extremamente Severo';
    }
  }

  String getLevelStress(int score) {
    if (score <= 14) {
      return 'Leve';
    } else if (score <= 18) {
      return 'Moderada';
    } else if (score <= 25) {
      return 'Grave';
    } else if (score <= 33) {
      return 'Muito Grave';
    } else {
      return 'Extremamente Severo';
    }
  }

  // Funções para retornar as descrições
  String getDescriptionAnxiety(String level) {
    switch (level) {
      case 'Leve':
        return 'Olá! Seu resultado indica níveis leves de ansiedade. É comum sentir-se um pouco ansioso de vez em quando, mas é ótimno que vocÊ esteja atento a isso. Para ajudar a gerenciar esses sentimenos, considere explorar a meditação, que opde promover uma sensação de calmma e relaxamento. A cromoterapia pode ser útil para equilibrar suas emoções, e a reflexologia podal pode aliviar a tensão. Lembre-se de que esta autoavaliação é uma ferramenta para ajudar a entender seu estado atual e não substitui a orientação médica. Se você sentir necessidade de mais suporte, um profissional de saúde mental pode oferecer orientações valiosas.';
      case 'Moderada':
        return 'Olá! Seu resultado indica níveis moderados de ansiedade. É natural sentir-se ansioso de vez em quando, mas é importante encontrar maneiras de gerenciar esses sentimentos para melhorar seu bem-estar. Considere explorar técnicas de meditação para ajudar a acalmar a mente e pormover a sensação de relaxamento. A cromoterapia também pode ajudar a equilibrar suas emoções, e a reflexologia podal pode aliviar a tensão e promover relaxamento. Lembre-se de que esta auto-avaliação não susbtitui um diagnóstico médico. Se você achar que a ansiedade está afetando sua vida cotidiana, não hesite em buscar a orinetaçãos d eum proffisonal de saúde mental.';
      case 'Grave':
        return 'Olá! Seu resultado indica níveis graves de ansiedade. É natural sentir-se sobrecarregado de vez em quando, mas é importante encontrar maneiras de gerenciar esses sentimentos para melhorar seu bem-estar. Considere explorar técnicas de meditação para ajudar a acalmar a mente e pormover a sensação de relaxamento. A cromoterapia também pode ajudar a equilibrar suas emoções, e a reflexologia podal pode aliviar a tensão e promover relaxamento. Lembre-se de que esta auto-avaliação não susbtitui um diagnóstico médico. Se você achar que a ansiedade está afetando sua vida cotidiana, não hesite em buscar a orinetaçãos d eum proffisonal de saúde mental.';
      case 'Muito Grave':
        return 'A ansiedade pode ser debilitante, mas existem maneiras de agir agora para encontrar mais calma e equilíbrio. Aqui estão algumas ações que podem ajudar: - Técnica de respiração diafragmática: Inspire contando até 4, segure a respiração por 4 segundos e expire contando até 4. Repita por 5 a 10 minutos.     - Prática de mindfullness: Focar no momento presente pode reduzir a ansiedade. Comece com 5 minutos de atenção plena ao o que está ao seu redor   - Exercícios físicos leves: Movimentar-se, mesmo com uma caminhada, pode ajudar a acalmar a mente e liberar a tensão acumulada.   *Se precisar comversar com alguém agora, o CVV está disponível 24h: Ligue 188 ou acesso [cvv.or.br] ou (https://wwww.cvv.org.br).*   Sua saúde mental é essencial. Busque ajuda profissional se os sintomas persistirem. Estamos aqui com você!💙';
      case 'Extremamente Severo':
        return 'A ansiedade pode ser debilitante, mas existem maneiras de agir agora para encontrar mais calma e equilíbrio. Aqui estão algumas ações que podem ajudar: - Técnica de respiração diafragmática: Inspire contando até 4, segure a respiração por 4 segundos e expire contando até 4. Repita por 5 a 10 minutos.   - Prática de mindfullness: Focar no momento presente pode reduzir a ansiedade. Comece com 5 minutos de atenção plena ao o que está ao seu redor   - Exercícios físicos leves: Movimentar-se, mesmo com uma caminhada, pode ajudar a acalmar a mente e liberar a tensão acumulada.   *Se precisar comversar com alguém agora, o CVV está disponível 24h: Ligue 188 ou acesso [cvv.or.br] ou (https://wwww.cvv.org.br).*   Sua saúde mental é essencial. Busque ajuda profissional se os sintomas persistirem. Estamos aqui com você!💙';
      default:
        return 'Não foi possível determinar seu nível de ansiedade.';
    }
  }

  String getDescriptionDepression(String level) {
    switch (level) {
      case 'Leve':
        return 'Olá! Seu resultado indica níveis leves de depressão. Sentir-se para baixo ocasionalmente é comum, mas é ótimo que você esteja atento a isso. Para gerenciar esses sentimentos, considere explorar práticas de autocuidado como meditação, atividades ao ar livre e manter uma rotina saudável. A prática de exercícios físicos leves também pode ajudar a melhorar seu humor e reduzir os sintomas. Esta autoavaliação é uma ferramenta útil, mas lembre-se de que não substitui a orientação médica. Se os sintomas persistirem, buscar apoio de um profissional de saúde mental pode ser muito útil.';
      case 'Moderada':
        return 'Olá! Seu resultado indica níveis moderados de depressão. Isso pode afetar seu bem-estar e rotina diária. É importante considerar técnicas de gestão do humor, como meditação, atividade física e praticar mindfulness. Além disso, manter-se conectado com amigos e familiares pode fornecer suporte emocional. Embora essas práticas possam ajudar, se você sentir que a depressão está impactando sua vida de forma significativa, procurar um psicólogo ou psiquiatra pode ser essencial para lidar com esses sentimentos de forma mais eficaz e promover seu bem-estar.';
      case 'Grave':
        return 'Olá! Seu resultado indica níveis graves de depressão. É comum que momentos difíceis impactem o estado emocional, mas é crucial cuidar de sua saúde mental agora. Práticas como a respiração profunda e mindfulness podem trazer algum alívio, assim como o suporte de amigos e familiares. No entanto, a orientação de um profissional de saúde mental, como psicólogo ou psiquiatra, é fundamental para enfrentar essa situação. Não hesite em buscar ajuda profissional e lembre-se de que há recursos para ajudar você a superar este momento.';
      case 'Muito Grave':
        return 'Seu resultado indica níveis muito graves de depressão. Este é um momento delicado e requer atenção especial. Práticas como mindfulness podem ajudar a aliviar o peso emocional, mas o suporte profissional de um psicólogo ou psiquiatra é altamente recomendado. Não enfrente isso sozinho. Caso precise de ajuda imediata, o CVV está disponível 24h para conversar: Ligue 188 ou acesse [cvv.org.br]. Sua saúde mental é prioridade, e procurar apoio é um passo importante para encontrar equilíbrio e bem-estar.';
      case 'Extremamente Severo':
        return 'Sua depressão está em um nível extremamente grave. Neste momento, é essencial procurar ajuda imediata de um profissional de saúde mental. Enquanto isso, práticas de autocuidado, como respiração profunda, podem oferecer algum alívio temporário. Não enfrente isso sozinho. O CVV está disponível 24h: Ligue 188 ou acesse [cvv.org.br]. Busque ajuda profissional o quanto antes, pois sua saúde mental é fundamental para o seu bem-estar. Estamos aqui para ajudar você a superar este momento difícil!';
      default:
        return 'Não foi possível determinar seu nível de depressão.';
    }
  }

  String getDescriptionStress(String level) {
    switch (level) {
      case 'Leve':
        return 'Olá! Seu resultado indica níveis leves de estresse. Isso significa que você está conseguindo gerenciar bem as pressões diárias. Manter uma rotina equilibrada, com momentos de relaxamento e práticas de autocuidado, como meditação e exercícios leves, pode ajudar a manter esse nível de bem-estar. Lembre-se de que, mesmo em momentos tranquilos, é importante continuar prestando atenção ao seu bem-estar emocional e físico para garantir que você permaneça equilibrado e saudável.';
      case 'Moderada':
        return 'Olá! Seu resultado indica níveis moderados de estresse. Isso significa que você pode estar enfrentando alguns desafios que estão impactando sua rotina. Para ajudar a aliviar a tensão, considere técnicas de relaxamento como mindfulness, exercícios físicos leves e fazer pausas regulares ao longo do dia. Práticas de autocuidado podem fazer uma grande diferença. No entanto, se você perceber que o estresse está impactando negativamente sua qualidade de vida, não hesite em buscar apoio profissional para gerenciar melhor esses sentimentos.';
      case 'Grave':
        return 'Seu resultado indica níveis graves de estresse. Quando o estresse atinge esse nível, é fundamental encontrar formas de aliviar a pressão. Considere técnicas como respiração profunda, meditação e práticas de relaxamento. Atividades físicas regulares também podem ajudar a liberar a tensão acumulada. Além disso, o acompanhamento de um psicólogo pode ser muito útil para gerenciar e reduzir o impacto do estresse em sua vida diária. Cuidar da sua saúde mental agora é essencial para garantir que o estresse não afete negativamente sua qualidade de vida.';
      case 'Muito Grave':
        return 'Seu resultado indica níveis muito graves de estresse. Nessa situação, é importante agir rapidamente para aliviar a sobrecarga. Técnicas de respiração profunda e mindfulness podem ajudar a trazer algum alívio imediato, enquanto atividades físicas leves podem auxiliar a reduzir a tensão. No entanto, o mais importante é procurar apoio profissional o quanto antes. Caso precise de suporte emocional imediato, o CVV está disponível 24h para ajudar: Ligue 188 ou acesse [cvv.org.br]. Sua saúde mental é essencial, e você não precisa enfrentar isso sozinho.';
      case 'Extremamente Severo':
        return 'Seu nível de estresse está extremamente severo, o que pode ter um impacto significativo na sua saúde física e mental. A primeira ação que você pode tomar é buscar ajuda profissional imediatamente. Enquanto isso, práticas como respiração profunda e exercícios leves podem fornecer algum alívio temporário. O CVV está disponível 24h para apoio emocional: Ligue 188 ou acesse [cvv.org.br]. Não hesite em buscar ajuda. Seu bem-estar é essencial, e há pessoas dispostas a ajudar você a encontrar equilíbrio novamente.';
      default:
        return 'Não foi possível determinar seu nível de estresse.';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Obtém os níveis
    String anxietyLevel = getLevelAnxiety(anxietyScore);
    String depressionLevel = getLevelDepression(depressionScore);
    String stressLevel = getLevelStress(stressScore);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Resultados",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: TabBar(
              indicator: BoxDecoration(
                border: Border.all(
                    color: Colors.blue.shade700,
                    width: 3), // Borda preta em volta de cada Tab
                borderRadius:
                    BorderRadius.circular(10), // Deixa as bordas arredondadas
                color: Colors.blue[300], // Cor de fundo do tab selecionado
              ),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.white, // Cor do texto da aba selecionada
              unselectedLabelColor:
                  Colors.blueGrey, // Cor do texto das abas não selecionadas
              labelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ), // Estilo do texto da aba
              unselectedLabelStyle: const TextStyle(
                fontSize: 16,
              ), // Estilo do texto das abas não selecionadas
              tabs: const [
                Tab(
                  text: 'Ansiedade',
                ),
                Tab(
                  text: 'Depressão',
                ),
                Tab(
                  text: 'Estresse',
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            _buildTabContent(
              context,
              title: anxietyLevel,
              description: getDescriptionAnxiety(anxietyLevel),
            ),
            _buildTabContent(
              context,
              title: depressionLevel,
              description: getDescriptionDepression(depressionLevel),
            ),
            _buildTabContent(
              context,
              title: stressLevel,
              description: getDescriptionStress(stressLevel),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(BuildContext context,
      {required String title, required String description}) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Center(
          child: Container(
            width: 370,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Icon(
                        Icons.bar_chart,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.green[500],
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: const TextStyle(fontSize: 16.5),
                ),
                const SizedBox(height: 50),
                GestureDetector(
                  onTap: () {
// Exemplo na sua LevelsPage (ou onde estiver o botão que leva ao UserProfile)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PicsPage(),

                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.symmetric(horizontal: 70),
                    decoration: BoxDecoration(
                      color: Colors.blue[500],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'Continuar',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
