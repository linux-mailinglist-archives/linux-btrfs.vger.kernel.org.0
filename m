Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A88901A8497
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Apr 2020 18:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391426AbgDNQXr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Apr 2020 12:23:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391399AbgDNQWr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Apr 2020 12:22:47 -0400
Received: from debian7.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C8252076D;
        Tue, 14 Apr 2020 16:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586881366;
        bh=tqs+N9LDuXLbnrMC4ex8/6dS4xfR7Du6R8aoezXz1Ko=;
        h=From:To:Cc:Subject:Date:From;
        b=ItMCmB5huUPfEpgMprmmIaF7KjSwo5WHGNFjB2KVRnyMmuL8HLv7VFAKlIjTwXSaX
         uaPmdQCVxe3ZUyIIC3BHMCTWQ4VU2ulCiKuxLGshBsGkSlk1eDxLxmJ8g/FImMiyYW
         KBdnBcpL6Z1o+ZqonG7mpCiPKLJJfeqFJgYKV3IE=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 3/3] fstests: make all btrfs tests that exercise balance use _run_btrfs_balance_start()
Date:   Tue, 14 Apr 2020 17:22:42 +0100
Message-Id: <20200414162242.24457-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

In btrfs-progs v4.10 we had a behaviour change where starting a balance
operation without any filters results in a delay of 10 seconds and a
warning is printed to stdout that warns that a full balance is about to
be made and that it can be a slow operation. The new flag '--full-balance'
was added in that release to avoid the 10 seconds delay and the warning
message.

Our existing helper _run_btrfs_balance_start() uses that new balance flag
if we are running a btrfs-progs version that has it, to avoid that 10
seconds wait.

Make all existing btrfs tests that trigger balance operations use the
_run_btrfs_balance_start() helper, so that we avoid wasting time and
speed up some of the tests. In particular test btrfs/014 is now about 10x
faster and tests btrfs/060 to btrfs/064 3 to 5 times faster (depending
on the fsstress random load).

Besides speeding up many tests that do balance operations it also fixes
functional problems:

1) Since btrfs-progs v4.10 the test case btrfs/014 got broken, because
   its purpose is to run balance and snapshot creation in parallel,
   and that wasn't happening anymore because all snapshots were being
   created during the 10 seconds delay of the first balance operation,
   so balance and snapshot creation was being serialized instead of
   running in parallel.

   Fixing this test to avoid the 10 seconds delay immediately exposes
   a regression that went into kernel 5.7-rc1 which is fixed by a patch
   that has the following subject:

      "btrfs: fix setting last_trans for reloc roots"

2) Test cases btrfs/060 to btrfs/064 now spend much more time running
   fsstress, balance and other operations in parallel, there's no
   longer intervals of 10 seconds where balance is not running
   concurrently with those other operations, making the tests a lot
   more useful again.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 common/btrfs    | 2 +-
 tests/btrfs/003 | 4 ++--
 tests/btrfs/013 | 3 +--
 tests/btrfs/014 | 2 +-
 tests/btrfs/021 | 2 +-
 tests/btrfs/102 | 2 +-
 tests/btrfs/123 | 2 +-
 tests/btrfs/125 | 2 +-
 tests/btrfs/154 | 4 ++--
 tests/btrfs/156 | 4 ++--
 tests/btrfs/181 | 2 +-
 tests/btrfs/182 | 2 +-
 tests/btrfs/187 | 2 +-
 tests/btrfs/190 | 3 ++-
 tests/btrfs/195 | 2 +-
 15 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index b43932df..6d452d4d 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -245,7 +245,7 @@ _btrfs_stress_balance()
 {
 	local options=$@
 	while true; do
-		$BTRFS_UTIL_PROG balance start $options
+		_run_btrfs_balance_start $options >> $seqres.full
 	done
 }
 
diff --git a/tests/btrfs/003 b/tests/btrfs/003
index c72c3429..9ce9d946 100755
--- a/tests/btrfs/003
+++ b/tests/btrfs/003
@@ -113,7 +113,7 @@ _test_add()
 			_fail "wipefs failed"
 		$BTRFS_UTIL_PROG device add ${devs[$i]} $SCRATCH_MNT >> $seqres.full 2>&1 || _fail "device add failed"
 	done
-	$BTRFS_UTIL_PROG filesystem balance $SCRATCH_MNT >> $seqres.full 2>&1 || _fail "balance failed"
+	_run_btrfs_balance_start $SCRATCH_MNT >> $seqres.full
 	_scratch_unmount
 }
 
@@ -159,7 +159,7 @@ _test_replace()
 	# in some system balance fails if there is no delay (a bug)
 	# putting sleep 10 to work around as of now
 	# sleep 10
