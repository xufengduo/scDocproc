*****************************************************************
** �ļ���  :      vfpbat
** ��    ��:      Version 0.1
** �汾��Ϣ��     2015/04/23  ����V0.1
***************************END***********************************


*************������������***********
*�򿪵���ģʽ
#define       DEDUG          0
*��ִ�б���ģʽ
#define       REPORTMODE     1 
*���������ļ�·��
#define       CFGDB          "c:\Users\eland\Desktop\mycfgdb1.dbf"
*����ִ��Ĭ��·��
#define       DEFALUTPATH    "c:\Users\eland\Desktop"
#define       NEWLINE        CHR(13) + CHR(10)
#define       MMDD           SUBSTR(DTOC(DATE()),1,2) + SUBSTR(DTOC(DATE()),4,2)
#define       YYYYMMDD       "20" + SUBSTR(DTOC(DATE()),7,2) + SUBSTR(DTOC(DATE()),1,2) + SUBSTR(DTOC(DATE()),4,2)

#define       PRGNAME        '�����ļ�:'
#define       PRGDIR         '����Ŀ¼:'
#define       EXCTIME        'ִ��ʱ��:'
#define       CFGNOTEXIT     '�����ļ�������'
#define       CFGINFO        '��ȡ����������Ϣ..............'
#define       MAXARRAYLEN    100
#define       DBCOLMNNU      10
*************������������***********


*************������������***********
SET ECHO OFF
SET TALK OFF
SET SAFETY OFF
SET EXCLUSIVE OFF
*SET COMPATIBLE ON 
*************������������END*********


*************�����ڴ�����*************
CLEAR 
*************�����ڴ�����END**********


*************����Ĭ��·��***************
SET DEFAULT TO DEFALUTPATH

?PrgDebug("Ĭ��·��:",DEFALUTPATH, 1)
*************����Ĭ��·��END************


*****��ȡϵͳʱ��YYYYMMDD���ڴ���Ŀ¼*****
m_date = DTOC(DATE(),1)

?PrgDebug("��ǰ����",m_date, 1)

PUBLIC cFileName as Character
PUBLIC mdd as String
IF MONTH(DATE()) <10
	mdd= SUBSTR(DTOC(DATE()),2,1) + SUBSTR(DTOC(DATE()),4,2)
ELSE
	mdd= CHR(MONTH(DATE() + 55)) + SUBSTR(DTOC(DATE()),4,2)
ENDIF 

?PrgDebug("��λ����",mdd , 1)
*****��ȡϵͳʱ��YYYYMMDD���ڴ���Ŀ¼*****



**********************ִ�б�������ļ�*******************
PUBLIC m_rpname as Character
PUBLIC m_rpfilename as Character
m_rpname = m_date + '.txt'
m_rpfilename = sys(5)+sys(2003)+'\' + m_rpname
m_spaces = '        '

excinfo= PRGDIR + m_spaces + sys(5)+sys(2003)+'\' + m_spaces + m_spaces + m_spaces + EXCTIME + m_spaces + DTOC(DATE()) + NEWLINE 
reportfile = NEWLINE + PRGNAME + m_spaces +m_rpname + NEWLINE

?PrgDebug("�ļ�����",m_rpname, 1)
?PrgDebug("�ļ�Ŀ¼",m_rpfilename , 1)
?PrgDebug("ִ����Ϣ",excinfo, 1)
?PrgDebug("��������",reportfile, 1)

STRTOFILE(reportfile ,m_rpfilename,1)
STRTOFILE(excinfo,m_rpfilename ,1)    
**********************ִ�б�������ļ�END*******************


**********************ִ�д������Ŀ¼*********************
Dimension  m_mkdir(MAXARRAYLEN)

IF FILE(CFGDB)
	SELECT * from CFGDB INTO  ARRAY m_mkdir WHERE flags = 1
ELSE

ENDIF 

lens = ALEN(m_mkdir)/DBCOLMNNU

?PrgDebug("����Ŀ¼",m_mkdir, 1)
IF DEDUG = 0
		DISPLAY MEMORY LIKE m_mkdir
ENDIF 

?PrgDebug("Ŀ¼����",lens , 1)

PUBLIC kfile  as Character

SET DEFAULT TO "d:\qssj"

