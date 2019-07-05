Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8241B60541
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2019 13:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfGEL01 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Jul 2019 07:26:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbfGEL01 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 5 Jul 2019 07:26:27 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E763B21852;
        Fri,  5 Jul 2019 11:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562325986;
        bh=hZwBWuq3kJU0Goy/sqWl63lGwWjaKqG3XOhbCM6rm7Y=;
        h=From:To:Cc:Subject:Date:From;
        b=mAqmiB3xfT7UbXqziykTtp1thAO/O9+JIExr/iQxuwYhn1lqxZ6hQ5VkI8mj/c68Q
         RASjSzxgyEyLuEieu+2Sh+h4gcSixKviYN672Tju31+85jCAtsR1vNrK8IcM+cPKNp
         TMuk7TnLHrLOsUiKvbzMIaPmxQ8X6Ly47ge96n+E=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs/189: make the test work on systems with a page size greater than 4Kb
Date:   Fri,  5 Jul 2019 12:26:21 +0100
Message-Id: <20190705112621.653-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The test currently uses offsets and lengths which are multiples of 4K, but
not multiples of 64K (or any other page size between 4Kb and 64Kb). This
makes the reflink calls fail with -EINVAL because reflink only operates on
ranges that are aligned to the the filesystem's block size.

Fix this by ensuring all ranges passed to the reflink calls are aligned to
64K, so that the test works on any system regardless of its page size.
The test still fails without the corresponding kernel fix applied [1] as
it is supposed to.

[1] 3c850b45110950 ("Btrfs: incremental send, fix emission of invalid clone operations")

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/189     | 10 ++++++----
 tests/btrfs/189.out |  4 ++--
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/tests/btrfs/189 b/tests/btrfs/189
index 5f736d73..7b6a1708 100755
--- a/tests/btrfs/189
+++ b/tests/btrfs/189
@@ -59,20 +59,22 @@ $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 2>&1 \
 
 # Clone part of the extent from a higher offset to a lower offset of the same
 # file.
-$XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 1560K 500K 100K" $SCRATCH_MNT/bar \
+$XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 1600K 640K 128K" $SCRATCH_MNT/bar \
 	| _filter_xfs_io
 
 # Now clone from the previous file, same range, into the middle of another file,
 # such that the end offset at the destination is smaller than the destination's
 # file size.
-$XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 1560K 0 100K" $SCRATCH_MNT/zoo \
+$XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 1600K 0 128K" $SCRATCH_MNT/zoo \
 	| _filter_xfs_io
 
 # Truncate the source file of the previous clone operation to a smaller size,
 # which ends up in the middle of the range of previous clone operation from file
 # bar to file bar. We want to check this doesn't confuse send to issue invalid
-# clone operations.
-$XFS_IO_PROG -c "truncate 550K" $SCRATCH_MNT/bar
+# clone operations. This smaller size must not be aligned to the sector size of
+# the filesystem - the unaligned size is what can cause those invalid clone
+# operations.
+$XFS_IO_PROG -c "truncate 710K" $SCRATCH_MNT/bar
 
 $BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr 2>&1 \
 	| _filter_scratch
diff --git a/tests/btrfs/189.out b/tests/btrfs/189.out
index 0ae3cdce..79c70b03 100644
--- a/tests/btrfs/189.out
+++ b/tests/btrfs/189.out
@@ -9,9 +9,9 @@ wrote 2097152/2097152 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/base'
 At subvol SCRATCH_MNT/base
-linked 102400/102400 bytes at offset 512000
+linked 131072/131072 bytes at offset 655360
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-linked 102400/102400 bytes at offset 0
+linked 131072/131072 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/incr'
 At subvol SCRATCH_MNT/incr
-- 
2.11.0

