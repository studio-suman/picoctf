Date: Mon, 29 Jan 90 01:32:06 EST
From: jjw7384@ultb.isc.rit.edu (Jeff Wasilko)
Subject: Batch Unbinhexing/Unstuffing (SUMMARY and SOURCE)


Quite a while ago, I requested info on batch un-binhexing/
un-stufing software available for the mac. I received a few
replies about this, all of them but one suggesting a solution
centered around a mainframe. One person suggested that Ray Lau's 
commercial version of Stuffit might do batch work.

What I found was a trio of programs from the archives at
sumex-aim.stanford.edu in the /info-mac/unix directory. The
combination of these three programs allow almost-batch operation
(I'll get into why it's 'almost' later).

The three programs are:
-rw-r--r--  1 macmod   info-mac    54554 Jan 16 18:18 mcvert-15.shar

    mcvert converts a .hqx (BinHex 4.0) file to a .bin (MacBinary
    file) that can be read by unsit. This program allows wildcard
    operations. Additionally, mcvert will unpack PackIt files.

    Files in: *.hqx
    Files out: *.bin (generally *.sit.bin)

-rw-r--r--  1 macmod   info-mac    26067 Jan  1  1989 unsit.shar

    unsit will decompress .sit.bin (MacBinary Stuffit files)

    I am enclosing a new version of unsit that Allen sent me to
    allow input from MacBinary files. Previously, it was only
    possible to input from macput/macget formatted files. The new version
    also adds compatiblity with Stuffit 1.5.1 and the new HMF
    folder scheme.

    At present, unsit can only output files in macput/macget format,
    but the author Allan Weber (weber%brand.usc.edu@oberon.usc.edu)
    said that he may add the option to output directly to MacBinary format.

    Files in: *.sit.bin 
    Files out: foo.rsrc, foo.data, foo.info 
                       
-rw-r--r--  1 macmod   info-mac     4184 Jan  1  1989 macbinary.shar

    macbinary (macbin) converts macput/macget type files to
    MacBinary files. This allows easy downloading with progams
    such as Kermit or ZTerm.

    macbin does NOT support wildcards, so this part of the
    conversion must be done manually.

    Files in: foo.rsrc, foo.data, foo.info
    Files out: foo.bin (Unstuffed and in Binary format)


The combination of programs works very well and is extremely fast
on our vax, especially when comparied to Stuffit's performance on
a Plus.

Since this process requires the use of three different programs,
I'm writing a shell script to tie everything together. When I get
it running, I'll send it along too.

I'm including a new version of unsit that reads macbinary files.

Jeff


| RIT VAX/VMS Systems: |     Jeff Wasilko     |     RIT Ultrix Systems:     |
|BITNET: jjw7384@ritvax+----------------------+INET:jjw7384@ultb.isc.rit.edu|
|UUCP: {psuvax1, mcvax}!ritvax.bitnet!JJW7384 +___UUCP:jjw7384@ultb.UUCP____+
|INTERNET: jjw7384@isc.rit.edu                |'claimer: No one cares.      |


------cut here for source for unsit 1.5------


>From weber%brand.usc.edu%oberon.USC.EDU@usc.edu Wed Jan 10 17:35:07 1990
Received: by ultb.isc.rit.edu (5.57/5.2 (Postmaster DPMSYS))
	id AA28138; Wed, 10 Jan 90 17:34:45 EST
Received: from brand.usc.edu by usc.edu (5.59/SMI-3.0DEV3) id AA26388; 
                Wed, 10 Jan 90 14:34:03 PST
Received: by brand (5.61/SMI-3.0DEV3) id AA08278; 
                Wed, 10 Jan 90 14:33:20 -0800
Date: Wed, 10 Jan 1990 14:33:17 PST
>From: Allan G. Weber <weber%brand.usc.edu@usc.edu>
>To: jjw7384@usc.edu (Jeff Wasilko)
In-Reply-To: Your message of Wed, 10 Jan 90 16:32:38 EST 
>Subject: unsit
Message-Id: <CMM.0.88.632010797.weber@brand.usc.edu>
Status: RO

The problem is probably that unsit is expecting the file to be just the
data fork of the Mac file, and Macbinary format has the data and resource
forks together along with a header.  I've include the lastest version of
unsit below in case you don't have it.  Some time ago I added a option to
the program to make it skip the Macbinary header by using a "-m" switch
on the command line.  Try the version below with the -m and hopefully it
will work.

Allan Weber

#! /bin/sh
# This is a shell archive, meaning:
# 1. Remove everything above the #! /bin/sh line.
# 2. Save the resulting text in a file.
# 3. Execute the file with /bin/sh (not csh) to create the files:
#	README
#	Makefile
#	unsit.c
#	stuffit.h
#	updcrc.c
#	getopt.c
#	unsit.1
# This archive created: Wed Jan 10 14:25:12 1990
export PATH; PATH=/bin:$PATH
if test -f 'README'
then
	echo shar: will not over-write existing file "'README'"
else
cat << \SHAR_EOF > 'README'
			  Unsit, version 1.5

These are the souces for "unsit", a Unix program for breaking apart
StuffIt archive files created on a Macintosh into separate files on
the Unix system.  See the documentation at the beginning of "unsit.c"
or the man page "unsit.1" for more information.

To build the program, compile unsit.c and updcrc.c and link together.
If your system doesn't have the getopt() routine in its standard
library, also compile getopt.c and include it in the link.

This program opens a pipe to the "compress" program for doing the
uncompression of some of the files in the archive.  Most Unix sites
probably already have "compress".  If not, it can be found in the
comp.sources.unix archives.

Comments and bug reports should be send to weber%brand.usc.edu@oberon.usc.edu


				Allan G. Weber
				Signal and Image Processing Institute
				University of Southern California
				Powell Hall 306, MC-0272
				Los Angeles, CA 90089-0272
				(213) 743-5519
SHAR_EOF
fi # end of overwriting check
if test -f 'Makefile'
then
	echo shar: will not over-write existing file "'Makefile'"
else
cat << \SHAR_EOF > 'Makefile'
GETOPT = 
#GETOPT = getopt.o

unsit : unsit.o updcrc.o $(GETOPT)
	cc -o unsit unsit.o updcrc.o $(GETOPT)

