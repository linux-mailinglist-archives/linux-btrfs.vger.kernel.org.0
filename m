Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B571A57CC9C
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Jul 2022 15:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiGUNuj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Jul 2022 09:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiGUNu1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Jul 2022 09:50:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D2FBCB6
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Jul 2022 06:50:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D681834074;
        Thu, 21 Jul 2022 13:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658411410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ss71LQ3xFqT2YUtyv6/FJCYUCZ/Q5LUfqyKPUhmAEEo=;
        b=Pbg9UudEJYnQOmCyBs1m0xz2vGg8TDT8lad/dapPUcV+/ALMMBk2mFTEwDQhWeMxem3dxP
        zM0TDuV/PKKzOJ5xVHuKIrY91aBkhb8S352ArVLJznri3QypU6j9MjozHvTT8dRaL0lwHk
        WBCTJkeKsK3LJJF5LCo0p1X1AqOzUrU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A518D13A1B;
        Thu, 21 Jul 2022 13:50:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EIydJZJZ2WIPMgAAMHmgww
        (envelope-from <nborisov@suse.com>); Thu, 21 Jul 2022 13:50:10 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/3] btrfs: use btrfs_find_inode in btrfs_prune_dentries
Date:   Thu, 21 Jul 2022 16:50:05 +0300
Message-Id: <20220721135006.3345302-3-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721135006.3345302-1-nborisov@suse.com>
References: <20220721135006.3345302-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we have a standalone function which encapsulates the logic of
searching the root's ino rb tree use that. It results in massive
simplification of the code.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c | 47 +++++++++++++++++------------------------------
 1 file changed, 17 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c11169ba28b2..06724925a3d3 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4635,44 +4635,27 @@ struct rb_node *btrfs_find_inode(struct btrfs_root *root, const u64 objectid)
 static void btrfs_prune_dentries(struct btrfs_root *root)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct rb_node *node;
-	struct rb_node *prev;
-	struct btrfs_inode *entry;
-	struct inode *inode;
+	struct rb_node *node = NULL;
 	u64 objectid = 0;
 
 	if (!BTRFS_FS_ERROR(fs_info))
 		WARN_ON(btrfs_root_refs(&root->root_item) != 0);
 
 	spin_lock(&root->inode_lock);
-again:
-	node = root->inode_tree.rb_node;
-	prev = NULL;
-	while (node) {
-		prev = node;
-		entry = rb_entry(node, struct btrfs_inode, rb_node);
+	do {
+		struct btrfs_inode *entry;
+		struct inode *inode;
 
-		if (objectid < btrfs_ino(entry))
-			node = node->rb_left;
-		else if (objectid > btrfs_ino(entry))
-			node = node->rb_right;
-		else
-			break;
-	}
-	if (!node) {
-		while (prev) {
-			entry = rb_entry(prev, struct btrfs_inode, rb_node);
-			if (objectid <= btrfs_ino(entry)) {
-				node = prev;
+		if (!node) {
+			node = btrfs_find_inode(root, objectid);
+			if (!node)
 				break;
-			}
-			prev = rb_next(prev);
 		}
-	}
-	while (node) {
+
 		entry = rb_entry(node, struct btrfs_inode, rb_node);
 		objectid = btrfs_ino(entry) + 1;
 		inode = igrab(&entry->vfs_inode);
+
 		if (inode) {
 			spin_unlock(&root->inode_lock);
 			if (atomic_read(&inode->i_count) > 1)
@@ -4684,14 +4667,18 @@ static void btrfs_prune_dentries(struct btrfs_root *root)
 			iput(inode);
 			cond_resched();
 			spin_lock(&root->inode_lock);
-			goto again;
+			node = NULL;
+			continue;
 		}
 
-		if (cond_resched_lock(&root->inode_lock))
-			goto again;
+		if (cond_resched_lock(&root->inode_lock)) {
+			node = NULL;
+			continue;
+		}
 
 		node = rb_next(node);
-	}
+	} while(node);
+
 	spin_unlock(&root->inode_lock);
 }
 
-- 
2.25.1

