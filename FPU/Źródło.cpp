#include <iostream>
#include <string>
#include <windows.h>
using namespace std;
string num1; //= "49301000012341";
int num2; //= 291;
int wynik;
int reszta;
string wynik2;

extern "C" void _stdcall Dziel(string * num1, int num2, int* wynik, int* reszta, int liczba1size, string * wynik2);


int main(int argc, char* argv[]) {

	//przyjêcie argumentów konsoli
	string num1 = argv[1];
	num2 = stoi(argv[2]);

	//pobranie wielkoœci liczby1
	int x = num1.size();

	//dostosowanie liczby pod kod assembler
	int liczba1size = x - 1;
	//dodanie wielkoœci do wyniku
	wynik2.resize(x);

	//wywo³anie funkcji
	Dziel(&num1, num2, &wynik, &reszta, liczba1size, &wynik2);

	//wyœwietlenie wyniku
	cout << wynik2 << endl;
	//cout << reszta;


	return 0;
}