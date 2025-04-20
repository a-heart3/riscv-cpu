#include <stdio.h>

typedef struct label{
	int lines;
	char s[10];
}label;

extern char instructions[1000][100];
extern label* labels[1000];
extern int machinecodes[1000];
extern int label_pos;
extern int instr_pos;
void file_handle(char* filepath);
int a2c();

int main(int argc, char* argv[]) {
	file_handle(argv[1]);
	a2c();

	printf("instr_pos: %d, label_pos: %d\n", instr_pos, label_pos);
	printf("This is instructions:\n");
	for(int i=0; i < instr_pos; i++) {
		printf("%s", instructions[i]);
	}
	printf("This is labels:\n");
	for(int j=0; j < label_pos; j++) {
		printf("pos: %d, label: %s", labels[j]->lines, labels[j]->s);
	}
	printf("This is machine code:\n");
	for(int i=0; i < instr_pos; i++) {
		printf("opcode: 0x%08x\n", machinecodes[i]);
	}

	return 0;
}
