Return-Path: <linux-btrfs+bounces-7683-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A0C96534D
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 01:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7CB8283860
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 23:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD671BAEDE;
	Thu, 29 Aug 2024 23:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzemmP4K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A148D1B5EDB;
	Thu, 29 Aug 2024 23:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724973028; cv=none; b=b62UZ5JhCu1AZcBH0t8pgD+hjzqMPHpLoEgacMKbBzCH19YpF1SK4BjEDXmEBvyLP7kUssa9D9sIwMr1Y71Zpl+8wBQOZX0bbMYC/n6JYrs2AkPSfHTJuRwuV73DPb2ppHMGubXzD1cZLGKES2hFdiZMGU3hdwdoEBb81QJLvek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724973028; c=relaxed/simple;
	bh=wUqwRRYSyL42V5H8QnxjWAMVj77WGW5UUTA4H+GDSik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pi+QOdyx0QbxZ7b+UT+Jt/PjK+xRLA0lmmNFs38Vhgdc20S7N2PCIMrG05Qx3hlFDtj74thJ9kLvQKXQs9BOMyS0ZrCyunUlw8OADj+newmtWCLrrkoA4D/fk09sttzk7UX5s3UTI/MwHCTJD0odAj2WlRodtUYky4xOn+1qHFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzemmP4K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D7DC4CEC1;
	Thu, 29 Aug 2024 23:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724973028;
	bh=wUqwRRYSyL42V5H8QnxjWAMVj77WGW5UUTA4H+GDSik=;
	h=From:To:Cc:Subject:Date:From;
	b=IzemmP4KFsO9kbTeG+pvc4P30ceWdBLi1UCUOzOdiRT8cZzNOR2TrCftDvNPThhRR
	 yt9DOOZiiloQLgtiMmUa8CAIAcX2iMZaSS3P8ktcfCfnPDIX47fTJV9O+Sp2DKa2I4
	 a4iPvwuiQu0jqKIEPNBvTipZeki9k+u2ZIDSTA9yC2r3o0Wrvkx2G+kciMriaYgcsk
	 EIl6MVQmtZIMOZ2QTevr8eeAX44H+YbjzR/81x43qXUzcSRMvJ4RRWd5ojSHqu+d4a
	 BNbt0Io3l99PZrSt7P2U7Y2f2DWRipJQPon4mKDgvA1FfwOH1O2YnvR96XhIb3Cg9C
	 tWJl4R8BQ3FWg==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] generic: test concurrent direct IO writes and fsync using same fd
Date: Fri, 30 Aug 2024 00:10:21 +0100
Message-ID: <fa20c58b1a711d9da9899b895a5237f8737163af.1724972803.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Test that a program that has 2 threads using the same file descriptor and
concurrently doing direct IO writes and fsync doesn't trigger any crash
or deadlock.

This is motivated by a bug found in btrfs fixed by the following patch:

  "btrfs: fix race between direct IO write and fsync when using same fd"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 .gitignore                    |   1 +
 src/Makefile                  |   2 +-
 src/dio-write-fsync-same-fd.c | 106 ++++++++++++++++++++++++++++++++++
 tests/generic/363             |  30 ++++++++++
 tests/generic/363.out         |   2 +
 5 files changed, 140 insertions(+), 1 deletion(-)
 create mode 100644 src/dio-write-fsync-same-fd.c
 create mode 100755 tests/generic/363
 create mode 100644 tests/generic/363.out

diff --git a/.gitignore b/.gitignore
index 36083e9d..57519263 100644
--- a/.gitignore
+++ b/.gitignore
@@ -76,6 +76,7 @@ tags
 /src/dio-buf-fault
 /src/dio-interleaved
 /src/dio-invalidate-cache
+/src/dio-write-fsync-same-fd
 /src/dirhash_collide
 /src/dirperf
 /src/dirstress
diff --git a/src/Makefile b/src/Makefile
index b3da59a0..b9ad6b5f 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -20,7 +20,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
 	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
 	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
 	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test \
