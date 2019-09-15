Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D935EB2EF5
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Sep 2019 09:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfIOHWh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 Sep 2019 03:22:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:58860 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725773AbfIOHWh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Sep 2019 03:22:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F0C38AE78;
        Sun, 15 Sep 2019 07:22:34 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH v2] fstests: btrfs: Verify falloc on multiple holes won't cause qgroup reserved data space leak
Date:   Sun, 15 Sep 2019 15:22:30 +0800
Message-Id: <20190915072230.25732-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a test case where falloc is called on multiple holes with qgroup
enabled.

This can cause qgroup reserved data space leak and false EDQUOT error
even we're not reaching the limit.

The fix is titled:
"btrfs: qgroup: Fix the wrong target io_tree when freeing
 reserved data space"

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
changelog:
v2:
- Remove the unnecessary loop
  The loop itself is just to ensure we leak as much space as possible.
  However even one loop is already enough to fail the final
  verification write, so remove the loop and modify the golden output.
---
 tests/btrfs/192     | 70 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/192.out |  8 ++++++
 tests/btrfs/group   |  1 +
 3 files changed, 79 insertions(+)
 create mode 100755 tests/btrfs/192
 create mode 100644 tests/btrfs/192.out

diff --git a/tests/btrfs/192 b/tests/btrfs/192
new file mode 100755
index 00000000..1abd7838
--- /dev/null
+++ b/tests/btrfs/192
@@ -0,0 +1,70 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 192
+#
+# Test if btrfs is going to leak qgroup reserved data space when
+# falloc on multiple holes fails.
+# The fix is titled:
+# "btrfs: qgroup: Fix the wrong target io_tree when freeing reserved data space"
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
+_supported_os Linux
+_require_scratch
+_require_xfs_io_command falloc
+
+_scratch_mkfs > /dev/null
+_scratch_mount
+
+$BTRFS_UTIL_PROG quota enable "$SCRATCH_MNT" > /dev/null
+$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT" > /dev/null
+$BTRFS_UTIL_PROG qgroup limit -e 256M "$SCRATCH_MNT"
+
+# Create a file with the following layout:
+# 0         128M      256M      384M
+# |  Hole   |4K| Hole |4K| Hole |
+# The total hole size will be 384M - 8k
+truncate -s 384m "$SCRATCH_MNT/file"
+$XFS_IO_PROG -c "pwrite 128m 4k" -c "pwrite 256m 4k" \
+	"$SCRATCH_MNT/file" | _filter_xfs_io
+
+# Falloc 0~384M range, it's going to fail due to the qgroup limit
+$XFS_IO_PROG -c "falloc 0 384m" "$SCRATCH_MNT/file" |\
+	_filter_xfs_io_error
+rm "$SCRATCH_MNT/file"
+
+# Ensure above delete reaches disk and free some space
+sync
+
+# We should be able to write at least 3/4 of the limit
+$XFS_IO_PROG -f -c "pwrite 0 192m" "$SCRATCH_MNT/file" | _filter_xfs_io
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/192.out b/tests/btrfs/192.out
new file mode 100644
index 00000000..654adf48
--- /dev/null
+++ b/tests/btrfs/192.out
@@ -0,0 +1,8 @@
+QA output created by 192
+wrote 4096/4096 bytes at offset 134217728
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 4096/4096 bytes at offset 268435456
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+fallocate: Disk quota exceeded
+wrote 201326592/201326592 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 2474d43e..160fe927 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -194,3 +194,4 @@
 189 auto quick send clone
 190 auto quick replay balance qgroup
 191 auto quick send dedupe
+192 auto qgroup fast enospc limit
-- 
2.22.0

