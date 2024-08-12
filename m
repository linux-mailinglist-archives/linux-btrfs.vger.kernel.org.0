Return-Path: <linux-btrfs+bounces-7125-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD5894EEC9
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 15:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7171F22FD1
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 13:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C58183CB3;
	Mon, 12 Aug 2024 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYCevSfj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6D6183CA7;
	Mon, 12 Aug 2024 13:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470678; cv=none; b=OxnhlnUz9BDqWioOaf4fbo4G1lTZN5tvI1tPn4KYLXU2wWBYQGl1ILN9Ew3DiTEUB37Lkar6zZEyXLeZFWUHGwan6ETgn41N4pIujSZ5mlPQYnuVCtQQQlRV6/WxbmluPgllLhw8uh37D58lE901pPTSi1qPyZOaJ9yg658UVDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470678; c=relaxed/simple;
	bh=WBUoNzxaxc7mc0/kNgrl/K4y0L+WjLB43TN7ZElMfOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XzIvxMlCGdjj/uZ+BsV374jFXBdm8MCecjcqonJV2X2i4/ZEuQGH/4K+bhgi4ymcX7H89qAgNBfGxe6Ibj9dIf7nC7/Yoa0UHOyu3MdLPPV+OwGkMd72tAwUrcjlujyM90h4Gcj22St/6DqzfoQ/QZgnUGLZNxMHruMLaFL54FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYCevSfj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA5AC4AF0F;
	Mon, 12 Aug 2024 13:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723470677;
	bh=WBUoNzxaxc7mc0/kNgrl/K4y0L+WjLB43TN7ZElMfOc=;
	h=From:To:Cc:Subject:Date:From;
	b=XYCevSfjoBoLO0YkGithPjY+yCPNdCk9SPiP/BwzGKnzxsAHAu9il+7wvtaPHZdJQ
	 lmF7Db+s+n5CWu5lmHGG0nMZwbWApf3ztR2PK9rHppg1NjQ18MM263L37F2dqltnDq
	 N6OHZzqgfqIkAn4/qDvHX5VRIXny6uCwqHQPcUW2liXvyrEqrWmzQxPt/vRdbZFYZg
	 +EQz1r2UnQX/h+nDEC5xXWKqzrqU3dpbg0To7nPtL0HRcTk7s1kIyty0JvE1w7O+T6
	 3GB9mHM2KT9MhuLPZ2l0TkD8IF4FKHeXac0m4lKzU5FQ5M1j7nkPr5EjmlTlOwc3hL
	 ggABjKU55vEpw==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: test send clones extents with unaligned end offset ending at i_size
Date: Mon, 12 Aug 2024 14:51:09 +0100
Message-ID: <177f429d65afb5cc99a7f950779ba15b130cd581.1723470203.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Test that a send operation will issue a clone operation for a shared
extent of a file if the extent ends at the i_size of the file and the
i_size is not sector size aligned.

This verifies an improvement to the btrfs send feature implemented by
the following kernel patch:

  "btrfs: send: allow cloning non-aligned extent if it ends at i_size"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/319     | 80 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/319.out | 16 +++++++++
 2 files changed, 96 insertions(+)
 create mode 100755 tests/btrfs/319
 create mode 100644 tests/btrfs/319.out

diff --git a/tests/btrfs/319 b/tests/btrfs/319
new file mode 100755
index 00000000..2fe80185
--- /dev/null
+++ b/tests/btrfs/319
@@ -0,0 +1,80 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 319
+#
+# Test that a send operation will issue a clone operation for a shared extent
+# of a file if the extent ends at the i_size of the file and the i_size is not
+# sector size aligned.
+#
+. ./common/preamble
+_begin_fstest auto quick send clone fiemap
+
+# Override the default cleanup function.
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
+_require_cp_reflink
+_require_xfs_io_command "fiemap"
+_require_odirect
+
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: send: allow cloning non-aligned extent if it ends at i_size"
+
+send_files_dir=$TEST_DIR/btrfs-test-$seq
+send_stream=$send_files_dir/snap.stream
+
+rm -fr $send_files_dir
+mkdir $send_files_dir
+
+_scratch_mkfs >> $seqres.full 2>&1 || _fail "first mkfs failed"
+_scratch_mount
+
+# Use a file size that is not aligned to any possible sector size (1M + 5 bytes).
+file_size=$((1024 * 1024 + 5))
+# Use O_DIRECT to guarantee a single extent.
+$XFS_IO_PROG -f -d -c "pwrite -S 0xab -b $file_size 0 $file_size" \
+	     $SCRATCH_MNT/foo | _filter_xfs_io
+
+# Clone the file.
+_cp_reflink $SCRATCH_MNT/foo $SCRATCH_MNT/bar
+
+echo "Creating snapshot and a send stream for it..."
+_btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap
+$BTRFS_UTIL_PROG send -f $send_stream $SCRATCH_MNT/snap >> $seqres.full 2>&1
+
+echo "File digests in the original filesystem:"
+md5sum $SCRATCH_MNT/snap/foo | _filter_scratch
+md5sum $SCRATCH_MNT/snap/bar | _filter_scratch
+
+echo "File bar fiemap in the original filesystem:"
+$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap/bar | _filter_fiemap_flags
+
+echo "Creating a new filesystem to receive the send stream..."
+_scratch_unmount
+_scratch_mkfs >> $seqres.full 2>&1 || _fail "second mkfs failed"
+_scratch_mount
+
+$BTRFS_UTIL_PROG receive -f $send_stream $SCRATCH_MNT
+
+echo "File digests in the new filesystem:"
+md5sum $SCRATCH_MNT/snap/foo | _filter_scratch
+md5sum $SCRATCH_MNT/snap/bar | _filter_scratch
+
+echo "File bar fiemap in the new filesystem:"
+$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap/bar | _filter_fiemap_flags
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/319.out b/tests/btrfs/319.out
new file mode 100644
index 00000000..14079dbe
--- /dev/null
+++ b/tests/btrfs/319.out
@@ -0,0 +1,16 @@
+QA output created by 319
+wrote 1048581/1048581 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Creating snapshot and a send stream for it...
+File digests in the original filesystem:
+e61178ee0288ebe3fa36a3c975b02c94  SCRATCH_MNT/snap/foo
+e61178ee0288ebe3fa36a3c975b02c94  SCRATCH_MNT/snap/bar
+File bar fiemap in the original filesystem:
+0: [0..2055]: shared|last
+Creating a new filesystem to receive the send stream...
+At subvol snap
+File digests in the new filesystem:
+e61178ee0288ebe3fa36a3c975b02c94  SCRATCH_MNT/snap/foo
+e61178ee0288ebe3fa36a3c975b02c94  SCRATCH_MNT/snap/bar
+File bar fiemap in the new filesystem:
+0: [0..2055]: shared|last
-- 
2.43.0


