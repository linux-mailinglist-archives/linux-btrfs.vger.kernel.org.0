Return-Path: <linux-btrfs+bounces-18433-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4DFC231F0
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 04:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B595C4EF34A
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Oct 2025 03:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160BC2F29;
	Fri, 31 Oct 2025 03:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="bpW2WvIF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923D01373
	for <linux-btrfs@vger.kernel.org>; Fri, 31 Oct 2025 03:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.23.38.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761879991; cv=none; b=J6VSKRALI7ehk4SQb6EpAuxOcD5BTP8Nn7hTFzZxR6e5jjjYNJ9KCE4KevzzbAcwy97WEwtyxIJTH2faacr+Kw60xMlz/tBLSNrBBRU/42A6C8xf3ILFSLg/DM7rPQsfPwoMs3ben/E1nP/6+kfesZbTDAjmD7Rl6JQERE52lEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761879991; c=relaxed/simple;
	bh=FvGF0u7noyhe75he7SqvkannH30PceaUHE5fz6r3cLE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=NIElYhaSSyiZHovln5DqoaZ0Ca8BzyPDCJpHPwtbkmFgoj23pl3iNHQnxfPP1HHAicgEBRrh9+EFNs6OZ3C9NoPMf7gS4VUIZiNJnCFUsWsEKety3fi3luMdBw9LUpyo1BPSQlHqM1KEASoIlpGVxTZoKxNwF/+rGNQ6JEmDmdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=bpW2WvIF; arc=none smtp.client-ip=211.23.38.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synology.com
Received: from vbm-austinchang.. (unknown [10.17.211.34])
	by mail.synology.com (Postfix) with ESMTPA id 4cyQqJ6qgHzDfHckr;
	Fri, 31 Oct 2025 11:06:20 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
	t=1761879981; bh=FvGF0u7noyhe75he7SqvkannH30PceaUHE5fz6r3cLE=;
	h=From:To:Cc:Subject:Date;
	b=bpW2WvIFt1YmLHgQBxPe54wDoM3LdmhtGYoCDUSFW+YX3LU1ITcoqdkYqVtvzOeZs
	 +ntwMr3Qpd/Q242hmPClfh3GKhKusbqP1SrXJY5FTeFhPr9w4KwW/+13qrq6CI/GQt
	 N5qir58hKmK6W75adK9XWFdZSiYhTth9jXybGBOY=
From: austinchang <austinchang@synology.com>
To: dsterba@suse.com,
	linux-btrfs@vger.kernel.org
Cc: robbieko@synology.com,
	austinchang@synology.com,
	fdmanana@kernel.org
Subject: [PATCH] fstests: btrfs: add test for fallocate on prealloc extents
Date: Fri, 31 Oct 2025 03:06:06 +0000
Message-Id: <20251031030606.2972296-1-austinchang@synology.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-MCP-Status: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Spam-Flag: no
X-Synology-Virus-Status: no
Content-Type: text/plain

In subvolume without no_holes feature, following sequence can produce
incorrect i_size for a file:

1. Allocate an extent at the offset larger than the i_size of the file.
2. Unmount then mount back the volume.
3. Perform fallocate on the preallocated range to increase the i_size.
4. The i_size won't reflect the fallocate in 3. after umount then
   mount.

The bug exists since the file_extent_tree has been introduced:
41a2ee75aab0 ("btrfs: introduce per-inode file extent tree")
And became hidden since
3d7db6e8bd22 ("btrfs: don't allocate file extent tree for non regular files")
Then became visible again after
8679d2687c35 ("btrfs: initialize inode::file_extent_tree after i_mode has been set").

The test creates the file with the extents mentioned above and verify
that the file size is consistent after unmount and mount.

Signed-off-by: austinchang <austinchang@synology.com>
---
 tests/btrfs/338     | 48 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/338.out |  3 +++
 2 files changed, 51 insertions(+)
 create mode 100755 tests/btrfs/338
 create mode 100755 tests/btrfs/338.out

diff --git a/tests/btrfs/338 b/tests/btrfs/338
new file mode 100755
index 00000000..565a5ae2
--- /dev/null
+++ b/tests/btrfs/338
@@ -0,0 +1,48 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Synology Inc.  All Rights Reserved.
+#
+# FS QA Test 338
+#
+# Tests the file size when the fallocate is performed on prealloc extents
+# that start after i_size.
+#
+. ./common/preamble
+_begin_fstest auto quick prealloc
+
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"btrfs: mark dirty bit for out of bound prealloc extents"
+
+. ./common/filter
+
+_require_btrfs_mkfs_feature "no-holes"
+
+_scratch_mkfs -O ^no-holes >>$seqres.full 2>&1
+_scratch_mount || _fail "mount failed"
+
+touch $SCRATCH_MNT/file1
+
+# Add a 2M extent at the file offset 1M without increasing i_size
+fallocate -n -o 1M -l 2M $SCRATCH_MNT/file1
+
+# Unmount and mount again to clear the in-memory extent tree
+_scratch_unmount
+_scratch_mount
+
+# Use a length that doesn't trigger realloc of the 2M extent before
+len=$((1 * 1024 * 1024))
+
+# fallocate on the prealloc extent to change i_size
+fallocate -o 1M -l $len $SCRATCH_MNT/file1
+
+du --bytes $SCRATCH_MNT/file1| cut -f1
+
+_scratch_unmount
+_scratch_mount
+
+# The file size should be the same as before
+du --bytes $SCRATCH_MNT/file1| cut -f1
+
+_scratch_unmount
+
+_exit 0
diff --git a/tests/btrfs/338.out b/tests/btrfs/338.out
new file mode 100755
index 00000000..0edd2502
--- /dev/null
+++ b/tests/btrfs/338.out
@@ -0,0 +1,3 @@
+QA output created by 338
+2097152
+2097152
-- 
2.34.1


Disclaimer: The contents of this e-mail message and any attachments are confidential and are intended solely for addressee. The information may also be legally privileged. This transmission is sent in trust, for the sole purpose of delivery to the intended recipient. If you have received this transmission in error, any use, reproduction or dissemination of this transmission is strictly prohibited. If you are not the intended recipient, please immediately notify the sender by reply e-mail or phone and delete this message and its attachments, if any.

