Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C745BCE04
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Sep 2022 16:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiISOHC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Sep 2022 10:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiISOG5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Sep 2022 10:06:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC582E6AA
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 07:06:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2AA58B81BFB
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 14:06:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA29C433C1
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 14:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663596413;
        bh=UJwvzwY72yGDtKzAOfYKtNo5FB8PO4PsQTez83uOHbs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=HQjtTvvzZxqv/YMkuGdnoYLld9cbKPvnmqc+fK3ApUKDu892tpo3KDtY55mbc9oKO
         YkMH3qwjPbvSAVq2MGclX6Y5O4dFdYRujZFPdITa9/FmLJoy3bM+BriUaa5JIAKJ7M
         xkU+nS1Xq7rHj5faUHY0bc5Fy24KG9farWHnutkneyS/B0NSzcOkLVGCTrieG8lfPD
         uQo4tBHVVfd8Wyw21ymGxookAKISVpBT+pz90i878iZt+hPZT4g3BNHCGJM0jsNWgr
         Up4NMqnDda8n7nlXIL5zyYgAishzENFa0E5UNIzLAJW8dq6eoC72ig8L5J79C+lIpA
         +RGncel8RkBeg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 11/13] btrfs: remove unnecessary next extent map search
Date:   Mon, 19 Sep 2022 15:06:38 +0100
Message-Id: <649869c209ef7aa6e32b43bfd7c270332ee6066e.1663594828.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1663594828.git.fdmanana@suse.com>
References: <cover.1663594828.git.fdmanana@suse.com>
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

At __tree_search(), and its single caller __lookup_extent_mapping(), there
is no point in finding the next extent map that starts after the search
offset if we were able to find the previous extent map that ends before
our search offset, because __lookup_extent_mapping() ignores the next
acceptable extent map if we were able to find the previous one.

So just return immediately if we were able to find the previous extent
map, therefore avoiding wasting time iterating the tree looking for the
next extent map which will not be used by __lookup_extent_mapping().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 12538ff04525..a5b031524c32 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -141,8 +141,7 @@ static int tree_insert(struct rb_root_cached *root, struct extent_map *em)
  * it can't be found, try to find some neighboring extents
  */
 static struct rb_node *__tree_search(struct rb_root *root, u64 offset,
-				     struct rb_node **prev_ret,
-				     struct rb_node **next_ret)
+				     struct rb_node **prev_or_next_ret)
 {
 	struct rb_node *n = root->rb_node;
 	struct rb_node *prev = NULL;
@@ -168,15 +167,23 @@ static struct rb_node *__tree_search(struct rb_root *root, u64 offset,
 		prev = rb_next(prev);
 		prev_entry = rb_entry(prev, struct extent_map, rb_node);
 	}
-	*prev_ret = prev;
-	prev = orig_prev;
 
+	/*
+	 * Previous extent map found, return as in this case the caller does not
+	 * care about the next one.
+	 */
+	if (prev) {
+		*prev_or_next_ret = prev;
+		return NULL;
+	}
+
+	prev = orig_prev;
 	prev_entry = rb_entry(prev, struct extent_map, rb_node);
 	while (prev && offset < prev_entry->start) {
 		prev = rb_prev(prev);
 		prev_entry = rb_entry(prev, struct extent_map, rb_node);
 	}
-	*next_ret = prev;
+	*prev_or_next_ret = prev;
 
 	return NULL;
 }
@@ -422,16 +429,13 @@ __lookup_extent_mapping(struct extent_map_tree *tree,
 {
 	struct extent_map *em;
 	struct rb_node *rb_node;
-	struct rb_node *prev = NULL;
-	struct rb_node *next = NULL;
+	struct rb_node *prev_or_next = NULL;
 	u64 end = range_end(start, len);
 
-	rb_node = __tree_search(&tree->map.rb_root, start, &prev, &next);
+	rb_node = __tree_search(&tree->map.rb_root, start, &prev_or_next);
 	if (!rb_node) {
-		if (prev)
-			rb_node = prev;
-		else if (next)
-			rb_node = next;
+		if (prev_or_next)
+			rb_node = prev_or_next;
 		else
 			return NULL;
 	}
-- 
2.35.1

