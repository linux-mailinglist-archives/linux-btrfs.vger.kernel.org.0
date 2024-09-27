Return-Path: <linux-btrfs+bounces-8293-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 173FD98826A
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 12:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91EFB1F22422
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Sep 2024 10:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8471BC9E3;
	Fri, 27 Sep 2024 10:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1M8YmPg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E866419FA66;
	Fri, 27 Sep 2024 10:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727432912; cv=none; b=V3TdZa0yU4WXqszyMtaic0TP8La+14aNk/PeLahsNLL9ZmmnnLhgSurLt4IkygqnWSYBE68JAHXFZZkvIHOvlcbgjtkGooaZOudPqjOF1jWzfW1RsmdcFLjyL4XsHnI/SAEHys0e3/pDNQiCQkVnhUvhDQMW+YSHDLiwVUmIJqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727432912; c=relaxed/simple;
	bh=gD8lzGCB0sa2LJA8v4Og6GbbacLab6cvjKxhGKKGSUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=grMMQX/OwKgPKOW/cu1UaZedm/Fs+9YKLU5YWPEnp/ogp0+HBbndWOCJMBINeUW80mX14OSaFPVPdUIg/YujE58dNFeefvy8494MYjVP8xNRByzYf7K/kMG5eK6sBRCJiCrE4R3Bjqn8h1CMukQc2DmYpFjj3BKy3YSSyktYK80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1M8YmPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696E3C4CEC4;
	Fri, 27 Sep 2024 10:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727432910;
	bh=gD8lzGCB0sa2LJA8v4Og6GbbacLab6cvjKxhGKKGSUg=;
	h=From:To:Cc:Subject:Date:From;
	b=k1M8YmPgeGh9VV1aJ9Uo5u2n4lBdng1zlLnY1AsdkU29BlK7Elw/PCX2UijZz2B3f
	 9TROQX7LxTa17G5OeHp6pp2V+HOaT8zoc7XWnK/U+YBJYaU7eopD9VH//3WqcLgXsY
	 c902aAAD1xx9aMLCghidl0XjEQBsmjFwQC5yoH3ym80ofVjzc6VpUV1yqnfScy7Zqc
	 O/H+AZwXAFVg7aIi3G98HhLivD08FOxsmr/K1Uqz+xgXL7R0vbanQ4Lclu+ivxDGtq
	 9tQD/SzieFURwOiwXRhC6H52Ily8BeeRAX2+BKjP3mxbU6G9uJF7+VDssRrNr8NdfY
	 R2PHipmG44Fig==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: test an incremental send scenario with cloning of unaligned extent
Date: Fri, 27 Sep 2024 11:28:07 +0100
Message-ID: <76d94e63cec4cb04cbfbc0dcd0928f1fbdc27bdf.1727432832.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Test that doing an incremental send with a file that had its size
decreased and became the destination for a clone operation of an extent
with an unaligned end offset that matches the new file size, works
correctly.

This tests a bug fixed by the following kernel patch:

  "btrfs: send: fix invalid clone operation for file that got its size decreased"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/322     | 108 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/322.out |  24 ++++++++++
 2 files changed, 132 insertions(+)
 create mode 100755 tests/btrfs/322
 create mode 100644 tests/btrfs/322.out

