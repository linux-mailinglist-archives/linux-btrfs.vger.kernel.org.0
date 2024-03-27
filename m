Return-Path: <linux-btrfs+bounces-3661-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5349188EC39
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 18:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8892AB273A7
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 17:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E18E149DF5;
	Wed, 27 Mar 2024 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hz8Cm1B+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8334F130AFC;
	Wed, 27 Mar 2024 17:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711559521; cv=none; b=TTuz3tmjBxKqmxnxfdTCiUIsSriDUz5qPE9mcD0Pkg0djvvzWaTxDJTKehoZgTOKmUPkCWjArD5sfbkIsLHfmo3568Bax32qoNwQc0b8pMHrZqwh8M8Xt/kQSmmDfT4N/69RBruBEEo2ad0bfToP9f2g5HSHIKPtFHXNzndb/Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711559521; c=relaxed/simple;
	bh=HtwhMmoubzcWK5MoH0oMJbVCTY9IinGu2kBMPiHu2d0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OiaMpv46s7Phd3Ta80sfxnudiOSuRagrgkEv0ilamhtEM8Marz7LpWlRGUb2qm5Ab2SSZHH2lTzZBedTttf0ozjI1YiRha+wS0EifiMzhjMnH6rQ/Yd9UCpuGaiNXTYVkvI+qbhFkTouC+zfLIINlxQ2zUPbrJAkXWM65WfmcG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hz8Cm1B+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B5B7C43390;
	Wed, 27 Mar 2024 17:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711559521;
	bh=HtwhMmoubzcWK5MoH0oMJbVCTY9IinGu2kBMPiHu2d0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hz8Cm1B+iGgc/gobAfSu7blnsOqIiHnZYc6GB2wHYdsDkKeAm8VRLT6SrJ/xU/KzN
	 /UeOBEZ8YwXW/zpgcLjOmwZzZ9JzcfhhtYt7/D5ITL3s0LsQB9N8RZgWuWF3PZcCx9
	 QsOQz4ijpBPkMfUHYMcOXT2Zi+6GMqkMpqkkFFBgubqKk36URKlNM3F64i8sgxCEFr
	 dajQ+wgfMa7K8zXCUoRhMc0ri1ApWQTy2WHO1lw/+9qDjHgbG8YcvIvPg7BWHrz1T7
	 EcQXL3c0cjWIScyydBJTNbQX3w5eWGz7+SYQjNJ5XuymstfAMwCmH6rNYkb1RG9stV
	 FuvKTOOsNl49A==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 06/10] btrfs: add helper to kill background process running _btrfs_stress_remount_compress
Date: Wed, 27 Mar 2024 17:11:40 +0000
Message-ID: <0689a969e9834f4c2e694404f41f0bf8b7a34a2f.1711558345.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1711558345.git.fdmanana@suse.com>
References: <cover.1711558345.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Killing a background process running _btrfs_stress_remount_compress() is
not as simple as sending a signal to the process and waiting for it to
die. Therefore we have the following logic to terminate such process:

    kill $pid
    wait $pid
    while ps aux | grep "mount.*$SCRATCH_MNT" | grep -qv grep; do
        sleep 1
    done

Since this is repeated in several test cases, move this logic to a common
helper and use it in all affected test cases. This will help to avoid
repeating the same code again several times in upcoming changes.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 common/btrfs    | 15 +++++++++++++++
 tests/btrfs/063 |  7 +------
 tests/btrfs/068 |  8 ++------
 tests/btrfs/071 | 12 +++++-------
 tests/btrfs/073 |  8 +-------
 tests/btrfs/074 |  8 +-------
 6 files changed, 25 insertions(+), 33 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index 46056d4a..66a3a347 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -411,6 +411,21 @@ _btrfs_stress_remount_compress()
 	done
 }
 
