Return-Path: <linux-btrfs+bounces-1782-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C662F83BEBE
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 11:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00628B28A60
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jan 2024 10:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2227F1CABB;
	Thu, 25 Jan 2024 10:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6EZ6VQL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527021CAAB
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jan 2024 10:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706178394; cv=none; b=p4xpV8beGlANflhLot6ebiqe4vLmZPBs3VQ1lZdtb+xhKVYGuCCdJiMcnQodm7j5mJNkkgWJHygEIUoblcjJ/U/+FM0Kq4CNxauxF/0Nxhiy8dS3vX65q5HNYyqOFbZEuXbKnutoQ1fcmePsWPqD9YxfWbJuccWgbhS6bGDoCFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706178394; c=relaxed/simple;
	bh=q8w6+t4lVwp7uvhFKcRbB6tYPld8uu53vdbJ+LipNqE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bHBAji3wQYR0rbpP5k7U6TSkkc9uCZToS9y5FjfR2/FZ+dWbGalv52/rvvERmsY2MxbIn+zMMUTmq+hmfDcaxfiCEvtUl3DquYLrFCDTfaCzTuD8GBhSN0/s5Rb/MTqC+LULtOi2SBag4lVriPQVl5Zjf/k3XNKtv7dV9bJOzqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6EZ6VQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D376C433B1
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Jan 2024 10:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706178393;
	bh=q8w6+t4lVwp7uvhFKcRbB6tYPld8uu53vdbJ+LipNqE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=B6EZ6VQLlfibciDyvehLObAJFyo6btK8pFokuEBsQbmkFx68Bj9X4C7hYah2R+reD
	 goW/HrOjr+YWcUqa5CTBnNoxRRZGc7B3U6wdRM9Ih5odYBzed+/pOj/kIiQUoGkhiH
	 zQtoHp9L8z/kecKd3WjVmSz1TXFYYh4lecs/uCKo7rX+HCfCiaQoFyTp57XeC1gOd6
	 JD/x7itBJjy1Vp3c7mZvtWba06FqO5m34lCrJtRoeP7Te4+4C6mHFfAJnusA+tgv5u
	 k6eCLvRlevzZXMTEDqS90qNWKUDSU5oVlc4gb7Nr0oKGFkU1KbVWLukrF9J7grxAQ7
	 zWYdUQIXCurnA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/5] btrfs: do not delete unused block group if it may be used soon
Date: Thu, 25 Jan 2024 10:26:25 +0000
Message-Id: <46dbefda7220b7f8e5ee89003a98a0465867f4a0.1706177914.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706177914.git.fdmanana@suse.com>
References: <cover.1706177914.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Before deleting a block group that is in the list of unused block groups
(fs_info->unused_bgs), we check if the block group became used before
deleting it, as extents from it may have been allocated after it was added
to the list.

However even if the block group was not yet used, there may be tasks that
have only reserved space and have not yet allocated extents, and they
might be relying on the availability of the unused block group in order
to allocate extents. The reservation works first by increasing the
"bytes_may_use" field of the corresponding space_info object (which may
first require flushing delayed items, allocating a new block group, etc),
and only later a task does the actual allocation of extents.

For metadata we usually don't end up using all reserved space, as we are
pessimistic and typically account for the worst cases (need to COW every
single node in a path of a tree at maximum possible height, etc). For
data we usually reserve the exact amount of space we're going to allocate
later, except when using compression where we always reserve space based
on the uncompressed size, as compression is only triggered when writeback
starts so we don't know in advance how much space we'll actually need, or
if the data is compressible.

So don't delete an unused block group if the total size of its space_info
object minus the block group's size is less then the sum of used space and
space that may be used (space_info->bytes_may_use), as that means we have
tasks that reserved space and may need to allocate extents from the block
group. In this case, besides skipping the deletion, re-add the block group
to the list of unused block groups so that it may be reconsidered later,
in case the tasks that reserved space end up not needing to allocate
extents from it.

