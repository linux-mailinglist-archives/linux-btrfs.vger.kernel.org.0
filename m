Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9291CDA87
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 May 2020 14:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgEKMyv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 May 2020 08:54:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:33880 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbgEKMyv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 May 2020 08:54:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BBC0AAC12;
        Mon, 11 May 2020 12:54:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A8651DA823; Mon, 11 May 2020 14:53:59 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: remove more obsolete v0 extent ref declarations
Date:   Mon, 11 May 2020 14:53:58 +0200
Message-Id: <20200511125358.775-1-dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The extent references v0 have been superseded long time go, there are
some unused declarations of access helpers. We can safely remove them
now. The struct btrfs_extent_ref_v0 is not used anywhere, but struct
btrfs_extent_item_v0 is still part of a backward compatibility check in
relocation.c and thus not removed.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h                | 9 ---------
 include/uapi/linux/btrfs_tree.h | 9 ---------
 2 files changed, 18 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0b78ab0213bb..86ec25250ac5 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1648,9 +1648,6 @@ BTRFS_SETGET_FUNCS(extent_generation, struct btrfs_extent_item,
 		   generation, 64);
 BTRFS_SETGET_FUNCS(extent_flags, struct btrfs_extent_item, flags, 64);
 
-BTRFS_SETGET_FUNCS(extent_refs_v0, struct btrfs_extent_item_v0, refs, 32);
-
-
 BTRFS_SETGET_FUNCS(tree_block_level, struct btrfs_tree_block_info, level, 8);
 
 static inline void btrfs_tree_block_key(struct extent_buffer *eb,
@@ -1698,12 +1695,6 @@ static inline u32 btrfs_extent_inline_ref_size(int type)
 	return 0;
 }
 
-BTRFS_SETGET_FUNCS(ref_root_v0, struct btrfs_extent_ref_v0, root, 64);
-BTRFS_SETGET_FUNCS(ref_generation_v0, struct btrfs_extent_ref_v0,
-		   generation, 64);
-BTRFS_SETGET_FUNCS(ref_objectid_v0, struct btrfs_extent_ref_v0, objectid, 64);
-BTRFS_SETGET_FUNCS(ref_count_v0, struct btrfs_extent_ref_v0, count, 32);
-
 /* struct btrfs_node */
 BTRFS_SETGET_FUNCS(key_blockptr, struct btrfs_key_ptr, blockptr, 64);
 BTRFS_SETGET_FUNCS(key_generation, struct btrfs_key_ptr, generation, 64);
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index 8e322e2c7e78..a3f3975df0de 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -519,15 +519,6 @@ struct btrfs_extent_inline_ref {
 	__le64 offset;
 } __attribute__ ((__packed__));
 
-/* old style backrefs item */
-struct btrfs_extent_ref_v0 {
-	__le64 root;
-	__le64 generation;
-	__le64 objectid;
-	__le32 count;
-} __attribute__ ((__packed__));
-
-
 /* dev extents record free space on individual devices.  The owner
  * field points back to the chunk allocation mapping tree that allocated
  * the extent.  The chunk tree uuid field is a way to double check the owner
-- 
2.25.0

