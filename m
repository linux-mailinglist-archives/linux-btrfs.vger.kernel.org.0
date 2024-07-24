Return-Path: <linux-btrfs+bounces-6681-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8C393B22F
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2024 16:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC01A1F25550
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jul 2024 14:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D71C158DDC;
	Wed, 24 Jul 2024 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akkItAWj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5299EEAB;
	Wed, 24 Jul 2024 14:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721829609; cv=none; b=boZX7scWnJlrubBhAtX3ndztw83M5bPOjPyz2UHYIR3O0aAfht3IpWsv6vB4LlCNuOKwvmut7stXpU+W1gLEVXzPIPNf/QWAyLsV3iL3+ouiFF4lEOO3C6hLpSz3m+Ok71hIYwRWgs22gUR+Ay0N1yjq7e670T/XNIkMS3EbLUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721829609; c=relaxed/simple;
	bh=51GwSOXZW45NdsQw6iSa5GHSCxKyayBUAUBWtLdN8TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mLOwt4PlbVAWDD2HZrWRnMmjMa4NqdpZicCwj3DyrV3yWQ+VAnxVLgiKPd19rMZQP3ZVsKXBUGtVQIK+wri8gXfJxayI51TyPNR2mLReFjBjLAmF/TBx5hthoYEXg2R1HSXyxAG5/rfLHCG9A/Qz65io93minunCQ1hQd0xuAW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akkItAWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6235AC32781;
	Wed, 24 Jul 2024 14:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721829609;
	bh=51GwSOXZW45NdsQw6iSa5GHSCxKyayBUAUBWtLdN8TQ=;
	h=From:To:Cc:Subject:Date:From;
	b=akkItAWjke4ZbeBj2NcryzFRioHJXUswun9p3rotOlHKpVhbpCTllRKwNgrnFcZ5z
	 qAE9R6pGSqj+hitGezQnFYKRyxQlmSTO6w7gbFcCx6h8a9p8qVYaXkg4ASb0LjACP0
	 XH7QtCwWGMrxN7Cnz0fkWCqGu6hj1JFbhbqb1Mc70EVwcc7d1M4+rtLd4bJ5rU0OXC
	 HJFpy0JRxNx2vTWSNUqMQWhhyUhtWSXa/BR0JOt9QA8x5EjvLHqE6BMw5rs8yyR8lP
	 dzMwLv816iV36pyoy+l/r3jYx3CcsGteLEryWZ3TVP7cL89gHSydRDcdfRTe9iF1QS
	 MLjIqn85achpg==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: properly shutdown subvolume stress worker to avoid umount failures
Date: Wed, 24 Jul 2024 14:58:52 +0100
Message-ID: <4ee3a7f176ee871345a68aaa48b13e8ca89c2262.1721829411.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

When killing a test that is using the subvolume stress worker, we may end
up in a situation where we end up leaving a subvolume mounted which makes
the shutdown sequence fail. Example when killing a script that keeps
running fstests in a loop:

   FSTYP         -- btrfs
   PLATFORM      -- Linux/x86_64 debian0 6.10.0-rc7-btrfs-next-167+ #1 SMP PREEMPT_DYNAMIC Thu Jul 11 17:54:07 WEST 2024
   MKFS_OPTIONS  -- /dev/sdc
   MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

   (...)
   btrfs/065 23s ... ^C^C^C
   Iteration 134, errors 1, leaks 0, Wed Jul 24 12:14:33 PM WEST 2024, flakey errors: 0 MKFS_OPTIONS="" MOUNT_OPTIONS=""

   SCRATCH_DEV=/dev/sdc is mounted but not on SCRATCH_MNT=/home/fdmanana/btrfs-tests/scratch_1 - aborting
   Already mounted result:
   /dev/sdc /home/fdmanana/btrfs-tests/scratch_1 /dev/sdc /home/fdmanana/btrfs-tests/dev/065.mnt
   grep: results/btrfs/065.out.bad: No such file or directory
   Error iteration 134, total errors 2, leaks 0
   'results/btrfs/065.full' -> '/home/fdmanana/failures/btrfs_065/134/065.full'

Running 'mount' to see what's going on:

   $ mount
   (...)
   /dev/sdb on /home/fdmanana/btrfs-tests/dev type btrfs (rw,relatime,discard=async,space_cache=v2,subvolid=5,subvol=/)
   /dev/sdc on /home/fdmanana/btrfs-tests/scratch_1 type btrfs (rw,relatime,discard=async,space_cache=v2,subvolid=5,subvol=/)
   /dev/sdc on /home/fdmanana/btrfs-tests/dev/065.mnt type btrfs (rw,relatime,discard=async,space_cache=v2,subvolid=2627,subvol=/subvol_3395330)

