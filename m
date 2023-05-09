Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13D66FC566
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 13:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbjEILwZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 May 2023 07:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235582AbjEILwX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 May 2023 07:52:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFDE198E;
        Tue,  9 May 2023 04:52:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6399260C61;
        Tue,  9 May 2023 11:52:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01DFC433EF;
        Tue,  9 May 2023 11:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683633139;
        bh=JAYF+KYxSpe+e/npHXCa/jNTnnQeJxDX5lO1OJPjvoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mAlyClIBO+MckzMpFNB+F5oOYjb6p/SIiKzNiidc2J1cDGciwXAAWpiE35zqN6I5k
         1SfeGr5GZF+Bb9gd5s6DNuPxXoAGzInlNjk+OCUXy90QgDFVwsAQ8vDT3lDjsMbtW/
         A/ma84DU/yEcoxlkA/u+MSafwbB2PxMq995NMJeyOp9Jy4Hw5CF0QrCKNuNoPS42jM
         WSNv5pZgzacDgSF9VLcN+/B0fyGj1XVELHd0JiWeQ2NpaS0hoE1Bt9ttWymoo7ot35
         otuP84YEX7H5wMRTamqrt4rUmS3VbijFnmBd6dZeg4VASV+J5oCqhisDD8ToN6/0ie
         TWAw6NHXWz6uQ==
From:   fdmanana@kernel.org
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 2/3] btrfs: add a test case for the logical to ino ioctl
Date:   Tue,  9 May 2023 12:52:05 +0100
Message-Id: <928d682f857556ebfa30e2cfb333e96f6be6a1c1.1683632565.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1683632565.git.fdmanana@suse.com>
References: <cover.1683632565.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Add a test case to exercise the logical to ino ioctl, including the v2
version (which adds the ignore offset option). This is motivated by the
fact that we have no test cases giving full coverage to that ioctl, only
two test cases partially exercise it (btrfs/004 and btrfs/299) and
absolutely no coverage for the v2 ioctl. This resulted in a recent
regression fixed by the patch mentioned in the _fixed_by_kernel_commit
tag of the introduced test case.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 common/btrfs        |  29 +++++++++
 tests/btrfs/287     | 154 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/287.out |  95 +++++++++++++++++++++++++++
 3 files changed, 278 insertions(+)
 create mode 100755 tests/btrfs/287
 create mode 100644 tests/btrfs/287.out

diff --git a/common/btrfs b/common/btrfs
index 42777df2..bd4dc31f 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -647,3 +647,32 @@ _btrfs_get_file_extent_item_bytenr()
 		grep -A4 "$file_extent_key" | grep "disk byte" | \
 		$AWK_PROG '{ print $5 }'
 }
