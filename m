Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1A14130F8C
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2020 10:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgAFJee (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 04:34:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:33084 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgAFJee (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jan 2020 04:34:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 750BEAD48;
        Mon,  6 Jan 2020 09:34:32 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH] fstests: btrfs/172: Remove the dead test which we have no plan to fix
Date:   Mon,  6 Jan 2020 17:34:27 +0800
Message-Id: <20200106093427.21029-1-wqu@suse.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is no plan to fix it yet, so remove it.

Cc: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/172     | 73 ---------------------------------------------
 tests/btrfs/172.out |  2 --
 tests/btrfs/group   |  1 -
 3 files changed, 76 deletions(-)
 delete mode 100755 tests/btrfs/172
 delete mode 100644 tests/btrfs/172.out

diff --git a/tests/btrfs/172 b/tests/btrfs/172
deleted file mode 100755
index 0dffb2dff40b..000000000000
--- a/tests/btrfs/172
+++ /dev/null
@@ -1,73 +0,0 @@
-#! /bin/bash
-# SPDX-License-Identifier: GPL-2.0
-# Copyright (c) 2018 Oracle. All Rights Reserved.
-#
-# FS QA Test 172
-#
-# Test if the unaligned (by size and offset) punch hole is successful when FS
-# is at ENOSPC.
-#
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
-
-here=`pwd`
-tmp=/tmp/$$
-status=1	# failure is the default!
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
-_cleanup()
-{
-	cd /
-	rm -f $tmp.*
-}
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-
-# remove previous $seqres.full before test
-rm -f $seqres.full
-
-# real QA test starts here
-
-# Modify as appropriate.
-_supported_fs btrfs
-_supported_os Linux
-_require_scratch
-_require_xfs_io_command "fpunch"
-
-_scratch_mkfs_sized $((256 * 1024 *1024)) >> $seqres.full
-
-# max_inline ensures data is not inlined within metadata extents
-_scratch_mount "-o max_inline=0,nodatacow"
-
-cat /proc/self/mounts | grep $SCRATCH_DEV >> $seqres.full
-$BTRFS_UTIL_PROG filesystem df $SCRATCH_MNT >> $seqres.full
-
-extent_size=$(_scratch_btrfs_sectorsize)
-unalign_by=512
-echo extent_size=$extent_size unalign_by=$unalign_by >> $seqres.full
-
-$XFS_IO_PROG -f -c "pwrite -S 0xab 0 $((extent_size * 10))" \
-					$SCRATCH_MNT/testfile >> $seqres.full
-
-echo "Fill all space available for data and all unallocated space." >> $seqres.full
-dd status=none if=/dev/zero of=$SCRATCH_MNT/filler bs=512 >> $seqres.full 2>&1
-
-hole_offset=0
-hole_len=$unalign_by
-$XFS_IO_PROG -c "fpunch $hole_offset $hole_len" $SCRATCH_MNT/testfile
-
-hole_offset=$(($extent_size + $unalign_by))
-hole_len=$(($extent_size - $unalign_by))
-$XFS_IO_PROG -c "fpunch $hole_offset $hole_len" $SCRATCH_MNT/testfile
-
-hole_offset=$(($extent_size * 2 + $unalign_by))
-hole_len=$(($extent_size * 5))
-$XFS_IO_PROG -c "fpunch $hole_offset $hole_len" $SCRATCH_MNT/testfile
-
-# success, all done
-echo "Silence is golden"
-status=0
-exit
diff --git a/tests/btrfs/172.out b/tests/btrfs/172.out
deleted file mode 100644
index ce2de3f0d107..000000000000
--- a/tests/btrfs/172.out
+++ /dev/null
@@ -1,2 +0,0 @@
-QA output created by 172
-Silence is golden
diff --git a/tests/btrfs/group b/tests/btrfs/group
index d7eeb45d3bc4..ed971bae493c 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -174,7 +174,6 @@
 169 auto quick send
 170 auto quick snapshot
 171 auto quick qgroup
-172 auto quick punch
 173 auto quick swap
 174 auto quick swap
 175 auto quick swap volume
-- 
2.24.1

