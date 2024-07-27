Return-Path: <linux-btrfs+bounces-6796-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DD593DF26
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jul 2024 13:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA6A71F22201
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jul 2024 11:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E61A6BFB0;
	Sat, 27 Jul 2024 11:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ur0b+wgG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6EA41746;
	Sat, 27 Jul 2024 11:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722079704; cv=none; b=tv13de84EdQNxh+BiFCX7Pizxezw1QulTE0k7YcS3nG0BHNQJdxehNObxhgirRiSuNbWJCO/FA6EyLnzuD+hoZ7k5Y5xYbAAtcBtzFl7NtvWzRyI13LklDXNnd6rg9PDqTeA/0p82c+wwB0wyFTCSXWhPjmvSJrERxNdlyVTAv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722079704; c=relaxed/simple;
	bh=HZgSlq6S/eajgi92T+Wb/CGyDFisqji6VMfFkdvEAN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LraTv/thNxybBCTj9RnZzT+UZND8ayTLkiwYafkOacZaO6BbRpM930EYg3CK6VMOxCRqXOuHKl91ytuEatZeG160B0//zNI5/TD6QuiBnjPUn0TavaMoAq5/rTaaDhh7TVOaAOZ+cWDRYQNz0U3r9raI9wY3tSVkM7mfr27GlWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ur0b+wgG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A84C32781;
	Sat, 27 Jul 2024 11:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722079704;
	bh=HZgSlq6S/eajgi92T+Wb/CGyDFisqji6VMfFkdvEAN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ur0b+wgGdNaaqss4Frb6vLNRVWZ4AWF1J/TcPPhY7w2eYMLfieoeNdJASlpsyGGp/
	 rpEEWIf8oLhcMpsgGho6mNgnc6wxGxLYANpXkcRdoH95rGptV2Xju4wSmAzd1eMcNt
	 Q1UEIduD0b6NxDZcpanVJffBOpD9X6JtXhofHMDLZLzwQZAMxgwqmSUY3ERe8reTEI
	 CQjn5Zqv33YNeVgFoTwKi+z2fzcDI2bjUAyPucwYpgqMjRLF1ZDAQr7bThlkSqptmf
	 iO4l4Z1EQYZTvdIMvGSpOJqvmHkUOqZgNCtM1oidjmMOqlWnrTRdfUwyqr/pgQhk2u
	 zZmS6Z9ztDvEw==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2] generic: test page fault during direct IO write with O_APPEND
Date: Sat, 27 Jul 2024 12:28:16 +0100
Message-ID: <6c52fe9ce75354a931afdc6d2f7fb638c7f06b00.1722079321.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <652ec55049e94a59f66f4112fb8707629db3001d.1722008942.git.fdmanana@suse.com>
References: <652ec55049e94a59f66f4112fb8707629db3001d.1722008942.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Test that doing a direct IO append write to a file when the input buffer
was not yet faulted in, does not result in an incorrect file size.

This exercises a bug on btrfs reported by users and which is fixed by
the following kernel patch:

   "btrfs: fix corruption after buffer fault in during direct IO append write"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: Deal with partial writes by looping and writing any remaining data.
    Don't exit when the first test fails, instead let the second test
    run as well.

 .gitignore                 |   1 +
 src/Makefile               |   2 +-
 src/dio-append-buf-fault.c | 145 +++++++++++++++++++++++++++++++++++++
 tests/generic/362          |  28 +++++++
 tests/generic/362.out      |   2 +
 5 files changed, 177 insertions(+), 1 deletion(-)
 create mode 100644 src/dio-append-buf-fault.c
 create mode 100755 tests/generic/362
 create mode 100644 tests/generic/362.out

diff --git a/.gitignore b/.gitignore
index b5f15162..97c7e001 100644
--- a/.gitignore
+++ b/.gitignore
@@ -72,6 +72,7 @@ tags
 /src/deduperace
 /src/detached_mounts_propagation
 /src/devzero
+/src/dio-append-buf-fault
 /src/dio-buf-fault
 /src/dio-interleaved
 /src/dio-invalidate-cache
diff --git a/src/Makefile b/src/Makefile
index 99796137..559209be 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -20,7 +20,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
 	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
 	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
 	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test \
-	readdir-while-renames
+	readdir-while-renames dio-append-buf-fault
 
 LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
