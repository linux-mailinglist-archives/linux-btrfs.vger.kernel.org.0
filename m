Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780F51EA714
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 17:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgFAPiG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 11:38:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:34073 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728101AbgFAPh4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 11:37:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1248FB21B;
        Mon,  1 Jun 2020 15:37:57 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 39/46] btrfs: Make btrfs_free_reserved_data_space take btrfs_inode
Date:   Mon,  1 Jun 2020 18:37:37 +0300
Message-Id: <20200601153744.31891-40-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601153744.31891-1-nborisov@suse.com>
References: <20200601153744.31891-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It only uses btrfs_inode internally so take it as a parameter.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/delalloc-space.c | 18 +++++++++---------
 fs/btrfs/delalloc-space.h |  2 +-
 fs/btrfs/file.c           | 13 +++++++------
 fs/btrfs/inode.c          |  5 +++--
 fs/btrfs/relocation.c     |  7 ++++---
 5 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 489df364bb04..bf5420ad3af5 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -292,18 +292,18 @@ void btrfs_free_reserved_data_space_noquota(struct btrfs_fs_info *fs_info,
  * This one will handle the per-inode data rsv map for accurate reserved
  * space framework.
  */
-void btrfs_free_reserved_data_space(struct inode *inode,
+void btrfs_free_reserved_data_space(struct btrfs_inode *inode,
 			struct extent_changeset *reserved, u64 start, u64 len)
 {
-	struct btrfs_root *root = BTRFS_I(inode)->root;
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;

 	/* Make sure the range is aligned to sectorsize */
-	len = round_up(start + len, root->fs_info->sectorsize) -
-	      round_down(start, root->fs_info->sectorsize);
-	start = round_down(start, root->fs_info->sectorsize);
+	len = round_up(start + len, fs_info->sectorsize) -
+	      round_down(start, fs_info->sectorsize);
+	start = round_down(start, fs_info->sectorsize);

-	btrfs_free_reserved_data_space_noquota(btrfs_sb(inode->i_sb), start, len);
-	btrfs_qgroup_free_data(BTRFS_I(inode), reserved, start, len);
+	btrfs_free_reserved_data_space_noquota(fs_info, start, len);
+	btrfs_qgroup_free_data(inode, reserved, start, len);
 }

 /**
@@ -566,7 +566,7 @@ int btrfs_delalloc_reserve_space(struct inode *inode,
 		return ret;
 	ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode), len);
 	if (ret < 0)
-		btrfs_free_reserved_data_space(inode, *reserved, start, len);
+		btrfs_free_reserved_data_space(BTRFS_I(inode), *reserved, start, len);
 	return ret;
 }

@@ -587,5 +587,5 @@ void btrfs_delalloc_release_space(struct inode *inode,
 				  u64 start, u64 len, bool qgroup_free)
 {
 	btrfs_delalloc_release_metadata(BTRFS_I(inode), len, qgroup_free);
-	btrfs_free_reserved_data_space(inode, reserved, start, len);
+	btrfs_free_reserved_data_space(BTRFS_I(inode), reserved, start, len);
 }
diff --git a/fs/btrfs/delalloc-space.h b/fs/btrfs/delalloc-space.h
index 57ab719a9a79..16a6f9320e39 100644
--- a/fs/btrfs/delalloc-space.h
+++ b/fs/btrfs/delalloc-space.h
@@ -8,7 +8,7 @@ struct extent_changeset;
 int btrfs_alloc_data_chunk_ondemand(struct btrfs_inode *inode, u64 bytes);
 int btrfs_check_data_free_space(struct inode *inode,
 			struct extent_changeset **reserved, u64 start, u64 len);
-void btrfs_free_reserved_data_space(struct inode *inode,
+void btrfs_free_reserved_data_space(struct btrfs_inode *inode,
 			struct extent_changeset *reserved, u64 start, u64 len);
 void btrfs_delalloc_release_space(struct inode *inode,
 				  struct extent_changeset *reserved,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 2b3e935baabc..71e055800609 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1658,7 +1658,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 				reserve_bytes);
 		if (ret) {
 			if (!only_release_metadata)
-				btrfs_free_reserved_data_space(inode,
+				btrfs_free_reserved_data_space(BTRFS_I(inode),
 						data_reserved, pos,
 						write_bytes);
 			else
@@ -3212,7 +3212,7 @@ static int btrfs_zero_range(struct inode *inode,
 	ret = btrfs_fallocate_update_isize(inode, offset + len, mode);
  out:
 	if (ret && space_reserved)
-		btrfs_free_reserved_data_space(inode, data_reserved,
+		btrfs_free_reserved_data_space(BTRFS_I(inode), data_reserved,
 					       alloc_start, bytes_to_reserve);
 	extent_changeset_free(data_reserved);

@@ -3377,8 +3377,9 @@ static long btrfs_fallocate(struct file *file, int mode,
 			 * range, free reserved data space first, otherwise
 			 * it'll result in false ENOSPC error.
 			 */
-			btrfs_free_reserved_data_space(inode, data_reserved,
-					cur_offset, last_byte - cur_offset);
+			btrfs_free_reserved_data_space(BTRFS_I(inode),
+				data_reserved, cur_offset,
+				last_byte - cur_offset);
 		}
 		free_extent_map(em);
 		cur_offset = last_byte;
@@ -3395,7 +3396,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 					range->len, i_blocksize(inode),
 					offset + len, &alloc_hint);
 		else
