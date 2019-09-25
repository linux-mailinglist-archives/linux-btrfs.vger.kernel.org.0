Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3BDBDDAC
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2019 14:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405314AbfIYMEV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Sep 2019 08:04:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:55344 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388199AbfIYMEV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Sep 2019 08:04:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D722DAD3E
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2019 12:04:18 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] fstests: btrfs/011: Fill the fs to ensure we have enough data for dev-replace
Date:   Wed, 25 Sep 2019 20:04:14 +0800
Message-Id: <20190925120414.115458-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When btrfs/011 is executed on a fast enough system (fully memory backed
VM, with test device has unsafe cache mode), the test can fail like
this:

  btrfs/011 43s ... [failed, exit status 1]- output mismatch (see /home/adam/xfstests-dev/results//btrfs/011.out.bad)
    --- tests/btrfs/011.out     2019-07-22 14:13:44.643333326 +0800
    +++ /home/adam/xfstests-dev/results//btrfs/011.out.bad      2019-09-18 14:49:28.308798022 +0800
    @@ -1,3 +1,4 @@
     QA output created by 011
     *** test btrfs replace
    -*** done
    +failed: '/usr/bin/btrfs replace cancel /mnt/scratch'
    +(see /home/adam/xfstests-dev/results//btrfs/011.full for details)
    ...

[CAUSE]
Looking into the full output, it shows:
  ...
  Replace from /dev/mapper/test-scratch1 to /dev/mapper/test-scratch2

  # /usr/bin/btrfs replace start -f /dev/mapper/test-scratch1 /dev/mapper/test-scratch2 /mnt/scratch
  # /usr/bin/btrfs replace cancel /mnt/scratch
  INFO: ioctl(DEV_REPLACE_CANCEL)"/mnt/scratch": not started
  failed: '/usr/bin/btrfs replace cancel /mnt/scratch'

So this means the replace is already finished before we cancel it.
For fast system, it's very common.

[FIX]
In fill_scratch() after all the original file creations, do a timer
based direct IO write.
The extra write will take 2 * $wait_time, utilizing direct IO with 64K
block size, the write performance should be very comparable (although a
little faster) to replace performance.

So later cancel should be able to really cancel the dev-replace without
it finished too early.

Also, do extra check about the above write. If we hit ENOSPC we just
skip the test as the system is really too fast and the fs is not large
enough.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
changelog
v2:
- Remove one confusing comment
- Change the _notrun message to focus on too small fs
---
 tests/btrfs/011 | 42 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/tests/btrfs/011 b/tests/btrfs/011
index 89bb4d11..de424f87 100755
--- a/tests/btrfs/011
+++ b/tests/btrfs/011
@@ -34,7 +34,7 @@ _cleanup()
 		kill -TERM $noise_pid
 	fi
 	wait
-	rm -f $tmp.tmp
+	rm -f $tmp.*
 	# we need this umount and couldn't rely on _require_scratch to umount
 	# it from next test, because we would replace SCRATCH_DEV, which is
 	# needed by _require_scratch, and make it umounted.
@@ -54,13 +54,17 @@ _require_scratch_dev_pool_equal_size
 _require_command "$WIPEFS_PROG" wipefs
 
 rm -f $seqres.full
-rm -f $tmp.tmp
+rm -f $tmp.*
 
 echo "*** test btrfs replace"
 
+# In seconds
+wait_time=1
+
 fill_scratch()
 {
 	local fssize=$1
+	local filler_pid
 
 	# Fill inline extents.
 	for i in `seq 1 500`; do
@@ -75,6 +79,30 @@ fill_scratch()
 	for i in `seq $fssize`; do
 		cp $SCRATCH_MNT/t0 $SCRATCH_MNT/t$i || _fail "cp failed"
 	done > /dev/null 2>> $seqres.full
+
+	# Ensure we have enough data so that dev-replace would take at least
+	# 2 * $wait_time, allowing we cancel the running replace.
+	# Some extra points:
+	# - Use XFS_IO_PROG instead of dd
+	#   fstests wraps dd, making it pretty hard to kill the real dd pid
+	# - Use 64K block size with Direct IO
+	#   64K is the same stripe size used in replace/scrub. Using Direct IO
+	#   ensure the IO speed is near device limit and comparable to replace
+	#   speed.
+	$XFS_IO_PROG -f -d -c "pwrite -b 64k 0 1E" "$SCRATCH_MNT/t_filler" &>\
+		$tmp.filler_result &
+	filler_pid=$!
+	sleep $((2 * $wait_time))
+	kill -KILL $filler_pid &> /dev/null
+	wait $filler_pid &> /dev/null
+
+	# If the system is too fast and the fs is too small, then skip the test
+	if grep -q "No space left" $tmp.filler_result; then
+		ls -alh $SCRATCH_MNT >> $seqres.full
+		cat $tmp.filler_result >> $seqres.full
+		_notrun "fs too small for this test"
+	fi
+	cat $tmp.filler_result
 	sync; sync
 }
 
@@ -147,7 +175,7 @@ btrfs_replace_test()
 	if [ "${with_cancel}Q" = "cancelQ" ]; then
 		# background the replace operation (no '-B' option given)
 		_run_btrfs_util_prog replace start -f $replace_options $source_dev $target_dev $SCRATCH_MNT
-		sleep 1
+		sleep $wait_time
 		_run_btrfs_util_prog replace cancel $SCRATCH_MNT
 
 		# 'replace status' waits for the replace operation to finish
@@ -157,10 +185,10 @@ btrfs_replace_test()
 		grep -q canceled $tmp.tmp || _fail "btrfs replace status (canceled) failed"
 	else
 		if [ "${quick}Q" = "thoroughQ" ]; then
-			# On current hardware, the thorough test runs
-			# more than a second. This is a chance to force
-			# a sync in the middle of the replace operation.
-			(sleep 1; sync) > /dev/null 2>&1 &
+			# The thorough test runs around 2 * $wait_time seconds.
+			# This is a chance to force a sync in the middle of the
+			# replace operation.
+			(sleep $wait_time; sync) > /dev/null 2>&1 &
 		fi
 		_run_btrfs_util_prog replace start -Bf $replace_options $source_dev $target_dev $SCRATCH_MNT
 
-- 
2.22.0

