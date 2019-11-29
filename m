Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B39610D7BD
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Nov 2019 16:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfK2PPQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Nov 2019 10:15:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:36946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbfK2PPQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Nov 2019 10:15:16 -0500
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22C88216F4;
        Fri, 29 Nov 2019 15:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575040514;
        bh=DzmFP1g/C4Zu48AgFSs5fvDJ1vZjROCqu/ogxFaXGAg=;
        h=From:To:Cc:Subject:Date:From;
        b=0wBxqjP8nNTG/9ISEV9/ietE31FkFgMQUZrX2U0zWoB6lVbx+r1waQT3MwINmFgFU
         +yEGqZJUnXdaeEjmFoPpmYC45yyfE/bAxwwEXglPN6AvwuBEPF7oLOLtyk5D5MDho5
         qf0lopVpnv+4tj8ZJan1YIwTbVLiPw8bJFhlbdxA=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] generic: test journal/log replay when a file with cloned extents was fsync'ed
Date:   Fri, 29 Nov 2019 15:15:09 +0000
Message-Id: <20191129151509.1871-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test that if we clone part of an extent from a file to itself at a
different offset, fsync it, rewrite (COW) part of the extent from the
former offset, fsync it again, power fail and then mount the filesystem,
we are able to read the whole file and it has the correct data.

This is motivated by a bug found in btrfs which is fixed by a kernel patch
that has the following subject:

  "Btrfs: fix missing data checksums after replaying a log tree"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/586     | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/586.out | 13 +++++++++
 tests/generic/group   |  1 +
 3 files changed, 91 insertions(+)
 create mode 100755 tests/generic/586
 create mode 100644 tests/generic/586.out

diff --git a/tests/generic/586 b/tests/generic/586
new file mode 100755
index 00000000..b889a0d0
--- /dev/null
+++ b/tests/generic/586
@@ -0,0 +1,77 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FSQA Test No. 586
+#
+# Test that if we clone part of an extent from a file to itself at different
+# offset, fsync it, rewrite (COW) part of the extent from the former offset,
+# fsync it again, power fail and then mount the filesystem, we are able to
+# read the whole file and it has the correct data.
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
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
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_scratch_reflink
+_require_dm_target flakey
+
+rm -f $seqres.full
+
+_scratch_mkfs >>$seqres.full 2>&1
+_require_metadata_journaling $SCRATCH_DEV
+_init_flakey
+_mount_flakey
+
+# Create our test file with two 256Kb extents, one at file offset 0 and the
+# other at file offset 256Kb.
+$XFS_IO_PROG -f -c "pwrite -S 0xa3 0 256K" \
+	     -c "fsync" \
+	     -c "pwrite -S 0xc7 256K 256K" \
+	     $SCRATCH_MNT/foobar | _filter_xfs_io
+
+# Now clone the second 64Kb of data from the second extent into file offset 0.
+# After this we get that extent partially shared. Also fsync the file.
+$XFS_IO_PROG -c "reflink $SCRATCH_MNT/foobar 320K 0K 64K" \
+	     -c "fsync" \
+	     $SCRATCH_MNT/foobar | _filter_xfs_io
+
+# Now COW the first 64Kb of data for that second extent. After this we no longer
+# have the extent fully referenced - its second 64Kb of data are referenced at
+# file offset 0 and its last 192Kb of data are referenced at file offset 320Kb.
+# Fsync the file to make sure everything is durably persisted.
+$XFS_IO_PROG -c "pwrite -S 0xe5 256K 64K" \
+	     -c "fsync" \
+	     $SCRATCH_MNT/foobar | _filter_xfs_io
+
+echo "File digest before power failure:"
+_md5_checksum $SCRATCH_MNT/foobar
+
+# Simulate a power failure and then check no data loss or corruption happened.
+_flakey_drop_and_remount
+
+echo "File digest after mount:"
+_md5_checksum $SCRATCH_MNT/foobar
+
+_unmount_flakey
+status=0
+exit
diff --git a/tests/generic/586.out b/tests/generic/586.out
new file mode 100644
index 00000000..7bb4cdce
--- /dev/null
+++ b/tests/generic/586.out
@@ -0,0 +1,13 @@
+QA output created by 586
+wrote 262144/262144 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 262144/262144 bytes at offset 262144
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+linked 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 262144
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File digest before power failure:
+b92c7b6e89d6f466cffba1f6e6193e5d
+File digest after mount:
+b92c7b6e89d6f466cffba1f6e6193e5d
diff --git a/tests/generic/group b/tests/generic/group
index e5d0c1da..d264cfcf 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -588,3 +588,4 @@
 583 auto quick encrypt
 584 auto quick encrypt
 585 auto rename
+586 auto quick log clone
-- 
2.11.0

