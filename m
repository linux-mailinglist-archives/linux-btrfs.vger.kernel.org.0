Return-Path: <linux-btrfs+bounces-15428-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A195B00985
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jul 2025 19:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33259540AFC
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jul 2025 17:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFCB272E4F;
	Thu, 10 Jul 2025 17:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5Xbls15"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1632242A9D;
	Thu, 10 Jul 2025 17:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752167032; cv=none; b=j3J6Z7GiQweSL0t0mxavXzWZ73oPJ1PEIkJ0cIDM7NWrEQOS4AvQ8BhBUUHCHHxgoF9zRHsiAH4bYefG656Nvda2FcG7as5tZbHe386uqanua4l7d6CTbzeFT2hG1nWK+w1sryOKp2KUt2hESpYuhnMXEOa3cqqXvVgwFGCKW8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752167032; c=relaxed/simple;
	bh=nV1VFkf2rpP2eptpujbimR0fux8oAMd2cQLEOXzdtaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2PNwOzQUgQp9jQLXMThuXVgFPYxy7nYdEjwqaL5loxJUDR+F4UbSmvDthI/AAqeJaZltCvT0zD3L590+0I30zwLtGjSJCWvE6uqxLTPpoqbvSovVlBpSWIeknfh3+Yex56Sj4KA/pnrsq7nFSWH8I4sscFWasZ3zTTnMgFHAYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5Xbls15; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0FFDC4CEE3;
	Thu, 10 Jul 2025 17:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752167031;
	bh=nV1VFkf2rpP2eptpujbimR0fux8oAMd2cQLEOXzdtaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d5Xbls15WU7KS1ehlIjm+DWfcwVMPf6hxR9snwcWrMqzeOHI/mJGqWzbuxm9/QRjT
	 nksZsCWy+/uyUgK0eLOlYe1T9Ny7QrlflZ1eKiQcwnADRXG0CKI3pp0WJ/xaH37A+I
	 wT2fTVXJmtWRdZ4kBIJ0FAY323v02dMu58paoKqiTOgJX55R6hK+iO1DBmvQtRUI7b
	 YfnoC4qqK4EU8vFO5nrrZuA7hhOnO6WCSJ1rkw5Xcl0lp9hJMRf5ymJTROT3jfzWhQ
	 lwqCdFGPyH5YMCRBMzrieBR1+wLATA130+X7zzWhr3rISv3y+WkhwtfJXw0ciKfsfb
	 oCz7Vs5M6qpCA==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2] generic: test overwriting file with mmap on a full filesystem
Date: Thu, 10 Jul 2025 18:03:43 +0100
Message-ID: <681c9dcaca0bf16a694d8f56449618001cf20df6.1752166696.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <f28ef5098ed18d53df6f94faded1b352bb833527.1752049536.git.fdmanana@suse.com>
References: <f28ef5098ed18d53df6f94faded1b352bb833527.1752049536.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Test that overwriting a file with mmap when the filesystem has no more
space available for data allocation works. The motivation here is to check
that NOCOW mode of a COW filesystem (such as btrfs) works as expected.

This currently fails with btrfs but it's fixed by a kernel patch that has
the subject:

   btrfs: fix -ENOSPC mmap write failure on NOCOW files/extents

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: Use _try_scratch_mkfs_sized;
    Use _get_file_block_size instead of _get_block_size;
    Add a more detailed comment about why dd is used to fill the fs.

 tests/generic/211     | 63 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/211.out |  6 +++++
 2 files changed, 69 insertions(+)
 create mode 100755 tests/generic/211
 create mode 100644 tests/generic/211.out

diff --git a/tests/generic/211 b/tests/generic/211
new file mode 100755
index 00000000..e87d1e01
--- /dev/null
+++ b/tests/generic/211
@@ -0,0 +1,63 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 SUSE Linux Products GmbH.  All Rights Reserved.
+#
+# FS QA Test 211
+#
+# Test that overwriting a file with mmap when the filesystem has no more space
+# available for data allocation works. The motivation here is to check that
+# NOCOW mode of a COW filesystem (such as btrfs) works as expected.
+#
+. ./common/preamble
+_begin_fstest auto quick rw mmap
+
+. ./common/filter
+
+_require_scratch
+
+[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: fix -ENOSPC mmap write failure on NOCOW files/extents"
+
+# Use a 512M fs so that it's fast to fill it with data but not too small such
+# that on btrfs it results in a fs with mixed block groups - we want to have
+# dedicated block groups for data and metadata, so that after filling all the
+# data block groups we can do a NOCOW write with mmap (if we have enough free
+# metadata space available).
+fs_size=$(_small_fs_size_mb 512)
+_try_scratch_mkfs_sized $((fs_size * 1024 * 1024)) >>$seqres.full 2>&1 || \
+	_fail "mkfs failed"
+_scratch_mount
+
+touch $SCRATCH_MNT/foobar
+
+# Set the file to NOCOW mode on btrfs, which must be done while the file is
+# empty, otherwise it fails.
+if [ $FSTYP == "btrfs" ]; then
+	_require_chattr C
+	$CHATTR_PROG +C $SCRATCH_MNT/foobar
+fi
+
+# Add initial data to the file we will later overwrite with mmap.
+$XFS_IO_PROG -c "pwrite -S 0xab 0 1M" $SCRATCH_MNT/foobar | _filter_xfs_io
+
+# Now fill all the remaining space with data. We use dd because we want to fill
+# only data space in btrfs - creating files with __populate_fill_fs() would also
+# fill metadata space. We want to exhaust data space on btrfs but still have
+# metadata space available, as metadata is always COWed on btrfs, so that the
+# mmap writes below succeed (metadata space available but no more data space
+# available).
+blksz=$(_get_file_block_size $SCRATCH_MNT)
+dd if=/dev/zero of=$SCRATCH_MNT/filler bs=$blksz >>$seqres.full 2>&1
+
+# Overwrite the file with a mmap write. Should succeed.
+$XFS_IO_PROG -c "mmap -w 0 1M"        \
+	     -c "mwrite -S 0xcd 0 1M" \
+	     -c "munmap"              \
+	     $SCRATCH_MNT/foobar
+
+# Cycle mount and dump the file's content. We expect to see the new data.
+_scratch_cycle_mount
+_hexdump $SCRATCH_MNT/foobar
+
+# success, all done
+_exit 0
diff --git a/tests/generic/211.out b/tests/generic/211.out
new file mode 100644
index 00000000..71cdf0f8
--- /dev/null
+++ b/tests/generic/211.out
@@ -0,0 +1,6 @@
+QA output created by 211
+wrote 1048576/1048576 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+000000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >................<
+*
+100000
-- 
2.47.2