Allowing the deletion of the block group while we have reserved space, can
result in tasks failing to allocate metadata extents (-ENOSPC) while under
a transaction handle, resulting in a transaction abort, or failure during
writeback for the case of data extents.

CC: stable@vger.kernel.org # 6.0+
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 46 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 9daef18bcbbc..5fe37bc82f11 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1455,6 +1455,7 @@ static bool clean_pinned_extents(struct btrfs_trans_handle *trans,
  */
 void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 {
+	LIST_HEAD(retry_list);
 	struct btrfs_block_group *block_group;
 	struct btrfs_space_info *space_info;
 	struct btrfs_trans_handle *trans;
@@ -1476,6 +1477,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 
 	spin_lock(&fs_info->unused_bgs_lock);
 	while (!list_empty(&fs_info->unused_bgs)) {
+		u64 used;
 		int trimming;
 
 		block_group = list_first_entry(&fs_info->unused_bgs,
@@ -1511,6 +1513,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 			goto next;
 		}
 
+		spin_lock(&space_info->lock);
 		spin_lock(&block_group->lock);
 		if (btrfs_is_block_group_used(block_group) || block_group->ro ||
 		    list_is_singular(&block_group->list)) {
@@ -1522,10 +1525,49 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 			 */
 			trace_btrfs_skip_unused_block_group(block_group);
 			spin_unlock(&block_group->lock);
+			spin_unlock(&space_info->lock);
+			up_write(&space_info->groups_sem);
+			goto next;
+		}
+
+		/*
+		 * The block group may be unused but there may be space reserved
+		 * accounting with the existence of that block group, that is,
+		 * space_info->bytes_may_use was incremented by a task but no
+		 * space was yet allocated from the block group by the task.
+		 * That space may or may not be allocated, as we are generally
+		 * pessimistic about space reservation for metadata as well as
+		 * for data when using compression (as we reserve space based on
+		 * the worst case, when data can't be compressed, and before
+		 * actually attempting compression, before starting writeback).
+		 *
+		 * So check if the total space of the space_info minus the size
+		 * of this block group is less than the used space of the
+		 * space_info - if that's the case, then it means we have tasks
+		 * that might be relying on the block group in order to allocate
+		 * extents, and add back the block group to the unused list when
+		 * we finish, so that we retry later in case no tasks ended up
+		 * needing to allocate extents from the block group.
+		 */
+		used = btrfs_space_info_used(space_info, true);
+		if (space_info->total_bytes - block_group->length < used) {
+			/*
+			 * Add a reference for the list, compensate for the ref
+			 * drop under the "next" label for the
+			 * fs_info->unused_bgs list.
+			 */
+			btrfs_get_block_group(block_group);
+			list_add_tail(&block_group->bg_list, &retry_list);
+
+			trace_btrfs_skip_unused_block_group(block_group);
+			spin_unlock(&block_group->lock);
+			spin_unlock(&space_info->lock);
 			up_write(&space_info->groups_sem);
 			goto next;
 		}
+
 		spin_unlock(&block_group->lock);
+		spin_unlock(&space_info->lock);
 
 		/* We don't want to force the issue, only flip if it's ok. */
 		ret = inc_block_group_ro(block_group, 0);
@@ -1649,12 +1691,16 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		btrfs_put_block_group(block_group);
 		spin_lock(&fs_info->unused_bgs_lock);
 	}
+	list_splice_tail(&retry_list, &fs_info->unused_bgs);
 	spin_unlock(&fs_info->unused_bgs_lock);
 	mutex_unlock(&fs_info->reclaim_bgs_lock);
 	return;
 
 flip_async:
 	btrfs_end_transaction(trans);
+	spin_lock(&fs_info->unused_bgs_lock);
+	list_splice_tail(&retry_list, &fs_info->unused_bgs);
+	spin_unlock(&fs_info->unused_bgs_lock);
 	mutex_unlock(&fs_info->reclaim_bgs_lock);
 	btrfs_put_block_group(block_group);
 	btrfs_discard_punt_unused_bgs_list(fs_info);
-- 
2.40.1