-	$BTRFS_UTIL_PROG filesystem balance $SCRATCH_MNT >> $seqres.full 2>&1 || _fail "dev balance failed"
+	_run_btrfs_balance_start $SCRATCH_MNT >> $seqres.full
 
 	# cleaup. add the removed disk
 	_scratch_unmount
diff --git a/tests/btrfs/013 b/tests/btrfs/013
index eadaf199..a795119d 100755
--- a/tests/btrfs/013
+++ b/tests/btrfs/013
@@ -56,8 +56,7 @@ _check_csum_error()
 }
 $XFS_IO_PROG -f -c "falloc 0 1M" -c "pwrite 16k 8k" -c "fsync" \
 	$SCRATCH_MNT/foo > $seqres.full 2>&1
-$BTRFS_UTIL_PROG filesystem balance $SCRATCH_MNT >> $seqres.full 2>&1 || \
-	_fail "balance failed"
+_run_btrfs_balance_start $SCRATCH_MNT >> $seqres.full
 _scratch_unmount
 _scratch_mount
 $XFS_IO_PROG -c "pread 0 1M" $SCRATCH_MNT/foo >> $seqres.full 2>&1 || \
diff --git a/tests/btrfs/014 b/tests/btrfs/014
index a8da6c4d..9f637fe8 100755
--- a/tests/btrfs/014
+++ b/tests/btrfs/014
@@ -27,7 +27,7 @@ _balance()
 {
 	for i in $(seq 20)
 	do
-		$BTRFS_UTIL_PROG balance start $SCRATCH_MNT >/dev/null
+		_run_btrfs_balance_start $SCRATCH_MNT >> $seqres.full
 	done
 }
 
diff --git a/tests/btrfs/021 b/tests/btrfs/021
index d5ba4b66..341b6a2b 100755
--- a/tests/btrfs/021
+++ b/tests/btrfs/021
@@ -31,7 +31,7 @@ _cleanup()
 # real QA test starts here
 run_test()
 {
-	$BTRFS_UTIL_PROG balance start $SCRATCH_MNT >> $seqres.full &
+	_run_btrfs_balance_start $SCRATCH_MNT >> $seqres.full &
 
 	sleep 0.5
 
diff --git a/tests/btrfs/102 b/tests/btrfs/102
index ed50453d..de4d1051 100755
--- a/tests/btrfs/102
+++ b/tests/btrfs/102
@@ -47,7 +47,7 @@ _require_fs_space $SCRATCH_MNT $((2 * 1024 * 1024))
 # mkfs created. We could also wait for the background kthread to automatically
 # delete the unused block group, but we do not have a way to make it run and
 # wait for it to complete, so just do a balance instead of some unreliable sleep
-_run_btrfs_util_prog balance start -dusage=0 $SCRATCH_MNT
+_run_btrfs_balance_start -dusage=0 $SCRATCH_MNT >> $seqres.full
 
 # Now unmount the filesystem, mount it again (either with or with space caches
 # enabled, it does not matter to trigger the problem) and attempt to create a
diff --git a/tests/btrfs/123 b/tests/btrfs/123
index 03b00437..65177159 100755
--- a/tests/btrfs/123
+++ b/tests/btrfs/123
@@ -59,7 +59,7 @@ _run_btrfs_util_prog quota enable $SCRATCH_MNT
 _run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
 
 # now balance data block groups to corrupt qgroup
-_run_btrfs_util_prog balance start -d $SCRATCH_MNT
+_run_btrfs_balance_start -d $SCRATCH_MNT >> $seqres.full
 
 _scratch_unmount
 # qgroup will be check at _check_scratch_fs() by fstest
diff --git a/tests/btrfs/125 b/tests/btrfs/125
index e1edccdd..63327d05 100755
--- a/tests/btrfs/125
+++ b/tests/btrfs/125
@@ -123,7 +123,7 @@ _run_btrfs_util_prog device scan
 _scratch_mount >> $seqres.full 2>&1
 
 echo >> $seqres.full
-_run_btrfs_util_prog balance start ${SCRATCH_MNT}
+_run_btrfs_balance_start $SCRATCH_MNT >> $seqres.full
 
 _run_btrfs_util_prog filesystem show
 _run_btrfs_util_prog filesystem df ${SCRATCH_MNT}
diff --git a/tests/btrfs/154 b/tests/btrfs/154
index cbf65a42..321bbee9 100755
--- a/tests/btrfs/154
+++ b/tests/btrfs/154
@@ -129,8 +129,8 @@ balance_convert()
 	echo
 	echo "run balance"
 
-	_run_btrfs_util_prog balance start --full-balance -dconvert=raid1 \
-				-mconvert=raid1 ${SCRATCH_MNT}
+	_run_btrfs_balance_start -dconvert=raid1 \
+				 -mconvert=raid1 $SCRATCH_MNT >> $seqres.full
 }
 
 verify()
