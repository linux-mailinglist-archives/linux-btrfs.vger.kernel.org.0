Return-Path: <linux-btrfs+bounces-15645-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525FCB0F1D6
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jul 2025 14:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A48587A4945
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jul 2025 12:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AA42E54C8;
	Wed, 23 Jul 2025 12:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bG2TQmR8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44A32AD3E;
	Wed, 23 Jul 2025 12:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753272255; cv=none; b=KkKFPY0KvWUIQpQ4KF/naQrXvbbeE8rMr5dVCUKp8dq5ccU73VzGhucAp100rhVV0Gnsp0mnPIod5KfB1DdUyn+r+9TUyQxBjJ0vT9cOaxYH2Y1Ha2+PTbwiD5W2G15sXLm1benHGIxjjwn4eOGHkg4wqSd0SCtBoz5RBYJKows=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753272255; c=relaxed/simple;
	bh=hNogKy1SzVntbfa2XfVY+rAA9VmZ0tlq1LRXZh6Jg6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iBZ6Bc4PR4B46ODnlnQJNHklDV+xOck7m8x5IaTVjJVk1ElcIrQuaDfMPyQjYosfSN6f0BS2CVGm4XwGC9cNMCFtxzHk7UP4r+LOoAZMC6zWpXnxwIBFICUTgswdy0CTjQYnVf1YodEKOILmb7zZgeoBeQfNoZAPpVI47/0SQeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bG2TQmR8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7908AC4CEE7;
	Wed, 23 Jul 2025 12:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753272255;
	bh=hNogKy1SzVntbfa2XfVY+rAA9VmZ0tlq1LRXZh6Jg6I=;
	h=From:To:Cc:Subject:Date:From;
	b=bG2TQmR8lN6vSGZtYFQjtO8KvnLiAB1YMKoLgXcGBgBhR/TSw0wXHJTch7mtL45xr
	 8JiakjSzIKx4zefY8kpbvV+5FR0S1vyfKd0QaFA/mIc4isB/SGAhycZlqd5y989ckR
	 V0SXIKk27bjCKDXZkYcvWNhJA09M4tr/4g+w8/GAOmSjRDrYIEm+pSy6h7owADBHMW
	 pWCZELkFUSwa0lOErYemrrC0CsOdM6K2IwSzRCndCc5pFpwzz+dTLJImEV3VmTd8tg
	 rSB48qbspQ1TtNDpoXZ//Fxfl0naMwM4KGSVl3PXKd7TOh+Q9/O17lX75S8lMfitE7
	 lOlkRIYjNiyUQ==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] generic/211: verify if the filesystem being tested supports in place writes
Date: Wed, 23 Jul 2025 13:04:06 +0100
Message-ID: <7ba7d315e60388593ccef0353cff58c4b5795615.1753272216.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The test currently assumes the filesystem can do in place writes (no
Copy-On-Write, no allocation of new extents) when overwriting a file.
While that is the case for most filesystems in most configurations, there
are exceptions such as zoned xfs where overwriting results in allocating
new extents for the new data.

So make the test check that in place writes are supported and skip the
test if they are not supported.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 common/rc         | 59 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/211 |  1 +
 2 files changed, 60 insertions(+)

diff --git a/common/rc b/common/rc
index 96578d15..52aade10 100644
--- a/common/rc
+++ b/common/rc
@@ -5873,6 +5873,65 @@ _require_program() {
 	_have_program "$1" || _notrun "$tag required"
 }
 
+# Test that a filesystem can do writes to a file in place (without allocating
+# new extents, without Copy-On-Write semantics).
+_require_inplace_writes()
+{
+	_require_xfs_io_command "fiemap"
+
+	local target=$1
+	local test_file="${target}/test_inplace_writes"
+	local fiemap_before
+	local fiemap_after
+
+	if [ -z "$target" ]; then
+		_fail "Usage: _require_inplace_writes <filesystem path>"
+	fi
+
+	rm -f "$test_file"
+	touch "$test_file"
+
+	# Set the file to NOCOW mode on btrfs, which must be done while the file
+	# is empty, otherwise it fails.
+	if [ "$FSTYP" == "btrfs" ]; then
+		_require_chattr C
+		$CHATTR_PROG +C "$test_file"
+	fi
+
+	$XFS_IO_PROG -f -c "pwrite 0 128K" -c "fsync" "$test_file" &> /dev/null
+	if [ $? -ne 0 ]; then
+		rm -f "$test_file"
+		_fail "_require_inplace_writes failed to write to test file"
+	fi
+
+	# Grab fiemap output before overwriting.
+	fiemap_before=$($XFS_IO_PROG -c "fiemap" "$test_file")
+	if [ $? -ne 0 ]; then
+		rm -f "$test_file"
+		_fail "_require_inplace_writes first fiemap call failed"
+	fi
+
+	$XFS_IO_PROG -c "pwrite 0 128K" -c "fsync" "$test_file" &> /dev/null
+	if [ $? -ne 0 ]; then
+		rm -f "$test_file"
+		_fail "_require_inplace_writes failed to overwrite test file"
+	fi
+
+	fiemap_after=$($XFS_IO_PROG -c "fiemap" "$test_file")
+	if [ $? -ne 0 ]; then
+		rm -f "$test_file"
+		_fail "_require_inplace_writes second fiemap call failed"
+	fi
+
+	rm -f "$test_file"
+
+	# If the filesystem supports inplace writes, then the extent mapping is
+	# the same before and after overwriting.
+	if [ "${fiemap_after}" != "${fiemap_before}" ]; then
+		_notrun "inplace writes not supported"
+	fi
+}
+
 ################################################################################
 # make sure this script returns success
 /bin/true
diff --git a/tests/generic/211 b/tests/generic/211
index e87d1e01..ed426db2 100755
--- a/tests/generic/211
+++ b/tests/generic/211
@@ -27,6 +27,7 @@ fs_size=$(_small_fs_size_mb 512)
 _try_scratch_mkfs_sized $((fs_size * 1024 * 1024)) >>$seqres.full 2>&1 || \
 	_fail "mkfs failed"
 _scratch_mount
+_require_inplace_writes "${SCRATCH_MNT}"
 
 touch $SCRATCH_MNT/foobar
 
-- 
2.47.2


