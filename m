Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5421A631E31
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Nov 2022 11:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbiKUKXs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Nov 2022 05:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiKUKXl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Nov 2022 05:23:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B844D8CFCC
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Nov 2022 02:23:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54EDE60FC5
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Nov 2022 10:23:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F670C433D6
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Nov 2022 10:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669026210;
        bh=5p7bWGGSjlx0ZbTYWWFINIoha/gLVT084HTVc2DE58o=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NI5V5pqIkwBHAvxjKRZ07D6mrRjb9Pg6VjF1/YG/lHlkk7FNqSRSP0J7s9rDFyvsq
         Ko15gPvQSyv/lDexlcyvtmMd3L4I943qsE94eNcacserivqlR1pssnTWjTzbv1PnI8
         EyPfx1S3O2LBO//afBhHZdM+XWLpe0wkfliOASfbYx5IQbEKfTn5m7qUKumTBUzjgf
         0OJk7qRLrO8OXte2pzAasf+9q3oS5LCZh4gvwo0bmOqVmFhZ3fTYwsozGZihzpFS5k
         l+jA9s6/Wc24a7mSsjbh4LaPZt49RW3J6wGgjQ6epk3pEgucqx3k2iTjIHXcG4hk43
         WI0ZlDNYUgUAw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: remove outdated logic from overwrite_item() and add assertion
Date:   Mon, 21 Nov 2022 10:23:24 +0000
Message-Id: <684c436b1e111cc58fb1677770a9270a1e5870fa.1669025204.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1669025204.git.fdmanana@suse.com>
References: <cover.1669025204.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

As of commit 193df6245704 ("btrfs: search for last logged dir index if
it's not cached in the inode"), the overwrite_item() function is always
called for a root that is rom a fs/subvolume tree. In other words, now
it's only used during log replay to modify a fs/subvolume tree. Therefore
we can remove the logic that checks if we are dealing with a log tree at
overwrite_item().

So remove that logic, replacing it with an assertion and document that if
we ever need to support a log root there, we will need to clone the leaf
from the fs/subvolume tree and then release it before modifying the log
tree, which is needed to avoid a potential deadlock, similar to the one
recently fixed by a patch with the subject:

  "btrfs: do not modify log tree while holding a leaf from fs tree locked"

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 742f26a217d7..00e0ec0ba002 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -385,11 +385,16 @@ static int overwrite_item(struct btrfs_trans_handle *trans,
 	int save_old_i_size = 0;
 	unsigned long src_ptr;
 	unsigned long dst_ptr;
-	int overwrite_root = 0;
 	bool inode_item = key->type == BTRFS_INODE_ITEM_KEY;
 
-	if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID)
-		overwrite_root = 1;
+	/*
+	 * This is only used during log replay, so the root is always from a
+	 * fs/subvolume tree. In case we ever need to support a log root, then
+	 * we'll have to clone the leaf in the path, release the path and use
+	 * the leaf before writing into the log tree. See the comments at
+	 * copy_items() for more details.
+	 */
+	ASSERT(root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID);
 
 	item_size = btrfs_item_size(eb, slot);
 	src_ptr = btrfs_item_ptr_offset(eb, slot);
@@ -542,8 +547,7 @@ static int overwrite_item(struct btrfs_trans_handle *trans,
 			goto no_copy;
 		}
 
-		if (overwrite_root &&
-		    S_ISDIR(btrfs_inode_mode(eb, src_item)) &&
+		if (S_ISDIR(btrfs_inode_mode(eb, src_item)) &&
 		    S_ISDIR(btrfs_inode_mode(path->nodes[0], dst_item))) {
 			save_old_i_size = 1;
 			saved_i_size = btrfs_inode_size(path->nodes[0],
-- 
2.35.1