diff --git a/tests/btrfs/156 b/tests/btrfs/156
index 9a97308b..cd488e54 100755
--- a/tests/btrfs/156
+++ b/tests/btrfs/156
@@ -70,14 +70,14 @@ sync
 # Now we have take at least 50% of the filesystem, relocate all chunks twice
 # so all chunks will start after 1G in logical space.
 # (Btrfs chunk allocation will not rewind to reuse lower space)
-_run_btrfs_util_prog balance start --full-balance "$SCRATCH_MNT"
+_run_btrfs_balance_start $SCRATCH_MNT >> $seqres.full
 
 # To avoid possible false ENOSPC alert on v4.15-rc1, seems to be a
 # reserved space related bug (maybe related to outstanding space rework?),
 # but that's another story.
 sync
 
-_run_btrfs_util_prog balance start --full-balance "$SCRATCH_MNT"
+_run_btrfs_balance_start $SCRATCH_MNT >> $seqres.full
 
 # Now remove half of the files to make some holes for later trim.
 # While still keep the chunk space fragmented, so no chunk will be freed
diff --git a/tests/btrfs/181 b/tests/btrfs/181
index 1302eca9..f029cc35 100755
--- a/tests/btrfs/181
+++ b/tests/btrfs/181
@@ -68,7 +68,7 @@ sync
 
 before_gen=$(get_super_gen)
 
-$BTRFS_UTIL_PROG balance start -m "$SCRATCH_MNT" > /dev/null
+_run_btrfs_balance_start -m $SCRATCH_MNT >> $seqres.full
 
 after_gen=$(get_super_gen)
 
diff --git a/tests/btrfs/182 b/tests/btrfs/182
index 19b4ad81..650ba9f1 100755
--- a/tests/btrfs/182
+++ b/tests/btrfs/182
@@ -53,7 +53,7 @@ for ((i = 0; i < $nr_files; i++)) do
 	_pwrite_byte 0xcd 0 1K "$SCRATCH_MNT/subvol/file_$i" > /dev/null
 done
 
-$BTRFS_UTIL_PROG balance start -m "$SCRATCH_MNT" > /dev/null
+_run_btrfs_balance_start -m $SCRATCH_MNT >> $seqres.full
 
 # success, all done
 echo "Silence is golden"
diff --git a/tests/btrfs/187 b/tests/btrfs/187
index a604690a..428b328a 100755
--- a/tests/btrfs/187
+++ b/tests/btrfs/187
@@ -84,7 +84,7 @@ balance_loop()
 		# easier to hit problems (crashes and errors) in send.
 		# Ignore errors from balance. We just want to test for crashes
 		# and deadlocks.
-		$BTRFS_UTIL_PROG balance start -f -m $SCRATCH_MNT &> /dev/null
+		_run_btrfs_balance_start -f -m $SCRATCH_MNT &> /dev/null
 		sleep $((RANDOM % 3))
 	done
 }
diff --git a/tests/btrfs/190 b/tests/btrfs/190
index 7d3d3007..f9cf159c 100755
--- a/tests/btrfs/190
+++ b/tests/btrfs/190
@@ -59,7 +59,8 @@ sync
 
 # Balance metadata so we will have at least one transaction committed with
 # valid reloc tree, and hopefully another commit with orphan reloc tree.
-$BTRFS_UTIL_PROG balance start -f -m $SCRATCH_MNT >> $seqres.full
+_run_btrfs_balance_start -f -m $SCRATCH_MNT >> $seqres.full
+
 _log_writes_unmount
 _log_writes_remove
 
diff --git a/tests/btrfs/195 b/tests/btrfs/195
index e40edb95..944e048b 100755
--- a/tests/btrfs/195
+++ b/tests/btrfs/195
@@ -64,7 +64,7 @@ run_testcase() {
 	# Create random filesystem with 20k write ops
 	$FSSTRESS_PROG -d $SCRATCH_MNT -w -n 10000 $FSSTRESS_AVOID >>$seqres.full 2>&1
 
-	$BTRFS_UTIL_PROG balance start -f -dconvert=$dst_type $SCRATCH_MNT >> $seqres.full 2>&1
+	_run_btrfs_balance_start -f -dconvert=$dst_type $SCRATCH_MNT >> $seqres.full
 	[ $? -eq 0 ] || echo "$1: Failed convert"
 
 	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >>$seqres.full 2>&1
-- 
2.11.0

