#include <stdio.h>
#include <assert.h>
#include <string.h>
#include <stdlib.h>

typedef struct label{
	int lines;											// 标签所在的行号
	char s[10];											// 标签值
}label;

char instructions[10000][100];
label* labels[1000];
int label_pos = 0;
int instr_pos = 0;
void strip(char* s) {
	int i = 0;
	char *p = s;
	while(*p != '\0') {
		if(*p == '/') {
			*p = '\n';
			*(p+1) = '\0';
		}
		p = p + 1;
	}
}

void file_handle(char* filepath) {
	FILE* file;
	char instruction[100];

	printf("%s\n", filepath);
	file = fopen(filepath, "r");
	if(file == NULL) {
		assert(0);
	}

	// printf("file open success!\n");

	while(fgets(instruction, 100, file)) {
		// printf("%s", instruction);
		strip(instruction);
		int c = instruction[0];

		if(c == '.') {
			// 标签处理
			char* arg = strtok(instruction, ":");
			label* L = (label *)malloc(sizeof(label));
		  // printf("test instr_pos = %d\n", instr_pos);
			L -> lines = instr_pos;      // 标签实际上没有地址，记录的是标签之后第一条指令的地址
			strcpy(L->s, instruction);
			labels[label_pos] = L;
			label_pos++;
			// printf("label has benn done\n");
		}

		else {
			// 指令处理
			strcpy(instructions[instr_pos], instruction);  // 数组编号代表指令地址
			instr_pos++;
			// printf("instruction has been done.\n");
		}
	}
}
			



