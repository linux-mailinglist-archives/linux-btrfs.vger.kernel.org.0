Return-Path: <linux-btrfs+bounces-6917-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 731169433C7
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 18:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2830F281D6A
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2024 16:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD041BC075;
	Wed, 31 Jul 2024 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOoh+SGx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3BD1BC06E;
	Wed, 31 Jul 2024 16:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722441604; cv=none; b=ANDK/C2PU8YkHoSYa5tocYPMvRtNLksthhO00lAcW5tyYXmDV5v7MM/BPmaufRHdJcAZgoWuNd8BCZJ2stsC/u37U71qA7P3ZK9M470mUxvRNvV9S95Y/HMW74zXNsMIQQUKQzNfVtnq8ntmltHA+1rgG4mcCOT/mN2zPh8sO98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722441604; c=relaxed/simple;
	bh=KLDzWvl4kXbvgiATWESpNg9iSwQfphlBf8F8PNY4ges=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SaoGXwbVAn6hWaZfz+Xw6x237DxA20XPuTjiMDtqchsrbtMyaydA3krqpVp2VkE8nue88cAgxPwVqlCHQyUSMfWRVDamenYdc4q0+/NlWX1Q1uRQjh429+O3GuuKIgs0kXkALUjfBsdNUSPvhRDOtSsZKmnlflg9ccVHRpHZEHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOoh+SGx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46A4C4AF09;
	Wed, 31 Jul 2024 16:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722441603;
	bh=KLDzWvl4kXbvgiATWESpNg9iSwQfphlBf8F8PNY4ges=;
	h=From:To:Cc:Subject:Date:From;
	b=vOoh+SGxfoB2Y4bjGhrHytcZPil+wA0s06KnYohmz7XnRxYPyAOhNrDJgv8vfqG0M
	 LwIHx4yABoqHcp20MDTVerHdmFOeV7efLfdUm6OANhmL96wV+HrbesDb4uxBev2Bmu
	 7yL1xCt4mbb+YYV+MO8/Et/L3dOmlPjU+YZ/12Dqmfcbd02lHM1r0Osr52XVlhxzMP
	 uAwbRj/LqfD5MEmG/G0riSnfrtKtkvryP5MWvILYG8LnQum1bgEIPW/ea7IH2TMS6c
	 yVRmTNMdq3zsP4o/RQcqYmGAEEBWlZP/Gms9joYTObrogbfl81VI/5DY8Vr8wEMIiF
	 RtfC5scWHgB9A==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] fstests: remove unnecessary stdout/stderr redirection for run_check calls
Date: Wed, 31 Jul 2024 16:59:58 +0100
Message-ID: <742c2d98a000e324106a9f5bd3498f2985bb2706.1722441541.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

It's pointless, and confusing, to have calls to run_check redirect the
stdout and/or stderr, because run_check already redirects it:

   $ cat common/rc
   (...)
   run_check()
   {
       echo "# $@" >> $seqres.full 2>&1
       "$@" >> $seqres.full 2>&1 || _fail "failed: '$@'"
   }
   (...)

So remove those redirections.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/004   | 4 ++--
 tests/btrfs/030   | 4 ++--
 tests/btrfs/038   | 6 +++---
 tests/btrfs/039   | 4 ++--
 tests/btrfs/040   | 4 ++--
 tests/btrfs/057   | 6 ++----
 tests/btrfs/284   | 2 +-
 tests/generic/482 | 2 +-
 8 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/tests/btrfs/004 b/tests/btrfs/004
index e89697d2..5a2ce993 100755
--- a/tests/btrfs/004
+++ b/tests/btrfs/004
@@ -165,7 +165,7 @@ workout()
 	_btrfs subvolume snapshot $SCRATCH_MNT \
 		$SCRATCH_MNT/$snap_name
 
-	run_check _scratch_unmount >/dev/null 2>&1
+	run_check _scratch_unmount
 	_scratch_mount "-o compress=lzo"
 
 	# make some noise but ensure we're not touching existing data
@@ -179,7 +179,7 @@ workout()
 	# now make more files to get a higher tree
 	run_check $FSSTRESS_PROG -d $clean_dir -w -p $procs -n 2000 \
 		$FSSTRESS_AVOID
-	run_check _scratch_unmount >/dev/null 2>&1
+	run_check _scratch_unmount
 	_scratch_mount "-o atime"
 
 	if [ $do_bg_noise -ne 0 ]; then
diff --git a/tests/btrfs/030 b/tests/btrfs/030
index bedbb728..0c84000a 100755
--- a/tests/btrfs/030
+++ b/tests/btrfs/030
@@ -150,10 +150,10 @@ _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
 _btrfs receive -f $tmp/1.snap $SCRATCH_MNT
-run_check $FSSUM_PROG -r $tmp/1.fssum $SCRATCH_MNT/mysnap1 2>> $seqres.full
+run_check $FSSUM_PROG -r $tmp/1.fssum $SCRATCH_MNT/mysnap1
 
 _btrfs receive -f $tmp/2.snap $SCRATCH_MNT
-run_check $FSSUM_PROG -r $tmp/2.fssum $SCRATCH_MNT/mysnap2 2>> $seqres.full
+run_check $FSSUM_PROG -r $tmp/2.fssum $SCRATCH_MNT/mysnap2
 
 _scratch_unmount
 _check_btrfs_filesystem $SCRATCH_DEV
diff --git a/tests/btrfs/038 b/tests/btrfs/038
index bdef4f41..1e6defa9 100755
--- a/tests/btrfs/038
+++ b/tests/btrfs/038
@@ -76,13 +76,13 @@ _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
 _btrfs receive -f $tmp/1.snap $SCRATCH_MNT
