class Questionn {
  Questionn({
    required this.title,
    required this.answers,
  });

  final String title;
  final List<Answer> answers;
}

class Answer {
  Answer({
    required this.title,
    required this.isCorrect,
  });

  final String title;
  final bool isCorrect;
}

final defaultAnswer = Answer(
  title: '',
  isCorrect: false,
);

List<Questionn> questionsList = [
  Questionn(
    title: "What is the primary purpose of a budget?",
    answers: [
      Answer(title: "To track expenses", isCorrect: false),
      Answer(title: "To plan income and expenses", isCorrect: true),
      Answer(title: "To calculate taxes", isCorrect: false),
      Answer(title: "To invest in stocks", isCorrect: false),
    ],
  ),
  Questionn(
    title: "Which type of account typically offers the highest interest rate?",
    answers: [
      Answer(title: "Savings account", isCorrect: false),
      Answer(title: "Current account", isCorrect: false),
      Answer(title: "Fixed deposit account", isCorrect: true),
      Answer(title: "Checking account", isCorrect: false),
    ],
  ),
  Questionn(
    title: "What does ROI stand for in finance?",
    answers: [
      Answer(title: "Rate of Investment", isCorrect: false),
      Answer(title: "Return on Investment", isCorrect: true),
      Answer(title: "Revenue on Income", isCorrect: false),
      Answer(title: "Ratio of Income", isCorrect: false),
    ],
  ),
  Questionn(
    title: "Which is an example of a fixed expense?",
    answers: [
      Answer(title: "Electricity bill", isCorrect: false),
      Answer(title: "Rent", isCorrect: true),
      Answer(title: "Grocery shopping", isCorrect: false),
      Answer(title: "Entertainment", isCorrect: false),
    ],
  ),
  Questionn(
    title: "What is a stock?",
    answers: [
      Answer(title: "A type of bond", isCorrect: false),
      Answer(title: "A share in a company's ownership", isCorrect: true),
      Answer(title: "A fixed deposit", isCorrect: false),
      Answer(title: "A mutual fund", isCorrect: false),
    ],
  ),
  Questionn(
    title: "What does 'liquidity' refer to in finance?",
    answers: [
      Answer(title: "The ability to pay debts", isCorrect: false),
      Answer(title: "The ease of converting assets into cash", isCorrect: true),
      Answer(title: "The level of market risk", isCorrect: false),
      Answer(title: "The value of an investment", isCorrect: false),
    ],
  ),
  Questionn(
    title: "What is the primary goal of investing?",
    answers: [
      Answer(title: "To save money", isCorrect: false),
      Answer(title: "To grow wealth over time", isCorrect: true),
      Answer(title: "To avoid taxes", isCorrect: false),
      Answer(title: "To reduce expenses", isCorrect: false),
    ],
  ),
  Questionn(
    title: "What is the term for money borrowed from a lender?",
    answers: [
      Answer(title: "Deposit", isCorrect: false),
      Answer(title: "Loan", isCorrect: true),
      Answer(title: "Equity", isCorrect: false),
      Answer(title: "Revenue", isCorrect: false),
    ],
  ),
  Questionn(
    title: "Which type of investment is considered the safest?",
    answers: [
      Answer(title: "Stocks", isCorrect: false),
      Answer(title: "Government bonds", isCorrect: true),
      Answer(title: "Real estate", isCorrect: false),
      Answer(title: "Cryptocurrency", isCorrect: false),
    ],
  ),
  Questionn(
    title: "What is the primary purpose of insurance?",
    answers: [
      Answer(title: "To maximize profits", isCorrect: false),
      Answer(title: "To protect against financial loss", isCorrect: true),
      Answer(title: "To save on taxes", isCorrect: false),
      Answer(title: "To increase income", isCorrect: false),
    ],
  ),
  Questionn(
    title: "What is a credit score?",
    answers: [
      Answer(title: "A measure of income", isCorrect: false),
      Answer(title: "A number representing creditworthiness", isCorrect: true),
      Answer(title: "The amount of debt owed", isCorrect: false),
      Answer(title: "The interest rate on a loan", isCorrect: false),
    ],
  ),
  Questionn(
    title: "What is compound interest?",
    answers: [
      Answer(
          title: "Interest calculated only on the initial principal",
          isCorrect: false),
      Answer(
          title:
              "Interest calculated on the initial principal and accrued interest",
          isCorrect: true),
      Answer(title: "Interest added monthly", isCorrect: false),
      Answer(title: "A fixed interest rate", isCorrect: false),
    ],
  ),
  Questionn(
    title: "What is diversification in investing?",
    answers: [
      Answer(title: "Investing in a single asset", isCorrect: false),
      Answer(
          title: "Spreading investments across different assets",
          isCorrect: true),
      Answer(title: "Avoiding risky investments", isCorrect: false),
      Answer(title: "Investing only in real estate", isCorrect: false),
    ],
  ),
  Questionn(
    title: "What does a balance sheet show?",
    answers: [
      Answer(title: "A company's income and expenses", isCorrect: false),
      Answer(
          title: "A company's assets, liabilities, and equity",
          isCorrect: true),
      Answer(title: "Only a company's revenue", isCorrect: false),
      Answer(title: "Future projections of profits", isCorrect: false),
    ],
  ),
  Questionn(
    title: "What is the term for the money a company earns before expenses?",
    answers: [
      Answer(title: "Revenue", isCorrect: true),
      Answer(title: "Profit", isCorrect: false),
      Answer(title: "Net income", isCorrect: false),
      Answer(title: "Expense", isCorrect: false),
    ],
  ),
  Questionn(
    title: "Which of the following is an example of an asset?",
    answers: [
      Answer(title: "Bank loan", isCorrect: false),
      Answer(title: "Cash", isCorrect: true),
      Answer(title: "Taxes owed", isCorrect: false),
      Answer(title: "Credit card debt", isCorrect: false),
    ],
  ),
  Questionn(
    title: "What is inflation?",
    answers: [
      Answer(title: "A decrease in prices over time", isCorrect: false),
      Answer(
          title: "An increase in the general level of prices over time",
          isCorrect: true),
      Answer(title: "The cost of borrowing money", isCorrect: false),
      Answer(title: "The interest rate on a loan", isCorrect: false),
    ],
  ),
  Questionn(
    title: "What does 'net worth' represent?",
    answers: [
      Answer(title: "Income minus taxes", isCorrect: false),
      Answer(title: "Assets minus liabilities", isCorrect: true),
      Answer(title: "Total earnings in a year", isCorrect: false),
      Answer(title: "Gross income", isCorrect: false),
    ],
  ),
  Questionn(
    title: "Which of the following is a liability?",
    answers: [
      Answer(title: "Cash", isCorrect: false),
      Answer(title: "Mortgages", isCorrect: true),
      Answer(title: "Investments", isCorrect: false),
      Answer(title: "Properties", isCorrect: false),
    ],
  ),
  Questionn(
    title: "What is a mutual fund?",
    answers: [
      Answer(title: "An individual stock investment", isCorrect: false),
      Answer(
          title: "A pool of funds collected from investors", isCorrect: true),
      Answer(title: "A type of savings account", isCorrect: false),
      Answer(title: "A government loan", isCorrect: false),
    ],
  ),
];
