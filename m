Return-Path: <linux-btrfs+bounces-9208-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9AD9B5072
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2024 18:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D455286862
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2024 17:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967CE1DB943;
	Tue, 29 Oct 2024 17:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRlImA1d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88C82107;
	Tue, 29 Oct 2024 17:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730222663; cv=none; b=iZQeFNioZ1i5pYqymG7dtyBoRco4qyxli7b7T4/zuKaTmB0M/4P2mEjK0yjsY/AGwFJBJt4ioukea5hzV+gJNyCZSFf7YtxEA7dDEH6FqvmYeanTQhdkKRHBpux6LDxUu7vcPG8ZTvrkDxxKlhFkkDvBk0zNnNcsisksUdn3HeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730222663; c=relaxed/simple;
	bh=8XkZ/GtBZytV0VIqI7F+ZxWjeCXtpGciY5xt45vcjlE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jt3+FwPBASAOYGbVfSn3jKOxxR+59mbbvWDiQUfHpJ8g9pZYSWUNSfRRtWWdCR4ALd9Uar1XVjq9/+umkN2U53JT0xwfAw58tXpUdXafhvb0tOfYn5a6wzYxIRM1X5acr5pMX05rhDZzYcxX21gTd2PfjlyJGp62FN0wqD14Sfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRlImA1d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE1FC4CECD;
	Tue, 29 Oct 2024 17:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730222663;
	bh=8XkZ/GtBZytV0VIqI7F+ZxWjeCXtpGciY5xt45vcjlE=;
	h=From:To:Cc:Subject:Date:From;
	b=RRlImA1d/aYLwG8CYfuu4jbolisBcBn785U/XnfE5v5t/EA69TdPYhC2e9E0WThEt
	 TVt0xxOXwQFui5qt9T5fwD/PVFmKMaAEa4QISnqzKdss2TU6wW7cyXntm92IC3UDP/
	 UVPjJHbmXw9mqMIWWBt4A3Haj293bqIayTtB1WiqimHmfBFrVUlTQb0JuT9VtBluBi
	 QWiS404V8UYQr+Zdig8/gmUG7GPD08WugX1YU5xQ/RFTOCmC5mzkOkMtGdH2wsi0QF
	 CtjZZj/hcVEo9jU9EejN4RDVlC8H0pB4PF/x6MlXoPfUDnTQehMfMyPQmyircGrDHR
	 7ILU5tzq6zBbw==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: add a test for defrag of contiguous file extents
Date: Tue, 29 Oct 2024 17:23:41 +0000
Message-ID: <e592bcc458f5c2ec41930975003702a667c92a8e.1730220751.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Test that defrag merges adjacent extents that are contiguous.
This exercises a regression fixed by a patchset for the kernel that is
comprissed of the following patches:

  btrfs: fix extent map merging not happening for adjacent extents
  btrfs: fix defrag not merging contiguous extents due to merged extent maps

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/325     | 80 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/325.out | 22 +++++++++++++
 2 files changed, 102 insertions(+)
 create mode 100755 tests/btrfs/325
 create mode 100644 tests/btrfs/325.out

diff --git a/tests/btrfs/325 b/tests/btrfs/325
new file mode 100755
index 00000000..0b1ab3c2
--- /dev/null
+++ b/tests/btrfs/325
@@ -0,0 +1,80 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
+#
+# FS QA Test 325
+#
+# Test that defrag merges adjacent extents that are contiguous.
+#
+. ./common/preamble
+_begin_fstest auto quick preallocrw defrag
+
+. ./common/filter
+
+_require_scratch
+_require_btrfs_command inspect-internal dump-tree
+_require_xfs_io_command "falloc"
+
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: fix extent map merging not happening for adjacent extents"
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: fix defrag not merging contiguous extents due to merged extent maps"
+
+count_file_extent_items()
+{
+	# We count file extent extent items through dump-tree instead of using
+	# fiemap because fiemap merges adjacent extent items when they are
+	# contiguous.
+	# We unmount because all metadata must be ondisk for dump-tree to see
+	# it and work correctly.
+	_scratch_unmount
+	$BTRFS_UTIL_PROG inspect-internal dump-tree -t 5 $SCRATCH_DEV | \
+		grep EXTENT_DATA | wc -l
+	_scratch_mount
+}
+
+_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
+_scratch_mount
+
+# Create a file with a size of 256K and 4 written extents of 64K each.
+# We fallocate to guarantee exact extent size, even if compression mount
+# option is give, and write to them because defrag skips prealloc extents.
+$XFS_IO_PROG -f -c "falloc 0 64K" \
+	     -c "pwrite -S 0xab 0 64K" \
+	     -c "falloc 64K 64K" \
+	     -c "pwrite -S 0xcd 64K 64K" \
+	     -c "falloc 128K 64K" \
+	     -c "pwrite -S 0xef 128K 64K" \
+	     -c "falloc 192K 64K" \
+	     -c "pwrite -S 0x73 192K 64K" \
+	     $SCRATCH_MNT/foo | _filter_xfs_io
+
+echo -n "Initial number of file extent items: "
+count_file_extent_items
+
+# Read the whole file in order to load extent maps and merge them.
+cat $SCRATCH_MNT/foo > /dev/null
+
+# Now defragment with a threshold of 128K. After this we expect to get a file
+# with 1 file extent item - the treshold is 128K but since all the extents are
+# contiguous, they should be merged into a single one of 256K.
+$BTRFS_UTIL_PROG filesystem defragment -t 128K $SCRATCH_MNT/foo
+echo -n "Number of file extent items after defrag with 128K treshold: "
+count_file_extent_items
+
+# Read the whole file in order to load extent maps and merge them.
+cat $SCRATCH_MNT/foo > /dev/null
+
+# Now defragment with a threshold of 256K. After this we expect to get a file
+# with only 1 file extent item.
+$BTRFS_UTIL_PROG filesystem defragment -t 256K $SCRATCH_MNT/foo
+echo -n "Number of file extent items after defrag with 256K treshold: "
+count_file_extent_items
+
+# Check that the file has the expected data, that defrag didn't cause any data
+# loss or corruption.
+echo "File data after defrag:"
+_hexdump $SCRATCH_MNT/foo
+
+status=0
+exit
diff --git a/tests/btrfs/325.out b/tests/btrfs/325.out
new file mode 100644
index 00000000..96053925
--- /dev/null
+++ b/tests/btrfs/325.out
@@ -0,0 +1,22 @@
+QA output created by 325
+wrote 65536/65536 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 65536
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 131072
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 65536/65536 bytes at offset 196608
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+Initial number of file extent items: 4
+Number of file extent items after defrag with 128K treshold: 1
+Number of file extent items after defrag with 256K treshold: 1
+File data after defrag:
+000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab  >................<
+*
+010000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >................<
+*
+020000 ef ef ef ef ef ef ef ef ef ef ef ef ef ef ef ef  >................<
+*
+030000 73 73 73 73 73 73 73 73 73 73 73 73 73 73 73 73  >ssssssssssssssss<
+*
+040000
-- 
2.45.2


