Return-Path: <linux-btrfs+bounces-648-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C14B805A10
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 17:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6F381F21579
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 16:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D825C8ED;
	Tue,  5 Dec 2023 16:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klmjZcJK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBA57ED;
	Tue,  5 Dec 2023 16:39:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516BAC433C7;
	Tue,  5 Dec 2023 16:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701794367;
	bh=aiDk4xrw2wvXGQzh51loxHNu4L7Wdhjc1iNbZ6sUlE0=;
	h=From:To:Cc:Subject:Date:From;
	b=klmjZcJKYmazo9dvRhAlDXVzTEsY8ENG/DmdM7dEMotUeN4IMcfqGdnrdXd6BGZ2q
	 ciM6F3Evh6lGfDczEE8P983Drnyd4zFpxaENFwaG1OxChmKOuQorOHA1lJQ+15apFR
	 P4bPr30LdYJW7eTtBZYomW2Seu+pZ8VmDUtcyiUZoLuiospN3HaVY1CznIhqo0qDA0
	 eHowzhR6NX5EnYDnuEvOukt5Z2VKXdf0Iz4ayxVQtn4MCMVZdmVYI7hFPqu5FUyzD+
	 HAi8wT7RiWeG8cIPJchI5X52HZSFJIA4fJ6rVI4BPrPfUFFm/FRnYl437YFKGyb0fd
	 tda9mjwidoupQ==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] generic: test reading a large directory while renaming its files
Date: Tue,  5 Dec 2023 16:39:20 +0000
Message-Id: <e54239e625f794c62b962c35d06db04571bf73d5.1701794007.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Test that on a fairly large directory if we keep renaming files while
holding the directory open and doing readdir(3) calls, we don't end up
in an infinite loop.

This exercise a bug that existed in btrfs and was fixed in kernel 6.5
by commit 9b378f6ad48c ("btrfs: fix infinite directory reads").

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 .gitignore                  |   1 +
 src/Makefile                |   3 +-
 src/readdir-while-renames.c | 146 ++++++++++++++++++++++++++++++++++++
 tests/generic/734           |  37 +++++++++
 tests/generic/734.out       |   2 +
 5 files changed, 188 insertions(+), 1 deletion(-)
 create mode 100644 src/readdir-while-renames.c
 create mode 100755 tests/generic/734
 create mode 100644 tests/generic/734.out

diff --git a/.gitignore b/.gitignore
index 4c32ac42..7508b6e8 100644
--- a/.gitignore
+++ b/.gitignore
@@ -121,6 +121,7 @@ tags
 /src/punch-alternating
 /src/pwrite_mmap_blocked
 /src/randholes
+/src/readdir-while-renames
 /src/rename
 /src/renameat2
 /src/resvtest
diff --git a/src/Makefile b/src/Makefile
index 8160a0e8..d79015ce 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -19,7 +19,8 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
 	t_ofd_locks t_mmap_collision mmap-write-concurrent \
 	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
 	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
-	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test
+	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test \
+	readdir-while-renames
 
 LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