FOR i = 1 TO lens  IN m_mkdir
	*IF FILE(m_aArray2(i,8))
   	   kfile = m_mkdir(i,7)+'\'+ m_date
   	   X=Adir(m_atrr,kfile ,'D') 
   	   ?PrgDebug("�贴����Ŀ¼",kfile , 1)
   	   ?PrgDebug("�Ƿ���ڣ� 1��ʾ������ 0��ʾ����",X , 1)
       IF X=0 
	      md &kfile 
	    ELSE
	      
	  ENDIF 
ENDFOR 
*md c:\zxxt\&m_date
**********************ִ�д������Ŀ¼END*******************


*!xcopy d:\show2003\show2003.dbf  c:\zrxt\&m_date /y
**********************ִ�д������Ŀ¼*********************


**********************ִ�п�������ļ�*********************
SET DEFAULT TO DEFALUTPATH
Dimension  m_cpydir(MAXARRAYLEN)

IF FILE(CFGDB)
	SELECT * from CFGDB INTO  ARRAY m_cpydir WHERE flags = 2
ELSE

ENDIF 

?PrgDebug("�追����Ŀ¼",m_cpydir, 1)
IF DEDUG = 0
		DISPLAY MEMORY LIKE m_cpydir
ENDIF 


len2 = ALEN(m_cpydir)/DBCOLMNNU 
SET DEFAULT TO c:\

?PrgDebug("�追��Ŀ¼����",len2 , 1)

FOR i = 1 TO len2 IN m_cpydir
	*IF FILE(m_aArray2(i,8))
	cfile = m_cpydir(i,7)+'\'+ m_cpydir(i,6)
	dfile = m_cpydir(i,8)+'\'+m_date+'\'+m_cpydir(i,6)
	 
    ?PrgDebug("ԴĿ¼",cfile , 1)
    ?PrgDebug("Ŀ��Ŀ¼",dfile , 1)
       	 IF FILE(cfile)
	     	*!XCOPY FILE  &cfile TO &dfile /y
	     *ELSE
	     *COPY TO &dfile
	     COPY FILE  &cfile TO &dfile 
	    ?PrgDebug("����ԴĿ¼",cfile , 1)
    	?PrgDebug("����Ŀ��Ŀ¼",dfile , 1)
	     ENDIF 
ENDFOR 

*cFileName ="d:\qssj\zqjsxx." +mdd
**DISPLAY MEMORY LIKE cFileName
*!xcopy &cFileName c:\zrxt\&m_date\zqjsxx.dbf /y
*COPY FILE  &cFileName  TO c:\zrxt\&m_date\zqjsxx.dbf

**********************ִ�п�������ļ�END*********************


**********************ִ������ɸѡ*********************
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

?PrgDebug("������������",m_aArray, 1)
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

?PrgDebug("��������",cnt, 1)
?PrgDebug("ɸѡ����",m_aArray2, 1)
IF DEDUG = 0
	DISPLAY MEMORY LIKE m_aArray2
ENDIF 
?PrgDebug("ɸѡ�������",SZ, 1)

SET DEFAULT to d:\qssj

PUBLIC fname as Character

FOR i = 1 TO SZ IN m_aArray2
    fname = m_aArray2(i,2)+ YYYYMMDD +'.dbf'
    ?PrgDebug("ɸѡ�����ļ���",fname, 1)
	IF FILE(fname)
   	    IF NOT USED(fname)   
        	cnt = cnt + 1
       	    use &fname IN m_aArray(cnt)
       	    ?PrgDebug("ɸѡ��������",cnt, 1)
       	    ?PrgDebug("ɸѡ��������",m_aArray(cnt), 1)
    	ENDIF
		cFileName =m_aArray2(i,5) + '\' +  mmdd +m_aArray2(i,6) 
		COPY TO &cFileName for gg = m_aArray2(i,3)
		?PrgDebug("ɸѡ����������·��",cFileName, 1)
		@13,20 say "Done"
	ELSE
		@17,20 say "Not Done"
	ENDIF 
	
ENDFOR 
CLOSE TABLES

**********************ִ������ɸѡEND*********************

*�򿪵���ģʽ
FUNCTION PrgDebug
	LPARAMETERS mTextinfo, mContexts, mDebugmode
	IF mDebugmode = 1
	   ?mTextinfo 
	   ?mContexts 
	ENDIF 
ENDFUNC 


