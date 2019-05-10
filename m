Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFC919C55
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2019 13:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfEJLPy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 May 2019 07:15:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:50514 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727222AbfEJLPy (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 May 2019 07:15:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1E934AF86
        for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2019 11:15:52 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 03/17] btrfs: use btrfs_crc32c() instead of btrfs_extref_hash()
Date:   Fri, 10 May 2019 13:15:33 +0200
Message-Id: <20190510111547.15310-4-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190510111547.15310-1-jthumshirn@suse.de>
References: <20190510111547.15310-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Like btrfs_crc32c() btrfs_extref_hash() is only a shim wrapper over the
crc32c() library function. So we can just use btrfs_crc32c() instead of
btrfs_extref_hash().

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 fs/btrfs/ctree.h      | 9 ---------
 fs/btrfs/inode-item.c | 6 +++---
 fs/btrfs/tree-log.c   | 6 +++---
 3 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index d85541f13f65..a3479a4e4f4d 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2659,15 +2659,6 @@ static inline u64 btrfs_name_hash(const char *name, int len)
        return crc32c((u32)~1, name, len);
 }
 
-/*
- * Figure the key offset of an extended inode ref
- */
-static inline u64 btrfs_extref_hash(u64 parent_objectid, const char *name,
-                                   int len)
-{
-       return (u64) crc32c(parent_objectid, name, len);
-}
-
 static inline bool btrfs_mixed_space_info(struct btrfs_space_info *space_info)
 {
 	return ((space_info->flags & BTRFS_BLOCK_GROUP_METADATA) &&
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 30d62ef918b9..d2b2a64a1553 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -91,7 +91,7 @@ btrfs_lookup_inode_extref(struct btrfs_trans_handle *trans,
 
 	key.objectid = inode_objectid;
 	key.type = BTRFS_INODE_EXTREF_KEY;
-	key.offset = btrfs_extref_hash(ref_objectid, name, name_len);
+	key.offset = (u64) btrfs_crc32c(ref_objectid, name, name_len);
 
 	ret = btrfs_search_slot(trans, root, &key, path, ins_len, cow);
 	if (ret < 0)
@@ -123,7 +123,7 @@ static int btrfs_del_inode_extref(struct btrfs_trans_handle *trans,
 
 	key.objectid = inode_objectid;
 	key.type = BTRFS_INODE_EXTREF_KEY;
-	key.offset = btrfs_extref_hash(ref_objectid, name, name_len);
+	key.offset = (u64) btrfs_crc32c(ref_objectid, name, name_len);
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -272,7 +272,7 @@ static int btrfs_insert_inode_extref(struct btrfs_trans_handle *trans,
 
 	key.objectid = inode_objectid;
 	key.type = BTRFS_INODE_EXTREF_KEY;
-	key.offset = btrfs_extref_hash(ref_objectid, name, name_len);
+	key.offset = (u64) btrfs_crc32c(ref_objectid, name, name_len);
 
 	path = btrfs_alloc_path();
 	if (!path)
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 6adcd8a2c5c7..f01c6e1a15ed 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1111,7 +1111,7 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 
 			search_key.objectid = inode_objectid;
 			search_key.type = BTRFS_INODE_EXTREF_KEY;
-			search_key.offset = btrfs_extref_hash(parent_objectid,
+			search_key.offset = (u64) btrfs_crc32c(parent_objectid,
 							      victim_name,
 							      victim_name_len);
 			ret = 0;
@@ -1323,7 +1323,7 @@ static int btrfs_inode_ref_exists(struct inode *inode, struct inode *dir,
 	if (key.type == BTRFS_INODE_REF_KEY)
 		key.offset = parent_id;
 	else
-		key.offset = btrfs_extref_hash(parent_id, name, namelen);
+		key.offset = (u64) btrfs_crc32c(parent_id, name, namelen);
 
 	ret = btrfs_search_slot(NULL, BTRFS_I(inode)->root, &key, path, 0, 0);
 	if (ret < 0)
@@ -1901,7 +1901,7 @@ static bool name_in_log_ref(struct btrfs_root *log_root,
 		return true;
 
 	search_key.type = BTRFS_INODE_EXTREF_KEY;
-	search_key.offset = btrfs_extref_hash(dirid, name, name_len);
+	search_key.offset = (u64) btrfs_crc32c(dirid, name, name_len);
 	if (backref_in_log(log_root, &search_key, dirid, name, name_len))
 		return true;
 
-- 
2.16.4

