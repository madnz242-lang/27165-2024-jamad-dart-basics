// Student: Jamad NZIKOU MIERE
// Reg no: 27165_2024
const String regNo = '27165';
final int d = int.parse(regNo[regNo.length - 1]);
final int t = int.parse(regNo.substring(regNo.length - 2));

int momoFee(int amount) {
  // by JNM
  if (amount <= 0) return -1;
  if (amount <= 1000) return 20;
  if (amount <= 10000) return 100;
  if (amount <= 150000) return 250;
  return 1500;
}

// F1
String formatRwf(int amount) {
  // by JNM
  bool isNegative = amount < 0;
  String digits = amount.abs().toString();
  String formatted = '';
  int count = 0;
  int i = digits.length - 1;

  while (i >= 0) {
    formatted = digits[i] + formatted;
    count++;
    if (count % 3 == 0 && i > 0) {
      formatted = ',$formatted';
    }
    i--;
  }

  if (isNegative) {
    formatted = '-$formatted';
  }
  return '$formatted RWF';
}

// F2
bool isValidPin(String pin) {
  // by JNM
  if (pin.length != 5) return false;
  if (pin == '12345') return false;

  int i = 0;
  bool allSame = true;
  while (i < pin.length) {
    int code = pin.codeUnitAt(i);
    if (code < 48 || code > 57) {
      return false; // Not an ASCII digit 0-9
    }
    if (pin[i] != pin[0]) {
      allSame = false;
    }
    i++;
  }

  if (allSame) return false;
  return true;
}

// F3
int sendMoney(int balance, int amount) {
  // by JNM
  int fee = momoFee(amount);
  if (fee == -1) {
    print('Failed: invalid amount');
    return balance;
  }
  if (amount + fee > balance) {
    print('Failed: insufficient balance');
    return balance;
  }
  int newBalance = balance - (amount + fee);
  print(
      'Sent ${formatRwf(amount)} (fee ${formatRwf(fee)}). New balance: ${formatRwf(newBalance)}');
  return newBalance;
}

// F4
int buyAirtime(int balance, int amount) {
  // by JNM
  if (amount < 100 || amount > 50000) {
    print('Failed: invalid airtime amount');
    return balance;
  }
  if (amount > balance) {
    print('Failed: insufficient balance');
    return balance;
  }
  int newBalance = balance - amount;
  print('Bought airtime ${formatRwf(amount)}. New balance: ${formatRwf(newBalance)}');
  return newBalance;
}

void main() {
  // by JNM
  print('Reg no: $regNo | D=$d | T=$t');

  // 1. Test PINs
  print('\n--- PIN Checks ---');
  print('12345: ${isValidPin('12345')}');
  print('77777: ${isValidPin('77777')}');
  print('4821: ${isValidPin('4821')}');
  print('48a21: ${isValidPin('48a21')}');
  print('4821$d: ${isValidPin('4821$d')}');

  // 2. Starting balance: 20000 + 65 * 500 = 52,500
  print('\n--- Transactions ---');
  int balance = 20000 + t * 500;
  print('Starting balance: ${formatRwf(balance)}');

  // 3. Transactions: send (5 + 1) * 3000 = 18,000 three times
  int transferAmount = (d + 1) * 3000;
  balance = sendMoney(balance, transferAmount);
  balance = sendMoney(balance, transferAmount);
  balance = sendMoney(balance, transferAmount);
  balance = buyAirtime(balance, 1000);
  balance = sendMoney(balance, 0);
  balance = sendMoney(balance, 200000);

  // 4. Final balance
  print('Final balance: ${formatRwf(balance)}');

  // 5. Custom Test Calls
  print('\n--- Extra Tests ---');
  print(formatRwf(0)); // Expected: 0 RWF
  print(formatRwf(-1000000)); // Expected: -1,000,000 RWF
  print(isValidPin('00000')); // Expected: false
  print(isValidPin('54321')); // Expected: true
  print(isValidPin(' 1234')); // Expected: false (edge case with leading space)
}
