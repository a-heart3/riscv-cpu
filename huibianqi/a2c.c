#include <stdio.h>
#include <string.h>
#include <assert.h>

typedef struct label{
	int lines;
	char s[10];
}label;

extern char instructions[10000][100];
extern label* labels[1000];
extern int label_pos;
extern int instr_pos;

int machinecodes[10000];

static struct {
	char* name;
	int reg;
} regs [] = {
	{ "r0", 0 }, { "r1", 1 }, { "r2", 2 }, { "r3", 3 },
	{ "r4", 4 }, { "r5", 5 }, { "r6", 6 }, { "r7", 7 },
	{ "r8", 8 }, { "r9", 9 }, { "r10", 10 }, { "r11", 11 },
	{ "r12", 12 }, { "r13", 13 }, { "r14", 14 }, { "r15", 15 },
	{ "r16", 16 }, { "r17", 17 }, { "r18", 18 }, { "r19", 19 },
	{ "r20", 20 }, { "r21", 21 }, { "r22", 22 }, { "r23", 23 },
	{ "r24", 24 }, { "r25", 25 }, { "r26", 26 }, { "r27", 27 },
	{ "r28", 28 }, { "r29", 29 }, { "r30", 30 }, { "r31", 31 },
};


static struct {
	char* name;
	int opcode;
} types [] = {
	{ "Rtype", 0x33 }, { "Itype", 0x13 }, { "sw", 0x23 }, { "lw", 0x03 },
	{ "Btype", 0x63 }, { "jalr", 0x67 }, { "jal", 0x6f }, { "lui", 0x37 },
};

static struct {
	char* name;
	int func3;
	int func7;
} rtypes[] = {
	{ "add", 0, 0 }, { "sub", 0, 32 }, { "sll", 1, 0 }, { "slt", 2, 0 },
	{ "sltu", 3, 0 }, { "xor", 4, 0 }, { "srl", 5, 0 }, { "sra", 5, 32 },
	{ "or", 6, 0 }, { "and", 7, 0 }
};

static struct {
	char* name;
	int func3;
} itypes[] = {
	{ "addi", 0 }, { "slti", 2 }, { "sltiu", 3 }, { "xori", 4 },
	{ "ori", 6 }, { "andi", 7 }, { "slli", 1 }, { "srli", 5 },
	{ "srai", 5 },
};

static struct btype{
	char* name;
	int func3;
} btypes[] = {
	{ "beq", 0 }, { "bne", 1 }, { "blt", 4 }, { "bge", 5 }, { "bltu", 6 }, { "bgeu", 7 },
};

int ntype = 8;
int nrtype = 10;
int nitype = 9;
int nbtype = 6;

int in_rtypes(char* op) {
	for(int i=0; i<nrtype; i++) {
		if(!strcmp(op, rtypes[i].name)) {
			return 1;
		}
	}
	return 0;
}

int in_itypes(char* op) {
	for(int i=0; i<nitype; i++) {
		if(!strcmp(op, itypes[i].name)) {
			return 1;
		}
	}
	return 0;
}

int in_btypes(char* op) {
	for(int i=0; i<nbtype; i++) {
		if(!strcmp(op, btypes[i].name)) {
			return 1;
		}
	}
	return 0;
}

/* type */
char *instr_type(char* op) {
	if (in_rtypes(op)) {
		return "Rtype";
	}
	if (in_itypes(op)) {
		return "Itype";
	}
	if (in_btypes(op)) {
		return "Btype";
	}
	return op;
}

/* opcode */
int code_opcode(char* type) {
	for(int i=0; i<ntype; i++) {
		if(!strcmp(type, types[i].name)) {
			return types[i].opcode;
		}
	}
	assert(0);
}

/* reg number */
int regnum(char* regname) {
	// // printf("test regname is %s\n", regname);
	for(int i=0; i<32; i++) {
		if(!strcmp(regname, regs[i].name)) {
			return regs[i].reg;
		}
	}
	assert(0);
}

