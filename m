Return-Path: <linux-btrfs+bounces-12560-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C49CA6FE66
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Mar 2025 13:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9A79188BE25
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Mar 2025 12:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6B8264612;
	Tue, 25 Mar 2025 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mt8ILXaQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBE92594B7;
	Tue, 25 Mar 2025 12:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905490; cv=none; b=g6CkpZuBUyc9LB5LUZLPtZvngtnufiu5BontLgYustoduz717TaZ+muKqQsz/gq+M3SL+GG6mPjjGP32r/O9dqGt5ygiZ3g39BPbXKRVfwoCMhA2E9rB/Cw9w31DgMXUIv/obApuDqm4KW+rb+2itQcgmW9ENgL092WsWtnd7+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905490; c=relaxed/simple;
	bh=IfdcHatEmipxRsn5wUmDJUnnTto6PmTIwLIFvNib0NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eJjwAkWlHi/repWFlJdbd4aIhkxMo4t0i/xCXNrIRb/HmDaQ9sRmXN4gnQwfbz9RU1z8DcfZqCIRwt5O+RxQlMqhTIwaBy8J0TCuMJzvbeKPCR8mG2neAxUx69MVYgp8gMPXEiejX8XgeaXdsjov42GQRbYlFacr/ohgYdRCh/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mt8ILXaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23541C4CEEE;
	Tue, 25 Mar 2025 12:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905490;
	bh=IfdcHatEmipxRsn5wUmDJUnnTto6PmTIwLIFvNib0NQ=;
	h=From:To:Cc:Subject:Date:From;
	b=mt8ILXaQRQaxpCWOIYZU0uzqdXjQsAU1MCgsQuGpEIQPZpEpu9GkVfTQYIUAkETeP
	 KVxTTHoap7Fnwf0Lq7QW3wiGSS4td7tyWJfZLnDNc5N+7z4yR6jPxrywOe396e8154
	 q1N+GTn6T3b5xZsu04cn9fxYJusDMyMQ8YK8WynEyebDuQeK4NZVFIMjJQ+Xdz3UTK
	 gBG60XvaMqzLo6TRVgxcGqiB8z/kmHd8K0wNhkKlKL2tUTuyQ0ZZNt9s7d9BHBrvn4
	 DmKHCt8Ru4CGgohaPzMy2FXtncYnhxsE0lINTpQAghCnHrHsWW134e1G0+/fWoJjzR
	 lpszIUsMC2Arg==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2] generic: test fsync of file with no more hard links
Date: Tue, 25 Mar 2025 12:24:40 +0000
Message-ID: <9a9c54e662293fb01591c256dd32243b1a149fe2.1742905343.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Test that if we fsync a file that has no more hard links, power fail and
then mount the filesystem, after the journal/log is replayed, the file
doesn't exists anymore.

This exercises a bug recently found and fixed by the following patch for
the linux kernel:

   btrfs: fix fsync of files with no hard links not persisting deletion

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: Use the src/multi_open_unlink.c program with added options to sync
    filesystem after creating files and fsync files after the unlink.

 src/multi_open_unlink.c | 24 ++++++++++++++++++--
 tests/generic/764       | 50 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/764.out   |  2 ++
 3 files changed, 74 insertions(+), 2 deletions(-)
 create mode 100755 tests/generic/764
 create mode 100644 tests/generic/764.out

diff --git a/src/multi_open_unlink.c b/src/multi_open_unlink.c
index c221d39e..fb054e87 100644
--- a/src/multi_open_unlink.c
+++ b/src/multi_open_unlink.c
@@ -28,7 +28,7 @@
 void
 usage(char *prog)
 {
-	fprintf(stderr, "Usage: %s [-e num-eas] [-f path_prefix] [-n num_files] [-s sleep_time] [-v ea-valuesize] \n", prog);
+	fprintf(stderr, "Usage: %s [-e num-eas] [-f path_prefix] [-F] [-n num_files] [-s sleep_time] [-S] [-v ea-valuesize] \n", prog);
 	exit(1);
 }
 
@@ -44,8 +44,10 @@ main(int argc, char *argv[])
 	int value_size = MAX_VALUELEN;
 	int fd = -1;
 	int i,j,c;
+	int fsync_files = 0;
+	int sync_fs = 0;
 
-	while ((c = getopt(argc, argv, "e:f:n:s:v:")) != EOF) {
+	while ((c = getopt(argc, argv, "e:f:Fn:s:Sv:")) != EOF) {
 		switch (c) {
 			case 'e':   /* create eas */
 				num_eas = atoi(optarg);
@@ -53,12 +55,18 @@ main(int argc, char *argv[])
 			case 'f':   /* file prefix */
 				given_path = optarg;
 				break;
+			case 'F':   /* fsync files after unlink */
+				fsync_files = 1;
+				break;
 			case 'n':   /* number of files */
 				num_files = atoi(optarg);
 				break;
 			case 's':   /* sleep time */
 				sleep_time = atoi(optarg);
 				break;
+			case 'S':   /* sync fs after creating files */
+				sync_fs = 1;
+				break;
 			case 'v':  /* value size on eas */
 				value_size = atoi(optarg);
 				break;
@@ -83,6 +91,12 @@ main(int argc, char *argv[])
 			return 1;
 		}
 
+		if (sync_fs && syncfs(fd) == -1) {
+			fprintf(stderr, "%s: failed to sync filesystem: %s\n",
+				prog, strerror(errno));
+			return 1;
+		}
+
 		/* set the EAs */
 		for (j = 0; j < num_eas; j++) {
 			int sts;
@@ -111,6 +125,12 @@ main(int argc, char *argv[])
 				prog, path, strerror(errno));
 			return 1;
 		}
+
+		if (fsync_files && fsync(fd) == -1) {
+			fprintf(stderr, "%s: failed to fsync \"%s\": %s\n",
+				prog, path, strerror(errno));
+			return 1;
+		}
 	}
 
 	sleep(sleep_time);
diff --git a/tests/generic/764 b/tests/generic/764
new file mode 100755
index 00000000..1b21bc02
--- /dev/null
+++ b/tests/generic/764
@@ -0,0 +1,50 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 SUSE Linux Products GmbH.  All Rights Reserved.
+#
+# FS QA Test 764
+#
+# Test that if we fsync a file that has no more hard links, power fail and then
+# mount the filesystem, after the journal/log is replayed, the file doesn't
+# exists anymore.
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
+. ./common/dmflakey
+
+[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: fix fsync of files with no hard links not persisting deletion"
+
+_require_scratch
+_require_dm_target flakey
+_require_test_program "multi_open_unlink"
+
+_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
+_require_metadata_journaling $SCRATCH_DEV
+_init_flakey
+_mount_flakey
+
+mkdir $SCRATCH_MNT/testdir
+$here/src/multi_open_unlink -f $SCRATCH_MNT/testdir/foo -F -S -n 1 -s 0
+
+# Simulate a power failure and then mount again the filesystem to replay the
+# journal/log.
+_flakey_drop_and_remount
+
+# We don't expect the file to exist anymore, since it was fsynced when it had no
+# more hard links.
+ls $SCRATCH_MNT/testdir
+
+_unmount_flakey
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/764.out b/tests/generic/764.out
new file mode 100644
index 00000000..bb58e5b8
--- /dev/null
+++ b/tests/generic/764.out
@@ -0,0 +1,2 @@
+QA output created by 764
+Silence is golden
-- 
2.45.2


