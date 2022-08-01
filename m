Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C04586C6C
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Aug 2022 15:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbiHAN6E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Aug 2022 09:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbiHAN6C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 1 Aug 2022 09:58:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6660013CF1
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Aug 2022 06:58:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E63AD61278
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Aug 2022 13:58:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC80C433D7
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Aug 2022 13:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659362280;
        bh=74gZrIuhOm1HYR1n6XfxBr7oe5O/RXpSdFZV3ask5jc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UktZnHrewDR1P04naJ/HUnn43bwBc7+O+qzJLc26pNaSUwORfVlEEQpILOR08P7wN
         IsTuvryyeJucewCzGP2+cIbUASSmtXGshLu8TG43lB1SGmJxL+i97KlncFaJrsFQW7
         dJsM7SAiQ8BwfcZdeYN8ezAHRm1wfeROFVyNkkPDCqGTKzH85IOokWWnkWMbI9qY5V
         N3mf/NkPo4cq4x77nbpK68Gf8FROfgolHrpRd2KdjAg6OJKxzyZ+xnQvLv2bIx6Plc
         06ePhfRwcLlYc1tqD9zhuweggu03zPX0ul+Q7zpH70qDi1+1srJ1+tVCiiWl5iCkRg
         mBxePGeftAXTQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: simplify adding and replacing references during log replay
Date:   Mon,  1 Aug 2022 14:57:53 +0100
Message-Id: <d715abcf6904988f1fdff3e632bf84a89a91e52a.1659361747.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1659361747.git.fdmanana@suse.com>
References: <cover.1659361747.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

During log replay, when adding/replacing inode references, there are two
special cases that have special code for them:

1) When we have an inode with two or more hardlinks in the same directory,
   therefore two or more names incoded in the same inode reference item,
   and one of the hard links gets renamed to the old name of another hard
   link - that is, the index number for a name changes. This was added in
   commit 0d836392cadd55 ("Btrfs: fix mount failure after fsync due to
   hard link recreation"), and is covered by test case generic/502 from
   fstests;

2) When we have several inodes that got renamed to an old name of some
   other inode, in a cascading style. The code to deal with this special
   case was added in commit 6b5fc433a7ad67 ("Btrfs: fix fsync after
   succession of renames of different files"), and is covered by test
   cases generic/526 and generic/527 from fstests.

Both cases can be deal with by making sure __add_inode_ref() is always
called by add_inode_ref() for every name encoded in the inode reference
item, and not just for the first name that has a conflict. With such
change we no longer need that special casing for the two cases mentioned
before. So do those changes.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 164 ++++----------------------------------------
 1 file changed, 13 insertions(+), 151 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index ff786e712f2b..e3db3cbdb97b 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1063,8 +1063,7 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 				  struct btrfs_inode *dir,
 				  struct btrfs_inode *inode,
 				  u64 inode_objectid, u64 parent_objectid,
-				  u64 ref_index, char *name, int namelen,
-				  int *search_done)
+				  u64 ref_index, char *name, int namelen)
 {
 	int ret;
 	char *victim_name;
@@ -1126,19 +1125,12 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 				kfree(victim_name);
 				if (ret)
 					return ret;
-				*search_done = 1;
 				goto again;
 			}
 			kfree(victim_name);
 
 			ptr = (unsigned long)(victim_ref + 1) + victim_name_len;
 		}
-
-		/*
-		 * NOTE: we have searched root tree and checked the
-		 * corresponding ref, it does not need to check again.
-		 */
-		*search_done = 1;
 	}
 	btrfs_release_path(path);
 
@@ -1202,14 +1194,12 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 				kfree(victim_name);
 				if (ret)
 					return ret;
-				*search_done = 1;
 				goto again;
 			}
 			kfree(victim_name);
 next:
 			cur_offset += victim_name_len + sizeof(*extref);
 		}
-		*search_done = 1;
 	}
 	btrfs_release_path(path);
 
