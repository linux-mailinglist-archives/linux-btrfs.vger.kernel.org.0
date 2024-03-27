Return-Path: <linux-btrfs+bounces-3660-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0571488EC35
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 18:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EF15299ED1
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 17:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6CA14E2F6;
	Wed, 27 Mar 2024 17:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcvUjbSZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BE114E2F3;
	Wed, 27 Mar 2024 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711559520; cv=none; b=jLYJKzCntmDp78lEjwfl6j8Son2NE5hFCJHHFhOCcyYpEWQiO569pjMYaDhybFU27HPR9HPQQLyx++rrDsJrdHb8Q+obbozmEfCacZUddgoqWDmb13sKlAnrWrbV1MNJiuxVQk3ntHQttZTtRZh5TGr+H2Ffw0ee+xhFoPFTTso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711559520; c=relaxed/simple;
	bh=Zb/dlXz6K/v2wrzxkvGZAVHTuf3HA4j87EhPu1yDskQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=steXFxT/2bluVZQrDEq0kjNemWUZGA9iTgcUgv2OJs60s01BWAAJoMlIxVjooucAhfQXyCBBdAcEJB5S7Swr6Vs8Bu9fK93+7d8xFXGHBcsXPCnyxQe8A7/E62mS3YdgyCjxRYE7UcLrojcVzNXPQEFslFdy+5DaGSyCQmB/1IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcvUjbSZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32174C433F1;
	Wed, 27 Mar 2024 17:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711559520;
	bh=Zb/dlXz6K/v2wrzxkvGZAVHTuf3HA4j87EhPu1yDskQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tcvUjbSZgXLIO3WWnt9PicjRsgjdAS3+Fi65M5GH9/PjQ5lWW3omfjpZCZsjFNZYE
	 jwsL+/EiORI0g3JzM27GtwZx8z2CTbVVKDHHNdsaa42gENE05u+1Id5lQQlo+IsqIx
	 AjI5HliFWby/onUqvN3+Zj7ByTBJW7gZtTRuzUEgtvN902gUleogXnB6IKcKPKXUdE
	 RKZrV9EzL/C75AiHF9xiIwqyL4snU8KkkuQ2hznhJRv3ZoUfTPYNe+ObYrimldnUt+
	 T6L0pZ4P3OQWRk7ZD14z0DJzD4b5cSwEJrDh5ihrZGrLgHG8xEi6PCg5Enu5aCWT3f
	 72QrHEtUYBXDQ==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 05/10] btrfs: add helper to kill background process running _btrfs_stress_defrag
Date: Wed, 27 Mar 2024 17:11:39 +0000
Message-ID: <247bde0d4f7d943337e228dded8ad03753b0e3c9.1711558345.git.fdmanana@suse.com>
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

Killing a background process running _btrfs_stress_defrag() is not as
simple as sending a signal to the process and waiting for it to die.
Therefore we have the following logic to terminate such process:

       kill $pid
       wait $pid
       while ps aux | grep "btrfs filesystem defrag" | grep -qv grep; do
           sleep 1
       done

Since this is repeated in several test cases, move this logic to a common
helper and use it in all affected test cases. This will help to avoid
repeating the same code again several times in upcoming changes.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 common/btrfs    | 14 ++++++++++++++
 tests/btrfs/062 |  7 +------
 tests/btrfs/067 |  8 ++------
 tests/btrfs/070 | 11 +++++------
 tests/btrfs/072 |  7 +------
 tests/btrfs/074 | 11 +++++------
 6 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index d0adeea1..46056d4a 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -383,6 +383,20 @@ _btrfs_stress_defrag()
 	done
 }
 
+# Kill a background process running _btrfs_stress_defrag()
+_btrfs_kill_stress_defrag_pid()
+{
+       local defrag_pid=$1
+
+       # Ignore if process already died.
+       kill $defrag_pid &> /dev/null
+       wait $defrag_pid &> /dev/null
+       # Wait for the defrag operation to finish.
+       while ps aux | grep "btrfs filesystem defrag" | grep -qv grep; do
+               sleep 1
+       done
+}
+
 # stress btrfs by remounting it with different compression algorithms in a loop
 # run this with fsstress running at background could exercise the compression
 # code path and ensure no race when switching compression algorithm with constant
