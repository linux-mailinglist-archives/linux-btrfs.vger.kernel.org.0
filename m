Return-Path: <linux-btrfs+bounces-15657-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D67B109E3
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Jul 2025 14:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47B31C26882
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Jul 2025 12:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C7B2C1596;
	Thu, 24 Jul 2025 12:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8AOwC0K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F44824FBFF;
	Thu, 24 Jul 2025 12:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753358777; cv=none; b=kOPQECQso87RbXMoV0U8fXqo5XdV6XyhuKPQnu7vL3zkhy6kiEwQMoS7n49KYkfJqAcLDyYT6Aapf6qjOuYFWlrlkXu1ms++GVeCByOMMDsuoyz3TS48+bt5sfD9RSkc1hamaWT+wRsSt0NboTdleaxqG9SSsKLZ3naG1bsJ7JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753358777; c=relaxed/simple;
	bh=wpTRfhswvEYLuUaYXN3pjMPzMI2yUJLddELcEpZRAdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3yxNQRjSrUb7kZiX4pvfxr0X6O5kyMZAK0Qk/Dl9VBunP3OhxSQGawu8SXM+Sjt/Bs7QGk2Z6VuOeIayZwgXempQj5N4CcYQ5ECebruFEB3dvWvB20eBgM8GVJuBI4iXs4bDBx0VqE33CTdU0HkgKz/uuCnBdPZODTWK+D29XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8AOwC0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E214AC4CEED;
	Thu, 24 Jul 2025 12:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753358777;
	bh=wpTRfhswvEYLuUaYXN3pjMPzMI2yUJLddELcEpZRAdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L8AOwC0K4H5yg9CDq706g9ahFp4fnaqEAH9pCQgVGhXhzZCyHEedZYc/ZYPd7Xf1r
	 APPttWxCUdiDWsNWlpR3Ao6wNncW7zThuPrbY3ZDwIMXvzsMHhbhekBhZ38wPxB6vv
	 yhlkyLzEIWELEygBaFishNPLYJ+Qh/YBMxXkdf7LY7lm8nZrusag59wFyMVMx05402
	 bHe6QDNcnKtW+h4kzBMT7QnsyshVj8w04ul9PekBx9CFXuqtsoDaQHHBFnGhPljnZz
	 lwkORDeGfAw0B/r6rRuNM1Vo57GHtUpkzB8yVE0Ib/uUqVOKrARTZX0d6MoIrXDd42
	 CF4Piz2/zpXcA==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v2] generic/211: verify if the filesystem being tested supports in place writes
Date: Thu, 24 Jul 2025 13:05:59 +0100
Message-ID: <16f6bbbb4422cdb2b5ff0b29dc5d7d45ebff5dcf.1753358594.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <7ba7d315e60388593ccef0353cff58c4b5795615.1753272216.git.fdmanana@suse.com>
References: <7ba7d315e60388593ccef0353cff58c4b5795615.1753272216.git.fdmanana@suse.com>
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

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: Move chattr +C logic into a helper.
    Change "inplace" to "in-place" in a message.

 common/rc         | 71 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/211 |  9 ++----
 2 files changed, 73 insertions(+), 7 deletions(-)

diff --git a/common/rc b/common/rc
index 96578d15..b9292a78 100644
--- a/common/rc
+++ b/common/rc
@@ -5873,6 +5873,77 @@ _require_program() {
 	_have_program "$1" || _notrun "$tag required"
 }
 
+_force_inplace_writes()
+{
+	local file=$1
+
+	if [ -z "$file" ]; then
+		_fail "Usage: _force_inplace_writes <file path>"
+	fi
+
+	case "$FSTYP" in
+	"btrfs")
+		# Set the file to NOCOW mode on btrfs, which must be done while
+		# the file is empty, otherwise it fails with -EINVAL.
+		_require_chattr C
+		$CHATTR_PROG +C "$file"
+		;;
+	esac
+}
+
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
+	_force_inplace_writes "$test_file"
+
+	$XFS_IO_PROG -c "pwrite 0 128K" -c "fsync" "$test_file" &> /dev/null
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
+		_notrun "in-place writes not supported"
+	fi
+}
+
 ################################################################################
 # make sure this script returns success
 /bin/true
diff --git a/tests/generic/211 b/tests/generic/211
index e87d1e01..6eda1608 100755
--- a/tests/generic/211
+++ b/tests/generic/211
@@ -27,15 +27,10 @@ fs_size=$(_small_fs_size_mb 512)
 _try_scratch_mkfs_sized $((fs_size * 1024 * 1024)) >>$seqres.full 2>&1 || \
 	_fail "mkfs failed"
 _scratch_mount
+_require_inplace_writes $SCRATCH_MNT
 
 touch $SCRATCH_MNT/foobar
-
-# Set the file to NOCOW mode on btrfs, which must be done while the file is
-# empty, otherwise it fails.
-if [ $FSTYP == "btrfs" ]; then
-	_require_chattr C
-	$CHATTR_PROG +C $SCRATCH_MNT/foobar
-fi
+_force_inplace_writes $SCRATCH_MNT/foobar
 
 # Add initial data to the file we will later overwrite with mmap.
 $XFS_IO_PROG -c "pwrite -S 0xab 0 1M" $SCRATCH_MNT/foobar | _filter_xfs_io
-- 
2.47.2


