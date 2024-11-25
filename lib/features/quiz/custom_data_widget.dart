import 'package:dark_fin/core/models/questionn.dart';

// Вопросы по инвестициям (Investing)
final List<Questionn> investingQuestions = [
  Questionn(
    title: 'What is diversification in investing?',
    answers: [
      Answer(
          title: 'Spreading investments across different assets',
          isCorrect: true),
      Answer(title: 'Investing all money in one stock', isCorrect: false),
      Answer(title: 'Only investing in bonds', isCorrect: false),
      Answer(title: 'Keeping all money in cash', isCorrect: false),
    ],
  ),
  Questionn(
    title: 'What is a dividend?',
    answers: [
      Answer(
          title: 'A payment made by a company to shareholders',
          isCorrect: true),
      Answer(title: 'A type of stock market', isCorrect: false),
      Answer(title: 'An investment loss', isCorrect: false),
      Answer(title: 'A trading fee', isCorrect: false),
    ],
  ),
  Questionn(
    title: 'What is a P/E ratio?',
    answers: [
      Answer(
          title: 'Price-to-Earnings ratio, measuring company valuation',
          isCorrect: true),
      Answer(title: 'Profit and Exchange ratio', isCorrect: false),
      Answer(title: 'Personal Equity ratio', isCorrect: false),
      Answer(title: 'Public Enterprise ratio', isCorrect: false),
    ],
  ),
  Questionn(
    title: 'What is a bond?',
    answers: [
      Answer(
          title: 'A debt investment where you lend money to an entity',
          isCorrect: true),
      Answer(title: 'A type of stock', isCorrect: false),
      Answer(title: 'A savings account', isCorrect: false),
      Answer(title: 'A cryptocurrency', isCorrect: false),
    ],
  ),
  Questionn(
    title: 'What is compound interest?',
    answers: [
      Answer(
          title: 'Interest earned on both principal and accumulated interest',
          isCorrect: true),
      Answer(title: 'Interest paid only on the principal', isCorrect: false),
      Answer(title: 'A type of investment fee', isCorrect: false),
      Answer(title: 'Monthly interest payments', isCorrect: false),
    ],
  ),
  Questionn(
    title: 'What is an ETF?',
    answers: [
      Answer(
          title: 'A fund that tracks an index, sector, commodity, or asset',
          isCorrect: true),
      Answer(title: 'A type of cryptocurrency', isCorrect: false),
      Answer(title: 'Electronic Trading Format', isCorrect: false),
      Answer(title: 'Emergency Trading Fund', isCorrect: false),
    ],
  ),
  Questionn(
    title: 'What is market capitalization?',
    answers: [
      Answer(
          title: 'Total value of a company\'s outstanding shares',
          isCorrect: true),
      Answer(title: 'Company\'s yearly profit', isCorrect: false),
      Answer(title: 'Stock market maximum limit', isCorrect: false),
      Answer(title: 'Capital held in markets', isCorrect: false),
    ],
  ),
  Questionn(
    title: 'What is a mutual fund?',
    answers: [
      Answer(
          title: 'A pool of money from investors to buy securities',
          isCorrect: true),
      Answer(title: 'A personal savings account', isCorrect: false),
      Answer(title: 'A type of insurance', isCorrect: false),
      Answer(title: 'A government bond', isCorrect: false),
    ],
  ),
  Questionn(
    title: 'What is asset allocation?',
    answers: [
      Answer(
          title: 'Distribution of investments among different asset classes',
          isCorrect: true),
      Answer(title: 'Selling all assets', isCorrect: false),
      Answer(title: 'Buying only stocks', isCorrect: false),
      Answer(title: 'Trading frequency', isCorrect: false),
    ],
  ),
  Questionn(
    title: 'What is a blue-chip stock?',
    answers: [
      Answer(
          title: 'Stock of a well-established, financially sound company',
          isCorrect: true),
      Answer(title: 'A new company\'s stock', isCorrect: false),
      Answer(title: 'A penny stock', isCorrect: false),
      Answer(title: 'A type of bond', isCorrect: false),
    ],
  ),
];

