" Vim syntax file
" Language:	Microsoft Macro Assembler (80x86)
" Orig Author:	Rob Brady <robb@datatone.com>
" Maintainer:	Wu Yongwei <wuyongwei@gmail.com>
" Last Change:	$Date: 2008/08/09 17:43:19 $
" $Revision: 1.10 $

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case ignore


syn match masmIdentifier	"[@a-z_$?][@a-z0-9_$?]*"
syn match masmLabel		"^\s*[@a-z_$?][@a-z0-9_$?]*:"he=e-1

syn match masmDecimal		"[-+]\?\d\+[dt]\?"
syn match masmBinary		"[-+]\?[0-1]\+[by]"  "put this before hex or 0bfh dies!
syn match masmOctal		"[-+]\?[0-7]\+[oq]"
syn match masmHexadecimal	"[-+]\?[0-9]\x*h"
syn match masmFloatRaw		"[-+]\?[0-9]\x*r"
syn match masmFloat		"[-+]\?\d\+\.\(\d*\(E[-+]\?\d\+\)\?\)\?"

syn match masmComment		";.*" contains=@Spell
syn region masmComment		start=+COMMENT\s*\z(\S\)+ end=+\z1.*+ contains=@Spell
syn region masmString		start=+'+ end=+'+ oneline contains=@Spell
syn region masmString		start=+"+ end=+"+ oneline contains=@Spell

syn region masmTitleArea	start=+\<TITLE\s+lc=5 start=+\<SUBTITLE\s+lc=8 start=+\<SUBTTL\s+lc=6 end=+$+ end=+;+me=e-1 contains=masmTitle
syn region masmTextArea		start=+\<NAME\s+lc=4 start=+\<INCLUDE\s+lc=7 start=+\<INCLUDELIB\s+lc=10 end=+$+ end=+;+me=e-1 contains=masmText
syn match masmTitle		"[^\t ;]\([^;]*[^\t ;]\)\?" contained contains=@Spell
syn match masmText		"[^\t ;]\([^;]*[^\t ;]\)\?" contained

syn region masmOptionOpt	start=+\<OPTION\s+lc=6 end=+$+ end=+;+me=e-1 contains=masmOption
syn region masmContextOpt	start=+\<PUSHCONTEXT\s+lc=11 start=+\<POPCONTEXT\s+lc=10 end=+$+ end=+;+me=e-1 contains=masmOption
syn region masmModelOpt		start=+\.MODEL\s+lc=6 end=+$+ end=+;+me=e-1 contains=masmOption,masmType
syn region masmSegmentOpt	start=+\<SEGMENT\s+lc=7 end=+$+ end=+;+me=e-1 contains=masmOption,masmString
syn region masmProcOpt		start=+\<PROC\s+lc=4 end=+$+ end=+;+me=e-1 contains=masmOption,masmType,masmRegister,masmIdentifier
syn region masmAssumeOpt	start=+\<ASSUME\s+lc=6 end=+$+ end=+;+me=e-1 contains=masmOption,masmOperator,masmType,masmRegister,masmIdentifier
syn region masmExpression	start=+\.IF\s+lc=3 start=+\.WHILE\s+lc=6 start=+\.UNTIL\s+lc=6 start=+\<IF\s+lc=2 start=+\<IF2\s+lc=3 start=+\<ELSEIF\s+lc=6 start=+\<ELSEIF2\s+lc=7 start=+\<REPEAT\s+lc=6 start=+\<WHILE\s+lc=5 end=+$+ end=+;+me=e-1 contains=masmType,masmOperator,masmRegister,masmIdentifier,masmDecimal,masmBinary,masmHexadecimal,masmFloatRaw,masmString

