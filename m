Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3055176695
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 23:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgCBWIw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 17:08:52 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:34083 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgCBWIv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Mar 2020 17:08:51 -0500
Received: by mail-pj1-f66.google.com with SMTP id f2so351059pjq.1
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Mar 2020 14:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6eilX2BTsDDxBviroTez5tkOrUqYg+t+Zvzkt65hfjQ=;
        b=UAg7epZshV0DfHgJu9gwHnswSsUAfC3j6CNxB9p/i20kT7tNIkBqPQnTnXzKO5i5M7
         tmNH5upyOPee3FOdjGcUrkalpRT+l5ejW3SPYh6a6aB6ETblTBIB38VVSpIWSak3rCzv
         DerCVOUg1MUSZFrT3k4Yk9/AYSkQsUfO1HddvJF89v2OkFzj0zCn6gbqBukOtZWKn9mu
         y4fzIIUwAD5ZoXi0X68SaspceJC5pEZ0r2l+aVWSCZztnJULsqJqTUnISyTci6TtVDmI
         xb75cy7BUb9IjIFvjnFMXQRUbRmbPKVVuSPeCvIF0hPMcbRtehNT/4ASN1fk8B38tg5Z
         mA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6eilX2BTsDDxBviroTez5tkOrUqYg+t+Zvzkt65hfjQ=;
        b=Ndrtr5CNUrP3N0WFhAWp/+WglKDuSYxUOCXPrfmZ6d2y6ufQosoRs0zNLBMwRGYRjv
         Ei6wOWeFmEfszjejwdyzy3Wn6X37/bCoTxA73bH5GlgOaiD28/vaOS9SfnwWEqUmQNcY
         di55DtpSm+WPioDrHv0MlUjkdp/slnzN1qpEW6tNmrLcKbb2wm217Bvy5w/ZLRZlmS9I
         oZVOxP6mxi6adCG9cSMQPH+ptrgPL8DoIHuPHw3uKeI/CAQX9bf3ZccojNp4BS1zOpoB
         qTFyFsByJT12nLd8H5E1Ht+ZA8rgt2mkSbhbk5qVHr/cyn6GwG4z6+SpHHVCkd2o0581
         u4WQ==
X-Gm-Message-State: ANhLgQ2lo+xVyQKE7RCCTfLwAy3Upb3B62OhkIyPXtdCqXxkEHTpy4t8
        Fb2KX3Ccqlr0hvZC3G/8FKJPjQv4/RM=
X-Google-Smtp-Source: ADFU+vtIqksBZgzw9SLpezCTNWRaTcNPFHKO8RpZ6EGMuP98CiggT0WBaxBQ0n+zQEYBN80HZvyyiw==
X-Received: by 2002:a17:90a:102:: with SMTP id b2mr630005pjb.64.1583186930599;
        Mon, 02 Mar 2020 14:08:50 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:500::5:755a])
        by smtp.gmail.com with ESMTPSA id iq22sm207648pjb.9.2020.03.02.14.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 14:08:50 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH fstests] btrfs: add test for large direct I/O reads w/ RAID
Date:   Mon,  2 Mar 2020 14:08:45 -0800
Message-Id: <f9a293a382e81ba55e2a321634cb1548d7f69627.1583186857.git.osandov@fb.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Apparently we don't have any tests which exercise the code path in Btrfs
that has to split up direct I/Os for RAID stripes. Add one to catch the
bug fixed by "btrfs: fix RAID direct I/O reads with alternate csums".
---
I also had to fix up the tests/btrfs/group file, which had a renumbering
issue that was preventing me from adding a new test.

 tests/btrfs/207     | 58 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/207.out |  2 ++
 tests/btrfs/group   |  3 ++-
 3 files changed, 62 insertions(+), 1 deletion(-)
 create mode 100755 tests/btrfs/207
 create mode 100644 tests/btrfs/207.out

diff --git a/tests/btrfs/207 b/tests/btrfs/207
new file mode 100755
index 00000000..99e57cb8
--- /dev/null
+++ b/tests/btrfs/207
@@ -0,0 +1,58 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Facebook.  All Rights Reserved.
+#
+# FS QA Test 207
+#
+# Test large DIO reads with various profiles. Regression test for patch "btrfs:
+# fix RAID direct I/O reads with alternate csums".
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
+_supported_fs btrfs
+_supported_os Linux
+# we check scratch dev after each loop
+_require_scratch_nocheck
+_require_scratch_dev_pool 4
+_btrfs_get_profile_configs
+
+for mkfs_opts in "${_btrfs_profile_configs[@]}"; do
+	echo "Test $mkfs_opts" >>$seqres.full
+	_scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
+	_scratch_mount >>$seqres.full 2>&1
+
+	dd if=/dev/urandom of="$SCRATCH_MNT/$seq" \
+		bs=1M count=64 conv=fsync status=none
+	dd if="$SCRATCH_MNT/$seq" of="$SCRATCH_MNT/$seq.copy" \
+		bs=1M iflag=direct status=none
+	diff -q "$SCRATCH_MNT/$seq" "$SCRATCH_MNT/$seq.copy" |
+		tee -a $seqres.full
+
+	_scratch_unmount
+	_check_scratch_fs
+done
+
+echo "Silence is golden"
+
+status=0
+exit
diff --git a/tests/btrfs/207.out b/tests/btrfs/207.out
new file mode 100644
index 00000000..cb8e0e2b
--- /dev/null
+++ b/tests/btrfs/207.out
@@ -0,0 +1,2 @@
+QA output created by 207
+Silence is golden
diff --git a/tests/btrfs/group b/tests/btrfs/group
index e3ad347b..c87a042e 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -208,4 +208,5 @@
 203 auto quick send clone
 204 auto quick punch
 205 auto quick clone compress
-204 auto quick log replay
+206 auto quick log replay
+207 auto quick rw raid
-- 
2.25.1

