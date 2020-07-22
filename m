Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D55D2299D6
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jul 2020 16:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730415AbgGVONC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jul 2020 10:13:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:39290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730346AbgGVONB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jul 2020 10:13:01 -0400
Received: from debian9.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 551BB20709;
        Wed, 22 Jul 2020 14:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595427181;
        bh=o0+62muE4l4OMwWqWg5+LTYrVUUBqVbXd7CzUL/umpw=;
        h=From:To:Cc:Subject:Date:From;
        b=jzw14cghhSTkd4r72cfUwfO6tdSHSdSCZOztkaGjXsrb7pDg4W1buOca5irM3QQTJ
         m8g4UNo3RkQ/2oYN8EOS6H+wdiLvTEyRdyiypkJrhZWjzgQ2wPLDvvHegmbBjMPtXw
         5E/S2+fPq/XYeh7O/xERDjj31OFzTNvqi1zp5tCs=
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Murphy Zhou <jencce.kernel@gmail.com>
Subject: [PATCH] generic/501: make the test work on machines with a non 4K page size
Date:   Wed, 22 Jul 2020 15:12:54 +0100
Message-Id: <20200722141254.19511-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Currently generic/501 fails on machines with a page size different from 4K
(like ppc64le), because the clone operation fails with -EINVAL due to the
fact we pass it an offset that is 4K aligned but not aligned to the page
size of the machine.

The test doesn't actually need offsets and lengths to be 4K aligned, so
just update the test to use offsets and lenghts that work for page size.
Also add a comment mentioning that a file size of at least 16Mb was a
necessary condition to trigger the btrfs bug.

The test is a regression test for a btrfs issue fixed by kernel commit
bd3599a0e142cd ("Btrfs: fix file data corruption after cloning a range
and fsync"), which landed in kernel 4.18.

Since I couldn't compile a 4.17 kernel on debian testing, I tried this
with a 4.18 kernel with that commit reverted, and it fails as expected
on a x86_64 box:

$ ./check generic/501
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 debian9 4.18.0-btrfs-next-64 #1 SMP (...)
MKFS_OPTIONS  -- /dev/sdc
MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

generic/501 1s ... - output mismatch (see .../xfstests/results//generic/501.out.bad)
    --- tests/generic/501.out	2020-07-22 14:50:12.585674202 +0100
    +++ /home/fdmanana/git/hub/xfstests/results//generic/501.out.bad ...
    @@ -2,4 +2,4 @@
     File bar digest before power failure:
     69319d0343ab8f5ea564167da445addc  SCRATCH_MNT/bar
     File bar digest after power failure:
    -69319d0343ab8f5ea564167da445addc  SCRATCH_MNT/bar
    +21de7d7325fe4dae1f3311d5a76f819f  SCRATCH_MNT/bar
    ...
    (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/generic/501.out ...
Ran: generic/501
Failures: generic/501
Failed 1 of 1 tests

Without the commit reverted it passes as expected.

Reported-by: Murphy Zhou <jencce.kernel@gmail.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/501     | 14 ++++++++------
 tests/generic/501.out |  4 ++--
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/tests/generic/501 b/tests/generic/501
index 0d1f6ffe..bf020095 100755
--- a/tests/generic/501
+++ b/tests/generic/501
@@ -42,14 +42,16 @@ _require_metadata_journaling $SCRATCH_DEV
 _init_flakey
 _mount_flakey
 
-$XFS_IO_PROG -f -c "pwrite -S 0x18 9000K 6908K" $SCRATCH_MNT/foo >>$seqres.full
-$XFS_IO_PROG -f -c "pwrite -S 0x20 2572K 156K" $SCRATCH_MNT/bar >>$seqres.full
+# Use file sizes and offsets/lengths for the clone operation that are multiples
+# of 64Kb, so that the test works on machine with any page size.
+$XFS_IO_PROG -f -s -c "pwrite -S 0x18 0 2M" $SCRATCH_MNT/foo >>$seqres.full
+$XFS_IO_PROG -f -s -c "pwrite -S 0x20 0 20M" $SCRATCH_MNT/bar >>$seqres.full
 
 # We clone from file foo into a range of file bar that overlaps the existing
-# extent at file bar. The destination offset of the reflink operation matches
-# the eof position of file bar minus 4Kb.
-$XFS_IO_PROG -c "fsync" \
-	     -c "reflink ${SCRATCH_MNT}/foo 0 2724K 15908K" \
+# extent at file bar. The clone operation must also extend the size of file bar.
+# Note: in order to trigger the original bug on btrfs, the destination file size
+# must be at least 16Mb and the destination file must have been fsynced before.
+$XFS_IO_PROG -c "reflink ${SCRATCH_MNT}/foo 0 19M 2M" \
 	     -c "fsync" \
 	     $SCRATCH_MNT/bar >>$seqres.full
 
diff --git a/tests/generic/501.out b/tests/generic/501.out
index 5d7da017..778aba4b 100644
--- a/tests/generic/501.out
+++ b/tests/generic/501.out
@@ -1,5 +1,5 @@
 QA output created by 501
 File bar digest before power failure:
-95a95813a8c2abc9aa75a6c2914a077e  SCRATCH_MNT/bar
+69319d0343ab8f5ea564167da445addc  SCRATCH_MNT/bar
 File bar digest after power failure:
-95a95813a8c2abc9aa75a6c2914a077e  SCRATCH_MNT/bar
+69319d0343ab8f5ea564167da445addc  SCRATCH_MNT/bar
-- 
2.26.2

