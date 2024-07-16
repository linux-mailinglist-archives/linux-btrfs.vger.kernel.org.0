Return-Path: <linux-btrfs+bounces-6495-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE7B9323B7
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2024 12:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6E9A284C8E
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jul 2024 10:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCA6143875;
	Tue, 16 Jul 2024 10:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4RP/Y0P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6E2198A2A;
	Tue, 16 Jul 2024 10:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721124896; cv=none; b=pWq7uvPb6jAsCPEGXfKQb5s2VXqV2MMpu0DCevgErPGEwwlU5sXm3aVs4ibxXN/GP/xPrlqEN2BL4HAsKp26CQfL5TLO/qMcISUPz/XJPR+lrcJqb5VZVjmTkaGt6AbRjUradrrCLF7j6OLaxgAZ4GVbK9PSYRNwuw0wA95pTH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721124896; c=relaxed/simple;
	bh=nDqqj1+aCw1jnXe71wusn42aF3zZYCxbvthxWf3ko2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t0qvSuVawb7lMxdNaG6KLe5faEfwsVH/Fal/TNN6KHEQePZct5/GdL+4xbm15r4r8PlLCSQpSw+/LfFWcgQx2RZfVFxA87gLcE3yWx/ffh25X+iQ1aTYbFfxbR48o7+b4nx+9gbpWcgT5mBfHJGlb6SWhoE6sXJ2OX/lpU1+1oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4RP/Y0P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8565C116B1;
	Tue, 16 Jul 2024 10:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721124895;
	bh=nDqqj1+aCw1jnXe71wusn42aF3zZYCxbvthxWf3ko2w=;
	h=From:To:Cc:Subject:Date:From;
	b=X4RP/Y0PlQQAwhWTYXUO144H1JUZQJZTfXG6u33dmkvQ8QmgQLORcuEU0BgoFYjr+
	 B2KeAFZ42KbEULh3YyIg2umRfEsx6bdol9bAitGlN6AETRDC/e+ILnIh8CkW1v/W2Y
	 g9F+CSqPgtZ063x0bYGoZQcVOMEpNbCbgbvqcwNbyeEjF7e1tWuBwHBpKiKvWkFKYi
	 pDcgUUetgmhgaGH0MHNMMelVkA+gvlpsbHKIbgyiGbhO/+GOS8Arn8gnS0GAHxQuQp
	 UwdfxEOJwsKboZXVGqXWn8ziaLWIpYwy7tytaGtbXiwkINQONtrdE57U4arsg8Lr5z
	 /cItje6DzK78g==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: test a compressed send stream scenario that triggered a read corruption
Date: Tue, 16 Jul 2024 11:14:45 +0100
Message-ID: <330b0c61a77f01bd2aa57e9b500145178a2d751a.1721124764.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Test a scenario of a compressed send stream that triggered a bug in the
extent map merging code introduced in the merge window for 6.11.

The commit that introduced the bug is on its way to Linus' tree and its
subject is:

   "btrfs: introduce new members for extent_map"

The corresponding fix was submitted to the btrfs mailing list, with the
subject:

  "btrfs: fix corrupt read due to bad offset of a compressed extent map"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/312     | 115 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/312.out |   7 +++
 2 files changed, 122 insertions(+)
 create mode 100755 tests/btrfs/312
 create mode 100644 tests/btrfs/312.out

