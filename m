Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC437A097E
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 17:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241166AbjINPko (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 11:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241158AbjINPkn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 11:40:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677ED1FD2;
        Thu, 14 Sep 2023 08:40:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B11C433C7;
        Thu, 14 Sep 2023 15:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694706039;
        bh=o8MeO5/daz6PUCXbw6nrS8m48LdnT9d1f74accI3vkI=;
        h=From:To:Cc:Subject:Date:From;
        b=PfDCS88PxTqJLWE2DtiYqCIARU+WX85Iw06t3hgmoX9wRfd79H72nr/4PLpi3BRc8
         DSQTuUsOq3r/OneEsV+tLN2ZagrN/aRzOXmY4s7EnZ4oQDUOA0s5lVp1LwJ81tt1uD
         LxEGkvluSjUkptFEOWj+Nq0oQSADLkO2lWyiDGLMl2tZ1IiHFytWSrc3RzdFdTUR8j
         iVxrZYkM6G8VixhNopAsE9GMesPWOiSUCJ2TBlOAakyArjNhbfZ2QYhSCkshzV82Zn
         QosRUPND007v6OARQC1Y9F5k8fqGz7vIfca6EpQpZRfluMI18jHZpF+R1XPykDhHsG
         cm0Ff26gmEiWQ==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] generic: test new directory entries are returned after rewinding directory
Date:   Thu, 14 Sep 2023 16:40:22 +0100
Message-Id: <1888d81c5fad8204dd4948d36291d24f00354b22.1694705838.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test that if names are added to a directory after an opendir(3) call and
before a rewinddir(3) call, future readdir(3) calls will return the names.
This is mandated by POSIX:

  https://pubs.opengroup.org/onlinepubs/007904875/functions/rewinddir.html

This exercises a regression in btrfs which is fixed by a kernel patch that
has the following subject:

  ""btrfs: refresh dir last index during a rewinddir(3) call""

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 .gitignore            |   1 +
 src/Makefile          |   2 +-
 src/rewinddir-test.c  | 159 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/471     |  39 +++++++++++
 tests/generic/471.out |   2 +
 5 files changed, 202 insertions(+), 1 deletion(-)
 create mode 100644 src/rewinddir-test.c
 create mode 100755 tests/generic/471
 create mode 100644 tests/generic/471.out

diff --git a/.gitignore b/.gitignore
index 644290f0..4c32ac42 100644
--- a/.gitignore
+++ b/.gitignore
@@ -124,6 +124,7 @@ tags
 /src/rename
 /src/renameat2
 /src/resvtest
+/src/rewinddir-test
 /src/runas
 /src/seek_copy_test
 /src/seek_sanity_test
diff --git a/src/Makefile b/src/Makefile
index aff871d0..2815f919 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -19,7 +19,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
 	t_ofd_locks t_mmap_collision mmap-write-concurrent \
 	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
 	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
-	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault
+	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test
 
 LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