-	readdir-while-renames dio-append-buf-fault
+	readdir-while-renames dio-append-buf-fault dio-write-fsync-same-fd
 
 LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
diff --git a/src/dio-write-fsync-same-fd.c b/src/dio-write-fsync-same-fd.c
new file mode 100644
index 00000000..79472a9e
--- /dev/null
+++ b/src/dio-write-fsync-same-fd.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 SUSE Linux Products GmbH.  All Rights Reserved.
+ */
+
+/*
+ * Test two threads working with the same file descriptor, one doing direct IO
+ * writes into the file and the other just doing fsync calls. We want to verify
+ * that there are no crashes or deadlocks.
+ *
+ * This program never finishes, it starts two infinite loops to write and fsync
+ * the file. It's meant to be called with the 'timeout' program from coreutils.
+ */
+
+/* Get the O_DIRECT definition. */
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <stdint.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <string.h>
+#include <pthread.h>
+
+static int fd;
+
+static ssize_t do_write(int fd, const void *buf, size_t count, off_t offset)
+{
+        while (count > 0) {
+		ssize_t ret;
+
+		ret = pwrite(fd, buf, count, offset);
+		if (ret < 0) {
+			if (errno == EINTR)
+				continue;
+			return ret;
+		}
+		count -= ret;
+		buf += ret;
+	}
+	return 0;
+}
+
+static void *fsync_loop(void *arg)
+{
+	while (1) {
+		int ret;
+
+		ret = fsync(fd);
+		if (ret != 0) {
+			perror("Fsync failed");
+			exit(6);
+		}
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	long pagesize;
+	void *write_buf;
+	pthread_t fsyncer;
+	int ret;
+
+	if (argc != 2) {
+		fprintf(stderr, "Use: %s <file path>\n", argv[0]);
+		return 1;
+	}
+
+	fd = open(argv[1], O_WRONLY | O_CREAT | O_TRUNC | O_DIRECT, 0666);
+	if (fd == -1) {
+		perror("Failed to open/create file");
+		return 1;
+	}
+
+	pagesize = sysconf(_SC_PAGE_SIZE);
+	if (pagesize == -1) {
+		perror("Failed to get page size");
+		return 2;
+	}
+
+	ret = posix_memalign(&write_buf, pagesize, pagesize);
+	if (ret) {
+		perror("Failed to allocate buffer");
+		return 3;
+	}
+
+	ret = pthread_create(&fsyncer, NULL, fsync_loop, NULL);
+	if (ret != 0) {
+		fprintf(stderr, "Failed to create writer thread: %d\n", ret);
+		return 4;
+	}
+
+	while (1) {
+		ret = do_write(fd, write_buf, pagesize, 0);
+		if (ret != 0) {
+			perror("Write failed");
+			exit(5);
+		}
+	}
+
+	return 0;
+}
diff --git a/tests/generic/363 b/tests/generic/363
new file mode 100755
index 00000000..21159e24
--- /dev/null
+++ b/tests/generic/363
@@ -0,0 +1,30 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 363
+#
+# Test that a program that has 2 threads using the same file descriptor and
+# concurrently doing direct IO writes and fsync doesn't trigger any crash or
+# deadlock.
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+_require_test
+_require_odirect
+_require_test_program dio-write-fsync-same-fd
+_require_command "$TIMEOUT_PROG" timeout
+
+[ $FSTYP == "btrfs" ] && \
+	_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: fix race between direct IO write and fsync when using same fd"
+
+# On error the test program writes messages to stderr, causing a golden output
+# mismatch and making the test fail.
+$TIMEOUT_PROG 10s $here/src/dio-write-fsync-same-fd $TEST_DIR/dio-write-fsync-same-fd
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/363.out b/tests/generic/363.out
new file mode 100644
index 00000000..d03d2dc2
--- /dev/null
+++ b/tests/generic/363.out
@@ -0,0 +1,2 @@
+QA output created by 363
+Silence is golden
-- 
2.43.0