/* Rtype decode */
void rtype_codes(char* op, char* arguments, int* instr_func7, int* instr_rs2, int* instr_rs1, int* instr_func3, int* instr_rd) {
	int is_rtype = 0;

	for(int i=0; i<nrtype; i++) {
		if(!strcmp(op, rtypes[i].name)) {
			*instr_func3 = rtypes[i].func3;
			*instr_func7 = rtypes[i].func7;
			is_rtype = 1;
			break;
		}
	}

	if(!is_rtype) {
		assert(0);
	}

	char *arg1 = strtok(arguments, ",");
	char *arg2 = strtok(NULL, ",");
	arg2 = arg2 + 1;     // 去掉arg2多出的空格
	char *arg3 = strtok(NULL, " ");
	printf("test arg3 is %s\n", arg3);
	printf("test arg2 is %s\n", arg2);
	// // printf("test arg1 is %s\n", arg1);

	*instr_rs2 = regnum(arg1);
	*instr_rs1 = regnum(arg2);
	*instr_rd  = regnum(arg3);
	
}

/* Itype decode */
void itype_codes(char* op, char* arguments, int* instr_func7, int* instr_rs2, int* instr_rs1, int* instr_func3, int* instr_rd) {
	int is_itype = 0;
	
	for(int i=0; i<nitype; i++) {
		if(!strcmp(op, itypes[i].name)) {
			*instr_func3 = itypes[i].func3;
			is_itype = 1;
			break;
		}
	}

	if(!is_itype) {
		assert(0);
	}

	int fc7rs2 = 0;
	char *arg1 = strtok(arguments, ",");
	char *arg2 = strtok(NULL, ",");
	arg2 = arg2 + 1;
	char *arg3 = strtok(NULL, " ");
	// // printf("test itype arg3 is %s\n", arg3);
	// // printf("test itype arg2 is %s\n", arg2);
	// // printf("test itype arg1 is %s\n", arg1);

	sscanf(arg1, "%d", &fc7rs2);
	*instr_func7 = fc7rs2 >> 5;
	if(!strcmp(op, "slli")) {
		*instr_func7 = 0;
	}
	else if(!strcmp(op, "srli")) {
		*instr_func7 = 0;
	}
	else if(!strcmp(op, "srai")) {
		*instr_func7 = 32;
	}
	*instr_rs2 = fc7rs2 & 0x1f;
	*instr_rs1 = regnum(arg2);
	*instr_rd = regnum(arg3);
}

/* sw type decode */
void swtype_codes(char* arguments, int* instr_func7, int* instr_rs2, int* instr_rs1, int*instr_func3, int* instr_rd) {
	*instr_func3 = 2;

	char *arg1 = strtok(arguments, ",");
	char *arg2 = strtok(NULL, " ");

	char *imme = strtok(arg2, "(");
	char *reg_rs1 = strtok(NULL, ")");
	// // printf("test sw type arg1 is %s\n", arg1);
	// // printf("test sw type imme is %s\n", imme);
	// // printf("test sw type reg_rs2 is %s\n", reg_rs2);

	int imme_num = 0;
	sscanf(imme, "%d", &imme_num);
	*instr_func7 = imme_num >> 5;
	*instr_rd = imme_num & 0x1f;
	*instr_rs1 = regnum(reg_rs1);

	*instr_rs2 = regnum(arg1);
}

/* lw type decode */
void lwtype_codes(char* arguments, int* instr_func7, int* instr_rs2, int* instr_rs1, int*instr_func3, int* instr_rd) {
	*instr_func3 = 2;

	char *arg1 = strtok(arguments, ",");
	char *arg2 = strtok(NULL, " ");

	char *imme = strtok(arg1, "(");
	char *reg_rs1 = strtok(NULL, ")");
	printf("test lw type arg1 is %s\n", arg1);
	printf("test lw type imme is %s\n", imme);
	printf("test lw type reg_rs1 is %s\n", reg_rs1);

	int imme_num = 0;
	sscanf(imme, "%d", &imme_num);
	*instr_func7 = imme_num >> 5;
	*instr_rs2 = imme_num & 0x1f;
	*instr_rs1 = regnum(reg_rs1);

	*instr_rd = regnum(arg2);
}

