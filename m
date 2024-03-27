Return-Path: <linux-btrfs+bounces-3665-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD8188EC38
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 18:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFDBF29C443
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 17:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF0B14F111;
	Wed, 27 Mar 2024 17:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pza8ACff"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA14513774D;
	Wed, 27 Mar 2024 17:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711559526; cv=none; b=C0iaokcoFUiwNcoMyff4o/84Sau7cack8IJeSA9ToR7+VhLRvdVCVMpLz1ZeP2o6GPazmcA9r/Zbtf7FCPbMFD3YGBsXx7JZYCXatUsWd/UCerNJGgq27pBJu6PBmcW1vB7MaeRIhLYQ4AkuIywJgDwBYYrUfC8R9rIKKsjAkz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711559526; c=relaxed/simple;
	bh=v5pf0lSa3h+btHzVGfzTgJcWCE5ool7jkXrROY+POeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=haqe9jioNabssigd/wn55oEdKhCTAYzI9/COrUHCfCMgzN/WkM5kF/KocT5H2UXSKdt0irNeNJXmfiSsAMOsb7ohQvvuHSu0ZWsZMCO32TJvs4yfb4ijp9OMq0/ubt62k6f/Dez6n7R19LW7KCuK58TtGMWIP0Z5YjlN1AGzyl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pza8ACff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5622C433F1;
	Wed, 27 Mar 2024 17:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711559526;
	bh=v5pf0lSa3h+btHzVGfzTgJcWCE5ool7jkXrROY+POeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pza8ACffRZ/fDde3XhkKZMJNfMpP8vHZfEh3JrIDG0Y0AyLVb7PvS6aOAntxEEqAB
	 Sy0RTBUqbNN9EmZbCthzfDPEuHEMGQeuNZ9S7j4VkFl6+FZQIQSqqsC2VJHkmr/qaR
	 LwtaqQg0aATjmdsofwX8kF/imTNxrb3Pi/mpvEkTfzaYawFRfB7sf5vDH4oGVjG4cD
	 xhAJBNZbq0j5+Ez63QVh7N89itlLEqvrEap30KMZkX6M/1XVMir59r6fPAnMmEFLA5
	 x4uu+jRTR6fYC/bNTaLfyJmERitu7OFbTY3JdcaQskrQuum5Eb3C2wfEhUCX33ZO1y
	 d5+ENzIK6DwDA==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 10/10] btrfs/06[0-9]..07[0-4]: kill all background tasks when test is killed/interrupted
Date: Wed, 27 Mar 2024 17:11:44 +0000
Message-ID: <48866623524ab565944db6f7fa61f6a0ce0c0996.1711558345.git.fdmanana@suse.com>
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

Test cases btrfs/06[0-9] and btrfs/07[0-4] exercise multiple concurrent
operations while fsstress is running in parallel, and all these are left
as child processes running in the background, which are correctly stopped
if the tests are not interrupted/killed. However if any of these tests is
interrupted/killed, it often leaves child processes still running in the
background, which prevent further running fstests again. For example:

  $ /check -g auto
  (...)
  btrfs/060 394s ...  264s
  btrfs/061 83s ...  69s
  btrfs/062 109s ...  105s
  btrfs/063 52s ...  67s
  btrfs/064 53s ...  51s
  btrfs/065 88s ...  271s
  btrfs/066 127s ...  241s
  btrfs/067 435s ...  248s
  btrfs/068 161s ... ^C^C
  ^C

  $ ./check btrfs/068
  FSTYP         -- btrfs
  PLATFORM      -- Linux/x86_64 debian0 6.8.0-rc7-btrfs-next-153+ #1 SMP PREEMPT_DYNAMIC Mon Mar  4 17:19:19 WET 2024
  MKFS_OPTIONS  -- /dev/sdb
  MOUNT_OPTIONS -- /dev/sdb /home/fdmanana/btrfs-tests/scratch_1

  our local _scratch_mkfs routine ...
  btrfs-progs v6.6.2
  See https://btrfs.readthedocs.io for more information.

  ERROR: unable to open /dev/sdb: Device or resource busy
  check: failed to mkfs $SCRATCH_DEV using specified options
  Interrupted!
  Passed all 0 tests

In this case there was still a process running _btrfs_stress_subvolume()
from common/btrfs.

This is a bit annoying because it requires manually finding out which
process is preventing unmounting the scratch device and then properly
stop/kill it.

So fix this by adding a _cleanup() function to all these tests and then
making sure it stops all the child processes it spawned and are running
in the background.

