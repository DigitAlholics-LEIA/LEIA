// lib/language_data.dart

import 'model/language_model.dart';

final List<Language> languages = [
  Language(
    name: "English",
    date: "15/12/2024",
    description: "Unidad de la PUCP dedicada a la enseñanza del inglés, portugués, quechua y español como segunda lengua...",
    cycles: "5",
    startDate: "15/12/2024",
    endDate: "15/06/2025",
    prices: ["100", "200"],
    locations: ["Lima", "Cusco", "Arequipa"],
    logos: [
      'assets/logo1.png',
      'assets/logo2.png',
      'assets/logo3.png',
      'assets/logo4.png',
    ],
  ),
  Language(
    name: "German",
    date: "15/12/2024",
    description: "Descripción del programa en alemán aquí...",
    cycles: "4",
    startDate: "01/01/2025",
    endDate: "01/07/2025",
    prices: ["150", "250"],
    locations: ["Lima", "Trujillo", "Piura"],
    logos: [
      'assets/logo5.png',
      'assets/logo6.png',
      'assets/logo7.png',
      'assets/logo8.png',
    ],
  ),
];