diff --git a/src/dio-append-buf-fault.c b/src/dio-append-buf-fault.c
new file mode 100644
index 00000000..72c23265
--- /dev/null
+++ b/src/dio-append-buf-fault.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 SUSE Linux Products GmbH.  All Rights Reserved.
+ */
+
+/*
+ * Test a direct IO write in append mode with a buffer that was not faulted in
+ * (or just partially) before the write.
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
+#include <sys/mman.h>
+#include <sys/stat.h>
+
+static ssize_t do_write(int fd, const void *buf, size_t count)
+{
+        while (count > 0) {
+		ssize_t ret;
+
+		ret = write(fd, buf, count);
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
+int main(int argc, char *argv[])
+{
+	struct stat stbuf;
+	int fd;
+	long pagesize;
+	void *buf;
+	ssize_t ret;
+
+	if (argc != 2) {
+		fprintf(stderr, "Use: %s <file path>\n", argv[0]);
+		return 1;
+	}
+
+	/*
+	 * First try an append write against an empty file of a buffer with a
+	 * size matching the page size. The buffer is not faulted in before
+	 * attempting the write.
+	 */
+
+	fd = open(argv[1], O_WRONLY | O_CREAT | O_TRUNC | O_DIRECT | O_APPEND, 0666);
+	if (fd == -1) {
+		perror("Failed to open/create file");
+		return 2;
+	}
+
+	pagesize = sysconf(_SC_PAGE_SIZE);
+	if (pagesize == -1) {
+		perror("Failed to get page size");
+		return 3;
+	}
+
+	buf = mmap(NULL, pagesize, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (buf == MAP_FAILED) {
+		perror("Failed to allocate first buffer");
+		return 4;
+	}
+
+	ret = do_write(fd, buf, pagesize);
+	if (ret < 0) {
+		perror("First write failed");
+		return 5;
+	}
+
+	ret = fstat(fd, &stbuf);
+	if (ret < 0) {
+		perror("First stat failed");
+		return 6;
+	}
+
+	/* Don't exit on failure so that we run the second test below too. */
+	if (stbuf.st_size != pagesize)
+		fprintf(stderr,
+			"Wrong file size after first write, got %jd expected %ld\n",
+			(intmax_t)stbuf.st_size, pagesize);
+
+	munmap(buf, pagesize);
+	close(fd);
+
+	/*
+	 * Now try an append write against an empty file of a buffer with a
+	 * size matching twice the page size. Only the first page of the buffer
+	 * is faulted in before attempting the write, so that the second page
+	 * should be faulted in during the write.
+	 */
+	fd = open(argv[1], O_WRONLY | O_CREAT | O_TRUNC | O_DIRECT | O_APPEND, 0666);
+	if (fd == -1) {
+		perror("Failed to open/create file");
+		return 7;
+	}
+
+	buf = mmap(NULL, pagesize * 2, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (buf == MAP_FAILED) {
+		perror("Failed to allocate second buffer");
+		return 8;
+	}
+
+	/* Fault in first page of the buffer before the write. */
+	memset(buf, 0, 1);
+
+	ret = do_write(fd, buf, pagesize * 2);
+	if (ret < 0) {
+		perror("Second write failed");
+		return 9;
+	}
+
+	ret = fstat(fd, &stbuf);
+	if (ret < 0) {
+		perror("Second stat failed");
+		return 10;
+	}
+
+	if (stbuf.st_size != pagesize * 2)
+		fprintf(stderr,
+			"Wrong file size after second write, got %jd expected %ld\n",
+			(intmax_t)stbuf.st_size, pagesize * 2);
+
+	munmap(buf, pagesize * 2);
+	close(fd);
+
+	return 0;
+}
diff --git a/tests/generic/362 b/tests/generic/362
new file mode 100755
index 00000000..2c127347
--- /dev/null
+++ b/tests/generic/362
@@ -0,0 +1,28 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 362
+#
+# Test that doing a direct IO append write to a file when the input buffer was
+# not yet faulted in, does not result in an incorrect file size.
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+_require_test
+_require_odirect
+_require_test_program dio-append-buf-fault
+
+[ $FSTYP == "btrfs" ] && \
+	_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: fix corruption after buffer fault in during direct IO append write"
+
+# On error the test program writes messages to stderr, causing a golden output
+# mismatch and making the test fail.
+$here/src/dio-append-buf-fault $TEST_DIR/dio-append-buf-fault
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/362.out b/tests/generic/362.out
new file mode 100644
index 00000000..0ff40905
--- /dev/null
+++ b/tests/generic/362.out
@@ -0,0 +1,2 @@
+QA output created by 362
+Silence is golden
-- 
2.43.0