/* lui type decode */
void luitype_codes(char* arguments, int* instr_func7, int* instr_rs2, int* instr_rs1, int* instr_func3, int* instr_rd) {
	char *arg1 = strtok(arguments, ",");
	char *arg2 = strtok(NULL, " ");
	unsigned int imme_num = 0;
	// // printf("test lui type arg1 is %s\n", arg1);
	// // printf("test lui type arg2 is %s\n", arg2);

	sscanf(arg1, "%x", &imme_num);
	*instr_func7 = imme_num >> 25;
	*instr_rs2 = (imme_num >> 20) & 0x1f;
	*instr_rs1 = (imme_num >> 15) & 0x1f;
	*instr_func3 = (imme_num >> 12) & 0x3;
	*instr_rd = regnum(arg2);
}

/* btype decode */
void btype_codes(char* op, char* arguments, int* instr_func7, int* instr_rs2, int* instr_rs1, int* instr_func3, int* instr_rd, int pos) {
	int is_btype = 0;
	for(int i=0; i<nbtype; i++) {
		if(!strcmp(op, btypes[i].name)) {
			*instr_func3 = btypes[i].func3;
			is_btype = 1;
			break;
		}
	}

	if(!is_btype) {
		assert(0);
	}

	char *arg1 = strtok(arguments, ",");
	char *arg2 = strtok(NULL, ",");
	arg2 = arg2 + 1;									// 去掉arg2多出的空格
	char *arg3 = strtok(NULL, " ");
	// // printf("test btype arg3 is %s\n", arg3);
	// // printf("test btype arg2 is %s\n", arg2);
	// // printf("test btype arg1 is %s\n", arg1);

	*instr_rs2 = regnum(arg1);
	*instr_rs1 = regnum(arg2);

	int branch_pos = 0;
	int is_label = 0;
	for(int i=0; i<label_pos; i++) {
		// printf("test loop\n");
		// printf("label is %s\n", labels[i]->s);
		// printf("label is %s\n", arg3);
		if(!strcmp(arg3, labels[i]->s)) {
				branch_pos = labels[i]->lines;
				// printf("%s\n", labels[i]->s);
				is_label = 1;
				break;
		}
	}
	if(!is_label) {
		assert(0);
	}

	/* 这里为了适应vivado当前的让ram形式做了改变，只需要记录offset即可
	 * 后续修改ram形式需要更改代码
	 */
	int offset = branch_pos - (pos + 1);
	// // printf("the branch address is %d\n", offset);
	offset = offset & (0x00000fff);
	*instr_func7 = ((offset >> 5) & 0x40) | ((offset >> 4) & 0x3f);
	*instr_rd = ((offset & 0xf) << 1) | ((offset >> 10) & 1);

}

/* jalr type decode
 *	 与 lw 指令的解码过程完全相同
 */
void jalrtype_codes(char* arguments, int* instr_func7, int* instr_rs2, int* instr_rs1, int* instr_func3, int* instr_rd) {
	*instr_func3 = 0;

	char *arg1 = strtok(arguments, ",");
	char *arg2 = strtok(NULL, " ");

	char *imme = strtok(arg1, "(");
	char *reg_rs1 = strtok(NULL, ")");
	// printf("test jalr type arg1 is %s\n", arg1);
	// printf("test jalr type imme is %s\n", imme);
	// printf("test jalr type reg_rs1 is %s\n", reg_rs1);

	int imme_num = 0;
	sscanf(imme, "%d", &imme_num);
	*instr_func7 = imme_num >> 5;
	*instr_rs2 = imme_num & 0x1f;
	*instr_rs1 = regnum(reg_rs1);

	*instr_rd = regnum(arg2);

}