diff --git a/src/rewinddir-test.c b/src/rewinddir-test.c
new file mode 100644
index 00000000..9f7505a2
--- /dev/null
+++ b/src/rewinddir-test.c
@@ -0,0 +1,159 @@
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
+/*
+ * Number of files we add to the test directory after calling opendir(3) and
+ * before calling rewinddir(3).
+ */
+#define NUM_FILES 10000
+
+int main(int argc, char *argv[])
+{
+	int file_counters[NUM_FILES] = { 0 };
+	int dot_count = 0;
+	int dot_dot_count = 0;
+	struct dirent *entry;
+	DIR *dir = NULL;
+	char *dir_path = NULL;
+	char *file_path = NULL;
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
+	/* More than enough to contain any full file path. */
+	file_path = malloc(strlen(dir_path) + 12);
+	if (!file_path) {
+		fprintf(stderr, "malloc failure\n");
+		ret = ENOMEM;
+		goto out;
+	}
+
+	ret = mkdir(dir_path, 0700);
+	if (ret == -1) {
+		fprintf(stderr, "Failed to create test directory: %d\n", errno);
+		ret = errno;
+		goto out;
+	}
+
+	/* Open the directory first. */
+	dir = opendir(dir_path);
+	if (dir == NULL) {
+		fprintf(stderr, "Failed to open directory: %d\n", errno);
+		ret = errno;
+		goto out;
+	}
+
+	/*
+	 * Now create all files inside the directory.
+	 * File names go from 1 to NUM_FILES, 0 is unused as it's the return
+	 * value for atoi(3) when an error happens.
+	 */
+	for (i = 1; i <= NUM_FILES; i++) {
+		FILE *f;
+
+		sprintf(file_path, "%s/%d", dir_path, i);
+		f = fopen(file_path, "w");
+		if (f == NULL) {
+			fprintf(stderr, "Failed to create file number %d: %d\n",
+				i, errno);
+			ret = errno;
+			goto out;
+		}
+		fclose(f);
+	}
+
+	/*
+	 * Rewind the directory and read it.
+	 * POSIX requires that after a rewind, any new names added to the
+	 * directory after the openddir(3) call and before the rewinddir(3)
+	 * call, must be returned by readdir(3) calls
+	 */
+	rewinddir(dir);
+
+	/*
+	 * readdir(3) returns NULL when it reaches the end of the directory or
+	 * when an error happens, so reset errno to 0 to distinguish between
+	 * both cases later.
+	 */
+	errno = 0;
+	while ((entry = readdir(dir)) != NULL) {
+		if (strcmp(entry->d_name, ".") == 0) {
+			dot_count++;
+			continue;
+		}
+		if (strcmp(entry->d_name, "..") == 0) {
+			dot_dot_count++;
+			continue;
+		}
+		i = atoi(entry->d_name);
+		if (i == 0) {
+			fprintf(stderr,
+				"Failed to parse name '%s' to integer: %d\n",
+				entry->d_name, errno);
+			ret = errno;
+			goto out;
+		}
+		/* File names go from 1 to NUM_FILES, so subtract 1. */
+		file_counters[i - 1]++;
+	}
+
+	if (errno) {
+		fprintf(stderr, "Failed to read directory: %d\n", errno);
+		ret = errno;
+		goto out;
+	}
+
+	/*
+	 * Now check that the readdir() calls return every single file name
+	 * and without repeating any of them. If any name is missing or
+	 * repeated, don't exit immediatelly, so that we print a message for
+	 * all missing or repeated names.
+	 */
+	for (i = 0; i < NUM_FILES; i++) {
+		if (file_counters[i] != 1) {
+			fprintf(stderr, "File name %d appeared %d times\n",
+				i + 1,  file_counters[i]);
+			ret = EINVAL;
+		}
+	}
+	if (dot_count != 1) {
+		fprintf(stderr, "File name . appeared %d times\n", dot_count);
+		ret = EINVAL;
+	}
+	if (dot_dot_count != 1) {
+		fprintf(stderr, "File name .. appeared %d times\n", dot_dot_count);
+		ret = EINVAL;
+	}
+out:
+	free(dir_path);
+	free(file_path);
+	if (dir != NULL)
+		closedir(dir);
+
+	return ret;
+}
diff --git a/tests/generic/471 b/tests/generic/471
new file mode 100755
index 00000000..15dc89f3
--- /dev/null
+++ b/tests/generic/471
@@ -0,0 +1,39 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 471
+#
+# Test that if names are added to a directory after an opendir(3) call and
+# before a rewinddir(3) call, future readdir(3) calls will return the names.
+# This is mandated by POSIX:
+#
+# https://pubs.opengroup.org/onlinepubs/007904875/functions/rewinddir.html
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+_cleanup()
+{
+	cd /
+	rm -fr $tmp.*
+	[ -n "$target_dir" ] && rm -fr $target_dir
+}
+
+_supported_fs generic
+_require_test
+_require_test_program rewinddir-test
+
+[ $FSTYP == "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: refresh dir last index during a rewinddir(3) call"
+
+target_dir="$TEST_DIR/test-$seq"
+rm -fr $target_dir
+mkdir $target_dir
+
+$here/src/rewinddir-test $target_dir
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/471.out b/tests/generic/471.out
new file mode 100644
index 00000000..260f629e
--- /dev/null
+++ b/tests/generic/471.out
@@ -0,0 +1,2 @@
+QA output created by 471
+Silence is golden
-- 
2.40.1

