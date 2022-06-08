Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24691543958
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 18:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343529AbiFHQsB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 12:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343518AbiFHQsA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 12:48:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361634B43A
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 09:48:00 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DFBFD1F9B0;
        Wed,  8 Jun 2022 16:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654706878; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9G86Bfc7XG358C+2gZPnrXxdu5tewGXtTKje5GTohVI=;
        b=IRhSYzudmDEXY2masgLepS0FRrbQtuzkXSzPOz+9fwyez6ZoGfUL3QWzCt3jmBN8tjoTdn
        iK28FTnpvsPVhuPd0Jd6cpEdXKNXi4JTlENryBz8s5CNWUtWbHxp7V/egYi42yeLr9wQpX
        V7KaN27q6++nD7fS3qVUzyQjyQ9ab8Y=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D68A82C141;
        Wed,  8 Jun 2022 16:47:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4E68DDA883; Wed,  8 Jun 2022 18:43:30 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 5/9] btrfs: add fast path for extent_state insertion
Date:   Wed,  8 Jun 2022 18:43:30 +0200
Message-Id: <85ad4b193c5c4dcc803449feff008f06bd61808f.1654706034.git.dsterba@suse.com>
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

In two cases the exact location where to insert the extent state is
known at the call time so we don't need to pass it to insert_state that
takes the fast path.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9b1dfe4363c9..00a6a2d0b112 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -569,6 +569,21 @@ static int insert_state(struct extent_io_tree *tree,
 	return 0;
 }
 
+/*
+ * Insert state to the tree to a location given by @p_
+ */
+static void insert_state_fast(struct extent_io_tree *tree,
+			struct extent_state *state,
+			struct rb_node **node,
+			struct rb_node *parent,
+			unsigned bits, struct extent_changeset *changeset)
+{
+	set_state_bits(tree, state, bits, changeset);
+	rb_link_node(&state->rb_node, parent, node);
+	rb_insert_color(&state->rb_node, &tree->state);
+	merge_state(tree, state);
+}
+
 /*
  * split a given extent state struct in two, inserting the preallocated
  * struct 'prealloc' as the newly created second half.  'split' indicates an
@@ -1021,10 +1036,7 @@ int set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits,
 		BUG_ON(!prealloc);
 		prealloc->start = start;
 		prealloc->end = end;
-		err = insert_state(tree, prealloc, &p, &parent, bits, changeset);
-		if (err)
-			extent_io_tree_panic(tree, err);
-
+		insert_state_fast(tree, prealloc, p, parent, bits, changeset);
 		cache_state(prealloc, cached_state);
 		prealloc = NULL;
 		goto out;
@@ -1264,9 +1276,7 @@ int convert_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		}
 		prealloc->start = start;
 		prealloc->end = end;
-		err = insert_state(tree, prealloc, &p, &parent, bits, NULL);
-		if (err)
-			extent_io_tree_panic(tree, err);
+		insert_state_fast(tree, prealloc, p, parent, bits, NULL);
 		cache_state(prealloc, cached_state);
 		prealloc = NULL;
 		goto out;
-- 
2.36.1

