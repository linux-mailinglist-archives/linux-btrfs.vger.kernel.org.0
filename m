Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E4B23ACEB
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Aug 2020 21:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgHCT0C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Aug 2020 15:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgHCT0C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Aug 2020 15:26:02 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE35C06174A
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Aug 2020 12:26:01 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id l23so36283944qkk.0
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Aug 2020 12:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TrKa6Patrk2ZaeVVHOdYE4RjP0EMxsYHbGx5hW6HHiE=;
        b=CuCdhzUkbJwYUyTsTyraU1G0bnFu8B+0F1x4kabBi7MhUxDPdSdqFDc13SKfl8G/mY
         ZLS5pjn1bpbsmP4WE9FUvIJbFHdWb2kZbTnBK2MS9NcbTcjjyZHiV7E90wkDaQ8Mag1G
         5mk64yq8QAzv1jYNW7rQLwNI64fm5KxPzGxIdSos//3CKEwUHSkz77N49/FP8nN1Zfg8
         lthUMghkSLKjstvH8yxK9ei6Ktz1r/RA5/Z97BQAMbrd9gnR7XeIu//ggF8yVnyiJoB3
         23x388T3rmG/54p5krDhjf/DrbcVcFIAl/JLWs0vrVcuKHiG6JtmAtWfjhK7fuUNN1vN
         ZgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TrKa6Patrk2ZaeVVHOdYE4RjP0EMxsYHbGx5hW6HHiE=;
        b=lziY/MM+TiYSyInZPWfoiVAfjbJ3CToMQLn0A69ALCCMkxzfIP3XWvTP6kepqkFDi7
         ZY5XUwkhsLn41UcesrTyjUEZZX2Ki55Ml2OktyXuq3VES4QWfs5xhd8kuu698XWSB72l
         3aw2HRc05C6MhniSMCjCH5C9Lr3gy+fHF1rd1JH1gVtIvG6OZ/Z6ovdbVnBT9gO8tYvg
         FzXt5LKiHMMNEkge6/tnVxL/SUspIEGr5LEnDmCbu16lAGTK4dZshnmEUPHQgSRstgZB
         9d2EyDbp/VQRONeNCjz0BxUnW3qorzQheQMTBeNz+QcpMkYUEl1XlW6u9vRBa5k/wXt2
         R5PA==
X-Gm-Message-State: AOAM531UAcdHSjtYxSwRowldiL02S046o7p6TufbSc+rem7LhKc6mR7o
        WHadXQ2OmOto/Gpfe4UzSewEOg==
X-Google-Smtp-Source: ABdhPJyw8vdLh8Eyro2RgVvkgZDrJmGnB95IGBZ6v5qKmAvF3vSkZfy3Qu/8bvv1tyQPsO5JeN+k1Q==
X-Received: by 2002:a37:bc87:: with SMTP id m129mr17583286qkf.47.1596482760828;
        Mon, 03 Aug 2020 12:26:00 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y50sm24745819qtk.29.2020.08.03.12.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 12:26:00 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs/217 add a test for btrfs seed device stats
Date:   Mon,  3 Aug 2020 15:25:59 -0400
Message-Id: <20200803192559.18330-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a regression test for the issue fixed by

  btrfs: init device stats for seed devices

We create a seed device, add a sprout device, and then check the device
stats after a remount to make sure it succeeds.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/217     | 71 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/217.out | 25 ++++++++++++++++
 tests/btrfs/group   |  1 +
 3 files changed, 97 insertions(+)
 create mode 100755 tests/btrfs/217
 create mode 100644 tests/btrfs/217.out

diff --git a/tests/btrfs/217 b/tests/btrfs/217
new file mode 100755
index 00000000..204298bd
--- /dev/null
+++ b/tests/btrfs/217
@@ -0,0 +1,71 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Facebook.  All Rights Reserved.
+#
+# FS QA Test 217
+#
+# Regression test for the problem fixed by the patch
+#
+#  btrfs: init device stats for seed devices
+#
+# Make a seed device, add a sprout to it, and then make sure we can still read
+# the device stats for both devices after we remount with the new sprout device.
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/filter.btrfs
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs btrfs
+_supported_os Linux
+_require_test
+_require_scratch_dev_pool 2
+
+_scratch_dev_pool_get 2
+
+dev_seed=$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
+dev_sprout=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
+
+# Create the seed device
+_mkfs_dev $dev_seed
+run_check _mount $dev_seed $SCRATCH_MNT
+$XFS_IO_PROG -f -d -c "pwrite -S 0xab 0 1M" $SCRATCH_MNT/foo > /dev/null
+$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | \
+	_filter_btrfs_filesystem_show
+_scratch_unmount
+$BTRFS_TUNE_PROG -S 1 $dev_seed
+
+# Mount the seed device and add the rw device
+run_check _mount $dev_seed $SCRATCH_MNT
+_run_btrfs_util_prog device add -f $dev_sprout $SCRATCH_MNT
+$BTRFS_UTIL_PROG device stats $SCRATCH_MNT | _filter_scratch_pool
+_scratch_unmount
+
+# Now remount, validate the device stats do not fail
+run_check _mount $dev_sprout $SCRATCH_MNT
+$BTRFS_UTIL_PROG device stats $SCRATCH_MNT | _filter_scratch_pool
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/217.out b/tests/btrfs/217.out
new file mode 100644
index 00000000..86c6e775
--- /dev/null
+++ b/tests/btrfs/217.out
@@ -0,0 +1,25 @@
+QA output created by 217
+Label: none  uuid: <UUID>
+	Total devices <NUM> FS bytes used <SIZE>
+	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
+
+[SCRATCH_DEV].write_io_errs    0
+[SCRATCH_DEV].read_io_errs     0
+[SCRATCH_DEV].flush_io_errs    0
+[SCRATCH_DEV].corruption_errs  0
+[SCRATCH_DEV].generation_errs  0
+[SCRATCH_DEV].write_io_errs    0
+[SCRATCH_DEV].read_io_errs     0
+[SCRATCH_DEV].flush_io_errs    0
+[SCRATCH_DEV].corruption_errs  0
+[SCRATCH_DEV].generation_errs  0
+[SCRATCH_DEV].write_io_errs    0
+[SCRATCH_DEV].read_io_errs     0
+[SCRATCH_DEV].flush_io_errs    0
+[SCRATCH_DEV].corruption_errs  0
+[SCRATCH_DEV].generation_errs  0
+[SCRATCH_DEV].write_io_errs    0
+[SCRATCH_DEV].read_io_errs     0
+[SCRATCH_DEV].flush_io_errs    0
+[SCRATCH_DEV].corruption_errs  0
+[SCRATCH_DEV].generation_errs  0
diff --git a/tests/btrfs/group b/tests/btrfs/group
index ca90818b..32604e25 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -219,3 +219,4 @@
 214 auto quick send snapshot
 215 auto quick
 216 auto quick seed
+217 auto quick volume
-- 
2.24.1