// Вопросы по криптовалюте (Cryptocurrency)
final List<Questionn> cryptoQuestions = [
  Questionn(
    title: 'What is blockchain?',
    answers: [
      Answer(
          title: 'A decentralized digital ledger of transactions',
          isCorrect: true),
      Answer(title: 'A type of cryptocurrency', isCorrect: false),
      Answer(title: 'An online wallet', isCorrect: false),
      Answer(title: 'A trading platform', isCorrect: false),
    ],
  ),
  Questionn(
    title: 'What is a crypto wallet?',
    answers: [
      Answer(
          title: 'A tool to store and manage cryptocurrencies',
          isCorrect: true),
      Answer(title: 'A type of blockchain', isCorrect: false),
      Answer(title: 'A mining computer', isCorrect: false),
      Answer(title: 'A trading bot', isCorrect: false),
    ],
  ),
  Questionn(
    title: 'What is mining in cryptocurrency?',
    answers: [
      Answer(
          title: 'Process of validating transactions and creating new coins',
          isCorrect: true),
      Answer(title: 'Buying cryptocurrencies', isCorrect: false),
      Answer(title: 'Selling cryptocurrencies', isCorrect: false),
      Answer(title: 'Creating a wallet', isCorrect: false),
    ],
  ),
  Questionn(
    title: 'What is a smart contract?',
    answers: [
      Answer(
          title: 'Self-executing contract with terms written in code',
          isCorrect: true),
      Answer(title: 'A legal document', isCorrect: false),
      Answer(title: 'A type of cryptocurrency', isCorrect: false),
      Answer(title: 'A trading strategy', isCorrect: false),
    ],
  ),
  Questionn(
    title: 'What is DeFi?',
    answers: [
      Answer(
          title: 'Decentralized Finance - financial services on blockchain',
          isCorrect: true),
      Answer(title: 'Digital Finance', isCorrect: false),
      Answer(title: 'Default Finance', isCorrect: false),
      Answer(title: 'Defined Financial Index', isCorrect: false),
    ],
  ),
  Questionn(
    title: 'What is a private key?',
    answers: [
      Answer(
          title: 'Secret code that allows access to your cryptocurrency',
          isCorrect: true),
      Answer(title: 'Public wallet address', isCorrect: false),
      Answer(title: 'Trading password', isCorrect: false),
      Answer(title: 'Mining algorithm', isCorrect: false),
    ],
  ),
  Questionn(
    title: 'What is an NFT?',
    answers: [
      Answer(
          title: 'Non-Fungible Token - unique digital asset', isCorrect: true),
      Answer(title: 'New Financial Technology', isCorrect: false),
      Answer(title: 'Network Function Type', isCorrect: false),
      Answer(title: 'National Finance Trade', isCorrect: false),
    ],
  ),
  Questionn(
    title: 'What is a hard fork?',
    answers: [
      Answer(
          title: 'A radical change to a blockchain protocol', isCorrect: true),
      Answer(title: 'A mining tool', isCorrect: false),
      Answer(title: 'A type of wallet', isCorrect: false),
      Answer(title: 'A trading strategy', isCorrect: false),
    ],
  ),
  Questionn(
    title: 'What is staking?',
    answers: [
      Answer(
          title: 'Locking up crypto to support network operations',
          isCorrect: true),
      Answer(title: 'Selling cryptocurrency', isCorrect: false),
      Answer(title: 'Mining new coins', isCorrect: false),
      Answer(title: 'Trading tokens', isCorrect: false),
    ],
  ),
  Questionn(
    title: 'What is a dApp?',
    answers: [
      Answer(
          title: 'Decentralized Application running on blockchain',
          isCorrect: true),
      Answer(title: 'Digital Application', isCorrect: false),
      Answer(title: 'Download Application', isCorrect: false),
      Answer(title: 'Data Application', isCorrect: false),
    ],
  ),
];

