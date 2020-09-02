Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA1E25B2B8
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 19:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgIBRKl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 13:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgIBRKk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 13:10:40 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945A1C061245
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Sep 2020 10:10:39 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b14so388348qkn.4
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Sep 2020 10:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/g6cqMHXVmB8wRLu+eAmzUbroOhh00B3gBSFyDzIicE=;
        b=DefJW2zaytREjYgLyzG/oekWAAna2PFpCyMl4BZe0e+X1sUo6kvqwGMz768Hi77ZNH
         dgnOsW84K6siZFmI12pcstm6O5st4CDN4uWBzv2EHOVI3YJhApKLJvS7f+xMvBDN2MCc
         hPAhJHUVhEZMajfpFnSTVxoZx9qGZbxqzNvWI5cv6YzwUIB9D6loG3ieyZ+Da/rv95oq
         K6HBK6JhW/+s4dXFxTAklCsPvAJcnVCT6b3l7mZzrhmmZ1u/rCuNK63q5A78FqeDSKc3
         XQ8Fy5lvkBV8AWV7VkvXsNGm+vSzWuDry4b/RwZn3ljENtOmafkFWc81SQcFXQt3yfto
         kCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/g6cqMHXVmB8wRLu+eAmzUbroOhh00B3gBSFyDzIicE=;
        b=X8cfmMN2xqa29R7XOiTXNchUaq/EV9V5m98WFMNZODSFWM/M81ZM7oRssXfl9wfHgR
         oyVTBF9N15DMjCUIG9uuBCjfpU8I+ZEUS3rZOr3lujxH5km388B15N3Nw+rsu7x+Pt7X
         aOtkfZLCwJrWIEQA79aBSeClj52VEXX+i8aooP9fy+TEkT3pETu74udnN4hmwEiYLItz
         b4eJ2CP+lbNcWDVC9qsF50cEdqE3rvvhr4HUI/2CbDCA8Cbzi5mW8QtBvA0YoUFvCSbH
         h0xl8ZzSsSmHI8LUQbFCKJpVcAlQfhu161oYjY25Jz5UQmT6SkJlyUEKANd4fI+aRRPu
         g9fw==
X-Gm-Message-State: AOAM532ZjNxAmBGw2YOFs2AdUBWYJMZUoqkQ+kXLxiafQap3g25/4vKD
        PIgpY8R92xiD+laDv9j4dos0K5eYjMBwtAz5JIQ=
X-Google-Smtp-Source: ABdhPJxtXW0b5t8DfDSgLolp0STQChAoBvzb8QY2s5PLHeEZBTsV2GDhaSmvObNFg75A7/YysQlufw==
X-Received: by 2002:a37:30d:: with SMTP id 13mr7933558qkd.44.1599066638237;
        Wed, 02 Sep 2020 10:10:38 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l1sm5067151qtp.96.2020.09.02.10.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 10:10:37 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH][v4] fstests: add generic/609 to test O_DIRECT|O_DSYNC
Date:   Wed,  2 Sep 2020 13:10:36 -0400
Message-Id: <20200902171036.273416-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <8e841e0e05934baaf6119363414440b271426a03.1599065695.git.josef@toxicpanda.com>
References: <8e841e0e05934baaf6119363414440b271426a03.1599065695.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We had a problem recently where btrfs would deadlock with
O_DIRECT|O_DSYNC because of an unexpected dependency on ->fsync in
iomap.  This was only caught by chance with aiostress, because weirdly
we don't actually test this particular configuration anywhere in
xfstests.  Fix this by adding a basic test that just does
O_DIRECT|O_DSYNC writes.  With this test the box deadlocks right away
with Btrfs, which would have been helpful in finding this issue before
the patches were merged.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v3->v4:
- Trying to see how many times I can fuck this thing up.
- Simplified the xfs_io command per Darrick's suggestion.
- Added it to the rw group.

 tests/generic/609     | 43 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/609.out |  3 +++
 tests/generic/group   |  1 +
 3 files changed, 47 insertions(+)
 create mode 100755 tests/generic/609
 create mode 100644 tests/generic/609.out

diff --git a/tests/generic/609 b/tests/generic/609
new file mode 100755
index 00000000..6c74ae63
--- /dev/null
+++ b/tests/generic/609
@@ -0,0 +1,43 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Josef Bacik.  All Rights Reserved.
+#
+# FS QA Test 609
+#
+# iomap can call generic_write_sync() if we're O_DSYNC, so write a basic test to
+# exercise O_DSYNC so any unsuspecting file systems will get lockdep warnings if
+# their locking isn't compatible.
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
+	rm -rf $TEST_DIR/file
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# Modify as appropriate.
+_supported_fs generic
+_supported_os Linux
+_require_test
+_require_xfs_io_command "pwrite"
+
+$XFS_IO_PROG -f -d -s -c "pwrite 0 64k" $TEST_DIR/file | _filter_xfs_io
+
+status=0
+exit
diff --git a/tests/generic/609.out b/tests/generic/609.out
new file mode 100644
index 00000000..111c7fe9
--- /dev/null
+++ b/tests/generic/609.out
@@ -0,0 +1,3 @@
+QA output created by 609
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/generic/group b/tests/generic/group
index aa969bcb..ae2567a0 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -611,3 +611,4 @@
 606 auto attr quick dax
 607 auto attr quick dax
 608 auto attr quick dax
+609 auto quick rw
-- 
2.28.0