unsit.o : unsit.c stuffit.h
getopt.o : getopt.c

unsit.shar : README Makefile unsit.c stuffit.h updcrc.c getopt.c unsit.1
	shar README Makefile unsit.c stuffit.h updcrc.c getopt.c unsit.1 \
	>unsit.shar
SHAR_EOF
fi # end of overwriting check
if test -f 'unsit.c'
then
	echo shar: will not over-write existing file "'unsit.c'"
else
cat << \SHAR_EOF > 'unsit.c'
/*
	       unsit - Macintosh StuffIt file extractor

		     Version 1.5c, for StuffIt 1.5

			    August 3, 1989

This program will unpack a Macintosh StuffIt file into separate files.
The data fork of a StuffIt file contains both the data and resource
forks of the packed files.  The program will unpack each Mac file into
separate .data, .rsrc., and .info files that can be downloaded to a
Mac using macput.  The program is much like the "unpit" program for
breaking apart Packit archive files.

			***** IMPORTANT *****
To extract StuffIt files that have been compressed with the Lempel-Ziv
compression method, unsit pipes the data through the "compress"
program with the appropriate switches, rather than incorporate the
uncompression routines within "unsit".  Therefore, it is necessary to
have the "compress" program on the system and in the search path to
make "unsit" work.  "Compress" is available from the comp.sources.unix
archives.

The program syntax is much like unpit and macput/macget, with some added
options:

	unsit [-rdulvqfm] stuffit-file.data

The -r and -d flags will cause only the resource and data forks to be
written.  The -u flag will cause only the data fork to be written and
to have carriage return characters changed to Unix newline characters.
The -l flag will make the program only list the files in the StuffIt
file.  The -v flag causes the program to list the names, sizes, type,
and creators of the files it is writing.  The -q flag causes it to
list the name, type and size of each file and wait for a 'y' or 'n'
for either writing that file or skipping it, respectively.  The -m
flag is used when the input file in in the MacBinary format instead of
three separate .data, .info, and .rsrc files.  It causes the program
to skip the 128 byte MacBinary header before looking for the StuffIt
header.

Version 1.5 of the unsit supports extracting files and folders as
implemented by StuffIt 1.5's "Hierarchy Maintained Folder" feature.
Each folder is extracted as a subdirectory on the Unix system with the
files in the folder placed in the corresponding subdirectory.  The -f
option can be used to "flatten" out the hierarchy and unsit will store
all the files in the current directory.  If the query option (-q) is
used and a "n" response is given to a folder name, none of the files
or folders in that folder will be extraced.

Some of the program is borrowed from the macput.c/macget.c programs.
Many, many thanks to Raymond Lau, the author of StuffIt, for including
information on the format of the StuffIt archives in the
documentation.  Several changes and enhancements supplied by David
Shanks (cde@atelabs.UUCP) have been incorporated into the program for
doing things like supporting System V and recognizing MacBinary files.
I'm always glad to receive advice, suggestions, or comments about the
program so feel free to send whatever you think would be helpful


	Author: Allan G. Weber
		weber%brand.usc.edu@oberon.usc.edu
		...sdcrdcf!usc-oberon!brand!weber
	Date:   April 3, 1989

*/

#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>

typedef long OSType;

#include "stuffit.h"

/*
 * Define the following if your Unix can only handle 14 character file names
 * (e.g. Version 7 and System V).
 */
/* #define SHORTNAMES */

/*
 * The following defines the name of the compress program that is used for the
 * uncompression of Lempel-Ziv compressed files.  If the path is set up to
 * include the right directory, this should work.
 */
#define COMPRESS   "compress"

#define IOBUFSIZ   4096

#define MACBINHDRSIZE  128L

#define INIT_CRC 0L
extern unsigned short updcrc();

#define INFOBYTES 128

#define BYTEMASK 0xff

#define S_SIGNATURE    0
#define S_NUMFILES     4
#define S_ARCLENGTH    6
#define S_SIGNATURE2  10
#define	S_VERSION     14
#define SITHDRSIZE    22

#define F_COMPRMETHOD    0
#define F_COMPDMETHOD    1
#define F_FNAME          2
#define F_FTYPE         66
#define F_CREATOR       70
#define F_FNDRFLAGS     74
#define F_CREATIONDATE  76
#define F_MODDATE       80
#define F_RSRCLENGTH    84
#define F_DATALENGTH    88
#define F_COMPRLENGTH   92
#define F_COMPDLENGTH   96
#define F_RSRCCRC      100
#define F_DATACRC      102
#define F_HDRCRC       110
#define FILEHDRSIZE    112

#define F_NAMELEN 63
#ifdef SHORTNAMES		/* short file names */
# define I_NAMELEN 15		/* 14 char file names + '\0' terminator */
#else
# define I_NAMELEN 69		/* 63 + strlen(".info") + 1 */
#endif

/* The following are copied out of macput.c/macget.c */
#define I_NAMEOFF 1
/* 65 <-> 80 is the FInfo structure */
#define I_TYPEOFF 65
#define I_AUTHOFF 69
#define I_FLAGOFF 73
#define I_LOCKOFF 81
#define I_DLENOFF 83
#define I_RLENOFF 87
#define I_CTIMOFF 91
#define I_MTIMOFF 95

#define INITED_BUG
#define INITED_OFF	I_FLAGOFF	/* offset to byte with Inited flag */
#define INITED_MASK	(~1)		/* mask to '&' with byte to reset it */

#define TEXT 0
#define DATA 1
#define RSRC 2
#define FULL 3
#define DUMP 4

#define NODECODE 0
#define DECODE   1

#define H_ERROR -1
#define H_EOF    0
#define H_WRITE  1
#define H_SKIP   2

struct node {
	int flag, byte;
	struct node *one, *zero;
} nodelist[512], *nodeptr, *read_tree();	/* 512 should be big enough */

struct sitHdr sithdr;

char f_info[I_NAMELEN];
char f_data[I_NAMELEN];
char f_rsrc[I_NAMELEN];

char info[INFOBYTES];
char mname[F_NAMELEN+1];
char uname[F_NAMELEN+1];
char iobuf[IOBUFSIZ];

int mode, txtmode, listonly, verbose, query, flatten;
int bit, chkcrc, numfiles, depth;
FILE *infp;

