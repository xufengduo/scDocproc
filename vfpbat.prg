*****************************************************************
** �ļ���  :      vfpbat
** ��    ��:      Version 0.1
** �汾��Ϣ��     2015/04/23  ����V0.1
***************************END***********************************


*************������������***********
*�򿪵���ģʽ
#define       DEDUG          0
#define       CTROLWIN       0
*��ִ�б���ģʽ
#define       REPORTMODE     1 
*���������ļ�·��
#define       CFGDB          "c:\Users\eland\Desktop\scDocproc\mycfgdb1.dbf"
*����ִ��Ĭ��·��
#define       DEFALUTPATH    "c:\Users\eland\Desktop\scDocproc"
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

*PUBLIC cFileName as Character
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

excinfo= PRGDIR + m_spaces + sys(5)+sys(2003)+'\' + m_spaces + m_spaces + m_spaces + EXCTIME + m_spaces + DTOC(DATE()) +' '+ TIME() + NEWLINE 
reportfile = NEWLINE + PRGNAME + m_spaces +m_rpname + NEWLINE

?PrgDebug("�ļ�����",m_rpname, 1)
?PrgDebug("�ļ�Ŀ¼",m_rpfilename , 1)
?PrgDebug("ִ����Ϣ",excinfo, 1)
?PrgDebug("��������",reportfile, 1)

STRTOFILE(reportfile ,m_rpfilename,1)
STRTOFILE(excinfo,m_rpfilename ,1)    
**********************ִ�б�������ļ�END*******************




**********************ִ�ж�ȡ������Ϣ**********************
Dimension  m_mkdir(MAXARRAYLEN)
Dimension  m_cpydir(MAXARRAYLEN)
DIMENSION m_worksheet(10)
DIMENSION m_procfile(MAXARRAYLEN)
PUBLIC cnt as Integer

IF FILE(CFGDB)
	SELECT * from CFGDB INTO  ARRAY m_mkdir WHERE flags = 1
ELSE
	STRTOFILE("����Ŀ¼�����ļ�������" + NEWLINE ,m_rpfilename ,1)
ENDIF 
dirlens = ALEN(m_mkdir)/DBCOLMNNU
?PrgDebug("����Ŀ¼",m_mkdir, 1)
IF DEDUG = 1
		DISPLAY MEMORY LIKE m_mkdir
ENDIF 

?PrgDebug("Ŀ¼����",dirlens, 1)


IF FILE(CFGDB)
	SELECT * from CFGDB INTO  ARRAY m_cpydir WHERE flags = 2
ELSE
	STRTOFILE("����Ŀ¼�����ļ�������" + NEWLINE ,m_rpfilename ,1)
ENDIF 

?PrgDebug("�追����Ŀ¼",m_cpydir, 1)
IF DEDUG = 1
		DISPLAY MEMORY LIKE m_cpydir
ENDIF 


cpylen = ALEN(m_cpydir)/DBCOLMNNU
*SET DEFAULT TO c:\

?PrgDebug("�追��Ŀ¼����",cpylen , 1)

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

?PrgDebug("������������",m_worksheet, 1)
IF DEDUG = 1
	DISPLAY MEMORY LIKE m_worksheet
ENDIF 


IF FILE(CFGDB)
	SELECT * from CFGDB INTO  ARRAY m_procfile WHERE flags = 3
ELSE
	STRTOFILE("ɸѡ����Ŀ¼�����ļ�������" + NEWLINE ,m_rpfilename ,1)
ENDIF 

proclen = ALEN(m_procfile) / DBCOLMNNU

?PrgDebug("��������",cnt, 1)
?PrgDebug("ɸѡ����",m_procfile, 1)
IF DEDUG = 1
	DISPLAY MEMORY LIKE m_procfile
ENDIF 
?PrgDebug("ɸѡ�������",proclen, 1)


**********************ִ�ж�ȡ������ϢEND*******************



**********************ִ�д������Ŀ¼*********************
PUBLIC kfile  as Character

*SET DEFAULT TO "d:\qssj"

FOR i = 1 TO dirlens IN m_mkdir
	*IF FILE(m_procfile(i,8))
   	   kfile = m_mkdir(i,COL_FILESRC)+'\'+ m_date
   	   X=Adir(m_atrr,kfile ,'D') 
   	   ?PrgDebug("�贴����Ŀ¼",kfile , 1)
   	   ?PrgDebug("�Ƿ���ڣ� 1��ʾ������ 0��ʾ����",X , 1)
       IF X=0 
	      md &kfile 
	      mdirinfo = 'Ŀ¼'+ STR(i,1,5) + ' ·����' + kfile +  '  �����ɹ�' + NEWLINE
	      
	      STRTOFILE(mdirinfo ,m_rpfilename,1)
	      IF CTROLWIN = 1
	      	@i ,10 say mdirinfo 
	      ENDIF 
	    ELSE
	    	mdirinfoerr = 'Ŀ¼'+ STR(i,1,5) + ' ·����' + kfile +  '  ����ʧ�ܣ�Ŀ¼' + m_date + '�Ѵ���' + NEWLINE
	   		STRTOFILE(mdirinfoerr ,m_rpfilename,1)
	    	IF CTROLWIN = 1
	      		@i ,10 say mdirinfoerr 
	      	ENDIF 
	  ENDIF 
