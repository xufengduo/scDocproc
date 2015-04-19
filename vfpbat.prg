*****************************************************************
** 文件名  :      vfpbat
** 版    本:      Version 0.1
** 版本信息：     2015/04/23  创建V0.1
***************************END***********************************


*************基础配置设置***********
*打开调试模式
#define       DEDUG          0
*打开执行报告模式
#define       REPORTMODE     1 
*设置配置文件路径
#define       CFGDB          "c:\Users\eland\Desktop\mycfgdb1.dbf"
*设置执行默认路径
#define       DEFALUTPATH    "c:\Users\eland\Desktop"
#define       NEWLINE        CHR(13) + CHR(10)
#define       MMDD           SUBSTR(DTOC(DATE()),1,2) + SUBSTR(DTOC(DATE()),4,2)
#define       YYYYMMDD       "20" + SUBSTR(DTOC(DATE()),7,2) + SUBSTR(DTOC(DATE()),1,2) + SUBSTR(DTOC(DATE()),4,2)

#define       PRGNAME        '报告文件:'
#define       PRGDIR         '程序目录:'
#define       EXCTIME        '执行时间:'
#define       CFGNOTEXIT     '配置文件不存在'
#define       CFGINFO        '读取配置数据信息..............'
#define       MAXARRAYLEN    100
#define       DBCOLMNNU      10
*************基础配置设置***********


*************环境变量设置***********
SET ECHO OFF
SET TALK OFF
SET SAFETY OFF
SET EXCLUSIVE OFF
*SET COMPATIBLE ON 
*************环境变量设置END*********


*************清理内存数据*************
CLEAR 
*************清理内存数据END**********


*************设置默认路径***************
SET DEFAULT TO DEFALUTPATH

?PrgDebug("默认路径:",DEFALUTPATH, 1)
*************设置默认路径END************


*****获取系统时间YYYYMMDD用于创建目录*****
m_date = DTOC(DATE(),1)

?PrgDebug("当前日期",m_date, 1)

PUBLIC cFileName as Character
PUBLIC mdd as String
IF MONTH(DATE()) <10
	mdd= SUBSTR(DTOC(DATE()),2,1) + SUBSTR(DTOC(DATE()),4,2)
ELSE
	mdd= CHR(MONTH(DATE() + 55)) + SUBSTR(DTOC(DATE()),4,2)
ENDIF 

?PrgDebug("三位日期",mdd , 1)
*****获取系统时间YYYYMMDD用于创建目录*****



**********************执行报告输出文件*******************
PUBLIC m_rpname as Character
PUBLIC m_rpfilename as Character
m_rpname = m_date + '.txt'
m_rpfilename = sys(5)+sys(2003)+'\' + m_rpname
m_spaces = '        '

excinfo= PRGDIR + m_spaces + sys(5)+sys(2003)+'\' + m_spaces + m_spaces + m_spaces + EXCTIME + m_spaces + DTOC(DATE()) + NEWLINE 
reportfile = NEWLINE + PRGNAME + m_spaces +m_rpname + NEWLINE

?PrgDebug("文件名称",m_rpname, 1)
?PrgDebug("文件目录",m_rpfilename , 1)
?PrgDebug("执行信息",excinfo, 1)
?PrgDebug("报告名称",reportfile, 1)

STRTOFILE(reportfile ,m_rpfilename,1)
STRTOFILE(excinfo,m_rpfilename ,1)    
**********************执行报告输出文件END*******************


**********************执行创建相关目录*********************
Dimension  m_mkdir(MAXARRAYLEN)

IF FILE(CFGDB)
	SELECT * from CFGDB INTO  ARRAY m_mkdir WHERE flags = 1
ELSE

ENDIF 

lens = ALEN(m_mkdir)/DBCOLMNNU

?PrgDebug("创建目录",m_mkdir, 1)
IF DEDUG = 0
		DISPLAY MEMORY LIKE m_mkdir
ENDIF 

?PrgDebug("目录个数",lens , 1)

PUBLIC kfile  as Character

SET DEFAULT TO "d:\qssj"

FOR i = 1 TO lens  IN m_mkdir
	*IF FILE(m_aArray2(i,8))
   	   kfile = m_mkdir(i,7)+'\'+ m_date
   	   X=Adir(m_atrr,kfile ,'D') 
   	   ?PrgDebug("需创建的目录",kfile , 1)
   	   ?PrgDebug("是否存在？ 1表示不存在 0表示存在",X , 1)
       IF X=0 
	      md &kfile 
	    ELSE
	      
	  ENDIF 
ENDFOR 
*md c:\zxxt\&m_date
**********************执行创建相关目录END*******************