long get4();
short get2();
unsigned short write_file();

main(argc, argv)
int argc;
char *argv[];
{
    int status;
    int c;
    extern int optind;
    extern char *optarg;
    int errflg;
    int macbin;

    mode = FULL;
    errflg = 0;
    macbin = 0;
    flatten = 0;
    numfiles = 0;
    depth = 0;

    while ((c = getopt(argc, argv, "dflmqruvx")) != EOF)
	switch (c) {
	  case 'r':
	    mode = RSRC;
	    break;
	  case 'd':
	    mode = DATA;
	    break;
	  case 'u':
	    mode = TEXT;
	    break;
	  case 'l':
	    listonly++;
	    break;
	  case 'q':
	    query++;
	    break;
	  case 'v':
	    verbose++;
	    break;
	  case 'x':
	    mode = DUMP;
	    break;
	  case 'm':
	    macbin = 1;
	    break;
	  case 'f':
	    flatten = 1;
	    break;
	  case '?':
	    errflg++;
	    break;
	}
    if (errflg) {
	usage();
	exit(1);
    }

    if (optind == argc) {
	usage();
	exit(1);
    }
    else {
	if ((infp = fopen(argv[optind], "r")) == NULL) {
	    fprintf(stderr,"Can't open input file \"%s\"\n",argv[optind]);
	    exit(1);
	}
    }

    if (macbin) {
	if (fseek(infp, MACBINHDRSIZE, 0) == -1) {
	    fprintf(stderr, "Can't skip over MacBinary header\n");
	    exit(1);
	}
    }

    if (readsithdr(&sithdr) == 0) {
	fprintf(stderr, "Can't read file header\n");
	exit(1);
    }
    /* 
    printf("numfiles=%d, arclength=%ld\n", sithdr.numFiles, sithdr.arcLength);
    */
	
    status = extract("", 0);
    exit((status < 0) ? 1 : 0);
}

usage()
{
    fprintf(stderr, "Usage: unsit [-rdulvqmf] filename\n");
}

/*
  extract(parent, skip) - Extract all files from the current folder.
  char *parent;           name of parent folder
  int  skip;              1 to skip all files and folders in this one
                          0 to extract them

  returns 1 if came an endFolder record
          0 if EOF
	 -1 if error (bad fileHdr, bad file, etc.)
*/

extract(parent, skip)
char *parent;
int skip;
{
    struct fileHdr filehdr;
    struct stat sbuf;
    int status, rstat, sstat, skipit;
    char name[256];

    while (1) {
	rstat = readfilehdr(&filehdr, skip);
	if (rstat == H_ERROR || rstat == H_EOF) {
	    status = rstat;
	    break;
	}
	/*
	printf("compr=%d, compd=%d, rsrclen=%ld, datalen=%ld, rsrccrc=%d, datacrc=%d\n",
	       filehdr.compRMethod, filehdr.compDMethod,
	       filehdr.compRLength, filehdr.compDLength,
	       filehdr.rsrcCRC, filehdr.dataCRC);
	*/

	skipit = (rstat == H_SKIP) ? 1 : 0;

	if (filehdr.compRMethod == endFolder && 
	    filehdr.compDMethod == endFolder) {
	    status = 1;		/* finished with this folder */
	    break;
	}
	else if (filehdr.compRMethod == startFolder && 
		 filehdr.compDMethod == startFolder) {
	    if (!listonly && rstat == H_WRITE && !flatten) {
		sstat = stat(uname, &sbuf);
		if (sstat == -1) {	/* directory doesn't exist */
		    if (mkdir(uname, 0777) == -1) {
			fprintf(stderr,
				"Can't create subdirectory %s\n", uname);
			return(-1);
		    }
		}
		else {		/* something exists with this name */
		    if ((sbuf.st_mode & S_IFMT) != S_IFDIR) {
			fprintf(stderr, "Directory name %s already in use\n",
				uname);
			return(-1);
		    }
		}
		if (chdir(uname) == -1) {
		    fprintf(stderr, "Can't chdir to %s\n", uname);
		    return(-1);
		}
		sprintf(name,"%s:%s", parent, uname);
	    }
	    depth++;
	    status = extract(name, skipit);
	    depth--;
	    if (status != 1)
		break;		/* problem with folder */
	    if (depth == 0)	/* count how many top-level files done */
		numfiles++;
	    if (!flatten)
		chdir("..");
	}
	else {
	    if ((status = extractfile(&filehdr, skipit)) != 1)
		break;
	    if (depth == 0)	/* count how many top-level files done */
		numfiles++;
	}
	if (numfiles == sithdr.numFiles)
	    break;
    }
    return(status);
}

extractfile(fh, skip)
struct fileHdr *fh;
int skip;
{
    unsigned short crc;
    FILE *fp;

    f_data[0] = f_rsrc[0] = f_info[0] = '\0'; /* assume no output files */
    /* figure out what file names to use and what to do */
    if (!listonly && !skip) {
	switch (mode) {
	  case FULL:		/* do both rsrc and data forks */
	    sprintf(f_data, "%.*s.data", I_NAMELEN - 6, uname);
	    sprintf(f_rsrc, "%.*s.rsrc", I_NAMELEN - 6, uname);
	    sprintf(f_info, "%.*s.info", I_NAMELEN - 6, uname);
	    break;
	  case RSRC:		/* rsrc fork only */
	    sprintf(f_rsrc, "%.*s.rsrc", I_NAMELEN - 6, uname);
	    break;
	  case DATA:		/* data fork only */
	  case TEXT:
	    sprintf(f_data, "%.*s", I_NAMELEN - 1, uname);
	    break;
	  case DUMP:		/* for debugging, dump data as is */
	    sprintf(f_data, "%.*s.ddump", I_NAMELEN - 7, uname);
	    sprintf(f_rsrc, "%.*s.rdump", I_NAMELEN - 7, uname);
	    fh->compRMethod = fh->compDMethod = noComp;
	    break;
	}
    }

    if (f_info[0] != '\0' && check_access(f_info) != -1) {
	fp = fopen(f_info, "w");
	if (fp == NULL) {
	    perror(f_info);
	    exit(1);
	}
	fwrite(info, 1, INFOBYTES, fp);
	fclose(fp);
    }

    if (f_rsrc[0] != '\0') {
	txtmode = 0;
	crc = write_file(f_rsrc, fh->compRLength,
			 fh->rsrcLength, fh->compRMethod);
	if (chkcrc && fh->rsrcCRC != crc) {
	    fprintf(stderr,
		    "CRC error on resource fork: need 0x%04x, got 0x%04x\n",
		    fh->rsrcCRC, crc);
	    return(-1);
	}
    }
    else {
	fseek(infp, (long) fh->compRLength, 1);
    }
    if (f_data[0] != '\0') {
	txtmode = (mode == TEXT);
	crc = write_file(f_data, fh->compDLength,
			 fh->dataLength, fh->compDMethod);
	if (chkcrc && fh->dataCRC != crc) {
	    fprintf(stderr,
		    "CRC error on data fork: need 0x%04x, got 0x%04x\n",
		    fh->dataCRC, crc);
	    return(-1);
	}
    }
    else {
	fseek(infp, (long) fh->compDLength, 1);
    }
    return(1);
}

