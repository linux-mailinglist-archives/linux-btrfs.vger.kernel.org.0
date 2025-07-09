Return-Path: <linux-btrfs+bounces-15376-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C64AFE348
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 10:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 748AB3B68E3
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 08:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFA42857CC;
	Wed,  9 Jul 2025 08:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClLTeQdv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF9F280CC1;
	Wed,  9 Jul 2025 08:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752051236; cv=none; b=oEdQ1aVUUBx4kP8OVu8oV92Kyprz7zJOxe/sithzD4YOiIzDXav3VgH5z8JF5wzanq517pZ68GC0DhxXx29emuDaXk+ZBMmBVl/Byy7FlKKE9WPKhzScLMNjibToXSQPcNLVSenCidjUFIFkJk37miGGcuNRqP5Cz5lXMC9NINs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752051236; c=relaxed/simple;
	bh=v3TUmJTakj5rTl0h1QvdlJUzkOrQ4grAhhxPfYtZ2YM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uFuxfwLDSsl1BxSd/xzVtxei0/8jiMJApgzBYCiBqGnv8qjGYUWAoJMPg8IHgWPcKE3ZD0Um2bjhu9t9u41uVIoKE4yBofvnN2YUit1glaBlQUZeWe+XEsDpNbqAgUC0ZKogJeFmpUo3WJe4XBeiOF466jXKJTwNxwkep+ycXj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClLTeQdv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4413AC4CEF0;
	Wed,  9 Jul 2025 08:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752051236;
	bh=v3TUmJTakj5rTl0h1QvdlJUzkOrQ4grAhhxPfYtZ2YM=;
	h=From:To:Cc:Subject:Date:From;
	b=ClLTeQdvQaQqTnCT3WgN7yOIEZjN89V+NIxhrdhm4jMTiYK92GyhjH2owgF7MFhVI
	 nu0jPXW/kYH/Hr/bc5rqw36IQfjGpPL6zX84ds3JP7XR7E5MLJIsrURvWu2JpdDZIl
	 2Ji7PKkqvIN3QpD+y4AWWG4QSxnpsnGff3Kd+kN44ynGRFqagO3gXXI403/bxX/B7P
	 uu0gRdfefTd/yZEVvuOEDPJAZE3kjQQUPFOk5epL0e+gVsXzVcY0GVvoh2pX6vuXxy
	 U+j4ni5BIV0cLUDIieXD4p/v6/aoLlgqCET0hDhsph00toFURjF/MKg+Z8K8kjxy8B
	 B48P3PF+04Esg==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] generic: test overwriting file with mmap on a full filesystem
Date: Wed,  9 Jul 2025 09:53:50 +0100
Message-ID: <f28ef5098ed18d53df6f94faded1b352bb833527.1752049536.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
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
 tests/generic/211     | 58 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/211.out |  6 +++++
 2 files changed, 64 insertions(+)
 create mode 100755 tests/generic/211
 create mode 100644 tests/generic/211.out

diff --git a/tests/generic/211 b/tests/generic/211
new file mode 100755
index 00000000..c77508fe
--- /dev/null
+++ b/tests/generic/211
@@ -0,0 +1,58 @@
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
+_scratch_mkfs_sized $((fs_size * 1024 * 1024)) >>$seqres.full 2>&1 || \
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
+# Now fill all the remaining space with data.
+blksz=$(_get_block_size $SCRATCH_MNT)
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


