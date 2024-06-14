# Aplicativo de Rotina de Treinos - Documentação

## Sumário
1 - Descrição do Projeto
2 - Estrutura do Diretório
3 - Modelos de Dados
4 - Arquitetura do Aplicativo
5 - Especificações das Telas

## Descrição do Projeto
Nome do Projeto: Gym Routine App

Descrição: O Gym Routine App é um aplicativo móvel desenvolvido com Flutter que permite aos usuários criar, gerenciar e acompanhar suas rotinas de treino na academia. O aplicativo inclui funcionalidades para anotar treinos, monitorar o desempenho, definir metas e visualizar estatísticas de progresso.

Objetivo: Facilitar a organização e monitoramento das rotinas de treino dos usuários, proporcionando uma experiência intuitiva e motivadora.

## Estrutura do Diretório
```
gym_routine_app/
├── android/
├── ios/
├── lib/
│   ├── models/
│   │   ├── exercise.dart
│   │   ├── goal.dart
│   │   └── workout.dart
│   ├── providers/
│   │   └── workouts_provider.dart
│   ├── screens/
│   │   ├── home_screen.dart
│   │   ├── workout_detail_screen.dart
│   │   ├── add_edit_workout_screen.dart
│   │   └── goals_screen.dart
│   ├── services/
│   │   └── workout_service.dart
│   ├── utils/
│   │   └── date_formatter.dart
│   ├── widgets/
│   │   ├── workout_item.dart
│   │   └── exercise_item.dart
│   └── main.dart
├── test/
├── pubspec.yaml
└── README.md
```

## Modelos de Dados
### Workout (Treino)
Representa um treino com uma lista de exercícios.
```
dart
Copiar código
class Workout {
  String id;
  String name;
  List<Exercise> exercises;
  DateTime date;

  Workout({
    required this.id,
    required this.name,
    required this.exercises,
    required this.date,
  });
}
```

### Exercise (Exercício)
Representa um exercício individual dentro de um treino.

```
dart
Copiar código
class Exercise {
  String id;
  String name;
  int sets;
  int reps;
  double weight;

  Exercise({
    required this.id,
    required this.name,
    required this.sets,
    required this.reps,
    required this.weight,
  });
}
```

### Goal (Meta)
Representa uma meta definida pelo usuário.

```
dart
Copiar código
class Goal {
  String id;
  String description;
  DateTime targetDate;
  bool achieved;

  Goal({
    required this.id,
    required this.description,
    required this.targetDate,
    this.achieved = false,
  });
}
```

## Arquitetura do Aplicativo

O Gym Routine App utiliza a arquitetura baseada em Provider para gerenciamento de estado, com uma separação clara entre modelos de dados, lógica de negócios e a interface do usuário.

- Models (Modelos): Contêm as definições de dados.
- Providers (Gerenciamento de Estado): Contêm a lógica de negócios e gerenciamento de estado.
- Screens (Telas): Contêm a interface do usuário.
- Services (Serviços): Contêm a lógica de interação com APIs e banco de dados.
- Utils (Utilitários): Contêm funções auxiliares e formatações.

### Especificações das Telas
#### Tela Inicial (HomeScreen)

Descrição: Exibe uma lista de treinos agendados e um botão para adicionar novos treinos.

#### Componentes:

- AppBar com título "Gym Routine".
- ListView com itens de treino.
- FloatingActionButton para adicionar novos treinos.

#### Eventos:

- Tap em um item de treino navega para a tela de detalhes do treino.
- Tap no FloatingActionButton navega para a tela de adicionar/editar treino.

#### Tela de Detalhes do Treino (WorkoutDetailScreen)
Descrição: Exibe os detalhes de um treino específico, incluindo a lista de exercícios.

#### Componentes:

- AppBar com o nome do treino.
- ListView com itens de exercício.

#### Eventos:

- Tap em um item de exercício pode abrir um diálogo para editar o exercício.

#### Tela de Adicionar/Editar Treino (AddEditWorkoutScreen)
Descrição: Formulário para adicionar ou editar um treino.

#### Componentes:

- TextFields para nome do treino e data.
- ListView para adicionar/excluir/editar exercícios.
- Botões para salvar ou cancelar.

#### Eventos:

- Tap no botão salvar valida e salva os dados do treino.
- Tap no botão cancelar descarta as alterações.

#### Tela de Metas (GoalsScreen)
Descrição: Exibe a lista de metas definidas pelo usuário.

#### Componentes:

- AppBar com título "Metas".
- ListView com itens de meta.
- FloatingActionButton para adicionar nova meta.

#### Eventos:

- Tap em um item de meta pode abrir um diálogo para editar a meta.
- Tap no FloatingActionButton navega para a tela de adicionar/editar meta.

Essa documentação inicial cobre a descrição do projeto, a estrutura do diretório, a definição dos modelos de dados, a arquitetura do aplicativo e as especificações das principais telas. Com essa base, podemos começar a programar as funcionalidades do aplicativo.