All these tests have the same structure as they were part of the same
patchset and from the same author.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/060 | 22 +++++++++++++++++++++-
 tests/btrfs/061 | 19 +++++++++++++++++++
 tests/btrfs/062 | 19 +++++++++++++++++++
 tests/btrfs/063 | 19 +++++++++++++++++++
 tests/btrfs/064 | 19 +++++++++++++++++++
 tests/btrfs/065 | 22 +++++++++++++++++++++-
 tests/btrfs/066 | 22 +++++++++++++++++++++-
 tests/btrfs/067 | 22 +++++++++++++++++++++-
 tests/btrfs/068 | 22 +++++++++++++++++++++-
 tests/btrfs/069 | 19 +++++++++++++++++++
 tests/btrfs/070 | 19 +++++++++++++++++++
 tests/btrfs/071 | 19 +++++++++++++++++++
 tests/btrfs/072 | 19 +++++++++++++++++++
 tests/btrfs/073 | 19 +++++++++++++++++++
 tests/btrfs/074 | 19 +++++++++++++++++++
 15 files changed, 295 insertions(+), 5 deletions(-)

diff --git a/tests/btrfs/060 b/tests/btrfs/060
index 53cbd3a0..f74d9593 100755
--- a/tests/btrfs/060
+++ b/tests/btrfs/060
@@ -10,6 +10,22 @@
 . ./common/preamble
 _begin_fstest auto balance subvol scrub
 
+_cleanup()
+{
+	cd /
+	rm -rf $tmp.*
+	if [ ! -z "$stop_file" ] && [ ! -z "$subvol_pid" ]; then
+		_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
+	fi
+	if [ ! -z "$balance_pid" ]; then
+		_btrfs_kill_stress_balance_pid $balance_pid
+	fi
+	if [ ! -z "$fsstress_pid" ]; then
+		kill $fsstress_pid &> /dev/null
+		wait $fsstress_pid &> /dev/null
+	fi
+}
+
 # Import common functions.
 . ./common/filter
 
@@ -20,11 +36,12 @@ _require_scratch_nocheck
 _require_scratch_dev_pool 4
 _btrfs_get_profile_configs
 
