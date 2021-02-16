Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D5831D1B5
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Feb 2021 21:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbhBPUop (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Feb 2021 15:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhBPUon (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Feb 2021 15:44:43 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3DDC061756
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 12:44:03 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id w19so10717281qki.13
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Feb 2021 12:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BlhUCFkFFCmq/UyxFYfOqs8IE46QXChUuNbPvSI3D6Q=;
        b=UuwEG9ByE6qSVUT2fSdwxtjhCEdV2n07Y73oADEzI2/UNkiUXorDrLsb9mMpH4Ey+C
         SN1DgmUoxHvVNKLH0kvw4mpvAKTFHs3XsmcepW4Q9ZwZhrlUV/HDC3g5U+UjEwLkGqHU
         re7Qdbbq2NMSRMEZoYrdiIfb4t8cAQF532+bpuEuk8Gp2Rc9ODnvdVwQToD4svb+KKZr
         YHVMl1Iect8uD6M/kCIaNCXCV7OgRaJa45F0aPQlR8xEoD3oe9ig7yO/Os+BK8D0eUih
         qre0/JoDjynkWimvT3Hc+EmvJryQ/NQMBRL48od6AOjeLDq7q5R4nREhcT4ykK3e7wJ2
         hxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BlhUCFkFFCmq/UyxFYfOqs8IE46QXChUuNbPvSI3D6Q=;
        b=VI5VQeOg2vOX1blhsM/8XzDkB+30k1ynkq7dPkx2oLZz6wnrqTpuLckSsdrO9dz6b7
         mbaFPFRnE+/IQJc50k7tf+stICWbFE7DY3xYYkEYZ32voRlO68RFNDUJUB3E78k6aVKC
         XpTqNOZjmCHejLtNqsSWRFXx6UICpFT2jLmHLYs+6pKKbp6WU0KNMIv31eZI6CwrR5qt
         FYEc7utqkyQR6IqxaeuxIsKPWoget9womMcW/2llXJNi5weSZio43Ne/mgvZiPO0tGG+
         pRqqKjZYCPQA4Cnvm4zJNPYX8/C54uzhNAZG3mG94s0fc98eVJNrFb83CU6sGaYGnGXN
         Rn3w==
X-Gm-Message-State: AOAM532a+c0DJ98zuna4K0ahRvWhBYWlSY4XuqfFHJCmULRfbOgX2+WJ
        M4GLV/eYVk+aRqnjM7dZysNzRPm27iSxAm5d
X-Google-Smtp-Source: ABdhPJyu+g4xq/rHkINc52ogc3D9r7M1xtI/D0ebCk3KkSIj+p+0c9O4zTVAa/jObzw+4aASt3CJ6w==
X-Received: by 2002:a37:478a:: with SMTP id u132mr21913077qka.135.1613508241838;
        Tue, 16 Feb 2021 12:44:01 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n5sm14035824qtd.5.2021.02.16.12.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 12:44:01 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: [PATCH] fstests: test a regression with btrfs extent reference collisions
Date:   Tue, 16 Feb 2021 15:44:00 -0500
Message-Id: <5e341bd2e900b2ba6e42109ca20e2ababc6f0873.1613508208.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a regression test for a problem where we would flip read only if
we reflink'ed enough extents to generate key'ed references, and then got
a hash collision with those references.  This is a test for the fix

	btrfs: do not error out if the extent ref hash doesn't match

and is relatively straightforward, simply generate such a file and
watch for fireworks.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/231     | 81 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/231.out | 11 ++++++
 tests/btrfs/group   |  1 +
 3 files changed, 93 insertions(+)
 create mode 100755 tests/btrfs/231
 create mode 100644 tests/btrfs/231.out

diff --git a/tests/btrfs/231 b/tests/btrfs/231
new file mode 100755
index 00000000..b4787f9f
--- /dev/null
+++ b/tests/btrfs/231
@@ -0,0 +1,81 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 Josef Bacik.  All Rights Reserved.
+#
+# FS QA Test 231
+#
+# This is a regression test for a problem fixed by
+#
+#    btrfs: do not error out if the extent ref hash doesn't match
+#
+# Simply generate a file with a lot of extent references, then reflink in a few
+# offsets that will generate hash collisions, sync and validate we can still
+# write to the file system.
+
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
+. ./common/reflink
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+_supported_fs btrfs
+_require_test
+_require_scratch_reflink
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+FILE=$SCRATCH_MNT/file
+
+# Create a 1m extent to reflink
+$XFS_IO_PROG -f -c "pwrite 0 1M" -c "fsync" $FILE | _filter_xfs_io
+
+# Generate a bunch of extent references so we're forced to use key'ed extent
+# references.
+offset=2
+for i in {0..10000}
+do
+	$XFS_IO_PROG -c "reflink ${FILE} 0 ${offset}M 1M" $FILE \
+		> /dev/null 2>&1
+	offset=$(( offset + 2 ))
+done
+
+# Our key is
+#
+# key.objectid = bytenr
+# key.type = BTRFS_EXTENT_DATA_REF_KEY
+# key.offset = hash(tree, inode, offset)
+#
+# The tree id is 5, the inode is 257, and the reflink'ed offset is 0, the below
+# offsets generate a hash collision with that offset.  We only need two to
+# collide, but if it's worth doing it's worth overdoing.
+$XFS_IO_PROG -c "reflink ${FILE} 0 17999258914816 1M" $FILE | _filter_xfs_io
+$XFS_IO_PROG -c "reflink ${FILE} 0 35998517829632 1M" $FILE | _filter_xfs_io
+$XFS_IO_PROG -c "reflink ${FILE} 0 53752752058368 1M" $FILE | _filter_xfs_io
+
+# Sync to make sure this works, it'll error out if we abort the transaction, but
+# write a file just to make sure
+$BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
+$XFS_IO_PROG -f -c "pwrite 0 1M" $SCRATCH_MNT/write | _filter_xfs_io
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/231.out b/tests/btrfs/231.out
new file mode 100644
index 00000000..f52c71ac
--- /dev/null
+++ b/tests/btrfs/231.out
@@ -0,0 +1,11 @@
+QA output created by 231
+wrote 1048576/1048576 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+linked 1048576/1048576 bytes at offset 17999258914816
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+linked 1048576/1048576 bytes at offset 35998517829632
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+linked 1048576/1048576 bytes at offset 53752752058368
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/btrfs/group b/tests/btrfs/group
index a7c65983..65cedf7f 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -233,3 +233,4 @@
 228 auto quick volume
 229 auto quick send clone
 230 auto quick qgroup limit
+231 auto
-- 
2.26.2