diff --git a/tests/btrfs/312 b/tests/btrfs/312
new file mode 100755
index 00000000..ebecadc6
--- /dev/null
+++ b/tests/btrfs/312
@@ -0,0 +1,115 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 312
+#
+# Test a scenario of a compressed send stream that triggered a bug in the extent
+# map merging code introduced in the merge window for 6.11.
+#
+. ./common/preamble
+_begin_fstest auto quick send compress
+
+_cleanup()
+{
+	cd /
+	rm -fr $tmp.*
+	rm -fr $send_files_dir
+}
+
+. ./common/filter
+
+_require_btrfs_send_version 2
+_require_test
+_require_scratch
+
+_fixed_by_kernel_commit XXXXXXXXXXXX \
+	"btrfs: fix corrupt read due to bad offset of a compressed extent map"
+
+send_files_dir=$TEST_DIR/btrfs-test-$seq
+
+rm -fr $send_files_dir
+mkdir $send_files_dir
+first_stream="$send_files_dir/1.send"
+second_stream="$send_files_dir/2.send"
+
+_scratch_mkfs >> $seqres.full 2>&1 || _fail "first mkfs failed"
+_scratch_mount -o compress
+
+# Create a compressed extent for the range [108K, 144K[. Since it's a
+# non-aligned start offset, the first 3K of the extent are filled with zeroes.
+# The i_size is set to 141K.
+$XFS_IO_PROG -f -c "pwrite -S 0xab 111K 30K" $SCRATCH_MNT/foo >> $seqres.full
+
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1 >> $seqres.full
+
+# Overwrite a part of the extent we created before.
+# This will make the send stream include an encoded write (compressed) for the
+# file range [120K, 128K[.
+$XFS_IO_PROG -c "pwrite -S 0xcd 120K 8K" $SCRATCH_MNT/foo >> $seqres.full
+
+# Now do write after those extents and leaving a hole in between.
+# This results in expanding the last block of the extent we first created, that
+# is, in filling with zeroes the file range [141K, 144K[ (3072 bytes), which
+# belongs to the block in the range [140K, 144K[.
+#
+# When the destination filesystem receives from the send stream a write for that
+# range ([140K, 144K[) it does a btrfs_get_extent() call to find the extent map
+# containing the offset 140K. There's no loaded extent map covering that range
+# so it will lookg at the subvolume tree to find a file extent item covering the
+# range and then finds the file extent item covering the range [108K, 144K[ which
+# corresponds to the first extent written to the file, before snapshoting.
+#
+# Note that at this point in time the destination filesystem processed an encoded
+# write for the range [120K, 128K[, which created a compressed extent map for
+# that range and a corresponding ordered extent, which has not yet completed when
+# it received the write command for the [140K, 144K[ range, so the corresponding
+# file extent item is not yet in the subvolume tree - that only happens when the
+# ordered extent completes, at btrfs_finish_one_ordered().
+#
+# So having found a file extent item for the range [108K, 144K[ where 140K falls
+# into, it tries to add a compressed extent map for that range to the inode's
+# extent map tree with a call to btrfs_add_extent_mapping() done at
+# btrfs_get_extent(). That finds there's a loaded overlapping extent map for the
+# range [120K, 128K[ (the extent from the previous encoded write) and then calls
+# into merge_extent_mapping().
+#
+# The merging ended adjusting the extent map we attempted to insert, covering
+# the range [108K, 144K[, to cover instead the range [128K, 144K[ (length 16K)
+# instead, since there's an existing extent map for the range [120K, 128K[ and
+# we are looking for a range starting at 140K (and ending at 144K). However it
+# didn't adjust the extent map's offset from 0 to 20K, resulting in future reads
+# reading the incorrect range from the underlying extent (108K to 124K, 16K of
+# length, instead of the 128K to 144K range).
+#
+# Note that for the incorrect extent map, and therefore read corruption, to
+# happen, we depend on specific timings - the ordered extent for the encoded
+# write for the range [120K, 128K[ must not complete before the destination
+# of the send stream receives the write command for the range [140K, 144K[.
+#
+$XFS_IO_PROG -c "pwrite -S 0xef 160K 4K" $SCRATCH_MNT/foo >> $seqres.full
+
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2 >> $seqres.full
+
+echo "Checksums in the original filesystem:"
+echo "$(md5sum $SCRATCH_MNT/snap1/foo | _filter_scratch)"
+echo "$(md5sum $SCRATCH_MNT/snap2/foo | _filter_scratch)"
+
+$BTRFS_UTIL_PROG send --compressed-data -q -f $first_stream $SCRATCH_MNT/snap1
+$BTRFS_UTIL_PROG send --compressed-data -q -f $second_stream \
+		 -p $SCRATCH_MNT/snap1 $SCRATCH_MNT/snap2
+
+_scratch_unmount
+_scratch_mkfs >> $seqres.full 2>&1 || _fail "second mkfs failed"
+_scratch_mount
+
+$BTRFS_UTIL_PROG receive -q -f $first_stream $SCRATCH_MNT
+$BTRFS_UTIL_PROG receive -q -f $second_stream $SCRATCH_MNT
+
+echo "Checksums in the new filesystem:"
+echo "$(md5sum $SCRATCH_MNT/snap1/foo | _filter_scratch)"
+echo "$(md5sum $SCRATCH_MNT/snap2/foo | _filter_scratch)"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/312.out b/tests/btrfs/312.out
new file mode 100644
index 00000000..75f1f4cc
--- /dev/null
+++ b/tests/btrfs/312.out
@@ -0,0 +1,7 @@
+QA output created by 312
+Checksums in the original filesystem:
+e3ba4a9cbb38d921adc30d7e795d6626  SCRATCH_MNT/snap1/foo
+4de09f7184f63aa64b481f3031138920  SCRATCH_MNT/snap2/foo
+Checksums in the new filesystem:
+e3ba4a9cbb38d921adc30d7e795d6626  SCRATCH_MNT/snap1/foo
+4de09f7184f63aa64b481f3031138920  SCRATCH_MNT/snap2/foo
-- 
2.43.0