@@ -1373,103 +1363,6 @@ static int unlink_old_inode_refs(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static int btrfs_inode_ref_exists(struct inode *inode, struct inode *dir,
-				  const u8 ref_type, const char *name,
-				  const int namelen)
-{
-	struct btrfs_key key;
-	struct btrfs_path *path;
-	const u64 parent_id = btrfs_ino(BTRFS_I(dir));
-	int ret;
-
-	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
-
-	key.objectid = btrfs_ino(BTRFS_I(inode));
-	key.type = ref_type;
-	if (key.type == BTRFS_INODE_REF_KEY)
-		key.offset = parent_id;
-	else
-		key.offset = btrfs_extref_hash(parent_id, name, namelen);
-
-	ret = btrfs_search_slot(NULL, BTRFS_I(inode)->root, &key, path, 0, 0);
-	if (ret < 0)
-		goto out;
-	if (ret > 0) {
-		ret = 0;
-		goto out;
-	}
-	if (key.type == BTRFS_INODE_EXTREF_KEY)
-		ret = !!btrfs_find_name_in_ext_backref(path->nodes[0],
-				path->slots[0], parent_id, name, namelen);
-	else
-		ret = !!btrfs_find_name_in_backref(path->nodes[0], path->slots[0],
-						   name, namelen);
-
-out:
-	btrfs_free_path(path);
-	return ret;
-}
-
-static int add_link(struct btrfs_trans_handle *trans,
-		    struct inode *dir, struct inode *inode, const char *name,
-		    int namelen, u64 ref_index)
-{
-	struct btrfs_root *root = BTRFS_I(dir)->root;
-	struct btrfs_dir_item *dir_item;
-	struct btrfs_key key;
-	struct btrfs_path *path;
-	struct inode *other_inode = NULL;
-	int ret;
-
-	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
-
-	dir_item = btrfs_lookup_dir_item(NULL, root, path,
-					 btrfs_ino(BTRFS_I(dir)),
-					 name, namelen, 0);
-	if (!dir_item) {
-		btrfs_release_path(path);
-		goto add_link;
-	} else if (IS_ERR(dir_item)) {
-		ret = PTR_ERR(dir_item);
-		goto out;
-	}
-
-	/*
-	 * Our inode's dentry collides with the dentry of another inode which is
-	 * in the log but not yet processed since it has a higher inode number.
-	 * So delete that other dentry.
-	 */
-	btrfs_dir_item_key_to_cpu(path->nodes[0], dir_item, &key);
-	btrfs_release_path(path);
-	other_inode = read_one_inode(root, key.objectid);
-	if (!other_inode) {
-		ret = -ENOENT;
-		goto out;
-	}
-	ret = unlink_inode_for_log_replay(trans, BTRFS_I(dir), BTRFS_I(other_inode),
-					  name, namelen);
-	if (ret)
-		goto out;
-	/*
-	 * If we dropped the link count to 0, bump it so that later the iput()
-	 * on the inode will not free it. We will fixup the link count later.
-	 */
-	if (other_inode->i_nlink == 0)
-		set_nlink(other_inode, 1);
-add_link:
-	ret = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode),
-			     name, namelen, 0, ref_index);
-out:
-	iput(other_inode);
-	btrfs_free_path(path);
-
-	return ret;
-}
-
 /*
  * replay one inode back reference item found in the log tree.
  * eb, slot and key refer to the buffer and key found in the log tree.
@@ -1490,7 +1383,6 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 	char *name = NULL;
 	int namelen;
 	int ret;
-	int search_done = 0;
 	int log_ref_ver = 0;
 	u64 parent_objectid;
 	u64 inode_objectid;
@@ -1565,51 +1457,21 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 			 * overwrite any existing back reference, and we don't
 			 * want to create dangling pointers in the directory.
 			 */
-
-			if (!search_done) {
-				ret = __add_inode_ref(trans, root, path, log,
-						      BTRFS_I(dir),
-						      BTRFS_I(inode),
-						      inode_objectid,
-						      parent_objectid,
-						      ref_index, name, namelen,
-						      &search_done);
-				if (ret) {
-					if (ret == 1)
-						ret = 0;
-					goto out;
-				}
-			}
-
-			/*
-			 * If a reference item already exists for this inode
-			 * with the same parent and name, but different index,
-			 * drop it and the corresponding directory index entries
-			 * from the parent before adding the new reference item
-			 * and dir index entries, otherwise we would fail with
-			 * -EEXIST returned from btrfs_add_link() below.
-			 */
-			ret = btrfs_inode_ref_exists(inode, dir, key->type,
-						     name, namelen);
-			if (ret > 0) {
-				ret = unlink_inode_for_log_replay(trans,
-							 BTRFS_I(dir),
-							 BTRFS_I(inode),
-							 name, namelen);
-				/*
-				 * If we dropped the link count to 0, bump it so
-				 * that later the iput() on the inode will not
-				 * free it. We will fixup the link count later.
-				 */
-				if (!ret && inode->i_nlink == 0)
-					set_nlink(inode, 1);
-			}
-			if (ret < 0)
+			ret = __add_inode_ref(trans, root, path, log,
+					      BTRFS_I(dir),
+					      BTRFS_I(inode),
+					      inode_objectid,
+					      parent_objectid,
+					      ref_index, name, namelen);
+			if (ret) {
+				if (ret == 1)
+					ret = 0;
 				goto out;
+			}
 
 			/* insert our name */
-			ret = add_link(trans, dir, inode, name, namelen,
-				       ref_index);
+			ret = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode),
+					     name, namelen, 0, ref_index);
 			if (ret)
 				goto out;
 
-- 
2.35.1

