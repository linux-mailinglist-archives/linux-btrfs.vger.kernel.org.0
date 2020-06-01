Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98161EA70C
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 17:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgFAPh6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 11:37:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:34068 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728114AbgFAPh4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 11:37:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 832A4B234;
        Mon,  1 Jun 2020 15:37:57 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 41/46] btrfs: Make btrfs_check_data_free_space take btrfs_inode
Date:   Mon,  1 Jun 2020 18:37:39 +0300
Message-Id: <20200601153744.31891-42-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601153744.31891-1-nborisov@suse.com>
References: <20200601153744.31891-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Instead of calling BTRFS_I on the passed vfs_inode take btrfs_inode directly.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/block-group.c    |  3 ++-
 fs/btrfs/delalloc-space.c | 10 +++++-----
 fs/btrfs/delalloc-space.h |  2 +-
 fs/btrfs/file.c           |  3 ++-
 fs/btrfs/relocation.c     |  3 ++-
 5 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 176e8a292fd1..9ff6d44415ad 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2511,7 +2511,8 @@ static int cache_save_setup(struct btrfs_block_group *block_group,
 	num_pages *= 16;
 	num_pages *= PAGE_SIZE;

-	ret = btrfs_check_data_free_space(inode, &data_reserved, 0, num_pages);
+	ret = btrfs_check_data_free_space(BTRFS_I(inode), &data_reserved, 0,
+					  num_pages);
 	if (ret)
 		goto out_put;

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 776e671902bf..e5580262e4dd 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -237,10 +237,10 @@ int btrfs_alloc_data_chunk_ondemand(struct btrfs_inode *inode, u64 bytes)
 	return 0;
 }

-int btrfs_check_data_free_space(struct inode *inode,
+int btrfs_check_data_free_space(struct btrfs_inode *inode,
 			struct extent_changeset **reserved, u64 start, u64 len)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	int ret;

 	/* align the range */
@@ -248,12 +248,12 @@ int btrfs_check_data_free_space(struct inode *inode,
 	      round_down(start, fs_info->sectorsize);
 	start = round_down(start, fs_info->sectorsize);

-	ret = btrfs_alloc_data_chunk_ondemand(BTRFS_I(inode), len);
+	ret = btrfs_alloc_data_chunk_ondemand(inode, len);
 	if (ret < 0)
 		return ret;

 	/* Use new btrfs_qgroup_reserve_data to reserve precious data space. */
-	ret = btrfs_qgroup_reserve_data(BTRFS_I(inode), reserved, start, len);
+	ret = btrfs_qgroup_reserve_data(inode, reserved, start, len);
 	if (ret < 0)
 		btrfs_free_reserved_data_space_noquota(fs_info, start, len);
 	else
@@ -561,7 +561,7 @@ int btrfs_delalloc_reserve_space(struct inode *inode,
 {
 	int ret;

-	ret = btrfs_check_data_free_space(inode, reserved, start, len);
+	ret = btrfs_check_data_free_space(BTRFS_I(inode), reserved, start, len);
 	if (ret < 0)
 		return ret;
 	ret = btrfs_delalloc_reserve_metadata(BTRFS_I(inode), len);
diff --git a/fs/btrfs/delalloc-space.h b/fs/btrfs/delalloc-space.h
index 853a9ac3de35..2722fb6d2e5b 100644
--- a/fs/btrfs/delalloc-space.h
+++ b/fs/btrfs/delalloc-space.h
@@ -6,7 +6,7 @@
 struct extent_changeset;

 int btrfs_alloc_data_chunk_ondemand(struct btrfs_inode *inode, u64 bytes);
-int btrfs_check_data_free_space(struct inode *inode,
+int btrfs_check_data_free_space(struct btrfs_inode *inode,
 			struct extent_changeset **reserved, u64 start, u64 len);
 void btrfs_free_reserved_data_space(struct btrfs_inode *inode,
 			struct extent_changeset *reserved, u64 start, u64 len);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 3a8b8bda9824..28c18ff5fbc1 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1627,7 +1627,8 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 				fs_info->sectorsize);

 		extent_changeset_release(data_reserved);
-		ret = btrfs_check_data_free_space(inode, &data_reserved, pos,
+		ret = btrfs_check_data_free_space(BTRFS_I(inode),
+						  &data_reserved, pos,
 						  write_bytes);
 		if (ret < 0) {
 			if ((BTRFS_I(inode)->flags & (BTRFS_INODE_NODATACOW |
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index a884addec7bd..fd8710837430 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2590,7 +2590,8 @@ int prealloc_file_extent_cluster(struct inode *inode,
 	BUG_ON(cluster->start != cluster->boundary[0]);
 	inode_lock(inode);

-	ret = btrfs_check_data_free_space(inode, &data_reserved, prealloc_start,
+	ret = btrfs_check_data_free_space(BTRFS_I(inode), &data_reserved,
+					  prealloc_start,
 					  prealloc_end + 1 - prealloc_start);
 	if (ret)
 		goto out;
--
2.17.1

