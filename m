Return-Path: <linux-btrfs+bounces-19382-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2392EC8FE46
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Nov 2025 19:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 238A434FC29
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Nov 2025 18:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D294E3002DF;
	Thu, 27 Nov 2025 18:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEY9pVtv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD012FFFBC;
	Thu, 27 Nov 2025 18:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764267473; cv=none; b=K7QJdbOyFYQutzE53zZ/x9nd2jmI0ZirqwFdV3HNW3dlU8Lunezmq6kMqrjb7iyT0MhxRGggguvA61bzF4cGyjcQkgNZDD+XdF0WaIqHLj7QVm3LZcsLXTbHy5woSKzgFlffTgxTOS+80bo7eXQm1hbnha5t8Wb/fCian7Xq3Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764267473; c=relaxed/simple;
	bh=Tzpeowed1PRwIw6Okpeztb2a87WTpbakHwpXjOxub7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MpJAqStCdTkdLABfVD4gazTluYJYASJk/RA2dszyfVlL5klNT2sW16XjN7cMKDNG+HDGx8xfWq8sgLghhvyBVvTtbXpwwKSXnsQIwtwynXAdWrewupewSM23/7ek6HPSFobLVVv2bS5ERQeVDxje8EtNQHhRkT+ud2adIbWEdp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEY9pVtv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CD5C4CEF8;
	Thu, 27 Nov 2025 18:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764267470;
	bh=Tzpeowed1PRwIw6Okpeztb2a87WTpbakHwpXjOxub7c=;
	h=From:To:Cc:Subject:Date:From;
	b=eEY9pVtvMuAVF4lAo8xKXmMRK3YLKQAaaAft96LXLQUAdkJfjBRCIr7w532Y1+qBh
	 ba++WFiM/qgx63X5FRWLRuJt++KZAI1j6RW5juXi/VD9BgdfuLbJXKbcCs/MF3BZoB
	 sCVoQnthPu7N+glmZ1RqfBk1IJ4fQtSXO5kvHjlOpP3CzM/SVkWbQDgEmxGkWAb6rp
	 NFrqRL1mtQnd01mARaTBd5TdV8lHRzZbwGJfYdD6o6UGHOnWXbH2759yTw2InkHub/
	 rRTqvzfc2GCj1rHg4Jna+mfNssvu+UjIVpLWPkX3ztmgMHJZzKnfRFRn4zI9ZXXzXD
	 51iUxR+sP2wiw==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] generic: test a scenario of power failure after renames and fsyncs
Date: Thu, 27 Nov 2025 18:17:44 +0000
Message-ID: <5923d73eeeaf2b5d2e179c9be9cf3303149dc3f8.1764264859.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Test moving a directory to another location, create a file in the old
location of the directory and with the same name, fsync the file, then
move the file elsewhere and fsync again the file. After a power failure
we expect to be able to mount the fs and have the same content as before
the power failure.

This exercises a bug fixed by the following kernel patch for btrfs:

 "btrfs: don't log conflicting inode if it's a dir moved in the current transaction"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/generic/784     | 76 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/784.out | 19 +++++++++++
 2 files changed, 95 insertions(+)
 create mode 100755 tests/generic/784
 create mode 100644 tests/generic/784.out

diff --git a/tests/generic/784 b/tests/generic/784
new file mode 100755
index 00000000..8e01dff0
--- /dev/null
+++ b/tests/generic/784
@@ -0,0 +1,76 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 SUSE S.A.  All Rights Reserved.
+#
+# FS QA Test 784
+#
+# Test moving a directory to another location, create a file in the old location
+# of the directory and with the same name, fsync the file, then move the file
+# elsewhere and fsync again the file. After a power failure we expect to be able
+# to mount the fs and have the same content as before the power failure.
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
+. ./common/filter
+. ./common/dmflakey
+
+_require_scratch
+_require_dm_target flakey
+
+[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: don't log conflicting inode if it's a dir moved in the current transaction"
+
+_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
+_require_metadata_journaling $SCRATCH_DEV
+_init_flakey
+_mount_flakey
+
+list_fs_contents()
+{
+	# Remove the 'lost+found' directory which only exists in some
+	# filesystems like extN and remove empty lines to have a consistent
+	# output regardless of the existence of the 'lost+found' directory.
+	ls -1R $SCRATCH_MNT/ | grep -v 'lost+found' | grep -v -e '^$' | \
+		_filter_scratch
+}
+
+mkdir $SCRATCH_MNT/dir1
+mkdir $SCRATCH_MNT/dir2
+
+_scratch_sync
+
+mv $SCRATCH_MNT/dir1 $SCRATCH_MNT/dir2
+
+# Create a file with the old name of the first directory and persist it with
+# a fsync.
+$XFS_IO_PROG -f -c "fsync" $SCRATCH_MNT/dir1
+
+# Move the file to some other location.
+mv $SCRATCH_MNT/dir1 $SCRATCH_MNT/dir2/foo
+
+# Fsync again the file.
+$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/dir2/foo
+
+echo -e "\nfs contents before power failure:\n"
+list_fs_contents
+
+# Simulate a power failure and then mount again the filesystem to replay the
+# journal/log. We expect the mount to succeed.
+_flakey_drop_and_remount
+
+# We expect the fs contents to be the same as before the power failure.
+echo -e "\nfs contents after power failure:\n"
+list_fs_contents
+
+_unmount_flakey
+
+# success, all done
+_exit 0
diff --git a/tests/generic/784.out b/tests/generic/784.out
new file mode 100644
index 00000000..87942d04
--- /dev/null
+++ b/tests/generic/784.out
@@ -0,0 +1,19 @@
+QA output created by 784
+
+fs contents before power failure:
+
+SCRATCH_MNT/:
+dir2
+SCRATCH_MNT/dir2:
+dir1
+foo
+SCRATCH_MNT/dir2/dir1:
+
+fs contents after power failure:
+
+SCRATCH_MNT/:
+dir2
+SCRATCH_MNT/dir2:
+dir1
+foo
+SCRATCH_MNT/dir2/dir1:
-- 
2.47.2


