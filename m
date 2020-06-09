Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85001F37DA
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jun 2020 12:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbgFIKTi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Jun 2020 06:19:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728676AbgFIKTh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Jun 2020 06:19:37 -0400
Received: from debian8.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F04DD2078D
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Jun 2020 10:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591697976;
        bh=2XRX3g3R8uIlE0Y2IL5cfbenXlr/6V5HfNNqRsbq98s=;
        h=From:To:Subject:Date:From;
        b=fbQ0yyc7oL0xnnQ6NCrcjFflYZqMD4fA8jD0AY43L1k5wPUB9+2yoUXYL5ADPjYHk
         OzxsOlBblbefQKBiS341xsgmMh20YSsZvYJJbq2JDDAvr4gHZ6KkAtbm9hSkuMfnDV
         E0CZFy/eVN/q83gLUcz0fTZBu5q3DLSfiQzL5uQU=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] Btrfs: remove the start argument from btrfs_free_reserved_data_space_noquota()
Date:   Tue,  9 Jun 2020 11:19:33 +0100
Message-Id: <20200609101933.29459-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The start argument for btrfs_free_reserved_data_space_noquota() is only
used to make sure the amount of bytes we decrement from the bytes_may_use
counter of the data space_info object is aligned to the filesystem's
sector size. It serves no other purpose.

All its current callers always pass a length argument that is already
aligned to the sector size, so we can make the start argument go away.
In fact its presence makes it impossible to use it in a context where we
just want to free a number of bytes for a range for which either we do
not know its start offset or for freeing multiple ranges at once (which
are not contiguous).

This change is preparatory work for a patch (third patch in this series)
that makes relocation of data block groups that are not full reserve less
data space.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delalloc-space.c | 11 ++++-------
 fs/btrfs/delalloc-space.h |  2 +-
 fs/btrfs/inode.c          |  5 ++---
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 1245739a3a6e..d05648f882ca 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -255,7 +255,7 @@ int btrfs_check_data_free_space(struct inode *inode,
 	/* Use new btrfs_qgroup_reserve_data to reserve precious data space. */
 	ret = btrfs_qgroup_reserve_data(inode, reserved, start, len);
 	if (ret < 0)
-		btrfs_free_reserved_data_space_noquota(inode, start, len);
+		btrfs_free_reserved_data_space_noquota(inode, len);
 	else
 		ret = 0;
 	return ret;
@@ -269,16 +269,13 @@ int btrfs_check_data_free_space(struct inode *inode,
  * which we can't sleep and is sure it won't affect qgroup reserved space.
  * Like clear_bit_hook().
  */
-void btrfs_free_reserved_data_space_noquota(struct inode *inode, u64 start,
+void btrfs_free_reserved_data_space_noquota(struct inode *inode,
 					    u64 len)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_space_info *data_sinfo;
 
-	/* Make sure the range is aligned to sectorsize */
-	len = round_up(start + len, fs_info->sectorsize) -
-	      round_down(start, fs_info->sectorsize);
-	start = round_down(start, fs_info->sectorsize);
+	ASSERT(IS_ALIGNED(len, fs_info->sectorsize));
 
 	data_sinfo = fs_info->data_sinfo;
 	spin_lock(&data_sinfo->lock);
@@ -303,7 +300,7 @@ void btrfs_free_reserved_data_space(struct inode *inode,
 	      round_down(start, root->fs_info->sectorsize);
 	start = round_down(start, root->fs_info->sectorsize);
 
-	btrfs_free_reserved_data_space_noquota(inode, start, len);
+	btrfs_free_reserved_data_space_noquota(inode, len);
 	btrfs_qgroup_free_data(inode, reserved, start, len);
 }
 
diff --git a/fs/btrfs/delalloc-space.h b/fs/btrfs/delalloc-space.h
index 54466fbd7075..fe8c6aafb25b 100644
--- a/fs/btrfs/delalloc-space.h
+++ b/fs/btrfs/delalloc-space.h
@@ -13,7 +13,7 @@ void btrfs_free_reserved_data_space(struct inode *inode,
 void btrfs_delalloc_release_space(struct inode *inode,
 				  struct extent_changeset *reserved,
 				  u64 start, u64 len, bool qgroup_free);
-void btrfs_free_reserved_data_space_noquota(struct inode *inode, u64 start,
+void btrfs_free_reserved_data_space_noquota(struct inode *inode,
 					    u64 len);
 void btrfs_delalloc_release_metadata(struct btrfs_inode *inode, u64 num_bytes,
 				     bool qgroup_free);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e75a77a4e068..2173df2da9c7 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2093,7 +2093,7 @@ void btrfs_clear_delalloc_extent(struct inode *vfs_inode,
 		    (*bits & EXTENT_CLEAR_DATA_RESV))
 			btrfs_free_reserved_data_space_noquota(
 					&inode->vfs_inode,
-					state->start, len);
+					len);
 
 		percpu_counter_add_batch(&fs_info->delalloc_bytes, -len,
 					 fs_info->delalloc_batch);
@@ -7258,8 +7258,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 			 * use the existing or preallocated extent, so does not
 			 * need to adjust btrfs_space_info's bytes_may_use.
 			 */
-			btrfs_free_reserved_data_space_noquota(inode, start,
-							       len);
+			btrfs_free_reserved_data_space_noquota(inode, len);
 			goto skip_cow;
 		}
 	}
-- 
2.11.0

