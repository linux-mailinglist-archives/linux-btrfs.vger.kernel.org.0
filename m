Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53BCA9E6FF
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 13:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbfH0Lqf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 07:46:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:42066 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727380AbfH0Lqf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 07:46:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4B999B011
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 11:46:33 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 1/3] btrfs: Make btrfs_find_name_in_backref return btrfs_inode_ref struct
Date:   Tue, 27 Aug 2019 14:46:28 +0300
Message-Id: <20190827114630.2425-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190827114630.2425-1-nborisov@suse.com>
References: <20190827114630.2425-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_find_name_in_backref returns either 0/1 depending on whether it
found a backref for the given name. If it returns true then the actual
inode_ref struct is returned in one of its parameters. That's pointless,
instead refactor the function such that it returns either a pointer
to the btrfs_inode_ref or NULL it it didn't find anything. This
streamlines the function calling convention.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.h      |  6 +++---
 fs/btrfs/inode-item.c | 29 ++++++++++++++---------------
 fs/btrfs/tree-log.c   |  4 ++--
 3 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 6052f7403032..11312aeb6ff6 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2860,9 +2860,9 @@ btrfs_lookup_inode_extref(struct btrfs_trans_handle *trans,
 			  u64 inode_objectid, u64 ref_objectid, int ins_len,
 			  int cow);
 
-int btrfs_find_name_in_backref(struct extent_buffer *leaf, int slot,
-			       const char *name,
-			       int name_len, struct btrfs_inode_ref **ref_ret);
+struct btrfs_inode_ref *btrfs_find_name_in_backref(struct extent_buffer *leaf,
+						   int slot, const char *name,
+						   int name_len);
 int btrfs_find_name_in_ext_backref(struct extent_buffer *leaf, int slot,
 				   u64 ref_objectid, const char *name,
 				   int name_len,
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 30d62ef918b9..6f43bedd3700 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -8,9 +8,9 @@
 #include "transaction.h"
 #include "print-tree.h"
 
-int btrfs_find_name_in_backref(struct extent_buffer *leaf, int slot,
-			       const char *name,
-			       int name_len, struct btrfs_inode_ref **ref_ret)
+struct btrfs_inode_ref *btrfs_find_name_in_backref(struct extent_buffer *leaf,
+						   int slot, const char *name,
+						   int name_len)
 {
 	struct btrfs_inode_ref *ref;
 	unsigned long ptr;
@@ -28,13 +28,10 @@ int btrfs_find_name_in_backref(struct extent_buffer *leaf, int slot,
 		cur_offset += len + sizeof(*ref);
 		if (len != name_len)
 			continue;
-		if (memcmp_extent_buffer(leaf, name, name_ptr, name_len) == 0) {
-			if (ref_ret)
-				*ref_ret = ref;
-			return 1;
-		}
+		if (memcmp_extent_buffer(leaf, name, name_ptr, name_len) == 0)
+			return ref;
 	}
-	return 0;
+	return NULL;
 }
 
 int btrfs_find_name_in_ext_backref(struct extent_buffer *leaf, int slot,
@@ -213,8 +210,10 @@ int btrfs_del_inode_ref(struct btrfs_trans_handle *trans,
 	} else if (ret < 0) {
 		goto out;
 	}
-	if (!btrfs_find_name_in_backref(path->nodes[0], path->slots[0],
-					name, name_len, &ref)) {
+
+	ref = btrfs_find_name_in_backref(path->nodes[0], path->slots[0], name,
+					 name_len);
+	if (!ref) {
 		ret = -ENOENT;
 		search_ext_refs = 1;
 		goto out;
@@ -341,9 +340,9 @@ int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
 				      ins_len);
 	if (ret == -EEXIST) {
 		u32 old_size;
-
-		if (btrfs_find_name_in_backref(path->nodes[0], path->slots[0],
-					       name, name_len, &ref))
+		ref = btrfs_find_name_in_backref(path->nodes[0], path->slots[0],
+					       name, name_len);
+		if (ref)
 			goto out;
 
 		old_size = btrfs_item_size_nr(path->nodes[0], path->slots[0]);
@@ -359,7 +358,7 @@ int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
 		if (ret == -EOVERFLOW) {
 			if (btrfs_find_name_in_backref(path->nodes[0],
 						       path->slots[0],
-						       name, name_len, &ref))
+						       name, name_len))
 				ret = -EEXIST;
 			else
 				ret = -EMLINK;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 19a4b9dc669f..12151eb81976 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1271,7 +1271,7 @@ static int unlink_old_inode_refs(struct btrfs_trans_handle *trans,
 							     namelen, NULL);
 		else
 			ret = btrfs_find_name_in_backref(log_eb, log_slot, name,
-							 namelen, NULL);
+							 namelen) != NULL;
 
 		if (!ret) {
 			struct inode *dir;
@@ -1338,7 +1338,7 @@ static int btrfs_inode_ref_exists(struct inode *inode, struct inode *dir,
 						     name, namelen, NULL);
 	else
 		ret = btrfs_find_name_in_backref(path->nodes[0], path->slots[0],
-						 name, namelen, NULL);
+						 name, namelen) != NULL;
 
 out:
 	btrfs_free_path(path);
-- 
2.17.1

