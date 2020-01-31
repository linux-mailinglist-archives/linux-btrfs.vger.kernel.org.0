Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 510A714E892
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 07:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgAaGGI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jan 2020 01:06:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:48190 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgAaGGI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jan 2020 01:06:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BC78DAF05;
        Fri, 31 Jan 2020 06:06:05 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Martin Doucha <mdoucha@suse.cz>
Subject: [PATCH] fstests: generic: Introduce new test case to verify the NOCOW unaligned hole punch behavior
Date:   Fri, 31 Jan 2020 14:05:45 +0800
Message-Id: <20200131060545.27904-1-wqu@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a new LTP test case (*) doing hole punching with the following
conditions:
- Hole is unaligned on exiting data
  Which involves data writes to zero exiting data.

- The fs is full

- The involved file has NOCOW bit set
  Even for fs like btrfs, such write should no allocate new space.
  For other fses which don't support NOCOW bit, they either default to
  NOCOW or don't support COW at all.
  Thus the behavior should still be the same.

Btrfs currently fails such test, the fix is titled
"btrfs: Allow btrfs_truncate_block() to fallback to nocow for data space
 reservation".

XFS and EXT4 all pass.

*: https://patchwork.ozlabs.org/patch/1224176/

Reported-by: Martin Doucha <mdoucha@suse.cz>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Please note that, for EXT4 there seems to be a bug in mkfs.ext4, as it
always output the version string ("mke2fs 1.45.5 (07-Jan-2020)") to
stderr, polluting the golden output.

But the unaligned hole punching behavior is still correct for EXT4.
---
 tests/generic/593     | 75 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/593.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 78 insertions(+)
 create mode 100755 tests/generic/593
 create mode 100644 tests/generic/593.out

diff --git a/tests/generic/593 b/tests/generic/593
new file mode 100755
index 00000000..884a142a
--- /dev/null
+++ b/tests/generic/593
@@ -0,0 +1,75 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 593
+#
+# Test if a fs can still punch unaligned hole for NOCOW files when the fs
+# is full.
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
+_require_scratch
+_require_command "$CHATTR_PROG" chattr
+_require_command "$LSATTR_PROG" lsattr 
+
+# Create a small fs so filling it should be pretty fast
+fssize=$(( 1024 * 1024 * 1024 )) # In bytes
+
+_scratch_mkfs_sized $fssize > $seqres.full
+_scratch_mount
+
+blocksize=$(_get_block_size $SCRATCH_MNT)
+echo "blocksize = $blocksize" >> $seqres.full
+nr_blocks=5
+
+touch $SCRATCH_MNT/target
+# - Completely ignore the error
+#   Either the fs supports COW, this will success and mark the file NOCOW
+#   Or the fs doesn't support COW, we can still go ahead.
+$CHATTR_PROG +C $SCRATCH_MNT/target >> $seqres.full 2>&1
+
+$LSATTR_PROG $SCRATCH_MNT/target >> $seqres.full
+
+$XFS_IO_PROG -c "pwrite -b $blocksize 0 $(( $nr_blocks * $blocksize))" \
+	$SCRATCH_MNT/target >> $seqres.full
+
+# ENOSPC expected
+$XFS_IO_PROG -f -c "pwrite -b $blocksize 0 $fssize" \
+	$SCRATCH_MNT/padding >> $seqres.full 2>&1
+
+# All these fpunch calls should success
+for ((i = 0; i < $nr_blocks; i++)); do
+	$XFS_IO_PROG -c "fpunch $(( $i * $blocksize)) $(( $blocksize / 2))" \
+		$SCRATCH_MNT/target >> $seqres.full
+done
+
+echo "Silence is golden"
+# success, all done
+status=0
+exit
diff --git a/tests/generic/593.out b/tests/generic/593.out
new file mode 100644
index 00000000..bac4d7d9
--- /dev/null
+++ b/tests/generic/593.out
@@ -0,0 +1,2 @@
+QA output created by 593
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 6fe62505..ca4df435 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -595,3 +595,4 @@
 590 auto prealloc preallocrw
 591 auto quick rw pipe splice
 592 auto quick encrypt
+593 auto quick enospc
-- 
2.23.0

