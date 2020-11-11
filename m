Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553652AEFA4
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Nov 2020 12:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgKKLcJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Nov 2020 06:32:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:45438 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbgKKLcD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Nov 2020 06:32:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605094320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AWq8HAapziuUREuU8vc18v1jWnJehnz9KAXvn9jypLA=;
        b=siksuzPi1K2YmmPaLolp/Le5BWJvWQPR6BaY0fSsfGyuMtR3g7Pj/SFEQ4dRZP37Y+dMSM
        5Tf24/ecvnchc/tykhAzvQXclg0a+g+SFSXWsLb+Y1dFA6r8RIvO4M9VLvB6zNpL8ssLJa
        6thXfPfqsM5REFSv4MRUN8TIFmI5EhY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D5C29ABD6;
        Wed, 11 Nov 2020 11:32:00 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs: check qgroup doesn't crash when beyond limit
Date:   Wed, 11 Nov 2020 19:31:52 +0800
Message-Id: <20201111113152.136729-1-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a bug that, when btrfs is beyond qgroup limit, touching a file
could crash btrfs.

Such beyond limit situation needs to be intentionally created, e.g.
writing 1GiB file, then limit the subvolume to 512 MiB.
As current qgroup works pretty well at preventing us from reaching the
limit.

This makes existing qgroup test cases unable to detect it.

The regression is introduced by commit c53e9653605d ("btrfs: qgroup: try
to flush qgroup space when we get -EDQUOT"), and the fix is titled
"btrfs: qgroup: don't commit transaction when we have already
 hold a transaction handler"

Link: https://bugzilla.suse.com/show_bug.cgi?id=1178634
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/154     | 62 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/154.out |  2 ++
 tests/btrfs/group   |  1 +
 3 files changed, 65 insertions(+)
 create mode 100755 tests/btrfs/154
 create mode 100644 tests/btrfs/154.out

diff --git a/tests/btrfs/154 b/tests/btrfs/154
new file mode 100755
index 00000000..2a65d182
--- /dev/null
+++ b/tests/btrfs/154
@@ -0,0 +1,62 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 154
+#
+# Test if btrfs qgroup would crash if we're modifying the fs
+# after exceeding the limit
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
+_supported_fs btrfs
+
+# Need at least 2GiB
+_require_scratch_size $((2 * 1024 * 1024))
+_scratch_mkfs > /dev/null 2>&1
+
+_scratch_mount
+
+_pwrite_byte 0xcd 0 1G $SCRATCH_MNT/file >> $seqres.full
+
+# Make sure the data reach disk so later qgroup scan can see it
+sync
+
+$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
+$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
+
+# Set the limit to just 512MiB, which is way below the existing usage
+$BTRFS_UTIL_PROG qgroup limit  512M $SCRATCH_MNT $SCRATCH_MNT
+
+# Touch above file, if kernel not patched, it will trigger an ASSERT()
+#
+# Even for patched kernel, we will still get EDQUOT error, but that
+# is expected behavior.
+touch $SCRATCH_MNT/file 2>&1 | _filter_scratch
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/154.out b/tests/btrfs/154.out
new file mode 100644
index 00000000..b526c3f3
--- /dev/null
+++ b/tests/btrfs/154.out
@@ -0,0 +1,2 @@
+QA output created by 154
+touch: setting times of 'SCRATCH_MNT/file': Disk quota exceeded
diff --git a/tests/btrfs/group b/tests/btrfs/group
index d18450c7..c491e339 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -156,6 +156,7 @@
 151 auto quick volume
 152 auto quick metadata qgroup send
 153 auto quick qgroup limit
+154 auto quick qgroup limit
 155 auto quick send
 156 auto quick trim balance
 157 auto quick raid
-- 
2.28.0

