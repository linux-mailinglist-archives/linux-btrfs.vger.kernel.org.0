Return-Path: <linux-btrfs+bounces-11319-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 723CFA2A902
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2025 14:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00099166E72
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2025 13:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A10B22E410;
	Thu,  6 Feb 2025 13:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdwHM4Kh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F94321CFF7;
	Thu,  6 Feb 2025 13:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738847114; cv=none; b=rIBKtyqmaz0Szv3NILSm7DiqnOeSXFHmxELOcHPg/PXlXU2jMzGWi3Tk3R0hFJLa229fkd6ofbj4gh+7AarAjg52mjrzdmjgMEqJ7PMpJsVCTedNMwO7BRGIIl05lJNk/BY3XoJgD0kpNMOtmaGfAJnvxohKodf8PAQEgO6+9yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738847114; c=relaxed/simple;
	bh=Ocma/5HR/7Hps9dGVEPIUKK5qgNCgG7pHfgkpGTFR+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nu+F0pEKOM7c05J24lcJLo6xni32xv+hesOMMNdubeMXJdwkjJpfPuRos7k59BfNdVeStTjcM4YGerkjNjSuUcufJz9ivr0rW+WyWYpPyxMfx9ERvyuOiK/DlQlHuwr0MA7sC1Jr/CG9DIJMvw4EHHs2U61zSEHdLImJaBU5je0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdwHM4Kh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD407C4CEDD;
	Thu,  6 Feb 2025 13:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738847113;
	bh=Ocma/5HR/7Hps9dGVEPIUKK5qgNCgG7pHfgkpGTFR+0=;
	h=From:To:Cc:Subject:Date:From;
	b=KdwHM4KhP7tmDXgBQ71yVuZIYNbVKGrh1nq1DXeNVkQsipmFUz2+8sYqUaptO7/pS
	 PLXplVO1Kfd297fC3/6amoSBKVAwAmtPEZD/69Ljnp+PCLy94EYzWnqYXVyPgo8GC2
	 zWEeX+k56qnCeG9Fugqxq2XZ2EciQ0kwSdwP2d6c1bq+ih1t3kiH4S+IVZg5aZnrYe
	 tzOF2aiQxYekcv+QlGKPsmuNx6tFTQvx7d48iVYd9HZOSiC+mXHVvLsid7EI4bIWg2
	 KhYJCuYwRPJDG3d0m4LH65NakXy5jUQgmZslH3bvQFbLTzF2TYqLxJpb3KyhUkbw8I
	 6C53ttBNtqYVQ==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] generic: suggest fs specific fix only if the tested filesystem matches
Date: Thu,  6 Feb 2025 13:05:06 +0000
Message-ID: <8c64ba21953b44b682c72b448bebe273dba64013.1738847088.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

It's odd when a test fails on a filesystem and a specific fix is suggested
for another filesystem. Some generic tests are suggesting filesystem
specific fixes without checking if the running filesystem matches, so
update them.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/365 | 10 ++++++----
 tests/generic/366 |  2 +-
 tests/generic/367 |  2 +-
 tests/generic/623 |  2 +-
 tests/generic/631 |  2 +-
 tests/generic/646 |  2 +-
 tests/generic/649 |  2 +-
 tests/generic/695 |  2 +-
 tests/generic/700 |  4 ++--
 tests/generic/701 |  2 +-
 tests/generic/702 |  2 +-
 tests/generic/704 |  4 +++-
 tests/generic/707 |  4 ++--
 13 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/tests/generic/365 b/tests/generic/365
index 1f6a618a..1bca848a 100755
--- a/tests/generic/365
+++ b/tests/generic/365
@@ -9,10 +9,12 @@
 . ./common/preamble
 _begin_fstest auto rmap fsmap
 
-_fixed_by_kernel_commit 68415b349f3f \
-	"xfs: Fix the owner setting issue for rmap query in xfs fsmap"
-_fixed_by_kernel_commit ca6448aed4f1 \
-	"xfs: Fix missing interval for missing_owner in xfs fsmap"
+if [ "$FSTYP" = "xfs" ]; then
+	_fixed_by_kernel_commit 68415b349f3f \
+		"xfs: Fix the owner setting issue for rmap query in xfs fsmap"
+	_fixed_by_kernel_commit ca6448aed4f1 \
+		"xfs: Fix missing interval for missing_owner in xfs fsmap"
+fi
 
 . ./common/filter
 
diff --git a/tests/generic/366 b/tests/generic/366
index b322bcca..b2c2e607 100755
--- a/tests/generic/366
+++ b/tests/generic/366
@@ -23,7 +23,7 @@ _require_scratch
 _require_odirect 512	# see fio job1 config below
 _require_aio
 
