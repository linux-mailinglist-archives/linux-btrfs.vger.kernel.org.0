Return-Path: <linux-btrfs+bounces-19661-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAD5CB65D1
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 16:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3697C30028A0
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 15:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F4B311C20;
	Thu, 11 Dec 2025 15:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPl3lB6I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C65B30FF3B;
	Thu, 11 Dec 2025 15:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765467703; cv=none; b=LrPRHzxqmZdKe4gEwh2sF8XDow+AhlZoeR+Tc9HhKHvJulOMG3T2XI934IFkesPERM7EwuA48T9MoGa9/F3MeCPKmEpwugruxrhX7VFwc4jxrWLzV5glLeezebeiCMLbXsLEJNVSrTMHN4mfnub/CaYQK2ajFDv9YA+ZPbjHIbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765467703; c=relaxed/simple;
	bh=UFgsliItQTeyZGvHWyfcJPxJzzd1sOVSG9GLECKdlSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=THy0N69ZQkpCp1uPga+L1yYQ8GT0WdpMc9F4F49RiZBF/INaWNqq3oc/l3pLunSnw+u0GuEyGxfrjLKweBG3oNW/aDiHegm1UcSET4nSYnOVEWjFtX7e9nF60YyluVFjpidxLyW3b4d5YC6SxywSzlFxiBPDBVD7Qd5h+FXckgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPl3lB6I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E85EC4CEFB;
	Thu, 11 Dec 2025 15:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765467703;
	bh=UFgsliItQTeyZGvHWyfcJPxJzzd1sOVSG9GLECKdlSU=;
	h=From:To:Cc:Subject:Date:From;
	b=kPl3lB6IVx+CUJ6YzQLsoP69b38AW3V6R29YWMp/u9p3zlhq/1ExtnwZBZg3e6DaA
	 Ri68kg4DalMAcayhMdiUv9zbX1Nm1zowhiAQLk4Gts9wAPAoIjcn6no/Oe/RT6pgKh
	 JpEc7lulPsg53R4V2SMflv+gjbz8JyX//SGCLzXivfZlpeZacX89WeYqkqvWG8mvwy
	 FeBoa1rPB0q2vBH8NY9fzZXwEG17g/vaOPFJE/8Jm4vwMKlGuhzWxArXUM6j8O+dgJ
	 DF9UA+nyptiT2/IBDhExlTeymMr6vUvFEC0Txtv6KOmZbw1K9+2UdpfZh6saJt2xK3
	 YGn5lD06d+TJQ==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: test power failure after fsync and rename exchanging directories
Date: Thu, 11 Dec 2025 15:41:37 +0000
Message-ID: <3cb8fdeec6e3bf977682d1074bf3e7ba1719b98c.1765466812.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Test renaming one directory over another one that has a subvolume inside
it and fsync a file in the other directory that was previously renamed.
We want to verify that after a power failure we are able to mount the
filesystem and it has the correct content (all renames visible).

This exercises a bug fixed by the following kernel patch:

  "btrfs: always detect conflicting inodes when logging inode refs"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/340     | 75 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/340.out | 15 +++++++++
 2 files changed, 90 insertions(+)
 create mode 100755 tests/btrfs/340
 create mode 100644 tests/btrfs/340.out

diff --git a/tests/btrfs/340 b/tests/btrfs/340
new file mode 100755
index 00000000..d52893ae
--- /dev/null
+++ b/tests/btrfs/340
@@ -0,0 +1,75 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 SUSE S.A.  All Rights Reserved.
+#
+# FS QA Test 340
+#
+# Test renaming one directory over another one that has a subvolume inside it
+# and fsync a file in the other directory that was previously renamed. We want
+# to verify that after a power failure we are able to mount the filesystem and
+# it has the correct content (all renames visible).
+#
+. ./common/preamble
+_begin_fstest auto quick subvol rename log
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
+. ./common/renameat2
+
+_require_scratch
+_require_dm_target flakey
+_require_renameat2 exchange
+
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: always detect conflicting inodes when logging inode refs"
+
+_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
+_require_metadata_journaling $SCRATCH_DEV
+_init_flakey
+_mount_flakey
+
+# Create our test directories, one with a file inside, another with a subvolume
+# that is not empty (has one file).
+mkdir $SCRATCH_MNT/dir1
+echo -n > $SCRATCH_MNT/dir1/foo
+
+mkdir $SCRATCH_MNT/dir2
+_btrfs subvolume create $SCRATCH_MNT/dir2/subvol
+echo -n > $SCRATCH_MNT/dir2/subvol/subvol_file
+
+_scratch_sync
+
+# Rename file foo so that its inode's last_unlink_trans is updated to the
+# current transaction.
+mv $SCRATCH_MNT/dir1/foo $SCRATCH_MNT/dir1/bar
+
+# Rename exchange dir1 with dir2.
+$here/src/renameat2 -x $SCRATCH_MNT/dir1 $SCRATCH_MNT/dir2
+
+# Fsync file bar, we just renamed from foo.
+# Until the kernel fix mentioned above, it would result in logging dir2 without
+# logging dir1, causing log replay to attempt to remove the inode for dir1 since
+# the inode for dir2 has the same name in the same parent directory. Not only
+# this was not correct, since we did not delete the directory, but it would also
+# result in a log replay failure (and therefore mount failure) because we would
+# be attempting to delete a directory with a non-empty subvolume inside it.
+$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/dir2/bar
+
+# Simulate a power failure and then mount again the filesystem to replay the
+# journal/log. We should be able to replay the log tree and mount successfully.
+_flakey_drop_and_remount
+
+echo -e "Filesystem contents after power failure:\n"
+ls -1R $SCRATCH_MNT | _filter_scratch
+
+_unmount_flakey
+
+# success, all done
+_exit 0
diff --git a/tests/btrfs/340.out b/tests/btrfs/340.out
new file mode 100644
index 00000000..7745c639
--- /dev/null
+++ b/tests/btrfs/340.out
@@ -0,0 +1,15 @@
+QA output created by 340
+Filesystem contents after power failure:
+
+SCRATCH_MNT:
+dir1
+dir2
+
+SCRATCH_MNT/dir1:
+subvol
+
+SCRATCH_MNT/dir1/subvol:
+subvol_file
+
+SCRATCH_MNT/dir2:
+bar
-- 
2.47.2


