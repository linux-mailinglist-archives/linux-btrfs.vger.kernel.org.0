Return-Path: <linux-btrfs+bounces-15762-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8ACB166D4
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 21:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EA605861E6
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Jul 2025 19:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DAA2E1744;
	Wed, 30 Jul 2025 19:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biZw80S9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D408B2BCFB;
	Wed, 30 Jul 2025 19:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753903307; cv=none; b=cTw1L9w5oPi7dGrNeanZ+cWEKkY406MzsruAuiRBWKEjglaDm5uiTd6ID3yBl/2SBqjMHs4KRvGKC9VFHJ6E6K8vnOCBNl5t8ch7XGQKrMGChJTeZquWw/lsFzjSzk8eK+l1gIlwCbZi7GOFlr73MRhg2vjhMJGcGIhf+tfZU+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753903307; c=relaxed/simple;
	bh=LUytNnNoqkW0bz7uMHDai1bink9SfNHQfZgLgc49mM8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sAVQO+JhomjGdScgmMTKtk4+9NI+3tUICN/ZgH/KhgtFQkhaaD8xQDnYwpNCwux/rY9+C9JWu8NVftZcaeXGPM6QHvzPg6lc4/DiT+NMrxNGesccY9BVgWvlqRCU9KVOiXSl65Mp2vPl1br1bp+cVerz8eulEqilqcMdM4mAvh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biZw80S9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59360C4CEE3;
	Wed, 30 Jul 2025 19:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753903307;
	bh=LUytNnNoqkW0bz7uMHDai1bink9SfNHQfZgLgc49mM8=;
	h=From:To:Cc:Subject:Date:From;
	b=biZw80S9WIsR3GghkU8vGXmmnJKOqsbuaqBGf5yNL2rSjONQ1sTm/3PHldOkq5hWs
	 F7F5unanWuhShxibLp0zbuC0Z5bCL6i6pXjROV5rh8UsEY20dVStuHbdLlFL8DM9sf
	 v3l9WLfBll6LtsDrgFry7j31dvqCnP1yOCiPIa1YTX9ho6PDio/zoq153dxF5Rc0Nw
	 kRBGGZdg1TvP4I1jr8wSUJ4mOhlOadQ88exNE8QvnHmOcU6JJQYQvmRGwBfIK/u5Xk
	 meUKyUUnWkmp/R5yBkueV11K++RtyQCuu5X2GKitb5iCfk6LwA7meIHeLP/A/leHFh
	 aQGScBE0xd1Pw==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] generic: test fsync of file with 0 links and extents
Date: Wed, 30 Jul 2025 20:21:41 +0100
Message-ID: <ab95518f5483a2e23e0f3cdf1bc67258c0e71918.1753902704.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Create two files, the first one with some data, and then fsync both
files. The first file is fsynced after removing its hardlink. After a
power failure we expect the fs to be mountable and for only the second
file to be present.

This exercises an issue found in btrfs and fixed by the following patch:

  btrfs: fix log tree replay failure due to file with 0 links and extents

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 .gitignore            |  1 +
 src/Makefile          |  2 +-
 src/unlink-fsync.c    | 45 ++++++++++++++++++++++++++++++++
 tests/generic/771     | 60 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/771.out |  4 +++
 5 files changed, 111 insertions(+), 1 deletion(-)
 create mode 100644 src/unlink-fsync.c
 create mode 100755 tests/generic/771
 create mode 100644 tests/generic/771.out

diff --git a/.gitignore b/.gitignore
index 58dc2a63..6948fd60 100644
--- a/.gitignore
+++ b/.gitignore
@@ -210,6 +210,7 @@ tags
 /src/fiemap-fault
 /src/min_dio_alignment
 /src/dio-writeback-race
+/src/unlink-fsync
 
 # Symlinked files
 /tests/generic/035.out
diff --git a/src/Makefile b/src/Makefile
index 2cc1fb40..7080e348 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -21,7 +21,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
 	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
 	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test \
 	readdir-while-renames dio-append-buf-fault dio-write-fsync-same-fd \
-	dio-writeback-race
+	dio-writeback-race unlink-fsync
 
 LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
diff --git a/src/unlink-fsync.c b/src/unlink-fsync.c
new file mode 100644
index 00000000..ce008c6b
--- /dev/null
+++ b/src/unlink-fsync.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 SUSE Linux Products GmbH.  All Rights Reserved.
+ */
+
+/*
+ * Utility to open an existing file, unlink it while holding an open fd on it
+ * and then fsync the file before closing the fd.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+
+int main(int argc, char *argv[])
+{
+	int fd;
+	int ret;
+
+	if (argc != 2) {
+		fprintf(stderr, "Use: %s <file path>\n", argv[0]);
+		return 1;
+	}
+
+	fd = open(argv[1], O_WRONLY, 0666);
+	if (fd == -1) {
+		perror("failed to open file");
+		exit(1);
+	}
+
+	ret = unlink(argv[1]);
+	if (ret == -1) {
+		perror("unlink failed");
+		exit(2);
+	}
+
+	ret = fsync(fd);
+	if (ret == -1) {
+		perror("fsync failed");
+		exit(3);
+	}
+
+	return 0;
+}
diff --git a/tests/generic/771 b/tests/generic/771
new file mode 100755
index 00000000..ad30cc0a
--- /dev/null
+++ b/tests/generic/771
@@ -0,0 +1,60 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 SUSE Linux Products GmbH.  All Rights Reserved.
+#
+# FS QA Test 771
+#
+# Create two files, the first one with some data, and then fsync both files.
+# The first file is fsynced after removing its hardlink. After a power failure
+# we expect the fs to be mountable and for only the second file to be present.
+#
+. ./common/preamble
+_begin_fstest auto quick log
+
+_cleanup()
+{
+	_cleanup_flakey
+	cd /
+	rm -r -f $tmp.*
+}
+
+. ./common/filter
+. ./common/dmflakey
+
+_require_scratch
+_require_test_program unlink-fsync
+_require_dm_target flakey
+
+[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: fix log tree replay failure due to file with 0 links and extents"
+
+_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
+_require_metadata_journaling $SCRATCH_DEV
+_init_flakey
+_mount_flakey
+
+# Create our first test file with some data.
+mkdir $SCRATCH_MNT/testdir
+$XFS_IO_PROG -f -c "pwrite 0K 64K" $SCRATCH_MNT/testdir/foo | _filter_xfs_io
+
+# fsync our first test file after unlinking it - we keep an fd open for the
+# file, unlink it and then fsync the file using that fd, so that we log/journal
+# a file with 0 hard links.
+$here/src/unlink-fsync $SCRATCH_MNT/testdir/foo
+
+# Create another test file and fsync it.
+touch $SCRATCH_MNT/testdir/bar
+$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/testdir/bar
+
+# Simulate a power failure and replay the log/journal.
+# On btrfs we had a bug where the replay procedure failed, causing the fs mount
+# to fail, because the first test file has extents and the second one, which has
+# an higher inode number, has a non-zero (1) link count - the replay code got
+# confused and thought the extents belonged to the second file and then it
+# failed when trying to open a non-existing inode to replay the extents.
+_flakey_drop_and_remount
+
+# File foo should not exist and file bar should exist.
+ls -1 $SCRATCH_MNT/testdir
+
+_exit 0
diff --git a/tests/generic/771.out b/tests/generic/771.out
new file mode 100644
index 00000000..e40d7091
--- /dev/null
+++ b/tests/generic/771.out
@@ -0,0 +1,4 @@
+QA output created by 771
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+bar
-- 
2.47.2


