import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ChecklistItem {
  final String title;
  final String description;
  bool isChecked;

  ChecklistItem({
    required this.title,
    required this.description,
    this.isChecked = false,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'isChecked': isChecked,
      };

  factory ChecklistItem.fromJson(Map<String, dynamic> json) => ChecklistItem(
        title: json['title'],
        description: json['description'],
        isChecked: json['isChecked'],
      );
}

class ChecklistSection {
  final String title;
  final List<ChecklistItem> items;

  ChecklistSection({
    required this.title,
    required this.items,
  });
}

class FinanceChecklist extends StatefulWidget {
  const FinanceChecklist({super.key});

  @override
  State<FinanceChecklist> createState() => _FinanceChecklistState();
}

class _FinanceChecklistState extends State<FinanceChecklist> {
  final List<ChecklistSection> sections = [
    ChecklistSection(
      title: 'Basic Finance',
      items: [
        ChecklistItem(
            title: 'Create a budget',
            description: 'Determine monthly income and categorize expenses.'),
        ChecklistItem(
          title: 'Track expenses',
          description:
              'Install an app or create a spreadsheet to track spending',
        ),
        ChecklistItem(
          title: 'Emergency Fund',
          description:
              'Accumulate 3-6 months worth of expenses for emergencies',
        ),
        ChecklistItem(
          title: 'Financial Goals',
          description: 'Determine short-term and long-term financial goals',
        ),
      ],
    ),
    ChecklistSection(
      title: 'Savings and Investments',
      items: [
        ChecklistItem(
          title: 'Automatic Savings',
          description:
              'Set up automatic transfers of a portion of your income to a savings account',
        ),
        ChecklistItem(
          title: 'Diversification',
          description:
              'Allocate investments among different assets (stocks, bonds, real estate)',
        ),
        ChecklistItem(
          title: 'Pension savings',
          description: 'Start saving for retirement through the right tools',
        ),
        ChecklistItem(
          title: 'Explore Markets',
          description:
              'Regularly explore financial markets and new opportunities',
        ),
      ],
    ),
    ChecklistSection(
      title: 'Cost Optimization',
      items: [
        ChecklistItem(
          title: 'Subscription Audit',
          description:
              'Check and cancel unnecessary recurring payments and subscriptions',
        ),
        ChecklistItem(
          title: 'Rate Comparison',
          description: 'Find the best deals on utilities and communications',
        ),
        ChecklistItem(
          title: 'Loyalty Programs',
          description: 'Use cashback and rewards programs to save money',
        ),
        ChecklistItem(
          title: 'Tax Optimization',
          description:
              'Explore opportunities to legally minimize your tax payments',
        ),
      ],
    ),
    ChecklistSection(
      title: 'Asset Protection',
      items: [
        ChecklistItem(
          title: 'Insurance',
          description:
              'Take out the necessary insurance policies (life, health, property)',
        ),
        ChecklistItem(
          title: 'Cybersecurity',
          description:
              'Protect your financial accounts with strong passwords and 2FA',
        ),
        ChecklistItem(
          title: 'Legal Defense',
          description:
              'Prepare important legal documents to protect your assets',
        ),
        ChecklistItem(
          title: 'Account Monitoring',
          description:
              'Regularly check statements and transactions for suspicious activity',
        ),
      ],
    ),
    ChecklistSection(
      title: 'Financial Education',
      items: [
        ChecklistItem(
          title: 'Books and courses',
          description: 'Read books and take courses on financial literacy',
        ),
        ChecklistItem(
          title: 'Financial Advisor',
          description:
              'Consider consulting with a professional financial advisor',
        ),
        ChecklistItem(
          title: 'News and analytics',
          description: 'Follow financial news and analysis',
        ),
        ChecklistItem(
          title: 'Community',
          description: 'Join groups and forums on financial topics',
        ),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadCheckedStates();
  }

  Future<void> _loadCheckedStates() async {
    final prefs = await SharedPreferences.getInstance();
    final savedStates = prefs.getString('finance_checklist_states');

    if (savedStates != null) {
      final decodedStates = json.decode(savedStates) as Map<String, dynamic>;

      setState(() {
        for (var section in sections) {
          for (var item in section.items) {
            final key = '${section.title}_${item.title}';
            if (decodedStates.containsKey(key)) {
              item.isChecked = decodedStates[key];
            }
          }
        }
      });
    }
  }

  Future<void> _saveCheckedStates() async {
    final prefs = await SharedPreferences.getInstance();
    final states = <String, bool>{};

    for (var section in sections) {
      for (var item in section.items) {
        final key = '${section.title}_${item.title}';
        states[key] = item.isChecked;
      }
    }

    await prefs.setString('finance_checklist_states', json.encode(states));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181818),
      appBar: CupertinoNavigationBar(
        backgroundColor: const Color(0xFF222222),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context),
          child: const Icon(
            CupertinoIcons.back,
            color: Colors.white,
          ),
        ),
        middle: const Text(
          'Checklist',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children:
                sections.map((section) => _buildSection(section)).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(ChecklistSection section) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF222222),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              section.title,
              style: const TextStyle(
                color: Color(0xffFEDB35),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...section.items.map((item) => _buildChecklistItem(section, item)),
        ],
      ),
    );
  }

  Widget _buildChecklistItem(ChecklistSection section, ChecklistItem item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: CheckboxListTile(
        title: Text(
          item.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          item.description,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
          ),
        ),
        value: item.isChecked,
        onChanged: (bool? value) {
          setState(() {
            item.isChecked = value ?? false;
          });
          _saveCheckedStates();
        },
        checkColor: Colors.white,
        activeColor: const Color(0xffFEDB35),
        checkboxShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}
