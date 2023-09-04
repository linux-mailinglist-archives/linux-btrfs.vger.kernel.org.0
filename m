Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76084791611
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Sep 2023 13:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238685AbjIDLKl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Sep 2023 07:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjIDLKl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Sep 2023 07:10:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978701AD
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Sep 2023 04:10:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02A17B80DFB
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Sep 2023 11:10:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FAA4C433C8
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Sep 2023 11:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693825834;
        bh=q4PuZslhnhRl2UpAj8sUAkuSJzfQwd1lKBFs/4Q4vMg=;
        h=From:To:Subject:Date:From;
        b=WhgDvbLBX2YFZLp4SPPFahlgFPzgAgFrF7bmkDWtI43MPx9KIOYCfHVV0IkyzI3wj
         oLRVONBvVhlbefxeU/AWI6fERhN1gWR5MtQ0FAjFQh6UkzC3+Wl7Q0fG6WAjtUvHbw
         ruVkaVjfL8B2uTifudt6ZoHxi5LqdpJFEaz6Q56RbZamsvnO2NPbXfOSZvx8ZVG+KW
         UCTLETMHLYe1xT1BoYmNGPFAr8GZFiVxNpfYMjrSrjHRk2g5zmwVBV8SIEv3B9HRUx
         DZedbJFRGFZd2IJBg0qfYNuN7ijiGsxe0Rbd33yFlA3ATpqxZY56qnsVMYVxBxZoNU
         3iIcgOmTh402g==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix race between finishing block group creation and its item update
Date:   Mon,  4 Sep 2023 12:10:31 +0100
Message-Id: <f5eda1ba8b7a776d3407d30939078b63d02aaff4.1693825574.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
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

Commit 675dfe1223a6 ("btrfs: fix block group item corruption after
inserting new block group") fixed one race that resulted in not persisting
a block group's item when its "used" bytes field decreases to zero.
However there's another race that can happen in a much shorter time window
that results in the same problem. The following sequence of steps explains
how it can happen:

1) Task A creates a metadata block group X, its "used" and "commit_used"
   fields are initialized to 0;

2) Two extents are allocated from block group X, so its "used" field is
   updated to 32K, and its "commit_used" field remains as 0;

3) Transaction commit starts, by some task B, and it enters
   btrfs_start_dirty_block_groups(). There it tries to update the block
   group item for block group X, which currently has its "used" field with
   a value of 32K and its "commited_used" field with a value of 0. However
   that fails since the block group item was not yet inserted, so at
   update_block_group_item(), the btrfs_search_slot() call returns 1, and
   then we set 'ret' to -ENOENT. Before jumping to the label 'fail'...

4) The block group item is inserted by task A, when for example
   btrfs_create_pending_block_groups() is called when releasing its
   transaction handle. This results in insert_block_group_item() inserting
   the block group item in the extent tree (or block group tree), with a
   "used" field having a value of 32K and setting "commit_used", in struct
   btrfs_block_group, to the same value (32K);

5) Task B jumps to the 'fail' label and then resets the "commit_used"
   field to 0. At btrfs_start_dirty_block_groups(), because -ENOENT was
   returned from update_block_group_item(), we add the block group again
   to the list of dirty block groups, so that we will try again in the
   critical section of the transaction commit when calling
   btrfs_write_dirty_block_groups();

6) Later the two extents from block group X are freed, so its "used" field
   becomes 0;

7) If no more extents are allocated from block group X before we get into
   btrfs_write_dirty_block_groups(), then when we call
   update_block_group_item() again for block group X, we will not update
   the block group item to reflect that it has 0 bytes used, because the
   "used" and "commit_used" fields in struct btrfs_block_group have the
   same value, a value of 0.

   As a result after committing the transaction we have an empty block
   group with its block group item having a 32K value for its "used" field.
   This will trigger errors from fsck ("btrfs check" command) and after
   mounting again the fs, the cleaner kthread will not automatically delete
   the empty block group, since its "used" field is not 0. Possibly there
   are other issues due to this incosistency.

   When this issue happens, the error reported by fsck is like this:

     [1/7] checking root items
     [2/7] checking extents
     block group [1104150528 1073741824] used 39796736 but extent items used 0
     ERROR: errors found in extent allocation tree or chunk allocation
     (...)

So fix this by not resetting the "commit_used" field of a block group when
we don't find the block group item at update_block_group_item().

Fixes: 7248e0cebbef ("btrfs: skip update of block group item if used bytes are the same")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 0cb1dee965a0..b2e5107b7cec 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3028,8 +3028,16 @@ static int update_block_group_item(struct btrfs_trans_handle *trans,
 	btrfs_mark_buffer_dirty(leaf);
 fail:
 	btrfs_release_path(path);
-	/* We didn't update the block group item, need to revert @commit_used. */
-	if (ret < 0) {
+	/*
+	 * We didn't update the block group item, need to revert commit_used
+	 * unless the block group item didn't exist yet - this is to prevent a
+	 * race with a concurrent insertion of the block group item, with
+	 * insert_block_group_item(), that happened just after we attempted to
+	 * update. In that case we would reset commit_used to 0 just after the
+	 * insertion set it to a value greater than 0 - if the block group later
+	 * becomes with 0 used bytes, we would incorrectly skip its update.
+	 */
+	if (ret < 0 && ret != -ENOENT) {
 		spin_lock(&cache->lock);
 		cache->commit_used = old_commit_used;
 		spin_unlock(&cache->lock);
-- 
2.40.1

