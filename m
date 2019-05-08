Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCC6817B40
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2019 16:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfEHOEO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 May 2019 10:04:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:42546 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726515AbfEHOEO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 May 2019 10:04:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 02769ABE1;
        Wed,  8 May 2019 14:04:12 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH v4] fstests: generic: Test if we can still do certain operations which doesn't take data space on full fs
Date:   Wed,  8 May 2019 22:04:05 +0800
Message-Id: <20190508140405.21887-1-wqu@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This test will test if we can still do the following operations when a
full is full:
- buffered write into unpopulated preallocated extent
- clone the untouched preallocated extent
- fsync
- no data loss if power loss happens after above fsync
Above operations should not fail, as they takes no extra data space.

Xfs passes the test, while btrfs fails at fsync and has data loss.
The fix for btrfs is:
"btrfs: Flush before reflinking any extent to prevent NOCOW write falling
 back to CoW without data reservation"

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
changelog:
v2:
- Change the comment and commit message to make it describe the test
  itself, not the btrfs specific part.
- Use $XFS_IO_PROG to replace xfs_io.
v3:
- Move the current test result and btrfs fix to commit message
- Also test if data is consistent after power loss and log recovery
v4:
- Skip the checksum of padding file
- Use golden output to verify the checksum
- Rename "checkpoint" to "checksum"
- Add _require_metadata_journaling check
---
 tests/generic/545     | 83 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/545.out |  3 ++
 tests/generic/group   |  1 +
 3 files changed, 87 insertions(+)
 create mode 100755 tests/generic/545
 create mode 100644 tests/generic/545.out

diff --git a/tests/generic/545 b/tests/generic/545
new file mode 100755
index 00000000..eb63022d
--- /dev/null
+++ b/tests/generic/545
@@ -0,0 +1,83 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 545
+#
+# Test when a fs is full we can still:
+# - Do buffered write into a unpopulated preallocated extent
+# - Clone the untouched part of that preallocated extent
+# - Fsync
+# - No data loss even power loss happens after fsync
+# All operations above should not fail.
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
+	_cleanup_flakey
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/reflink
+. ./common/dmflakey
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_supported_os Linux
+_require_scratch_reflink
+_require_dm_target flakey
+
+_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
+_init_flakey
+_mount_flakey
+
+# Create preallocated extent where we can write into
+$XFS_IO_PROG -f -c 'falloc 8k 64m' "$SCRATCH_MNT/foobar" >> $seqres.full
+
+# Use up all data space, to test later write-into-preallocate behavior
+_pwrite_byte 0x00 0 512m "$SCRATCH_MNT/padding" >> $seqres.full 2>&1
+
+# Sync to ensure that padding file reach disk so that at log recovery we
+# still have no data space
+sync
+
+# This should not fail
+_pwrite_byte 0xcd 1m 16m "$SCRATCH_MNT/foobar" >> $seqres.full
+
+# Do reflink here, we shouldn't use extra data space, thus it should not fail
+$XFS_IO_PROG -c "reflink ${SCRATCH_MNT}/foobar 8k 0 4k" "$SCRATCH_MNT/foobar" \
+	>> $seqres.full
+
+# Checksum before power loss
+echo md5 before $(_md5_checksum "$SCRATCH_MNT/foobar")
+
+# Fsync to check if writeback is ok
+$XFS_IO_PROG -c 'fsync'  "$SCRATCH_MNT/foobar"
+
+# Now emulate power loss
+_flakey_drop_and_remount
+
+# Checksum after power loss
+echo md5 after $(_md5_checksum "$SCRATCH_MNT/foobar")
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/545.out b/tests/generic/545.out
new file mode 100644
index 00000000..d38ac2e0
--- /dev/null
+++ b/tests/generic/545.out
@@ -0,0 +1,3 @@
+QA output created by 545
+md5 before cdccc121ae95c72fdbe53d8e343ef5ee
+md5 after cdccc121ae95c72fdbe53d8e343ef5ee
diff --git a/tests/generic/group b/tests/generic/group
index 40deb4d0..84892a60 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -547,3 +547,4 @@
 542 auto quick clone
 543 auto quick clone
 544 auto quick clone
+545 auto quick clone enospc log
-- 
2.21.0

