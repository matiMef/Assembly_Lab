#include <iostream>
#include <string>
#include <windows.h>
using namespace std;

string num1;
char operacjaw;
string num2;
float wynik;
string wybor;

extern "C" float _stdcall Dodawanie(float num1,float num2,int wybor);
extern "C" float _stdcall Odejmowanie(float num1, float num2, int wybor);
extern "C" float _stdcall Mnozenie(float num1, float num2, int wybor);
extern "C" float _stdcall Dzielenie(float num1, float num2, int wybor);


int main(int argc, char* argv[]) {

	float num1 = atof(argv[1]);
	char operacjaw = argv[2][0];
	float num2 = atof(argv[3]);
	int wybor = stoi(argv[4]);

	switch (operacjaw){
	case '+':
		wynik = Dodawanie(num1, num2, wybor);
		cout<<wynik;
		break;

	case '-':
		wynik = Odejmowanie(num1, num2, wybor);
		cout << wynik;
		break;

	case '*':
		wynik = Mnozenie(num1, num2, wybor);
		cout << wynik;
		break;

	case '/':
		wynik = Dzielenie(num1, num2, wybor);
		cout << wynik;
		break;
	}

		

	return 0;
}
