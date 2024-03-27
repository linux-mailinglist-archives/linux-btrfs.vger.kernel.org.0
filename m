Return-Path: <linux-btrfs+bounces-3659-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC46E88EC33
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 18:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FFD91F2D3DE
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 17:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BE712F5A0;
	Wed, 27 Mar 2024 17:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0pmoB4s"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E603214D439;
	Wed, 27 Mar 2024 17:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711559519; cv=none; b=KC+PVKzuHZJVxJS/ZawdrTOC24uOPrZs4Nb9a/OobTLi0+ykSnLGU3M9kcBe3Gj11qQJAJ4wrPZZ1Q0VUP2Hhir8xmpHOh+gixk8jA3Q+vR1OtiGUqTlc6S5Mu1redNgFBS/k3PO8ULU+s+sOkKxvz9OGCy0EFQ4eLsRONmKZfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711559519; c=relaxed/simple;
	bh=6/kSIBnnTuaxbsOQsIl08wSEZZOIpHWuf3lwX6fTGRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LV64uyNuhOpNOLEAroDE+mAjuA4cj0W9FS2mYmIWcDrTZo5+AxuOX6yraIgSNHWkR4UzAoY2Htd4WEEk3hQUqvlXXbCeJGNIO00BtzS40k/u+3neWYHkpeyCGh52Sl7Dh5H4eEHiTXmgKvytllz1erWCXMheivwiMDtIShhqql0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0pmoB4s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB6DC43390;
	Wed, 27 Mar 2024 17:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711559518;
	bh=6/kSIBnnTuaxbsOQsIl08wSEZZOIpHWuf3lwX6fTGRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K0pmoB4sIaAtnW/8LtMzfmH8IZIfrNmVg/AVhO7MXbIx6RrjbU599e53Bs0mS1BKH
	 3DSc70eWBWfktmoDpOChvcwfpiLL2omYvGwDnuCKyT8mQRNnNjsqhOs6KDAMvQ1VTv
	 iQsaJIn4odNg5Bz88fW8mFuiQYa50j1sy59NnCnJOKyM4giLhllmcJoZ8LG4RnAINQ
	 UcGVoM8v3wkzhpHyWaS8QXQLjJih/VYE/W9zWih4bYS+lsc+Ym9F/BjWN3P0yLzOEt
	 YI1fsrIDjXaSpSN6NuvHahKFvfw8TIrtuWgOABmcNQMbqJJiBJMNNZzEWsJmdCx45F
	 ym9b+E7OdTyog==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 04/10] btrfs: add helper to kill background process running _btrfs_stress_scrub
Date: Wed, 27 Mar 2024 17:11:38 +0000
Message-ID: <091a8f4e0211299e21c3a3231584d0e8dac49ed1.1711558345.git.fdmanana@suse.com>
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

Killing a background process running _btrfs_stress_scrub() is not as
simple as sending a signal to the process and waiting for it to die.
Therefore we have the following logic to terminate such process:

   kill $pid
   wait $pid
   while ps aux | grep "scrub start" | grep -qv grep; do
       sleep 1
   done

Since this is repeated in several test cases, move this logic to a common
helper and use it in all affected test cases. This will help to avoid
repeating the same code again several times in upcoming changes.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 common/btrfs    | 14 ++++++++++++++
 tests/btrfs/061 |  7 +------
 tests/btrfs/066 |  8 ++------
 tests/btrfs/069 | 11 +++++------
 tests/btrfs/072 | 11 +++++------
 tests/btrfs/073 | 11 +++++------
 6 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index e95cff7f..d0adeea1 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -349,6 +349,20 @@ _btrfs_stress_scrub()
 	done
 }
 
+# Kill a background process running _btrfs_stress_scrub()
+_btrfs_kill_stress_scrub_pid()
+{
+       local scrub_pid=$1
+
+       # Ignore if process already died.
+       kill $scrub_pid &> /dev/null
+       wait $scrub_pid &> /dev/null
+       # Wait for the scrub operation to finish.
+       while ps aux | grep "scrub start" | grep -qv grep; do
+               sleep 1
+       done
+}
+
 # stress btrfs by defragmenting every file/dir in a loop and compress file
 # contents while defragmenting if second argument is not "nocompress"
 _btrfs_stress_defrag()
