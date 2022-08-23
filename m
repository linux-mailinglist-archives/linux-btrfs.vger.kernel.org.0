Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C7D59ED35
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Aug 2022 22:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbiHWUM2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Aug 2022 16:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiHWUMG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Aug 2022 16:12:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAF5A4064;
        Tue, 23 Aug 2022 12:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:Content-Type:Content-ID:Content-Description;
        bh=guTyfOZCaRlHZvAjDuV9ElTojd1SDJ1/Mg03YBv7KpY=; b=DNSsnxvr9QX9CwopzDsvJIDZo6
        W7rOe+5ppq/XJeZ8yMatk1Jh/3/hGXo8fbkuTaYDIvzKNKAuUiQmMg0cO0bwyii9fo9Vu/bMBTAKR
        Qx0DMx0dGjOBAuwYKz3ggpsGZxHb1OV8QXFKqlQFvQKjhguEqoWUVCyug9Hi5LpWExwNUQZ8Leazk
        1Wg/V+aenc7gn6jHIlkSa9XFEh3+FJsR6VOydhnMoegeGzTun8k+FBB3jebxwRIsLQCPeYexUb2bj
        3jBIbfSjuwE/Xs7yLQmBhXOFQHexFQi+yZjvC/RDs96Bd7JJwIsdJt8MvB2IfZRxJHYlZrRiuw62J
        g68+xrSQ==;
Received: from [2001:4bb8:190:6c32:d3e3:62e2:bb3f:326d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQZdb-008bF0-Nm; Tue, 23 Aug 2022 19:32:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH 2/2] btrfs/271: use the common fail_request setup helpers
Date:   Tue, 23 Aug 2022 21:32:30 +0200
Message-Id: <20220823193230.505544-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220823193230.505544-1-hch@lst.de>
References: <20220823193230.505544-1-hch@lst.de>
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

Use the helpers from common/fail_make_request instead of open coding
them.  This switches to using a higher error count than the existing
code, which was the intention from the very beginning (and doesn't
actuallt matter for the short sequences in this test).

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/btrfs/271     | 35 ++++++++---------------------------
 tests/btrfs/271.out |  2 ++
 2 files changed, 10 insertions(+), 27 deletions(-)

diff --git a/tests/btrfs/271 b/tests/btrfs/271
index 681fa965..c7c95b3e 100755
--- a/tests/btrfs/271
+++ b/tests/btrfs/271
@@ -18,20 +18,6 @@ _require_fail_make_request
 _require_scratch_dev_pool 2
 _scratch_dev_pool_get 2
 
-enable_io_failure()
-{
-	local sysfs_bdev=`_sysfs_dev $1`
-
-	echo 1 > $sysfs_bdev/make-it-fail
-}
-
-disable_io_failure()
-{
-	local sysfs_bdev=`_sysfs_dev $1`
-
-	echo 0 > $sysfs_bdev/make-it-fail
-}
-
 _check_minimal_fs_size $(( 1024 * 1024 * 1024 ))
 _scratch_pool_mkfs "-d raid1 -b 1G" >> $seqres.full 2>&1
 
@@ -43,15 +29,12 @@ pagesize=$(get_page_size)
 blocksize=$(_get_block_size $SCRATCH_MNT)
 sectors_per_page=$(($pagesize / $blocksize))
 
-# enable block I/O error injection
-echo 100 > $DEBUGFS_MNT/fail_make_request/probability
-echo 1000 > $DEBUGFS_MNT/fail_make_request/times
-echo 0 > $DEBUGFS_MNT/fail_make_request/verbose
+_allow_fail_make_request
 
 echo "Step 1: writing with one failing mirror:"
-enable_io_failure $SCRATCH_DEV
+_bdev_fail_make_request $SCRATCH_DEV 1
 $XFS_IO_PROG -f -c "pwrite -W -S 0xaa 0 8K" $SCRATCH_MNT/foobar | _filter_xfs_io
-disable_io_failure $SCRATCH_DEV
+_bdev_fail_make_request $SCRATCH_DEV 0
 
 errs=$($BTRFS_UTIL_PROG device stats $SCRATCH_DEV | \
 	$AWK_PROG '/write_io_errs/ { print $2 }')
@@ -63,15 +46,13 @@ echo "Step 2: verify that the data reads back fine:"
 $XFS_IO_PROG -c "pread -v 0 8K" $SCRATCH_MNT/foobar | _filter_xfs_io_offset
 
 echo "Step 3: writing with two failing mirrors (should fail):"
-enable_io_failure $SCRATCH_DEV
-enable_io_failure $dev2
+_bdev_fail_make_request $SCRATCH_DEV 1
+_bdev_fail_make_request $dev2 1
 $XFS_IO_PROG -f -c "pwrite -W -S 0xbb 0 8K" $SCRATCH_MNT/foobar | _filter_xfs_io
-disable_io_failure $dev2
-disable_io_failure $SCRATCH_DEV
+_bdev_fail_make_request $dev2 0
+_bdev_fail_make_request $SCRATCH_DEV 0
 
-# disable block I/O error injection
-echo 0 > $DEBUGFS_MNT/fail_make_request/probability
-echo 0 > $DEBUGFS_MNT/fail_make_request/times
+_disallow_fail_make_request
 
 _scratch_dev_pool_put
 # success, all done
diff --git a/tests/btrfs/271.out b/tests/btrfs/271.out
index 27451c37..d58c92f2 100644
--- a/tests/btrfs/271.out
+++ b/tests/btrfs/271.out
@@ -1,4 +1,5 @@
 QA output created by 271
+Allow global fail_make_request feature
 Step 1: writing with one failing mirror:
 wrote 8192/8192 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -519,3 +520,4 @@ read 8192/8192 bytes
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Step 3: writing with two failing mirrors (should fail):
 fsync: Input/output error
+Disallow global fail_make_request feature
-- 
2.30.2

