Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476C37986C5
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 14:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243138AbjIHMJf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 08:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242948AbjIHMJe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 08:09:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE871BC5
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 05:09:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2D4C433C9
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 12:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694174970;
        bh=ofqceQzX14mxrffpoH28c0AGhxFUN/GHjjygki5N98g=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PVw+8bVkgYx9eWSy8sNShP6Ef+LkQv1UgcMyK8Oanx2Ruk61OxNfll4FRHd7nQCQF
         XZqyZGh2vwcvCQgFzEBKjR0YZW0QhPNuM8Qe1RX9bIW+bkqDpWy4zliVqNyYhtUSo9
         IhK1zZ1Av4DA3nYDD876+VEJN6F0eAZB4HTE/h9tK9brTbTSCP5y7PHm4znOgHsjb6
         K1YIQPhhBqzRGthn8IqMn4vFN2GK8+L5jhdBh+1egCp2bUSSrTT2hLvm1GN9iKT2rc
         wCxn2Hu+W4JXJ4qVs0lt0Y4OaYrZDKC9Ykry6fMwPDhy78q5ke64hPSNtyKIWCsJhW
         5GnN7QdmOiKcA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 03/21] btrfs: pass a space_info argument to btrfs_reserve_metadata_bytes()
Date:   Fri,  8 Sep 2023 13:09:05 +0100
Message-Id: <ebcb3b7f9426e28325f857a4ace3c29d2331274b.1694174371.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694174371.git.fdmanana@suse.com>
References: <cover.1694174371.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

We are passing a block reserve argument to btrfs_reserve_metadata_bytes()
which is not really used, all we need is to pass the space_info associated
to the block reserve, we don't change the block reserve at all.

Not only it's pointless to pass the block reserve, it's also confusing as
one might think that the reserved bytes will end up being added to the
passed block reserve, when that's not the case. The pattern for reserving
space and adding it to a block reserve is to first reserve space with
btrfs_reserve_metadata_bytes() and if that succeeds, then add the space to
a block reserve by calling btrfs_block_rsv_add_bytes().

Also the reverse of btrfs_reserve_metadata_bytes(), which is
btrfs_space_info_free_bytes_may_use(), takes a space_info argument and
not a block reserve, so one more reason to pass a space_info and not a
block reserve to btrfs_reserve_metadata_bytes().