readsithdr(s)
struct sitHdr *s;
{
    char temp[FILEHDRSIZE];
    int count = 0;

    for (;;) {
	if (fread(temp, 1, SITHDRSIZE, infp) != SITHDRSIZE) {
	    fprintf(stderr, "Can't read file header\n");
	    return(0);
	}
    	
	if (strncmp(temp + S_SIGNATURE,  "SIT!", 4) == 0 &&
    	strncmp(temp + S_SIGNATURE2, "rLau", 4) == 0) {
	    s->numFiles = get2(temp + S_NUMFILES);
	    s->arcLength = get4(temp + S_ARCLENGTH);
	    return(1);
	}
    
	if (++count == 2) {
	    fprintf(stderr, "Not a StuffIt file\n");
	    return(0);
	}
	
	if (fread(&temp[SITHDRSIZE], 1, FILEHDRSIZE - SITHDRSIZE, infp) !=
	    FILEHDRSIZE - SITHDRSIZE) {
	    fprintf(stderr, "Can't read file header\n");
	    return(0);
	}
    
	if (strncmp(temp + I_TYPEOFF, "SIT!", 4) == 0 &&
	    strncmp(temp + I_AUTHOFF, "SIT!", 4) == 0) {	/* MacBinary format */
	    fseek(infp, (long)(INFOBYTES-FILEHDRSIZE), 1);	/* Skip over header */
	}
    }
}

/*
  readfilehdr - reads the file header for each file and the folder start
  and end records.

  returns: H_ERROR = error
	   H_EOF   = EOF
	   H_WRITE = write file/folder
	   H_SKIP  = skip file/folder
*/

readfilehdr(f, skip)
struct fileHdr *f;
int skip;
{
    unsigned short crc;
    int i, n, write_it, isfolder;
    char hdr[FILEHDRSIZE];
    char ch, *mp, *up;
    char *tp, temp[10];

    for (i = 0; i < INFOBYTES; i++)
	info[i] = '\0';

    /* read in the next file header, which could be folder start/end record */
    n = fread(hdr, 1, FILEHDRSIZE, infp);
    if (n == 0)			/* return 0 on EOF */
	return(H_EOF);
    else if (n != FILEHDRSIZE) {
	fprintf(stderr, "Can't read file header\n");
	return(H_ERROR);
    }

    /* check the CRC for the file header */
    crc = INIT_CRC;
    crc = updcrc(crc, hdr, FILEHDRSIZE - 2);
    f->hdrCRC = get2(hdr + F_HDRCRC);
    if (f->hdrCRC != crc) {
	fprintf(stderr, "Header CRC mismatch: got 0x%04x, need 0x%04x\n",
		f->hdrCRC, crc);
	return(H_ERROR);
    }

    /* grab the name of the file or folder */
    n = hdr[F_FNAME] & BYTEMASK;
    if (n > F_NAMELEN)
	n = F_NAMELEN;
    info[I_NAMEOFF] = n;
    copy(info + I_NAMEOFF + 1, hdr + F_FNAME + 1, n);
    strncpy(mname, hdr + F_FNAME + 1, n);
    mname[n] = '\0';
    /* copy to a string with no illegal Unix characters in the file name */
    mp = mname;
    up = uname;
    while ((ch = *mp++) != '\0') {
	if (ch <= ' ' || ch > '~' || index("/!()[]*<>?\\\"$\';&`", ch) != NULL)
	    ch = '_';
	*up++ = ch;
    }
    *up = '\0';

    /* get lots of other stuff from the header */
    f->compRMethod = hdr[F_COMPRMETHOD];
    f->compDMethod = hdr[F_COMPDMETHOD];
    f->rsrcLength = get4(hdr + F_RSRCLENGTH);
    f->dataLength = get4(hdr + F_DATALENGTH);
    f->compRLength = get4(hdr + F_COMPRLENGTH);
    f->compDLength = get4(hdr + F_COMPDLENGTH);
    f->rsrcCRC = get2(hdr + F_RSRCCRC);
    f->dataCRC = get2(hdr + F_DATACRC);

    /* if it's an end folder record, don't need to do any more */
    if (f->compRMethod == endFolder && f->compDMethod == endFolder)
	return(H_WRITE);

    /* prepare an info file in case its needed */

    copy(info + I_TYPEOFF, hdr + F_FTYPE, 4);
    copy(info + I_AUTHOFF, hdr + F_CREATOR, 4);
    copy(info + I_FLAGOFF, hdr + F_FNDRFLAGS, 2);
#ifdef INITED_BUG
    info[INITED_OFF] &= INITED_MASK; /* reset init bit */
#endif
    copy(info + I_DLENOFF, hdr + F_DATALENGTH, 4);
    copy(info + I_RLENOFF, hdr + F_RSRCLENGTH, 4);
    copy(info + I_CTIMOFF, hdr + F_CREATIONDATE, 4);
    copy(info + I_MTIMOFF, hdr + F_MODDATE, 4);

    isfolder = f->compRMethod == startFolder && f->compDMethod == startFolder;
	
    /* list the file name if verbose or listonly mode, also if query mode */
    if (skip)			/* skip = 1 if skipping all in this folder */
	write_it = 0;
    else {
	write_it = 1;
	if (listonly || verbose || query) {
	    for (i = 0; i < depth; i++)
		putchar(' ');
	    if (isfolder)
		printf("Folder: \"%s\"", uname);
	    else
		printf("name=\"%s\", type=%4.4s, author=%4.4s, data=%ld, rsrc=%ld",
		       uname, hdr + F_FTYPE, hdr + F_CREATOR,
		       f->dataLength, f->rsrcLength);
	    if (query) {	/* if querying, check with the boss */
		printf(" ? ");
		fgets(temp, sizeof(temp) - 1, stdin);
		tp = temp;
		write_it = 0;
		while (*tp != '\0') {
		    if (*tp == 'y' || *tp == 'Y') {
			write_it = 1;
			break;
		    }
		    else
			tp++;
		}
	    }
	    else		/* otherwise, terminate the line */
		putchar('\n');
	}
    }
    return(write_it ? H_WRITE : H_SKIP);
}

