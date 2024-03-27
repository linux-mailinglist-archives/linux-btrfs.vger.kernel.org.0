Return-Path: <linux-btrfs+bounces-3662-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A81AA88EC3A
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 18:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64652B279FA
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 17:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D848014D42B;
	Wed, 27 Mar 2024 17:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uPLzhVbn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F73613172F;
	Wed, 27 Mar 2024 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711559523; cv=none; b=HaPiCkJv7h1LRqpVgbia+dIXkWkaroQqQCJhsa7HcWjYEFvOqwLpYJsZeARJlUG+6w6KtWDeF2Dbj9pB1BdAjvPGutG2YT8Vd0MUBRjES1h76GuGQmt7OETTQ3BzvtP7CHsvBpcduRyPQTGG4mphywDa9r3VZApBwMehkxKtQX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711559523; c=relaxed/simple;
	bh=o1+Rj5wGAc25lZ/MqgrSMd2jFsPLItLcz4elQ7JI/kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=on/78VH3L4EPILzQL5NDrdv0bkeiHEjbSObScTlsjpry1rueTLQqbXpJFAn8xGfeoiEVc84BQHY20WzyhDUp6EGNKBGz8c5y0a6Szhm5G92JTTBuT6IHfHhCvsyIt+6Ti9gfA/Vw+XlrIYqcTefr4FnH8D4KdxOx/qQNiUcdwjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uPLzhVbn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6369C43394;
	Wed, 27 Mar 2024 17:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711559522;
	bh=o1+Rj5wGAc25lZ/MqgrSMd2jFsPLItLcz4elQ7JI/kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uPLzhVbnDGCLxy4oZLihOJOJJuKfltTf41h6yv26SlokMVPEPMAUrML/EMsRU8cEN
	 mqF9KL55nnyfHet4PXsrhRUT3DJNxChlU9XtNb2jq97bdORq9AbFiXMms1K4aZx5lS
	 Szu/YxHuc7Lmfi7t8T5KdY7klCITubYLmL9r1ib0DVmt4FmzVyDJyDSlDce9QYJFyB
	 7evWiu20sIm1hfZ8OVK5GdC7Ql42BksU9ifeSVsWUhK9rfY+Hg0/pJK7uTuKfF3ac6
	 gAzgekodHLVUetXGiKXFQxlSEFBID+QL8htXGjU7IeJ1n0YQ/uVWkeDwEphwmX0BBV
	 BWaK8RnAxzgEg==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 07/10] btrfs: add helper to kill background process running _btrfs_stress_replace
Date: Wed, 27 Mar 2024 17:11:41 +0000
Message-ID: <3334980dc99188a6742b28ba813268221d20a3b4.1711558345.git.fdmanana@suse.com>
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

Killing a background process running _btrfs_stress_replace() is not as
simple as sending a signal to the process and waiting for it to die.
Therefore we have the following logic to terminate such process:

   kill $pid
   wait $pid
   while ps aux | grep "replace start" | grep -qv grep; do
      sleep 1
   done

Since this is repeated in several test cases, move this logic to a common
helper and use it in all affected test cases. This will help to avoid
repeating the same code again several times in upcoming changes.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 common/btrfs    | 14 ++++++++++++++
 tests/btrfs/064 |  7 +------
 tests/btrfs/065 |  8 ++------
 tests/btrfs/069 |  9 +--------
 tests/btrfs/070 |  9 +--------
 tests/btrfs/071 | 10 ++--------
 6 files changed, 21 insertions(+), 36 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index 66a3a347..6d7e7a68 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -475,6 +475,20 @@ _btrfs_stress_replace()
 	done
 }
 
+# Kill a background process running _btrfs_stress_replace()
+_btrfs_kill_stress_replace_pid()
+{
+       local replace_pid=$1
+
+       # Ignore if process already died.
+       kill $replace_pid &> /dev/null
+       wait $replace_pid &> /dev/null
+       # Wait for the replace operation to finish.
+       while ps aux | grep "replace start" | grep -qv grep; do
+               sleep 1
+       done
+}
+
 # find the right option to force output in bytes, older versions of btrfs-progs
 # print that by default, newer print human readable numbers with unit suffix
 _btrfs_qgroup_units()
diff --git a/tests/btrfs/064 b/tests/btrfs/064
index 58b53afe..9e0b3b30 100755
--- a/tests/btrfs/064
+++ b/tests/btrfs/064
@@ -64,12 +64,7 @@ run_test()
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
 	wait $fsstress_pid
 	_btrfs_kill_stress_balance_pid $balance_pid
-	kill $replace_pid
-	wait $replace_pid
-	# wait for the replace operation to finish
-	while ps aux | grep "replace start" | grep -qv grep; do
-		sleep 1
-	done
+	_btrfs_kill_stress_replace_pid $replace_pid
 
 	echo "Scrub the filesystem" >>$seqres.full
 	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
diff --git a/tests/btrfs/065 b/tests/btrfs/065
index c4b6aafe..d2b04178 100755
--- a/tests/btrfs/065
+++ b/tests/btrfs/065
@@ -65,12 +65,8 @@ run_test()
 	wait $fsstress_pid
 
 	touch $stop_file
-	kill $replace_pid
-	wait
-	# wait for the replace operation to finish
-	while ps aux | grep "replace start" | grep -qv grep; do
-		sleep 1
-	done
+	wait $subvol_pid
+	_btrfs_kill_stress_replace_pid $replace_pid
 
 	echo "Scrub the filesystem" >>$seqres.full
 	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
diff --git a/tests/btrfs/069 b/tests/btrfs/069
index 20f44b39..ad1609d4 100755
--- a/tests/btrfs/069
+++ b/tests/btrfs/069
@@ -59,15 +59,8 @@ run_test()
 
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
 	wait $fsstress_pid
-	kill $replace_pid
-	wait $replace_pid
-
-	# wait for the replace operation to finish
-	while ps aux | grep "replace start" | grep -qv grep; do
-		sleep 1
-	done
-
 	_btrfs_kill_stress_scrub_pid $scrub_pid
+	_btrfs_kill_stress_replace_pid $replace_pid
 
 	echo "Scrub the filesystem" >>$seqres.full
 	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
diff --git a/tests/btrfs/070 b/tests/btrfs/070
index cefa5723..3054c270 100755
--- a/tests/btrfs/070
+++ b/tests/btrfs/070
@@ -60,14 +60,7 @@ run_test()
 
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
 	wait $fsstress_pid
-	kill $replace_pid
-	wait $replace_pid
-
-	# wait for the replace operation to finish
-	while ps aux | grep "replace start" | grep -qv grep; do
-		sleep 1
-	done
-
+	_btrfs_kill_stress_replace_pid $replace_pid
 	_btrfs_kill_stress_defrag_pid $defrag_pid
 
 	echo "Scrub the filesystem" >>$seqres.full
diff --git a/tests/btrfs/071 b/tests/btrfs/071
index 7ba15390..36b39341 100755
--- a/tests/btrfs/071
+++ b/tests/btrfs/071
@@ -58,14 +58,8 @@ run_test()
 	echo "$remount_pid" >>$seqres.full
 
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
-	kill $replace_pid
-	wait $fsstress_pid $replace_pid
-
-	# wait for the replace operationss to finish
-	while ps aux | grep "replace start" | grep -qv grep; do
-		sleep 1
-	done
-
+	wait $fsstress_pid
+	_btrfs_kill_stress_replace_pid $replace_pid
 	_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
 
 	echo "Scrub the filesystem" >>$seqres.full
-- 
2.43.0


