Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD11543952
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 18:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343558AbiFHQsJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 12:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343557AbiFHQsH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 12:48:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964B248E61
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 09:48:06 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 539151F9B0;
        Wed,  8 Jun 2022 16:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654706885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L41thX6tNasEa6Yf+2otxVCKAHqp132iPgR9LkRSBBk=;
        b=ken+Pa/67SxmSY6NZjzN48av5hE4cfzHGjaM/KgRFVVqrhrFu9oJEUNJV5ha4BmpnTUp71
        RvLXESJPMnYtIN1tCpUWsArfw1Fjc8MYwKwYl6ciL/Vtgztpo9lqa/SsFXRbdybM7ZqHXg
        DeofS/YCwNEfy1AYhH+48fuE7+4P9nQ=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 494F12C141;
        Wed,  8 Jun 2022 16:48:05 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BFAD2DA883; Wed,  8 Jun 2022 18:43:36 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 8/9] btrfs: make tree search for insert more generic and use it for tree_search
Date:   Wed,  8 Jun 2022 18:43:36 +0200
Message-Id: <7c8a3f54c97b6c3bd57064d63501b35b1b1ccc4c.1654706034.git.dsterba@suse.com>
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

With a slight extension of tree_search_for_insert (fill the return node
and parent return parameters) we can avoid calling __etree_search from
tree_search, that could be removed eventually in followup patches.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index de0bd32d99e0..ae27b7a5e56c 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -443,20 +443,6 @@ tree_search_for_insert(struct extent_io_tree *tree,
 		       u64 offset,
 		       struct rb_node ***p_ret,
 		       struct rb_node **parent_ret)
-{
-	struct rb_node *next= NULL;
-	struct rb_node *ret;
-
-	ret = __etree_search(tree, offset, &next, NULL, p_ret, parent_ret);
-	if (!ret)
-		return next;
-	return ret;
-}
-
-/*
- * Inexact rb-tree search, return the next entry if @offset is not found
- */
-static inline struct rb_node *tree_search(struct extent_io_tree *tree, u64 offset)
 {
 	struct rb_root *root = &tree->state;
 	struct rb_node **node = &root->rb_node;
@@ -475,6 +461,11 @@ static inline struct rb_node *tree_search(struct extent_io_tree *tree, u64 offse
 			return *node;
 	}
 
+	if (p_ret)
+		*p_ret = node;
+	if (parent_ret)
+		*parent_ret = prev;
+
 	/* Search neighbors until we find the first one past the end */
 	while (prev && offset > entry->end) {
 		prev = rb_next(prev);
@@ -484,6 +475,14 @@ static inline struct rb_node *tree_search(struct extent_io_tree *tree, u64 offse
 	return prev;
 }
 
+/*
+ * Inexact rb-tree search, return the next entry if @offset is not found
+ */
+static inline struct rb_node *tree_search(struct extent_io_tree *tree, u64 offset)
+{
+	return tree_search_for_insert(tree, offset, NULL, NULL);
+}
+
 /*
  * utility function to look for merge candidates inside a given range.
  * Any extents with matching state are merged together into a single
-- 
2.36.1

