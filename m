Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3BD492B62
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jan 2022 17:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243692AbiARQhO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jan 2022 11:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbiARQhN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jan 2022 11:37:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F65C061574;
        Tue, 18 Jan 2022 08:37:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 240AAB8159B;
        Tue, 18 Jan 2022 16:37:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138B0C00446;
        Tue, 18 Jan 2022 16:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642523829;
        bh=7vBIfCRGD4nvvRzouS6AWiwjrxq4BzOerThPrkV3d6s=;
        h=From:To:Cc:Subject:Date:From;
        b=pKiFTLhadW3asN8mdZlTTOcjocq32Rqq6tHTuQ5nClOnkFu9p1vp5tNoBxgZcGj8z
         xVy7m0NAe5IG2FBV2LBBXg5Cgdszs5gnxklX8PBl9NntCU6ok/Soq+cr+HVE7sfNK1
         1aIrrSRR2sLfagxzIiyISmfkxy1Vi+lbh2o/WdaMiqX1r0Jl7PUjUS6qqkuxS8KlNe
         TUgd+qHSz8w9+esddKS630d3l28ggGljAX6KfiPb6ueJGDenVwojIrvdBXJgAbcizK
         AThkvnFjb9aoEXGDaEJrbeUJWuNyvINUGVU6J5+9iOCjUJqwwBtGZBp88SJxbKNIhi
         IcIhcrCsdQJ0Q==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: test that defrag on small files does not hang or crashes
Date:   Tue, 18 Jan 2022 16:36:52 +0000
Message-Id: <8859990e4cd23070653bfe793960f25be3fbd387.1642523738.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Test that defragging files with very small sizes works and does not
result in any crash, hang or corruption.

This is motivated by a regression introduced in kernel 5.16 where
attempting to defrag a file with a size of 1 byte would result in
the kernel code hitting an "infinite" loop (iterating from 0 to
(u64)-1 in increments of 256K, which in practice is an eternity).

The regression is fixed by a patch with the following subject:

  "btrfs: fix too long loop when defragging a 1 byte file"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/255     | 64 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/255.out |  3 +++
 2 files changed, 67 insertions(+)
 create mode 100755 tests/btrfs/255
 create mode 100644 tests/btrfs/255.out

diff --git a/tests/btrfs/255 b/tests/btrfs/255
new file mode 100755
index 00000000..55b11145
--- /dev/null
+++ b/tests/btrfs/255
@@ -0,0 +1,64 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test No. 255
+#
+# Test that defragging files with very small sizes works and does not result in
+# any crash, hang or corruption.
+#
+. ./common/preamble
+_begin_fstest auto quick defrag
+
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.*
+}
+
+# Import common functions.
+. ./common/filter
+
+# real QA test starts here
+
+_supported_fs btrfs
+_require_scratch
+_require_fssum
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+
+checksums_file="$TEST_DIR/btrfs-test-$seq-checksums"
+block_size=$(_get_block_size "$SCRATCH_MNT")
+
+# Test file sizes of 0, 1, 512, 1K, 2K, 4K, 8K, 16K, 32K and 64K bytes.
+file_sizes=( 0 1 512 1024 2048 4096 8192 16384 32768 65536 )
+
+# Create the files and compute their checksums.
+for sz in ${file_sizes[@]}; do
+	byte=$(printf "0x%x" $((RANDOM % 255)))
+	$XFS_IO_PROG -f -c "pwrite -S $byte 0 $sz" "$SCRATCH_MNT/f_$sz" >> $seqres.full
+done
+
+# Compute the checksums.
+$FSSUM_PROG -A -f -w "$checksums_file" "$SCRATCH_MNT"
+
+# Now defrag each file.
+for sz in ${file_sizes[@]}; do
+	echo "Defragging file with $sz bytes..." >> $seqres.full
+	$BTRFS_UTIL_PROG filesystem defragment "$SCRATCH_MNT/f_$sz"
+done
+
+# Verify the checksums after the defrag operations.
+$FSSUM_PROG -r "$checksums_file" "$SCRATCH_MNT"
+
+# Unmount and mount again, this clears the page cache and we want to see that
+# no corruptions were persisted.
+_scratch_cycle_mount
+
+# Verify the checksums again.
+$FSSUM_PROG -r "$checksums_file" "$SCRATCH_MNT"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/255.out b/tests/btrfs/255.out
new file mode 100644
index 00000000..9b1db997
--- /dev/null
+++ b/tests/btrfs/255.out
@@ -0,0 +1,3 @@
+QA output created by 255
+OK
+OK
-- 
2.33.0