*!xcopy d:\show2003\show2003.dbf  c:\zrxt\&m_date /y
**********************执行创建相关目录*********************


**********************执行拷贝相关文件*********************
SET DEFAULT TO DEFALUTPATH
Dimension  m_cpydir(MAXARRAYLEN)

IF FILE(CFGDB)
	SELECT * from CFGDB INTO  ARRAY m_cpydir WHERE flags = 2
ELSE

ENDIF 

?PrgDebug("需拷贝的目录",m_cpydir, 1)
IF DEDUG = 0
		DISPLAY MEMORY LIKE m_cpydir
ENDIF 


len2 = ALEN(m_cpydir)/DBCOLMNNU 
SET DEFAULT TO c:\

?PrgDebug("需拷贝目录个数",len2 , 1)

FOR i = 1 TO len2 IN m_cpydir
	*IF FILE(m_aArray2(i,8))
	cfile = m_cpydir(i,7)+'\'+ m_cpydir(i,6)
	dfile = m_cpydir(i,8)+'\'+m_date+'\'+m_cpydir(i,6)
	 
    ?PrgDebug("源目录",cfile , 1)
    ?PrgDebug("目标目录",dfile , 1)
       	 IF FILE(cfile)
	     	*!XCOPY FILE  &cfile TO &dfile /y
	     *ELSE
	     *COPY TO &dfile
	     COPY FILE  &cfile TO &dfile 
	    ?PrgDebug("拷贝源目录",cfile , 1)
    	?PrgDebug("拷贝目标目录",dfile , 1)
	     ENDIF 
ENDFOR 

*cFileName ="d:\qssj\zqjsxx." +mdd
**DISPLAY MEMORY LIKE cFileName
*!xcopy &cFileName c:\zrxt\&m_date\zqjsxx.dbf /y
*COPY FILE  &cFileName  TO c:\zrxt\&m_date\zqjsxx.dbf

**********************执行拷贝相关文件END*********************


**********************执行数据筛选*********************
DIMENSION m_aArray(10)
DIMENSION m_aArray2(MAXARRAYLEN)
PUBLIC cnt as Integer
cnt = 0
m_aArray(1) = 1
m_aArray(2) = 2
m_aArray(3) = 3
m_aArray(4) = 4
m_aArray(5) = 5
m_aArray(6) = 6
m_aArray(7) = 7
m_aArray(8) = 8
m_aArray(9) = 9
m_aArray(10) = 10

?PrgDebug("工作区域数组",m_aArray, 1)
IF DEDUG = 0
	DISPLAY MEMORY LIKE m_aArray
ENDIF 


IF FILE(CFGDB)
	m_cfi =  NEWLINE + CFGINFO 
    STRTOFILE(m_cfi ,m_rpfilename ,1)
	SELECT * from CFGDB INTO  ARRAY m_aArray2 WHERE flags = 3
ELSE
		IF REPORTMODE = 1
		    m_cfgne = NEWLINE + CFGNOTEXIT 
			STRTOFILE(m_cfgne,m_rpfilename ,1) 
		ENDIF 
ENDIF 

PUBLIC SZ as Integer

SZ = ALEN(m_aArray2) / DBCOLMNNU 

?PrgDebug("工作计数",cnt, 1)
?PrgDebug("筛选处理",m_aArray2, 1)
IF DEDUG = 0
	DISPLAY MEMORY LIKE m_aArray2
ENDIF 
?PrgDebug("筛选处理个数",SZ, 1)

SET DEFAULT to d:\qssj

PUBLIC fname as Character

FOR i = 1 TO SZ IN m_aArray2
    fname = m_aArray2(i,2)+ YYYYMMDD +'.dbf'
    ?PrgDebug("筛选处理文件名",fname, 1)
	IF FILE(fname)
   	    IF NOT USED(fname)   
        	cnt = cnt + 1
       	    use &fname IN m_aArray(cnt)
       	    ?PrgDebug("筛选工作计数",cnt, 1)
       	    ?PrgDebug("筛选工作区域",m_aArray(cnt), 1)
    	ENDIF
		cFileName =m_aArray2(i,5) + '\' +  mmdd +m_aArray2(i,6) 
		COPY TO &cFileName for gg = m_aArray2(i,3)
		?PrgDebug("筛选工作件拷贝路径",cFileName, 1)
		@13,20 say "Done"
	ELSE
		@17,20 say "Not Done"
	ENDIF 
	
ENDFOR 
CLOSE TABLES

**********************执行数据筛选END*********************

*打开调试模式
FUNCTION PrgDebug
	LPARAMETERS mTextinfo, mContexts, mDebugmode
	IF mDebugmode = 1
	   ?mTextinfo 
	   ?mContexts 
	ENDIF 
ENDFUNC 


