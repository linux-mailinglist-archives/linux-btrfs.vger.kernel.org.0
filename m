Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC1F68BE59
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Aug 2019 18:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbfHMQXE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Aug 2019 12:23:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728084AbfHMQXE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Aug 2019 12:23:04 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B64A220679;
        Tue, 13 Aug 2019 16:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565713382;
        bh=alElVBkrIUOF2kRKmY3/xVFEcXm2Lj9vXtwDyLj/HqA=;
        h=From:To:Cc:Subject:Date:From;
        b=WYCKdDyZE26I7s1HZWqIW8rcgwfkHI9QlR4DUrZ3/syqmnDVgXnDqjH2k4UIiVLzw
         hPn/2ktjiHd4bIpatZm5Y9kAeMmuE304cFhBa7OLZ3g9BrasYNbtFj+ejvweiSeMkA
         EGTS3Luvb3tbFz0nEZQm9lkMa0PEoWLyw4qXwTmo=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] generic/517: make test work on filesystems with block size greater than 4Kb
Date:   Tue, 13 Aug 2019 17:22:55 +0100
Message-Id: <20190813162255.1841-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The test currently fails on filesystems with a block size greater than 4Kb,
as dedupe operations fail with -EINVAL because the file offsets used are
not multiples of such block sizes (but they are multiples of 4Kb, 2Kb and
1Kb).

So update the test to use offsets that are multiples of 64Kb, since that
allows the test to work on filesystems with any block size between 4Kb and
64Kb (8Kb, 16Kb, 32Kb). Verified it works as expected on kernels that have
the fixes for the issue tested by this test case (listed in the changelog
of commit 91540ef980110f78161893f98d946e2afa0c1f4a), and on systems without
those fixes (a 4.18 kernel), it fails as it is supposed to.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/517     | 30 ++++++++++++++++--------------
 tests/generic/517.out | 42 +++++++++++++++++++++---------------------
 2 files changed, 37 insertions(+), 35 deletions(-)

diff --git a/tests/generic/517 b/tests/generic/517
index 601bb24e..67aec8e6 100755
--- a/tests/generic/517
+++ b/tests/generic/517
@@ -36,28 +36,29 @@ rm -f $seqres.full
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-# The first byte with a value of 0xae starts at an offset (2518890) which is not
-# a multiple of the block size.
+# The first byte with a value of 0xae starts at an offset (512Kb + 100) which is
+# not a multiple of the block size.
 $XFS_IO_PROG -f \
-	-c "pwrite -S 0x6b 0 2518890" \
-	-c "pwrite -S 0xae 2518890 102398" \
+	-c "pwrite -S 0x6b 0 524388" \
+	-c "pwrite -S 0xae 524388 256K" \
 	$SCRATCH_MNT/foo | _filter_xfs_io
 
-# Create a second file with a length not aligned to the block size, whose bytes
-# all have the value 0x6b, so that its extent(s) can be deduplicated with the
-# first file.
-$XFS_IO_PROG -f -c "pwrite -S 0x6b 0 557771" $SCRATCH_MNT/bar | _filter_xfs_io
+# Create a second file with a length not aligned to the block size (128K + 100),
+# whose bytes all have the value 0x6b, so that its extent(s) can be deduplicated
+# with the first file.
+$XFS_IO_PROG -f -c "pwrite -S 0x6b 0 131172" $SCRATCH_MNT/bar | _filter_xfs_io
 
 # The file is filled with bytes having the value 0x6b from offset 0 to offset
-# 2518889 and with the value 0xae from offset 2518890 to offset 2621287.
+# 524388 (512K + 100) and with the value 0xae from offset 524388 to offset
+# 786532 (512K + 100 + 256K).
 echo "File content before first deduplication:"
-od -t x1 $SCRATCH_MNT/foo
+od -A d -t x1 $SCRATCH_MNT/foo
 
 # Now deduplicate the entire second file into a range of the first file that
 # also has all bytes with the value 0x6b. The destination range's end offset
 # must not be aligned to the block size and must be less then the offset of
