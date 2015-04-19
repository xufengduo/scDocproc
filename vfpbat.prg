*****************************************************************
** 文件名  :      vfpbat
** 版    本:      Version 0.1
** 版本信息：     2015/04/23  创建V0.1
***************************END***********************************


*************基础配置设置***********
*打开调试模式
#define       DEDUG          0
#define       CTROLWIN       0
*打开执行报告模式
#define       REPORTMODE     1 
*设置配置文件路径
#define       CFGDB          "c:\Users\eland\Desktop\scDocproc\mycfgdb1.dbf"
*设置执行默认路径
#define       DEFALUTPATH    "c:\Users\eland\Desktop\scDocproc"
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

#define       COL_SMARKNAME       1
#define       COL_SPRENAME        2
#define       COL_SCONDITION      3
#define       COL_DFILEPATH       4
#define       COL_DPRENAME        5
#define       COL_DFILENAME       6
#define       COL_FILESRC         7
#define       COL_CPYDES          8
#define       COL_FLAGS           9
#define       COL_MARK            10


#define       SMARKNAME       smarkname 
#define       SPRENAME        sprename
#define       SCONDITION      scondition
#define       DFILEPATH       dfilepath
#define       DPRENAME        dprename
#define       DFILENAME       dfilename
#define       FILESRC         filesrc
#define       CPYDES          cpydes
#define       FLAGS           flags
#define       MARK            mark

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

*PUBLIC cFileName as Character
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

excinfo= PRGDIR + m_spaces + sys(5)+sys(2003)+'\' + m_spaces + m_spaces + m_spaces + EXCTIME + m_spaces + DTOC(DATE()) +' '+ TIME() + NEWLINE 
reportfile = NEWLINE + PRGNAME + m_spaces +m_rpname + NEWLINE

?PrgDebug("文件名称",m_rpname, 1)
?PrgDebug("文件目录",m_rpfilename , 1)
?PrgDebug("执行信息",excinfo, 1)
?PrgDebug("报告名称",reportfile, 1)

STRTOFILE(reportfile ,m_rpfilename,1)
STRTOFILE(excinfo,m_rpfilename ,1)    
**********************执行报告输出文件END*******************




**********************执行读取配置信息**********************
Dimension  m_mkdir(MAXARRAYLEN)
Dimension  m_cpydir(MAXARRAYLEN)
DIMENSION m_worksheet(10)
DIMENSION m_procfile(MAXARRAYLEN)
PUBLIC cnt as Integer

IF FILE(CFGDB)
	SELECT * from CFGDB INTO  ARRAY m_mkdir WHERE flags = 1
ELSE
	STRTOFILE("创建目录配置文件不存在" + NEWLINE ,m_rpfilename ,1)
ENDIF 
dirlens = ALEN(m_mkdir)/DBCOLMNNU
?PrgDebug("创建目录",m_mkdir, 1)
IF DEDUG = 1
		DISPLAY MEMORY LIKE m_mkdir
ENDIF 

?PrgDebug("目录个数",dirlens, 1)


IF FILE(CFGDB)
	SELECT * from CFGDB INTO  ARRAY m_cpydir WHERE flags = 2
ELSE
	STRTOFILE("拷贝目录配置文件不存在" + NEWLINE ,m_rpfilename ,1)
ENDIF 

?PrgDebug("需拷贝的目录",m_cpydir, 1)
IF DEDUG = 1
		DISPLAY MEMORY LIKE m_cpydir
ENDIF 


cpylen = ALEN(m_cpydir)/DBCOLMNNU
*SET DEFAULT TO c:\

?PrgDebug("需拷贝目录个数",cpylen , 1)

cnt = 0
m_worksheet(1) = 1
m_worksheet(2) = 2
m_worksheet(3) = 3
m_worksheet(4) = 4
m_worksheet(5) = 5
m_worksheet(6) = 6
m_worksheet(7) = 7
m_worksheet(8) = 8
m_worksheet(9) = 9
m_worksheet(10) = 10

?PrgDebug("工作区域数组",m_worksheet, 1)
IF DEDUG = 1
	DISPLAY MEMORY LIKE m_worksheet
ENDIF 


IF FILE(CFGDB)
	SELECT * from CFGDB INTO  ARRAY m_procfile WHERE flags = 3
ELSE
	STRTOFILE("筛选处理目录配置文件不存在" + NEWLINE ,m_rpfilename ,1)
ENDIF 

proclen = ALEN(m_procfile) / DBCOLMNNU

?PrgDebug("工作计数",cnt, 1)
?PrgDebug("筛选处理",m_procfile, 1)
IF DEDUG = 1
	DISPLAY MEMORY LIKE m_procfile
ENDIF 
?PrgDebug("筛选处理个数",proclen, 1)


**********************执行读取配置信息END*******************



**********************执行创建相关目录*********************
PUBLIC kfile  as Character

*SET DEFAULT TO "d:\qssj"

FOR i = 1 TO dirlens IN m_mkdir
	*IF FILE(m_procfile(i,8))
   	   kfile = m_mkdir(i,COL_FILESRC)+'\'+ m_date
   	   X=Adir(m_atrr,kfile ,'D') 
   	   ?PrgDebug("需创建的目录",kfile , 1)
   	   ?PrgDebug("是否存在？ 1表示不存在 0表示存在",X , 1)
       IF X=0 
	      md &kfile 
	      mdirinfo = '目录'+ STR(i,1,5) + ' 路径：' + kfile +  '  创建成功' + NEWLINE
	      
	      STRTOFILE(mdirinfo ,m_rpfilename,1)
	      IF CTROLWIN = 1
	      	@i ,10 say mdirinfo 
	      ENDIF 
	    ELSE
	    	mdirinfoerr = '目录'+ STR(i,1,5) + ' 路径：' + kfile +  '  创建失败，目录' + m_date + '已存在' + NEWLINE
	   		STRTOFILE(mdirinfoerr ,m_rpfilename,1)
	    	IF CTROLWIN = 1
	      		@i ,10 say mdirinfoerr 
	      	ENDIF 
	  ENDIF 