Then this makes the next attempt to run a test (./check) always fail due
to the extra mount of the subvolume, requiring one to manually umount the
subvolume before running fstests again.

So update _btrfs_kill_stress_subvolume_pid() to also unmount the subvolume.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 common/btrfs    | 2 ++
 tests/btrfs/060 | 9 +++++----
 tests/btrfs/065 | 9 +++++----
 tests/btrfs/066 | 9 +++++----
 tests/btrfs/067 | 9 +++++----
 tests/btrfs/068 | 9 +++++----
 6 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index c0be7c08..95a9c8e6 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -362,11 +362,13 @@ _btrfs_kill_stress_subvolume_pid()
 {
 	local subvol_pid=$1
 	local stop_file=$2
+	local subvol_mnt=$3
 
 	touch $stop_file
 	# Ignore if process already died.
 	wait $subvol_pid &> /dev/null
 	rm -f $stop_file
+	$UMOUNT_PROG $subvol_mnt &> /dev/null
 }
 
 # stress btrfs by running scrub in a loop
diff --git a/tests/btrfs/060 b/tests/btrfs/060
index 00f57841..75c10bd2 100755
--- a/tests/btrfs/060
+++ b/tests/btrfs/060
@@ -14,8 +14,9 @@ _cleanup()
 {
 	cd /
 	rm -rf $tmp.*
-	if [ ! -z "$stop_file" ] && [ ! -z "$subvol_pid" ]; then
-		_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
+	if [ ! -z "$stop_file" ] && [ ! -z "$subvol_pid" ] && \
+		   [ ! -z "$subvol_mnt" ]; then
+		_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file $subvol_mnt
 	fi
 	if [ ! -z "$balance_pid" ]; then
 		_btrfs_kill_stress_balance_pid $balance_pid
@@ -34,11 +35,11 @@ _require_scratch_dev_pool 4
 _btrfs_get_profile_configs
 
 stop_file=$TEST_DIR/$seq.stop.$$
+subvol_mnt=$TEST_DIR/$seq.mnt
 
 run_test()
 {
 	local mkfs_opts=$1
-	local subvol_mnt=$TEST_DIR/$seq.mnt
 
 	echo "Test $mkfs_opts" >>$seqres.full
 
@@ -69,7 +70,7 @@ run_test()
 	wait $fsstress_pid
 	unset fsstress_pid
 
-	_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
+	_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file $subvol_mnt
 	unset subvol_pid
 	_btrfs_kill_stress_balance_pid $balance_pid
 	unset balance_pid
diff --git a/tests/btrfs/065 b/tests/btrfs/065
index 5fb635ab..b87c66d6 100755
--- a/tests/btrfs/065
+++ b/tests/btrfs/065
@@ -14,8 +14,9 @@ _cleanup()
 {
 	cd /
 	rm -rf $tmp.*
-	if [ ! -z "$stop_file" ] && [ ! -z "$subvol_pid" ]; then
-		_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
+	if [ ! -z "$stop_file" ] && [ ! -z "$subvol_pid" ] && \
+		   [ ! -z "$subvol_mnt" ]; then
+		_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file $subvol_mnt
 	fi
 	if [ ! -z "$replace_pid" ]; then
 		_btrfs_kill_stress_replace_pid $replace_pid
@@ -35,12 +36,12 @@ _require_scratch_dev_pool_equal_size
 _btrfs_get_profile_configs replace
 
 stop_file=$TEST_DIR/$seq.stop.$$
+subvol_mnt=$TEST_DIR/$seq.mnt
 
 run_test()
 {
 	local mkfs_opts=$1
 	local saved_scratch_dev_pool=$SCRATCH_DEV_POOL
-	local subvol_mnt=$TEST_DIR/$seq.mnt
 
 	echo "Test $mkfs_opts" >>$seqres.full
 
@@ -77,7 +78,7 @@ run_test()
 	wait $fsstress_pid
 	unset fsstress_pid
 
-	_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
+	_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file $subvol_mnt
 	unset subvol_pid
 	_btrfs_kill_stress_replace_pid $replace_pid
 	unset replace_pid
diff --git a/tests/btrfs/066 b/tests/btrfs/066
index 30fa438a..cc7cd9b7 100755
--- a/tests/btrfs/066
+++ b/tests/btrfs/066
@@ -14,8 +14,9 @@ _cleanup()
 {
 	cd /
 	rm -rf $tmp.*
-	if [ ! -z "$stop_file" ] && [ ! -z "$subvol_pid" ]; then
-		_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
+	if [ ! -z "$stop_file" ] && [ ! -z "$subvol_pid" ] && \
+		   [ ! -z "$subvol_mnt" ]; then
+		_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file $subvol_mnt
 	fi
 	if [ ! -z "$scrub_pid" ]; then
 		_btrfs_kill_stress_scrub_pid $scrub_pid
@@ -34,11 +35,11 @@ _require_scratch_dev_pool 4
 _btrfs_get_profile_configs
 
 stop_file=$TEST_DIR/$seq.stop.$$
+subvol_mnt=$TEST_DIR/$seq.mnt
 
 run_test()
 {
 	local mkfs_opts=$1
-	local subvol_mnt=$TEST_DIR/$seq.mnt
 
 	echo "Test $mkfs_opts" >>$seqres.full
 
@@ -69,7 +70,7 @@ run_test()
 	wait $fsstress_pid
 	unset fsstress_pid
 
-	_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
+	_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file $subvol_mnt
 	unset subvol_pid
 	_btrfs_kill_stress_scrub_pid $scrub_pid
 	unset scrub_pid
diff --git a/tests/btrfs/067 b/tests/btrfs/067
index 899b96da..0b473050 100755
--- a/tests/btrfs/067
+++ b/tests/btrfs/067
@@ -14,8 +14,9 @@ _cleanup()
 {
 	cd /
 	rm -rf $tmp.*
-	if [ ! -z "$stop_file" ] && [ ! -z "$subvol_pid" ]; then
-		_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
+	if [ ! -z "$stop_file" ] && [ ! -z "$subvol_pid" ] && \
+		   [ ! -z "$subvol_mnt" ]; then
+		_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file $subvol_mnt
 	fi
 	if [ ! -z "$defrag_pid" ]; then
 		_btrfs_kill_stress_defrag_pid $defrag_pid
@@ -34,12 +35,12 @@ _require_scratch_dev_pool 4
 _btrfs_get_profile_configs
 
 stop_file=$TEST_DIR/$seq.stop.$$
+subvol_mnt=$TEST_DIR/$seq.mnt
 
 run_test()
 {
 	local mkfs_opts=$1
 	local with_compress=$2
-	local subvol_mnt=$TEST_DIR/$seq.mnt
 
 	echo "Test $mkfs_opts with $with_compress" >>$seqres.full
 
@@ -70,7 +71,7 @@ run_test()
 	wait $fsstress_pid
 	unset fsstress_pid
 
-	_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
+	_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file $subvol_mnt
 	unset subvol_pid
 	_btrfs_kill_stress_defrag_pid $defrag_pid
 	unset defrag_pid
diff --git a/tests/btrfs/068 b/tests/btrfs/068
index 48b6cdb0..83e932e8 100755
--- a/tests/btrfs/068
+++ b/tests/btrfs/068
@@ -15,8 +15,9 @@ _cleanup()
 {
 	cd /
 	rm -rf $tmp.*
-	if [ ! -z "$stop_file" ] && [ ! -z "$subvol_pid" ]; then
-		_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
+	if [ ! -z "$stop_file" ] && [ ! -z "$subvol_pid" ] && \
+		   [ ! -z "$subvol_mnt" ]; then
+		_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file $subvol_mnt
 	fi
 	if [ ! -z "$remount_pid" ]; then
 		_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
@@ -35,11 +36,11 @@ _require_scratch_dev_pool 4
 _btrfs_get_profile_configs
 
 stop_file=$TEST_DIR/$seq.stop.$$
+subvol_mnt=$TEST_DIR/$seq.mnt
 
 run_test()
 {
 	local mkfs_opts=$1
-	local subvol_mnt=$TEST_DIR/$seq.mnt
 
 	echo "Test $mkfs_opts with $with_compress" >>$seqres.full
 
@@ -70,7 +71,7 @@ run_test()
 	wait $fsstress_pid
 	unset fsstress_pid
 
-	_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file
+	_btrfs_kill_stress_subvolume_pid $subvol_pid $stop_file $subvol_mnt
 	unset subvol_pid
 	_btrfs_kill_stress_remount_compress_pid $remount_pid $SCRATCH_MNT
 	unset remount_pid
-- 
2.43.0


