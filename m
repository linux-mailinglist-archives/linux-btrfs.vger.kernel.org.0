Return-Path: <linux-btrfs+bounces-18284-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63737C06209
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 13:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF7053AE1E5
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 11:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFA230E82E;
	Fri, 24 Oct 2025 11:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zwc08M8m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A4530B512;
	Fri, 24 Oct 2025 11:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761306798; cv=none; b=anGgQFvGcCmxyxadPPhWmnxB7U8v+KNW1Z4V5hHXDRFUB6y+giDycf0FRcv8Z+Ve3X2GCa/0sR3Z9es5HwRgp4y9+MGVOoy3dKLQ6RrxFvvz6XFRb/BJ6YZIpD1JEZHGGCMctrPw87PS6pjo/i1djX1s4Ip7Va1+CkWlT8R4hU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761306798; c=relaxed/simple;
	bh=sxwfvU/Ry46nRT9HyyzOGsIz+BtjWU/lpLrAM2ZeT2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tu5MOcZyVC6yBFtk5uqAjKVcjz/F9cRjXADQj4l3NzZ9NiGQ23Bt0MH6IiyFyGISzaEQ1Yg0145lR+5svHFPd2c72xtMPE5dCz0zjn51dTfumYI0DOVAW8A6Rspj3mE4Zid5trXKT6L0X/pmb+tSXpYOGW57ep3JXW45L9QI2xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zwc08M8m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C38C4CEF1;
	Fri, 24 Oct 2025 11:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761306797;
	bh=sxwfvU/Ry46nRT9HyyzOGsIz+BtjWU/lpLrAM2ZeT2A=;
	h=From:To:Cc:Subject:Date:From;
	b=Zwc08M8mjRGK6sbSkOCSvivmcKjElCIfS7tHDhd8qDKMxIe82ydXMuR5dcEl/FgDa
	 MObZu9d7Ch4tE95YVrQTPOR0Pp1t41SmzLq4NE24Bu3AkOrESn90M7v45EoQcXuzGl
	 oVxYDpXFbbmA6Nw90efYxPqwn//82hxgptJIx+xl9DnakUVDHl4n3OZbuqW++hh7wp
	 4VPuQD5+IzqHyergFrjpgxhcJ6f8qnS2+cvtw/uc95bM0RLSyxc+DrFkyKvZCNLT0R
	 5FeyNjckLmk8kFvkk/vXHxx/IH55MRwHw/cxt1+ngz5a6QqBw2d0vW7vk3UmYA8G3d
	 tOU7oY/892KgA==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] generic: test fsync of directory after renaming new symlink
Date: Fri, 24 Oct 2025 12:53:12 +0100
Message-ID: <54585ed26988fb88be1eab8211aa383a5e7cbd19.1761306683.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Test that if we fsync a directory that has a new symlink, then rename the
symlink and fsync again the directory, after a power failure the symlink
exists with the new name and not the old one.

This is to exercise a bug in btrfs where we ended up not persisting the
new name of the symlink. That is fixed by a kernel patch that has the
following subject:

 "btrfs: set inode flag BTRFS_INODE_COPY_EVERYTHING when logging new name"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/779     | 60 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/779.out |  2 ++
 2 files changed, 62 insertions(+)
 create mode 100755 tests/generic/779
 create mode 100644 tests/generic/779.out

diff --git a/tests/generic/779 b/tests/generic/779
new file mode 100755
index 00000000..40d1a86c
--- /dev/null
+++ b/tests/generic/779
@@ -0,0 +1,60 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 SUSE S.A.  All Rights Reserved.
+#
+# FS QA Test 779
+#
+# Test that if we fsync a directory that has a new symlink, then rename the
+# symlink and fsync again the directory, after a power failure the symlink
+# exists with the new name and not the old one.
+#
+. ./common/preamble
+_begin_fstest auto quick log
+
+_cleanup()
+{
+	_cleanup_flakey
+	cd /
+	rm -r -f $tmp.*
+}
+
+. ./common/dmflakey
+
+_require_scratch
+_require_symlinks
+_require_dm_target flakey
+
+[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: set inode flag BTRFS_INODE_COPY_EVERYTHING when logging new name"
+
+rm -f $seqres.full
+
+_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
+_require_metadata_journaling $SCRATCH_DEV
+_init_flakey
+_mount_flakey
+
+# Create our test dir and add a symlink inside it.
+mkdir $SCRATCH_MNT/dir
+ln -s foobar $SCRATCH_MNT/dir/old-slink
+
+# Fsync the test dir, should persist the symlink.
+$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/dir
+
+# Rename the symlink and fsync the directory. It should persist the new symlink
+# name.
+mv $SCRATCH_MNT/dir/old-slink $SCRATCH_MNT/dir/new-slink
+$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/dir
+
+# Simulate a power failure and then mount again the filesystem to replay the
+# journal/log.
+_flakey_drop_and_remount
+
+# Check that the symlink exists with the new name and has the correct content.
+[ -L $SCRATCH_MNT/dir/new-slink ] || echo "symlink dir/new-slink not found"
+echo "symlink content: $(readlink $SCRATCH_MNT/dir/new-slink)"
+
+_unmount_flakey
+
+# success, all done
+_exit 0
diff --git a/tests/generic/779.out b/tests/generic/779.out
new file mode 100644
index 00000000..c595cd01
--- /dev/null
+++ b/tests/generic/779.out
@@ -0,0 +1,2 @@
+QA output created by 779
+symlink content: foobar
-- 
2.47.2