ENDFOR 
*md c:\zxxt\&m_date
**********************执行创建相关目录END*******************


*!xcopy d:\show2003\show2003.dbf  c:\zrxt\&m_date /y


**********************执行拷贝相关文件*********************
*SET DEFAULT TO DEFALUTPATH
FOR i = 1 TO cpylen IN m_cpydir
	*IF FILE(m_procfile(i,8))
	cfile = m_cpydir(i,COL_FILESRC)+'\'+ m_cpydir(i,COL_DFILENAME)
	dfile = m_cpydir(i,COL_CPYDES)+'\'+m_date+'\'+m_cpydir(i,COL_DFILENAME)
	 
    ?PrgDebug("源目录",cfile , 1)
    ?PrgDebug("目标目录",dfile , 1)
       	 IF FILE(cfile)
	     	*!XCOPY FILE  &cfile TO &dfile /y
	     *ELSE
	     *COPY TO &dfile
	     	COPY FILE  &cfile TO &dfile 
	    	?PrgDebug("拷贝源目录",cfile , 1)
    		?PrgDebug("拷贝目标目录",dfile , 1)
    		copyfileinfo = '文件'+ STR(i,1,5) + ' 从源目录：' + cfile + ' 拷贝到目标目录：' + dfile +  '  成功' + NEWLINE
    		STRTOFILE(copyfileinfo ,m_rpfilename,1)
    		IF CTROLWIN = 1
    	    	@i + 20,10 say copyfileinfo 
    		ENDIF 
    	 ELSE
    	 	copyfileinfoerr = '文件'+ STR(i,1,5) + ' 从源目录：' + cfile + ' 拷贝到目标目录：' + dfile +  '  失败，文件' + cfile + '不存在' + NEWLINE
    	 	STRTOFILE(copyfileinfoerr ,m_rpfilename,1)
    	 	IF CTROLWIN = 1
    	 		@i + 20,10 say copyfileinfoerr 
    	 	ENDIF 
	     ENDIF 
ENDFOR 

*cFileName ="d:\qssj\zqjsxx." +mdd
**DISPLAY MEMORY LIKE cFileName
*!xcopy &cFileName c:\zrxt\&m_date\zqjsxx.dbf /y
*COPY FILE  &cFileName  TO c:\zrxt\&m_date\zqjsxx.dbf

**********************执行拷贝相关文件END*********************


**********************执行数据筛选*********************


*SET DEFAULT to d:\qssj

PUBLIC fname as Character
PUBLIC cFileName  as Character

FOR i = 1 TO proclen IN m_procfile
    fname = m_procfile(i,COL_SPRENAME)+ YYYYMMDD +'.dbf'
    cFileName =m_procfile(i,COL_DPRENAME) + '\' +  mmdd +m_procfile(i,COL_DFILENAME) 
    ?PrgDebug("筛选处理文件名",fname, 1)
    ?PrgDebug("筛选工作件拷贝路径",cFileName, 1)
	IF FILE(fname)
   	    IF NOT USED(fname)   
        	cnt = cnt + 1
       	    use &fname IN m_worksheet(cnt)
       	    SELECT m_worksheet(cnt)
       	    ?PrgDebug("筛选工作计数",cnt, 1)
       	    ?PrgDebug("筛选工作区域",m_worksheet(cnt), 1)
       	    ?PrgDebug("打开使用数据文件",fname, 1)
       	    openinfo = '打开使用文件'+fname + NEWLINE
       	    STRTOFILE(openinfo ,m_rpfilename ,1)
       	 ELSE
       	 	?PrgDebug("正在使用",fname, 1)
       	 	STRTOFILE('正在使用文件'+fname ,m_rpfilename ,1)
       	 ENDIF 
			COPY TO &cFileName for gg = m_procfile(i,COL_SCONDITION)
			
			procefileinfo = '文件'+ STR(i,1,5) + ' 从源目录：' + fname + ' 抽取数据到目标目录：' + cFileName +  '  成功' + NEWLINE
			STRTOFILE(procefileinfo ,m_rpfilename ,1)
			IF CTROLWIN = 1
				@i+40,10 say procefileinfo 
			ENDIF 
	ELSE
			proceinfoerr = '文件'+ STR(i,1,5) + ' 从源目录：' + fname + ' 抽取数据到目标目录：' + cFileName + '  失败，源文件不存在' + NEWLINE
			STRTOFILE(proceinfoerr ,m_rpfilename ,1)
	    	IF CTROLWIN = 1
				@i+40,10 say proceinfoerr 
			ENDIF 
	ENDIF 
	CLOSE TABLES
ENDFOR 
CLOSE TABLES

**********************执行数据筛选END*********************

*打开调试模式
FUNCTION PrgDebug
	LPARAMETERS mTextinfo, mContexts, mDebugmode
	IF mDebugmode = 0
	   ?mTextinfo 
	   ?mContexts 
	ENDIF 
ENDFUNC 