+
+# Check that btrfs-progs has support for the logical-resolve command, with the
+# -o option, and that the kernel supports the logical to ino ioctl v2 (which
+# adds the ignore offset parameter).
+_require_btrfs_scratch_logical_resolve_v2()
+{
+	local bytenr
+
+	# First check if we have support for calling the v2 logical resolve
+	# ioctl in btrfs-progs. Check if the -o options exists, which makes
+	# btrfs-progs call v2 of the ioctl (because the flag
+	# BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET is only supported in v2).
+	_require_btrfs_command inspect-internal logical-resolve -o
+	_require_scratch
+
+	_scratch_mkfs > /dev/null || \
+		_fail "_require_btrfs_scratch_logical_resolve_v2: mkfs failed"
+	_scratch_mount
+
+	$XFS_IO_PROG -f -c "pwrite -q 0 128K" "$SCRATCH_MNT/file1"
+	bytenr=$(_btrfs_get_file_extent_item_bytenr "$SCRATCH_MNT/file1" 0)
+	$BTRFS_UTIL_PROG inspect-internal logical-resolve -o $bytenr \
+			 $SCRATCH_MNT > /dev/null
+	if [ $? -ne 0 ]; then
+		_scratch_unmount
+		_notrun "Logical resolve ioctl v2 not supported in the kernel"
+	fi
+	_scratch_unmount
+}
diff --git a/tests/btrfs/287 b/tests/btrfs/287
new file mode 100755
index 00000000..a7e29e2b
--- /dev/null
+++ b/tests/btrfs/287
@@ -0,0 +1,154 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 287
+#
+# Test btrfs' logical to inode ioctls (v1 and v2).
+#
+. ./common/preamble
+_begin_fstest auto quick snapshot clone punch
+
+. ./common/filter
+. ./common/reflink
+
+_supported_fs btrfs
+_require_btrfs_scratch_logical_resolve_v2
+_require_scratch_reflink
+_require_xfs_io_command "fpunch"
+
+# This is a test case to test the logical to ino ioctl in general but it also
+# serves as a regression a test for an issue fixed by the following commit.
+_fixed_by_kernel_commit XXXXXXXXXXXX \
+	"btrfs: fix backref walking not returning all inode refs"
+
+query_logical_ino()
+{
+	$BTRFS_UTIL_PROG inspect-internal logical-resolve -P $* $SCRATCH_MNT
+}
+
+_scratch_mkfs >> $seqres.full || _fail "mkfs failed"
+_scratch_mount
+
+# Create a file with two extents:
+#
+# 1) One 4M extent covering the file range [0, 4M)
+# 2) Another 4M extent covering the file range [4M, 8M)
+$XFS_IO_PROG -f -c "pwrite -S 0xab -b 4M 0 4M" \
+	     -c "fsync" \
+	     -c "pwrite -S 0xcd -b 4M 4M 8M" \
+	     -c "fsync" $SCRATCH_MNT/foo | _filter_xfs_io
+
+echo "resolve first extent:"
+first_extent_bytenr=$(_btrfs_get_file_extent_item_bytenr "$SCRATCH_MNT/foo" 0)
+query_logical_ino $first_extent_bytenr
+
+echo "resolve second extent:"
+sz_4m=$((4 * 1024 * 1024))
+second_extent_bytenr=$(_btrfs_get_file_extent_item_bytenr "$SCRATCH_MNT/foo" $sz_4m)
+query_logical_ino $second_extent_bytenr
+
+# Now clone both extents twice to the end of the file.
+sz_8m=$((8 * 1024 * 1024))
+$XFS_IO_PROG -c "reflink $SCRATCH_MNT/foo 0 $sz_8m $sz_8m" $SCRATCH_MNT/foo \
+	| _filter_xfs_io
+sz_16m=$((16 * 1024 * 1024))
+$XFS_IO_PROG -c "reflink $SCRATCH_MNT/foo 0 $sz_16m $sz_8m" $SCRATCH_MNT/foo \
+	| _filter_xfs_io
+
+# Now lets resolve the extents again. They should now be listed 3 times each, at
+# the right file offsets.
+echo "resolve first extent:"
+query_logical_ino $first_extent_bytenr
+
+echo "resolve second extent:"
+query_logical_ino $second_extent_bytenr
+
+# Now lets punch a 2M hole at file offset 0. This changes the first file extent
+# item to point to the first extent with an offset of 2M and a length of 2M, so
+# doing a logical resolve with the bytenr of the first extent should not return
+# file offset 0.
+$XFS_IO_PROG -c "fpunch 0 2M" $SCRATCH_MNT/foo
+echo "resolve first extent after punching hole at file range [0, 2M):"
+query_logical_ino $first_extent_bytenr
+
+# Doing a logical resolve call with the BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET
+# flag (passing -o to logical-resolve command) should ignore file extent offsets
+# and return file offsets for all file extent items that point to any section of
+# the extent (3 of them, file offsets 2M, 8M and 16M).
+echo "resolve first extent with ignore offset option:"
+query_logical_ino -o $first_extent_bytenr
+
+# Now query for file extent items containing the first extent at offset +1M.
+# Should only return the file offsets 9M and 17M.
+bytenr=$(( $first_extent_bytenr + 1024 * 1024))
+echo "resolve first extent +1M offset:"
+query_logical_ino $bytenr
+
+# Now do the same query again but with the ignore offset ioctl argument. This
+# should returns 3 results, for file offsets 2M, 8M and 16M.
+echo "resolve first extent +1M offset with ignore offset option:"
+query_logical_ino -o $bytenr
+
+# Now query for file extent items containing the first extent at offset +3M.
+# Should return the file offsets 3M and 11M and 19M.
+bytenr=$(( $first_extent_bytenr + 3 * 1024 * 1024))
+echo "resolve first extent +3M offset:"
+query_logical_ino $bytenr
+
+# Now do the same query again but with the ignore offset ioctl argument. This
+# should returns 3 results, for file offsets 2M, 8M and 16M.
+echo "resolve first extent +3M offset with ignore offset option:"
+query_logical_ino -o $bytenr
+
+# Now create two snapshots and then do some queries.
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1 \
+	| _filter_scratch
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2 \
+	| _filter_scratch
+
+# Query for the first extent (at offset 0). Should give two entries for each
+# root - default subvolume and the 2 snapshots, for file offsets 8M and 16M.
+echo "resolve first extent:"
+query_logical_ino $first_extent_bytenr
+
+# Query for the first extent (at offset 0) with the ignore offset option.
+# Should give 3 entries for each root - default subvolume and the 2 snapshots,
+# for file offsets 2M, 8M and 16M.
+echo "resolve first extent with ignore offset option:"
+query_logical_ino -o $first_extent_bytenr
+
+# Now lets punch a 1M hole at file offset 4M. This changes the second file
+# extent item to point to the second extent with an offset of 1M and a length
+# of 3M, so doing a logical resolve with the bytenr of the second extent should
+# not return file offset 4M for root 5 (default subvolume), bit it should return
+# file offset 4M for the files in the snapshots. For all the roots, it should
+# return file offsets 12M and 20M.
+$XFS_IO_PROG -c "fpunch 4M 1M" $SCRATCH_MNT/foo
+echo "resolve second extent after punching hole at file range [4M, 5M):"
+query_logical_ino $second_extent_bytenr
+
+# Repeat the query but with the ignore offset option. We should get 3 entries
+# for each root. For the snapshot roots, we should get entries for file offsets
+# 4M, 12M and 20M, while for the default subvolume (root 5) we should get for
+# file offsets 5M, 12M and 20M.
+echo "resolve second extent with ignore offset option:"
+query_logical_ino -o $second_extent_bytenr
+
+# Now delete the first snapshot and repeat the last 2 queries.
+$BTRFS_UTIL_PROG subvolume delete -C $SCRATCH_MNT/snap1 | _filter_scratch
+
+# Query the second extent with an offset of 0, should return file offsets 12M
+# and 20M for the default subvolume (root 5) and file offsets 4M, 12M and 20M
+# for the second snapshot root.
+echo "resolve second extent:"
+query_logical_ino $second_extent_bytenr
+
+# Query the second extent with the ignore offset option, should return file
+# offsets 5M, 12M and 20M for the default subvolume (root 5) and file offsets
+# 4M, 12M and 20M for the second snapshot root.
+echo "resolve second extent with ignore offset option:"
+query_logical_ino -o $second_extent_bytenr
+
+status=0
+exit
diff --git a/tests/btrfs/287.out b/tests/btrfs/287.out
new file mode 100644
index 00000000..683f9875
--- /dev/null
+++ b/tests/btrfs/287.out
@@ -0,0 +1,95 @@
+QA output created by 287
+wrote 4194304/4194304 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 8388608/8388608 bytes at offset 4194304
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+resolve first extent:
+inode 257 offset 0 root 5
+resolve second extent:
+inode 257 offset 4194304 root 5
+linked 8388608/8388608 bytes at offset 8388608
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+linked 8388608/8388608 bytes at offset 16777216
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+resolve first extent:
+inode 257 offset 16777216 root 5
+inode 257 offset 8388608 root 5
+inode 257 offset 0 root 5
+resolve second extent:
+inode 257 offset 20971520 root 5
+inode 257 offset 12582912 root 5
+inode 257 offset 4194304 root 5
+resolve first extent after punching hole at file range [0, 2M):
+inode 257 offset 16777216 root 5
+inode 257 offset 8388608 root 5
+resolve first extent with ignore offset option:
+inode 257 offset 16777216 root 5
+inode 257 offset 8388608 root 5
+inode 257 offset 2097152 root 5
+resolve first extent +1M offset:
+inode 257 offset 17825792 root 5
+inode 257 offset 9437184 root 5
+resolve first extent +1M offset with ignore offset option:
+inode 257 offset 16777216 root 5
+inode 257 offset 8388608 root 5
+inode 257 offset 2097152 root 5
+resolve first extent +3M offset:
+inode 257 offset 19922944 root 5
+inode 257 offset 11534336 root 5
+inode 257 offset 3145728 root 5
+resolve first extent +3M offset with ignore offset option:
+inode 257 offset 16777216 root 5
+inode 257 offset 8388608 root 5
+inode 257 offset 2097152 root 5
+Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap1'
+Create a readonly snapshot of 'SCRATCH_MNT' in 'SCRATCH_MNT/snap2'
+resolve first extent:
+inode 257 offset 16777216 root 257
+inode 257 offset 8388608 root 257
+inode 257 offset 16777216 root 256
+inode 257 offset 8388608 root 256
+inode 257 offset 16777216 root 5
+inode 257 offset 8388608 root 5
+resolve first extent with ignore offset option:
+inode 257 offset 16777216 root 257
+inode 257 offset 8388608 root 257
+inode 257 offset 2097152 root 257
+inode 257 offset 16777216 root 256
+inode 257 offset 8388608 root 256
+inode 257 offset 2097152 root 256
+inode 257 offset 16777216 root 5
+inode 257 offset 8388608 root 5
+inode 257 offset 2097152 root 5
+resolve second extent after punching hole at file range [4M, 5M):
+inode 257 offset 20971520 root 257
+inode 257 offset 12582912 root 257
+inode 257 offset 4194304 root 257
+inode 257 offset 20971520 root 256
+inode 257 offset 12582912 root 256
+inode 257 offset 4194304 root 256
+inode 257 offset 20971520 root 5
+inode 257 offset 12582912 root 5
+resolve second extent with ignore offset option:
+inode 257 offset 20971520 root 257
+inode 257 offset 12582912 root 257
+inode 257 offset 4194304 root 257
+inode 257 offset 20971520 root 256
+inode 257 offset 12582912 root 256
+inode 257 offset 4194304 root 256
+inode 257 offset 20971520 root 5
+inode 257 offset 12582912 root 5
+inode 257 offset 5242880 root 5
+Delete subvolume (commit): 'SCRATCH_MNT/snap1'
+resolve second extent:
+inode 257 offset 20971520 root 257
+inode 257 offset 12582912 root 257
+inode 257 offset 4194304 root 257
+inode 257 offset 20971520 root 5
+inode 257 offset 12582912 root 5
+resolve second extent with ignore offset option:
+inode 257 offset 20971520 root 257
+inode 257 offset 12582912 root 257
+inode 257 offset 4194304 root 257
+inode 257 offset 20971520 root 5
+inode 257 offset 12582912 root 5
+inode 257 offset 5242880 root 5
-- 
2.35.1

