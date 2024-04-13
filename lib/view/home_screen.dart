import 'package:bssc_app/controller/homecontroller.dart';
import 'package:bssc_app/model/class_menus.dart';
import 'package:bssc_app/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late FocusNode _centralExamsFocusNode;
  late FocusNode _stateExamsFocusNode;
  late FocusNode _schoolExamsFocusNode;
  bool _isDropdownOpen = false;
  final HomeController _homeController = Get.put(HomeController());
  int _selectedChipIndex = -1;
  int _selectedChipIndex2 = -1;
  List<Class>? _selectedClasses;

  @override
  void initState() {
    super.initState();
    _centralExamsFocusNode = FocusNode();
    _stateExamsFocusNode = FocusNode();
    _schoolExamsFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _centralExamsFocusNode.dispose();
    _stateExamsFocusNode.dispose();
    _schoolExamsFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Change Your Goal',
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Select Exam Type',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Select for the exam for which you want to prepare',
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 16.0),
              CustomTextField(
                  labelText: 'Central Exams',
                  hasFocus: _centralExamsFocusNode.hasFocus,
                  initialValue: 'Central Exams',
                  focusNode: _centralExamsFocusNode,
                  onFocusChange: _handleFocusChange),
              const SizedBox(height: 16.0),
              CustomTextField(
                labelText: 'State Exams',
                hasFocus: _stateExamsFocusNode.hasFocus,
                initialValue: 'State Exams',
                focusNode: _stateExamsFocusNode,
                onFocusChange: _handleFocusChange,
              ),
              const SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _schoolExamsFocusNode.requestFocus();
                      });
                    },
                    child: CustomTextField(
                      labelText: 'School Exams',
                      hasFocus: _schoolExamsFocusNode.hasFocus,
                      initialValue: 'School Exams',
                      focusNode: _schoolExamsFocusNode,
                      onFocusChange: _handleFocusChange,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  if (_schoolExamsFocusNode.hasFocus)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Select Board"),
                        const Text("Select for preparation"),
                        SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: DropdownButton<String>(
                              hint: Center(
                                  child: Text(
                                      _homeController.getSchoolList![0].name)),
                              icon:
                                  const Icon(Icons.keyboard_arrow_down_rounded),
                              iconSize: 24,
                              elevation: 16,
                              items: _homeController.getSchoolList
                                      ?.map((schoolClass) => schoolClass.name)
                                      .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList() ??
                                  [],
                              onChanged: (selectedName) {
                                setState(() {
                                  _isDropdownOpen = true;
                                  final selectedClass = _homeController
                                      .getSchoolList
                                      ?.firstWhere((schoolClass) =>
                                          schoolClass.name == selectedName);
                                  _selectedClasses = selectedClass?.classes;
                                });
                              },
                            ),
                          ),
                        ),
                        if (_selectedClasses != null) ...[
                          const SizedBox(height: 16.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Select Exam"),
                              const Text("Select for preparation"),
                              const SizedBox(
                                height: 10,
                              ),
                              Wrap(
                                spacing: 8, // Add spacing between chips
                                children: List.generate(
                                  _selectedClasses!.length,
                                  (index) {
                                    final classItem = _selectedClasses![index];
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedChipIndex = index;
                                        });
                                      },
                                      child: Chip(
                                        label: Text(classItem.name),
                                        backgroundColor:
                                            _selectedChipIndex == index
                                                ? Colors.indigo
                                                : Colors.grey[300],
                                        labelStyle: TextStyle(
                                          color: _selectedChipIndex == index
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  if (_stateExamsFocusNode.hasFocus &&
                      _homeController.getStatesList != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Select State"),
                        const Text("Select for preparation"),
                        const SizedBox(height: 16.0),
                        // Map each StateExamItem to a dropdown form field
                        for (final stateExamItem
                            in _homeController.getStatesList!.stateExamItems)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: stateExamItem.name,
                                border: OutlineInputBorder(),
                              ),
                              items: stateExamItem.classes
                                  .map((stateExamClass) =>
                                      DropdownMenuItem<String>(
                                        value: stateExamClass.name,
                                        child: Text(stateExamClass.name),
                                      ))
                                  .toList(),
                              onChanged: (selectedName) {
                                // Handle onChanged event here if needed
                              },
                            ),
                          ),
                      ],
                    ),
                  if (_centralExamsFocusNode.hasFocus)
                    Wrap(
                      spacing: 8, // Add spacing between chips
                      children: List.generate(
                        _homeController.getCentralList!.classes.length,
                        (index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedChipIndex2 = index;
                              });
                            },
                            child: Chip(
                              label: Text(_homeController
                                  .getCentralList!.classes[index].name),
                              backgroundColor: _selectedChipIndex2 == index
                                  ? Colors.indigo
                                  : Colors.grey[300],
                              labelStyle: TextStyle(
                                color: _selectedChipIndex2 == index
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.indigo,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        'Save Changes',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleFocusChange(bool isDropdownOpen) {
    if (isDropdownOpen) {
      setState(() {
        _isDropdownOpen = false;
      });
    }
  }
}
