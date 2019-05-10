Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9C519C49
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2019 13:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfEJLPy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 May 2019 07:15:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:50512 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727067AbfEJLPy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 May 2019 07:15:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1E8B1AF85
        for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2019 11:15:52 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 04/17] btrfs: use btrfs_crc32c() instead of btrfs_name_hash()
Date:   Fri, 10 May 2019 13:15:34 +0200
Message-Id: <20190510111547.15310-5-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190510111547.15310-1-jthumshirn@suse.de>
References: <20190510111547.15310-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Like btrfs_crc32c() btrfs_name_hash() is only a shim wrapper over the
crc32c() library function. So we can just use btrfs_crc32c() instead of
btrfs_name_hash().

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 fs/btrfs/ctree.h        |  5 -----
 fs/btrfs/dir-item.c     | 10 +++++-----
 fs/btrfs/inode.c        |  6 ++++--
 fs/btrfs/props.c        |  5 +++--
 fs/btrfs/send.c         |  3 ++-
 fs/btrfs/tree-checker.c |  3 ++-
 6 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index a3479a4e4f4d..0a2a377f1640 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2654,11 +2654,6 @@ static inline void btrfs_crc32c_final(u32 crc, u8 *result)
 	put_unaligned_le32(~crc, result);
 }
 
-static inline u64 btrfs_name_hash(const char *name, int len)
-{
-       return crc32c((u32)~1, name, len);
-}
-
 static inline bool btrfs_mixed_space_info(struct btrfs_space_info *space_info)
 {
 	return ((space_info->flags & BTRFS_BLOCK_GROUP_METADATA) &&
diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index 863367c2c620..c8eccc0a2379 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -71,7 +71,7 @@ int btrfs_insert_xattr_item(struct btrfs_trans_handle *trans,
 
 	key.objectid = objectid;
 	key.type = BTRFS_XATTR_ITEM_KEY;
-	key.offset = btrfs_name_hash(name, name_len);
+	key.offset = (u64) btrfs_crc32c((u32)~1, name, name_len);
 
 	data_size = sizeof(*dir_item) + name_len + data_len;
 	dir_item = insert_with_overflow(trans, root, path, &key, data_size,
@@ -122,7 +122,7 @@ int btrfs_insert_dir_item(struct btrfs_trans_handle *trans, const char *name,
 
 	key.objectid = btrfs_ino(dir);
 	key.type = BTRFS_DIR_ITEM_KEY;
-	key.offset = btrfs_name_hash(name, name_len);
+	key.offset = (u64) btrfs_crc32c((u32)~1, name, name_len);
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -190,7 +190,7 @@ struct btrfs_dir_item *btrfs_lookup_dir_item(struct btrfs_trans_handle *trans,
 	key.objectid = dir;
 	key.type = BTRFS_DIR_ITEM_KEY;
 
-	key.offset = btrfs_name_hash(name, name_len);
+	key.offset = (u64) btrfs_crc32c((u32)~1, name, name_len);
 
 	ret = btrfs_search_slot(trans, root, &key, path, ins_len, cow);
 	if (ret < 0)
@@ -219,7 +219,7 @@ int btrfs_check_dir_item_collision(struct btrfs_root *root, u64 dir,
 
 	key.objectid = dir;
 	key.type = BTRFS_DIR_ITEM_KEY;
-	key.offset = btrfs_name_hash(name, name_len);
+	key.offset = (u64) btrfs_crc32c((u32)~1, name, name_len);
 
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 
@@ -353,7 +353,7 @@ struct btrfs_dir_item *btrfs_lookup_xattr(struct btrfs_trans_handle *trans,
 
 	key.objectid = dir;
 	key.type = BTRFS_XATTR_ITEM_KEY;
-	key.offset = btrfs_name_hash(name, name_len);
+	key.offset = (u64) btrfs_crc32c((u32)~1, name, name_len);
 	ret = btrfs_search_slot(trans, root, &key, path, ins_len, cow);
 	if (ret < 0)
 		return ERR_PTR(ret);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b6d549c993f6..db19f113d514 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3548,9 +3548,11 @@ static noinline int acls_after_inode_item(struct extent_buffer *leaf,
 	int scanned = 0;
 
 	if (!xattr_access) {
-		xattr_access = btrfs_name_hash(XATTR_NAME_POSIX_ACL_ACCESS,
+		xattr_access = (u64) btrfs_crc32c((u32)~1,
+					XATTR_NAME_POSIX_ACL_ACCESS,
 					strlen(XATTR_NAME_POSIX_ACL_ACCESS));
-		xattr_default = btrfs_name_hash(XATTR_NAME_POSIX_ACL_DEFAULT,
+		xattr_default = (u64) btrfs_crc32c((u32)~1,
+					XATTR_NAME_POSIX_ACL_DEFAULT,
 					strlen(XATTR_NAME_POSIX_ACL_DEFAULT));
 	}
 
diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
index a9e2e66152ee..10687edbb73d 100644
--- a/fs/btrfs/props.c
+++ b/fs/btrfs/props.c
@@ -41,7 +41,7 @@ find_prop_handler(const char *name,
 	struct prop_handler *h;
 
 	if (!handlers) {
-		u64 hash = btrfs_name_hash(name, strlen(name));
+		u64 hash = (u64) btrfs_crc32c((u32)~1, name, strlen(name));
 
 		handlers = find_prop_handlers_by_hash(hash);
 		if (!handlers)
@@ -445,7 +445,8 @@ void __init btrfs_props_init(void)
 
 	for (i = 0; i < ARRAY_SIZE(prop_handlers); i++) {
 		struct prop_handler *p = &prop_handlers[i];
-		u64 h = btrfs_name_hash(p->xattr_name, strlen(p->xattr_name));
+		u64 h = (u64) btrfs_crc32c((u32)~1, p->xattr_name,
+					   strlen(p->xattr_name));
 
 		hash_add(prop_handlers_ht, &p->node, h);
 	}
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index c029ca6d5eba..76eff609d877 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -3434,7 +3434,8 @@ static int wait_for_dest_dir_move(struct send_ctx *sctx,
 
 	key.objectid = parent_ref->dir;
 	key.type = BTRFS_DIR_ITEM_KEY;
-	key.offset = btrfs_name_hash(parent_ref->name, parent_ref->name_len);
+	key.offset = (u64) btrfs_crc32c((u32)~1, parent_ref->name,
+					parent_ref->name_len);
 
 	ret = btrfs_search_slot(NULL, sctx->parent_root, &key, path, 0, 0);
 	if (ret < 0) {
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 748cd1598255..0cb955bc7566 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -343,7 +343,8 @@ static int check_dir_item(struct extent_buffer *leaf,
 
 			read_extent_buffer(leaf, namebuf,
 					(unsigned long)(di + 1), name_len);
-			name_hash = btrfs_name_hash(namebuf, name_len);
+			name_hash = (u64) btrfs_crc32c((u32)~1, namebuf,
+						       name_len);
 			if (key->offset != name_hash) {
 				dir_item_err(leaf, slot,
 		"name hash mismatch with key, have 0x%016x expect 0x%016llx",
-- 
2.16.4