So change btrfs_reserve_metadata_bytes() and its callers to pass a
space_info argument instead of a block reserve argument.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-rsv.c      | 12 +++++++-----
 fs/btrfs/delalloc-space.c |  3 ++-
 fs/btrfs/delayed-ref.c    |  6 +++---
 fs/btrfs/space-info.c     | 12 +++++-------
 fs/btrfs/space-info.h     |  2 +-
 fs/btrfs/transaction.c    |  3 ++-
 6 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 77684c5e0c8b..6ccd91bbff3e 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -221,7 +221,8 @@ int btrfs_block_rsv_add(struct btrfs_fs_info *fs_info,
 	if (num_bytes == 0)
 		return 0;
 
-	ret = btrfs_reserve_metadata_bytes(fs_info, block_rsv, num_bytes, flush);
+	ret = btrfs_reserve_metadata_bytes(fs_info, block_rsv->space_info,
+					   num_bytes, flush);
 	if (!ret)
 		btrfs_block_rsv_add_bytes(block_rsv, num_bytes, true);
 
@@ -261,7 +262,8 @@ int btrfs_block_rsv_refill(struct btrfs_fs_info *fs_info,
 	if (!ret)
 		return 0;
 
-	ret = btrfs_reserve_metadata_bytes(fs_info, block_rsv, num_bytes, flush);
+	ret = btrfs_reserve_metadata_bytes(fs_info, block_rsv->space_info,
+					   num_bytes, flush);
 	if (!ret) {
 		btrfs_block_rsv_add_bytes(block_rsv, num_bytes, false);
 		return 0;
@@ -517,8 +519,8 @@ struct btrfs_block_rsv *btrfs_use_block_rsv(struct btrfs_trans_handle *trans,
 				block_rsv->type, ret);
 	}
 try_reserve:
-	ret = btrfs_reserve_metadata_bytes(fs_info, block_rsv, blocksize,
-					   BTRFS_RESERVE_NO_FLUSH);
+	ret = btrfs_reserve_metadata_bytes(fs_info, block_rsv->space_info,
+					   blocksize, BTRFS_RESERVE_NO_FLUSH);
 	if (!ret)
 		return block_rsv;
 	/*
@@ -539,7 +541,7 @@ struct btrfs_block_rsv *btrfs_use_block_rsv(struct btrfs_trans_handle *trans,
 	 * one last time to force a reservation if there's enough actual space
 	 * on disk to make the reservation.
 	 */
-	ret = btrfs_reserve_metadata_bytes(fs_info, block_rsv, blocksize,
+	ret = btrfs_reserve_metadata_bytes(fs_info, block_rsv->space_info, blocksize,
 					   BTRFS_RESERVE_FLUSH_EMERGENCY);
 	if (!ret)
 		return block_rsv;
diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 427abaf608b8..a764db67c033 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -346,7 +346,8 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes,
 						 noflush);
 	if (ret)
 		return ret;
-	ret = btrfs_reserve_metadata_bytes(fs_info, block_rsv, meta_reserve, flush);
+	ret = btrfs_reserve_metadata_bytes(fs_info, block_rsv->space_info,
+					   meta_reserve, flush);
 	if (ret) {
 		btrfs_qgroup_free_meta_prealloc(root, qgroup_reserve);
 		return ret;
diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 9fe4ccca50a0..0991f66471ff 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -154,6 +154,7 @@ int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
 				  enum btrfs_reserve_flush_enum flush)
 {
 	struct btrfs_block_rsv *block_rsv = &fs_info->delayed_refs_rsv;
+	struct btrfs_space_info *space_info = block_rsv->space_info;
 	u64 limit = btrfs_calc_delayed_ref_bytes(fs_info, 1);
 	u64 num_bytes = 0;
 	u64 refilled_bytes;
@@ -170,7 +171,7 @@ int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
 	if (!num_bytes)
 		return 0;
 
-	ret = btrfs_reserve_metadata_bytes(fs_info, block_rsv, num_bytes, flush);
+	ret = btrfs_reserve_metadata_bytes(fs_info, space_info, num_bytes, flush);
 	if (ret)
 		return ret;
 
@@ -199,8 +200,7 @@ int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
 	spin_unlock(&block_rsv->lock);
 
 	if (to_free > 0)
-		btrfs_space_info_free_bytes_may_use(fs_info, block_rsv->space_info,
-						    to_free);
+		btrfs_space_info_free_bytes_may_use(fs_info, space_info, to_free);
 
 	if (refilled_bytes > 0)
 		trace_btrfs_space_reservation(fs_info, "delayed_refs_rsv", 0,
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index d7e8cd4f140c..ca7c702172fd 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1742,7 +1742,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
  * Try to reserve metadata bytes from the block_rsv's space.
  *
  * @fs_info:    the filesystem
- * @block_rsv:  block_rsv we're allocating for
+ * @space_info: the space_info we're allocating for
  * @orig_bytes: number of bytes we want
  * @flush:      whether or not we can flush to make our reservation
  *
@@ -1754,21 +1754,19 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
  * space already.
  */
 int btrfs_reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
-				 struct btrfs_block_rsv *block_rsv,
+				 struct btrfs_space_info *space_info,
 				 u64 orig_bytes,
 				 enum btrfs_reserve_flush_enum flush)
 {
 	int ret;
 
-	ret = __reserve_bytes(fs_info, block_rsv->space_info, orig_bytes, flush);
+	ret = __reserve_bytes(fs_info, space_info, orig_bytes, flush);
 	if (ret == -ENOSPC) {
 		trace_btrfs_space_reservation(fs_info, "space_info:enospc",
-					      block_rsv->space_info->flags,
-					      orig_bytes, 1);
+					      space_info->flags, orig_bytes, 1);
 
 		if (btrfs_test_opt(fs_info, ENOSPC_DEBUG))
-			btrfs_dump_space_info(fs_info, block_rsv->space_info,
-					      orig_bytes, 0);
+			btrfs_dump_space_info(fs_info, space_info, orig_bytes, 0);
 	}
 	return ret;
 }
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 0bb9d14e60a8..ef0fac9c70ae 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -212,7 +212,7 @@ void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 			   struct btrfs_space_info *info, u64 bytes,
 			   int dump_block_groups);
 int btrfs_reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
-				 struct btrfs_block_rsv *block_rsv,
+				 struct btrfs_space_info *space_info,
 				 u64 orig_bytes,
 				 enum btrfs_reserve_flush_enum flush);
 void btrfs_try_granting_tickets(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 1985ab543ad2..ee63d92d66b4 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -625,7 +625,8 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 			reloc_reserved = true;
 		}
 
-		ret = btrfs_reserve_metadata_bytes(fs_info, rsv, num_bytes, flush);
+		ret = btrfs_reserve_metadata_bytes(fs_info, rsv->space_info,
+						   num_bytes, flush);
 		if (ret)
 			goto reserve_fail;
 		if (delayed_refs_bytes) {
-- 
2.40.1

