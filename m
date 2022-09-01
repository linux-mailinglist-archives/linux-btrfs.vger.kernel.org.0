Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE275A9858
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Sep 2022 15:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbiIANUT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 09:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbiIANTv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 09:19:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14B6F58
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 06:18:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9AFEFB826A6
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 13:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B34C433D7
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 13:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662038320;
        bh=raPohJB6sQ4wIU5BzyZjjnCi6fruW6LI+DqCZsZk+lg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CBSbho/6t+QyCvBZEIAdezJQhIHjzmfq1eolINHPyBrJ3XH99jCja8hFhuNVUYBPf
         5rAsBomAcGa8PNSBAV0sCG5bbxlBWT44HTkaXPRY+J120XGrnVQqr0P9HJJiN+/u0m
         NheawbrLAEancNDEugxAkRItvl7m/Uf1g9gdJdoJKSgz2x8o/sz5EPjPIYFf4Kl5vO
         QBTqNgExrWg2xBuSp6tE2WXKTWNf9wp9wgWxDp5wBYewwd/vtrnSHOcnkWZT15jJ2X
         yXMjo5qLRJAXzRWJ2b8AzgbQP4s+TOlQW7MVuGvNpbhxvR/Z+1m6n7Pdr0uxnFR/Et
         fexXdVW/OcXVA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 07/10] btrfs: rename btrfs_check_shared() to a more descriptive name
Date:   Thu,  1 Sep 2022 14:18:27 +0100
Message-Id: <c9954cf24dce0f62ad89dd5839c36e3ba9b14b8d.1662022922.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1662022922.git.fdmanana@suse.com>
References: <cover.1662022922.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The function btrfs_check_shared() is supposed to be used to check if a
data extent is shared, but its name is too generic, may easily cause
confusion in the sense that it may be used for metadata extents.

So rename it to btrfs_is_data_extent_shared(), which will also make it
less confusing after the next change that adds a backref lookup cache for
the b+tree nodes that lead to the leaf that contains the file extent item
that points to the target data extent.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/backref.c   | 8 ++++----
 fs/btrfs/backref.h   | 4 ++--
 fs/btrfs/extent_io.c | 5 +++--
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index d385357e19b6..e2ac10a695b6 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1512,7 +1512,7 @@ int btrfs_find_all_roots(struct btrfs_trans_handle *trans,
 }
 
 /**
- * Check if an extent is shared or not
+ * Check if a data extent is shared or not.
  *
  * @root:   root inode belongs to
  * @inum:   inode number of the inode whose extent we are checking
@@ -1520,7 +1520,7 @@ int btrfs_find_all_roots(struct btrfs_trans_handle *trans,
  * @roots:  list of roots this extent is shared among
  * @tmp:    temporary list used for iteration
  *
- * btrfs_check_shared uses the backref walking code but will short
+ * btrfs_is_data_extent_shared uses the backref walking code but will short
  * circuit as soon as it finds a root or inode that doesn't match the
  * one passed in. This provides a significant performance benefit for
  * callers (such as fiemap) which want to know whether the extent is
@@ -1531,8 +1531,8 @@ int btrfs_find_all_roots(struct btrfs_trans_handle *trans,
  *
  * Return: 0 if extent is not shared, 1 if it is shared, < 0 on error.
  */
-int btrfs_check_shared(struct btrfs_root *root, u64 inum, u64 bytenr,
-		struct ulist *roots, struct ulist *tmp)
+int btrfs_is_data_extent_shared(struct btrfs_root *root, u64 inum, u64 bytenr,
+				struct ulist *roots, struct ulist *tmp)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_trans_handle *trans;
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index 2759de7d324c..08354394b1bb 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -62,8 +62,8 @@ int btrfs_find_one_extref(struct btrfs_root *root, u64 inode_objectid,
 			  u64 start_off, struct btrfs_path *path,
 			  struct btrfs_inode_extref **ret_extref,
 			  u64 *found_off);
-int btrfs_check_shared(struct btrfs_root *root, u64 inum, u64 bytenr,
-		struct ulist *roots, struct ulist *tmp_ulist);
+int btrfs_is_data_extent_shared(struct btrfs_root *root, u64 inum, u64 bytenr,
+				struct ulist *roots, struct ulist *tmp);
 
 int __init btrfs_prelim_ref_init(void);
 void __cold btrfs_prelim_ref_exit(void);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1260038eb47d..a47710516ecf 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5656,8 +5656,9 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 			 * then we're just getting a count and we can skip the
 			 * lookup stuff.
 			 */
-			ret = btrfs_check_shared(root, btrfs_ino(inode),
-						 bytenr, roots, tmp_ulist);
+			ret = btrfs_is_data_extent_shared(root, btrfs_ino(inode),
+							  bytenr, roots,
+							  tmp_ulist);
 			if (ret < 0)
 				goto out_free;
 			if (ret)
-- 
2.35.1