syn keyword masmOption		TINY SMALL COMPACT MEDIUM LARGE HUGE contained
syn keyword masmOption		NEARSTACK FARSTACK contained
syn keyword masmOption		PUBLIC PRIVATE STACK COMMON MEMORY AT contained
syn keyword masmOption		BYTE WORD DWORD PARA PAGE contained
syn keyword masmOption		USE16 USE32 FLAT contained
syn keyword masmOption		INFO READ WRITE EXECUTE SHARED contained
syn keyword masmOption		NOPAGE NOCACHE DISCARD contained
syn keyword masmOption		READONLY USES FRAME contained
syn keyword masmOption		CASEMAP DOTNAME NODOTNAME EMULATOR contained
syn keyword masmOption		NOEMULATOR EPILOGUE EXPR16 EXPR32 contained
syn keyword masmOption		LANGUAGE LJMP NOLJMP M510 NOM510 contained
syn keyword masmOption		NOKEYWORD NOSIGNEXTEND OFFSET contained
syn keyword masmOption		OLDMACROS NOOLDMACROS OLDSTRUCTS contained
syn keyword masmOption		NOOLDSTRUCTS PROC PROLOGUE READONLY contained
syn keyword masmOption		NOREADONLY SCOPED NOSCOPED SEGMENT contained
syn keyword masmOption		SETIF2 contained
syn keyword masmOption		ABS ALL ASSUMES CPU ERROR EXPORT contained
syn keyword masmOption		FORCEFRAME LISTING LOADDS NONE contained
syn keyword masmOption		NONUNIQUE NOTHING OS_DOS RADIX REQ contained
syn keyword masmType		STDCALL SYSCALL C BASIC FORTRAN PASCAL
syn keyword masmType		PTR NEAR FAR NEAR16 FAR16 NEAR32 FAR32
syn keyword masmType		REAL4 REAL8 REAL10 BYTE SBYTE TBYTE
syn keyword masmType		WORD DWORD QWORD FWORD SWORD SDWORD
syn keyword masmOperator	AND NOT OR SHL SHR XOR MOD DUP
syn keyword masmOperator	EQ GE GT LE LT NE
syn keyword masmOperator	LROFFSET SEG LENGTH LENGTHOF SIZE SIZEOF
syn keyword masmOperator	CODEPTR DATAPTR FAR NEAR SHORT THIS TYPE
syn keyword masmOperator	HIGH HIGHWORD LOW LOWWORD OPATTR MASK WIDTH
syn match   masmOperator	"OFFSET\(\sFLAT:\)\?"
syn match   masmOperator	".TYPE\>"
syn match   masmOperator	"CARRY?"
syn match   masmOperator	"OVERFLOW?"
syn match   masmOperator	"PARITY?"
syn match   masmOperator	"SIGN?"
syn match   masmOperator	"ZERO?"
syn keyword masmDirective	ALIAS ASSUME CATSTR COMM DB DD DF DOSSEG DQ DT
syn keyword masmDirective	DW ECHO ELSE ELSEIF ELSEIF1 ELSEIF2 ELSEIFB
syn keyword masmDirective	ELSEIFDEF ELSEIFDIF ELSEIFDIFI ELSEIFE
syn keyword masmDirective	ELSEIFIDN ELSEIFIDNI ELSEIFNB ELSEIFNDEF END
syn keyword masmDirective	ENDIF ENDM ENDP ENDS EQU EVEN EXITM EXTERN
syn keyword masmDirective	EXTERNDEF EXTRN FOR FORC GOTO GROUP IF IF1 IF2
syn keyword masmDirective	IFB IFDEF IFDIF IFDIFI IFE IFIDN IFIDNI IFNB
syn keyword masmDirective	IFNDEF INCLUDE INCLUDELIB INSTR INVOKE IRP
syn keyword masmDirective	IRPC LABEL LOCAL MACRO NAME OPTION ORG PAGE
syn keyword masmDirective	POPCONTEXT PROC PROTO PUBLIC PURGE PUSHCONTEXT
syn keyword masmDirective	RECORD REPEAT REPT SEGMENT SIZESTR STRUC
syn keyword masmDirective	STRUCT SUBSTR SUBTITLE SUBTTL TEXTEQU TITLE
syn keyword masmDirective	TYPEDEF UNION WHILE
syn match   masmDirective	"\.8086\>"
syn match   masmDirective	"\.8087\>"
syn match   masmDirective	"\.NO87\>"
syn match   masmDirective	"\.186\>"
syn match   masmDirective	"\.286\>"
syn match   masmDirective	"\.286C\>"
syn match   masmDirective	"\.286P\>"
syn match   masmDirective	"\.287\>"
syn match   masmDirective	"\.386\>"
syn match   masmDirective	"\.386C\>"
syn match   masmDirective	"\.386P\>"
syn match   masmDirective	"\.387\>"
syn match   masmDirective	"\.486\>"
syn match   masmDirective	"\.486P\>"
syn match   masmDirective	"\.586\>"
syn match   masmDirective	"\.586P\>"
syn match   masmDirective	"\.686\>"
syn match   masmDirective	"\.686P\>"
syn match   masmDirective	"\.K3D\>"
syn match   masmDirective	"\.MMX\>"
syn match   masmDirective	"\.XMM\>"
syn match   masmDirective	"\.ALPHA\>"
syn match   masmDirective	"\.DOSSEG\>"
syn match   masmDirective	"\.SEQ\>"
syn match   masmDirective	"\.CODE\>"
syn match   masmDirective	"\.CONST\>"
syn match   masmDirective	"\.DATA\>"
syn match   masmDirective	"\.DATA?"
syn match   masmDirective	"\.EXIT\>"
syn match   masmDirective	"\.FARDATA\>"
syn match   masmDirective	"\.FARDATA?"
syn match   masmDirective	"\.MODEL\>"
syn match   masmDirective	"\.STACK\>"
syn match   masmDirective	"\.STARTUP\>"
syn match   masmDirective	"\.IF\>"
syn match   masmDirective	"\.ELSE\>"
syn match   masmDirective	"\.ELSEIF\>"
syn match   masmDirective	"\.ENDIF\>"
syn match   masmDirective	"\.REPEAT\>"
syn match   masmDirective	"\.UNTIL\>"
syn match   masmDirective	"\.UNTILCXZ\>"
syn match   masmDirective	"\.WHILE\>"
syn match   masmDirective	"\.ENDW\>"
syn match   masmDirective	"\.BREAK\>"
syn match   masmDirective	"\.CONTINUE\>"
syn match   masmDirective	"\.ERR\>"
syn match   masmDirective	"\.ERR1\>"
syn match   masmDirective	"\.ERR2\>"
syn match   masmDirective	"\.ERRB\>"
syn match   masmDirective	"\.ERRDEF\>"
syn match   masmDirective	"\.ERRDIF\>"
syn match   masmDirective	"\.ERRDIFI\>"
syn match   masmDirective	"\.ERRE\>"
syn match   masmDirective	"\.ERRIDN\>"
syn match   masmDirective	"\.ERRIDNI\>"
syn match   masmDirective	"\.ERRNB\>"
syn match   masmDirective	"\.ERRNDEF\>"
syn match   masmDirective	"\.ERRNZ\>"
syn match   masmDirective	"\.LALL\>"
syn match   masmDirective	"\.SALL\>"
syn match   masmDirective	"\.XALL\>"
syn match   masmDirective	"\.LFCOND\>"
syn match   masmDirective	"\.SFCOND\>"
syn match   masmDirective	"\.TFCOND\>"
syn match   masmDirective	"\.CREF\>"
syn match   masmDirective	"\.NOCREF\>"
syn match   masmDirective	"\.XCREF\>"
syn match   masmDirective	"\.LIST\>"
syn match   masmDirective	"\.NOLIST\>"
syn match   masmDirective	"\.XLIST\>"
syn match   masmDirective	"\.LISTALL\>"
syn match   masmDirective	"\.LISTIF\>"
syn match   masmDirective	"\.NOLISTIF\>"
syn match   masmDirective	"\.LISTMACRO\>"
syn match   masmDirective	"\.NOLISTMACRO\>"
syn match   masmDirective	"\.LISTMACROALL\>"
syn match   masmDirective	"\.FPO\>"
syn match   masmDirective	"\.RADIX\>"
syn match   masmDirective	"\.SAFESEH\>"
syn match   masmDirective	"%OUT\>"
syn match   masmDirective	"ALIGN\>"
syn match   masmOption		"ALIGN([0-9]\+)"

