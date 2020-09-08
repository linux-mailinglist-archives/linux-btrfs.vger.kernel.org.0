Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29EA6261D93
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Sep 2020 21:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732366AbgIHTjI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Sep 2020 15:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730205AbgIHPzg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Sep 2020 11:55:36 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406D5C061251
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Sep 2020 08:42:52 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id n133so15636815qkn.11
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Sep 2020 08:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IQlLeQqrtds9GcsUFdhbQtPfqvpKT3wxoDrNcMBhrWE=;
        b=xCacUG2pKL/2se+6r1IzpPdodiGDKHTObdLxGUFq7Je0KYn3xDVEqd2TuF3Fto1Z7n
         rfMrTzaoLtnupfsl02iVwbsUKq/Iehktrq6IzvSEZGL+bHlVhF3dJrvKqovuG+ppi137
         8UxfO0ghUWrZcRi/cQnjaIpUsLqrgoFOjKycwlfyKduX8O+glt8iz4B21bXWft5fSY72
         07MM5THHJiwzc+Sb6SQrc2RDoXOj2xQluixbQcSCLANGigobanh3LwWfqjtUuBqPgZQu
         VOxTltxXsbUwpqR81k4CAzUOv996Rd0sbWnz2EzRZ2sZurqabkoV0DG7QNI81bQ/sqkS
         lDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IQlLeQqrtds9GcsUFdhbQtPfqvpKT3wxoDrNcMBhrWE=;
        b=ANLkvB60JhDJhDfRnzelX77veRjfOW8zX8/TTDZLJC2icqehpgJAhb6/tZvJ7wC3EB
         Z2Do9/fsaXw8QG9TP2eGM+c47YZ56/g4sNmCX3gmWwR7B3YZkI4UW2eP54Kob8Nem2yN
         a/tk/HaWUBqtKykpohVc06t5qWAM1J8rNJ8nVG4uNCzo7lXBGsgY0elQsTRa9k6cFcR+
         PbIxfjQ0zoDMuneY5HJ5wqgHyoBTHCyvci77KmMHfcArgLybSGcV/AT1PabhOAH/V8Ug
         hnnT5+XSeEqikDK77zmKfKb26vko9O2YEBt6zJxnUAqHzdlPp8dA2TcLJVm43iq1FQNK
         rrhQ==
X-Gm-Message-State: AOAM533FRjQkZT7X5e2F4/4JbV+EBUksFBWKzZDm0zcqlYAKbhq/G7OW
        9mrGfmhlzFCctsYZp+PUOfmPZQ3fdi3fth5q
X-Google-Smtp-Source: ABdhPJwzJhCe9kMPzZxGz2XJgc85D8zVDSm+UG5MCXAEhIM4rQCrMeDc24kKCJ78XtkTG2ucNF7+bw==
X-Received: by 2002:a37:81c1:: with SMTP id c184mr620467qkd.151.1599579766074;
        Tue, 08 Sep 2020 08:42:46 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l19sm15459821qtu.16.2020.09.08.08.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 08:42:45 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] fstests: btrfs/219 add a test to test -o rescue=all
Date:   Tue,  8 Sep 2020 11:42:44 -0400
Message-Id: <5e29c56193c6de8bbc364f22595479d292da13d3.1599579754.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This new mount option makes sure we can still mount the file system if
any of the core roots are corrupted.  This test corrupts each of these
roots and validates that it can still mount the fs and read the file.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/btrfs/219     | 54 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/219.out |  2 ++
 tests/btrfs/group   |  1 +
 3 files changed, 57 insertions(+)
 create mode 100755 tests/btrfs/219
 create mode 100644 tests/btrfs/219.out

diff --git a/tests/btrfs/219 b/tests/btrfs/219
new file mode 100755
index 00000000..b63bf899
--- /dev/null
+++ b/tests/btrfs/219
@@ -0,0 +1,54 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Facebook.  All Rights Reserved.
+#
+# FS QA Test 219
+#
+# A test to exercise the various failure scenarios for -o rescue=all.  This is
+# mainly a regression test for
+#
+#   btrfs: introduce rescue=all
+#
+# We simply corrupt a bunch of core roots and validate that it works the way we
+# expect it to.
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
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_supported_os Linux
+_require_test
+_require_scratch_mountopt "-o rescue=all,ro"
+
+# if error
+exit
+
+# optional stuff if your test has verbose output to help resolve problems
+#echo
+#echo "If failure, check $seqres.full (this) and $seqres.full.ok (reference)"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/219.out b/tests/btrfs/219.out
new file mode 100644
index 00000000..162074d3
--- /dev/null
+++ b/tests/btrfs/219.out
@@ -0,0 +1,2 @@
+QA output created by 219
+Silence is golden
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 3295856d..f4dbfafb 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -221,3 +221,4 @@
 216 auto quick seed
 217 auto quick trim dangerous
 218 auto quick volume
+219 auto quick
-- 
2.26.2

