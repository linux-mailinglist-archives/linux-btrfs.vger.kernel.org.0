Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833701D5815
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 May 2020 19:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgEORgw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 May 2020 13:36:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:50520 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbgEORgv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 May 2020 13:36:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 75BA4AA7C;
        Fri, 15 May 2020 17:36:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7CDECDA732; Fri, 15 May 2020 19:35:57 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/3] btrfs: open code read_fs_root
Date:   Fri, 15 May 2020 19:35:57 +0200
Message-Id: <14b95caf211745a975543e4cddb6093d1e7745e7.1589563951.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1589563951.git.dsterba@suse.com>
References: <cover.1589563951.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

After the update to btrfs_get_fs_root, read_fs_root has become trivial
wrapper that can be open coded.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/relocation.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 72dc096410cd..722f36343664 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -365,12 +365,6 @@ struct btrfs_root *find_reloc_root(struct btrfs_fs_info *fs_info, u64 bytenr)
 	return btrfs_grab_root(root);
 }
 
-static struct btrfs_root *read_fs_root(struct btrfs_fs_info *fs_info,
-					u64 root_objectid)
-{
-	return btrfs_get_fs_root(fs_info, root_objectid, false);
-}
-
 /*
  * For useless nodes, do two major clean ups:
  *
@@ -1850,7 +1844,8 @@ int prepare_to_merge(struct reloc_control *rc, int err)
 					struct btrfs_root, root_list);
 		list_del_init(&reloc_root->root_list);
 
-		root = read_fs_root(fs_info, reloc_root->root_key.offset);
+		root = btrfs_get_fs_root(fs_info, reloc_root->root_key.offset,
+				false);
 		BUG_ON(IS_ERR(root));
 		BUG_ON(root->reloc_root != reloc_root);
 
@@ -1912,8 +1907,8 @@ void merge_reloc_roots(struct reloc_control *rc)
 					struct btrfs_root, root_list);
 
 		if (btrfs_root_refs(&reloc_root->root_item) > 0) {
-			root = read_fs_root(fs_info,
-					    reloc_root->root_key.offset);
+			root = btrfs_get_fs_root(fs_info,
+					    reloc_root->root_key.offset, false);
 			BUG_ON(IS_ERR(root));
 			BUG_ON(root->reloc_root != reloc_root);
 
@@ -1987,7 +1982,7 @@ static int record_reloc_root_in_trans(struct btrfs_trans_handle *trans,
 	if (reloc_root->last_trans == trans->transid)
 		return 0;
 
-	root = read_fs_root(fs_info, reloc_root->root_key.offset);
+	root = btrfs_get_fs_root(fs_info, reloc_root->root_key.offset, false);
 	BUG_ON(IS_ERR(root));
 	BUG_ON(root->reloc_root != reloc_root);
 	ret = btrfs_record_root_in_trans(trans, root);
@@ -3467,7 +3462,7 @@ struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
 	u64 objectid;
 	int err = 0;
 
-	root = read_fs_root(fs_info, BTRFS_DATA_RELOC_TREE_OBJECTID);
+	root = btrfs_get_fs_root(fs_info, BTRFS_DATA_RELOC_TREE_OBJECTID, false);
 	if (IS_ERR(root))
 		return ERR_CAST(root);
 
@@ -3763,8 +3758,8 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 		list_add(&reloc_root->root_list, &reloc_roots);
 
 		if (btrfs_root_refs(&reloc_root->root_item) > 0) {
-			fs_root = read_fs_root(fs_info,
-					       reloc_root->root_key.offset);
+			fs_root = btrfs_get_fs_root(fs_info,
+					reloc_root->root_key.offset, false);
 			if (IS_ERR(fs_root)) {
 				ret = PTR_ERR(fs_root);
 				if (ret != -ENOENT) {
@@ -3820,7 +3815,8 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 			continue;
 		}
 
-		fs_root = read_fs_root(fs_info, reloc_root->root_key.offset);
+		fs_root = btrfs_get_fs_root(fs_info, reloc_root->root_key.offset,
+					    false);
 		if (IS_ERR(fs_root)) {
 			err = PTR_ERR(fs_root);
 			list_add_tail(&reloc_root->root_list, &reloc_roots);
@@ -3862,7 +3858,8 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 
 	if (err == 0) {
 		/* cleanup orphan inode in data relocation tree */
-		fs_root = read_fs_root(fs_info, BTRFS_DATA_RELOC_TREE_OBJECTID);
+		fs_root = btrfs_get_fs_root(fs_info,
+					BTRFS_DATA_RELOC_TREE_OBJECTID, false);
 		if (IS_ERR(fs_root)) {
 			err = PTR_ERR(fs_root);
 		} else {
-- 
2.25.0

