Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F318A54395A
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 18:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343506AbiFHQrx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 12:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245745AbiFHQrw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 12:47:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B64443E8
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 09:47:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4B9E71F9B0;
        Wed,  8 Jun 2022 16:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654706870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rdwi/2w3c8W9giTdX5ie61XgR5x/gQmf2Ayc0cFzCwY=;
        b=kRGHL0dRjrNGGIl8E8A2dRE/UKLjBvNLCDz8984bM2AFa/JPMf2auC0lckYH3obJ+UJq5P
        BN1rgADVCy+EyeiYyVxvb5ePrSLtGNQ6eqKxaUmqcRGKHdHQ2YcQRSs3uH3tjmLpG89QGJ
        NYU7cA9Dk1E0ak6qbO2s6hDUwv93IF0=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 41D0B2C141;
        Wed,  8 Jun 2022 16:47:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AF27BDA883; Wed,  8 Jun 2022 18:43:21 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/9] btrfs: open code rbtree search into split_state
Date:   Wed,  8 Jun 2022 18:43:21 +0200
Message-Id: <6013325030c2a52b3a0b5873499be6ffd36c13d2.1654706034.git.dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654706034.git.dsterba@suse.com>
References: <cover.1654706034.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Preparatory work to remove tree_insert from extent_io.c, the rbtree
search loop is a known and simple so it can be open coded.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9fd114683027..c39f8674b6ce 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -607,7 +607,8 @@ static int insert_state(struct extent_io_tree *tree,
 static int split_state(struct extent_io_tree *tree, struct extent_state *orig,
 		       struct extent_state *prealloc, u64 split)
 {
-	struct rb_node *node;
+	struct rb_node *parent = NULL;
+	struct rb_node **node;
 
 	if (tree->private_data && is_data_inode(tree->private_data))
 		btrfs_split_delalloc_extent(tree->private_data, orig, split);
@@ -617,12 +618,27 @@ static int split_state(struct extent_io_tree *tree, struct extent_state *orig,
 	prealloc->state = orig->state;
 	orig->start = split;
 
-	node = tree_insert(&tree->state, &orig->rb_node, prealloc->end,
-			   &prealloc->rb_node, NULL, NULL);
-	if (node) {
-		free_extent_state(prealloc);
-		return -EEXIST;
+	parent = &orig->rb_node;
+	node = &parent;
+	while (*node) {
+		struct tree_entry *entry;
+
+		parent = *node;
+		entry = rb_entry(parent, struct tree_entry, rb_node);
+
+		if (prealloc->end < entry->start) {
+			node = &(*node)->rb_left;
+		} else if (prealloc->end > entry->end) {
+			node = &(*node)->rb_right;
+		} else {
+			free_extent_state(prealloc);
+			return -EEXIST;
+		}
 	}
+
+	rb_link_node(&prealloc->rb_node, parent, node);
+	rb_insert_color(&prealloc->rb_node, &tree->state);
+
 	return 0;
 }
 
-- 
2.36.1

