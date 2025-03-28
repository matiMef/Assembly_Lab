#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <cstdlib>
#include <cstring>
#include <sstream>

//biblioteka potrzebna do obsługi plików wav
#include "AudioFile.h"

using namespace std;

//deklaracja funkcji asm
extern "C" void addEchoASM(int* arr, int size, float alpha, int deltaT);


int main(int argc, char* argv[]) {

	if (argc != 4) {
		cerr << "Usage: " << argv[0] << " <input file> <echo decay factor> <echo delay (seconds)>" << "\n";
		return 1;
	}

	//zmienne i argumenty
	AudioFile<int> wavFile;
	string inputFileName = argv[1];
	float decayFactor;
	float delaySeconds;

	//sprawdzanie i konwersja argumentów
	stringstream decayStream(argv[2]);
	if (!(decayStream >> decayFactor)) {
		cerr << "Invalid echo decay factor: " << argv[2] << "\n";
		return 1;
	}

	stringstream delayStream(argv[3]);
	if (!(delayStream >> delaySeconds)) {
		cerr << "Invalid echo delay: " << argv[3] << "\n";
		return 1;
	}

	ifstream inputFile(inputFileName, ios::binary);
	if (!inputFile) {
		cerr << "Error opening input file." << "\n";
		return 1;
	}

	
	if (wavFile.load(inputFileName)) {

		int samplesCount = wavFile.getNumSamplesPerChannel();
		int sampleRate = wavFile.getSampleRate();


		int timeDiff = delaySeconds * sampleRate;
		int* samplesArray = new int[samplesCount];

		//sprawdzenie specyfikacji pliku czestotliwosc probkowania/ilosc probek/obliczone delta t
		cout << "SampleRate: " << sampleRate << " SampleQuantity: " << samplesCount << " Time differnce: " << timeDiff << "\n";


		vector<vector<int>> audioData = wavFile.samples;
		for (int i = 0; i < audioData[0].size(); i++)
		{
			samplesArray[i] = audioData[0][i];
		}


		//wywołanie funkcji asm
		addEchoASM(samplesArray, samplesCount, decayFactor, timeDiff);

		for (int i = 0; i < audioData[0].size(); i++) {
			audioData[0][i] = samplesArray[i];
		}
		wavFile.samples = audioData;


		//zapis zmian do pliku
		wavFile.save(inputFileName);
	}
}