check_access(fname)	/* return 0 if OK to write on file fname, -1 otherwise */
char *fname;
{
    char temp[10], *tp;

    if (access(fname, 0) == -1) {
	return(0);
    }
    else {
	printf("%s exists.  Overwrite? ", fname);
	fgets(temp, sizeof(temp) - 1, stdin);
	tp = temp;
	while (*tp != '\0') {
	    if (*tp == 'y' || *tp == 'Y') {
		return(0);
	    }
	    else
		tp++;
	}
    }
    return(-1);
}

unsigned short write_file(fname, ibytes, obytes, type)
char *fname;
unsigned long ibytes, obytes;
unsigned char type;
{
    unsigned short crc;
    int i, n, ch, lastch;
    FILE *outf;
    char temp[256];

    crc = INIT_CRC;
    chkcrc = 1;			/* usually can check the CRC */

    if (check_access(fname) == -1) {
	fseek(infp, ibytes, 1);
	chkcrc = 0;		/* inhibit crc check if file not written */
    	return(-1);
    }
	
    switch (type) {
      case noComp:		/* no compression */
	outf = fopen(fname, "w");
	if (outf == NULL) {
	    perror(fname);
	    exit(1);
	}
	while (ibytes > 0) {
	    n = (ibytes > IOBUFSIZ) ? IOBUFSIZ : ibytes;
	    n = fread(iobuf, 1, n, infp);
	    if (n == 0)
		break;
	    crc = updcrc(crc, iobuf, n);
	    outc(iobuf, n, outf);
	    ibytes -= n;
	}
	fclose(outf);
	break;
      case rleComp:		/* run length encoding */
	outf = fopen(fname, "w");
	if (outf == NULL) {
	    perror(fname);
	    exit(1);
	}
	while (ibytes > 0) {
	    ch = getc(infp) & 0xff;
	    ibytes--;
	    if (ch == 0x90) {	/* see if its the repeat marker */
		n = getc(infp) & 0xff; /* get the repeat count */
		ibytes--;
		if (n == 0) { /* 0x90 was really an 0x90 */
		    iobuf[0] = 0x90;
		    crc = updcrc(crc, iobuf, 1);
		    outc(iobuf, 1, outf);
		}
		else {
		    n--;
		    for (i = 0; i < n; i++)
			iobuf[i] = lastch;
		    crc = updcrc(crc, iobuf, n);
		    outc(iobuf, n, outf);
		}
	    }
	    else {
		iobuf[0] = ch;
		crc = updcrc(crc, iobuf, 1);
		lastch = ch;
		outc(iobuf, 1, outf);
	    }
	}
	fclose(outf);
	break;
      case lzwComp:		/* LZW compression */
	sprintf(temp, "%s%s", COMPRESS, " -d -c -n -b 14 ");
	if (txtmode) {
	    strcat(temp, "| tr \'\\015\' \'\\012\' ");
	    chkcrc = 0;		/* can't check CRC in this case */
	}
	strcat(temp, "> '");
	strcat(temp, fname);
	strcat(temp, "'");
	outf = popen(temp, "w");
	if (outf == NULL) {
	    perror(fname);
	    exit(1);
	}
	while (ibytes > 0) {
	    n = (ibytes > IOBUFSIZ) ? IOBUFSIZ : ibytes;
	    n = fread(iobuf, 1, n, infp);
	    if (n == 0)
		break;
	    fwrite(iobuf, 1, n, outf);
	    ibytes -= n;
	}
	pclose(outf);
	if (chkcrc) {
	    outf = fopen(fname, "r"); /* read the file to get CRC value */
	    if (outf == NULL) {
		perror(fname);
		exit(1);
	    }
	    while (1) {
		n = fread(iobuf, 1, IOBUFSIZ, outf);
		if (n == 0)
		    break;
		crc = updcrc(crc, iobuf, n);
	    }
	    fclose(outf);
	}
	break;
      case hufComp:		/* Huffman compression */
	outf = fopen(fname, "w");
	if (outf == NULL) {
	    perror(fname);
	    exit(1);
	}
	nodeptr = nodelist;
	bit = 0;		/* put us on a byte boundary */
	read_tree();
	while (obytes > 0) {
	    n = (obytes > IOBUFSIZ) ? IOBUFSIZ : obytes;
	    for (i = 0; i < n; i++)
		iobuf[i] = gethuffbyte(DECODE);
	    crc = updcrc(crc, iobuf, n);
	    outc(iobuf, n, outf);
	    obytes -= n;
	}
	fclose(outf);
	break;
      default:
	fprintf(stderr, "Unknown compression method\n");
	chkcrc = 0;		/* inhibit crc check if file not written */
	return(-1);
    }

    return(crc & 0xffff);
}

outc(p, n, fp)
char *p;
int n;
FILE *fp;
{
    register char *p1;
    register int i;
    if (txtmode) {
	for (i = 0, p1 = p; i < n; i++, p1++)
	    if ((*p1 & BYTEMASK) == '\r')
		*p1 = '\n';
    }
    fwrite(p, 1, n, fp);
}

long get4(bp)
char *bp;
{
    register int i;
    long value = 0;

    for (i = 0; i < 4; i++) {
	value <<= 8;
	value |= (*bp & BYTEMASK);
	bp++;
    }
    return(value);
}

