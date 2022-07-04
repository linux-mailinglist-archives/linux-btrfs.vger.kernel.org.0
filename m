Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE12756504D
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 11:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbiGDJDy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 05:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbiGDJDx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 05:03:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39B4F30;
        Mon,  4 Jul 2022 02:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=fNkxgl93txPYQsmuo+Q+1UC1sCImm3R8fkCSNe2pKRs=; b=BdxaD/LWkGO36gl/QuHN57fyA5
        QJqaSDGLNe/U9vALBBTQK9/i9UjZYTm6xWtrMmmxJXqH4zvF+AWSRXHghMVaOPIjbOtCGoLI/2/cc
        dj7I6kp42iXb15Xxji9Vgh2vfJjITXceJqvSQ++SjVJKQ4XdHf3WmxZJ8WDVc30Ec41sGGchutjz5
        b+VhYe73PN0RqjuJKieV9h65nZVVzVwa+CcvzVSwD1tcU1egjuXi4a1y4Y7W9cu4EgUXCE3SIKZeT
        t0nb8f/SwKEMJNdmlyRO8Bk+tkhi3SILDTAlmeUwC9pus2KdkTBYEfSlAbjVRZpGkqhZyIgVXx/ox
        OuZDGapg==;
Received: from 089144208244.atnat0017.highway.a1.net ([89.144.208.244] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8Hzj-006Gdd-MS; Mon, 04 Jul 2022 09:03:52 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] common: provide generic block error injection helper
Date:   Mon,  4 Jul 2022 11:03:45 +0200
Message-Id: <20220704090346.108134-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Various tests have more or less copy and pasted code to enable and
disable block layer "fail make request" error injection.  Move that
to a set of common helpers and use those in the drivers.

btrfs/150 differened from the other two in a few ways, like selecting
a not quite as big number to fail all requests in the small critical
section and clearing a bunch of never set attributes in the failure
injection configuration, but none of those matter for the test
execution.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 common/inject     | 33 +++++++++++++++++++++++++++++++++
 tests/btrfs/088   | 24 +++++-------------------
 tests/btrfs/150   | 27 +++++----------------------
 tests/generic/019 | 44 +++++++++-----------------------------------
 4 files changed, 52 insertions(+), 76 deletions(-)

diff --git a/common/inject b/common/inject
index 6b590804..137ff5fd 100644
--- a/common/inject
+++ b/common/inject
@@ -111,3 +111,36 @@ _scratch_inject_error()
 		_fail "Cannot inject error ${type} value ${value}."
 	fi
 }
+
+# enable block error injection globally
+_enable_fail_make_request()
+{
+	echo 100 > $DEBUGFS_MNT/fail_make_request/probability
+	echo 9999999 > $DEBUGFS_MNT/fail_make_request/times
+	echo 0 >  /sys/kernel/debug/fail_make_request/verbose
+}
+
+# disable block error injection globally
+_disable_fail_make_request()
+{
+	echo 0 > $DEBUGFS_MNT/fail_make_request/probability
+	echo 0 > $DEBUGFS_MNT/fail_make_request/times
+}
+
+# make a device always fail
+_start_fail_dev()
+{
+	local sysfs_bdev=`_sysfs_dev $1`
+
+	echo " echo 1 > $sysfs_bdev/make-it-fail" >> $seqres.full
+	echo 1 > $sysfs_bdev/make-it-fail
+}
+
+# stop a device from failing
+_stop_fail_dev()
+{
+	local sysfs_bdev=`_sysfs_dev $1`
+
+	echo " echo 0 > $sysfs_bdev/make-it-fail" >> $seqres.full
+	echo 0 > $sysfs_bdev/make-it-fail
+}
diff --git a/tests/btrfs/088 b/tests/btrfs/088
index d9c5528b..bd02401a 100755
--- a/tests/btrfs/088
+++ b/tests/btrfs/088
@@ -18,29 +18,13 @@ _begin_fstest auto quick metadata
 
 # Import common functions.
 . ./common/filter
+. ./common/inject
 
 # real QA test starts here
 _supported_fs btrfs
 _require_scratch
 _require_fail_make_request
 
-SYSFS_BDEV=`_sysfs_dev $SCRATCH_DEV`
-
-enable_io_failure()
-{
-	echo 100 > $DEBUGFS_MNT/fail_make_request/probability
-	echo 1000 > $DEBUGFS_MNT/fail_make_request/times
-	echo 0 > $DEBUGFS_MNT/fail_make_request/verbose
-	echo 1 > $SYSFS_BDEV/make-it-fail
-}
-
-disable_io_failure()
-{
-	echo 0 > $SYSFS_BDEV/make-it-fail
-	echo 0 > $DEBUGFS_MNT/fail_make_request/probability
-	echo 0 > $DEBUGFS_MNT/fail_make_request/times
-}
-
 # We will abort a btrfs transaction later, which always produces a warning in
 # dmesg. We do not want the test to fail because of this.
 _disable_dmesg_check
@@ -72,12 +56,14 @@ $XFS_IO_PROG -c "pwrite -S 0xbb 512K 1M" $SCRATCH_MNT/foo | _filter_xfs_io
 # perform a discard operation against the pinned exents. This made the fs
 # unmountable because the btree roots that the superblock points at were written
 # in place (by the discard operations).
-enable_io_failure
+_enable_fail_make_request
+_start_fail_dev $SCRATCH_DEV
 
 # This sync will trigger a commit of the current transaction, which will be
 # aborted because IO will fail for metadata extents (btree nodes/leafs).
 sync
