Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4747929EE37
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 15:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbgJ2O3R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Oct 2020 10:29:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:45842 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbgJ2O3R (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Oct 2020 10:29:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603981755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/nyECQZyKScZgsF1j5V7RzDMl2+J4LXMdQk111muSuw=;
        b=l84fYPfDEW3I90fc+DmZCm0zdhfR92HFggkspJcqVcCJfmBgARw8EwNbZfSSqMPXxPh25G
        FihseaEAhbpmVsHHRYNvsgkkgkqyMOSqUDkT0mTlboGhb5NQ/MbZd9k0rsszO3/KhBGug+
        lvEoCo25VS2avVn5gcMBpwhMc8WvPpY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 23E8EB90C;
        Thu, 29 Oct 2020 14:29:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2C812DA7CE; Thu, 29 Oct 2020 15:27:40 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 02/10] btrfs: replace div_u64 by shift in free_space_bitmap_size
Date:   Thu, 29 Oct 2020 15:27:40 +0100
Message-Id: <8eeec6dd99180d96b96168d24fc4205c0ed48f36.1603981453.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1603981452.git.dsterba@suse.com>
References: <cover.1603981452.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Change free_space_bitmap_size to take btrfs_fs_info so we can get the
sectorsize_bits to do calculations.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/free-space-tree.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index f09f62e245a0..0f6a2ee6f235 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -136,9 +136,10 @@ static int btrfs_search_prev_slot(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
-static inline u32 free_space_bitmap_size(u64 size, u32 sectorsize)
+static inline u32 free_space_bitmap_size(const struct btrfs_fs_info *fs_info,
+					 u64 size)
 {
-	return DIV_ROUND_UP((u32)div_u64(size, sectorsize), BITS_PER_BYTE);
+	return DIV_ROUND_UP(size >> fs_info->sectorsize_bits, BITS_PER_BYTE);
 }
 
 static unsigned long *alloc_bitmap(u32 bitmap_size)
@@ -200,8 +201,7 @@ int convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
 	int done = 0, nr;
 	int ret;
 
-	bitmap_size = free_space_bitmap_size(block_group->length,
-					     fs_info->sectorsize);
+	bitmap_size = free_space_bitmap_size(fs_info, block_group->length);
 	bitmap = alloc_bitmap(bitmap_size);
 	if (!bitmap) {
 		ret = -ENOMEM;
@@ -290,8 +290,7 @@ int convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
 		u32 data_size;
 
 		extent_size = min(end - i, bitmap_range);
-		data_size = free_space_bitmap_size(extent_size,
-						   fs_info->sectorsize);
+		data_size = free_space_bitmap_size(fs_info, extent_size);
 
 		key.objectid = i;
 		key.type = BTRFS_FREE_SPACE_BITMAP_KEY;
@@ -339,8 +338,7 @@ int convert_free_space_to_extents(struct btrfs_trans_handle *trans,
 	int done = 0, nr;
 	int ret;
 
-	bitmap_size = free_space_bitmap_size(block_group->length,
-					     fs_info->sectorsize);
+	bitmap_size = free_space_bitmap_size(fs_info, block_group->length);
 	bitmap = alloc_bitmap(bitmap_size);
 	if (!bitmap) {
 		ret = -ENOMEM;
@@ -383,8 +381,8 @@ int convert_free_space_to_extents(struct btrfs_trans_handle *trans,
 						     fs_info->sectorsize *
 						     BITS_PER_BYTE);
 				bitmap_cursor = ((char *)bitmap) + bitmap_pos;
-				data_size = free_space_bitmap_size(found_key.offset,
-								   fs_info->sectorsize);
+				data_size = free_space_bitmap_size(fs_info,
+								found_key.offset);
 
 				ptr = btrfs_item_ptr_offset(leaf, path->slots[0] - 1);
 				read_extent_buffer(leaf, bitmap_cursor, ptr,
-- 
2.25.0

