Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD81C293EEF
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Oct 2020 16:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408284AbgJTOnI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Oct 2020 10:43:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:54638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730975AbgJTOnI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Oct 2020 10:43:08 -0400
Received: from debian8.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89F132224B;
        Tue, 20 Oct 2020 14:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603204987;
        bh=FRiSUjVs503lwplBKnpi6Kx1aggomjJ49gyPVvvfK+U=;
        h=From:To:Cc:Subject:Date:From;
        b=kxhFl47noIVIF4icb8rj7X0Q71M6cIFOndXb4hs6P3vmIUewdV0exHrQtfCh/pngU
         NlQLCvSl04RREvA2928vRoATvvJJL+yOTyUsBb05jdd81uijZj7O81B99fODXalXVB
         ilmTw4Hjqy0fpxre0iY1pEEzFTCt0YFL/sYry6Mo=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: add test case for rwf_nowait writes
Date:   Tue, 20 Oct 2020 15:43:01 +0100
Message-Id: <5cfe8cb86da5593dda6c03b4ac404fa3b4c8b0d8.1603204654.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test several scenarios for RWF_NOWAIT writes, to verify we don't regress
on btrfs specific behaviour (snapshots, cow files, reflinks, holes,
prealloc extent beyond eof).

We had some bugs in the past related to RWF_NOWAIT writes not failing on
btrfs when they should or failing when they shouldn't, these were fixed by
the following kernel commits:

  4b1946284dd6 ("btrfs: fix failure of RWF_NOWAIT write into prealloc extent beyond eof")
  260a63395f90 ("btrfs: fix RWF_NOWAIT write not failling when we need to cow")

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/225     | 140 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/225.out |  70 ++++++++++++++++++++++
 tests/btrfs/group   |   1 +
 3 files changed, 211 insertions(+)
 create mode 100755 tests/btrfs/225
 create mode 100644 tests/btrfs/225.out

