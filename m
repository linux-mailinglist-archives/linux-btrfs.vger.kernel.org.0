Return-Path: <linux-btrfs+bounces-3656-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A4188EC30
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 18:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECE4E1C2E4F6
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 17:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D5714D719;
	Wed, 27 Mar 2024 17:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7bZDDLS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B32812F583;
	Wed, 27 Mar 2024 17:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711559515; cv=none; b=VlFfPNIQsy7CqZZ+PUIxuJRRb+4oHrO5yK+nbxRhvxIWHAFAPWgZlrNLWBWOznBc8lkmIxVBm0KOs6b4kjLlZ9CUAnKOVqPGkdh+DaBWUXWiVwtE2m2l4a9Q7eA2GyhfEcQmPvIqHOtQ7DUkMPp2v+JLs4GW84LSq/Y+HEiGNBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711559515; c=relaxed/simple;
	bh=9dTQ6HTsVMosSX2B+VSD/sl3vITeUwC0dNmSPaqrc3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMpLmhYS6L7CgKhfI7A0aQx2tTCJc9b+OmP3bIcIe2UYp8bMvMoz4yA+U8ufS3MOWJRcywZkCHTuETKdXbFckESl/G83yhfqzcCukJlFWQIizWShE4otC34wVVqiux94jy0AdE9y/4KnusZWy0rNZ3Y5O0/APbdcj9SoiuEKa84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7bZDDLS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F136AC433F1;
	Wed, 27 Mar 2024 17:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711559514;
	bh=9dTQ6HTsVMosSX2B+VSD/sl3vITeUwC0dNmSPaqrc3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A7bZDDLS1HB87I05uJvuvlZajS5J0OxW5J+NvreqnlzONbqk7rEEJ6PeY1/0eA007
	 4lHgQrCBwSfhnnpwHjnqyT+1pirHE3bAj8FLMmdJUs8UbPAr2b5f5kriU9vurhm5Ol
	 i9fwBrbbYyunprgyehJ2Wukg/of6NWwI4kXy1Asj1gtDyuSE+EvPiTAlskfi5X/1/O
	 KfvGuz4319nGeTj0mx3h4NziIHYGLdHM9BLKYHbgAtTMuajJkjIW2Tf3mx5RPhvwXt
	 nIzAWKMxcS6dcBtC0ATqot7AzEBC07HHwHX8RDCFvmcvWVM1pEdYyufl86wm9yrykU
	 HfJhvE3nOS0fQ==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 01/10] btrfs: add helper to kill background process running _btrfs_stress_balance
Date: Wed, 27 Mar 2024 17:11:35 +0000
Message-ID: <e5f1141cbe307e6057554e1c8fb8cff188ab68f0.1711558345.git.fdmanana@suse.com>
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

Killing a background process running _btrfs_stress_balance() is not as
simple as sending a signal to the process and waiting for it to die.
Therefore we have the following logic to terminate such process:

   kill $pid
   wait $pid
   # Wait for the balance operation to finish.
   while ps aux | grep "balance start" | grep -qv grep; do
       sleep 1
   done

Since this is repeated in several test cases, move this logic to a common
helper and use it in all affected test cases. This will help to avoid
repeating the same code again several times in upcoming changes.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 common/btrfs    | 14 ++++++++++++++
 tests/btrfs/060 |  8 ++------
 tests/btrfs/061 | 10 ++++------
 tests/btrfs/062 | 10 ++++------
 tests/btrfs/063 | 10 ++++------
 tests/btrfs/064 | 10 ++++------
 tests/btrfs/255 |  8 ++------
 7 files changed, 34 insertions(+), 36 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index aa344706..e95cff7f 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -308,6 +308,20 @@ _btrfs_stress_balance()
 	done
 }
 