-_fixed_by_kernel_commit xxxxxxxxxxxx \
+[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
 	"btrfs: avoid deadlock when reading a partial uptodate folio"
 
 iterations=$((32 * LOAD_FACTOR))
diff --git a/tests/generic/367 b/tests/generic/367
index 7cf90695..ed371a02 100755
--- a/tests/generic/367
+++ b/tests/generic/367
@@ -17,7 +17,7 @@
 
 _begin_fstest ioctl quick
 
-_fixed_by_kernel_commit 2a492ff66673 \
+[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit 2a492ff66673 \
 	"xfs: Check for delayed allocations before setting extsize"
 
 _require_scratch_extsize
diff --git a/tests/generic/623 b/tests/generic/623
index 6487ccb8..9f41b5cc 100755
--- a/tests/generic/623
+++ b/tests/generic/623
@@ -11,7 +11,7 @@ _begin_fstest auto quick shutdown
 
 . ./common/filter
 
-_fixed_by_kernel_commit e4826691cc7e \
+[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit e4826691cc7e \
 	"xfs: restore shutdown check in mapped write fault path"
 
 _require_scratch_nocheck
diff --git a/tests/generic/631 b/tests/generic/631
index 8e2cf9c6..c38ab771 100755
--- a/tests/generic/631
+++ b/tests/generic/631
@@ -41,7 +41,7 @@ _require_attrs trusted
 _exclude_fs overlay
 _require_extra_fs overlay
 
-_fixed_by_kernel_commit 6da1b4b1ab36 \
+[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit 6da1b4b1ab36 \
 	"xfs: fix an ABBA deadlock in xfs_rename"
 
 _scratch_mkfs >> $seqres.full
diff --git a/tests/generic/646 b/tests/generic/646
index dc73aeb3..b3b0ab0a 100755
--- a/tests/generic/646
+++ b/tests/generic/646
@@ -14,7 +14,7 @@
 . ./common/preamble
 _begin_fstest auto quick recoveryloop shutdown
 
-_fixed_by_kernel_commit 50d25484bebe \
+[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit 50d25484bebe \
 	"xfs: sync lazy sb accounting on quiesce of read-only mounts"
 
 _require_scratch
diff --git a/tests/generic/649 b/tests/generic/649
index a33b13ea..58ef96a8 100755
--- a/tests/generic/649
+++ b/tests/generic/649
@@ -31,7 +31,7 @@ _cleanup()
 
 
 # Modify as appropriate.
-_fixed_by_kernel_commit 72a048c1056a \
+[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit 72a048c1056a \
 	"xfs: only set IOMAP_F_SHARED when providing a srcmap to a write"
 
 _require_cp_reflink
diff --git a/tests/generic/695 b/tests/generic/695
index df81fdb7..694f4245 100755
--- a/tests/generic/695
+++ b/tests/generic/695
@@ -25,7 +25,7 @@ _cleanup()
 . ./common/dmflakey
 . ./common/punch
 
-_fixed_by_kernel_commit e6e3dec6c3c288 \
+[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit e6e3dec6c3c288 \
         "btrfs: update generation of hole file extent item when merging holes"
 _require_scratch
 _require_dm_target flakey
diff --git a/tests/generic/700 b/tests/generic/700
index 052cfbd6..7f84df9d 100755
--- a/tests/generic/700
+++ b/tests/generic/700
@@ -19,8 +19,8 @@ _require_scratch
 _require_attrs
 _require_renameat2 whiteout
 
-_fixed_by_kernel_commit 70b589a37e1a \
-	xfs: add selinux labels to whiteout inodes
+[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit 70b589a37e1a \
+	"xfs: add selinux labels to whiteout inodes"
 
 get_selinux_label()
 {
diff --git a/tests/generic/701 b/tests/generic/701
index 527bba34..806cc65d 100755
--- a/tests/generic/701
+++ b/tests/generic/701
@@ -22,7 +22,7 @@ _cleanup()
 	rm -r -f $tmp.* $junk_dir
 }
 
-_fixed_by_kernel_commit 92fba084b79e \
+[ "$FSTYP" = "exfat" ] && _fixed_by_kernel_commit 92fba084b79e \
 	"exfat: fix i_blocks for files truncated over 4 GiB"
 
 _require_test
diff --git a/tests/generic/702 b/tests/generic/702
index a506e07d..ae47eb27 100755
--- a/tests/generic/702
+++ b/tests/generic/702
@@ -14,7 +14,7 @@ _begin_fstest auto quick clone fiemap
 . ./common/filter
 . ./common/reflink
 
-_fixed_by_kernel_commit ac3c0d36a2a2f7 \
+[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit ac3c0d36a2a2f7 \
 	"btrfs: make fiemap more efficient and accurate reporting extent sharedness"
 
 _require_scratch_reflink
diff --git a/tests/generic/704 b/tests/generic/704
index f452f9e9..f2360c42 100755
--- a/tests/generic/704
+++ b/tests/generic/704
@@ -21,7 +21,9 @@ _cleanup()
 # Import common functions.
 . ./common/scsi_debug
 
-_fixed_by_kernel_commit 7c71ee78031c "xfs: allow logical-sector sized O_DIRECT"
+[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit 7c71ee78031c \
+	"xfs: allow logical-sector sized O_DIRECT"
+
 _require_scsi_debug
 # If TEST_DEV is block device, make sure current fs is a localfs which can be
 # written on scsi_debug device
diff --git a/tests/generic/707 b/tests/generic/707
index 3d8fac4b..23864038 100755
--- a/tests/generic/707
+++ b/tests/generic/707
@@ -13,9 +13,9 @@ _begin_fstest auto
 
 _require_scratch
 
-_fixed_by_kernel_commit f950fd052913 \
+[ "$FSTYP" = "udf" ] && _fixed_by_kernel_commit f950fd052913 \
 	"udf: Protect rename against modification of moved directory"
-_fixed_by_kernel_commit 0813299c586b \
+[ "$FSTYP" = "ext4" ] && _fixed_by_kernel_commit 0813299c586b \
 	"ext4: Fix possible corruption when moving a directory"
 
 _scratch_mkfs >>$seqres.full 2>&1
-- 
2.45.2


