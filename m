Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D054925AF5C
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 17:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgIBPhV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 11:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbgIBPhN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 11:37:13 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1E7C061246
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Sep 2020 08:37:12 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id e7so3870427qtj.11
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Sep 2020 08:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bdk4rkVQAGGmlAI+Nb0YCJGt7pD1sH8ZFCaFtWkmtl0=;
        b=A0T8u3lfOgOilEsxl8/PZL3imRS+3vfvEtQbkaqXi0F2JnD1oTjoiS6a+MgFQHyCky
         y43F07gjVzJqU+xJ8LbnmXmlcoufnxDdfXSb9YCvm7P+8kV9NzCpSYjjxx3eOqiPG0Ax
         1CdqOePJ/yeaYz+jMePT1u5J29S0ESB6AGWURNl2vRfERCQnCuBuCcjpBfItIRwaYW50
         LRtAhkDBztGP8gnctEWyZR29+9XKZkd3fEgAMTmZ5elTrUrO9Q/8OVbMGzzQbtUurH0W
         fb+uIVsWEVOa2BBrjB48JgQxT4ytkzm0xrXTslx47g0fsXL0J73EXD8BDD867ZJmAna8
         zGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bdk4rkVQAGGmlAI+Nb0YCJGt7pD1sH8ZFCaFtWkmtl0=;
        b=Dc1oWOhfUZWvxtYkdHtPJtyUrvTsWC1KoztTopPFR5tB3HoB+juiE/uP3QeGLZgvgX
         XriiHnD+au0RX1whlIuhBj8wz1cZD8BE4NcvFB7Z4uoCW2fPDTgxygrHDAnwDpPolqRo
         M30yLX5zbWxkEdUAy2t3UMqHN4jG+U9/Bek+QCpNYiJ0PnEkekKPBqyy/GSoacU+rKgk
         BKIvhMLtYyNl4OrOEuT8F/SSL1PDqqtvZVyRow/OaS2mkHtGg6aTN3iK81D65BXYT/Ns
         WU+q2lSMRn/Trcaq7O9o7HsWOe2DKZoqWwL1/ZUr1JS6CB80U/n/iQwopYJTVFEOqtHL
         oM4g==
X-Gm-Message-State: AOAM533cInOfuJCsKcnMar6dOg4XL82YeHqiSVaJ0sLKQSBp2gxndLtm
        9tc3ln+LldfnKDlCeL5kz0lB2QXPn+W1mKkcV5c=
X-Google-Smtp-Source: ABdhPJy5JZGjDYdLKOtJQBLghQh0G5jQyYTP4dCoC7N1Oa4N132EvmjJ/j13FEQe2zLAxSg2vKSI9g==
X-Received: by 2002:ac8:47d3:: with SMTP id d19mr7389544qtr.263.1599061031698;
        Wed, 02 Sep 2020 08:37:11 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x126sm5046655qkb.101.2020.09.02.08.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 08:37:11 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH][v2] fstests: add generic/609 to test O_DIRECT|O_DSYNC
Date:   Wed,  2 Sep 2020 11:37:09 -0400
Message-Id: <32b2e9a1d92e875a60ff6ff83ba5e1e386118df5.1599060956.git.josef@toxicpanda.com>
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
v1->v2:
- Fix the spelling thing Johannes spotted.
- Use xfs_io like a normal person.

 tests/generic/609   | 44 ++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/group |  1 +
 2 files changed, 45 insertions(+)
 create mode 100755 tests/generic/609

diff --git a/tests/generic/609 b/tests/generic/609
new file mode 100755
index 00000000..6f3ab055
--- /dev/null
+++ b/tests/generic/609
@@ -0,0 +1,44 @@
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
+$XFS_IO_PROG -f -d -c "pwrite -D -V 1 0 4k"  $TEST_DIR/file
+
+echo "Silence is golden"
+status=0
+exit
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
2.26.2

