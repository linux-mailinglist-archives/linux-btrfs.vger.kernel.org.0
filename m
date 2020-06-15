Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C200B1F9ED8
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jun 2020 19:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731208AbgFORuf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jun 2020 13:50:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728585AbgFORuf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jun 2020 13:50:35 -0400
Received: from debian8.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD2CF20679;
        Mon, 15 Jun 2020 17:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592243434;
        bh=oF9T3WX20U4gIU/vCnvsQ6/wJMcZdnBsn8YMMAZrm34=;
        h=From:To:Cc:Subject:Date:From;
        b=PC5hwJTh1jgI/pbSnapPDB3+vLh34S+J0lSKPDdW4e3qXMkLT/eo+lOlxZycnJQe6
         EYdDQlRHrt65+ZwUznEdIK3ou0GLnAyBzZp1VqLttfeBNZgFK2Ib3otamNX+vJj5ER
         aL8Nv9PDbDNr2sbHclQCGO0Ix/Z7L+D0v2UC1/rM=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: test creating a snapshot after RWF_NOWAIT write works as expected
Date:   Mon, 15 Jun 2020 18:50:28 +0100
Message-Id: <20200615175028.15090-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test that creating a snapshot after writing to a file using a RWF_NOWAIT
works, does not hang the snapshot creation task, and we are able to read
the data after.

Currently btrfs hangs when creating the snapshot due to a missing unlock
of a snapshot lock, but it is fixed by a patch with the following subject:

  "btrfs: fix hang on snapshot creation after RWF_NOWAIT write"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/214     | 66 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/214.out | 14 ++++++++++
 tests/btrfs/group   |  1 +
 3 files changed, 81 insertions(+)
 create mode 100755 tests/btrfs/214
 create mode 100644 tests/btrfs/214.out

diff --git a/tests/btrfs/214 b/tests/btrfs/214
new file mode 100755
index 00000000..c835e844
--- /dev/null
+++ b/tests/btrfs/214
@@ -0,0 +1,66 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FSQA Test No. 214
+#
+# Test that creating a snapshot after writing to a file using a RWF_NOWAIT
+# works, does not hang the snapshot creation task, and we are able to read
+# the data after.
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
+. ./common/attr
+
+# real QA test starts here
+_supported_fs btrfs
+_supported_os Linux
+_require_scratch
+_require_odirect
+_require_xfs_io_command pwrite -N
+_require_chattr C
+
+rm -f $seqres.full
+
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+# RWF_NOWAIT writes require NOCOW
+touch $SCRATCH_MNT/f
+$CHATTR_PROG +C $SCRATCH_MNT/f
+
+$XFS_IO_PROG -d -c "pwrite -S 0xab 0 64K" $SCRATCH_MNT/f | _filter_xfs_io
+
+# Now do a WEF_WRITE into a range containing a NOCOWable extent.
+$XFS_IO_PROG -d -c "pwrite -N -V 1 -S 0xfe 0 64K" $SCRATCH_MNT/f \
+	| _filter_xfs_io
+
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap \
+	| _filter_scratch
+
+# Unmount, mount again and verify the file in the subvolume and snapshot has
+# the correct data.
+_scratch_cycle_mount
+
+echo "File data in the subvolume:"
+od -A d -t x1 $SCRATCH_MNT/f
+
+echo "File data in the snapshot:"
+od -A d -t x1 $SCRATCH_MNT/snap/f
+
+status=0
+exit
diff --git a/tests/btrfs/214.out b/tests/btrfs/214.out
new file mode 100644
index 00000000..6cc66972
--- /dev/null
+++ b/tests/btrfs/214.out
@@ -0,0 +1,14 @@
+QA output created by 214
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap'
+File data in the subvolume:
+0000000 fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
+*
+0065536
+File data in the snapshot:
+0000000 fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
+*
+0065536
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 9e48ecc1..a3706e7d 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -216,3 +216,4 @@
 211 auto quick log prealloc
 212 auto balance dangerous
 213 auto balance dangerous
+214 auto quick snapshot
-- 
2.26.2

