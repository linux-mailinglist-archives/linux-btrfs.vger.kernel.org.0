Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C31F89E700
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 13:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbfH0Lqg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 07:46:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:42072 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726140AbfH0Lqf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 07:46:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AF664B01E
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 11:46:33 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/3] btrfs: Make btrfs_find_name_in_ext_backref return struct btrfs_inode_extref
Date:   Tue, 27 Aug 2019 14:46:29 +0300
Message-Id: <20190827114630.2425-3-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190827114630.2425-1-nborisov@suse.com>
References: <20190827114630.2425-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_find_name_in_ext_backref returns either 0/1 depending on whether it
found a backref for the given name. If it returns true then the actual
inode_ref struct is returned in one of its parameters. That's pointless,
instead refactor the function such that it returns either a pointer
to the btrfs_inode_extref or NULL it it didn't find anything. This
streamlines the function calling convention.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.h      |  9 ++++-----
 fs/btrfs/inode-item.c | 33 +++++++++++++--------------------
 fs/btrfs/tree-log.c   |  6 +++---
 3 files changed, 20 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 11312aeb6ff6..8b9469df8e3f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2863,11 +2863,10 @@ btrfs_lookup_inode_extref(struct btrfs_trans_handle *trans,
 struct btrfs_inode_ref *btrfs_find_name_in_backref(struct extent_buffer *leaf,
 						   int slot, const char *name,
 						   int name_len);
-int btrfs_find_name_in_ext_backref(struct extent_buffer *leaf, int slot,
-				   u64 ref_objectid, const char *name,
-				   int name_len,
-				   struct btrfs_inode_extref **extref_ret);
-
+struct btrfs_inode_extref *
+btrfs_find_name_in_ext_backref(struct extent_buffer *leaf, int slot,
+			       u64 ref_objectid, const char *name,
+			       int name_len);
 /* file-item.c */
 struct btrfs_dio_private;
 int btrfs_del_csums(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 6f43bedd3700..d1ee56dde758 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -34,10 +34,9 @@ struct btrfs_inode_ref *btrfs_find_name_in_backref(struct extent_buffer *leaf,
 	return NULL;
 }
 
-int btrfs_find_name_in_ext_backref(struct extent_buffer *leaf, int slot,
-				   u64 ref_objectid,
-				   const char *name, int name_len,
-				   struct btrfs_inode_extref **extref_ret)
+struct btrfs_inode_extref *
+btrfs_find_name_in_ext_backref(struct extent_buffer *leaf, int slot,
+			       u64 ref_objectid, const char *name, int name_len)
 {
 	struct btrfs_inode_extref *extref;
 	unsigned long ptr;
@@ -62,15 +61,12 @@ int btrfs_find_name_in_ext_backref(struct extent_buffer *leaf, int slot,
 
 		if (ref_name_len == name_len &&
 		    btrfs_inode_extref_parent(leaf, extref) == ref_objectid &&
-		    (memcmp_extent_buffer(leaf, name, name_ptr, name_len) == 0)) {
-			if (extref_ret)
-				*extref_ret = extref;
-			return 1;
-		}
+		    (memcmp_extent_buffer(leaf, name, name_ptr, name_len) == 0))
+			return extref;
 
 		cur_offset += ref_name_len + sizeof(*extref);
 	}
-	return 0;
+	return NULL;
 }
 
 /* Returns NULL if no extref found */
@@ -84,7 +80,6 @@ btrfs_lookup_inode_extref(struct btrfs_trans_handle *trans,
 {
 	int ret;
 	struct btrfs_key key;
-	struct btrfs_inode_extref *extref;
 
 	key.objectid = inode_objectid;
 	key.type = BTRFS_INODE_EXTREF_KEY;
@@ -95,11 +90,9 @@ btrfs_lookup_inode_extref(struct btrfs_trans_handle *trans,
 		return ERR_PTR(ret);
 	if (ret > 0)
 		return NULL;
-	if (!btrfs_find_name_in_ext_backref(path->nodes[0], path->slots[0],
-					    ref_objectid, name, name_len,
-					    &extref))
-		return NULL;
-	return extref;
+	return btrfs_find_name_in_ext_backref(path->nodes[0], path->slots[0],
+					      ref_objectid, name, name_len);
+
 }
 
 static int btrfs_del_inode_extref(struct btrfs_trans_handle *trans,
@@ -139,9 +132,9 @@ static int btrfs_del_inode_extref(struct btrfs_trans_handle *trans,
 	 * This should always succeed so error here will make the FS
 	 * readonly.
 	 */
-	if (!btrfs_find_name_in_ext_backref(path->nodes[0], path->slots[0],
-					    ref_objectid,
-					    name, name_len, &extref)) {
+	extref = btrfs_find_name_in_ext_backref(path->nodes[0], path->slots[0],
+						ref_objectid, name, name_len);
+	if (!extref) {
 		btrfs_handle_fs_error(root->fs_info, -ENOENT, NULL);
 		ret = -EROFS;
 		goto out;
@@ -284,7 +277,7 @@ static int btrfs_insert_inode_extref(struct btrfs_trans_handle *trans,
 		if (btrfs_find_name_in_ext_backref(path->nodes[0],
 						   path->slots[0],
 						   ref_objectid,
-						   name, name_len, NULL))
+						   name, name_len))
 			goto out;
 
 		btrfs_extend_item(path, ins_len);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 12151eb81976..7d45a4869bc9 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -967,7 +967,7 @@ static noinline int backref_in_log(struct btrfs_root *log,
 		if (btrfs_find_name_in_ext_backref(path->nodes[0],
 						   path->slots[0],
 						   ref_objectid,
-						   name, namelen, NULL))
+						   name, namelen))
 			match = 1;
 
 		goto out;
@@ -1268,7 +1268,7 @@ static int unlink_old_inode_refs(struct btrfs_trans_handle *trans,
 		if (key->type == BTRFS_INODE_EXTREF_KEY)
 			ret = btrfs_find_name_in_ext_backref(log_eb, log_slot,
 							     parent_id, name,
-							     namelen, NULL);
+							     namelen) != NULL;
 		else
 			ret = btrfs_find_name_in_backref(log_eb, log_slot, name,
 							 namelen) != NULL;
@@ -1335,7 +1335,7 @@ static int btrfs_inode_ref_exists(struct inode *inode, struct inode *dir,
 	if (key.type == BTRFS_INODE_EXTREF_KEY)
 		ret = btrfs_find_name_in_ext_backref(path->nodes[0],
 						     path->slots[0], parent_id,
-						     name, namelen, NULL);
+						     name, namelen) != NULL;
 	else
 		ret = btrfs_find_name_in_backref(path->nodes[0], path->slots[0],
 						 name, namelen) != NULL;
-- 
2.17.1

