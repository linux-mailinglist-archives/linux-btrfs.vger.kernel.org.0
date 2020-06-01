Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25781EA70A
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 17:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgFAPh5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 11:37:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:34082 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728097AbgFAPh4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 11:37:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 00677B21A;
        Mon,  1 Jun 2020 15:37:56 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 38/46] btrfs: Make btrfs_free_reserved_data_space_noquota take btrfs_fs_info
Date:   Mon,  1 Jun 2020 18:37:36 +0300
Message-Id: <20200601153744.31891-39-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601153744.31891-1-nborisov@suse.com>
References: <20200601153744.31891-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

No point in taking an inode only to get btrfs_fs_info from it, instead take
btrfs_fs_info directly.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/delalloc-space.c | 9 ++++-----
 fs/btrfs/delalloc-space.h | 4 ++--
 fs/btrfs/inode.c          | 7 +++----
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 212dd9648b87..489df364bb04 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -255,7 +255,7 @@ int btrfs_check_data_free_space(struct inode *inode,
 	/* Use new btrfs_qgroup_reserve_data to reserve precious data space. */
 	ret = btrfs_qgroup_reserve_data(BTRFS_I(inode), reserved, start, len);
 	if (ret < 0)
-		btrfs_free_reserved_data_space_noquota(inode, start, len);
+		btrfs_free_reserved_data_space_noquota(fs_info, start, len);
 	else
 		ret = 0;
 	return ret;
@@ -269,10 +269,9 @@ int btrfs_check_data_free_space(struct inode *inode,
  * which we can't sleep and is sure it won't affect qgroup reserved space.
  * Like clear_bit_hook().
  */
-void btrfs_free_reserved_data_space_noquota(struct inode *inode, u64 start,
-					    u64 len)
+void btrfs_free_reserved_data_space_noquota(struct btrfs_fs_info *fs_info,
+					    u64 start, u64 len)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_space_info *data_sinfo;

 	/* Make sure the range is aligned to sectorsize */
@@ -303,7 +302,7 @@ void btrfs_free_reserved_data_space(struct inode *inode,
 	      round_down(start, root->fs_info->sectorsize);
 	start = round_down(start, root->fs_info->sectorsize);

-	btrfs_free_reserved_data_space_noquota(inode, start, len);
+	btrfs_free_reserved_data_space_noquota(btrfs_sb(inode->i_sb), start, len);
 	btrfs_qgroup_free_data(BTRFS_I(inode), reserved, start, len);
 }

diff --git a/fs/btrfs/delalloc-space.h b/fs/btrfs/delalloc-space.h
index 54466fbd7075..57ab719a9a79 100644
--- a/fs/btrfs/delalloc-space.h
+++ b/fs/btrfs/delalloc-space.h
@@ -13,8 +13,8 @@ void btrfs_free_reserved_data_space(struct inode *inode,
 void btrfs_delalloc_release_space(struct inode *inode,
 				  struct extent_changeset *reserved,
 				  u64 start, u64 len, bool qgroup_free);
-void btrfs_free_reserved_data_space_noquota(struct inode *inode, u64 start,
-					    u64 len);
+void btrfs_free_reserved_data_space_noquota(struct btrfs_fs_info *fs_info,
+					    u64 start, u64 len);
 void btrfs_delalloc_release_metadata(struct btrfs_inode *inode, u64 num_bytes,
 				     bool qgroup_free);
 int btrfs_delalloc_reserve_space(struct inode *inode,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ed9ecb46208f..cb27836b3d4f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2063,9 +2063,8 @@ void btrfs_clear_delalloc_extent(struct inode *vfs_inode,
 		if (root->root_key.objectid != BTRFS_DATA_RELOC_TREE_OBJECTID &&
 		    do_list && !(state->state & EXTENT_NORESERVE) &&
 		    (*bits & EXTENT_CLEAR_DATA_RESV))
-			btrfs_free_reserved_data_space_noquota(
-					&inode->vfs_inode,
-					state->start, len);
+			btrfs_free_reserved_data_space_noquota(fs_info,
+							state->start, len);

 		percpu_counter_add_batch(&fs_info->delalloc_bytes, -len,
 					 fs_info->delalloc_batch);
@@ -7228,7 +7227,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 			 * use the existing or preallocated extent, so does not
 			 * need to adjust btrfs_space_info's bytes_may_use.
 			 */
-			btrfs_free_reserved_data_space_noquota(inode, start,
+			btrfs_free_reserved_data_space_noquota(fs_info, start,
 							       len);
 			goto skip_cow;
 		}
--
2.17.1