diff --git a/tests/btrfs/061 b/tests/btrfs/061
index d0b55e48..b8b2706c 100755
--- a/tests/btrfs/061
+++ b/tests/btrfs/061
@@ -52,12 +52,7 @@ run_test()
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
 	wait $fsstress_pid
 	_btrfs_kill_stress_balance_pid $balance_pid
-	kill $scrub_pid
-	wait $scrub_pid
-	# wait for the crub operation to finish
-	while ps aux | grep "scrub start" | grep -qv grep; do
-		sleep 1
-	done
+	_btrfs_kill_stress_scrub_pid $scrub_pid
 
 	echo "Scrub the filesystem" >>$seqres.full
 	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
diff --git a/tests/btrfs/066 b/tests/btrfs/066
index a29034bb..29821fdd 100755
--- a/tests/btrfs/066
+++ b/tests/btrfs/066
@@ -57,12 +57,8 @@ run_test()
 	wait $fsstress_pid
 
 	touch $stop_file
-	kill $scrub_pid
-	wait
-	# wait for the scrub operation to finish
-	while ps aux | grep "scrub start" | grep -qv grep; do
-		sleep 1
-	done
+	wait $subvol_pid
+	_btrfs_kill_stress_scrub_pid $scrub_pid
 
 	echo "Scrub the filesystem" >>$seqres.full
 	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
diff --git a/tests/btrfs/069 b/tests/btrfs/069
index 139dde48..20f44b39 100755
--- a/tests/btrfs/069
+++ b/tests/btrfs/069
@@ -59,17 +59,16 @@ run_test()
 
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
 	wait $fsstress_pid
-	kill $replace_pid $scrub_pid
-	wait
+	kill $replace_pid
+	wait $replace_pid
 
-	# wait for the scrub and replace operations to finish
-	while ps aux | grep "scrub start" | grep -qv grep; do
-		sleep 1
-	done
+	# wait for the replace operation to finish
 	while ps aux | grep "replace start" | grep -qv grep; do
 		sleep 1
 	done
 
+	_btrfs_kill_stress_scrub_pid $scrub_pid
+
 	echo "Scrub the filesystem" >>$seqres.full
 	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
 	if [ $? -ne 0 ]; then
diff --git a/tests/btrfs/072 b/tests/btrfs/072
index 4b6b6fb5..6c15b51f 100755
--- a/tests/btrfs/072
+++ b/tests/btrfs/072
@@ -52,16 +52,15 @@ run_test()
 
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
 	wait $fsstress_pid
-	kill $scrub_pid $defrag_pid
-	wait
-	# wait for the scrub and defrag operations to finish
-	while ps aux | grep "scrub start" | grep -qv grep; do
-		sleep 1
-	done
+	kill $defrag_pid
+	wait $defrag_pid
+	# wait for the defrag operation to finish
 	while ps aux | grep "btrfs filesystem defrag" | grep -qv grep; do
 		sleep 1
 	done
 
+	_btrfs_kill_stress_scrub_pid $scrub_pid
+
 	echo "Scrub the filesystem" >>$seqres.full
 	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
 	if [ $? -ne 0 ]; then
diff --git a/tests/btrfs/073 b/tests/btrfs/073
index b1604f94..49a4abd1 100755
--- a/tests/btrfs/073
+++ b/tests/btrfs/073
@@ -51,16 +51,15 @@ run_test()
 
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
 	wait $fsstress_pid
-	kill $scrub_pid $remount_pid
-	wait
-	# wait for the scrub and remount operations to finish
-	while ps aux | grep "scrub start" | grep -qv grep; do
-		sleep 1
-	done
+	kill $remount_pid
+	wait $remount_pid
+	# wait for the remount operation to finish
 	while ps aux | grep "mount.*$SCRATCH_MNT" | grep -qv grep; do
 		sleep 1
 	done
 
+	_btrfs_kill_stress_scrub_pid $scrub_pid
+
 	echo "Scrub the filesystem" >>$seqres.full
 	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
 	if [ $? -ne 0 ]; then
-- 
2.43.0


