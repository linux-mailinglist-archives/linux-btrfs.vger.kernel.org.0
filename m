Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0913721266D
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 16:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbgGBOi1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 10:38:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:51256 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728179AbgGBOi0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Jul 2020 10:38:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 48EB3ADD9;
        Thu,  2 Jul 2020 14:38:25 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: test that corruption counter is incremented correctly
Date:   Thu,  2 Jul 2020 17:38:23 +0300
Message-Id: <20200702143823.20333-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch ensures device corrupted counter is being modified when we try to
read broken data.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 tests/btrfs/215     | 92 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/215.out |  2 +
 tests/btrfs/group   |  1 +
 3 files changed, 95 insertions(+)
 create mode 100755 tests/btrfs/215
 create mode 100644 tests/btrfs/215.out

diff --git a/tests/btrfs/215 b/tests/btrfs/215
new file mode 100755
index 000000000000..d341144c0d97
--- /dev/null
+++ b/tests/btrfs/215
@@ -0,0 +1,92 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 215
+#
+# Test that reading corrupted files would correctly increment device status
+# counters. This is fixed by the following linux kernel commit:
+# btrfs: Increment device corruption error in case of checksum error
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
+get_physical()
+{
+	$BTRFS_UTIL_PROG inspect-internal dump-tree -t 3 $SCRATCH_DEV | \
+		grep $1 -A2 | \
+		$AWK_PROG "(\$1 ~ /stripe/ && \$3 ~ /devid/ && \$2 ~ /0/) { print \$6 }"
+}
+
+# Modify as appropriate.
+_supported_fs btrfs
+_supported_os Linux
+
+_scratch_mkfs > /dev/null
+# disable freespace inode to ensure file is the first thing in the data
+# blobk group
+_scratch_mount -o nospace_cache
+
+blocksize=$(_get_block_size $SCRATCH_MNT)
+filesize=$((8*$blocksize))
+uuid=$(findmnt -n -o UUID "$SCRATCH_MNT")
+
+if [ ! -e /sys/fs/btrfs/$uuid/bdi ]; then
+	_notrun "bdi link not found"
+fi
+
+#create an 8 block file
+$XFS_IO_PROG -d -f -c "pwrite -S 0xbb -b $filesize 0 $filesize" "$SCRATCH_MNT/foobar" > /dev/null
+
+logical_extent=$($FILEFRAG_PROG -v "$SCRATCH_MNT/foobar" | _filter_filefrag | cut -d '#' -f 1)
+physical_extent=$(get_physical $logical_extent)
+
+echo "logical = $logical_extent physical=$physical_extent" >> $seqres.full
+
+# corrupt first 4 blocks of file
+_scratch_unmount
+$XFS_IO_PROG -d -c "pwrite -S 0xaa -b $blocksize $physical_extent $((4*$blocksize))" $SCRATCH_DEV > /dev/null
+_scratch_mount
+
+# disable readahead to avoid skewing the counter
+echo 0 > /sys/fs/btrfs/$uuid/bdi/read_ahead_kb
+
+# buffered reads whould result in a single error since the read is done
+# page by page
+$XFS_IO_PROG -c "pread -b $filesize 0 $filesize" "$SCRATCH_MNT/foobar" > /dev/null 2>&1
+errs=$($BTRFS_UTIL_PROG device stats $SCRATCH_DEV | awk '/corruption_errs/ { print $2 }')
+if [ $errs -ne 1 ]; then
+	_fail "Errors: $errs expected: 1"
+fi
+
+# DIO does check every sector
+$XFS_IO_PROG -d -c "pread -b $filesize 0 $filesize" "$SCRATCH_MNT/foobar" > /dev/null 2>&1
+errs=$($BTRFS_UTIL_PROG device stats $SCRATCH_DEV | awk '/corruption_errs/ { print $2 }')
+if [ $errs -ne 5 ]; then
+	_fail "Errors: $errs expected: 1"
+fi
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/btrfs/215.out b/tests/btrfs/215.out
new file mode 100644
index 000000000000..0a11773bbb32
--- /dev/null
+++ b/tests/btrfs/215.out
@@ -0,0 +1,2 @@
+QA output created by 215
+Silence is golden
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 505665b54d61..dda0763e543b 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -217,3 +217,4 @@
 212 auto balance dangerous
 213 auto balance dangerous
 214 auto quick send snapshot
+215 auto quick
--
2.17.1

