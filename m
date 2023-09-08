Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B519798B5F
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 19:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245083AbjIHRUw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 13:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244788AbjIHRUu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 13:20:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F2C1FCF
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 10:20:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6263AC433C9
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 17:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694193645;
        bh=WC5XyTgi0HiQ+ZF+zyXgvKQhnjNTXPdeR1yAUkvVffY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=f/cNBCvMmT8BWjBOlnKU7jLK8mu7GbEwmcITyLpeZPXPvbWoj98CKSRIjwIbn6KWX
         SYzUni4vukL/P4lRxOZ9XOwl6NDACPRx1ijFmsBnE+B9zaQFt4boYw14jNWhJDX2Kv
         dW8Oni5Ynbhkm96K5DRhwMFYgA8k14Uh6LeTRQbBcVyj3JxI2z3eMOWQOTFpU0Uc8L
         kmQojbP7ZDsNJL1SRR157nmkI8F6telaTmHs7Wh7+d+RseLlX1u+x+Ksn369jPg0dM
         YsxpReuttJY+XfqD2xWt+HlthjVPZEXjsJh/7W0nHGbm20blwwcAlrHA4PbnHlF/4q
         buTzqY0XK2zVQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 04/21] btrfs: remove unnecessary logic when running new delayed references
Date:   Fri,  8 Sep 2023 18:20:21 +0100
Message-Id: <03c71b956f576a30904349327a672b7a7d4df450.1694192469.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694192469.git.fdmanana@suse.com>
References: <cover.1694192469.git.fdmanana@suse.com>
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

When running delayed references, at btrfs_run_delayed_refs(), we have this
logic to run any new delayed references that might have been added just
after we ran all delayed references. This logic grabs the first delayed
reference, then locks it to wait for any contention on it before running
all new delayed references. This however is pointless and not necessary
because at __btrfs_run_delayed_refs() when we start running delayed
references, we pick the first reference with btrfs_obtain_ref_head() and
then we will lock it (with btrfs_delayed_ref_lock()).

So remove the duplicate and unnecessary logic at btrfs_run_delayed_refs().

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 07d3896e6824..929fbb620d68 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2135,9 +2135,7 @@ int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
 			   unsigned long count)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct rb_node *node;
 	struct btrfs_delayed_ref_root *delayed_refs;
-	struct btrfs_delayed_ref_head *head;
 	int ret;
 	int run_all = count == (unsigned long)-1;
 
@@ -2166,25 +2164,16 @@ int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
 		btrfs_create_pending_block_groups(trans);
 
 		spin_lock(&delayed_refs->lock);
-		node = rb_first_cached(&delayed_refs->href_root);
-		if (!node) {
+		if (RB_EMPTY_ROOT(&delayed_refs->href_root.rb_root)) {
 			spin_unlock(&delayed_refs->lock);
-			goto out;
+			return 0;
 		}
-		head = rb_entry(node, struct btrfs_delayed_ref_head,
-				href_node);
-		refcount_inc(&head->refs);
 		spin_unlock(&delayed_refs->lock);
 
-		/* Mutex was contended, block until it's released and retry. */
-		mutex_lock(&head->mutex);
-		mutex_unlock(&head->mutex);
-
-		btrfs_put_delayed_ref_head(head);
 		cond_resched();
 		goto again;
 	}
-out:
+
 	return 0;
 }
 
-- 
2.40.1