+# Kill a background process running _btrfs_stress_remount_compress()
+_btrfs_kill_stress_remount_compress_pid()
+{
+	local remount_pid=$1
+	local btrfs_mnt=$2
+
+	# Ignore if process already died.
+	kill $remount_pid &> /dev/null
+	wait $remount_pid &> /dev/null
+	# Wait for the remount loop to finish.
+	while ps aux | grep "mount.*${btrfs_mnt}" | grep -qv grep; do
+		sleep 1
+	done
+}
+
 # stress btrfs by replacing devices in a loop
 # Note that at least 3 devices are needed in SCRATCH_DEV_POOL and the last
 # device should be free(not used by btrfs)
diff --git a/tests/btrfs/063 b/tests/btrfs/063
index baf0c356..5ee2837f 100755
--- a/tests/btrfs/063
+++ b/tests/btrfs/063
@@ -52,12 +52,7 @@ run_test()
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
 	wait $fsstress_pid
 	_btrfs_kill_stress_balance_pid $balance_pid
-	kill $remount_pid
-	wait $remount_pid
-	# wait for the remount loop to finish
-	while ps aux | grep "mount.*$SCRATCH_MNT" | grep -qv grep; do
-		sleep 1
-	done
+	_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
 
 	echo "Scrub the filesystem" >>$seqres.full
 	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
diff --git a/tests/btrfs/068 b/tests/btrfs/068
index 15fd41db..db53254a 100755
--- a/tests/btrfs/068
+++ b/tests/btrfs/068
@@ -58,12 +58,8 @@ run_test()
 	wait $fsstress_pid
 
 	touch $stop_file
-	kill $remount_pid
-	wait
-	# wait for the remount loop process to finish
-	while ps aux | grep "mount.*$SCRATCH_MNT" | grep -qv grep; do
-		sleep 1
-	done
+	wait $subvol_pid
+	_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
 
 	echo "Scrub the filesystem" >>$seqres.full
 	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
diff --git a/tests/btrfs/071 b/tests/btrfs/071
index 6ebbd8cc..7ba15390 100755
--- a/tests/btrfs/071
+++ b/tests/btrfs/071
@@ -58,17 +58,15 @@ run_test()
 	echo "$remount_pid" >>$seqres.full
 
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
-	wait $fsstress_pid
-	kill $replace_pid $remount_pid
-	wait
+	kill $replace_pid
+	wait $fsstress_pid $replace_pid
 
-	# wait for the remount and replace operations to finish
+	# wait for the replace operationss to finish
 	while ps aux | grep "replace start" | grep -qv grep; do
 		sleep 1
 	done
-	while ps aux | grep "mount.*$SCRATCH_MNT" | grep -qv grep; do
-		sleep 1
-	done
+
+	_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
 
 	echo "Scrub the filesystem" >>$seqres.full
 	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
diff --git a/tests/btrfs/073 b/tests/btrfs/073
index 49a4abd1..50358286 100755
--- a/tests/btrfs/073
+++ b/tests/btrfs/073
@@ -51,13 +51,7 @@ run_test()
 
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
 	wait $fsstress_pid
-	kill $remount_pid
-	wait $remount_pid
-	# wait for the remount operation to finish
-	while ps aux | grep "mount.*$SCRATCH_MNT" | grep -qv grep; do
-		sleep 1
-	done
-
+	_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
 	_btrfs_kill_stress_scrub_pid $scrub_pid
 
 	echo "Scrub the filesystem" >>$seqres.full
diff --git a/tests/btrfs/074 b/tests/btrfs/074
index d51922d0..6e93b36a 100755
--- a/tests/btrfs/074
+++ b/tests/btrfs/074
@@ -52,13 +52,7 @@ run_test()
 
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
 	wait $fsstress_pid
-	kill $remount_pid
-	wait $remount_pid
-	# wait for the remount operation to finish
-	while ps aux | grep "mount.*$SCRATCH_MNT" | grep -qv grep; do
-		sleep 1
-	done
-
+	_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
 	_btrfs_kill_stress_defrag_pid $defrag_pid
 
 	echo "Scrub the filesystem" >>$seqres.full
-- 
2.43.0


