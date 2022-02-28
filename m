Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFF54C71B7
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 17:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237915AbiB1QaR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 11:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237892AbiB1QaQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 11:30:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C225851E74
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 08:29:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82ED9B81235
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 16:29:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8907C340F1
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 16:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646065775;
        bh=APvogQT+HIkqncHPc/b8+cUb1pqQT43srsModO+wvZw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=T1pZxWmcsJkK7O5n2Wkce0WwFQWbFzKqY8JfB1onv5R9uG8azG3KYs8tQ6fWvha/a
         MNnAzbmJ8YVdiu4xk+rcugOx7p/MiyNHL848yfpbhWGCNvKcmxXdsrqqYaiuGMSXdW
         cjwZZLAu2DqJB2OOcqZR93JG6PakC+ICysckBgcICHWvZHeooscSN7gezLFApR0lDo
         kwDcm2zD6LW0zeqmeYDqvxK5wv/LT8WK3aRhc/xQTE2a5uOU++QvjrEY1okfzyKU+i
         SW3PxVcb1gSxs8oRZ+5neMrba/5yfL2j6xRNKmyh2TyvcN+/6DNHoeltqby4+WzxHt
         9XIM0RsGYNW/Q==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: add and use helper for unlinking inode during log replay
Date:   Mon, 28 Feb 2022 16:29:29 +0000
Message-Id: <1e47a4aa8af20f71057631874de0e91c9b0c0f45.1646064823.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1646064823.git.fdmanana@suse.com>
References: <cover.1646064823.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

During log replay there is this pattern of running delayed items after
every inode unlink. To avoid repeating this several times, move the
logic into an helper function and use it instead of calling
btrfs_unlink_inode() followed by btrfs_run_delayed_items().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 78 +++++++++++++++++----------------------------
 1 file changed, 30 insertions(+), 48 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index ad2da46bca0d..6081bc98c4a7 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -899,6 +899,26 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
+static int unlink_inode_for_log_replay(struct btrfs_trans_handle *trans,
+				       struct btrfs_inode *dir,
+				       struct btrfs_inode *inode,
+				       const char *name,
+				       int name_len)
+{
+	int ret;
+
+	ret = btrfs_unlink_inode(trans, dir, inode, name, name_len);
+	if (ret)
+		return ret;
+	/*
+	 * Whenever we need to check if a name exists or not, we check the
+	 * fs/subvolume tree. So after an unlink we must run delayed items, so
+	 * that future checks for a name during log replay see that the name
+	 * does not exists anymore.
+	 */
+	return btrfs_run_delayed_items(trans);
+}
+
 /*
  * when cleaning up conflicts between the directory names in the
  * subvolume, directory names in the log and directory names in the
@@ -941,12 +961,8 @@ static noinline int drop_one_dir_item(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto out;
 
-	ret = btrfs_unlink_inode(trans, dir, BTRFS_I(inode), name,
+	ret = unlink_inode_for_log_replay(trans, dir, BTRFS_I(inode), name,
 			name_len);
-	if (ret)
-		goto out;
-	else
-		ret = btrfs_run_delayed_items(trans);
 out:
 	kfree(name);
 	iput(inode);
@@ -1106,12 +1122,9 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 				inc_nlink(&inode->vfs_inode);
 				btrfs_release_path(path);
 
-				ret = btrfs_unlink_inode(trans, dir, inode,
+				ret = unlink_inode_for_log_replay(trans, dir, inode,
 						victim_name, victim_name_len);
 				kfree(victim_name);
-				if (ret)
-					return ret;
-				ret = btrfs_run_delayed_items(trans);
 				if (ret)
 					return ret;
 				*search_done = 1;
@@ -1178,14 +1191,11 @@ static inline int __add_inode_ref(struct btrfs_trans_handle *trans,
 					inc_nlink(&inode->vfs_inode);
 					btrfs_release_path(path);
 
-					ret = btrfs_unlink_inode(trans,
+					ret = unlink_inode_for_log_replay(trans,
 							BTRFS_I(victim_parent),
 							inode,
 							victim_name,
 							victim_name_len);
-					if (!ret)
-						ret = btrfs_run_delayed_items(
-								  trans);
 				}
 				iput(victim_parent);
 				kfree(victim_name);
@@ -1340,19 +1350,10 @@ static int unlink_old_inode_refs(struct btrfs_trans_handle *trans,
 				kfree(name);
 				goto out;
 			}
-			ret = btrfs_unlink_inode(trans, BTRFS_I(dir),
+			ret = unlink_inode_for_log_replay(trans, BTRFS_I(dir),
 						 inode, name, namelen);
 			kfree(name);
 			iput(dir);
-			/*
-			 * Whenever we need to check if a name exists or not, we
-			 * check the subvolume tree. So after an unlink we must
-			 * run delayed items, so that future checks for a name
-			 * during log replay see that the name does not exists
-			 * anymore.
-			 */
-			if (!ret)
-				ret = btrfs_run_delayed_items(trans);
 			if (ret)
 				goto out;
 			goto again;
@@ -1448,8 +1449,9 @@ static int add_link(struct btrfs_trans_handle *trans,
 		ret = -ENOENT;
 		goto out;
 	}
-	ret = btrfs_unlink_inode(trans, BTRFS_I(dir), BTRFS_I(other_inode),
-				 name, namelen);
+	ret = unlink_inode_for_log_replay(trans, BTRFS_I(dir),
+					  BTRFS_I(other_inode),
+					  name, namelen);
 	if (ret)
 		goto out;
 	/*
@@ -1458,10 +1460,6 @@ static int add_link(struct btrfs_trans_handle *trans,
 	 */
 	if (other_inode->i_nlink == 0)
 		inc_nlink(other_inode);
-
-	ret = btrfs_run_delayed_items(trans);
-	if (ret)
-		goto out;
 add_link:
 	ret = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode),
 			     name, namelen, 0, ref_index);
@@ -1594,7 +1592,7 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 			ret = btrfs_inode_ref_exists(inode, dir, key->type,
 						     name, namelen);
 			if (ret > 0) {
-				ret = btrfs_unlink_inode(trans,
+				ret = unlink_inode_for_log_replay(trans,
 							 BTRFS_I(dir),
 							 BTRFS_I(inode),
 							 name, namelen);
@@ -1605,15 +1603,6 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 				 */
 				if (!ret && inode->i_nlink == 0)
 					inc_nlink(inode);
-				/*
-				 * Whenever we need to check if a name exists or
-				 * not, we check the subvolume tree. So after an
-				 * unlink we must run delayed items, so that future
-				 * checks for a name during log replay see that the
-				 * name does not exists anymore.
-				 */
-				if (!ret)
-					ret = btrfs_run_delayed_items(trans);
 			}
 			if (ret < 0)
 				goto out;
@@ -2350,15 +2339,8 @@ static noinline int check_item_in_log(struct btrfs_trans_handle *trans,
 		goto out;
 
 	inc_nlink(inode);
-	ret = btrfs_unlink_inode(trans, BTRFS_I(dir), BTRFS_I(inode), name,
-				 name_len);
-	if (ret)
-		goto out;
-
-	ret = btrfs_run_delayed_items(trans);
-	if (ret)
-		goto out;
-
+	ret = unlink_inode_for_log_replay(trans, BTRFS_I(dir), BTRFS_I(inode),
+					  name, name_len);
 	/*
 	 * Unlike dir item keys, dir index keys can only have one name (entry) in
 	 * them, as there are no key collisions since each key has a unique offset
-- 
2.33.0

