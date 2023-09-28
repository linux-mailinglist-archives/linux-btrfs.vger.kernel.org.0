Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1947B181D
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Sep 2023 12:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjI1KM7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Sep 2023 06:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjI1KM6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Sep 2023 06:12:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C05E122
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Sep 2023 03:12:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE56C433C9
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Sep 2023 10:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695895975;
        bh=EnaeSb02nr7jcdjJ2ruzSaBY2WmsIExbx9Rnuir4mRY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ToEEqDCHCPc6W6aTV3gYqouKURce6mqYHly3P5UrcMtUMLu5+StSlqZAvKAb+I3Rg
         BZTmpGFOCWJOBjAEHFMVLYVntfid83pPq/RjzOqd6jm8Y2sCRsCNlcmvLLXazwtYS+
         kX9iaqgamjDNaw+4AjPzQP3GCeUafaEVMeRaTF5rcrbHHSUsZdItTrB8s/GXcaBC3s
         7S8HHpK4zUHwuQsqgABv6A9nU2W/Wh5Srhn3XuF0WO8SchWtUvYcl5p1do5DZ2NGen
         vDWf9Fo6gENGyNn4NCBPLj5NuQ7pwdjM6hJTla0QcerVTinTd0Ve5QXcpB1W4svzDw
         nOjVGbkrsPuvg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: stop reserving excessive space for block group item insertions
Date:   Thu, 28 Sep 2023 11:12:50 +0100
Message-Id: <e05c33c1b696f1af1b4fdb3d0989fbcdbdeb5340.1695895841.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695895841.git.fdmanana@suse.com>
References: <cover.1695895841.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Space for block group item insertions, necessary after allocating a new
block group, is reserved in the delayed refs block reserve. Currently we
do this by incrementing the transaction handle's delayed_ref_updates
counter and then calling btrfs_update_delayed_refs_rsv(), which will
increase the size of the delayed refs block reserve by an amount that
corresponds to the same amount we use for delayed refs, given by
btrfs_calc_delayed_ref_bytes().

That is an excessive amount because it corresponds to the amount of space
needed to insert one item in a btree (btrfs_calc_insert_metadata_size())
times 2 when the free space tree feature is enabled. All we need is an
amount as given by btrfs_calc_insert_metadata_size(), since we only need to
insert a block group item in the extent tree (or block group tree if this
feature is enabled). By using btrfs_calc_insert_metadata_size() we will
need to reserve 2 times less space when using the free space tree, putting
less pressure on space reservation.

So use helpers to reserve and release space for block group item
insertions that use btrfs_calc_insert_metadata_size() for calculation of
the space.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c |  5 ++---
 fs/btrfs/delayed-ref.c | 35 +++++++++++++++++++++++++++++++++++
 fs/btrfs/delayed-ref.h |  2 ++
 fs/btrfs/transaction.c |  2 +-
 4 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 9d17b0580fbf..6e5dc68ff661 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2709,7 +2709,7 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
 
 		/* Already aborted the transaction if it failed. */
 next:
-		btrfs_delayed_refs_rsv_release(fs_info, 1, 0);
+		btrfs_dec_delayed_refs_rsv_bg_inserts(fs_info);
 		list_del_init(&block_group->bg_list);
 		clear_bit(BLOCK_GROUP_FLAG_NEW, &block_group->runtime_flags);
 	}
@@ -2819,8 +2819,7 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
 #endif
 
 	list_add_tail(&cache->bg_list, &trans->new_bgs);
-	trans->delayed_ref_updates++;
-	btrfs_update_delayed_refs_rsv(trans);
+	btrfs_inc_delayed_refs_rsv_bg_inserts(fs_info);
 
 	set_avail_alloc_bits(fs_info, type);
 	return cache;
diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index a7feef155ded..f1e99d57d866 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -125,6 +125,41 @@ void btrfs_update_delayed_refs_rsv(struct btrfs_trans_handle *trans)
 	trans->delayed_ref_csum_deletions = 0;
 }
 
+/*
+ * Adjust the size of the delayed refs block reserve for 1 block group item
+ * insertion, used after allocating a block group.
+ */
+void btrfs_inc_delayed_refs_rsv_bg_inserts(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_block_rsv *delayed_rsv = &fs_info->delayed_refs_rsv;
+
+	spin_lock(&delayed_rsv->lock);
+	/*
+	 * Inserting a block group item does not require changing the free space
+	 * tree, only the extent tree or the block group tree, so this is all we
+	 * need.
+	 */
+	delayed_rsv->size += btrfs_calc_insert_metadata_size(fs_info, 1);
+	delayed_rsv->full = false;
+	spin_unlock(&delayed_rsv->lock);
+}
+
+/*
+ * Adjust the size of the delayed refs block reserve to release space for 1
+ * block group item insertion.
+ */
+void btrfs_dec_delayed_refs_rsv_bg_inserts(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_block_rsv *delayed_rsv = &fs_info->delayed_refs_rsv;
+	const u64 num_bytes = btrfs_calc_insert_metadata_size(fs_info, 1);
+	u64 released;
+
+	released = btrfs_block_rsv_release(fs_info, delayed_rsv, num_bytes, NULL);
+	if (released > 0)
+		trace_btrfs_space_reservation(fs_info, "delayed_refs_rsv",
+					      0, released, 0);
+}
+
 /*
  * Adjust the size of the delayed refs block reserve for 1 block group item
  * update.
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 3d2c455fd9b0..d8bfa6f03976 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -420,6 +420,8 @@ int btrfs_check_delayed_seq(struct btrfs_fs_info *fs_info, u64 seq);
 
 void btrfs_delayed_refs_rsv_release(struct btrfs_fs_info *fs_info, int nr_refs, int nr_csums);
 void btrfs_update_delayed_refs_rsv(struct btrfs_trans_handle *trans);
+void btrfs_inc_delayed_refs_rsv_bg_inserts(struct btrfs_fs_info *fs_info);
+void btrfs_dec_delayed_refs_rsv_bg_inserts(struct btrfs_fs_info *fs_info);
 void btrfs_inc_delayed_refs_rsv_bg_updates(struct btrfs_fs_info *fs_info);
 void btrfs_dec_delayed_refs_rsv_bg_updates(struct btrfs_fs_info *fs_info);
 int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index c05c2cd84688..89a5df3dd2d0 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2126,7 +2126,7 @@ static void btrfs_cleanup_pending_block_groups(struct btrfs_trans_handle *trans)
        struct btrfs_block_group *block_group, *tmp;
 
        list_for_each_entry_safe(block_group, tmp, &trans->new_bgs, bg_list) {
-               btrfs_delayed_refs_rsv_release(fs_info, 1, 0);
+               btrfs_dec_delayed_refs_rsv_bg_inserts(fs_info);
                list_del_init(&block_group->bg_list);
        }
 }
-- 
2.40.1