short get2(bp)
char *bp;
{
    register int i;
    int value = 0;

    for (i = 0; i < 2; i++) {
	value <<= 8;
	value |= (*bp & BYTEMASK);
	bp++;
    }
    return(value);
}

copy(p1, p2, n)
char *p1, *p2;
int n;
{
	while (n-- > 0)
		*p1++ = *p2++;
}

/* This routine recursively reads the Huffman encoding table and builds
   and decoding tree. */

struct node *read_tree()
{
	struct node *np;
	np = nodeptr++;
	if (getbit() == 1) {
		np->flag = 1;
		np->byte = gethuffbyte(NODECODE);
	}
	else {
		np->flag = 0;
		np->zero = read_tree();
		np->one  = read_tree();
	}
	return(np);
}

/* This routine returns the next bit in the input stream (MSB first) */

getbit()
{
	static char b;
	if (bit == 0) {
		b = getc(infp) & 0xff;
		bit = 8;
	}
	bit--;
	return((b >> bit) & 1);
}

/* This routine returns the next 8 bits.  If decoding is on, it finds the
byte in the decoding tree based on the bits from the input stream.  If
decoding is not on, it either gets it directly from the input stream or
puts it together from 8 calls to getbit(), depending on whether or not we
are currently on a byte boundary
*/
gethuffbyte(decode)
int decode;
{
	register struct node *np;
	register int i, b;
	if (decode == DECODE) {
		np = nodelist;
		while (np->flag == 0)
			np = (getbit()) ? np->one : np->zero;
		b = np->byte;
	}
	else {
		if (bit == 0)	/* on byte boundary? */
			b = getc(infp) & 0xff;
		else {		/* no, put a byte together */
			b = 0;
			for (i = 8; i > 0; i--) {
				b = (b << 1) + getbit();
			}
		}
	}
	return(b);
}
SHAR_EOF
fi # end of overwriting check
if test -f 'stuffit.h'
then
	echo shar: will not over-write existing file "'stuffit.h'"
else
cat << \SHAR_EOF > 'stuffit.h'
/* StuffIt.h: contains declarations for SIT headers */

typedef struct sitHdr {			/* 22 bytes */
	OSType	signature; 		/* = 'SIT!' -- for verification */
	unsigned short	numFiles;	/* number of files in archive */
	unsigned long	arcLength;	/* length of entire archive incl.
						hdr. -- for verification */
	OSType	signature2;		/* = 'rLau' -- for verification */
	unsigned char	version;	/* version number */
	char reserved[7];
};

typedef struct fileHdr {		/* 112 bytes */
	unsigned char	compRMethod;	/* rsrc fork compression method */
	unsigned char	compDMethod;	/* data fork compression method */
	unsigned char	fName[64];	/* a STR63 */
	OSType	fType;			/* file type */
	OSType	fCreator;		/* er... */
	short FndrFlags;		/* copy of Finder flags.  For our
						purposes, we can clear:
						busy,onDesk */
	unsigned long	creationDate;
	unsigned long	modDate;	/* !restored-compat w/backup prgms */
	unsigned long	rsrcLength;	/* decompressed lengths */
	unsigned long	dataLength;
	unsigned long	compRLength;	/* compressed lengths */
	unsigned long	compDLength;
	unsigned short rsrcCRC;		/* crc of rsrc fork */
	unsigned short dataCRC;		/* crc of data fork */
	char reserved[6];
	unsigned short hdrCRC;		/* crc of file header */
};


/* file format is:
	sitArchiveHdr
		file1Hdr
			file1RsrcFork
			file1DataFork
		file2Hdr
			file2RsrcFork
			file2DataFork
		.
		.
		.
		fileNHdr
			fileNRsrcFork
			fileNDataFork
*/



/* compression methods */
#define noComp 	0	/* just read each byte and write it to archive */
#define rleComp 1	/* RLE compression */
#define lzwComp 2	/* LZW compression */
#define hufComp 3	/* Huffman compression */

#define encrypted 16	/* bit set if encrypted.  ex: encrypted+lpzComp */

#define startFolder 32	/* marks start of a new folder */
#define endFolder 33	/* marks end of the last folder "started" */

/* all other numbers are reserved */
SHAR_EOF
fi # end of overwriting check
if test -f 'updcrc.c'
then
	echo shar: will not over-write existing file "'updcrc.c'"
else
cat << \SHAR_EOF > 'updcrc.c'
/* updcrc(3), crc(1) - calculate crc polynomials
 *
 * Calculate, intelligently, the CRC of a dataset incrementally given a 
 * buffer full at a time.
 * 
 * Usage:
 * 	newcrc = updcrc( oldcrc, bufadr, buflen )
 * 		unsigned int oldcrc, buflen;
 * 		char *bufadr;
 *
 * Compiling with -DTEST creates a program to print the CRC of stdin to stdout.
 * Compile with -DMAKETAB to print values for crctab to stdout.  If you change
 *	the CRC polynomial parameters, be sure to do this and change
 *	crctab's initial value.
 *
 * Notes:
 *  Regards the data stream as an integer whose MSB is the MSB of the first
 *  byte recieved.  This number is 'divided' (using xor instead of subtraction)
 *  by the crc-polynomial P.
 *  XMODEM does things a little differently, essentially treating the LSB of
 * the first data byte as the MSB of the integer. Define SWAPPED to make
 * things behave in this manner.
 *
 * Author:	Mark G. Mendel, 7/86
 *		UUCP: ihnp4!umn-cs!hyper!mark, GEnie: mgm
 */

/* The CRC polynomial.
 * These 4 values define the crc-polynomial.
 * If you change them, you must change crctab[]'s initial value to what is
 * printed by initcrctab() [see 'compile with -DMAKETAB' above].
 */
    /* Value used by:	    		CITT	XMODEM	ARC  	*/
#define	P	 0xA001	 /* the poly:	0x1021	0x1021	A001	*/
#define INIT_CRC 0L	 /* init value:	-1	0	0	*/
#define SWAPPED		 /* bit order:	undef	defined	defined */
#define W	16	 /* bits in CRC:16	16	16	*/

    /* data type that holds a W-bit unsigned integer */
#if W <= 16
#  define WTYPE	unsigned short
#else
#  define WTYPE   unsigned long
#endif

    /* the number of bits per char: don't change it. */
