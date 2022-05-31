Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A9F539398
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 May 2022 17:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345499AbiEaPGz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 11:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345497AbiEaPGy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 11:06:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9E910D
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 08:06:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7477BB80FB3
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 15:06:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA7CC34114
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 15:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654009611;
        bh=X3TxsDoRJUmrU7Raby7V5c7n4LpB/URHxAIhtQy22SM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aiHQ1ZnV3dUOA84yx6sKUZs/W0nCHYWqecYKa1Dedts+c564miaYzj0QDs5shOkm6
         3AeeYfqmgsh1qdTUfhENdj5tLtMrPwvSWRYBFo1sUJtCkItxRerRynIkqFfewDFQlt
         16yVqIEvvQ21JJZ8qVtwo84E5vwWc+6yN2nzDa+Tv4ypcn5TgRq71ehidKRWQTOGmQ
         wPvT9gtkl131o9X2DC2GHwIvGP81WBm9nj/qRQDvnShy2zAszFFxX7h1kBnd7UPHd9
         vMZtib5mlKfAY3AsHRgRn7AoarlQsQ1OxFsRf3ooQM/v2o/4Qm1Hvprf8Yxh7i6o9K
         8NTQo90ztfklA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 04/12] btrfs: add assertions when deleting batches of delayed items
Date:   Tue, 31 May 2022 16:06:35 +0100
Message-Id: <cfcaa0d48b19913fee8598e0899f1b6f132b0cce.1654009356.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1654009356.git.fdmanana@suse.com>
References: <cover.1654009356.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

There are a few impossible cases that btrfs_batch_delete_items() tries to
deal with:

1) Getting a path pointing to a NULL leaf;
2) The leaf slot is pointing beyond the last item in the leaf;
3) We can't find a single item to delete.

The first case is impossible because the given path was returned by a
successful call to btrfs_search_slot(). Replace the BUG_ON() with an
ASSERT for this.

The second case is impossible because we are always called when a delayed
item matches an item in the given leaf. So add an ASSERT() for that and
if that condition is not satisfied, trigger a warning and return an error.

The third case is impossible exactly because of the same reason as the
second case. The given delayed item matches one item in the leaf, so we
know that our batch always has at least one item. Add an ASSERT to check
that, trigger a warning if that expectation fails and return an error.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-inode.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 66779ab3ed4a..bb9955e74a51 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -790,20 +790,23 @@ static int btrfs_batch_delete_items(struct btrfs_trans_handle *trans,
 				    struct btrfs_delayed_item *item)
 {
 	struct btrfs_delayed_item *curr, *next;
-	struct extent_buffer *leaf;
+	struct extent_buffer *leaf = path->nodes[0];
 	struct btrfs_key key;
 	struct list_head head;
 	int nitems, i, last_item;
 	int ret = 0;
 
-	BUG_ON(!path->nodes[0]);
-
-	leaf = path->nodes[0];
+	ASSERT(leaf != NULL);
 
 	i = path->slots[0];
 	last_item = btrfs_header_nritems(leaf) - 1;
-	if (i > last_item)
-		return -ENOENT;	/* FIXME: Is errno suitable? */
+	/*
+	 * Our caller always gives us a path pointing to an existing item, so
+	 * this can not happen.
+	 */
+	ASSERT(i <= last_item);
+	if (WARN_ON(i > last_item))
+		return -ENOENT;
 
 	next = item;
 	INIT_LIST_HEAD(&head);
@@ -830,8 +833,13 @@ static int btrfs_batch_delete_items(struct btrfs_trans_handle *trans,
 		btrfs_item_key_to_cpu(leaf, &key, i);
 	}
 
-	if (!nitems)
-		return 0;
+	/*
+	 * Our caller always gives us a path pointing to an existing item, so
+	 * this can not happen.
+	 */
+	ASSERT(nitems >= 1);
+	if (nitems < 1)
+		return -ENOENT;
 
 	ret = btrfs_del_items(trans, root, path, path->slots[0], nitems);
 	if (ret)
-- 
2.35.1

