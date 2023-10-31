import 'dart:math';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class homeScreenController extends GetxController {
  List<List<String>> activities = [
    [
      "Take a short morning walk to get some fresh air.",
      "Write down one thing you're looking forward to today.",
      "Listen to a guided relaxation or mindfulness podcast.",
      "Try a new hobby or craft for 15 minutes.",
      "Plan a healthy and balanced meal for the day.",
      "Read an inspiring quote or poem.",
      "Send a kind message to a friend or loved one.",
      "Practice a quick 5-minute stretching routine.",
      "Create a list of achievable daily goals.",
      "Watch a funny video or comedy show for a good laugh.",
      "Start a gratitude journal and jot down positive moments.",
      "Savor a cup of herbal tea mindfully.",
      "Call or text a friend to catch up.",
      "Do a quick decluttering task in your living space.",
      "Engage in a brief breathing exercise.",
      "Listen to uplifting music or a favorite song.",
      "Water your indoor plants or tend to your garden.",
      "Doodle or draw for a few minutes.",
      "Try a brief visualization exercise for relaxation.",
      "Practice saying positive affirmations.",
    ],
    [
      "Engage in a 20-minute yoga or stretching session.",
      "Plan a video call with a friend or family member.",
      "Read a chapter from a book you've been wanting to finish.",
      "Cook a new and healthy recipe for dinner.",
      "Write a letter to your future self.",
      "Take a longer walk in a local park or nature reserve.",
      "Explore a new podcast or audiobook.",
      "Try a 10-minute meditation for mindfulness.",
      "Join an online group related to your interests.",
      "Create a vision board with your goals and dreams.",
      "Plan a self-care evening with a bath or spa treatment.",
      "Practice a hobby you enjoy for an extended period.",
      "Write down three things you appreciate about yourself.",
      "Engage in a 30-minute workout or exercise routine.",
      "Watch an inspiring documentary or TED talk.",
      "Learn a new language or a few phrases.",
      "Reach out to someone you haven't spoken to in a while.",
      "Visit a local museum or art exhibition.",
      "Plan a day trip to a nearby town or landmark.",
      "Start a journal to document your thoughts and experiences.",
    ],
    [
      "Take a day trip to a natural landmark or hiking trail.",
      "Participate in a group meditation or mindfulness session.",
      "Set aside time for a creative project or craft.",
      "Volunteer for a local charity or community project.",
      "Join a virtual class or workshop on a topic of interest.",
      "Plan a picnic with friends or family.",
      "Write a short story or poem.",
      "Explore a new genre of books or movies.",
      "Start a fitness challenge or training program.",
      "Create a playlist of your favorite uplifting songs.",
      "Organize and declutter a room in your home.",
      "Visit a botanical garden or flower show.",
      "Try your hand at photography or take scenic photos.",
      "Plan a weekend getaway to a nearby destination.",
      "Attend a live performance or concert.",
      "Participate in a local sports or fitness event.",
      "Write a letter of appreciation to someone you care about.",
      "Take a cooking or baking class.",
      "Engage in a full-body workout or outdoor activity.",
      "Set a goal to learn a new skill or hobby.",
    ],
    [
      "Embark on a challenging hike or outdoor adventure.",
      "Participate in a multi-day fitness or wellness retreat.",
      "Seek professional help from a mental health expert.",
      "Join a support group for individuals facing similar challenges.",
      "Plan an international trip for a future adventure.",
      "Learn to play a musical instrument.",
      "Enroll in a specialized course or certification program.",
      "Host a social gathering with friends or family.",
      "Create a detailed plan for achieving a long-term goal.",
      "Start a home improvement project you've been delaying.",
      "Explore a new culture through books, cuisine, or movies.",
      "Attend a motivational or self-improvement seminar.",
      "Take up a physically demanding sport or activity.",
      "Invest time in building stronger relationships with loved ones.",
      "Volunteer for an extended period with a charity or cause.",
      "Set aside time for daily mindfulness and reflection.",
      "Engage in philanthropic activities or charity work.",
      "Seek out a mentor or coach for personal development.",
      "Participate in a challenging physical endurance event.",
      "Plan a dream vacation to a far-off destination.",
    ],
    [
      "Spend quality time with friends or family, sharing your feelings.",
      "Plan a day of relaxation at a spa or wellness center.",
      "Practice deep breathing exercises for an extended period.",
      "Create a personal mission statement or life vision.",
      "Participate in a multi-day personal development seminar.",
      "Start a charitable initiative or community project.",
      "Seek guidance from a life coach or therapist.",
      "Set aside daily meditation time for self-reflection.",
      "Write a detailed gratitude journal highlighting life's positives.",
      "Connect with a spiritual or religious community for support.",
      "Take a week-long vacation to a tranquil destination.",
      "Consider attending a mindfulness retreat for inner healing.",
      "Engage in expressive arts therapy, like art or music therapy.",
      "Participate in advanced physical fitness training or sports.",
      "Volunteer for an international humanitarian mission.",
      "Plan and execute a major home renovation project.",
      "Create a comprehensive life plan with achievable goals.",
      "Invest in ongoing therapy or counseling sessions.",
      "Seek guidance from a mentor for personal and professional growth.",
      "Set up a regular exercise routine with a personal trainer.",
    ],
    [
      "Embark on a month-long sabbatical for self-discovery.",
      "Enroll in an intensive mental health treatment program.",
      "Connect with a support network of mental health advocates.",
      "Consider inpatient care if recommended by professionals.",
      "Participate in daily therapy sessions for a period.",
      "Plan a long-term wellness and recovery journey.",
      "Practice daily mindfulness meditation for emotional balance.",
      "Create a comprehensive crisis plan for high-risk situations.",
      "Engage in advanced therapeutic interventions.",
      "Establish a strong connection with a mental health expert.",
      "Participate in a clinical research study if suitable.",
      "Explore holistic healing modalities with professionals.",
      "Involve family members in the treatment process.",
      "Set clear boundaries for self-care and emotional well-being.",
      "Create and maintain a consistent self-care routine.",
      "Consider group therapy or support groups for specific issues.",
      "Build a robust safety plan with the help of professionals.",
      "Prioritize mental health as your topmost concern.",
      "Seek second opinions and consult multiple specialists.",
      "Celebrate small victories and progress made in recovery.",
    ]
  ];

  RxInt quizScore = 0.obs;
  RxList<int> randomIndexes = <int>[].obs;
  late DateTime savedDate;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    final prefs = await SharedPreferences.getInstance();
    await getQuizScore();
    if (quizScore.value != 0) {
      final indexes = await getIndexes();
      final dateString = prefs.getString('dateSaved');

      if (dateString != null) {
        savedDate = DateTime.parse(dateString);
      } else {
        savedDate = DateTime.now().subtract(const Duration(days: 1));
      }

      if (!_isSameDate(savedDate, DateTime.now()) && indexes.isEmpty) {
        final random = Random();
        while (randomIndexes.length < 5) {
          final randomIndex = random.nextInt(20);
          if (!randomIndexes.contains(randomIndex)) {
            randomIndexes.add(randomIndex);
          }
        }
        savedDate = DateTime.now();
        await storeData();
      } else {
        randomIndexes.assignAll(indexes);
      }
    }
  }

  Future<List<int>> getIndexes() async {
    final prefs = await SharedPreferences.getInstance();
    final stringIndexes = prefs.getStringList('randomIndexes') ?? [];
    final indexes = stringIndexes.map((index) => int.parse(index)).toList();
    return indexes;
  }

  Future getQuizScore() async {
    final prefs = await SharedPreferences.getInstance();
    quizScore.value = prefs.getInt('quizScore') ?? 0;
  }

  Future<void> storeData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'randomIndexes',
      randomIndexes.map((index) => index.toString()).toList(),
    );
    await prefs.setString('dateSaved', savedDate.toIso8601String());
  }

  void removeFromList(int index) {
    randomIndexes.removeAt(index);
    storeData();
  }

  bool _isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
