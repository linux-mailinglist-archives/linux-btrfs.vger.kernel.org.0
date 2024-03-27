Return-Path: <linux-btrfs+bounces-3663-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B6188EC4A
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 18:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33F27B27F9F
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 17:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A15E14EC65;
	Wed, 27 Mar 2024 17:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z94/qJ7C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2B314D70A;
	Wed, 27 Mar 2024 17:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711559524; cv=none; b=AyHLjdIaEvRDcBLJ14bduyiTSUKPoOkWOsDk4hmfj2NftoeTL79lH7lWtIEmRypReZfJXXPwVmBIuneOZ+qQpevUgy6xK6aK1XM93qRvejvyDJG8PANM+RpxtnSfOhKfV+5hLMJpAe4oqyKv5zWFSzL6oBg5uhrIOBEMDlm9VoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711559524; c=relaxed/simple;
	bh=f/azJUMBGXsfSJOxJFP4khx7N7IMoR4krNW88Ug1bgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fCGn11ZsUHmoGEW50H3zeEgisuA16TBt8f2rpB2CcsYiViZfLBmKzJy7k3L5dtMJKsrmhvup3MLXYOUmBqTHZRxyV9+SVMMJDGGJL5QyUAyw5fNeu5C+PzpkzrHvWL9KtvdvAebilzHT97mr+qzqjIk72MNMoeidUXGoP+lM1rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z94/qJ7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BBF7C433F1;
	Wed, 27 Mar 2024 17:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711559524;
	bh=f/azJUMBGXsfSJOxJFP4khx7N7IMoR4krNW88Ug1bgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z94/qJ7CKI4Qi6JLdI0QlPPiJEEwWMvGkh+z5BlbVOoHT5C/kRoj9YkPdbDYU2UMM
	 c1tPhuBn574M9bGQrcVeYoc9XzDCDHCo2ry6MHvLWoExpKwwuqJviLD3CpXEmN77t/
	 XHfttjAaq5S4M/yt6Wef8OtxhLS3Gu57QtyY/9eA/Og7Mnn7+XfEy1QGt8A0SY6lxE
	 +k0UE4i509erLfFwAIa6EqehYV4Cw5r1AP9hONHNPHvVwyn50UA0xWErlnkbfRPlDU
	 ssMYBrpTT/Wadm+bRgJy7TZH66hH1vjk9z1D/8sdBkSwLntiRxOYzKQ8aFqJYIB9ow
	 9jSIWMh08IWxQ==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 08/10] btrfs: add helper to stop background process running _btrfs_stress_subvolume
Date: Wed, 27 Mar 2024 17:11:42 +0000
Message-ID: <478d09248cf2a98a59853718197104735edd52c7.1711558345.git.fdmanana@suse.com>
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

We have this logic to stop a process running _btrfs_stress_subvolume()
spread in several test cases:

   touch $stop_file
   wait $subvol_pid

Add a helper to encapsulate that logic and also remove the stop file after
the process terminated as there's no point having it around anymore.

This will help to avoid repeating the same code again several times in
upcoming changes.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 common/btrfs    | 12 ++++++++++++
 tests/btrfs/060 |  3 +--
 tests/btrfs/065 |  3 +--
 tests/btrfs/066 |  3 +--
 tests/btrfs/067 |  3 +--
 tests/btrfs/068 |  3 +--
 6 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index 6d7e7a68..e19a6ad1 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -340,6 +340,18 @@ _btrfs_stress_subvolume()
 	done
 }
 
+# Kill a background process running _btrfs_stress_subvolume()
+_btrfs_kill_stress_subvolume_pid()
+{
+	local subvol_pid=$1
+	local stop_file=$2
+
+	touch $stop_file
+	# Ignore if process already died.
+	wait $subvol_pid &> /dev/null
+	rm -f $stop_file
+}
+
 # stress btrfs by running scrub in a loop
 _btrfs_stress_scrub()
 {
diff --git a/tests/btrfs/060 b/tests/btrfs/060
index 58167cc6..87823aba 100755
--- a/tests/btrfs/060
+++ b/tests/btrfs/060
@@ -56,8 +56,7 @@ run_test()
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
 	wait $fsstress_pid
 
-	touch $stop_file
-	wait $subvol_pid
+	_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
 	_btrfs_kill_stress_balance_pid $balance_pid
 
 	echo "Scrub the filesystem" >>$seqres.full
diff --git a/tests/btrfs/065 b/tests/btrfs/065
index d2b04178..ddc28616 100755
--- a/tests/btrfs/065
+++ b/tests/btrfs/065
@@ -64,8 +64,7 @@ run_test()
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
 	wait $fsstress_pid
 
-	touch $stop_file
-	wait $subvol_pid
+	_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
 	_btrfs_kill_stress_replace_pid $replace_pid
 
 	echo "Scrub the filesystem" >>$seqres.full
diff --git a/tests/btrfs/066 b/tests/btrfs/066
index 29821fdd..c7488602 100755
--- a/tests/btrfs/066
+++ b/tests/btrfs/066
@@ -56,8 +56,7 @@ run_test()
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
 	wait $fsstress_pid
 
-	touch $stop_file
-	wait $subvol_pid
+	_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
 	_btrfs_kill_stress_scrub_pid $scrub_pid
 
 	echo "Scrub the filesystem" >>$seqres.full
diff --git a/tests/btrfs/067 b/tests/btrfs/067
index 2bb00b87..ebbec1be 100755
--- a/tests/btrfs/067
+++ b/tests/btrfs/067
@@ -57,8 +57,7 @@ run_test()
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
 	wait $fsstress_pid
 
-	touch $stop_file
-	wait $subvol_pid
+	_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
 	_btrfs_kill_stress_defrag_pid $defrag_pid
 
 	echo "Scrub the filesystem" >>$seqres.full
diff --git a/tests/btrfs/068 b/tests/btrfs/068
index db53254a..5f41fb74 100755
--- a/tests/btrfs/068
+++ b/tests/btrfs/068
@@ -57,8 +57,7 @@ run_test()
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
 	wait $fsstress_pid
 
-	touch $stop_file
-	wait $subvol_pid
+	_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
 	_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
 
 	echo "Scrub the filesystem" >>$seqres.full
-- 
2.43.0


