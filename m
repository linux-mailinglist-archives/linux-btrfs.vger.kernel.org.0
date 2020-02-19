Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2440C164654
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2020 15:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgBSOGe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Feb 2020 09:06:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:46498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727597AbgBSOGe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Feb 2020 09:06:34 -0500
Received: from debian5.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A4D524656;
        Wed, 19 Feb 2020 14:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582121193;
        bh=XARpIrS6yltExNqzaLJ4ZG7/Iep+jv1FVoBu4F/X70Q=;
        h=From:To:Cc:Subject:Date:From;
        b=1EPMnYBNQr60LA9NItAnb48BUGjK6BK/mP7Y553r54nDuZ1KNQLHvr4+ZbmsXSwgL
         WA+nEcdZPXJxYJTrBcATTNz/NDdGdM+sXmoFg/81aGO+mwt/L8YXV4/0GJuRL/DVO0
         vOHxruBm6Zqt3KnN4Z3Hk9cIpx1uXtXB0xC/I4ww=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 1/2] btrfs/112: remove some tests for cloning inline extents
Date:   Wed, 19 Feb 2020 14:06:27 +0000
Message-Id: <20200219140627.1641733-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

This test case, btrfs/112, tests that some clone operations that have a
range covering inline extents fail with either -EOPNOTSUPP or -EINVAL.
These cases were unsupported on btrfs because they used to lead to file
corruptions and were not trivial to implement.

But there's now a patchset that adds support for them, and the relevant
patch of that patchset has the following subject:

  "Btrfs: implement full reflink support for inline extents"

So just remove these tests from test case btrfs/112, since this test
case is about testing only the unsupported reflink operations. A new
test case that verifies that these cases now work, as long as some other
new cases, will follow in another patch.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/112     | 31 -----------------------------
 tests/btrfs/112.out | 48 ---------------------------------------------
 2 files changed, 79 deletions(-)

diff --git a/tests/btrfs/112 b/tests/btrfs/112
index e4e9d322..13c19863 100755
--- a/tests/btrfs/112
+++ b/tests/btrfs/112
@@ -83,22 +83,6 @@ test_cloning_inline_extents()
 	od -t x1 $SCRATCH_MNT/foo2
 	$XFS_IO_PROG -c "pwrite -S 0xee 0 90" $SCRATCH_MNT/foo2 | _filter_xfs_io
 
-	# Test cloning the inline extent against a file which has a size of zero
-	# but has a prealloc extent. It should not be possible as well to clone
-	# the inline extent from file bar into this file.
-	$XFS_IO_PROG -f -c "falloc -k 0 1M" $SCRATCH_MNT/foo3 | _filter_xfs_io
-	$CLONER_PROG -s 0 -d 0 -l 0 $SCRATCH_MNT/bar $SCRATCH_MNT/foo3 \
-		| _filter_btrfs_cloner_error
-
-	# Doing IO against any range in the first 4K of the file should work.
-	# Due to a past clone ioctl bug which allowed cloning the inline extent,
-	# these operations resulted in EIO errors.
-	echo "First 50 bytes of foo3 after clone operation:"
-	# Should not be able to read any bytes, file has 0 bytes i_size (the
-	# clone operation failed and did not modify our file).
-	od -t x1 $SCRATCH_MNT/foo3
-	$XFS_IO_PROG -c "pwrite -S 0xff 0 90" $SCRATCH_MNT/foo3 | _filter_xfs_io
-
 	# Test cloning the inline extent against a file which consists of a
 	# single inline extent that has a size not greater than the size of
 	# bar's inline extent (40 < 50).
@@ -157,21 +141,6 @@ test_cloning_inline_extents()
 	# Must have a size of 50 bytes, with all bytes having a value of 0xbb.
 	od -t x1 $SCRATCH_MNT/foo7
 
-	# Test cloning the inline extent against a file which has a size not
-	# greater than the size of bar's inline extent (20 < 50) but has
-	# a prealloc extent that goes beyond the file's size. It should not be
-	# possible to clone the inline extent from bar into this file.
-	$XFS_IO_PROG -f -c "falloc -k 0 1M" \
-			-c "pwrite -S 0x88 0 20" \
-			$SCRATCH_MNT/foo8 | _filter_xfs_io
-	$CLONER_PROG -s 0 -d 0 -l 0 $SCRATCH_MNT/bar $SCRATCH_MNT/foo8 \
-		| _filter_btrfs_cloner_error
-
-	echo "File foo8 data after clone operation:"
-	# Must have a size of 20 bytes, with all bytes having a value of 0x88
-	# (the clone operation did not modify our file).
-	od -t x1 $SCRATCH_MNT/foo8
-
 	_scratch_unmount
 }
 
diff --git a/tests/btrfs/112.out b/tests/btrfs/112.out
index 3a95e14d..8c26d758 100644
--- a/tests/btrfs/112.out
+++ b/tests/btrfs/112.out
@@ -24,11 +24,6 @@ File foo2 data after clone operation:
 0040000
 wrote 90/90 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-clone failed: Invalid argument
-First 50 bytes of foo3 after clone operation:
-0000000
-wrote 90/90 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 40/40 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 File foo4 data after clone operation:
@@ -56,13 +51,6 @@ File foo7 data after clone operation:
 *
 0000060 bb bb
 0000062
-wrote 20/20 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-clone failed: Invalid argument
-File foo8 data after clone operation:
-0000000 88 88 88 88 88 88 88 88 88 88 88 88 88 88 88 88
-0000020 88 88 88 88
-0000024
 
 Testing with compression and without the no-holes feature...
 
@@ -88,11 +76,6 @@ File foo2 data after clone operation:
 0040000
 wrote 90/90 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-clone failed: Invalid argument
-First 50 bytes of foo3 after clone operation:
-0000000
-wrote 90/90 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 40/40 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 File foo4 data after clone operation:
@@ -120,13 +103,6 @@ File foo7 data after clone operation:
 *
 0000060 bb bb
 0000062
-wrote 20/20 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-clone failed: Invalid argument
-File foo8 data after clone operation:
-0000000 88 88 88 88 88 88 88 88 88 88 88 88 88 88 88 88
-0000020 88 88 88 88
-0000024
 
 Testing without compression and with the no-holes feature...
 
@@ -152,11 +128,6 @@ File foo2 data after clone operation:
 0040000
 wrote 90/90 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-clone failed: Invalid argument
-First 50 bytes of foo3 after clone operation:
-0000000
-wrote 90/90 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 40/40 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 File foo4 data after clone operation:
@@ -184,13 +155,6 @@ File foo7 data after clone operation:
 *
 0000060 bb bb
 0000062
-wrote 20/20 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-clone failed: Invalid argument
-File foo8 data after clone operation:
-0000000 88 88 88 88 88 88 88 88 88 88 88 88 88 88 88 88
-0000020 88 88 88 88
-0000024
 
 Testing with compression and with the no-holes feature...
 
@@ -216,11 +180,6 @@ File foo2 data after clone operation:
 0040000
 wrote 90/90 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-clone failed: Invalid argument
-First 50 bytes of foo3 after clone operation:
-0000000
-wrote 90/90 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 40/40 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 File foo4 data after clone operation:
@@ -248,10 +207,3 @@ File foo7 data after clone operation:
 *
 0000060 bb bb
 0000062
-wrote 20/20 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-clone failed: Invalid argument
-File foo8 data after clone operation:
-0000000 88 88 88 88 88 88 88 88 88 88 88 88 88 88 88 88
-0000020 88 88 88 88
-0000024
-- 
2.25.0

