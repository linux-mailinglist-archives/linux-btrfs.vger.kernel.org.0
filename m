Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C53F819F3DA
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Apr 2020 12:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgDFKvk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Apr 2020 06:51:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbgDFKvk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Apr 2020 06:51:40 -0400
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 305D620678;
        Mon,  6 Apr 2020 10:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586170298;
        bh=Ca5AY7KsqNITjQOHY21bYkfRx1xXHnlK/a6mqp/qpPc=;
        h=From:To:Cc:Subject:Date:From;
        b=Geg0e20D/JSBdo5V153kYXLMr87UvS44iarqoy/JFYyz3KXc0+0YB0vPMowS1fcsk
         pfu6vDdgb3DeBcu+zuq8008+IQvkfJO62Zso7ZIi6HWlrCBtq7lZgfEc/otF048GyH
         q9ca+ppsgrP4bRwMgzCA/8agx6Mmr56JF/LjqD8g=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: check that cloning an inline extent does not lead to data loss
Date:   Mon,  6 Apr 2020 11:51:34 +0100
Message-Id: <20200406105134.2233-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

We have a bug in the current kernel merge window (for 5.7) that results
in data loss when cloning an inline extent into a new file (or an empty
file. This change adds a test for such case into the existing test case
btrfs/205, because it's the test case that tests all the supported
scenarios for cloning inline extents in btrfs.

The btrfs patch for the linux kernel that fixes the regression has the
following sibject:

  "Btrfs: fix lost i_size update after cloning inline extent"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/205     | 13 +++++++++++++
 tests/btrfs/205.out | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/tests/btrfs/205 b/tests/btrfs/205
index 9bec2bfa..66355678 100755
--- a/tests/btrfs/205
+++ b/tests/btrfs/205
@@ -128,6 +128,18 @@ run_tests()
 
     echo "File bar6 digest = $(_md5_checksum $SCRATCH_MNT/bar6)"
 
+    # File foo3 a single inline extent of 500 bytes.
+    echo "Creating file foo3"
+    $XFS_IO_PROG -f -c "pwrite -S 0xbf 0 500" $SCRATCH_MNT/foo3 | _filter_xfs_io
+
+    # File bar7 is an empty file, has no extents.
+    touch $SCRATCH_MNT/bar7
+
+    echo "Cloning foo3 into bar7"
+    $XFS_IO_PROG -c "reflink $SCRATCH_MNT/foo3" $SCRATCH_MNT/bar7 | _filter_xfs_io
+
+    echo "File bar7 digest = $(_md5_checksum $SCRATCH_MNT/bar7)"
+
     # Unmount and mount again the filesystem. We want to verify the reflink
     # operations were durably persisted.
     _scratch_cycle_mount
@@ -139,6 +151,7 @@ run_tests()
     echo "File bar4 digest = $(_md5_checksum $SCRATCH_MNT/bar4)"
     echo "File bar5 digest = $(_md5_checksum $SCRATCH_MNT/bar5)"
     echo "File bar6 digest = $(_md5_checksum $SCRATCH_MNT/bar6)"
+    echo "File bar7 digest = $(_md5_checksum $SCRATCH_MNT/bar7)"
 }
 
 _scratch_mkfs "-O ^no-holes" >>$seqres.full 2>&1
diff --git a/tests/btrfs/205.out b/tests/btrfs/205.out
index 948e0634..d9932fc0 100644
--- a/tests/btrfs/205.out
+++ b/tests/btrfs/205.out
@@ -52,6 +52,13 @@ Cloning foo1 into bar6
 linked 131072/131072 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 File bar6 digest = 4b48829714d20a4e73a0cf1565270076
+Creating file foo3
+wrote 500/500 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Cloning foo3 into bar7
+linked 0/0 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File bar7 digest = 67679afda6f846539ca7138452de0171
 File digests after mounting again the filesystem:
 File bar1 digest = e9d03fb5fff30baf3c709f2384dfde67
 File bar2 digest = 85678cf32ed48f92ca42ad06d0b63f2a
@@ -59,6 +66,7 @@ File bar3 digest = 85678cf32ed48f92ca42ad06d0b63f2a
 File bar4 digest = 4b48829714d20a4e73a0cf1565270076
 File bar5 digest = 4b48829714d20a4e73a0cf1565270076
 File bar6 digest = 4b48829714d20a4e73a0cf1565270076
+File bar7 digest = 67679afda6f846539ca7138452de0171
 
 Testing with -o compress
 
@@ -112,6 +120,13 @@ Cloning foo1 into bar6
 linked 131072/131072 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 File bar6 digest = 4b48829714d20a4e73a0cf1565270076
+Creating file foo3
+wrote 500/500 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Cloning foo3 into bar7
+linked 0/0 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File bar7 digest = 67679afda6f846539ca7138452de0171
 File digests after mounting again the filesystem:
 File bar1 digest = e9d03fb5fff30baf3c709f2384dfde67
 File bar2 digest = 85678cf32ed48f92ca42ad06d0b63f2a
@@ -119,6 +134,7 @@ File bar3 digest = 85678cf32ed48f92ca42ad06d0b63f2a
 File bar4 digest = 4b48829714d20a4e73a0cf1565270076
 File bar5 digest = 4b48829714d20a4e73a0cf1565270076
 File bar6 digest = 4b48829714d20a4e73a0cf1565270076
+File bar7 digest = 67679afda6f846539ca7138452de0171
 
 Testing with -o nodatacow
 
@@ -172,6 +188,13 @@ Cloning foo1 into bar6
 linked 131072/131072 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 File bar6 digest = 4b48829714d20a4e73a0cf1565270076
+Creating file foo3
+wrote 500/500 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Cloning foo3 into bar7
+linked 0/0 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File bar7 digest = 67679afda6f846539ca7138452de0171
 File digests after mounting again the filesystem:
 File bar1 digest = e9d03fb5fff30baf3c709f2384dfde67
 File bar2 digest = 85678cf32ed48f92ca42ad06d0b63f2a
@@ -179,6 +202,7 @@ File bar3 digest = 85678cf32ed48f92ca42ad06d0b63f2a
 File bar4 digest = 4b48829714d20a4e73a0cf1565270076
 File bar5 digest = 4b48829714d20a4e73a0cf1565270076
 File bar6 digest = 4b48829714d20a4e73a0cf1565270076
+File bar7 digest = 67679afda6f846539ca7138452de0171
 
 Testing with -O no-holes
 
@@ -232,6 +256,13 @@ Cloning foo1 into bar6
 linked 131072/131072 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 File bar6 digest = 4b48829714d20a4e73a0cf1565270076
+Creating file foo3
+wrote 500/500 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Cloning foo3 into bar7
+linked 0/0 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+File bar7 digest = 67679afda6f846539ca7138452de0171
 File digests after mounting again the filesystem:
 File bar1 digest = e9d03fb5fff30baf3c709f2384dfde67
 File bar2 digest = 85678cf32ed48f92ca42ad06d0b63f2a
@@ -239,3 +270,4 @@ File bar3 digest = 85678cf32ed48f92ca42ad06d0b63f2a
 File bar4 digest = 4b48829714d20a4e73a0cf1565270076
 File bar5 digest = 4b48829714d20a4e73a0cf1565270076
 File bar6 digest = 4b48829714d20a4e73a0cf1565270076
+File bar7 digest = 67679afda6f846539ca7138452de0171
-- 
2.11.0

