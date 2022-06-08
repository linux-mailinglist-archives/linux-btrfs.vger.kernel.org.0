Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A776543956
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 18:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343522AbiFHQr7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 12:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343510AbiFHQr4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 12:47:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3AC4507D
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 09:47:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 998971F9B0;
        Wed,  8 Jun 2022 16:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654706874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CYGutKqbyNZwAM0n9JDhJKaloPBuZvdjK8ApRRZvnm8=;
        b=hPytwIs0D3VNgMTuL8tR/0ItRBrqCJrnkgDbUVgpzrOt7K91AaWHZVf6oVLvMa1NwHQQAL
        3ZAqz9odGp/9htn67hswFWDhidvWboz464BvskjnkC8mYJBLQPtCxKoK6rt63yYY5iJwt9
        unjdvcVHjMGbX0dB0DsHwd6QBC6u8cI=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 8FCD52C141;
        Wed,  8 Jun 2022 16:47:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 05A95DA883; Wed,  8 Jun 2022 18:43:25 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 3/9] btrfs: lift start and end parameters to callers of insert_state
Date:   Wed,  8 Jun 2022 18:43:25 +0200
Message-Id: <1be84acd258f46425c4162fe3b34173be2512c20.1654706034.git.dsterba@suse.com>
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

Let callers of insert_state to set up the extent state to allow further
simplifications of the parameters.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 429096fc8899..1411286e5ef2 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -524,21 +524,14 @@ static void set_state_bits(struct extent_io_tree *tree,
  * probably isn't what you want to call (see set/clear_extent_bit).
  */
 static int insert_state(struct extent_io_tree *tree,
-			struct extent_state *state, u64 start, u64 end,
+			struct extent_state *state,
 			struct rb_node ***node_in,
 			struct rb_node **parent_in,
 			u32 *bits, struct extent_changeset *changeset)
 {
 	struct rb_node **node;
 	struct rb_node *parent;
-
-	if (end < start) {
-		btrfs_err(tree->fs_info,
-			"insert state: end < start %llu %llu", end, start);
-		WARN_ON(1);
-	}
-	state->start = start;
-	state->end = end;
+	const u64 end = state->end;
 
 	set_state_bits(tree, state, bits, changeset);
 
@@ -563,7 +556,7 @@ static int insert_state(struct extent_io_tree *tree,
 		} else {
 			btrfs_err(tree->fs_info,
 			       "found node %llu %llu on insert of %llu %llu",
-			       entry->start, entry->end, start, end);
+			       entry->start, entry->end, state->start, end);
 			return -EEXIST;
 		}
 	}
@@ -1027,8 +1020,9 @@ int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
 	if (!node) {
 		prealloc = alloc_extent_state_atomic(prealloc);
 		BUG_ON(!prealloc);
-		err = insert_state(tree, prealloc, start, end,
-				   &p, &parent, &bits, changeset);
+		prealloc->start = start;
+		prealloc->end = end;
+		err = insert_state(tree, prealloc, &p, &parent, &bits, changeset);
 		if (err)
 			extent_io_tree_panic(tree, err);
 
@@ -1144,8 +1138,9 @@ int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
 		 * Avoid to free 'prealloc' if it can be merged with
 		 * the later extent.
 		 */
-		err = insert_state(tree, prealloc, start, this_end,
-				   NULL, NULL, &bits, changeset);
+		prealloc->start = start;
+		prealloc->end = this_end;
+		err = insert_state(tree, prealloc, NULL, NULL, &bits, changeset);
 		if (err)
 			extent_io_tree_panic(tree, err);
 
@@ -1268,8 +1263,9 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 			err = -ENOMEM;
 			goto out;
 		}
-		err = insert_state(tree, prealloc, start, end,
-				   &p, &parent, &bits, NULL);
+		prealloc->start = start;
+		prealloc->end = end;
+		err = insert_state(tree, prealloc, &p, &parent, &bits, NULL);
 		if (err)
 			extent_io_tree_panic(tree, err);
 		cache_state(prealloc, cached_state);
@@ -1366,8 +1362,9 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		 * Avoid to free 'prealloc' if it can be merged with
 		 * the later extent.
 		 */
-		err = insert_state(tree, prealloc, start, this_end,
-				   NULL, NULL, &bits, NULL);
+		prealloc->start = start;
+		prealloc->end = this_end;
+		err = insert_state(tree, prealloc, NULL, NULL, &bits, NULL);
 		if (err)
 			extent_io_tree_panic(tree, err);
 		cache_state(prealloc, cached_state);
-- 
2.36.1

