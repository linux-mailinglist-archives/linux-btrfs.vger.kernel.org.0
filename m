Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501E949B020
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jan 2022 10:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1456977AbiAYJ0T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jan 2022 04:26:19 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37486 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573428AbiAYJXv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jan 2022 04:23:51 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5892E1F397;
        Tue, 25 Jan 2022 09:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643102605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=YRWsd/EwoOdW2gN6s5B6GbYp5CNJthV1ji/Ufa0rud8=;
        b=fARA9PxdaVRDf8P5J7p3bWOaPZnKUfjMY3Z3I9bKAnzi2sy8L+5c0k8eOvB1kB+pZO9DiM
        EyK8rq3PloIn1ypKOLwcGucpVOeVie9rBqr4qg5Y14N2r95hky6u72F2JV48pwlIfhY2Gc
        8O4wVAxSTSagvkaBjHa8rHs02f+0a9c=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7895613DA2;
        Tue, 25 Jan 2022 09:23:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 43KuEIzB72EXRgAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 25 Jan 2022 09:23:24 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: add test case to make sure autodefrag won't give up the whole cluster when there is a hole in it
Date:   Tue, 25 Jan 2022 17:23:07 +0800
Message-Id: <20220125092307.67536-1-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In v5.11~v5.15 kernels, there is a regression in autodefrag that if a
cluster (up to 256K in size) has even a single hole, the whole cluster
will be rejected.

This will greatly reduce the efficiency of autodefrag.

The behavior is fixed in v5.16 by a full rework, although the rework
itself has other problems, it at least solves this particular
regression.

Here we add a test case to reproduce the case, where we have a 128K
cluster, the first half is fragmented extents which can be defragged.
The second half is hole.

Make sure autodefrag can defrag the 64K part.

This test needs extra debug feature, which is titled:

  [RFC] btrfs: sysfs: introduce <uuid>/debug/cleaner_trigger

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/btrfs        |  11 +++++
 tests/btrfs/256     | 112 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/256.out |   2 +
 3 files changed, 125 insertions(+)
 create mode 100755 tests/btrfs/256
 create mode 100644 tests/btrfs/256.out

diff --git a/common/btrfs b/common/btrfs
index 5de926dd..4e6842d9 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -496,3 +496,14 @@ _require_btrfs_support_sectorsize()
 	grep -wq $sectorsize /sys/fs/btrfs/features/supported_sectorsizes || \
 		_notrun "sectorsize $sectorsize is not supported"
 }
+
+# Require trigger for cleaner kthread
+_require_btrfs_debug_cleaner_trigger()
+{
+	local fsid
+
+	fsid=$($BTRFS_UTIL_PROG filesystem show $TEST_DIR | grep uuid: |\
+	       $AWK_PROG '{print $NF}')
+	test -f /sys/fs/btrfs/$fsid/debug/cleaner_trigger ||\
+		_notrun "no cleaner kthread trigger"
+}
diff --git a/tests/btrfs/256 b/tests/btrfs/256
new file mode 100755
index 00000000..86e6739e
--- /dev/null
+++ b/tests/btrfs/256
@@ -0,0 +1,112 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 256
+#
+# Make sure btrfs auto defrag can properly defrag clusters which has hole
+# in the middle
+#
+. ./common/preamble
+_begin_fstest auto defrag quick
+
+. ./common/btrfs
+. ./common/filter
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_require_scratch
+
+get_extent_disk_sector()
+{
+	local file=$1
+	local offset=$2
+
+	$XFS_IO_PROG -c "fiemap $offset" "$file" | _filter_xfs_io_fiemap |\
+		head -n1 | $AWK_PROG '{print $3}'
+}
+
+# Needs 4K sectorsize, as larger sectorsize can change the file layout.
+_require_btrfs_support_sectorsize 4096
+
+# We need a way to trigger autodefrag
+_require_btrfs_debug_cleaner_trigger
+
+_scratch_mkfs >> $seqres.full
+
+# Need datacow to show which range is defragged, and we're testing
+# autodefrag
+_scratch_mount -o datacow,autodefrag
+
+fsid=$($BTRFS_UTIL_PROG filesystem show $SCRATCH_MNT |grep uuid: |\
+       $AWK_PROG '{print $NF}')
+
+# Create a layout where we have fragmented extents at [0, 64k) (sync write in
+# reserve order), then a hole at [64k, 128k)
+$XFS_IO_PROG -f -c "pwrite 48k 16k" -c sync \
+		-c "pwrite 32k 16k" -c sync \
+		-c "pwrite 16k 16k" -c sync \
+		-c "pwrite 0 16k" $SCRATCH_MNT/foobar >> $seqres.full
+truncate -s 128k $SCRATCH_MNT/foobar
+sync
+
+old_csum=$(_md5_checksum $SCRATCH_MNT/foobar)
+echo "=== File extent layout before autodefrag ===" >> $seqres.full
+$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $seqres.full
+echo "old md5=$old_csum" >> $seqres.full
+
+old_regular=$(get_extent_disk_sector "$SCRATCH_MNT/foobar" 0)
+old_hole=$(get_extent_disk_sector "$SCRATCH_MNT/foobar" 64k)
+
+# For hole only xfs_io fiemap, there will be no output at all.
+# Re-fill it to "hole" for later comparison
+if [ ! -z $old_hole ]; then
+	echo "hole not at 128k"
+else
+	old_hole="hole"
+fi
+
+# Now trigger autodefrag
+echo 0 > /sys/fs/btrfs/$fsid/debug/cleaner_trigger
+
+# No good way to wait for autodefrag to finish yet
+sleep 3
+sync
+
+new_csum=$(_md5_checksum $SCRATCH_MNT/foobar)
+new_regular=$(get_extent_disk_sector "$SCRATCH_MNT/foobar" 0)
+new_hole=$(get_extent_disk_sector "$SCRATCH_MNT/foobar" 64k)
+
+echo "=== File extent layout after autodefrag ===" >> $seqres.full
+$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $seqres.full
+echo "new md5=$new_csum" >> $seqres.full
+
+if [ ! -z $new_hole ]; then
+	echo "hole not at 128k"
+else
+	new_hole="hole"
+fi
+
+# In v5.11~v5.15 kernels, regular extents won't get defragged, and would trigger
+# the following output
+if [ $new_regular == $old_regular ]; then
+	echo "regular extents didn't get defragged"
+fi
+
+# In v5.10 and earlier kernel, autodefrag may choose to defrag holes,
+# which should be avoided.
+if [ "$new_hole" != "$old_hole" ]; then
+	echo "hole extents got defragged"
+fi
+
+# Defrag should not change file content
+if [ "$new_csum" != "$old_csum" ]; then
+	echo "file content changed"
+fi
+
+echo "Silence is golden"
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/256.out b/tests/btrfs/256.out
new file mode 100644
index 00000000..7ee8e2e5
--- /dev/null
+++ b/tests/btrfs/256.out
@@ -0,0 +1,2 @@
+QA output created by 256
+Silence is golden
-- 
2.34.1

