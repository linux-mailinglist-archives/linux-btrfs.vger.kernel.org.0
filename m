Return-Path: <linux-btrfs+bounces-18394-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D56D5C19802
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Oct 2025 10:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B75B565DA5
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Oct 2025 09:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523243314B6;
	Wed, 29 Oct 2025 09:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="AudExk0J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A657E326D50
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 09:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.23.38.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730944; cv=none; b=HR7lK1nnwqV9EGDss5ZmFUbgbh+H+AUTufPvmGLtWGSqCVWVSuqu1DGJjNh1dD15bTPX77hR2b3/FHNcbz4pZqvXQxWm/1dZpC8KBRI6IxWDfkweqje6Dh7rmGKezh5mbzJPITHFJlCu3GFOxF6Xz/ihxLfvTC0nuqoyGb6vcss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730944; c=relaxed/simple;
	bh=6KI3CCdMXGtkzzOKKUqx1iAsCicCYzD38PRmiTEpBYw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GSnRY+rzJDwDukxdBrno3AXCnOiryfKSWf+e+x3618G6JZo3SPelH4hN/cZ8HboFIrOZQ6TOeFPejKJV1EeCPBB34yy/xt64hbdLwnSHKG5FS6dAJ/TvO6Pekx6zupQfkl63KboQQIgeHFDyO18SSbilmbo9H5TMJT6aVtTkQmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=AudExk0J; arc=none smtp.client-ip=211.23.38.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synology.com
Received: from vbm-austinchang.. (unknown [10.17.211.34])
	by mail.synology.com (Postfix) with ESMTPA id 4cxMYz5FXmzDcTQV3;
	Wed, 29 Oct 2025 17:36:07 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
	t=1761730567; bh=6KI3CCdMXGtkzzOKKUqx1iAsCicCYzD38PRmiTEpBYw=;
	h=From:To:Cc:Subject:Date;
	b=AudExk0JKpvpiAK7CG50juV/pngOt4SOZx0iflxYh8bXh2VGGKsmCLi62dnlZ/qff
	 MZz/XoIFxQ8ZWRU5xwtU4gsHPjGT2saWSDrQD1kFU+po1altWVqBTYKs+0akqxmSNV
	 ac0kZ7RvzsDdGkja19SsyV6ptHmsepMvZ1ClcV4k=
From: austinchang <austinchang@synology.com>
To: dsterba@suse.com,
	linux-btrfs@vger.kernel.org
Cc: robbieko@synology.com,
	austinchang@synology.com,
	fdmanana@kernel.org
Subject: [PATCH v2] btrfs: mark dirty bit for out of bound prealloc extents
Date: Wed, 29 Oct 2025 09:35:27 +0000
Message-Id: <20251029093527.2938961-1-austinchang@synology.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-Spam-Flag: no
X-Synology-Virus-Status: no
X-Synology-MCP-Status: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
Content-Type: text/plain

In btrfs_fallocate(), when the allocated range overlaps with a prealloc
extent and the extent starts after i_size, the range doesn't get marked
dirty in file_extent_tree.

This is reproducible since the commit
41a2ee75aab0 ("btrfs: introduce per-inode file extent tree"),
and became hidden since
3d7db6e8bd22 ("btrfs: don't allocate file extent tree for non regular files")
stops initializing file_extent_tree.

The following reproducer triggers the problem:
$ cat test.sh
#!/bin/sh

MNT=/mnt/test
DEV=/dev/vdb

mkdir -p $MNT

mkfs.btrfs -f -O ^no-holes $DEV
mount $DEV $MNT

touch $MNT/file1
# Add a 2M extent at the file offset 1M without increasing i_size
fallocate -n -o 1M -l 2M $MNT/file1

# Unmount and mount again to clear the in-memory extent tree
umount $MNT
mount $DEV $MNT

# Use a length that doesn't trigger realloc of the 2M extent before
len=$((1 * 1024 * 1024))

# fallocate on the prealloc extent to change i_size
fallocate -o 1M -l $len $MNT/file1

# Check the file size, expecting 2M
du --bytes $MNT/file1

# Unmount and mount again the fs.
umount $MNT
mount $DEV $MNT

# The file size should be the same as before
du --bytes $MNT/file1

umount $MNT

Running the reproducer gives the following result:

$ ./test.sh
(...)
2097152 /mnt/test/file1
1048576 /mnt/test/file1

The difference is exactly 1048576 as we assigned.

Fix by adding a call to btrfs_inode_set_file_extent_range() in
btrfs_fallocate_update_isize().

Fixes: 41a2ee75aab0 ("btrfs: introduce per-inode file extent tree")

Signed-off-by: austinchang <austinchang@synology.com>
---
Changelog:
v2: make a simpler reproducer and move the call of
btrfs_inode_set_file_extent_range().

The snapshot in v1 is to make the extent tree empty for the inode, so
"unmount then mount" can also trigger the issue.

We discovered that the unaligned length is only needed when the punch
hole is present. It will drop and replace the extent to be aligned, and
the later fallocate only marks the range on newly allocated 1M extent,
which is also aligned. Once the punch hole is removed, the requirement
become not to trigger new allocation on the 2M extent initially.

V2 also moves the call of btrfs_inode_set_file_extent_range() into
btrfs_fallocate_update_isize() so that the range can be updated for all
the extent operations that might affect i_size.
---
 fs/btrfs/file.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 204674934..882bb21ad 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2855,12 +2855,23 @@ static int btrfs_fallocate_update_isize(struct inode *inode,
 {
 	struct btrfs_trans_handle *trans;
 	struct btrfs_root *root = BTRFS_I(inode)->root;
+	u64 range_start;
+	u64 range_end;
 	int ret;
 	int ret2;
 
 	if (mode & FALLOC_FL_KEEP_SIZE || end <= i_size_read(inode))
 		return 0;
 
+	range_start = round_down(i_size_read(inode), root->fs_info->sectorsize);
+	range_end = round_up(end, root->fs_info->sectorsize);
+
+	ret = btrfs_inode_set_file_extent_range(BTRFS_I(inode), range_start,
+						range_end - range_start);
+
+	if (ret)
+		return ret;
+
 	trans = btrfs_start_transaction(root, 1);
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
-- 
2.34.1


Disclaimer: The contents of this e-mail message and any attachments are confidential and are intended solely for addressee. The information may also be legally privileged. This transmission is sent in trust, for the sole purpose of delivery to the intended recipient. If you have received this transmission in error, any use, reproduction or dissemination of this transmission is strictly prohibited. If you are not the intended recipient, please immediately notify the sender by reply e-mail or phone and delete this message and its attachments, if any.