-			btrfs_free_reserved_data_space(inode,
+			btrfs_free_reserved_data_space(BTRFS_I(inode),
 					data_reserved, range->start,
 					range->len);
 		list_del(&range->list);
@@ -3416,7 +3417,7 @@ static long btrfs_fallocate(struct file *file, int mode,
 	inode_unlock(inode);
 	/* Let go of our reservation. */
 	if (ret != 0 && !(mode & FALLOC_FL_ZERO_RANGE))
-		btrfs_free_reserved_data_space(inode, data_reserved,
+		btrfs_free_reserved_data_space(BTRFS_I(inode), data_reserved,
 				cur_offset, alloc_end - cur_offset);
 	extent_changeset_free(data_reserved);
 	return ret;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cb27836b3d4f..7c9fc5b0f894 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9618,8 +9618,9 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 			btrfs_end_transaction(trans);
 	}
 	if (clear_offset < end)
-		btrfs_free_reserved_data_space(inode, NULL, clear_offset,
-			end - clear_offset + 1);
+		btrfs_free_reserved_data_space(BTRFS_I(inode), NULL,
+					       clear_offset,
+					       end - clear_offset + 1);
 	return ret;
 }

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index fb1a4af8d307..a884addec7bd 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2606,8 +2606,9 @@ int prealloc_file_extent_cluster(struct inode *inode,
 		lock_extent(&BTRFS_I(inode)->io_tree, start, end);
 		num_bytes = end + 1 - start;
 		if (cur_offset < start)
-			btrfs_free_reserved_data_space(inode, data_reserved,
-					cur_offset, start - cur_offset);
+			btrfs_free_reserved_data_space(BTRFS_I(inode),
+					data_reserved, cur_offset,
+					start - cur_offset);
 		ret = btrfs_prealloc_file_range(inode, 0, start,
 						num_bytes, num_bytes,
 						end + 1, &alloc_hint);
@@ -2618,7 +2619,7 @@ int prealloc_file_extent_cluster(struct inode *inode,
 		nr++;
 	}
 	if (cur_offset < prealloc_end)
-		btrfs_free_reserved_data_space(inode, data_reserved,
+		btrfs_free_reserved_data_space(BTRFS_I(inode), data_reserved,
 				cur_offset, prealloc_end + 1 - cur_offset);
 out:
 	inode_unlock(inode);
--
2.17.1

