Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF8825B08F
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 18:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgIBQAt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 12:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgIBQAs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 12:00:48 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F84C061245
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Sep 2020 09:00:47 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id u3so116846qkd.9
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Sep 2020 09:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LP/jccXDFzVTMIOyCM8pXlDUczn0AoO1cdGq1ecfNWY=;
        b=m+Au2FksrPKilr13iLcjDh/6pDDadSFOvRUNE5ebcDT/lqs333Yq833R333g4MOwMf
         DaOqlecl+NhNusYgyo/jsUX7NY8f8Cv0U2pf1lcs5zcSMkyHRd+FOQY2jv/rT5p8i6Wx
         OO1vY/HfPKxCat+YUt2HtTavHKpLbJgYZ2DhIr77T+MFT0n1W8VxTkjATji6k1BtU9Cz
         UCBR1fiqstzVgzZjb/qpPFrfI7BYfbu4HXhD2avkY3iji3brCUl2EVGloT73zm4KbIQ0
         PIALtRvru38VLb84i/EDz7Txbik3CSa/up7TO9JKTYg/VhP3MqEYtqA8uxBRAkkPuKtu
         rmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LP/jccXDFzVTMIOyCM8pXlDUczn0AoO1cdGq1ecfNWY=;
        b=J3rstJuoMbnVYm7DBLkQwouLQAU9nN1WkkTU9yN5Cq3z1UknoTlLxncpyHwje330zH
         U9JiQnSMAe4rn36qKm59NDodCCvX+qGdRTN1cdm82LPZIUP8VB2pDNcBVb/gCDjb4JTS
         cUxI3v4id9fzMqfJ9m9S9VZ9m9hjvvSp4kDvTPPqs4ebxq+wJ8aC+MXYiTwCcEfuH22m
         YWDXdE0FvsxuSmFZWRb46CJrm2ib8D3s0Ds2+Q2c2tbFuYt0lYD+2Wp23JqjE2Tx4EC+
         bXrpwaEsTwIDCMPXP158gnUlD662tL7cg2EN+a7smmjQJzeuleXE2bS1NHpvXaBhS/7P
         u8RA==
X-Gm-Message-State: AOAM531ZScsBvzCJMZ4WUm8f6odkaTy5hmVb+a+obdD3u6qJXj9EnFhg
        J3zSkkgNg+sCIyVaJ+8UpFyl51QiaRuBgytS/Uk=
X-Google-Smtp-Source: ABdhPJwc/Bk/yHitrxXg1+4ZdoMry31ZlSzSGMlNSzqt6gZc41iZbMFulcL9z/vnCds5FqyUaqmn4w==
X-Received: by 2002:a37:a84a:: with SMTP id r71mr7299748qke.481.1599062446342;
        Wed, 02 Sep 2020 09:00:46 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h17sm23016qke.68.2020.09.02.09.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 09:00:45 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH][v3 fstests: add generic/609 to test O_DIRECT|O_DSYNC
Date:   Wed,  2 Sep 2020 12:00:44 -0400
Message-Id: <20200902160044.266690-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <f5ba8625d6277035b69e466f6ea87f19620f7fcb.1599058822.git.josef@toxicpanda.com>
References: <f5ba8625d6277035b69e466f6ea87f19620f7fcb.1599058822.git.josef@toxicpanda.com>
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
v2->v3:
- This time with 609.out added, verified it passed with xfs.

 tests/generic/609     | 43 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/609.out |  3 +++
 tests/generic/group   |  1 +
 3 files changed, 47 insertions(+)
 create mode 100755 tests/generic/609
 create mode 100644 tests/generic/609.out

diff --git a/tests/generic/609 b/tests/generic/609
new file mode 100755
index 00000000..3d1c97b2
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
+_require_xfs_io_command "pwrite" "-DV"
+
+$XFS_IO_PROG -f -d -c "pwrite -D -V 1 0 4k"  $TEST_DIR/file | _filter_xfs_io
+
+status=0
+exit
diff --git a/tests/generic/609.out b/tests/generic/609.out
new file mode 100644
index 00000000..db3242cb
--- /dev/null
+++ b/tests/generic/609.out
@@ -0,0 +1,3 @@
+QA output created by 609
+wrote 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/generic/group b/tests/generic/group
index aa969bcb..ae2567a0 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -611,3 +611,4 @@
 606 auto attr quick dax
 607 auto attr quick dax
 608 auto attr quick dax
+609 auto quick
-- 
2.28.0

