Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4A3A172CC
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2019 09:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfEHHrk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 May 2019 03:47:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:59122 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726835AbfEHHrk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 May 2019 03:47:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 338F9AEEA;
        Wed,  8 May 2019 07:47:38 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] fstests: generic: Test if fsync will fail after NOCOW write and reflink
Date:   Wed,  8 May 2019 15:47:33 +0800
Message-Id: <20190508074733.12787-1-wqu@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This test case is going to check if btrfs will fail fsync after NOCOW
buffered write and reflink.

Btrfs' back reference only has extent level granularity, so if we do
buffered write which can be done NOCOW, then reflink, that buffered
write will be forced CoW.

And if we have no data space left, CoW will fail and cause fsync
failure.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/generic/545     | 82 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/545.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 85 insertions(+)
 create mode 100755 tests/generic/545
 create mode 100644 tests/generic/545.out

diff --git a/tests/generic/545 b/tests/generic/545
new file mode 100755
index 00000000..b6e1a0ae
--- /dev/null
+++ b/tests/generic/545
@@ -0,0 +1,82 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 545
+#
+# Test if btrfs fails fsync due to ENOSPC.
+#
+# Btrfs' back reference only has extent level granularity, thus if reflink of
+# an preallocated extent happens, any write into that extent must be CoWed.
+#
+# We could craft a case, where btrfs reserve no data space at buffered write
+# time but are forced to do CoW at writeback, and fail fsync.
+#
+# This is fixed by "btrfs: Flush before reflinking any extent to prevent NOCOW
+# write falling back to CoW without data reservation"
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
+. ./common/reflink
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+_require_scratch_reflink
+
+_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
+
+# Space cache will use some data space and may cause interference.
+# Disable space cache here.
+_scratch_mount -o nospace_cache
+
+# Create preallocated extent where we can do NOCOW write
+xfs_io -f -c 'falloc 8k 64m' "$SCRATCH_MNT/foobar" >> $seqres.full
+
+# Use up all remaining space, so that later write will go through NOCOW check
+# We ignore the ENOSPC error here
+_pwrite_byte 0x00 0 512m "$SCRATCH_MNT/padding" >> $seqres.full 2>&1
+
+# Now setup is all done.
+sync
+
+# This buffered write will go through and pass NOCOW check thus no
+# data space is reserved.
+_pwrite_byte 0xcd 1m 16m "$SCRATCH_MNT/foobar" >> $seqres.full
+
+# Reflink the the unused part of the preallocated extent to increase
+# its reference, so for btrfs any write into that preallocated extent
+# must be CoWed.
+xfs_io -c "reflink ${SCRATCH_MNT}/foobar 8k 0 4k" "$SCRATCH_MNT/foobar" \
+	>> $seqres.full
+
+# Now fsync will fail due to we must CoW previous NOCOW write, but we have
+# now data space left, it will fail with ENOSPC
+xfs_io -c 'fsync'  "$SCRATCH_MNT/foobar"
+
+echo "Silence is golden"
+# success, all done
+status=0
+exit
diff --git a/tests/generic/545.out b/tests/generic/545.out
new file mode 100644
index 00000000..920d7244
--- /dev/null
+++ b/tests/generic/545.out
@@ -0,0 +1,2 @@
+QA output created by 545
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 40deb4d0..f26b91fe 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -547,3 +547,4 @@
 542 auto quick clone
 543 auto quick clone
 544 auto quick clone
+545 auto quick clone enospc
-- 
2.21.0