syn keyword masmRegister	AX BX CX DX SI DI BP SP
syn keyword masmRegister	CS DS SS ES FS GS
syn keyword masmRegister	AH BH CH DH AL BL CL DL
syn keyword masmRegister	EAX EBX ECX EDX ESI EDI EBP ESP
syn keyword masmRegister	CR0 CR2 CR3 CR4
syn keyword masmRegister	DR0 DR1 DR2 DR3 DR6 DR7
syn keyword masmRegister	TR3 TR4 TR5 TR6 TR7
syn match   masmRegister	"ST([0-7])"


" Instruction prefixes
syn keyword masmOpcode		LOCK REP REPE REPNE REPNZ REPZ

" 8086/8088 opcodes
syn keyword masmOpcode		AAA AAD AAM AAS ADC ADD AND CALL CBW CLC CLD
syn keyword masmOpcode		CLI CMC CMP CMPS CMPSB CMPSW CWD DAA DAS DEC
syn keyword masmOpcode		DIV ESC HLT IDIV IMUL IN INC INT INTO IRET
syn keyword masmOpcode		JCXZ JMP LAHF LDS LEA LES LODS LODSB LODSW
syn keyword masmOpcode		LOOP LOOPE LOOPEW LOOPNE LOOPNEW LOOPNZ
syn keyword masmOpcode		LOOPNZW LOOPW LOOPZ LOOPZW MOV MOVS MOVSB
syn keyword masmOpcode		MOVSW MUL NEG NOP NOT OR OUT POP POPF PUSH
syn keyword masmOpcode		PUSHF RCL RCR RET RETF RETN ROL ROR SAHF SAL
syn keyword masmOpcode		SAR SBB SCAS SCASB SCASW SHL SHR STC STD STI
syn keyword masmOpcode		STOS STOSB STOSW SUB TEST WAIT XCHG XLAT XLATB
syn keyword masmOpcode		XOR
syn match   masmOpcode	      "J\(P[EO]\|\(N\?\([ABGL]E\?\|[CEOPSZ]\)\)\)\>"