#define B	8

static WTYPE crctab[1<<B] = /* as calculated by initcrctab() */ {
0x0,  0xc0c1,  0xc181,  0x140,  0xc301,  0x3c0,  0x280,  0xc241,
0xc601,  0x6c0,  0x780,  0xc741,  0x500,  0xc5c1,  0xc481,  0x440,
0xcc01,  0xcc0,  0xd80,  0xcd41,  0xf00,  0xcfc1,  0xce81,  0xe40,
0xa00,  0xcac1,  0xcb81,  0xb40,  0xc901,  0x9c0,  0x880,  0xc841,
0xd801,  0x18c0,  0x1980,  0xd941,  0x1b00,  0xdbc1,  0xda81,  0x1a40,
0x1e00,  0xdec1,  0xdf81,  0x1f40,  0xdd01,  0x1dc0,  0x1c80,  0xdc41,
0x1400,  0xd4c1,  0xd581,  0x1540,  0xd701,  0x17c0,  0x1680,  0xd641,
0xd201,  0x12c0,  0x1380,  0xd341,  0x1100,  0xd1c1,  0xd081,  0x1040,
0xf001,  0x30c0,  0x3180,  0xf141,  0x3300,  0xf3c1,  0xf281,  0x3240,
0x3600,  0xf6c1,  0xf781,  0x3740,  0xf501,  0x35c0,  0x3480,  0xf441,
0x3c00,  0xfcc1,  0xfd81,  0x3d40,  0xff01,  0x3fc0,  0x3e80,  0xfe41,
0xfa01,  0x3ac0,  0x3b80,  0xfb41,  0x3900,  0xf9c1,  0xf881,  0x3840,
0x2800,  0xe8c1,  0xe981,  0x2940,  0xeb01,  0x2bc0,  0x2a80,  0xea41,
0xee01,  0x2ec0,  0x2f80,  0xef41,  0x2d00,  0xedc1,  0xec81,  0x2c40,
0xe401,  0x24c0,  0x2580,  0xe541,  0x2700,  0xe7c1,  0xe681,  0x2640,
0x2200,  0xe2c1,  0xe381,  0x2340,  0xe101,  0x21c0,  0x2080,  0xe041,
0xa001,  0x60c0,  0x6180,  0xa141,  0x6300,  0xa3c1,  0xa281,  0x6240,
0x6600,  0xa6c1,  0xa781,  0x6740,  0xa501,  0x65c0,  0x6480,  0xa441,
0x6c00,  0xacc1,  0xad81,  0x6d40,  0xaf01,  0x6fc0,  0x6e80,  0xae41,
0xaa01,  0x6ac0,  0x6b80,  0xab41,  0x6900,  0xa9c1,  0xa881,  0x6840,
0x7800,  0xb8c1,  0xb981,  0x7940,  0xbb01,  0x7bc0,  0x7a80,  0xba41,
0xbe01,  0x7ec0,  0x7f80,  0xbf41,  0x7d00,  0xbdc1,  0xbc81,  0x7c40,
0xb401,  0x74c0,  0x7580,  0xb541,  0x7700,  0xb7c1,  0xb681,  0x7640,
0x7200,  0xb2c1,  0xb381,  0x7340,  0xb101,  0x71c0,  0x7080,  0xb041,
0x5000,  0x90c1,  0x9181,  0x5140,  0x9301,  0x53c0,  0x5280,  0x9241,
0x9601,  0x56c0,  0x5780,  0x9741,  0x5500,  0x95c1,  0x9481,  0x5440,
0x9c01,  0x5cc0,  0x5d80,  0x9d41,  0x5f00,  0x9fc1,  0x9e81,  0x5e40,
0x5a00,  0x9ac1,  0x9b81,  0x5b40,  0x9901,  0x59c0,  0x5880,  0x9841,
0x8801,  0x48c0,  0x4980,  0x8941,  0x4b00,  0x8bc1,  0x8a81,  0x4a40,
0x4e00,  0x8ec1,  0x8f81,  0x4f40,  0x8d01,  0x4dc0,  0x4c80,  0x8c41,
0x4400,  0x84c1,  0x8581,  0x4540,  0x8701,  0x47c0,  0x4680,  0x8641,
0x8201,  0x42c0,  0x4380,  0x8341,  0x4100,  0x81c1,  0x8081,  0x4040,
} ;

WTYPE
updcrc( icrc, icp, icnt )
    WTYPE icrc;
    unsigned char *icp;
    int icnt;
{
    register WTYPE crc = icrc;
    register unsigned char *cp = icp;
    register int cnt = icnt;

    while( cnt-- ) {
#ifndef SWAPPED
	crc = (crc<<B) ^ crctab[(crc>>(W-B)) ^ *cp++];
#else
	crc = (crc>>B) ^ crctab[(crc & ((1<<B)-1)) ^ *cp++]; 
#endif SWAPPED
    }

    return( crc );
}

#ifdef MAKETAB

#include <stdio.h>
main()
{
    initcrctab();
}

initcrctab()
{
    register  int b, i;
    WTYPE v;

    
    for( b = 0; b <= (1<<B)-1; ++b ) {
#ifndef SWAPPED
	for( v = b<<(W-B), i = B; --i >= 0; )
	    v = v & ((WTYPE)1<<(W-1)) ? (v<<1)^P : v<<1;
#else
	for( v = b, i = B; --i >= 0; )
	    v = v & 1 ? (v>>1)^P : v>>1;
#endif	    
	crctab[b] = v;

	printf( "0x%lx,", v & ((1L<<W)-1L));
	if( (b&7) == 7 )
	    printf("\n" );
	else
	    printf("  ");
    }
}
#endif

#ifdef TEST

#include <stdio.h>
#include <fcntl.h>

#define MAXBUF	4096



