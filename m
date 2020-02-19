Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC45C164655
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2020 15:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgBSOGr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Feb 2020 09:06:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:46546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727762AbgBSOGr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Feb 2020 09:06:47 -0500
Received: from debian5.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43FBE20801;
        Wed, 19 Feb 2020 14:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582121206;
        bh=n04l4rVV0EFIBmk6k9i85/7pikHGwzb8g0NJGfqOfvI=;
        h=From:To:Cc:Subject:Date:From;
        b=WGtlgrslqazOKEL/uvHXDOTmiRCtD8cMwvm6EHfsaGwHeGPIMwtjOQp/NDuD85H8v
         XgVyRs0ioj/njnlS+fQnch9mh2QFpz+0pFCBIbiTnjDcic+nsbJUN6k5tx5kC3r5Ei
         uEuTxH8CESkajwLaL9aRHGU2XrLsrHi0yuYX2pt0=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 2/2] btrfs: add test case for newly supported cases of cloning inline extents
Date:   Wed, 19 Feb 2020 14:06:41 +0000
Message-Id: <20200219140641.1642570-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test several scenarios of cloning operations where the source range includes
inline extents. They used to not be supported on btrfs because their
implementation was not straightforward, and therefore these operations used
to fail with errno EOPNOTSUPP on older kernels.

This currently fails on any released kernel. It passes only when the patch
with the following subject is applied:

  "Btrfs: implement full reflink support for inline extents"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/205     | 173 +++++++++++++++++++++++++++++++
 tests/btrfs/205.out | 241 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/group   |   1 +
 3 files changed, 415 insertions(+)
 create mode 100755 tests/btrfs/205
 create mode 100644 tests/btrfs/205.out