diff --git a/tests/btrfs/225 b/tests/btrfs/225
new file mode 100755
index 00000000..f55e8c80
--- /dev/null
+++ b/tests/btrfs/225
@@ -0,0 +1,140 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test No. btrfs/225
+#
+# Test several (btrfs specific) scenarios with RWF_NOWAIT writes, cases where
+# they should fail and cases where they should succeed.
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
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
+# real QA test starts here
+_supported_fs btrfs
+_require_scratch_reflink
+_require_chattr C
+_require_odirect
+_require_xfs_io_command pwrite -N
+_require_xfs_io_command falloc -k
+_require_xfs_io_command fpunch
+
+rm -f $seqres.full
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+# Test a write against COW file/extent - should fail with -EAGAIN. Disable the
+# NOCOW attribute of the file just in case MOUNT_OPTIONS has "-o nodatacow".
+echo "Testing write against COW file"
+touch $SCRATCH_MNT/f1
+$CHATTR_PROG -C $SCRATCH_MNT/f1
+$XFS_IO_PROG -s -c "pwrite -S 0xab 0 128K" $SCRATCH_MNT/f1 | _filter_xfs_io
+$XFS_IO_PROG -d -c "pwrite -N -V 1 -S 0xff 32K 64K" $SCRATCH_MNT/f1
+
+# Check no data was written.
+echo "File data after write attempt:"
+od -A d -t x1 $SCRATCH_MNT/f1
+
+# Create a file with two extents (NOCOW), then create a snapshot, unshare the
+# first extent by writing to it without RWF_NOWAIT, and then attempt to write
+# to a file range that includes both the non-shared and the shared extent -
+# should fail with -EAGAIN.
+echo
+echo "Testing write against extent shared across snapshots"
+touch $SCRATCH_MNT/f2
+$CHATTR_PROG +C $SCRATCH_MNT/f2
+$XFS_IO_PROG -s -c "pwrite -S 0xab 0 64K" \
+	     -c "pwrite -S 0xcd 64K 64K" \
+	     $SCRATCH_MNT/f2 | _filter_xfs_io
+
+$BTRFS_UTIL_PROG subvolume snapshot $SCRATCH_MNT $SCRATCH_MNT/snap \
+    | _filter_scratch
+
+# Write into the range of the first extent so that that range no longer has a
+# shared extent.
+$XFS_IO_PROG -s -c "pwrite -S 0xab 0 64K" $SCRATCH_MNT/f2 | _filter_xfs_io
+
+# Attempt to write into the file range, using RWF_NOWAIT, that covers the
+# non-shared and the shared extents, should fail.
+$XFS_IO_PROG -d -c "pwrite -N -V 1 -S 0xff -b 64K 32K 64K" $SCRATCH_MNT/f2
+
+# Check no data was written.
+echo "File data after write attempt:"
+od -A d -t x1 $SCRATCH_MNT/f2
+
+# Create a file that has an extent shared with file f2. Attempting to write
+# into a range that covers the shared extent should fail with -EAGAIN.
+echo
+echo "Testing write against shared extent through reflink"
+touch $SCRATCH_MNT/f3
+$CHATTR_PROG +C $SCRATCH_MNT/f3
+$XFS_IO_PROG -s -c "pwrite -S 0xab -b 64K 0 64K" \
+	     -c "reflink $SCRATCH_MNT/f2 64K 64K 64K" \
+	     $SCRATCH_MNT/f3 | _filter_xfs_io
+
+# Should fail, range 64K to 96K has a shared extent.
+$XFS_IO_PROG -d -c "pwrite -N -V 1 -S 0xff -b 64K 32K 64K" $SCRATCH_MNT/f3
+
+# Check no data was written.
+echo "File data after write attempt:"
+od -A d -t x1 $SCRATCH_MNT/f3
+
+# Create a file with a prealloc extent at eof and attempt to write to it, it
+# should succeed.
+echo
+echo "Testing write against prealloc extent at eof"
+$XFS_IO_PROG -f -s -c "pwrite -S 0xab 0 64K" \
+	     -c "falloc -k 64K 64K" \
+	     $SCRATCH_MNT/f4 | _filter_xfs_io
+
+# Should succeed.
+$XFS_IO_PROG -d -c "pwrite -N -V 1 -S 0xcd -b 64K 64K 64K" $SCRATCH_MNT/f4 \
+    | _filter_xfs_io
+
+# Check the file has the expected data.
+echo "File after write:"
+od -A d -t x1 $SCRATCH_MNT/f4
+
+# Attempts to write to ranges that have a hole, should fail with -EAGAIN.
+echo
+echo "Testing writes against ranges with holes"
+touch $SCRATCH_MNT/f5
+$CHATTR_PROG +C $SCRATCH_MNT/f5
+# 3 64Kb extents, with a 64K hole at offset 128K.
+$XFS_IO_PROG -s -d -c "pwrite -S 0xab -b 64K 0 64K" \
+	     -s -d -c "pwrite -S 0xcd -b 64K 64K 64K" \
+	     -s -d -c "pwrite -S 0xef -b 64K 192K 64K" \
+	     $SCRATCH_MNT/f5 | _filter_xfs_io
+
+# Should fail, second half of the range maps to a hole.
+$XFS_IO_PROG -d -c "pwrite -N -V 1 -S 0x11 -b 128K 64K 128K" $SCRATCH_MNT/f5
+
+# Now try with a range that starts with a hole and ends with an extent, should
+# fail as well.
+$XFS_IO_PROG -c "fpunch 0 64K" \
+	     -d -c "pwrite -N -V 1 -S 0x22 -b 128K 0 128K" \
+	     $SCRATCH_MNT/f5
+
+# Check no data was written.
+echo "File data after write attempt:"
+od -A d -t x1 $SCRATCH_MNT/f5
+
+status=0
+exit
diff --git a/tests/btrfs/225.out b/tests/btrfs/225.out
new file mode 100644
index 00000000..e2aac85d
--- /dev/null
+++ b/tests/btrfs/225.out
@@ -0,0 +1,70 @@
+QA output created by 225
+Testing write against COW file
+wrote 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+pwrite: Resource temporarily unavailable
+File data after write attempt:
+0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
+*
+0131072
+
+Testing write against extent shared across snapshots
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 65536
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Create a snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+pwrite: Resource temporarily unavailable
+File data after write attempt:
+0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
+*
+0065536 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
+*
+0131072
+
+Testing write against shared extent through reflink
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+linked 65536/65536 bytes at offset 65536
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+pwrite: Resource temporarily unavailable
+File data after write attempt:
+0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
+*
+0065536 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
+*
+0131072
+
+Testing write against prealloc extent at eof
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 65536
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File after write:
+0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
+*
+0065536 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
+*
+0131072
+
+Testing writes against ranges with holes
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 65536
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 196608
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+pwrite: Resource temporarily unavailable
+pwrite: Resource temporarily unavailable
+File data after write attempt:
+0000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+*
+0065536 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
+*
+0131072 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+*
+0196608 ef ef ef ef ef ef ef ef ef ef ef ef ef ef ef ef
+*
+0262144
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 9ad33baa..3169e478 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -226,3 +226,4 @@
 222 auto quick send
 223 auto quick replace trim
 224 auto quick qgroup
+225 auto quick rw snapshot clone prealloc punch
-- 
2.28.0