" 80186 opcodes
syn keyword masmOpcode		BOUND ENTER INS INSB INSW LEAVE OUTS OUTSB
syn keyword masmOpcode		OUTSW POPA PUSHA PUSHW

" 80286 opcodes
syn keyword masmOpcode		ARPL LAR LSL SGDT SIDT SLDT SMSW STR VERR VERW

" 80286/80386 privileged opcodes
syn keyword masmOpcode		CLTS LGDT LIDT LLDT LMSW LTR

" 80386 opcodes
syn keyword masmOpcode		BSF BSR BT BTC BTR BTS CDQ CMPSD CWDE INSD
syn keyword masmOpcode		IRETD IRETDF IRETF JECXZ LFS LGS LODSD LOOPD
syn keyword masmOpcode		LOOPED LOOPNED LOOPNZD LOOPZD LSS MOVSD MOVSX
syn keyword masmOpcode		MOVZX OUTSD POPAD POPFD PUSHAD PUSHD PUSHFD
syn keyword masmOpcode		SCASD SHLD SHRD STOSD
syn match   masmOpcode	    "SET\(P[EO]\|\(N\?\([ABGL]E\?\|[CEOPSZ]\)\)\)\>"

" 80486 opcodes
syn keyword masmOpcode		BSWAP CMPXCHG INVD INVLPG WBINVD XADD