diff --git a/tests/btrfs/205 b/tests/btrfs/205
new file mode 100755
index 00000000..9bec2bfa
--- /dev/null
+++ b/tests/btrfs/205
@@ -0,0 +1,173 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FSQA Test No. 205
+#
+# Test several scenarios of cloning operations where the source range includes
+# inline extents. They used to not be supported on btrfs because their
+# implementation was not straightforward, and therefore these operations used
+# to fail with errno EOPNOTSUPP on older kernels.
+#
+# Support for this was added by a patch with the following subject:
+#
+#   "Btrfs: implement full reflink support for inline extents"
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
+_supported_os Linux
+_require_scratch_reflink
+_require_xfs_io_command "falloc" "-k"
+_require_command "$CHATTR_PROG" chattr
+_require_btrfs_fs_feature "no_holes"
+_require_btrfs_mkfs_feature "no-holes"
+
+run_tests()
+{
+    rm -f $SCRATCH_MNT/foo* $SCRATCH_MNT/bar*
+
+    # File foo1 has an inline extent encoding 4K of data followed by a regular
+    # extent. It has a file size of 128K.
+    echo "Creating file foo1"
+    touch $SCRATCH_MNT/foo1
+    $CHATTR_PROG +c $SCRATCH_MNT/foo1
+    $XFS_IO_PROG -c "pwrite -S 0xab 0 4K" \
+		 -c "fsync" \
+		 -c "pwrite -S 0xab 4K 124K" \
+		 $SCRATCH_MNT/foo1 | _filter_xfs_io
+
+    # File bar1 has a single 128K extent, and a file size of 128K.
+    echo "Creating file bar1"
+    $XFS_IO_PROG -f -c "pwrite -S 0xcd 0 128K" $SCRATCH_MNT/bar1 | _filter_xfs_io
+
+    echo "Cloning foo1 into the end of bar1"
+    $XFS_IO_PROG -c "reflink $SCRATCH_MNT/foo1 0 128K 128K" $SCRATCH_MNT/bar1 \
+        | _filter_xfs_io
+
+    echo "File bar1 digest = $(_md5_checksum $SCRATCH_MNT/bar1)"
+
+    # File foo2 has an inline extent with 1000 bytes of data and it's followed
+    # by a regular extent of 60K. It has a file size of 64K.
+    echo "Creating file foo2"
+    $XFS_IO_PROG -f -c "pwrite -S 0xab 0 1000" \
+		 -c "fsync" \
+		 -c "falloc 0 4K" \
+		 -c "pwrite -S 0xab 4K 60K" \
+		 $SCRATCH_MNT/foo2 | _filter_xfs_io
+
+    # File bar2 has a regular extent of 64K and a file size of 64K too.
+    echo "Creating file bar2"
+    $XFS_IO_PROG -f -c "pwrite -S 0xcd 0 64K" $SCRATCH_MNT/bar2 | _filter_xfs_io
+
+    echo "Cloning foo2 into the end of bar2"
+    $XFS_IO_PROG -c "reflink $SCRATCH_MNT/foo2 0 64K 64K" $SCRATCH_MNT/bar2 \
+        | _filter_xfs_io
+
+    echo "File bar2 digest = $(_md5_checksum $SCRATCH_MNT/bar2)"
+
+    # File bar3 has a regular extent of 128K and a file size of 128K too.
+    echo "Creating file bar3"
+    $XFS_IO_PROG -f -c "pwrite -S 0xcd 0 128K" $SCRATCH_MNT/bar3 \
+        | _filter_xfs_io
+
+    echo "Cloning foo2 into the middle of bar3"
+    $XFS_IO_PROG -c "reflink $SCRATCH_MNT/foo2 0 64K 64K" $SCRATCH_MNT/bar3 \
+        | _filter_xfs_io
+
+    echo "File bar3 digest = $(_md5_checksum $SCRATCH_MNT/bar3)"
+
+    # File bar4 has a 64K hole at offset 0 followed by a 64K regular extent, and
+    # a file size of 128K.
+    echo "Creating file bar4"
+    $XFS_IO_PROG -f -c "pwrite -S 0xcd 64K 64K" $SCRATCH_MNT/bar4 | _filter_xfs_io
+
+    echo "Cloning foo1 into bar4"
+    $XFS_IO_PROG -c "reflink $SCRATCH_MNT/foo1 0 0 128K" $SCRATCH_MNT/bar4 \
+        | _filter_xfs_io
+
+    echo "File bar4 digest = $(_md5_checksum $SCRATCH_MNT/bar4)"
+
+    # File bar5 has a 1Mb prealloc extent at file offset 0 and a file size of 0.
+    echo "Creating file bar5"
+    $XFS_IO_PROG -f -c "falloc -k 0 1M" $SCRATCH_MNT/bar5
+
+    echo "Cloning foo1 into bar5"
+    $XFS_IO_PROG -c "reflink $SCRATCH_MNT/foo1 0 0 128K" $SCRATCH_MNT/bar5 \
+        | _filter_xfs_io
+
+    echo "File bar5 digest = $(_md5_checksum $SCRATCH_MNT/bar5)"
+
+    # File bar6 has an inline extent encoding 500 bytes of data followed by a
+    # prealloc extent of 1Mb at file offset 4K. The file size is 500 bytes.
+    echo "Creating file bar6"
+    $XFS_IO_PROG -f -c "pwrite -S 0xef 0 500" \
+		 -c "falloc -k 4K 1M" \
+		 $SCRATCH_MNT/bar6 | _filter_xfs_io
+
+    echo "Cloning foo1 into bar6"
+    $XFS_IO_PROG -c "reflink $SCRATCH_MNT/foo1 0 0 128K" $SCRATCH_MNT/bar6 \
+        | _filter_xfs_io
+
+    echo "File bar6 digest = $(_md5_checksum $SCRATCH_MNT/bar6)"
+
+    # Unmount and mount again the filesystem. We want to verify the reflink
+    # operations were durably persisted.
+    _scratch_cycle_mount
+
+    echo "File digests after mounting again the filesystem:"
+    echo "File bar1 digest = $(_md5_checksum $SCRATCH_MNT/bar1)"
+    echo "File bar2 digest = $(_md5_checksum $SCRATCH_MNT/bar2)"
+    echo "File bar3 digest = $(_md5_checksum $SCRATCH_MNT/bar3)"
+    echo "File bar4 digest = $(_md5_checksum $SCRATCH_MNT/bar4)"
+    echo "File bar5 digest = $(_md5_checksum $SCRATCH_MNT/bar5)"
+    echo "File bar6 digest = $(_md5_checksum $SCRATCH_MNT/bar6)"
+}
+
+_scratch_mkfs "-O ^no-holes" >>$seqres.full 2>&1
+_scratch_mount
+
+echo
+echo "Testing with defaults"
+echo
+run_tests
+
+echo
+echo "Testing with -o compress"
+echo
+_scratch_cycle_mount "compress"
+run_tests
+
+echo
+echo "Testing with -o nodatacow"
+echo
+_scratch_cycle_mount "nodatacow"
+run_tests
+
+echo
+echo "Testing with -O no-holes"
+echo
+_scratch_unmount
+_scratch_mkfs "-O no-holes" >>$seqres.full 2>&1
+_scratch_mount
+run_tests
+
+status=0
+exit
diff --git a/tests/btrfs/205.out b/tests/btrfs/205.out
new file mode 100644
index 00000000..948e0634
--- /dev/null
+++ b/tests/btrfs/205.out
@@ -0,0 +1,241 @@
+QA output created by 205
+
+Testing with defaults
+
+Creating file foo1
+wrote 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 126976/126976 bytes at offset 4096
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Creating file bar1
+wrote 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Cloning foo1 into the end of bar1
+linked 131072/131072 bytes at offset 131072
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File bar1 digest = e9d03fb5fff30baf3c709f2384dfde67
+Creating file foo2
+wrote 1000/1000 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 61440/61440 bytes at offset 4096
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Creating file bar2
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Cloning foo2 into the end of bar2
+linked 65536/65536 bytes at offset 65536
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File bar2 digest = 85678cf32ed48f92ca42ad06d0b63f2a
+Creating file bar3
+wrote 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Cloning foo2 into the middle of bar3
+linked 65536/65536 bytes at offset 65536
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File bar3 digest = 85678cf32ed48f92ca42ad06d0b63f2a
+Creating file bar4
+wrote 65536/65536 bytes at offset 65536
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Cloning foo1 into bar4
+linked 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File bar4 digest = 4b48829714d20a4e73a0cf1565270076
+Creating file bar5
+Cloning foo1 into bar5
+linked 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File bar5 digest = 4b48829714d20a4e73a0cf1565270076
+Creating file bar6
+wrote 500/500 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Cloning foo1 into bar6
+linked 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File bar6 digest = 4b48829714d20a4e73a0cf1565270076
+File digests after mounting again the filesystem:
+File bar1 digest = e9d03fb5fff30baf3c709f2384dfde67
+File bar2 digest = 85678cf32ed48f92ca42ad06d0b63f2a
+File bar3 digest = 85678cf32ed48f92ca42ad06d0b63f2a
+File bar4 digest = 4b48829714d20a4e73a0cf1565270076
+File bar5 digest = 4b48829714d20a4e73a0cf1565270076
+File bar6 digest = 4b48829714d20a4e73a0cf1565270076
+
+Testing with -o compress
+
+Creating file foo1
+wrote 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 126976/126976 bytes at offset 4096
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Creating file bar1
+wrote 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Cloning foo1 into the end of bar1
+linked 131072/131072 bytes at offset 131072
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File bar1 digest = e9d03fb5fff30baf3c709f2384dfde67
+Creating file foo2
+wrote 1000/1000 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 61440/61440 bytes at offset 4096
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Creating file bar2
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Cloning foo2 into the end of bar2
+linked 65536/65536 bytes at offset 65536
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File bar2 digest = 85678cf32ed48f92ca42ad06d0b63f2a
+Creating file bar3
+wrote 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Cloning foo2 into the middle of bar3
+linked 65536/65536 bytes at offset 65536
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File bar3 digest = 85678cf32ed48f92ca42ad06d0b63f2a
+Creating file bar4
+wrote 65536/65536 bytes at offset 65536
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Cloning foo1 into bar4
+linked 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File bar4 digest = 4b48829714d20a4e73a0cf1565270076
+Creating file bar5
+Cloning foo1 into bar5
+linked 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File bar5 digest = 4b48829714d20a4e73a0cf1565270076
+Creating file bar6
+wrote 500/500 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Cloning foo1 into bar6
+linked 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File bar6 digest = 4b48829714d20a4e73a0cf1565270076
+File digests after mounting again the filesystem:
+File bar1 digest = e9d03fb5fff30baf3c709f2384dfde67
+File bar2 digest = 85678cf32ed48f92ca42ad06d0b63f2a
+File bar3 digest = 85678cf32ed48f92ca42ad06d0b63f2a
+File bar4 digest = 4b48829714d20a4e73a0cf1565270076
+File bar5 digest = 4b48829714d20a4e73a0cf1565270076
+File bar6 digest = 4b48829714d20a4e73a0cf1565270076
+
+Testing with -o nodatacow
+
+Creating file foo1
+wrote 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 126976/126976 bytes at offset 4096
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Creating file bar1
+wrote 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Cloning foo1 into the end of bar1
+linked 131072/131072 bytes at offset 131072
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File bar1 digest = e9d03fb5fff30baf3c709f2384dfde67
+Creating file foo2
+wrote 1000/1000 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 61440/61440 bytes at offset 4096
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Creating file bar2
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Cloning foo2 into the end of bar2
+linked 65536/65536 bytes at offset 65536
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File bar2 digest = 85678cf32ed48f92ca42ad06d0b63f2a
+Creating file bar3
+wrote 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Cloning foo2 into the middle of bar3
+linked 65536/65536 bytes at offset 65536
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File bar3 digest = 85678cf32ed48f92ca42ad06d0b63f2a
+Creating file bar4
+wrote 65536/65536 bytes at offset 65536
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Cloning foo1 into bar4
+linked 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File bar4 digest = 4b48829714d20a4e73a0cf1565270076
+Creating file bar5
+Cloning foo1 into bar5
+linked 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File bar5 digest = 4b48829714d20a4e73a0cf1565270076
+Creating file bar6
+wrote 500/500 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Cloning foo1 into bar6
+linked 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File bar6 digest = 4b48829714d20a4e73a0cf1565270076
+File digests after mounting again the filesystem:
+File bar1 digest = e9d03fb5fff30baf3c709f2384dfde67
+File bar2 digest = 85678cf32ed48f92ca42ad06d0b63f2a
+File bar3 digest = 85678cf32ed48f92ca42ad06d0b63f2a
+File bar4 digest = 4b48829714d20a4e73a0cf1565270076
+File bar5 digest = 4b48829714d20a4e73a0cf1565270076
+File bar6 digest = 4b48829714d20a4e73a0cf1565270076
+
+Testing with -O no-holes
+
+Creating file foo1
+wrote 4096/4096 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 126976/126976 bytes at offset 4096
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Creating file bar1
+wrote 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Cloning foo1 into the end of bar1
+linked 131072/131072 bytes at offset 131072
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File bar1 digest = e9d03fb5fff30baf3c709f2384dfde67
+Creating file foo2
+wrote 1000/1000 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 61440/61440 bytes at offset 4096
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Creating file bar2
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Cloning foo2 into the end of bar2
+linked 65536/65536 bytes at offset 65536
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File bar2 digest = 85678cf32ed48f92ca42ad06d0b63f2a
+Creating file bar3
+wrote 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Cloning foo2 into the middle of bar3
+linked 65536/65536 bytes at offset 65536
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File bar3 digest = 85678cf32ed48f92ca42ad06d0b63f2a
+Creating file bar4
+wrote 65536/65536 bytes at offset 65536
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Cloning foo1 into bar4
+linked 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File bar4 digest = 4b48829714d20a4e73a0cf1565270076
+Creating file bar5
+Cloning foo1 into bar5
+linked 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File bar5 digest = 4b48829714d20a4e73a0cf1565270076
+Creating file bar6
+wrote 500/500 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Cloning foo1 into bar6
+linked 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File bar6 digest = 4b48829714d20a4e73a0cf1565270076
+File digests after mounting again the filesystem:
+File bar1 digest = e9d03fb5fff30baf3c709f2384dfde67
+File bar2 digest = 85678cf32ed48f92ca42ad06d0b63f2a
+File bar3 digest = 85678cf32ed48f92ca42ad06d0b63f2a
+File bar4 digest = 4b48829714d20a4e73a0cf1565270076
+File bar5 digest = 4b48829714d20a4e73a0cf1565270076
+File bar6 digest = 4b48829714d20a4e73a0cf1565270076
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 79893747..0e77dbaa 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -207,3 +207,4 @@
 202 auto quick subvol snapshot
 203 auto quick send clone
 204 auto quick punch
+205 auto quick clone compress
-- 
2.25.0