+# Kill a background process running _btrfs_stress_balance()
+_btrfs_kill_stress_balance_pid()
+{
+	local balance_pid=$1
+
+	# Ignore if process already died.
+	kill $balance_pid &> /dev/null
+	wait $balance_pid &> /dev/null
+	# Wait for the balance operation to finish.
+	while ps aux | grep "balance start" | grep -qv grep; do
+		sleep 1
+	done
+}
+
 # stress btrfs by creating/mounting/umounting/deleting subvolume in a loop
 _btrfs_stress_subvolume()
 {
diff --git a/tests/btrfs/060 b/tests/btrfs/060
index a0184891..58167cc6 100755
--- a/tests/btrfs/060
+++ b/tests/btrfs/060
@@ -57,12 +57,8 @@ run_test()
 	wait $fsstress_pid
 
 	touch $stop_file
-	kill $balance_pid
-	wait
-	# wait for the balance operation to finish
-	while ps aux | grep "balance start" | grep -qv grep; do
-		sleep 1
-	done
+	wait $subvol_pid
+	_btrfs_kill_stress_balance_pid $balance_pid
 
 	echo "Scrub the filesystem" >>$seqres.full
 	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
diff --git a/tests/btrfs/061 b/tests/btrfs/061
index c1010413..d0b55e48 100755
--- a/tests/btrfs/061
+++ b/tests/btrfs/061
@@ -51,12 +51,10 @@ run_test()
 
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
 	wait $fsstress_pid
-	kill $balance_pid $scrub_pid
-	wait
-	# wait for the balance and scrub operations to finish
-	while ps aux | grep "balance start" | grep -qv grep; do
-		sleep 1
-	done
+	_btrfs_kill_stress_balance_pid $balance_pid
+	kill $scrub_pid
+	wait $scrub_pid
+	# wait for the crub operation to finish
 	while ps aux | grep "scrub start" | grep -qv grep; do
 		sleep 1
 	done
diff --git a/tests/btrfs/062 b/tests/btrfs/062
index 818a0156..a2639d6c 100755
--- a/tests/btrfs/062
+++ b/tests/btrfs/062
@@ -52,12 +52,10 @@ run_test()
 
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
 	wait $fsstress_pid
-	kill $balance_pid $defrag_pid
-	wait
-	# wait for the balance and defrag operations to finish
-	while ps aux | grep "balance start" | grep -qv grep; do
-		sleep 1
-	done
+	_btrfs_kill_stress_balance_pid $balance_pid
+	kill $defrag_pid
+	wait $defrag_pid
+	# wait for the defrag operation to finish
 	while ps aux | grep "btrfs filesystem defrag" | grep -qv grep; do
 		sleep 1
 	done
diff --git a/tests/btrfs/063 b/tests/btrfs/063
index 2f771baf..baf0c356 100755
--- a/tests/btrfs/063
+++ b/tests/btrfs/063
@@ -51,12 +51,10 @@ run_test()
 
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
 	wait $fsstress_pid
-	kill $balance_pid $remount_pid
-	wait
-	# wait for the balance and remount loop to finish
-	while ps aux | grep "balance start" | grep -qv grep; do
-		sleep 1
-	done
+	_btrfs_kill_stress_balance_pid $balance_pid
+	kill $remount_pid
+	wait $remount_pid
+	# wait for the remount loop to finish
 	while ps aux | grep "mount.*$SCRATCH_MNT" | grep -qv grep; do
 		sleep 1
 	done
diff --git a/tests/btrfs/064 b/tests/btrfs/064
index e9b46ce6..58b53afe 100755
--- a/tests/btrfs/064
+++ b/tests/btrfs/064
@@ -63,12 +63,10 @@ run_test()
 
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
 	wait $fsstress_pid
-	kill $balance_pid $replace_pid
-	wait
-	# wait for the balance and replace operations to finish
-	while ps aux | grep "balance start" | grep -qv grep; do
-		sleep 1
-	done
+	_btrfs_kill_stress_balance_pid $balance_pid
+	kill $replace_pid
+	wait $replace_pid
+	# wait for the replace operation to finish
 	while ps aux | grep "replace start" | grep -qv grep; do
 		sleep 1
 	done
diff --git a/tests/btrfs/255 b/tests/btrfs/255
index 7e70944a..aa250467 100755
--- a/tests/btrfs/255
+++ b/tests/btrfs/255
@@ -41,12 +41,8 @@ for ((i = 0; i < 20; i++)); do
 	$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
 	$BTRFS_UTIL_PROG quota disable $SCRATCH_MNT
 done
-kill $balance_pid &> /dev/null
-wait
-# wait for the balance operation to finish
-while ps aux | grep "balance start" | grep -qv grep; do
-	sleep 1
-done
+
+_btrfs_kill_stress_balance_pid $balance_pid
 
 echo "Silence is golden"
 status=0
-- 
2.43.0