-# the first byte with the value 0xae (byte at offset 2518890).
-$XFS_IO_PROG -c "dedupe $SCRATCH_MNT/bar 0 1957888 557771" $SCRATCH_MNT/foo \
+# the first byte with the value 0xae (byte at offset 524388).
+$XFS_IO_PROG -c "dedupe $SCRATCH_MNT/bar 0 64K 131172" $SCRATCH_MNT/foo \
 	| _filter_xfs_io
 
 # We should have exactly the same data we had before we asked for deduplication.
@@ -81,8 +82,9 @@ $XFS_IO_PROG -f -c "pwrite -S 0xae 0 100" $SCRATCH_MNT/baz | _filter_xfs_io
 # before.
 _scratch_cycle_mount
 
-# Now attempt to dedupe the single block of baz into foo.
-$XFS_IO_PROG -c "dedupe $SCRATCH_MNT/baz 0 2519040 100" $SCRATCH_MNT/foo \
+# Now attempt to dedupe the single block of baz into foo. The destination range,
+# in file foo, has all bytes with the same value (0xae) as file baz.
+$XFS_IO_PROG -c "dedupe $SCRATCH_MNT/baz 0 640K 100" $SCRATCH_MNT/foo \
     | _filter_xfs_io
 
 # Now attempt to unmount the filesystem before reading from the file. This is
diff --git a/tests/generic/517.out b/tests/generic/517.out
index 137a9719..b9b63207 100644
--- a/tests/generic/517.out
+++ b/tests/generic/517.out
@@ -1,45 +1,45 @@
 QA output created by 517
-wrote 2518890/2518890 bytes at offset 0
+wrote 524388/524388 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 102398/102398 bytes at offset 2518890
+wrote 262144/262144 bytes at offset 524388
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 557771/557771 bytes at offset 0
+wrote 131172/131172 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 File content before first deduplication:
 0000000 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
 *
-11467540 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b ae ae ae ae ae ae
-11467560 ae ae ae ae ae ae ae ae ae ae ae ae ae ae ae ae
+0524384 6b 6b 6b 6b ae ae ae ae ae ae ae ae ae ae ae ae
+0524400 ae ae ae ae ae ae ae ae ae ae ae ae ae ae ae ae
 *
-11777540 ae ae ae ae ae ae ae ae
-11777550
-deduped 557771/557771 bytes at offset 1957888
+0786528 ae ae ae ae
+0786532
+deduped 131172/131172 bytes at offset 65536
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 File content after first deduplication and before unmounting:
 0000000 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
 *
-2518880 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b ae ae ae ae ae ae
-2518896 ae ae ae ae ae ae ae ae ae ae ae ae ae ae ae ae
+0524384 6b 6b 6b 6b ae ae ae ae ae ae ae ae ae ae ae ae
+0524400 ae ae ae ae ae ae ae ae ae ae ae ae ae ae ae ae
 *
-2621280 ae ae ae ae ae ae ae ae
-2621288
+0786528 ae ae ae ae
+0786532
 File content after first unmount:
 0000000 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
 *
-2518880 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b ae ae ae ae ae ae
-2518896 ae ae ae ae ae ae ae ae ae ae ae ae ae ae ae ae
+0524384 6b 6b 6b 6b ae ae ae ae ae ae ae ae ae ae ae ae
+0524400 ae ae ae ae ae ae ae ae ae ae ae ae ae ae ae ae
 *
-2621280 ae ae ae ae ae ae ae ae
-2621288
+0786528 ae ae ae ae
+0786532
 wrote 100/100 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-deduped 100/100 bytes at offset 2519040
+deduped 100/100 bytes at offset 655360
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 File content after second deduplication:
 0000000 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
 *
-2518880 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b ae ae ae ae ae ae
-2518896 ae ae ae ae ae ae ae ae ae ae ae ae ae ae ae ae
+0524384 6b 6b 6b 6b ae ae ae ae ae ae ae ae ae ae ae ae
+0524400 ae ae ae ae ae ae ae ae ae ae ae ae ae ae ae ae
 *
-2621280 ae ae ae ae ae ae ae ae
-2621288
+0786528 ae ae ae ae
+0786532
-- 
2.11.0