diff --git a/tests/btrfs/322 b/tests/btrfs/322
new file mode 100755
index 00000000..c03f6a4c
--- /dev/null
+++ b/tests/btrfs/322
@@ -0,0 +1,108 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 322
+#
+# Test that doing an incremental send with a file that had its size decreased
+# and became the destination for a clone operation of an extent with an
+# unaligned end offset that matches the new file size, works correctly.
+#
+. ./common/preamble
+_begin_fstest auto quick send clone fiemap
+
+_cleanup()
+{
+	cd /
+	rm -fr $tmp.*
+	rm -fr $send_files_dir
+}
+
+. ./common/filter
+. ./common/reflink
+. ./common/punch # for _filter_fiemap_flags
+
+_require_test
+_require_scratch_reflink
+_require_xfs_io_command "fiemap"
+_require_odirect
+
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: send: fix invalid clone operation for file that got its size decreased"
+
+check_all_extents_shared()
+{
+	local file=$1
+	local fiemap_output
+
+	fiemap_output=$($XFS_IO_PROG -r -c "fiemap -v" $file | _filter_fiemap_flags)
+	echo "$fiemap_output" | grep -qv 'shared'
+	if [ $? -eq 0 ]; then
+		echo -e "Found non-shared extents for file $file:\n"
+		echo "$fiemap_output"
+	fi
+}
+
+send_files_dir=$TEST_DIR/btrfs-test-$seq
+full_send_stream=$send_files_dir/full_snap.stream
+inc_send_stream=$send_files_dir/inc_snap.stream
+
+rm -fr $send_files_dir
+mkdir $send_files_dir
+
+_scratch_mkfs >> $seqres.full 2>&1 || _fail "first mkfs failed"
+_scratch_mount
+
+# Create a file with a size of 256K + 5 bytes, having two extents, the first one
+# with a size of 128K and the second one with a size of 128K + 5 bytes.
+last_extent_size=$((128 * 1024 + 5))
+$XFS_IO_PROG -f -d -c "pwrite -S 0xab -b 128K 0 128K" \
+             -c "pwrite -S 0xcd -b $last_extent_size 128K $last_extent_size" \
+             $SCRATCH_MNT/foo | _filter_xfs_io
+
+# Another file which we will later clone foo into, but initially with
+# a larger size than foo.
+$XFS_IO_PROG -f -c "pwrite -b 0xef 0 1M" $SCRATCH_MNT/bar | _filter_xfs_io
+
+echo "Creating snapshot and the full send stream for it..."
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap1
+$BTRFS_UTIL_PROG send -f $full_send_stream $SCRATCH_MNT/snap1 >> $seqres.full 2>&1
+
+# Now resize bar and clone foo into it.
+$XFS_IO_PROG -c "truncate 0" \
+	     -c "reflink $SCRATCH_MNT/foo" $SCRATCH_MNT/bar | _filter_xfs_io
+
+echo "Creating another snapshot and the incremental send stream for it..."
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2
+$BTRFS_UTIL_PROG send -p $SCRATCH_MNT/snap1 -f $inc_send_stream \
+		 $SCRATCH_MNT/snap2 >> $seqres.full 2>&1
+
+echo "File digests in the original filesystem:"
+md5sum $SCRATCH_MNT/snap1/foo | _filter_scratch
+md5sum $SCRATCH_MNT/snap1/bar | _filter_scratch
+md5sum $SCRATCH_MNT/snap2/foo | _filter_scratch
+md5sum $SCRATCH_MNT/snap2/bar | _filter_scratch
+
+check_all_extents_shared "$SCRATCH_MNT/snap2/bar"
+check_all_extents_shared "$SCRATCH_MNT/snap1/foo"
+
+echo "Creating a new filesystem to receive the send streams..."
+_scratch_unmount
+_scratch_mkfs >> $seqres.full 2>&1 || _fail "second mkfs failed"
+_scratch_mount
+
+$BTRFS_UTIL_PROG receive -f $full_send_stream $SCRATCH_MNT
+$BTRFS_UTIL_PROG receive -f $inc_send_stream $SCRATCH_MNT
+
+echo "File digests in the new filesystem:"
+md5sum $SCRATCH_MNT/snap1/foo | _filter_scratch
+md5sum $SCRATCH_MNT/snap1/bar | _filter_scratch
+md5sum $SCRATCH_MNT/snap2/foo | _filter_scratch
+md5sum $SCRATCH_MNT/snap2/bar | _filter_scratch
+
+check_all_extents_shared "$SCRATCH_MNT/snap2/bar"
+check_all_extents_shared "$SCRATCH_MNT/snap1/foo"
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/322.out b/tests/btrfs/322.out
new file mode 100644
index 00000000..31e1ee55
--- /dev/null
+++ b/tests/btrfs/322.out
@@ -0,0 +1,24 @@
+QA output created by 322
+wrote 131072/131072 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 131077/131077 bytes at offset 131072
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Creating snapshot and the full send stream for it...
+linked 0/0 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Creating another snapshot and the incremental send stream for it...
+File digests in the original filesystem:
+c3bb068b7e21d3f009581f047be84f44  SCRATCH_MNT/snap1/foo
+ca539970d4b1fa1f34213ba675007381  SCRATCH_MNT/snap1/bar
+c3bb068b7e21d3f009581f047be84f44  SCRATCH_MNT/snap2/foo
+c3bb068b7e21d3f009581f047be84f44  SCRATCH_MNT/snap2/bar
+Creating a new filesystem to receive the send streams...
+At subvol snap1
+At snapshot snap2
+File digests in the new filesystem:
+c3bb068b7e21d3f009581f047be84f44  SCRATCH_MNT/snap1/foo
+ca539970d4b1fa1f34213ba675007381  SCRATCH_MNT/snap1/bar
+c3bb068b7e21d3f009581f047be84f44  SCRATCH_MNT/snap2/foo
+c3bb068b7e21d3f009581f047be84f44  SCRATCH_MNT/snap2/bar
-- 
2.43.0


