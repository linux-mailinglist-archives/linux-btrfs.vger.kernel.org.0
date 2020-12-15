Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D4B2DB504
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Dec 2020 21:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgLOUYb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Dec 2020 15:24:31 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45100 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbgLOUYF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Dec 2020 15:24:05 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BFKKdMP136608;
        Tue, 15 Dec 2020 20:23:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=/RozdPPc8Yb1Yrxbz/V+rUtL6WnmpLg1heW7WFMTBWA=;
 b=0Y2/p1G/X+1d1gA7iwUAM6O0O8HVtCIPY0qZURfKxb0crSdt7ieYGHBUPuYVu3maLogV
 FPEDs44SdZ6aATNwb0nzC3b3lYU7UKzPZPFOsP93Jccsk/CWqVZ8jeD9LC9TypB6w40T
 KRLsWSPFQ99DdyLJFoQCu4K845FYjm2aMPXzbUdHq9Uju01WFizyPSpADVSBnyHul5so
 6nYtR7sCbn+1tT1PqhKh2Sx3uO13SvVZ029+ccAC61gifquLr1WSk6lfNPstEFZ0UDVr
 LqWvaOR7/1NNUStPqg+0AwccR9RifGIaxTQuVWYw0YXHjSuLq38dpLG0wUqH+a27O9uP 9g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 35cn9rcnmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Dec 2020 20:23:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BFKL3Ps147233;
        Tue, 15 Dec 2020 20:23:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 35e6eqxp1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Dec 2020 20:23:18 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BFKNGto019426;
        Tue, 15 Dec 2020 20:23:17 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Dec 2020 12:23:16 -0800
Date:   Tue, 15 Dec 2020 12:23:15 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/4] btrfs: exclude mmaps while doing remap
Message-ID: <20201215202315.GA6905@magnolia>
References: <cover.1607969636.git.josef@toxicpanda.com>
 <d4234012acb7ecbdaa4aec9a9a6057ec596c6415.1607969636.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4234012acb7ecbdaa4aec9a9a6057ec596c6415.1607969636.git.josef@toxicpanda.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012150136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012150136
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Dec 14, 2020 at 01:19:40PM -0500, Josef Bacik wrote:
> Darrick reported a potential issue to me where we could allow mmap
> writes after validating a page range matched in the case of dedupe.
> Generally we rely on lock page -> lock extent with the ordered flush to
> protect us, but this is done after we check the pages because we use the
> generic helpers, so we could modify the page in between doing the check
> and locking the range.

FWIW I only found that via code inspection because Matthew Wilcox asked
me about whether or not filesystems did the right thing.  I wrote the
attached fstest to try to demonstrate the problem on btrfs but it
actually passes on xfs and btrfs.  This means either that (a) btrfs is
doing it right through some other means because I don't understand its
locking or (b) the test is wrong.

The test /does/ explode as expected on ocfs2 because mmap io lol there.

--D

From: Darrick J. Wong <darrick.wong@oracle.com>
Subject: [PATCH] generic: test file writers racing with FIDEDUPERANGE

Create a test to make sure that dedupe actually locks the file ranges
correctly before starting the content comparison and keeps them locked
until the operation completes.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 src/Makefile          |    2 
 src/deduperace.c      |  370 +++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/949     |   51 +++++++
 tests/generic/949.out |    2 
 tests/generic/group   |    1 
 5 files changed, 425 insertions(+), 1 deletion(-)
 create mode 100644 src/deduperace.c
 create mode 100755 tests/generic/949
 create mode 100644 tests/generic/949.out

diff --git a/src/Makefile b/src/Makefile
index 5b9781c5..2875e8ef 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -21,7 +21,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
 
 LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
-	locktest unwritten_mmap bulkstat_unlink_test \
+	locktest unwritten_mmap bulkstat_unlink_test deduperace \
 	bulkstat_unlink_test_modified t_dir_offset t_futimens t_immutable \
 	stale_handle pwrite_mmap_blocked t_dir_offset2 seek_sanity_test \
 	seek_copy_test t_readdir_1 t_readdir_2 fsync-tester nsexec cloner \