main( ac, av )
    int ac; char **av;
{
    int fd;
    int nr;
    int i;
    char buf[MAXBUF];
    WTYPE crc, crc2;

    fd = 0;
    if( ac > 1 )
	if( (fd = open( av[1], O_RDONLY )) < 0 ) {
	    perror( av[1] );
	    exit( -1 );
	}
    crc = crc2 = INIT_CRC;

    while( (nr = read( fd, buf, MAXBUF )) > 0 ) {
	crc = updcrc( crc, buf, nr );
    }

    if( nr != 0 )
	perror( "reading" );
    else {
	printf( "%lx\n", crc );
    }

#ifdef MAGICCHECK
    /* tack one's complement of crc onto data stream, and
       continue crc calculation.  Should get a constant (magic number)
       dependent only on P, not the data.
     */
    crc2 = crc ^ -1L;
    for( nr = W-B; nr >= 0; nr -= B ) {
	buf[0] = (crc2 >> nr);
	crc = updcrc(crc, buf, 1);
    }

    /* crc should now equal magic */
    buf[0] = buf[1] = buf[2] = buf[3] = 0;
    printf( "magic test: %lx =?= %lx\n", crc, updcrc(-1, buf, W/B));
#endif MAGICCHECK
}

#endif
SHAR_EOF
fi # end of overwriting check
if test -f 'getopt.c'
then
	echo shar: will not over-write existing file "'getopt.c'"
else
cat << \SHAR_EOF > 'getopt.c'
/*
 * getopt - get option letter from argv
 */

#include <stdio.h>

char	*optarg;	/* Global argument pointer. */
int	optind = 0;	/* Global argv index. */

static char	*scan = NULL;	/* Private scan pointer. */

extern char	*index();

int
getopt(argc, argv, optstring)
int argc;
char *argv[];
char *optstring;
{
	register char c;
	register char *place;

	optarg = NULL;

	if (scan == NULL || *scan == '\0') {
		if (optind == 0)
			optind++;
	
		if (optind >= argc || argv[optind][0] != '-' || argv[optind][1] == '\0')
			return(EOF);
		if (strcmp(argv[optind], "--")==0) {
			optind++;
			return(EOF);
		}
	
		scan = argv[optind]+1;
		optind++;
	}

	c = *scan++;
	place = index(optstring, c);

	if (place == NULL || c == ':') {
		fprintf(stderr, "%s: unknown option -%c\n", argv[0], c);
		return('?');
	}

	place++;
	if (*place == ':') {
		if (*scan != '\0') {
			optarg = scan;
			scan = NULL;
		} else if (optind < argc) {
			optarg = argv[optind];
			optind++;
		} else {
			fprintf(stderr, "%s: -%c argument missing\n", argv[0], c);
			return('?');
		}
	}

	return(c);
}

SHAR_EOF
fi # end of overwriting check
if test -f 'unsit.1'
then
	echo shar: will not over-write existing file "'unsit.1'"
else
cat << \SHAR_EOF > 'unsit.1'
.TH UNSIT L "Septermber 28, 1988"
.UC
.SH NAME
unsit \- extract/list files in a Macintosh Stuffit archive file
.SH SYNOPSIS
.B unsit
[
.B \-dflmqruv
] file
.br
.SH DESCRIPTION
For the Stuffit archive file listed, 
.I unsit
extracts the files in the archive into separate files.
This makes it possible, for example, to separate a large StuffIt file
into component files for selective downloading, rather than
downloading the larger archive file just to extract a single, small
file.  It also allows the use of StuffIt to compress a group of files
into a single, smaller archive that can be uploaded to a Unix system
for storage, printing, etc.
.PP
In the normal mode, both the data and the resource forks of the
component Macintosh files in the archive are extracted and stored in
Unix files with the extension
.I .data
and 
.I .rsrc
appended to the end of the Macintosh file name.
In addition, a 
.I .info
file will be created with the Finder information.
These three file are compatible with the
.I macput
program for downloading to a Mac running Macterminal.
If only the data or resource fork is extracted, no addition extension is
appended to the Mac file name.
Characters in the Mac file name that are illegal (or unwieldy, like spaces)
are changed to underscores in the Unix file name.  The true Mac file name 
is retained in the
.I .info
file and is restored when the file is downloaded.
.PP
StuffIt version 1.5 has the ability to archive a group of files and folders
in such a way that the hierarchical relationship of the files and folders
is maintained.
.I Unsit
version 1.5 can unpack files archived in this manner and place them in
corresponding subdirectories so as to maintain the hierarchy.  As an option,
the hierarcy can be flattened out and all the files stored in the current
directory.
.PP
The options are similar to those for 
.I macput
and
.I unpit.
.TP
.B \-f
For StuffIt files containing a "Hierarchy Maintained Folder" entry, extract the
files into a "flat" organization (all in the current directory) rather than
maintaining the hierarchy by creating new directories, etc.
Default is to maintain the hierarchical folder organization.
.TP
.B \-l
List the files in the archive but do not extract them.  The name, size,
type, and creator of each file is listed.
.TP
.B \-m
Assumes the input file in MacBinary format rather than macput/macget
format and skips over the MacBinary header.
.TP
.B \-r
Extract resources forks only.
.TP
.B \-d
Extract data forks only.
.TP
.B \-u
Extract data fork and change into a Unix text file.
This only works if the file is really a text file.
.TP
.B \-q
Query user before extracting files and folders.  If a "n" answer is given for
a folder, none of the files or folders in that folder will be extracted.
.TP
.B \-v
Verbose option.  Causes 
.I unsit
to list name, size, type, and creator of each file extracted.
.SH BUGS
Files that were compressed by StuffIt with the Lempel-Ziv method and are
extracted with the 
.B \-u
switch (text files) are not checked for a correct CRC value when 
.I unsit
uncompresses them.  This is because 
.I unsit
pipes the data through
.I compress
and
.I tr
to extract the file and never has a chance to do the CRC check.
.PP
The
.I compress
program has been observed to go into strange states when uncompressing a 
damaged file.  Often it will get stuck writing out bogus data until the
disk fills up.  Since 
.I unsit
sends data through 
.I compress,
the same problem could occur when extracting files from a damaged Stuffit
archive.
.SH FILES
For archives that have been compressed with the Lempel-Ziv method, the 
.I compress 
program must be present on the system and in the search path since 
.I unsit 
uses it for the uncompressing.
.I Compress
is available from the comp.sources.unix archives.
.SH AUTHOR
Allan G. Weber (weber%brand.usc.edu@oberon.usc.edu)
SHAR_EOF
fi # end of overwriting check
#	End of shell archive
exit 0


