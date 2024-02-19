Return-Path: <linux-btrfs+bounces-2503-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A709C85A2C3
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 13:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B68285BAA
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 12:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1893D2D604;
	Mon, 19 Feb 2024 12:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlFvlVF6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAAE2E40D;
	Mon, 19 Feb 2024 12:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708344137; cv=none; b=e5uu6Y+UA022VSgclLb+QCCy5yaF33+Yf5lVEjjImwMKTUIJwY5xVpyFHNB+Wr7D2CqnPRdajz0LTTaPmcGFfsNl0QQ9CGSN1wT68RcDSfgAVQ1y11u/cDc2sO251ke9ckWRfTwI/uly1MoAGDjJZYSWnoRZQJxGenCVEG07y3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708344137; c=relaxed/simple;
	bh=eKLRGH3mdIBGAMsL3XgHldAAyqteY4/uy4LPWPp14xQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K95D7eHTOT9b3cRNPlQdKUVTrY1rp4GoP/epZXLBFOPRVGvtT5YCZTK1oR5XPUkn3hUqTTdg8SU1ry1hAqPcRMtQN5qchNNyANbmr2fFxTlrk82mjd/62gyVBBCUxbh6+Q7gne+wZNB+TiyfaJImabAYSXkK7s8DCuscITQVmAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlFvlVF6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2183C433F1;
	Mon, 19 Feb 2024 12:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708344136;
	bh=eKLRGH3mdIBGAMsL3XgHldAAyqteY4/uy4LPWPp14xQ=;
	h=From:To:Cc:Subject:Date:From;
	b=nlFvlVF6CJOYeLfSaeswXHppfb3ORFn/yZwWj+iuBujpadUJZw4g6ur/rnHsSl/Iv
	 q5LP3dtebTYz90LlJaF47DPYKcsCIf14mQ816aWhrPfXNrzB3AHi7NkPQ28ceYKsV9
	 wiUIGXUouQEmzrhogTYXzyk0x68IhD5nZcvvFxkqaKPXr+6CblVHmiXC8cPLYA0c2R
	 1lsjHHMVyU4cSjyWRNhaR1WZ8zEATOuZNQH1dlwHD8lRSdgYqf1BBKRvAWAa/9kyQP
	 6ck9p5s0y0kAGtVc0NHt36xYWlHuswE7Rzv7buadCxfAw6A2BWXDwQWimNkjvTrJNf
	 rIlFrtECkoKFg==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: test incremental send on sparse file with trailing hole
Date: Mon, 19 Feb 2024 12:01:30 +0000
Message-Id: <fdf9b90760477ef48547efa1a5eecf273deaa09b.1708261420.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Test that an incremental send does not issue unnecessary writes for a
sparse file that got one new extent between its previous extent and the
file's size.

This exercises a fix by the following patch:

  "btrfs: send: don't issue unnecessary zero writes for trailing hole"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/303     | 92 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/303.out | 24 ++++++++++++
 2 files changed, 116 insertions(+)
 create mode 100755 tests/btrfs/303
 create mode 100644 tests/btrfs/303.out

diff --git a/tests/btrfs/303 b/tests/btrfs/303
new file mode 100755
index 00000000..26bcfe41
--- /dev/null
+++ b/tests/btrfs/303
@@ -0,0 +1,92 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 303
+#
+# Test that an incremental send does not issue unnecessary writes for a sparse
+# file that got one new extent between its previous extent and the file's size.
+#
+. ./common/preamble
+_begin_fstest auto quick snapshot send fiemap
+
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.*
+	rm -fr $send_files_dir
+}
+
+. ./common/filter
+. ./common/punch  # for _filter_fiemap
+
+_supported_fs btrfs
+_require_test
+_require_scratch
+_require_xfs_io_command "fiemap"
+
+_fixed_by_kernel_commit XXXXXXXXXXXX \
+	"btrfs: send: don't issue unnecessary zero writes for trailing hole"
+
+send_files_dir=$TEST_DIR/btrfs-test-$seq
+
+rm -fr $send_files_dir
+mkdir $send_files_dir
+
+_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
+_scratch_mount
+
+$XFS_IO_PROG -f -c "truncate 1G" $SCRATCH_MNT/foobar
+
+# Now create the base snapshot, which is going to be the parent snapshot for
+# a later incremental send.
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
+		 $SCRATCH_MNT/mysnap1 > /dev/null
+
+# Create send stream (full send) for the first snapshot.
+$BTRFS_UTIL_PROG send -f $send_files_dir/1.snap \
+		 $SCRATCH_MNT/mysnap1 2>&1 1>/dev/null | _filter_scratch
+
+# Now write one extent at the beginning of the file and one somewhere in the
+# middle, leaving a gap between the end of this second extent and the file's
+# size.
+$XFS_IO_PROG -c "pwrite -S 0xab -b 64K 0 64K" \
+	     -c "pwrite -S 0xcd -b 64K 512M 64K" \
+	     $SCRATCH_MNT/foobar | _filter_xfs_io
+
+# Now create a second snapshot which is going to be used for an incremental
+# send operation.
+$BTRFS_UTIL_PROG subvolume snapshot -r $SCRATCH_MNT \
+		 $SCRATCH_MNT/mysnap2 > /dev/null
+
+# Create send stream (incremental send) for the second snapshot.
+$BTRFS_UTIL_PROG send -p $SCRATCH_MNT/mysnap1 -f $send_files_dir/2.snap \
+		 $SCRATCH_MNT/mysnap2 2>&1 1>/dev/null | _filter_scratch
+
+# Now recreate the filesystem by receiving both send streams and verify we get
+# the same content that the original filesystem had and file foobar has only two
+# extents with a size of 64K each.
+_scratch_unmount
+_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
+_scratch_mount
+
+$BTRFS_UTIL_PROG receive -f $send_files_dir/1.snap $SCRATCH_MNT > /dev/null
+$BTRFS_UTIL_PROG receive -f $send_files_dir/2.snap $SCRATCH_MNT > /dev/null
+
+echo "File content in the new filesystem:"
+_hexdump $SCRATCH_MNT/mysnap2/foobar
+
+echo "File fiemap in the new filesystem:"
+# Should have:
+#
+# 64K extent at file range [0, 64K[
+# hole at file range [64K, 512M[
+# 64K extent at file range [512M, 512M + 64K[
+# hole at file range [512M + 64K, 1G[
+$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/mysnap2/foobar | _filter_fiemap
+
+# File should be using only 128K of data (two 64K extents).
+echo "Space used by the file: $(du -h $SCRATCH_MNT/mysnap2/foobar | cut -f 1)"
+
+status=0
+exit
diff --git a/tests/btrfs/303.out b/tests/btrfs/303.out
new file mode 100644
index 00000000..7659a794
--- /dev/null
+++ b/tests/btrfs/303.out
@@ -0,0 +1,24 @@
+QA output created by 303
+At subvol SCRATCH_MNT/mysnap1
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 536870912
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+At subvol SCRATCH_MNT/mysnap2
+At subvol mysnap1
+File content in the new filesystem:
+000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab  >................<
+*
+010000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
+*
+20000000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >................<
+*
+20010000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
+*
+40000000
+File fiemap in the new filesystem:
+0: [0..127]: data
+1: [128..1048575]: hole
+2: [1048576..1048703]: data
+3: [1048704..2097151]: hole
+Space used by the file: 128K
-- 
2.40.1