-disable_io_failure
+_stop_fail_dev $SCRATCH_DEV
+_disable_fail_make_request
 
 touch $SCRATCH_MNT/abc >>$seqres.full 2>&1 && \
 	echo "Transaction was not aborted, filesystem is not in readonly mode"
diff --git a/tests/btrfs/150 b/tests/btrfs/150
index c5e9c709..cc80cb41 100755
--- a/tests/btrfs/150
+++ b/tests/btrfs/150
@@ -15,6 +15,7 @@ _begin_fstest auto quick dangerous read_repair
 
 # Import common functions.
 . ./common/filter
+. ./common/inject
 
 # real QA test starts here
 
@@ -25,24 +26,6 @@ _require_fail_make_request
 _require_scratch_dev_pool 2
 _scratch_dev_pool_get 2
 
-SYSFS_BDEV=`_sysfs_dev $SCRATCH_DEV`
-enable_io_failure()
-{
-	echo 100 > $DEBUGFS_MNT/fail_make_request/probability
-	echo 1000 > $DEBUGFS_MNT/fail_make_request/times
-	echo 0 > $DEBUGFS_MNT/fail_make_request/verbose
-	echo 1 > $DEBUGFS_MNT/fail_make_request/task-filter
-	echo 1 > $SYSFS_BDEV/make-it-fail
-}
-
-disable_io_failure()
-{
-	echo 0 > $DEBUGFS_MNT/fail_make_request/probability
-	echo 0 > $DEBUGFS_MNT/fail_make_request/times
-	echo 0 > $DEBUGFS_MNT/fail_make_request/task-filter
-	echo 0 > $SYSFS_BDEV/make-it-fail
-}
-
 _check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
 _scratch_pool_mkfs "-d raid1 -b 1G" >> $seqres.full 2>&1
 
@@ -59,15 +42,15 @@ while [[ -z $result ]]; do
 	# invalidate the page cache
 	$XFS_IO_PROG -f -c "fadvise -d 0 8K" $SCRATCH_MNT/foobar
 
-	enable_io_failure
-
+	_enable_fail_make_request
+	_start_fail_dev $SCRATCH_DEV
 	result=$(bash -c "
 	if [ \$((\$\$ % 2)) == 1 ]; then
 		echo 1 > /proc/\$\$/make-it-fail
 		exec $XFS_IO_PROG -c \"pread 0 8K\" \$SCRATCH_MNT/foobar
 	fi")
-
-	disable_io_failure
+	_stop_fail_dev $SCRATCH_DEV
+	_disable_fail_make_request
 done
 
 _scratch_dev_pool_put
diff --git a/tests/generic/019 b/tests/generic/019
index 45c91624..3cfcb7c5 100755
--- a/tests/generic/019
+++ b/tests/generic/019
@@ -14,47 +14,18 @@ fio_config=$tmp.fio
 
 # Import common functions.
 . ./common/filter
+. ./common/inject
 _supported_fs generic
 _require_scratch
 _require_block_device $SCRATCH_DEV
 _require_fail_make_request
 
-SYSFS_BDEV=`_sysfs_dev $SCRATCH_DEV`
-
-allow_fail_make_request()
-{
-    echo "Allow global fail_make_request feature"
-    echo 100 > $DEBUGFS_MNT/fail_make_request/probability
-    echo 9999999 > $DEBUGFS_MNT/fail_make_request/times
-    echo 0 >  /sys/kernel/debug/fail_make_request/verbose
-}
-
-disallow_fail_make_request()
-{
-    echo "Disallow global fail_make_request feature"
-    echo 0 > $DEBUGFS_MNT/fail_make_request/probability
-    echo 0 > $DEBUGFS_MNT/fail_make_request/times
-}
-
-start_fail_scratch_dev()
-{
-    echo "Force SCRATCH_DEV device failure"
-    echo " echo 1 > $SYSFS_BDEV/make-it-fail" >> $seqres.full
-    echo 1 > $SYSFS_BDEV/make-it-fail
-}
-
-stop_fail_scratch_dev()
-{
-    echo "Make SCRATCH_DEV device operable again"
-    echo " echo 0 > $SYSFS_BDEV/make-it-fail" >> $seqres.full
-    echo 0 > $SYSFS_BDEV/make-it-fail
-}
-
 # Override the default cleanup function.
 _cleanup()
 {
 	kill $fs_pid $fio_pid &> /dev/null
-	disallow_fail_make_request
+	echo "Disallow global fail_make_request feature"
+	_disable_fail_make_request
 	cd /
 	rm -r -f $tmp.*
 }
@@ -129,7 +100,8 @@ _workout()
 
 	# Let's it work for awhile, and force device failure
 	sleep $RUN_TIME
-	start_fail_scratch_dev
+	echo "Force SCRATCH_DEV device failure"
+	_start_fail_dev $SCRATCH_DEV
 	# After device turns in to failed state filesystem may yet not know about
 	# that so buffered write(2) may succeed, but any integrity operations
 	# such as (sync, fsync, fdatasync, direct-io) should fail.
@@ -147,7 +119,8 @@ _workout()
 	run_check _scratch_unmount
 	# Once filesystem was umounted no one is able to write to block device
 	# It is now safe to bring device back to normal state
-	stop_fail_scratch_dev
+	echo "Make SCRATCH_DEV device operable again"
+	_stop_fail_dev $SCRATCH_DEV
 
 	# In order to check that filesystem is able to recover journal on mount(2)
 	# perform mount/umount, after that all errors should be fixed
@@ -159,7 +132,8 @@ _workout()
 
 _scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
 _scratch_mount
-allow_fail_make_request
+echo "Allow global fail_make_request feature"
+_enable_fail_make_request
 _workout
 status=$?
 exit
-- 
2.30.2