diff --git a/tests/btrfs/062 b/tests/btrfs/062
index a2639d6c..59d581be 100755
--- a/tests/btrfs/062
+++ b/tests/btrfs/062
@@ -53,12 +53,7 @@ run_test()
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
 	wait $fsstress_pid
 	_btrfs_kill_stress_balance_pid $balance_pid
-	kill $defrag_pid
-	wait $defrag_pid
-	# wait for the defrag operation to finish
-	while ps aux | grep "btrfs filesystem defrag" | grep -qv grep; do
-		sleep 1
-	done
+	_btrfs_kill_stress_defrag_pid $defrag_pid
 
 	echo "Scrub the filesystem" >>$seqres.full
 	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
diff --git a/tests/btrfs/067 b/tests/btrfs/067
index 709db155..2bb00b87 100755
--- a/tests/btrfs/067
+++ b/tests/btrfs/067
@@ -58,12 +58,8 @@ run_test()
 	wait $fsstress_pid
 
 	touch $stop_file
-	kill $defrag_pid
-	wait
-	# wait for btrfs defrag process to exit, otherwise it will block umount
-	while ps aux | grep "btrfs filesystem defrag" | grep -qv grep; do
-		sleep 1
-	done
+	wait $subvol_pid
+	_btrfs_kill_stress_defrag_pid $defrag_pid
 
 	echo "Scrub the filesystem" >>$seqres.full
 	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
diff --git a/tests/btrfs/070 b/tests/btrfs/070
index 54aa275c..cefa5723 100755
--- a/tests/btrfs/070
+++ b/tests/btrfs/070
@@ -60,17 +60,16 @@ run_test()
 
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
 	wait $fsstress_pid
-	kill $replace_pid $defrag_pid
-	wait
+	kill $replace_pid
+	wait $replace_pid
 
-	# wait for the defrag and replace operations to finish
-	while ps aux | grep "btrfs filesystem defrag" | grep -qv grep; do
-		sleep 1
-	done
+	# wait for the replace operation to finish
 	while ps aux | grep "replace start" | grep -qv grep; do
 		sleep 1
 	done
 
+	_btrfs_kill_stress_defrag_pid $defrag_pid
+
 	echo "Scrub the filesystem" >>$seqres.full
 	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
 	if [ $? -ne 0 ]; then
diff --git a/tests/btrfs/072 b/tests/btrfs/072
index 6c15b51f..505d0b57 100755
--- a/tests/btrfs/072
+++ b/tests/btrfs/072
@@ -52,13 +52,8 @@ run_test()
 
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
 	wait $fsstress_pid
-	kill $defrag_pid
-	wait $defrag_pid
-	# wait for the defrag operation to finish
-	while ps aux | grep "btrfs filesystem defrag" | grep -qv grep; do
-		sleep 1
-	done
 
+	_btrfs_kill_stress_defrag_pid $defrag_pid
 	_btrfs_kill_stress_scrub_pid $scrub_pid
 
 	echo "Scrub the filesystem" >>$seqres.full
diff --git a/tests/btrfs/074 b/tests/btrfs/074
index 9b22c620..d51922d0 100755
--- a/tests/btrfs/074
+++ b/tests/btrfs/074
@@ -52,16 +52,15 @@ run_test()
 
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
 	wait $fsstress_pid
-	kill $defrag_pid $remount_pid
-	wait
-	# wait for the defrag and remount operations to finish
-	while ps aux | grep "btrfs filesystem defrag" | grep -qv grep; do
-		sleep 1
-	done
+	kill $remount_pid
+	wait $remount_pid
+	# wait for the remount operation to finish
 	while ps aux | grep "mount.*$SCRATCH_MNT" | grep -qv grep; do
 		sleep 1
 	done
 
+	_btrfs_kill_stress_defrag_pid $defrag_pid
+
 	echo "Scrub the filesystem" >>$seqres.full
 	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
 	if [ $? -ne 0 ]; then
-- 
2.43.0