-run_check $FSSUM_PROG -r $tmp/1.fssum $SCRATCH_MNT/mysnap1 2>> $seqres.full
+run_check $FSSUM_PROG -r $tmp/1.fssum $SCRATCH_MNT/mysnap1
 
 _btrfs receive -f $tmp/clones.snap $SCRATCH_MNT
-run_check $FSSUM_PROG -r $tmp/clones.fssum $SCRATCH_MNT/clones_snap 2>> $seqres.full
+run_check $FSSUM_PROG -r $tmp/clones.fssum $SCRATCH_MNT/clones_snap
 
 _btrfs receive -f $tmp/2.snap $SCRATCH_MNT
-run_check $FSSUM_PROG -r $tmp/2.fssum $SCRATCH_MNT/mysnap2 2>> $seqres.full
+run_check $FSSUM_PROG -r $tmp/2.fssum $SCRATCH_MNT/mysnap2
 
 _scratch_unmount
 _check_btrfs_filesystem $SCRATCH_DEV
diff --git a/tests/btrfs/039 b/tests/btrfs/039
index e7cea325..2306ffe0 100755
--- a/tests/btrfs/039
+++ b/tests/btrfs/039
@@ -91,10 +91,10 @@ _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
 _btrfs receive -f $tmp/1.snap $SCRATCH_MNT
-run_check $FSSUM_PROG -r $tmp/1.fssum $SCRATCH_MNT/mysnap1 2>> $seqres.full
+run_check $FSSUM_PROG -r $tmp/1.fssum $SCRATCH_MNT/mysnap1
 
 _btrfs receive -f $tmp/2.snap $SCRATCH_MNT
-run_check $FSSUM_PROG -r $tmp/2.fssum $SCRATCH_MNT/mysnap2 2>> $seqres.full
+run_check $FSSUM_PROG -r $tmp/2.fssum $SCRATCH_MNT/mysnap2
 
 _scratch_unmount
 _check_btrfs_filesystem $SCRATCH_DEV
diff --git a/tests/btrfs/040 b/tests/btrfs/040
index 5d346be3..4fc4db44 100755
--- a/tests/btrfs/040
+++ b/tests/btrfs/040
@@ -84,10 +84,10 @@ _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
 
 _btrfs receive -f $tmp/1.snap $SCRATCH_MNT
-run_check $FSSUM_PROG -r $tmp/1.fssum $SCRATCH_MNT/mysnap1 2>> $seqres.full
+run_check $FSSUM_PROG -r $tmp/1.fssum $SCRATCH_MNT/mysnap1
 
 _btrfs receive -f $tmp/2.snap $SCRATCH_MNT
-run_check $FSSUM_PROG -r $tmp/2.fssum $SCRATCH_MNT/mysnap2 2>> $seqres.full
+run_check $FSSUM_PROG -r $tmp/2.fssum $SCRATCH_MNT/mysnap2
 
 _scratch_unmount
 _check_btrfs_filesystem $SCRATCH_DEV
diff --git a/tests/btrfs/057 b/tests/btrfs/057
index 07e60557..6c399946 100755
--- a/tests/btrfs/057
+++ b/tests/btrfs/057
@@ -19,14 +19,12 @@ _scratch_mkfs_sized $((1024 * 1024 * 1024)) >> $seqres.full 2>&1
 _scratch_mount
 
 # -w ensures that the only ops are ones which cause write I/O
-run_check $FSSTRESS_PROG -d $SCRATCH_MNT -w -p 5 -n 1000 \
-		$FSSTRESS_AVOID >&/dev/null
+run_check $FSSTRESS_PROG -d $SCRATCH_MNT -w -p 5 -n 1000 $FSSTRESS_AVOID
 
 _btrfs subvolume snapshot $SCRATCH_MNT \
 	$SCRATCH_MNT/snap1
 
-run_check $FSSTRESS_PROG -d $SCRATCH_MNT/snap1 -w -p 5 -n 1000 \
-       $FSSTRESS_AVOID >&/dev/null
+run_check $FSSTRESS_PROG -d $SCRATCH_MNT/snap1 -w -p 5 -n 1000 $FSSTRESS_AVOID
 
 _btrfs quota enable $SCRATCH_MNT
 _btrfs quota rescan -w $SCRATCH_MNT
diff --git a/tests/btrfs/284 b/tests/btrfs/284
index 19ffbbe6..6c554f32 100755
--- a/tests/btrfs/284
+++ b/tests/btrfs/284
@@ -50,7 +50,7 @@ run_send_test()
 	# Use a single process so that in case of failure it's easier to
 	# reproduce by using the same seed (logged in $seqres.full).
 	run_check $FSSTRESS_PROG -d $SCRATCH_MNT -p 1 -n $((LOAD_FACTOR * 200)) \
-		  -w $FSSTRESS_AVOID -x "$snapshot_cmd" >> $seqres.full
+		  -w $FSSTRESS_AVOID -x "$snapshot_cmd"
 
 	$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2 \
 			 >> $seqres.full
diff --git a/tests/generic/482 b/tests/generic/482
index 04026c4c..54fee07d 100755
--- a/tests/generic/482
+++ b/tests/generic/482
@@ -77,7 +77,7 @@ _log_writes_mkfs >> $seqres.full 2>&1
 _log_writes_mark mkfs
 
 _log_writes_mount
-run_check $FSSTRESS_PROG $fsstress_args > /dev/null 2>&1
+run_check $FSSTRESS_PROG $fsstress_args
 _log_writes_unmount
 
 _log_writes_remove
-- 
2.43.0