/* jal type decodec */
void jaltype_codes(char* arguments, int* instr_func7, int* instr_rs2, int* instr_rs1, int* instr_func3, int* instr_rd, int pos) {
	char* arg1 = strtok(arguments, ",");
	char* arg2 = strtok(NULL, " ");
	// printf("test jal type arg1 is %s\n", arg1);
	// printf("test jal type arg2 is %s\n", arg2);

	*instr_rd = regnum(arg1);

	int is_label = 0;
	int branch_pos = 0;
	for(int i=0; i<label_pos; i++) {
		// printf("jal test loop\n");
		// printf("jal label is %s\n", labels[i]->s);
		// printf("jal label is %s\n", arg2);
		if(!strcmp(arg2, labels[i]->s)) {
				branch_pos = labels[i]->lines;
				// printf("%s\n", labels[i]->s);
				is_label = 1;
				break;
		}
	}
	if(!is_label) {
		assert(0);
	}

	int address = branch_pos - (pos + 1);
	// printf("jal address is %d\n", address);
	address = address & 0xfffff;
	*instr_func7 = ((address >> 13) & 0x40) | ((address >> 4) & 0x3f);
	*instr_rs2 = ((address & 0xf) << 1) | ((address >> 10) & 1);
	*instr_rs1 = (address >> 14) & 0x1f;
	*instr_func3 = (address >> 11) & 7;
}

int machinecode(char* str, int pos) {
	char instr[100];
	strcpy(instr, str);
	//char* instr = str;
	char* instr_end = instr + strlen(instr) - 1;
	char* instr_start = instr;
	*instr_end = '\0';
	char* op = strtok(instr, " ");
	char* arguments = instr_start + strlen(op) + 1;
	char* type = instr_type(op);
	
	int instr_opcode = code_opcode(type);	
	int instr_func7 = 0;
	int instr_rs2 = 0;
	int instr_rs1 = 0;
	int instr_func3 = 0;
	int instr_rd = 0;

	if(instr_opcode == 0x33) {
		rtype_codes(op, arguments, &instr_func7, &instr_rs2, &instr_rs1, &instr_func3, &instr_rd);
	}
	else if(instr_opcode == 0x13) {
		itype_codes(op, arguments, &instr_func7, &instr_rs2, &instr_rs1, &instr_func3, &instr_rd);
	}
	else if(instr_opcode == 0x23) {
		swtype_codes(arguments, &instr_func7, &instr_rs2, &instr_rs1, &instr_func3, &instr_rd);
	}
	else if(instr_opcode == 0x03) {
		lwtype_codes(arguments, &instr_func7, &instr_rs2, &instr_rs1, &instr_func3, &instr_rd);
	}
	else if(instr_opcode == 0x37) {
		luitype_codes(arguments, &instr_func7, &instr_rs2, &instr_rs1, &instr_func3, &instr_rd);
	}
	else if(instr_opcode == 0x63) {
		btype_codes(op, arguments, &instr_func7, &instr_rs2, &instr_rs1, &instr_func3, &instr_rd, pos);
	}
	else if(instr_opcode == 0x67) {
		jalrtype_codes(arguments, &instr_func7, &instr_rs2, &instr_rs1, &instr_func3, &instr_rd);
	}
	else if(instr_opcode == 0x6f) {
		jaltype_codes(arguments, &instr_func7, &instr_rs2, &instr_rs1, &instr_func3, &instr_rd, pos);
	}
	int result = instr_opcode | (instr_rd<<7) | (instr_func3<<12) | (instr_rs1<<15) | (instr_rs2<<20) | (instr_func7<<25);
	return result;
	
}

int a2c() {
	int i;
	for(i=0; i<instr_pos; i++) {
		char* str = instructions[i];
		int code = machinecode(str, i);
		machinecodes[i] = code;
	}
}
