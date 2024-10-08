import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:receipt_sharing/pages/budget_page.dart';
import 'package:receipt_sharing/pages/new_budget_page.dart';

class Budget {
  final int id;
  final String name;
  final List<String> participants;
  final double balance;
  final Icon icon;

  Budget({required this.id, required this.name, required this.participants, required this.balance, required this.icon});

  // TODO check the factory annotation here for JSON parsing
  factory Budget.fromJson(Map<String, dynamic> json) {
    return Budget(
      id: json['id'],
      name: json['name'],
      participants: json['participants'],
      balance: json['balance'],
      icon: json['icon'],
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title, required this.camera});

  final String title;

  final CameraDescription camera;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // list of all budgets and the controller for the text field
  final List<Budget> budgets = [
    Budget(id: 1, name: 'Balcony Time', participants: ['Sam', 'Aiden', 'Sandra', 'Kyle'], balance: 0.00, icon: const Icon(Icons.favorite)),
    Budget(id: 2, name: '219 Andrews', participants: ['Sam', 'Jax', 'Nate', 'Levi'], balance: 999.99, icon: const Icon(Icons.wallet)),
    Budget(id: 3, name: 'Crack Cardboard', participants: ['Sam', 'Nate', 'Kyle', 'Sandra'], balance: 25.00, icon: const Icon(Icons.favorite)),
  ];

  // TODO Implement API call to backend to fetch budgets
  void fetchBudgets() {
    
  }

  // make an api call to add a new budget w/ participants
  void addNewBudget(String name, List<String> participants, Icon icon) {
    setState(() {
      budgets.add(Budget(id: budgets.length, name: name, participants: participants, balance: 0, icon: icon));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: budgets.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: budgets[index].icon,
              title: Text(budgets[index].name),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return BudgetPage(budgetName: budgets[index].name, participants: budgets[index].participants, camera: widget.camera, balance: budgets[index].balance);
                  }),
                );
              },
              trailing: const Icon(Icons.more_vert),
            );
          }
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
            return NewBudgetPage(addNewBudget: addNewBudget);
          }));
        },
        tooltip: 'Add a new shared budget',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