" Floating-point opcodes as of 487
syn keyword masmOpFloat		F2XM1 FABS FADD FADDP FBLD FBSTP FCHS FCLEX
syn keyword masmOpFloat		FNCLEX FCOM FCOMP FCOMPP FCOS FDECSTP FDISI
syn keyword masmOpFloat		FNDISI FDIV FDIVP FDIVR FDIVRP FENI FNENI
syn keyword masmOpFloat		FFREE FIADD FICOM FICOMP FIDIV FIDIVR FILD
syn keyword masmOpFloat		FIMUL FINCSTP FINIT FNINIT FIST FISTP FISUB
syn keyword masmOpFloat		FISUBR FLD FLDCW FLDENV FLDLG2 FLDLN2 FLDL2E
syn keyword masmOpFloat		FLDL2T FLDPI FLDZ FLD1 FMUL FMULP FNOP FPATAN
syn keyword masmOpFloat		FPREM FPREM1 FPTAN FRNDINT FRSTOR FSAVE FNSAVE
syn keyword masmOpFloat		FSCALE FSETPM FSIN FSINCOS FSQRT FST FSTCW
syn keyword masmOpFloat		FNSTCW FSTENV FNSTENV FSTP FSTSW FNSTSW FSUB
syn keyword masmOpFloat		FSUBP FSUBR FSUBRP FTST FUCOM FUCOMP FUCOMPP
syn keyword masmOpFloat		FWAIT FXAM FXCH FXTRACT FYL2X FYL2XP1

" Floating-point opcodes in Pentium and later processors
syn keyword masmOpFloat		FCMOVE FCMOVNE FCMOVB FCMOVBE FCMOVNB FCMOVNBE
syn keyword masmOpFloat		FCMOVU FCMOVNU FCOMI FUCOMI FCOMIP FUCOMIP
syn keyword masmOpFloat		FXSAVE FXRSTOR

" MMX opcodes (Pentium w/ MMX, Pentium II, and later)
syn keyword masmOpcode		MOVD MOVQ PACKSSWB PACKSSDW PACKUSWB
syn keyword masmOpcode		PUNPCKHBW PUNPCKHWD PUNPCKHDQ
syn keyword masmOpcode		PUNPCKLBW PUNPCKLWD PUNPCKLDQ
syn keyword masmOpcode		PADDB PADDW PADDD PADDSB PADDSW PADDUSB PADDUSW
syn keyword masmOpcode		PSUBB PSUBW PSUBD PSUBSB PSUBSW PSUBUSB PSUBUSW
syn keyword masmOpcode		PMULHW PMULLW PMADDWD
syn keyword masmOpcode		PCMPEQB PCMPEQW PCMPEQD PCMPGTB PCMPGTW PCMPGTD
syn keyword masmOpcode		PAND PANDN POR PXOR
syn keyword masmOpcode		PSLLW PSLLD PSLLQ PSRLW PSRLD PSRLQ PSRAW PSRAD
syn keyword masmOpcode		EMMS

" SSE opcodes (Pentium III and later)
syn keyword masmOpcode		MOVAPS MOVUPS MOVHPS MOVHLPS MOVLPS MOVLHPS
syn keyword masmOpcode		MOVMSKPS MOVSS
syn keyword masmOpcode		ADDPS ADDSS SUBPS SUBSS MULPS MULSS DIVPS DIVSS
syn keyword masmOpcode		RCPPS RCPSS SQRTPS SQRTSS RSQRTPS RSQRTSS
syn keyword masmOpcode		MAXPS MAXSS MINPS MINSS
syn keyword masmOpcode		CMPPS CMPSS COMISS UCOMISS
syn keyword masmOpcode		ANDPS ANDNPS ORPS XORPS
syn keyword masmOpcode		SHUFPS UNPCKHPS UNPCKLPS
syn keyword masmOpcode		CVTPI2PS CVTSI2SS CVTPS2PI CVTTPS2PI
syn keyword masmOpcode		CVTSS2SI CVTTSS2SI
syn keyword masmOpcode		LDMXCSR STMXCSR
syn keyword masmOpcode		PAVGB PAVGW PEXTRW PINSRW PMAXUB PMAXSW
syn keyword masmOpcode		PMINUB PMINSW PMOVMSKB PMULHUW PSADBW PSHUFW
syn keyword masmOpcode		MASKMOVQ MOVNTQ MOVNTPS SFENCE
syn keyword masmOpcode		PREFETCHT0 PREFETCHT1 PREFETCHT2 PREFETCHNTA