diff --git a/src/deduperace.c b/src/deduperace.c
new file mode 100644
index 00000000..88c0b6b9
--- /dev/null
+++ b/src/deduperace.c
@@ -0,0 +1,370 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Oracle.
+ * Author: Darrick J. Wong <darrick.wong@oracle.com>
+ *
+ * Race pwrite/mwrite with dedupe to see if we got the locking right.
+ *
+ * File writes and mmap writes should not be able to change the src_fd's
+ * contents after dedupe prep has verified that the file contents are the same.
+ */
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <sys/ioctl.h>
+#include <linux/fs.h>
+#include <string.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <pthread.h>
+#include <stdlib.h>
+#include <errno.h>
+
+#define GOOD_BYTE		0x58
+#define BAD_BYTE		0x66
+
+#ifndef FIDEDUPERANGE
+/* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
+#define FILE_DEDUPE_RANGE_SAME		0
+#define FILE_DEDUPE_RANGE_DIFFERS	1
+
+/* from struct btrfs_ioctl_file_extent_same_info */
+struct file_dedupe_range_info {
+	__s64 dest_fd;		/* in - destination file */
+	__u64 dest_offset;	/* in - start of extent in destination */
+	__u64 bytes_deduped;	/* out - total # of bytes we were able
+				 * to dedupe from this file. */
+	/* status of this dedupe operation:
+	 * < 0 for error
+	 * == FILE_DEDUPE_RANGE_SAME if dedupe succeeds
+	 * == FILE_DEDUPE_RANGE_DIFFERS if data differs
+	 */
+	__s32 status;		/* out - see above description */
+	__u32 reserved;		/* must be zero */
+};
+
+/* from struct btrfs_ioctl_file_extent_same_args */
+struct file_dedupe_range {
+	__u64 src_offset;	/* in - start of extent in source */
+	__u64 src_length;	/* in - length of extent */
+	__u16 dest_count;	/* in - total elements in info array */
+	__u16 reserved1;	/* must be zero */
+	__u32 reserved2;	/* must be zero */
+	struct file_dedupe_range_info info[0];
+};
+#define FIDEDUPERANGE	_IOWR(0x94, 54, struct file_dedupe_range)
+#endif /* FIDEDUPERANGE */
+
+static int fd1, fd2;
+static loff_t offset = 37; /* Nice low offset to trick the compare */
+static loff_t blksz;
+
+/* Continuously dirty the pagecache for the region being dupe-tested. */
+void *
+mwriter(
+	void		*data)
+{
+	volatile char	*p;
+
+	p = mmap(NULL, blksz, PROT_WRITE, MAP_SHARED, fd1, 0);
+	if (p == MAP_FAILED) {
+		perror("mmap");
+		exit(2);
+	}
+
+	while (1) {
+		*(p + offset) = BAD_BYTE;
+		*(p + offset) = GOOD_BYTE;
+	}
+}
+
+/* Continuously write to the region being dupe-tested. */
+void *
+pwriter(
+	void		*data)
+{
+	char		v;
+	ssize_t		sz;
+
+	while (1) {
+		v = BAD_BYTE;
+		sz = pwrite(fd1, &v, sizeof(v), offset);
+		if (sz != sizeof(v)) {
+			perror("pwrite0");
+			exit(2);
+		}
+
+		v = GOOD_BYTE;
+		sz = pwrite(fd1, &v, sizeof(v), offset);
+		if (sz != sizeof(v)) {
+			perror("pwrite1");
+			exit(2);
+		}
+	}
+
+	return NULL;
+}
+
+static inline void
+complain(
+	loff_t	offset,
+	char	bad)
+{
+	fprintf(stderr, "ASSERT: offset %llu should be 0x%x, got 0x%x!\n",
+			(unsigned long long)offset, GOOD_BYTE, bad);
+	abort();
+}
+
+/* Make sure the destination file pagecache never changes. */
+void *
+mreader(
+	void		*data)
+{
+	volatile char	*p;
+
+	p = mmap(NULL, blksz, PROT_READ, MAP_SHARED, fd2, 0);
+	if (p == MAP_FAILED) {
+		perror("mmap");
+		exit(2);
+	}
+
+	while (1) {
+		if (*(p + offset) != GOOD_BYTE)
+			complain(offset, *(p + offset));
+	}
+}
+
+/* Make sure the destination file never changes. */
+void *
+preader(
+	void		*data)
+{
+	char		v;
+	ssize_t		sz;
+
+	while (1) {
+		sz = pread(fd2, &v, sizeof(v), offset);
+		if (sz != sizeof(v)) {
+			perror("pwrite0");
+			exit(2);
+		}
+
+		if (v != GOOD_BYTE)
+			complain(offset, v);
+	}
+
+	return NULL;
+}
+
+void
+print_help(const char *progname)
+{
+	printf("Usage: %s [-b blksz] [-c dir] [-n nr_ops] [-o offset] [-r] [-w] [-v]\n",
+			progname);
+	printf("-b sets the block size (default is autoconfigured)\n");
+	printf("-c chdir to this path before starting\n");
+	printf("-n controls the number of dedupe ops (default 10000)\n");
+	printf("-o reads and writes to this offset (default 37)\n");
+	printf("-r uses pread instead of mmap read.\n");
+	printf("-v prints status updates.\n");
+	printf("-w uses pwrite instead of mmap write.\n");
+}
+
+int
+main(
+	int		argc,
+	char		*argv[])
+{
+	struct file_dedupe_range *fdr;
+	char		*Xbuf;
+	void		*(*reader_fn)(void *) = mreader;
+	void		*(*writer_fn)(void *) = mwriter;
+	unsigned long	same = 0;
+	unsigned long	differs = 0;
+	unsigned long	i, nr_ops = 10000;
+	ssize_t		sz;
+	pthread_t	reader, writer;
+	int		verbose = 0;
+	int		c;
+	int		ret;
+
+	while ((c = getopt(argc, argv, "b:c:n:o:rvw")) != -1) {
+		switch (c) {
+		case 'b':
+			errno = 0;
+			blksz = strtoul(optarg, NULL, 0);
+			if (errno) {
+				perror(optarg);
+				exit(1);
+			}
+			break;
+		case 'c':
+			ret = chdir(optarg);
+			if (ret) {
+				perror("chdir");
+				exit(1);
+			}
+			break;
+		case 'n':
+			errno = 0;
+			nr_ops = strtoul(optarg, NULL, 0);
+			if (errno) {
+				perror(optarg);
+				exit(1);
+			}
+			break;
+		case 'o':
+			errno = 0;
+			offset = strtoul(optarg, NULL, 0);
+			if (errno) {
+				perror(optarg);
+				exit(1);
+			}
+			break;
+		case 'r':
+			reader_fn = preader;
+			break;
+		case 'v':
+			verbose = 1;
+			break;
+		case 'w':
+			writer_fn = pwriter;
+			break;
+		default:
+			print_help(argv[0]);
+			exit(1);
+			break;
+		}
+	}
+
+	fdr = malloc(sizeof(struct file_dedupe_range) +
+			sizeof(struct file_dedupe_range_info));
+	if (!fdr) {
+		perror("malloc");
+		exit(1);
+	}
+
+	/* Initialize both files. */
+	fd1 = open("file1", O_RDWR | O_CREAT | O_TRUNC | O_NOATIME, 0600);
+	if (fd1 < 0) {
+		perror("file1");
+		exit(1);
+	}
+
+	fd2 = open("file2", O_RDWR | O_CREAT | O_TRUNC | O_NOATIME, 0600);
+	if (fd2 < 0) {
+		perror("file2");
+		exit(1);
+	}
+
+	if (blksz <= 0) {
+		struct stat	statbuf;
+
+		ret = fstat(fd1, &statbuf);
+		if (ret) {
+			perror("file1 stat");
+			exit(1);
+		}
+		blksz = statbuf.st_blksize;
+	}
+
+	if (offset >= blksz) {
+		fprintf(stderr, "offset (%llu) < blksz (%llu)?\n",
+				(unsigned long long)offset,
+				(unsigned long long)blksz);
+		exit(1);
+	}
+
+	Xbuf = malloc(blksz);
+	if (!Xbuf) {
+		perror("malloc buffer");
+		exit(1);
+	}
+	memset(Xbuf, GOOD_BYTE, blksz);
+
+	sz = pwrite(fd1, Xbuf, blksz, 0);
+	if (sz != blksz) {
+		perror("file1 write");
+		exit(1);
+	}
+
+	sz = pwrite(fd2, Xbuf, blksz, 0);
+	if (sz != blksz) {
+		perror("file2 write");
+		exit(1);
+	}
+
+	ret = fsync(fd1);
+	if (ret) {
+		perror("file1 fsync");
+		exit(1);
+	}
+
+	ret = fsync(fd2);
+	if (ret) {
+		perror("file2 fsync");
+		exit(1);
+	}
+
+	/* Start our reader and writer threads. */
+	ret = pthread_create(&reader, NULL, reader_fn, NULL);
+	if (ret) {
+		fprintf(stderr, "rthread: %s\n", strerror(ret));
+		exit(1);
+	}
+
+	ret = pthread_create(&writer, NULL, writer_fn, NULL);
+	if (ret) {
+		fprintf(stderr, "wthread: %s\n", strerror(ret));
+		exit(1);
+	}
+
+	/*
+	 * Now start deduping.  If the contents match, fd1's blocks will be
+	 * remapped into fd2, which is why the writer thread targets fd1 and
+	 * the reader checks fd2 to make sure that none of fd1's writes ever
+	 * make it into fd2.
+	 */
+	for (i = 1; i <= nr_ops; i++) {
+		fdr->src_offset = 0;
+		fdr->src_length = blksz;
+		fdr->dest_count = 1;
+		fdr->reserved1 = 0;
+		fdr->reserved2 = 0;
+		fdr->info[0].dest_fd = fd2;
+		fdr->info[0].dest_offset = 0;
+		fdr->info[0].reserved = 0;
+
+		ret = ioctl(fd1, FIDEDUPERANGE, fdr);
+		if (ret) {
+			perror("dedupe");
+			exit(2);
+		}
+
+		switch (fdr->info[0].status) {
+		case FILE_DEDUPE_RANGE_DIFFERS:
+			differs++;
+			break;
+		case FILE_DEDUPE_RANGE_SAME:
+			same++;
+			break;
+		default:
+			fprintf(stderr, "deduperange: %s\n",
+					strerror(-fdr->info[0].status));
+			exit(2);
+			break;
+		}
+
+		if (verbose && (i % 337) == 0)
+			printf("nr_ops: %lu; same: %lu; differs: %lu\n",
+					i, same, differs);
+	}
+
+	if (verbose)
+		printf("nr_ops: %lu; same: %lu; differs: %lu\n", i - 1, same,
+				differs);
+
+	/* Program termination will kill the threads and close the files. */
+	return 0;
+}
diff --git a/tests/generic/949 b/tests/generic/949
new file mode 100755
index 00000000..b827fcaa
--- /dev/null
+++ b/tests/generic/949
@@ -0,0 +1,51 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2020, Oracle.  All Rights Reserved.
+#
+# FS QA Test No. 949
+#
+# Make sure that mmap and file writers racing with FIDEDUPERANGE cannot write
+# to the file after the dedupe prep function has decided that the file contents
+# are identical and we can therefore go ahead with the remapping.
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1    # failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/reflink
+
+# real QA test starts here
+_supported_fs generic
+_require_scratch_dedupe
+
+rm -f $seqres.full
+
+nr_ops=$((TIME_FACTOR * 10000))
+
+# Format filesystem
+_scratch_mkfs > $seqres.full
+_scratch_mount
+
+# Test once with mmap writes
+$here/src/deduperace -c $SCRATCH_MNT -n $nr_ops
+
+# Test again with pwrites for the lulz
+$here/src/deduperace -c $SCRATCH_MNT -n $nr_ops -w
+
+echo Silence is golden.
+# success, all done
+status=0
+exit
diff --git a/tests/generic/949.out b/tests/generic/949.out
new file mode 100644
index 00000000..2998b46c
--- /dev/null
+++ b/tests/generic/949.out
@@ -0,0 +1,2 @@
+QA output created by 949
+Silence is golden.
diff --git a/tests/generic/group b/tests/generic/group
index fe196f0a..364c011d 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -628,6 +628,7 @@
 722 auto quick atime bigtime shutdown
 947 auto quick rw clone
 948 auto quick rw copy_range
+949 auto quick rw dedupe clone
 1200 auto quick swapext quota
 1201 auto quick swapext quota
 1202 auto quick swapext