ENDFOR 
*md c:\zxxt\&m_date
**********************ִ�д������Ŀ¼END*******************


*!xcopy d:\show2003\show2003.dbf  c:\zrxt\&m_date /y


**********************ִ�п�������ļ�*********************
*SET DEFAULT TO DEFALUTPATH
FOR i = 1 TO cpylen IN m_cpydir
	*IF FILE(m_procfile(i,8))
	cfile = m_cpydir(i,COL_FILESRC)+'\'+ m_cpydir(i,COL_DFILENAME)
	dfile = m_cpydir(i,COL_CPYDES)+'\'+m_date+'\'+m_cpydir(i,COL_DFILENAME)
	 
    ?PrgDebug("ԴĿ¼",cfile , 1)
    ?PrgDebug("Ŀ��Ŀ¼",dfile , 1)
       	 IF FILE(cfile)
	     	*!XCOPY FILE  &cfile TO &dfile /y
	     *ELSE
	     *COPY TO &dfile
	     	COPY FILE  &cfile TO &dfile 
	    	?PrgDebug("����ԴĿ¼",cfile , 1)
    		?PrgDebug("����Ŀ��Ŀ¼",dfile , 1)
    		copyfileinfo = '�ļ�'+ STR(i,1,5) + ' ��ԴĿ¼��' + cfile + ' ������Ŀ��Ŀ¼��' + dfile +  '  �ɹ�' + NEWLINE
    		STRTOFILE(copyfileinfo ,m_rpfilename,1)
    		IF CTROLWIN = 1
    	    	@i + 20,10 say copyfileinfo 
    		ENDIF 
    	 ELSE
    	 	copyfileinfoerr = '�ļ�'+ STR(i,1,5) + ' ��ԴĿ¼��' + cfile + ' ������Ŀ��Ŀ¼��' + dfile +  '  ʧ�ܣ��ļ�' + cfile + '������' + NEWLINE
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

**********************ִ�п�������ļ�END*********************


**********************ִ������ɸѡ*********************


*SET DEFAULT to d:\qssj

PUBLIC fname as Character
PUBLIC cFileName  as Character

FOR i = 1 TO proclen IN m_procfile
    fname = m_procfile(i,COL_SPRENAME)+ YYYYMMDD +'.dbf'
    cFileName =m_procfile(i,COL_DPRENAME) + '\' +  mmdd +m_procfile(i,COL_DFILENAME) 
    ?PrgDebug("ɸѡ�����ļ���",fname, 1)
    ?PrgDebug("ɸѡ����������·��",cFileName, 1)
	IF FILE(fname)
   	    IF NOT USED(fname)   
        	cnt = cnt + 1
       	    use &fname IN m_worksheet(cnt)
       	    SELECT m_worksheet(cnt)
       	    ?PrgDebug("ɸѡ��������",cnt, 1)
       	    ?PrgDebug("ɸѡ��������",m_worksheet(cnt), 1)
       	    ?PrgDebug("��ʹ�������ļ�",fname, 1)
       	    openinfo = '��ʹ���ļ�'+fname + NEWLINE
       	    STRTOFILE(openinfo ,m_rpfilename ,1)
       	 ELSE
       	 	?PrgDebug("����ʹ��",fname, 1)
       	 	STRTOFILE('����ʹ���ļ�'+fname ,m_rpfilename ,1)
       	 ENDIF 
			COPY TO &cFileName for gg = m_procfile(i,COL_SCONDITION)
			
			procefileinfo = '�ļ�'+ STR(i,1,5) + ' ��ԴĿ¼��' + fname + ' ��ȡ���ݵ�Ŀ��Ŀ¼��' + cFileName +  '  �ɹ�' + NEWLINE
			STRTOFILE(procefileinfo ,m_rpfilename ,1)
			IF CTROLWIN = 1
				@i+40,10 say procefileinfo 
			ENDIF 
	ELSE
			proceinfoerr = '�ļ�'+ STR(i,1,5) + ' ��ԴĿ¼��' + fname + ' ��ȡ���ݵ�Ŀ��Ŀ¼��' + cFileName + '  ʧ�ܣ�Դ�ļ�������' + NEWLINE
			STRTOFILE(proceinfoerr ,m_rpfilename ,1)
	    	IF CTROLWIN = 1
				@i+40,10 say proceinfoerr 
			ENDIF 
	ENDIF 
	CLOSE TABLES
ENDFOR 
CLOSE TABLES

**********************ִ������ɸѡEND*********************

*�򿪵���ģʽ
FUNCTION PrgDebug
	LPARAMETERS mTextinfo, mContexts, mDebugmode
	IF mDebugmode = 0
	   ?mTextinfo 
	   ?mContexts 
	ENDIF 
ENDFUNC 