// Вопросы по личным финансам (Personal Finance)
final List<Questionn> personalFinanceQuestions = [
  Questionn(
    title: 'What is an emergency fund?',
    answers: [
      Answer(title: 'Money saved for unexpected expenses', isCorrect: true),
      Answer(title: 'A type of investment', isCorrect: false),
      Answer(title: 'Monthly bills', isCorrect: false),
      Answer(title: 'Retirement account', isCorrect: false),
    ],
  ),
  Questionn(
    title: 'What is a credit score?',
    answers: [
      Answer(title: 'A number indicating creditworthiness', isCorrect: true),
      Answer(title: 'Bank account balance', isCorrect: false),
      Answer(title: 'Investment return', isCorrect: false),
      Answer(title: 'Savings amount', isCorrect: false),
    ],
  ),
  Questionn(
    title: 'What is a 401(k)?',
    answers: [
      Answer(
          title: 'A retirement savings plan sponsored by employers',
          isCorrect: true),
      Answer(title: 'A type of loan', isCorrect: false),
      Answer(title: 'A checking account', isCorrect: false),
      Answer(title: 'An insurance policy', isCorrect: false),
    ],
  ),
  Questionn(
    title: 'What is debt-to-income ratio?',
    answers: [
      Answer(
          title: 'Monthly debt payments divided by monthly income',
          isCorrect: true),
      Answer(title: 'Total savings divided by debt', isCorrect: false),
      Answer(title: 'Credit score calculation', isCorrect: false),
      Answer(title: 'Investment returns percentage', isCorrect: false),
    ],
  ),
  Questionn(
    title: 'What is a fixed expense?',
    answers: [
      Answer(
          title: 'Regular payment that stays the same each period',
          isCorrect: true),
      Answer(title: 'Variable cost', isCorrect: false),
      Answer(title: 'One-time payment', isCorrect: false),
      Answer(title: 'Investment loss', isCorrect: false),
    ],
  ),
  Questionn(
    title: 'What is net worth?',
    answers: [
      Answer(title: 'Total assets minus total liabilities', isCorrect: true),
      Answer(title: 'Total income', isCorrect: false),
      Answer(title: 'Monthly savings', isCorrect: false),
      Answer(title: 'Investment returns', isCorrect: false),
    ],
  ),
  Questionn(
    title: 'What is a deductible?',
    answers: [
      Answer(
          title: 'Amount paid before insurance coverage begins',
          isCorrect: true),
      Answer(title: 'Monthly premium', isCorrect: false),
      Answer(title: 'Tax return', isCorrect: false),
      Answer(title: 'Investment gain', isCorrect: false),
    ],
  ),
  Questionn(
    title: 'What is passive income?',
    answers: [
      Answer(
          title: 'Income earned with minimal active effort', isCorrect: true),
      Answer(title: 'Salary from job', isCorrect: false),
      Answer(title: 'Investment loss', isCorrect: false),
      Answer(title: 'Government benefits', isCorrect: false),
    ],
  ),
  Questionn(
    title: 'What is a tax deduction?',
    answers: [
      Answer(title: 'An expense that reduces taxable income', isCorrect: true),
      Answer(title: 'Government payment', isCorrect: false),
      Answer(title: 'Bank fee', isCorrect: false),
      Answer(title: 'Investment return', isCorrect: false),
    ],
  ),
  Questionn(
    title: 'What is compound interest?',
    answers: [
      Answer(
          title: 'Interest earned on previously earned interest',
          isCorrect: true),
      Answer(title: 'Simple interest', isCorrect: false),
      Answer(title: 'Bank fee', isCorrect: false),
      Answer(title: 'Tax rate', isCorrect: false),
    ],
  ),
];

// Вопросы по трейдингу (Trading)
final List<Questionn> tradingQuestions = [
  Questionn(
    title: 'What is a bull market?',
    answers: [
      Answer(title: 'Market characterized by rising prices', isCorrect: true),
      Answer(title: 'Market with falling prices', isCorrect: false),
      Answer(title: 'Stable market', isCorrect: false),
      Answer(title: 'Closed market', isCorrect: false),
    ],
  ),
  Questionn(
    title: 'What is day trading?',
    answers: [
      Answer(
          title: 'Buying and selling securities within same trading day',
          isCorrect: true),
      Answer(title: 'Long-term investing', isCorrect: false),
      Answer(title: 'Weekly trading', isCorrect: false),
      Answer(title: 'Monthly trading', isCorrect: false),
    ],
  ),
  Questionn(
    title: 'What is leverage in trading?',
    answers: [
      Answer(
          title: 'Using borrowed money to increase trading position',
          isCorrect: true),
      Answer(title: 'Trading profit', isCorrect: false),
      Answer(title: 'Market analysis', isCorrect: false),
      Answer(title: 'Trading fee', isCorrect: false),
    ],
  ),
  Questionn(
    title: 'What is a stop-loss order?',
    answers: [
      Answer(
          title: 'Order to sell when price reaches specified level',
          isCorrect: true),
      Answer(title: 'Buy order', isCorrect: false),
      Answer(title: 'Market order', isCorrect: false),
      Answer(title: 'Trading strategy', isCorrect: false),
    ],
  ),
  Questionn(
    title: 'What is volume in trading?',
    answers: [
      Answer(title: 'Number of shares traded during a period', isCorrect: true),
      Answer(title: 'Stock price', isCorrect: false),
      Answer(title: 'Market cap', isCorrect: false),
      Answer(title: 'Trading profit', isCorrect: false),
    ],
  ),
  Questionn(
    title: 'What is a candlestick chart?',
    answers: [
      Answer(
          title: 'Chart showing price movement with colored bars',
          isCorrect: true),
      Answer(title: 'Line graph', isCorrect: false),
      Answer(title: 'Bar chart', isCorrect: false),
      Answer(title: 'Pie chart', isCorrect: false),
    ],
  ),
];