" SSE2 opcodes (Pentium 4 and later)
syn keyword masmOpcode		MOVAPD MOVUPD MOVHPD MOVLPD MOVMSKPD MOVSD
syn keyword masmOpcode		ADDPD ADDSD SUBPD SUBSD MULPD MULSD DIVPD DIVSD
syn keyword masmOpcode		SQRTPD SQRTSD MAXPD MAXSD MINPD MINSD
syn keyword masmOpcode		ANDPD ANDNPD ORPD XORPD
syn keyword masmOpcode		CMPPD CMPSD COMISD UCOMISD
syn keyword masmOpcode		SHUFPD UNPCKHPD UNPCKLPD
syn keyword masmOpcode		CVTPD2PI CVTTPD2PI CVTPI2PD CVTPD2DQ
syn keyword masmOpcode		CVTTPD2DQ CVTDQ2PD CVTPS2PD CVTPD2PS
syn keyword masmOpcode		CVTSS2SD CVTSD2SS CVTSD2SI CVTTSD2SI CVTSI2SD
syn keyword masmOpcode		CVTDQ2PS CVTPS2DQ CVTTPS2DQ
syn keyword masmOpcode		MOVDQA MOVDQU MOVQ2DQ MOVDQ2Q PMULUDQ
syn keyword masmOpcode		PADDQ PSUBQ PSHUFLW PSHUFHW PSHUFD
syn keyword masmOpcode		PSLLDQ PSRLDQ PUNPCKHQDQ PUNPCKLQDQ
syn keyword masmOpcode		CLFLUSH LFENCE MFENCE PAUSE MASKMOVDQU
syn keyword masmOpcode		MOVNTPD MOVNTDQ MOVNTI

" SSE3 opcodes (Pentium 4 w/ Hyper-Threading and later)
syn keyword masmOpcode		FISTTP LDDQU ADDSUBPS ADDSUBPD
syn keyword masmOpcode		HADDPS HSUBPS HADDPD HSUBPD
syn keyword masmOpcode		MOVSHDUP MOVSLDUP MOVDDUP MONITOR MWAIT

" Other opcodes in Pentium and later processors
syn keyword masmOpcode		CMPXCHG8B CPUID UD2
syn keyword masmOpcode		RSM RDMSR WRMSR RDPMC RDTSC SYSENTER SYSEXIT
syn match   masmOpcode	   "CMOV\(P[EO]\|\(N\?\([ABGL]E\?\|[CEOPSZ]\)\)\)\>"


" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_masm_syntax_inits")
  if version < 508
    let did_masm_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  " The default methods for highlighting.  Can be overridden later
  HiLink masmLabel	PreProc
  HiLink masmComment	Comment
  HiLink masmDirective	Statement
  HiLink masmType	Type
  HiLink masmOperator	Type
  HiLink masmOption	Special
  HiLink masmRegister	Special
  HiLink masmString	String
  HiLink masmText	String
  HiLink masmTitle	Title
  HiLink masmOpcode	Statement
  HiLink masmOpFloat	Statement

  HiLink masmHexadecimal Number
  HiLink masmDecimal	Number
  HiLink masmOctal	Number
  HiLink masmBinary	Number
  HiLink masmFloatRaw	Number
  HiLink masmFloat	Number

  HiLink masmIdentifier Identifier

  syntax sync minlines=50

  delcommand HiLink
endif

let b:current_syntax = "masm"

" vim: ts=8