diff --git a/src/readdir-while-renames.c b/src/readdir-while-renames.c
new file mode 100644
index 00000000..afeefb04
--- /dev/null
+++ b/src/readdir-while-renames.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 SUSE Linux Products GmbH.  All Rights Reserved.
+ */
+#include <dirent.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <unistd.h>
+#include <sys/stat.h>
+
+/* Number of files we add to the test directory. */
+#define NUM_FILES 5000
+
+int main(int argc, char *argv[])
+{
+	struct dirent *entry;
+	DIR *dir = NULL;
+	char *dir_path = NULL;
+	int dentry_count = 0;
+	int ret = 0;
+	int i;
+
+	if (argc != 2) {
+		fprintf(stderr, "Usage:  %s <directory>\n", argv[0]);
+		ret = 1;
+		goto out;
+	}
+
+	dir_path = malloc(strlen(argv[1]) + strlen("/testdir") + 1);
+	if (!dir_path) {
+		fprintf(stderr, "malloc failure\n");
+		ret = ENOMEM;
+		goto out;
+	}
+	i = strlen(argv[1]);
+	memcpy(dir_path, argv[1], i);
+	memcpy(dir_path + i, "/testdir", strlen("/testdir"));
+	dir_path[i + strlen("/testdir")] = '\0';
+
+	ret = mkdir(dir_path, 0700);
+	if (ret == -1) {
+		fprintf(stderr, "Failed to create test directory: %d\n", errno);
+		ret = errno;
+		goto out;
+	}
+
+	ret = chdir(dir_path);
+	if (ret == -1) {
+		fprintf(stderr, "Failed to chdir to the test directory: %d\n", errno);
+		ret = errno;
+		goto out;
+	}
+
+	/* Now create all files inside the directory. */
+	for (i = 1; i <= NUM_FILES; i++) {
+		char file_name[32];
+		FILE *f;
+
+		sprintf(file_name, "%s/%d", dir_path, i);
+		f = fopen(file_name, "w");
+		if (f == NULL) {
+			fprintf(stderr, "Failed to create file number %d: %d\n",
+				i, errno);
+			ret = errno;
+			goto out;
+		}
+		fclose(f);
+	}
+
+	dir = opendir(dir_path);
+	if (dir == NULL) {
+		fprintf(stderr, "Failed to open directory: %d\n", errno);
+		ret = errno;
+		goto out;
+	}
+
+	/*
+	 * readdir(3) returns NULL when it reaches the end of the directory or
+	 * when an error happens, so reset errno to 0 to distinguish between
+	 * both cases later.
+	 */
+	errno = 0;
+	while ((entry = readdir(dir)) != NULL) {
+		dentry_count++;
+		/*
+		 * The actual number of dentries returned varies per filesystem
+		 * implementation. On a 6.7-rc4 kernel, on x86_64 with default
+		 * mkfs options, xfs returns 5031 dentries while ext4, f2fs and
+		 * btrfs return 5002 (the 5000 files plus "." and ".."). These
+		 * variations are fine and valid according to POSIX, as some of
+		 * the renames may be visible or not while calling readdir(3).
+		 * We only want to check we don't enter into an infinite loop,
+		 * so let the maximum number of dentries be 3 * NUM_FILES, which
+		 * is very reasonable.
+		 */
+		if (dentry_count > 3 * NUM_FILES) {
+			fprintf(stderr,
+				"Found too many directory entries (%d)\n",
+				dentry_count);
+			ret = 1;
+			goto out;
+		}
+		/* Can't rename "." and "..", skip them. */
+		if (strcmp(entry->d_name, ".") == 0 ||
+		    strcmp(entry->d_name, "..") == 0)
+			continue;
+		ret = rename(entry->d_name, "TEMPFILE");
+		if (ret == -1) {
+			fprintf(stderr,
+				"Failed to rename '%s' to TEMPFILE: %d\n",
+				entry->d_name, errno);
+			ret = errno;
+			goto out;
+		}
+		ret = rename("TEMPFILE", entry->d_name);
+		if (ret == -1) {
+			fprintf(stderr,
+				"Failed to rename TEMPFILE to '%s': %d\n",
+				entry->d_name, errno);
+			ret = errno;
+			goto out;
+		}
+	}
+
+	if (errno) {
+		fprintf(stderr, "Failed to read directory: %d\n", errno);
+		ret = errno;
+		goto out;
+	}
+
+	/* It should return at least NUM_FILES entries +2 (for "." and ".."). */
+	if (dentry_count < NUM_FILES + 2) {
+		fprintf(stderr,
+			"Found less directory entries than expected (%d but expected %d)\n",
+			dentry_count, NUM_FILES + 2);
+		ret = 2;
+	}
+out:
+	free(dir_path);
+	if (dir != NULL)
+		closedir(dir);
+
+	return ret;
+}
diff --git a/tests/generic/734 b/tests/generic/734
new file mode 100755
index 00000000..ea3dfb2d
--- /dev/null
+++ b/tests/generic/734
@@ -0,0 +1,37 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 734
+#
+# Test that on a fairly large directory if we keep renaming files while holding
+# the directory open and doing readdir(3) calls, we don't end up in an infinite
+# loop.
+#
+. ./common/preamble
+_begin_fstest auto quick dir
+
+_cleanup()
+{
+	cd /
+	rm -fr $tmp.*
+	rm -fr $target_dir
+}
+
+_supported_fs generic
+_require_test
+_require_test_program readdir-while-renames
+
+[ $FSTYP == "btrfs" ] && _fixed_by_kernel_commit 9b378f6ad48c \
+	"btrfs: fix infinite directory reads"
+
+target_dir="$TEST_DIR/test-$seq"
+rm -fr $target_dir
+mkdir $target_dir
+
+$here/src/readdir-while-renames $target_dir
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/734.out b/tests/generic/734.out
new file mode 100644
index 00000000..4299839b
--- /dev/null
+++ b/tests/generic/734.out
@@ -0,0 +1,2 @@
+QA output created by 734
+Silence is golden
-- 
2.40.1


