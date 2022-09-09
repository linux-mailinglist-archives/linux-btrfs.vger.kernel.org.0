Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9ED5B41CF
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 23:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbiIIVye (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 17:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbiIIVy3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 17:54:29 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AB310B6
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 14:54:26 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id r20so1645724qtn.12
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 14:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=E70UErGZdqyya/L8rohJV8oRz61o/sXy0aqwgAvzpFw=;
        b=YdUhTTlPa+8b5CtsJB2Mlf0PubsdYF6FpYIcApyUjZWptjsMAw/k+G6Fy+36UOk9T+
         Jr4T3eRGW9x4lzlOZF2+mY1ASVlxQ6K7z9lmGTK4w16CNkKTCYBZ76LNHHGh3QYbUXaF
         cI0LbaccwaVjbgvaCgkHb/FoteIbmTzIfv8kJiYajMBOKKnDxFLTspF+MYcJHB+9yf5p
         0o2A4hl7iP4yd4y9uEGXXG3xyu+WmFh7XfpCuF+LyMaK4xJOi9D+WLnEbX/ILuiiRhuN
         p0VEFWnyDsqM8rz0hQZbcnHFQa63l29GxkVwYLvJpJ+9TfGfMJU7SE/KTQgIFQ0U3jjG
         /uQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=E70UErGZdqyya/L8rohJV8oRz61o/sXy0aqwgAvzpFw=;
        b=4oDmlY+MTgGpNYDnyvtBSfVPVufXpMlJt8YDZbMjm25PkK0Mtayq1+N6/GMT1bMdD5
         wypLXluBlXTsoDNVK1WHUQj2p0X8okb0i9UNrjxCnA8t0phVGULqlBNllIDNLsv51RVe
         7GP9QR15Y6EI+u5n9I/savOVoFm/jwPC29iakOL9LysO8kz9AUrHzfaNqG0zoPwqczjv
         eo4Dtae5JbRj/+uJ0AdtHoCHjRox1fqASgVeMEwKN8K7d/j9t89S6Y2DPsrIRg2w5D83
         u+NyQlNGE9WVf0pH/FyDnFuEdhbl7pzC99FdTafT5spuxQtn8THXl1QwyXyHr3k6a1cr
         hiRw==
X-Gm-Message-State: ACgBeo3Qz500PCA1u08G/0KS70dIpdTTOQXnci/1a9L/iIjL0dveOQ8i
        SLkqXdDdZie8A62szg9CEaiDYHwIBA5Qiw==
X-Google-Smtp-Source: AA6agR47gzBV9pTIFQSd/hvrqVwN6A4IHaWJIZwT0Qgtoa2s4pCw7qXUOuVCxRxDXrnfd8T37PqNZQ==
X-Received: by 2002:ac8:5987:0:b0:35a:703a:9bb9 with SMTP id e7-20020ac85987000000b0035a703a9bb9mr7423432qte.213.1662760465909;
        Fri, 09 Sep 2022 14:54:25 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d23-20020ac85357000000b00343057845f7sm1135256qto.20.2022.09.09.14.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 14:54:25 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 24/36] btrfs: use next_state/prev_state in merge_state
Date:   Fri,  9 Sep 2022 17:53:37 -0400
Message-Id: <a25a586d4965e428658beb29a68305cd44395691.1662760286.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1662760286.git.josef@toxicpanda.com>
References: <cover.1662760286.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We use rb_next/rb_prev and then get the entry for the adjacent items in
an extent io tree.  We have helpers for this, so convert merge_state to
use next_state/prev_state and simplify the code.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.c | 49 ++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 9b3380c353e7..6c734b6871f8 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -338,40 +338,31 @@ static void extent_io_tree_panic(struct extent_io_tree *tree, int err)
 static void merge_state(struct extent_io_tree *tree, struct extent_state *state)
 {
 	struct extent_state *other;
-	struct rb_node *other_node;
 
 	if (state->state & (EXTENT_LOCKED | EXTENT_BOUNDARY))
 		return;
 
-	other_node = rb_prev(&state->rb_node);
-	if (other_node) {
-		other = rb_entry(other_node, struct extent_state, rb_node);
-		if (other->end == state->start - 1 &&
-		    other->state == state->state) {
-			if (tree->private_data &&
-			    is_data_inode(tree->private_data))
-				btrfs_merge_delalloc_extent(tree->private_data,
-							    state, other);
-			state->start = other->start;
-			rb_erase(&other->rb_node, &tree->state);
-			RB_CLEAR_NODE(&other->rb_node);
-			free_extent_state(other);
-		}
+	other = prev_state(state);
+	if (other && other->end == state->start - 1 &&
+	    other->state == state->state) {
+		if (tree->private_data && is_data_inode(tree->private_data))
+			btrfs_merge_delalloc_extent(tree->private_data,
+						    state, other);
+		state->start = other->start;
+		rb_erase(&other->rb_node, &tree->state);
+		RB_CLEAR_NODE(&other->rb_node);
+		free_extent_state(other);
 	}
-	other_node = rb_next(&state->rb_node);
-	if (other_node) {
-		other = rb_entry(other_node, struct extent_state, rb_node);
-		if (other->start == state->end + 1 &&
-		    other->state == state->state) {
-			if (tree->private_data &&
-			    is_data_inode(tree->private_data))
-				btrfs_merge_delalloc_extent(tree->private_data,
-							    state, other);
-			state->end = other->end;
-			rb_erase(&other->rb_node, &tree->state);
-			RB_CLEAR_NODE(&other->rb_node);
-			free_extent_state(other);
-		}
+	other = next_state(state);
+	if (other && other->start == state->end + 1 &&
+	    other->state == state->state) {
+		if (tree->private_data && is_data_inode(tree->private_data))
+			btrfs_merge_delalloc_extent(tree->private_data, state,
+						    other);
+		state->end = other->end;
+		rb_erase(&other->rb_node, &tree->state);
+		RB_CLEAR_NODE(&other->rb_node);
+		free_extent_state(other);
 	}
 }
 
-- 
2.26.3

