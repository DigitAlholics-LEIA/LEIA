import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leia/data/http_helper.dart';
import '../data/model/specialty_model.dart';
import '../data/model/institute_model.dart';

class PathView extends StatefulWidget {
  final int specialtyId;

  const PathView({Key? key, required this.specialtyId}) : super(key: key);

  @override
  State<PathView> createState() => _PathViewState();
}

class _PathViewState extends State<PathView> {
  late Future<Specialty> futureSpecialty;
  late Future<List<Institute>> futureInstitutes;
  final HttpHelper httpHelper = HttpHelper();

  @override
  void initState() {
    super.initState();
    futureSpecialty = httpHelper.getSpecialty();
    futureInstitutes = httpHelper.getInstitutionsBySpecialtyId(widget.specialtyId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<Specialty>(
        future: futureSpecialty,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data found'));
          }

          final specialty = snapshot.data!;
          final formattedStartDate = DateFormat('dd/MM/yyyy').format(specialty.startDate);
          final formattedEndDate = DateFormat('dd/MM/yyyy').format(specialty.endDate);

          return Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF3A65B7), Color(0xFF4BBAA2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Text(
                      "Specialty Details",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          Text(
                            specialty.name,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        "$formattedStartDate - $formattedEndDate",
                        style: TextStyle(fontSize: 16, color: Colors.teal),
                      ),
                      SizedBox(height: 20),
                      InstituteSection(specialtyId: widget.specialtyId),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class InstituteSection extends StatefulWidget {
  final int specialtyId;

  const InstituteSection({Key? key, required this.specialtyId}) : super(key: key);

  @override
  _InstituteSectionState createState() => _InstituteSectionState();
}

class _InstituteSectionState extends State<InstituteSection> {
  late Future<List<Institute>> futureInstitutes;
  final HttpHelper httpHelper = HttpHelper();
  int selectedInstituteIndex = 0;

  @override
  void initState() {
    super.initState();
    futureInstitutes = httpHelper.getInstitutionsBySpecialtyId(widget.specialtyId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Institute>>(
      future: futureInstitutes,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No institutes found'));
        }

        final institutes = snapshot.data!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 3,
                    color: selectedInstituteIndex == 0
                        ? Color(0xFF3A65B7)
                        : Colors.grey.shade300,
                  ),
                ),
                ...List.generate(institutes.length, (index) {
                  bool isSelected = selectedInstituteIndex == index;
                  return Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedInstituteIndex = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          padding: EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? Color(0xFF3A65B7)
                                  : Colors.grey.shade300,
                              width: isSelected ? 5 : 2,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor:
                                isSelected ? Colors.white : Colors.grey.shade200,
                            backgroundImage: AssetImage('assets/images/${institutes[index].brand}.png'),
                          ),
                        ),
                      ),
                      if (index < institutes.length - 1)
                        Container(
                          width: 30,
                          height: 3,
                          color: (isSelected || selectedInstituteIndex == index + 1)
                              ? Color(0xFF3A65B7)
                              : Colors.grey.shade300,
                        ),
                    ],
                  );
                }),
                Expanded(
                  child: Container(
                    height: 3,
                    color: selectedInstituteIndex == institutes.length - 1
                        ? Color(0xFF3A65B7)
                        : Colors.grey.shade300,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              institutes[selectedInstituteIndex].description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              "Número de Ciclos: ${institutes[selectedInstituteIndex].cycles}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Precio: ${institutes[selectedInstituteIndex].prices} USD", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Ubicación:", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("• ${institutes[selectedInstituteIndex].location}"),
            Divider(thickness: 1),
          ],
        );
      },
    );
  }
}

/*class LanguageView extends StatefulWidget {
  const LanguageView({super.key});

  @override
  State<LanguageView> createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView> {
  @override
  Widget build(BuildContext context) {
    final Specialty languageSpecialty = specialties.firstWhere(
      (specialty) => specialty.typeSpecialty == SpecialtyType.Language,
      orElse: () => Specialty(
        id: 1,
        name: 'Default Language',
        startDate: DateTime.now(),
        endDate: DateTime.now().add(Duration(days: 30)),
        typeSpecialty: SpecialtyType.Language,
      ),
    );

    // Formateo de fechas
    final formattedStartDate = DateFormat('dd/MM/yyyy').format(languageSpecialty.startDate);
    final formattedEndDate = DateFormat('dd/MM/yyyy').format(languageSpecialty.endDate);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF3A65B7), Color(0xFF4BBAA2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Text(
                  "Watch route",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Row(
                    children: [
                      Text(
                        languageSpecialty.name,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Solo mostrar el rango de fechas abajo
                  Text(
                    "$formattedStartDate - $formattedEndDate",
                    style: TextStyle(fontSize: 16, color: Colors.teal),
                  ),
                  SizedBox(height: 20),

                  InstituteSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InstituteSection extends StatefulWidget {
  @override
  _InstituteSectionState createState() => _InstituteSectionState();
}

class _InstituteSectionState extends State<InstituteSection> {
  int selectedInstituteIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Institute> institutes = getInstitutesForLanguage();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 3,
                color: selectedInstituteIndex == 0 ? Color(0xFF3A65B7) : Colors.grey.shade300,
              ),
            ),
            ...List.generate(institutes.length, (index) {
              bool isSelected = selectedInstituteIndex == index;

              return Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedInstituteIndex = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      padding: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? Color(0xFF3A65B7) : Colors.grey.shade300,
                          width: isSelected ? 5 : 2,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: isSelected ? Colors.white : Colors.grey.shade200,
                        backgroundImage: AssetImage(institutes[index].logo),
                      ),
                    ),
                  ),
                  if (index < institutes.length - 1)
                    Container(
                      width: 30,
                      height: 3,
                      color: (isSelected || selectedInstituteIndex == index + 1)
                          ? Color(0xFF3A65B7)
                          : Colors.grey.shade300,
                    ),
                ],
              );
            }),
            Expanded(
              child: Container(
                height: 3,
                color: selectedInstituteIndex == institutes.length - 1
                    ? Color(0xFF3A65B7)
                    : Colors.grey.shade300,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        if (institutes.isNotEmpty) ...[
          Text(
            institutes[selectedInstituteIndex].description,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            "Número de Ciclos: ${institutes[selectedInstituteIndex].cycles}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text("Precios:", style: TextStyle(fontWeight: FontWeight.bold)),
          ...institutes[selectedInstituteIndex].prices.map((price) => Text("• $price")).toList(),
          SizedBox(height: 10),
          Text("Locations:", style: TextStyle(fontWeight: FontWeight.bold)),
          ...institutes[selectedInstituteIndex].locations.map((location) => Text("• $location")).toList(),
        ],
        Divider(thickness: 1),
      ],
    );
  }

  List<Institute> getInstitutesForLanguage() {
    return institutes;
  }
}*/
