Return-Path: <linux-btrfs+bounces-17216-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA89BA33CE
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 11:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDE6D7B4020
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 09:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C09429C343;
	Fri, 26 Sep 2025 09:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CDYXLUjX";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CDYXLUjX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F6D29DB61
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Sep 2025 09:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758880236; cv=none; b=rzE7yr/ejE42GF3gKu0016GevsL9m4qVbqGkxf16T66eUQ0g2NWq3aEBKm4HuR1HQbXENmvnI/npDWqoC6BzvEBJPnqLooMtuifVSrLq9tS+db2w0Lv5YlnjEMBVvGH6DDO9u4uQE88KQ7A8rZku1l2g1bgleKPBDNBfeXNyQKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758880236; c=relaxed/simple;
	bh=oEQlKW35iNKFf2sA2tyo0WK1/3jMuVX0VmhUW1Bg3Lg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=eeGr5O9QjE0le0o/zVPlBOAKaYbDYIo8DNE+KvQlVZFFtLCEZGmJDQP29ED4v3pQCS03V3FZF+KI/W4WKJEDAmfQiTOtpbfGC6OzX7NnXue/hQavaXIJONwyN10pSZdUvuhQD3tu7SGlSElER2AcjmHYz2X5UwztodPi8jxWDSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CDYXLUjX; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=CDYXLUjX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 858F46B0FD;
	Fri, 26 Sep 2025 09:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758880232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vs79qjPDPYxdVCjM3Kmmn1kWvXqzYuqmc40KfNOqIW4=;
	b=CDYXLUjXL3D0TOkWAhgRdt70HYv4R07DMQcE3Oc/l+jYWY+0zOkpJYHjx6X8RbRlGMTZle
	fIeTTXAist8PH9LFQEKB8qNVYOq50Hg2Bw3EjLkJJZWwJaQ1xFoFx5yYXnW/Y/Pl4IMmZ3
	rla7qmPTF3ro0bbHIJATJXuDzLT4WG4=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=CDYXLUjX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758880232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=vs79qjPDPYxdVCjM3Kmmn1kWvXqzYuqmc40KfNOqIW4=;
	b=CDYXLUjXL3D0TOkWAhgRdt70HYv4R07DMQcE3Oc/l+jYWY+0zOkpJYHjx6X8RbRlGMTZle
	fIeTTXAist8PH9LFQEKB8qNVYOq50Hg2Bw3EjLkJJZWwJaQ1xFoFx5yYXnW/Y/Pl4IMmZ3
	rla7qmPTF3ro0bbHIJATJXuDzLT4WG4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 884121373E;
	Fri, 26 Sep 2025 09:50:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NhbCEudh1mgbEgAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 26 Sep 2025 09:50:31 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: add a new generic test case to verify direct io read
Date: Fri, 26 Sep 2025 19:20:13 +0930
Message-ID: <20250926095013.136988-1-wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 858F46B0FD
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

[POSSIBLE PROBLEM]
For filesystems with data checksum, a user space program can provide a
block of aligned memory as read buffer, and modify the buffer during the
read.

Btrfs used to utilize such memory directly during checksum
verification, and since the content can be modified by user space, the
checksum verification can fail easily when such modification happened.

This will cause a false checksum mismatch alert, and if there is no more
mirror, the read will fail.
And even if there is an extra mirror, checksum verification can still
fail due to user space interference.

[NEW TEST CASE]
The new test case is pretty much the same as the existing generic/761,
utilizing a user space multi-thread program to do a direct read,
meanwhile modifying the buffer at the same time.

The new program, dio-read-race, is almost the same, with some changes:

- O_RDRW flag to open the file
- Populate the contents of the file
- Do read and modify
  Instead of write and modify

