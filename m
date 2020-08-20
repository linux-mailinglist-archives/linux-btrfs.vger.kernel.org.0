Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B41324C552
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 20:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgHTSaJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Aug 2020 14:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgHTSaI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Aug 2020 14:30:08 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6893CC061386
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 11:30:08 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id s23so1887734qtq.12
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 11:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hJ6AO/Q2DquafDUKfZVdMpafSNrujk86FJYc36tCJiI=;
        b=tILldFchWdrzvDZmYQMxhagunsdc1q7g3HEcKQ/i1PCmLc8N6Q6n4bJ64ZGdiNsQvO
         wYiO0xG98WomDM9fRtEsIyQ5Ysta6/IY5TJXd6tVEBdJbfJ++qcF8vPA5xs4FkOu233k
         JwJoReVpei7QzuTnouPCcq2/am0OhY1yBVpJXgjpjo+CWILT+G0faXZ0prUK+avpY7CZ
         IOlmKfB1ZrlpVoeJTIFuWiC2NEWVOIndnGo82jdbMiRAUa5Pgy/3ZQxfCTlAb4CHj6cs
         VqgrHhaBuxbmBB469m/xPkQGzUAaoJ3ij05b6hMcCQz+u8w3Wukw1sP8OXcHjISO28My
         BJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hJ6AO/Q2DquafDUKfZVdMpafSNrujk86FJYc36tCJiI=;
        b=Q4hValyq5KRBa8cWXHcLB0IyB11+lC6rIF7lvD5jZjpnBZD2rvDhhZvN+Eu3z5z5J2
         4K9aaEtqlt9IK6uDCLAgqbWcuJeeFWU9tN8dBkgFMq7KTZ188L09+Cj2e9CGlVceqsp/
         mIRYLJJdra8zvYcXggiJ2rou/fT9E1LvJa7fAt7hQUWw2W2YFLBgCQwtvKSa2+oYkSJ6
         DDcjDTB8uiNB44GdrZR/Zp24ckwV+AtIMM7N4V1gB5jsLtQCwgPjeJrrv5fH2ZA5w0Ww
         0PYBRPLzTGZ/KaHteYTo18Ojygb8sQUbTrpTz2+4OOyNplMI+9sPnUNuKq6xZKT/KvhV
         JC0w==
X-Gm-Message-State: AOAM530UkJt4FcBWbfues5YTf5yeqqpbNwANEx+93AfKx6hBm1TAG1Zp
        L9R/W3MLC6F58YSnZ9ZzqOmKzXsSrTwIzEfz
X-Google-Smtp-Source: ABdhPJzXcGQaUaTUrYvmmheBjoVXwglngmjwcaFRsfZHyOH7YJarfvvPxixkN2AHzBXzk9797a6qRw==
X-Received: by 2002:aed:3404:: with SMTP id w4mr3988519qtd.181.1597948206446;
        Thu, 20 Aug 2020 11:30:06 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t32sm4085608qtb.3.2020.08.20.11.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 11:30:05 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH][v2] fstests: btrfs/218 add a test for btrfs seed device stats
Date:   Thu, 20 Aug 2020 14:30:04 -0400
Message-Id: <979d061f9957629bc5b89a9d74ae5673d75eb68d.1597948086.git.josef@toxicpanda.com>
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

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v1->v2:
- killed the run_check usage
- added the _scratch_dev_pool_put
- Changed the name since we now have a btrfs/217

 tests/btrfs/218     | 73 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/218.out | 25 ++++++++++++++++
 tests/btrfs/group   |  1 +
 3 files changed, 99 insertions(+)
 create mode 100755 tests/btrfs/218
 create mode 100644 tests/btrfs/218.out

diff --git a/tests/btrfs/218 b/tests/btrfs/218
new file mode 100755
index 00000000..5dce1c09
--- /dev/null
+++ b/tests/btrfs/218
@@ -0,0 +1,73 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Facebook.  All Rights Reserved.
+#
+# FS QA Test 218
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
+_mount $dev_seed $SCRATCH_MNT
+$XFS_IO_PROG -f -d -c "pwrite -S 0xab 0 1M" $SCRATCH_MNT/foo > /dev/null
+$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | \
+	_filter_btrfs_filesystem_show
+_scratch_unmount
+$BTRFS_TUNE_PROG -S 1 $dev_seed
+
+# Mount the seed device and add the rw device
+_mount -o ro $dev_seed $SCRATCH_MNT
+_run_btrfs_util_prog device add -f $dev_sprout $SCRATCH_MNT
+$BTRFS_UTIL_PROG device stats $SCRATCH_MNT | _filter_scratch_pool
+_scratch_unmount
+
+# Now remount, validate the device stats do not fail
+_mount $dev_sprout $SCRATCH_MNT
+$BTRFS_UTIL_PROG device stats $SCRATCH_MNT | _filter_scratch_pool
+
+_scratch_dev_pool_put
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/218.out b/tests/btrfs/218.out
new file mode 100644
index 00000000..7ccf13e9
--- /dev/null
+++ b/tests/btrfs/218.out
@@ -0,0 +1,25 @@
+QA output created by 218
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
index 8dcb2315..3295856d 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -220,3 +220,4 @@
 215 auto quick
 216 auto quick seed
 217 auto quick trim dangerous
+218 auto quick volume
-- 
2.24.1