+stop_file=$TEST_DIR/$seq.stop.$$
+
 run_test()
 {
 	local mkfs_opts=$1
 	local subvol_mnt=$TEST_DIR/$seq.mnt
-	local stop_file=$TEST_DIR/$seq.stop.$$
 
 	echo "Test $mkfs_opts" >>$seqres.full
 
@@ -53,9 +70,12 @@ run_test()
 
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
 	wait $fsstress_pid
+	unset fsstress_pid
 
 	_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
+	unset subvol_pid
 	_btrfs_kill_stress_balance_pid $balance_pid
+	unset balance_pid
 
 	echo "Scrub the filesystem" >>$seqres.full
 	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
diff --git a/tests/btrfs/061 b/tests/btrfs/061
index b8b2706c..fec90882 100755
--- a/tests/btrfs/061
+++ b/tests/btrfs/061
@@ -10,6 +10,22 @@
 . ./common/preamble
 _begin_fstest auto balance scrub
 
+_cleanup()
+{
+	cd /
+	rm -rf $tmp.*
+	if [ ! -z "$balance_pid" ]; then
+		_btrfs_kill_stress_balance_pid $balance_pid
+	fi
+	if [ ! -z "$scrub_pid" ]; then
+		_btrfs_kill_stress_scrub_pid $scrub_pid
+	fi
+	if [ ! -z "$fsstress_pid" ]; then
+		kill $fsstress_pid &> /dev/null
+		wait $fsstress_pid &> /dev/null
+	fi
+}
+
 # Import common functions.
 . ./common/filter
 
@@ -51,8 +67,11 @@ run_test()
 
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
 	wait $fsstress_pid
+	unset fsstress_pid
 	_btrfs_kill_stress_balance_pid $balance_pid
+	unset balance_pid
 	_btrfs_kill_stress_scrub_pid $scrub_pid
+	unset scrub_pid
 
 	echo "Scrub the filesystem" >>$seqres.full
 	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
diff --git a/tests/btrfs/062 b/tests/btrfs/062
index 59d581be..0b57681f 100755
--- a/tests/btrfs/062
+++ b/tests/btrfs/062
@@ -10,6 +10,22 @@
 . ./common/preamble
 _begin_fstest auto balance defrag compress scrub
 
+_cleanup()
+{
+	cd /
+	rm -rf $tmp.*
+	if [ ! -z "$balance_pid" ]; then
+		_btrfs_kill_stress_balance_pid $balance_pid
+	fi
+	if [ ! -z "$defrag_pid" ]; then
+		_btrfs_kill_stress_defrag_pid $defrag_pid
+	fi
+	if [ ! -z "$fsstress_pid" ]; then
+		kill $fsstress_pid &> /dev/null
+		wait $fsstress_pid &> /dev/null
+	fi
+}
+
 # Import common functions.
 . ./common/filter
 
@@ -52,8 +68,11 @@ run_test()
 
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
 	wait $fsstress_pid
+	unset fsstress_pid
 	_btrfs_kill_stress_balance_pid $balance_pid
+	unset balance_pid
 	_btrfs_kill_stress_defrag_pid $defrag_pid
+	unset defrag_pid
 
 	echo "Scrub the filesystem" >>$seqres.full
 	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
diff --git a/tests/btrfs/063 b/tests/btrfs/063
index 5ee2837f..99d9d2c1 100755
--- a/tests/btrfs/063
+++ b/tests/btrfs/063
@@ -10,6 +10,22 @@
 . ./common/preamble
 _begin_fstest auto balance remount compress scrub
 
+_cleanup()
+{
+	cd /
+	rm -rf $tmp.*
+	if [ ! -z "$balance_pid" ]; then
+		_btrfs_kill_stress_balance_pid $balance_pid
+	fi
+	if [ ! -z "$remount_pid" ]; then
+		_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
+	fi
+	if [ ! -z "$fsstress_pid" ]; then
+		kill $fsstress_pid &> /dev/null
+		wait $fsstress_pid &> /dev/null
+	fi
+}
+
 # Import common functions.
 . ./common/filter
 
@@ -51,8 +67,11 @@ run_test()
 
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
 	wait $fsstress_pid
+	unset fsstress_pid
 	_btrfs_kill_stress_balance_pid $balance_pid
+	unset balance_pid
 	_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
+	unset remount_pid
 
 	echo "Scrub the filesystem" >>$seqres.full
 	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
diff --git a/tests/btrfs/064 b/tests/btrfs/064
index 9e0b3b30..663442c6 100755
--- a/tests/btrfs/064
+++ b/tests/btrfs/064
@@ -12,6 +12,22 @@
 . ./common/preamble
 _begin_fstest auto balance replace volume scrub
 
+_cleanup()
+{
+	cd /
+	rm -rf $tmp.*
+	if [ ! -z "$balance_pid" ]; then
+		_btrfs_kill_stress_balance_pid $balance_pid
+	fi
+	if [ ! -z "$replace_pid" ]; then
+		_btrfs_kill_stress_replace_pid $replace_pid
+	fi
+	if [ ! -z "$fsstress_pid" ]; then
+		kill $fsstress_pid &> /dev/null
+		wait $fsstress_pid &> /dev/null
+	fi
+}
+
 # Import common functions.
 . ./common/filter
 
@@ -63,8 +79,11 @@ run_test()
 
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
 	wait $fsstress_pid
+	unset fsstress_pid
 	_btrfs_kill_stress_balance_pid $balance_pid
+	unset balance_pid
 	_btrfs_kill_stress_replace_pid $replace_pid
+	unset replace_pid
 
 	echo "Scrub the filesystem" >>$seqres.full
 	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
diff --git a/tests/btrfs/065 b/tests/btrfs/065
index f9e43cdc..b1e54fc8 100755
--- a/tests/btrfs/065
+++ b/tests/btrfs/065
@@ -10,6 +10,22 @@
 . ./common/preamble
 _begin_fstest auto subvol replace volume scrub
 
+_cleanup()
+{
+	cd /
+	rm -rf $tmp.*
+	if [ ! -z "$stop_file" ] && [ ! -z "$subvol_pid" ]; then
+		_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
+	fi
+	if [ ! -z "$replace_pid" ]; then
+		_btrfs_kill_stress_replace_pid $replace_pid
+	fi
+	if [ ! -z "$fsstress_pid" ]; then
+		kill $fsstress_pid &> /dev/null
+		wait $fsstress_pid &> /dev/null
+	fi
+}
+
 # Import common functions.
 . ./common/filter
 
@@ -21,12 +37,13 @@ _require_scratch_dev_pool 5
 _require_scratch_dev_pool_equal_size
 _btrfs_get_profile_configs replace
 
+stop_file=$TEST_DIR/$seq.stop.$$
+
 run_test()
 {
 	local mkfs_opts=$1
 	local saved_scratch_dev_pool=$SCRATCH_DEV_POOL
 	local subvol_mnt=$TEST_DIR/$seq.mnt
-	local stop_file=$TEST_DIR/$seq.stop.$$
 
 	echo "Test $mkfs_opts" >>$seqres.full
 
@@ -61,9 +78,12 @@ run_test()
 
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
 	wait $fsstress_pid
+	unset fsstress_pid
 
 	_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
+	unset subvol_pid
 	_btrfs_kill_stress_replace_pid $replace_pid
+	unset replace_pid
 
 	echo "Scrub the filesystem" >>$seqres.full
 	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
diff --git a/tests/btrfs/066 b/tests/btrfs/066
index b6f904ac..feb6062e 100755
--- a/tests/btrfs/066
+++ b/tests/btrfs/066
@@ -10,6 +10,22 @@
 . ./common/preamble
 _begin_fstest auto subvol scrub
 
+_cleanup()
+{
+	cd /
+	rm -rf $tmp.*
+	if [ ! -z "$stop_file" ] && [ ! -z "$subvol_pid" ]; then
+		_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
+	fi
+	if [ ! -z "$scrub_pid" ]; then
+		_btrfs_kill_stress_scrub_pid $scrub_pid
+	fi
+	if [ ! -z "$fsstress_pid" ]; then
+		kill $fsstress_pid &> /dev/null
+		wait $fsstress_pid &> /dev/null
+	fi
+}
+
 # Import common functions.
 . ./common/filter
 
@@ -20,11 +36,12 @@ _require_scratch_nocheck
 _require_scratch_dev_pool 4
 _btrfs_get_profile_configs
 
+stop_file=$TEST_DIR/$seq.stop.$$
+
 run_test()
 {
 	local mkfs_opts=$1
 	local subvol_mnt=$TEST_DIR/$seq.mnt
-	local stop_file=$TEST_DIR/$seq.stop.$$
 
 	echo "Test $mkfs_opts" >>$seqres.full
 
@@ -53,9 +70,12 @@ run_test()
 
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
 	wait $fsstress_pid
+	unset fsstress_pid
 
 	_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
+	unset subvol_pid
 	_btrfs_kill_stress_scrub_pid $scrub_pid
+	unset scrub_pid
 
 	echo "Scrub the filesystem" >>$seqres.full
 	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
diff --git a/tests/btrfs/067 b/tests/btrfs/067
index 7be09d52..0bbfe83f 100755
--- a/tests/btrfs/067
+++ b/tests/btrfs/067
@@ -10,6 +10,22 @@
 . ./common/preamble
 _begin_fstest auto subvol defrag compress scrub
 
+_cleanup()
+{
+	cd /
+	rm -rf $tmp.*
+	if [ ! -z "$stop_file" ] && [ ! -z "$subvol_pid" ]; then
+		_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
+	fi
+	if [ ! -z "$defrag_pid" ]; then
+		_btrfs_kill_stress_defrag_pid $defrag_pid
+	fi
+	if [ ! -z "$fsstress_pid" ]; then
+		kill $fsstress_pid &> /dev/null
+		wait $fsstress_pid &> /dev/null
+	fi
+}
+
 # Import common functions.
 . ./common/filter
 
@@ -20,12 +36,13 @@ _require_scratch_nocheck
 _require_scratch_dev_pool 4
 _btrfs_get_profile_configs
 
+stop_file=$TEST_DIR/$seq.stop.$$
+
 run_test()
 {
 	local mkfs_opts=$1
 	local with_compress=$2
 	local subvol_mnt=$TEST_DIR/$seq.mnt
-	local stop_file=$TEST_DIR/$seq.stop.$$
 
 	echo "Test $mkfs_opts with $with_compress" >>$seqres.full
 
@@ -54,9 +71,12 @@ run_test()
 
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
 	wait $fsstress_pid
+	unset fsstress_pid
 
 	_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
+	unset subvol_pid
 	_btrfs_kill_stress_defrag_pid $defrag_pid
+	unset defrag_pid
 
 	echo "Scrub the filesystem" >>$seqres.full
 	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
diff --git a/tests/btrfs/068 b/tests/btrfs/068
index 19e37010..7ab6feca 100755
--- a/tests/btrfs/068
+++ b/tests/btrfs/068
@@ -11,6 +11,22 @@
 . ./common/preamble
 _begin_fstest auto subvol remount compress scrub
 
+_cleanup()
+{
+	cd /
+	rm -rf $tmp.*
+	if [ ! -z "$stop_file" ] && [ ! -z "$subvol_pid" ]; then
+		_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
+	fi
+	if [ ! -z "$remount_pid" ]; then
+		_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
+	fi
+	if [ ! -z "$fsstress_pid" ]; then
+		kill $fsstress_pid &> /dev/null
+		wait $fsstress_pid &> /dev/null
+	fi
+}
+
 # Import common functions.
 . ./common/filter
 
@@ -21,11 +37,12 @@ _require_scratch_nocheck
 _require_scratch_dev_pool 4
 _btrfs_get_profile_configs
 
+stop_file=$TEST_DIR/$seq.stop.$$
+
 run_test()
 {
 	local mkfs_opts=$1
 	local subvol_mnt=$TEST_DIR/$seq.mnt
-	local stop_file=$TEST_DIR/$seq.stop.$$
 
 	echo "Test $mkfs_opts with $with_compress" >>$seqres.full
 
@@ -54,9 +71,12 @@ run_test()
 
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
 	wait $fsstress_pid
+	unset fsstress_pid
 
 	_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
+	unset subvol_pid
 	_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
+	unset remount_pid
 
 	echo "Scrub the filesystem" >>$seqres.full
 	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
diff --git a/tests/btrfs/069 b/tests/btrfs/069
index ad1609d4..3fbfecdb 100755
--- a/tests/btrfs/069
+++ b/tests/btrfs/069
@@ -10,6 +10,22 @@
 . ./common/preamble
 _begin_fstest auto replace scrub volume
 
+_cleanup()
+{
+	cd /
+	rm -rf $tmp.*
+	if [ ! -z "$replace_pid" ]; then
+		_btrfs_kill_stress_replace_pid $replace_pid
+	fi
+	if [ ! -z "$scrub_pid" ]; then
+		_btrfs_kill_stress_scrub_pid $scrub_pid
+	fi
+	if [ ! -z "$fsstress_pid" ]; then
+		kill $fsstress_pid &> /dev/null
+		wait $fsstress_pid &> /dev/null
+	fi
+}
+
 # Import common functions.
 . ./common/filter
 
@@ -59,8 +75,11 @@ run_test()
 
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
 	wait $fsstress_pid
+	unset fsstress_pid
 	_btrfs_kill_stress_scrub_pid $scrub_pid
+	unset scrub_pid
 	_btrfs_kill_stress_replace_pid $replace_pid
+	unset replace_pid
 
 	echo "Scrub the filesystem" >>$seqres.full
 	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
diff --git a/tests/btrfs/070 b/tests/btrfs/070
index 3054c270..11fddc86 100755
--- a/tests/btrfs/070
+++ b/tests/btrfs/070
@@ -10,6 +10,22 @@
 . ./common/preamble
 _begin_fstest auto replace defrag compress volume scrub
 
+_cleanup()
+{
+	cd /
+	rm -rf $tmp.*
+	if [ ! -z "$replace_pid" ]; then
+		_btrfs_kill_stress_replace_pid $replace_pid
+	fi
+	if [ ! -z "$defrag_pid" ]; then
+		_btrfs_kill_stress_defrag_pid $defrag_pid
+	fi
+	if [ ! -z "$fsstress_pid" ]; then
+		kill $fsstress_pid &> /dev/null
+		wait $fsstress_pid &> /dev/null
+	fi
+}
+
 # Import common functions.
 . ./common/filter
 
@@ -60,8 +76,11 @@ run_test()
 
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
 	wait $fsstress_pid
+	unset fsstress_pid
 	_btrfs_kill_stress_replace_pid $replace_pid
+	unset replace_pid
 	_btrfs_kill_stress_defrag_pid $defrag_pid
+	unset defrag_pid
 
 	echo "Scrub the filesystem" >>$seqres.full
 	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
diff --git a/tests/btrfs/071 b/tests/btrfs/071
index 36b39341..1a91ec45 100755
--- a/tests/btrfs/071
+++ b/tests/btrfs/071
@@ -10,6 +10,22 @@
 . ./common/preamble
 _begin_fstest auto replace remount compress volume scrub
 
+_cleanup()
+{
+	cd /
+	rm -rf $tmp.*
+	if [ ! -z "$replace_pid" ]; then
+		_btrfs_kill_stress_replace_pid $replace_pid
+	fi
+	if [ ! -z "$remount_pid" ]; then
+		_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
+	fi
+	if [ ! -z "$fsstress_pid" ]; then
+		kill $fsstress_pid &> /dev/null
+		wait $fsstress_pid &> /dev/null
+	fi
+}
+
 # Import common functions.
 . ./common/filter
 
@@ -59,8 +75,11 @@ run_test()
 
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
 	wait $fsstress_pid
+	unset fsstress_pid
 	_btrfs_kill_stress_replace_pid $replace_pid
+	unset replace_pid
 	_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
+	unset remount_pid
 
 	echo "Scrub the filesystem" >>$seqres.full
 	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
diff --git a/tests/btrfs/072 b/tests/btrfs/072
index 505d0b57..e66e49c9 100755
--- a/tests/btrfs/072
+++ b/tests/btrfs/072
@@ -10,6 +10,22 @@
 . ./common/preamble
 _begin_fstest auto scrub defrag compress
 
+_cleanup()
+{
+	cd /
+	rm -rf $tmp.*
+	if [ ! -z "$defrag_pid" ]; then
+		_btrfs_kill_stress_defrag_pid $defrag_pid
+	fi
+	if [ ! -z "$scrub_pid" ]; then
+		_btrfs_kill_stress_scrub_pid $scrub_pid
+	fi
+	if [ ! -z "$fsstress_pid" ]; then
+		kill $fsstress_pid &> /dev/null
+		wait $fsstress_pid &> /dev/null
+	fi
+}
+
 # Import common functions.
 . ./common/filter
 
@@ -52,9 +68,12 @@ run_test()
 
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
 	wait $fsstress_pid
+	unset fsstress_pid
 
 	_btrfs_kill_stress_defrag_pid $defrag_pid
+	unset defrag_pid
 	_btrfs_kill_stress_scrub_pid $scrub_pid
+	unset scrub_pid
 
 	echo "Scrub the filesystem" >>$seqres.full
 	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
diff --git a/tests/btrfs/073 b/tests/btrfs/073
index 50358286..e6cfd92a 100755
--- a/tests/btrfs/073
+++ b/tests/btrfs/073
@@ -10,6 +10,22 @@
 . ./common/preamble
 _begin_fstest auto scrub remount compress
 
+_cleanup()
+{
+	cd /
+	rm -rf $tmp.*
+	if [ ! -z "$remount_pid" ]; then
+		_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
+	fi
+	if [ ! -z "$scrub_pid" ]; then
+		_btrfs_kill_stress_scrub_pid $scrub_pid
+	fi
+	if [ ! -z "$fsstress_pid" ]; then
+		kill $fsstress_pid &> /dev/null
+		wait $fsstress_pid &> /dev/null
+	fi
+}
+
 # Import common functions.
 . ./common/filter
 
@@ -51,8 +67,11 @@ run_test()
 
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
 	wait $fsstress_pid
+	unset fsstress_pid
 	_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
+	unset remount_pid
 	_btrfs_kill_stress_scrub_pid $scrub_pid
+	unset scrub_pid
 
 	echo "Scrub the filesystem" >>$seqres.full
 	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
diff --git a/tests/btrfs/074 b/tests/btrfs/074
index 6e93b36a..1dd88bcd 100755
--- a/tests/btrfs/074
+++ b/tests/btrfs/074
@@ -10,6 +10,22 @@
 . ./common/preamble
 _begin_fstest auto defrag remount compress scrub
 
+_cleanup()
+{
+	cd /
+	rm -rf $tmp.*
+	if [ ! -z "$remount_pid" ]; then
+		_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
+	fi
+	if [ ! -z "$defrag_pid" ]; then
+		_btrfs_kill_stress_defrag_pid $defrag_pid
+	fi
+	if [ ! -z "$fsstress_pid" ]; then
+		kill $fsstress_pid &> /dev/null
+		wait $fsstress_pid &> /dev/null
+	fi
+}
+
 # Import common functions.
 . ./common/filter
 
@@ -52,8 +68,11 @@ run_test()
 
 	echo "Wait for fsstress to exit and kill all background workers" >>$seqres.full
 	wait $fsstress_pid
+	unset fsstress_pid
 	_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
+	unset remount_pid
 	_btrfs_kill_stress_defrag_pid $defrag_pid
+	unset defrag_pid
 
 	echo "Scrub the filesystem" >>$seqres.full
 	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
-- 
2.43.0