[EXPECTED RESULTS]
For unpatched kernels, the new test case fails like this:

 generic/772       - output mismatch (see /home/adam/xfstests/results//generic/772.out.bad)
     --- tests/generic/772.out	2025-09-26 19:07:37.319000000 +0930
     +++ /home/adam/xfstests/results//generic/772.out.bad	2025-09-26 19:08:33.873401495 +0930
     @@ -1,2 +1,3 @@
      QA output created by 772
     +io thread failed
      Silence is golden
     ...
     (Run 'diff -u /home/adam/xfstests/tests/generic/772.out /home/adam/xfstests/results//generic/772.out.bad'  to see the entire diff)

 HINT: You _MAY_ be missing kernel fix:
       xxxxxxxxxxxx btrfs: fallback to buffered read if the inode has data checksum

With dmesg recording some checksum mismatch:

 BTRFS warning (device dm-3): csum failed root 5 ino 257 off 241664 csum 0x13fec125 expected csum 0x8941f998 mirror 1
 BTRFS error (device dm-3): bdev /dev/mapper/test-scratch1 errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
 BTRFS warning (device dm-3): direct IO failed ino 257 op 0x8800 offset 0x3b000 len 4096 err no 10

For patched kernels, the new test case passes, without any error in
dmesg:

 generic/772 6s ...  6s

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .gitignore            |   1 +
 src/Makefile          |   2 +-
 src/dio-read-race.c   | 167 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/772     |  41 +++++++++++
 tests/generic/772.out |   2 +
 5 files changed, 212 insertions(+), 1 deletion(-)
 create mode 100644 src/dio-read-race.c
 create mode 100755 tests/generic/772
 create mode 100644 tests/generic/772.out

diff --git a/.gitignore b/.gitignore
index 82c57f41..3e950079 100644
--- a/.gitignore
+++ b/.gitignore
@@ -210,6 +210,7 @@ tags
 /src/fiemap-fault
 /src/min_dio_alignment
 /src/dio-writeback-race
+/src/dio-read-race
 /src/unlink-fsync
 /src/file_attr
 
diff --git a/src/Makefile b/src/Makefile
index 711dbb91..e7dd4db5 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -21,7 +21,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
 	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
 	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test \
 	readdir-while-renames dio-append-buf-fault dio-write-fsync-same-fd \
-	dio-writeback-race unlink-fsync
+	dio-writeback-race dio-read-race unlink-fsync
 
 LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
diff --git a/src/dio-read-race.c b/src/dio-read-race.c
new file mode 100644
index 00000000..7c6389e0
--- /dev/null
+++ b/src/dio-read-race.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * dio-read-race -- test direct IO read with the contents of
+ * the buffer changed during the read, which should not cause any read error.
+ *
+ * Copyright (C) 2025 SUSE Linux Products GmbH.
+ */
+
+/*
+ * dio-read-race
+ *
+ * Compile:
+ *
+ *   gcc -Wall -pthread -o dio-read-race dio-read-race.c
+ *
+ * Make sure filesystems with explicit data checksum can handle direct IO
+ * reads correctly, so that even the contents of the direct IO buffer changes
+ * during read, the fs should still work fine without data checksum mismatch.
+ * (Normally by falling back to buffer IO to keep the checksum and contents
+ *  consistent)
+ *
+ * Usage:
+ *
+ *   dio-read-race [-b <buffersize>] [-s <filesize>] <filename>
+ *
+ * Where:
+ *
+ *   <filename> is the name of the test file to create, if the file exists
+ *   it will be overwritten.
+ *
+ *   <buffersize> is the buffer size for direct IO. Users are responsible to
+ *   probe the correct direct IO size and alignment requirement.
+ *   If not specified, the default value will be 4096.
+ *
+ *   <filesize> is the total size of the test file. If not aligned to <blocksize>
+ *   the result file size will be rounded up to <blocksize>.
+ *   If not specified, the default value will be 64MiB.
+ */
+
+#include <fcntl.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <pthread.h>
+#include <unistd.h>
+#include <getopt.h>
+#include <string.h>
+#include <errno.h>
+#include <sys/stat.h>
+
+static int fd = -1;
+static void *buf = NULL;
+static unsigned long long filesize = 64 * 1024 * 1024;
+static int blocksize = 4096;
+
+const int orig_pattern = 0x00;
+const int modify_pattern = 0xff;
+
+static void *do_io(void *arg)
+{
+	ssize_t ret;
+
+	ret = read(fd, buf, blocksize);
+	pthread_exit((void *)ret);
+}
+
+static void *do_modify(void *arg)
+{
+	memset(buf, modify_pattern, blocksize);
+	pthread_exit(NULL);
+}
+
+int main (int argc, char *argv[])
+{
+	pthread_t io_thread;
+	pthread_t modify_thread;
+	unsigned long long filepos;
+	int opt;
+	int ret = -EINVAL;
+
+	while ((opt = getopt(argc, argv, "b:s:")) > 0) {
+		switch (opt) {
+		case 'b':
+			blocksize = atoi(optarg);
+			if (blocksize == 0) {
+				fprintf(stderr, "invalid blocksize '%s'\n", optarg);
+				goto error;
+			}
+			break;
+		case 's':
+			filesize = atoll(optarg);
+			if (filesize == 0) {
+				fprintf(stderr, "invalid filesize '%s'\n", optarg);
+				goto error;
+			}
+			break;
+		default:
+			fprintf(stderr, "unknown option '%c'\n", opt);
+			goto error;
+		}
+	}
+	if (optind >= argc) {
+		fprintf(stderr, "missing argument\n");
+		goto error;
+	}
+	ret = posix_memalign(&buf, sysconf(_SC_PAGESIZE), blocksize);
+	if (!buf) {
+		fprintf(stderr, "failed to allocate aligned memory\n");
+		exit(EXIT_FAILURE);
+	}
+	fd = open(argv[optind], O_DIRECT | O_RDWR | O_CREAT, 0600);
+	if (fd < 0) {
+		fprintf(stderr, "failed to open file '%s': %m\n", argv[optind]);
+		goto error;
+	}
+
+	memset(buf, orig_pattern, blocksize);
+	/* Create the original file. */
+	for (filepos = 0; filepos < filesize; filepos += blocksize) {
+
+		ret = write(fd, buf, blocksize);
+		if (ret < 0) {
+			ret = -errno;
+			fprintf(stderr, "failed to write the initial content: %m");
+			goto error;
+		}
+	}
+	ret = lseek(fd, 0, SEEK_SET);
+	if (ret < 0) {
+		ret = -errno;
+		fprintf(stderr, "failed to set file offset to 0: %m");
+		goto error;
+	}
+
+	/* Do the read race. */
+	for (filepos = 0; filepos < filesize; filepos += blocksize) {
+		void *retval = NULL;
+
+		memset(buf, orig_pattern, blocksize);
+		pthread_create(&io_thread, NULL, do_io, NULL);
+		pthread_create(&modify_thread, NULL, do_modify, NULL);
+		ret = pthread_join(io_thread, &retval);
+		if (ret) {
+			errno = ret;
+			ret = -ret;
+			fprintf(stderr, "failed to join io thread: %m\n");
+			goto error;
+		}
+		if ((ssize_t )retval < blocksize) {
+			ret = -EIO;
+			fprintf(stderr, "io thread failed\n");
+			goto error;
+		}
+		ret = pthread_join(modify_thread, NULL);
+		if (ret) {
+			errno = ret;
+			ret = -ret;
+			fprintf(stderr, "failed to join modify thread: %m\n");
+			goto error;
+		}
+	}
+error:
+	close(fd);
+	free(buf);
+	if (ret < 0)
+		return EXIT_FAILURE;
+	return EXIT_SUCCESS;
+}
diff --git a/tests/generic/772 b/tests/generic/772
new file mode 100755
index 00000000..46593536
--- /dev/null
+++ b/tests/generic/772
@@ -0,0 +1,41 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 2025 SUSE Linux Products GmbH.  All Rights Reserved.
+#
+# FS QA Test 772
+#
+# Making sure direct IO (O_DIRECT) reads won't cause any data checksum mismatch,
+# even if the contents of the buffer changes during read.
+#
+# This is mostly for filesystems with data checksum support, as the content can
+# be modified by user space during checksum verification.
+#
+# To avoid such false alerts, such filesystems should fallback to buffer IO to
+# avoid inconsistency, and never trust user space memory when checksum is involved.
+# For filesystems without data checksum support, nothing needs to be bothered.
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+_require_scratch
+_require_odirect
+_require_test_program dio-read-race
+
+
+[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: fallback to buffered read if the inode has data checksum"
+
+_scratch_mkfs > $seqres.full 2>&1
+_scratch_mount
+
+blocksize=$(_get_file_block_size $SCRATCH_MNT)
+filesize=$(( 64 * 1024 * 1024))
+
+echo "blocksize=$blocksize filesize=$filesize" >> $seqres.full
+
+$here/src/dio-read-race -b $blocksize -s $filesize $SCRATCH_MNT/foobar
+
+echo "Silence is golden"
+
+# success, all done
+_exit 0
diff --git a/tests/generic/772.out b/tests/generic/772.out
new file mode 100644
index 00000000..98c13968
--- /dev/null
+++ b/tests/generic/772.out
@@ -0,0 +1,2 @@
+QA output created by 772
+Silence is golden
-- 
2.51.0


