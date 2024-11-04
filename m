Return-Path: <linux-btrfs+bounces-9322-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB71C9BB3AB
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2024 12:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A9981C222D6
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Nov 2024 11:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F681B0F1C;
	Mon,  4 Nov 2024 11:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6/wZDNd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B635C23A6;
	Mon,  4 Nov 2024 11:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730720493; cv=none; b=GgYZMRqug8nfLkHbwxdJLHZeWxlVW0gSrt/E+ozEv7jsPjvdy3kwOh/dWlkCyDQZJCoUackORmZ+vkegTK7R+9uj+TIAg2EdJpSreGz2F30DYCdwWpT+GuxwD0Dz+DQKvI4+0Q0pYFXT9fDaYjyoK9eHWTBev/QAfgmezZZeVAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730720493; c=relaxed/simple;
	bh=fBID/fDXogeNfjCL38YrAn4PXXXNGhZ+nlPIoKwQTq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G5Ej11Xbbe3C2h4UQ/RM/orViNvt8mCoC9cPQVY1nd2iPcj2Omub2369LnbmhiSpfQOl+YaBnya7YpYVZ+doaDFGjk5J8fLRE5xRzil2GBquDnbbeP+aK43gSlZ1WdYlCdUWvA2igY5SwsmgEOdYK6kdVPLfWZhIoRo/+ASsaT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6/wZDNd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0979BC4CECE;
	Mon,  4 Nov 2024 11:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730720493;
	bh=fBID/fDXogeNfjCL38YrAn4PXXXNGhZ+nlPIoKwQTq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D6/wZDNdWMVzdkE601psMCIAds/gRgP3RkMcQIivcJvTKqX2RLalywnuweRu0bk2q
	 Gte0sqngYF2tcdv2pdC2F0L5adSckyGS6K4xHj4HVtEbrMQ7tMsWY2f//utUphpihH
	 bt69eJykV2JwKsKLV7mdChyTjf8J5evCj8BpLJna5KvUk/y/jYjybOj9C68einzYSE
	 Is6AhxYaG6BMsxjL9nUtj5xSCEYoqyikWCBSYcnPfQ+f/5jEiOBQVERymCaA80+P+6
	 RKXz9Y7cqq4TpDy4/bt4ZWzWcM1pkuejDnquUeyx5be1qJlvIFSkT49QA0Zv264GAf
	 84pekgwwkLo+A==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>,
	Qu Wenruo <wqu@suse.com>
Subject: [PATCH v3] btrfs: add a test for defrag of contiguous file extents
Date: Mon,  4 Nov 2024 11:41:23 +0000
Message-ID: <92697a8420a5c756acfe247352419562793a2196.1730720132.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <e592bcc458f5c2ec41930975003702a667c92a8e.1730220751.git.fdmanana@suse.com>
References: <e592bcc458f5c2ec41930975003702a667c92a8e.1730220751.git.fdmanana@suse.com>
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

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V3: Add git commit IDs, the patches were merged into Linus' tree (6.12-rc6).

V2: Fix typo (treshold -> threshold), make the test be skipped if compression
    is enabled.

 tests/btrfs/325     | 83 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/325.out | 22 ++++++++++++
 2 files changed, 105 insertions(+)
 create mode 100755 tests/btrfs/325
 create mode 100644 tests/btrfs/325.out

diff --git a/tests/btrfs/325 b/tests/btrfs/325
new file mode 100755
index 00000000..ad86bae5
--- /dev/null
+++ b/tests/btrfs/325
@@ -0,0 +1,83 @@
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
+# We want to test getting a 256K extent after defrag, so skip the test if
+# compression is enabled (with compression the maximum extent size is 128K).
+_require_no_compress
+
+_fixed_by_kernel_commit a0f062539085 \
+	"btrfs: fix extent map merging not happening for adjacent extents"
+_fixed_by_kernel_commit 77b0d113eec4 \
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
+# with 1 file extent item - the threshold is 128K but since all the extents are
+# contiguous, they should be merged into a single one of 256K.
+$BTRFS_UTIL_PROG filesystem defragment -t 128K $SCRATCH_MNT/foo
+echo -n "Number of file extent items after defrag with 128K threshold: "
+count_file_extent_items
+
+# Read the whole file in order to load extent maps and merge them.
+cat $SCRATCH_MNT/foo > /dev/null
+
+# Now defragment with a threshold of 256K. After this we expect to get a file
+# with only 1 file extent item.
+$BTRFS_UTIL_PROG filesystem defragment -t 256K $SCRATCH_MNT/foo
+echo -n "Number of file extent items after defrag with 256K threshold: "
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
index 00000000..c0df8137
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
+Number of file extent items after defrag with 128K threshold: 1
+Number of file extent items after defrag with 256K threshold: 1
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


