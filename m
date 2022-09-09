Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337835B41CE
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 23:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbiIIVyW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 17:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbiIIVyU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 17:54:20 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4450F113C5E
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 14:54:19 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id r6so2344797qtx.6
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 14:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=qUFMHuXycz7rmHA0hI3ZRo8x5SOXZYVbmwk1Z+HWHWk=;
        b=okqdrzNxeKXDSUZMiTISY3yxpdtNV+gV8f/qpw2+d64sG36oCqTQj4CeNgcXyDLIVg
         5FXNvxdhTjXWAA3Kg7L5CIqbinp9hO19NR+vqsiCJ4Pj/nlcmxAP0Sd9qgAkZeK9Z5pz
         l6QZPOfe4QYSxPGMo5HC1Usw8Y6AsAb1GGgM6iwp5ZGdGbouUOQxBmpUg+maYa4ITCLe
         b0Poy7fRw7gG7NAOK+7h9CQBCne8NXauCtkdNHsFcGCJPsob+iAWigdtpSAUtQ/BVhuE
         tzi3E3xdmMjNXUPBmVE6FEZ62fptDcYv0uEkSPgNjdNEeUr+GLllFOIss6GFVr3QoPwJ
         Kjkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=qUFMHuXycz7rmHA0hI3ZRo8x5SOXZYVbmwk1Z+HWHWk=;
        b=D3hHuGz6nrQSkv1B0CbAtK1dqyWBWjT+BZbrmPKF8gpJIk95zJBYm1q/aXw/2nVVIs
         KEMlQxbHw4NCjlENi8o7aed/OQB70P1nUrDcJ4fG2n70SUGUY9scgypzVGSFu21PXPyc
         V1rV4rVcDxkkVT3rU8e0s/lcO4H87jDvBFM3ESylqPUNVyYc8c0o9ndpDwxfHFV2gTN5
         shdElS2njQXpbOClKl+/h4mhkxAHNV1m/o46BgGmNqZ5QvS/vGsFfNOSdwMR6KnL3pzv
         35ksbPJPOU8zqU9gC1ECQGmKo1fQ16kGEkVszpEyCigw4d206NRdXoyj5LB5nSpwK8Cd
         oY0w==
X-Gm-Message-State: ACgBeo2JDS8fggsn/eFZ2ak8uIsfO47slChpijOyXkOztY3qZ552O5aD
        0RWNqYioovYuAkgtiQcNs2gTYTxMfvQr8Q==
X-Google-Smtp-Source: AA6agR4AtzNg2UeKBAa9PtrQkBmV8F1Q8wyHqmsepcYOnFopW5YXzzrytwEDlc7C5nRJgSP9yU5GJQ==
X-Received: by 2002:ac8:7f03:0:b0:344:6f5c:6aee with SMTP id f3-20020ac87f03000000b003446f5c6aeemr14661672qtk.558.1662760458623;
        Fri, 09 Sep 2022 14:54:18 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l3-20020a37f903000000b006af0ce13499sm1321029qkj.115.2022.09.09.14.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 14:54:18 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 19/36] btrfs: remove struct tree_entry
Date:   Fri,  9 Sep 2022 17:53:32 -0400
Message-Id: <fb921dc9fe2ece16fc7b1d423c458b856c6d8a07.1662760286.git.josef@toxicpanda.com>
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

This existed when we overloaded the tree manipulation functions for both
the extent_io_tree and the extent buffer tree.  However the extent
buffers are now stored in a radix tree, so we no longer need this
abstraction.  Remove struct tree_entry and use extent_state directly
instead.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index e462b81a8d3e..4855fa5ab29e 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -228,11 +228,11 @@ static inline struct rb_node *tree_search_for_insert(struct extent_io_tree *tree
 	struct rb_root *root = &tree->state;
 	struct rb_node **node = &root->rb_node;
 	struct rb_node *prev = NULL;
-	struct tree_entry *entry;
+	struct extent_state *entry;
 
 	while (*node) {
 		prev = *node;
-		entry = rb_entry(prev, struct tree_entry, rb_node);
+		entry = rb_entry(prev, struct extent_state, rb_node);
 
 		if (offset < entry->start)
 			node = &(*node)->rb_left;
@@ -250,7 +250,7 @@ static inline struct rb_node *tree_search_for_insert(struct extent_io_tree *tree
 	/* Search neighbors until we find the first one past the end */
 	while (prev && offset > entry->end) {
 		prev = rb_next(prev);
-		entry = rb_entry(prev, struct tree_entry, rb_node);
+		entry = rb_entry(prev, struct extent_state, rb_node);
 	}
 
 	return prev;
@@ -277,14 +277,14 @@ static inline struct rb_node *tree_search_prev_next(struct extent_io_tree *tree,
 	struct rb_node **node = &root->rb_node;
 	struct rb_node *prev = NULL;
 	struct rb_node *orig_prev = NULL;
-	struct tree_entry *entry;
+	struct extent_state *entry;
 
 	ASSERT(prev_ret);
 	ASSERT(next_ret);
 
 	while (*node) {
 		prev = *node;
-		entry = rb_entry(prev, struct tree_entry, rb_node);
+		entry = rb_entry(prev, struct extent_state, rb_node);
 
 		if (offset < entry->start)
 			node = &(*node)->rb_left;
@@ -297,15 +297,15 @@ static inline struct rb_node *tree_search_prev_next(struct extent_io_tree *tree,
 	orig_prev = prev;
 	while (prev && offset > entry->end) {
 		prev = rb_next(prev);
-		entry = rb_entry(prev, struct tree_entry, rb_node);
+		entry = rb_entry(prev, struct extent_state, rb_node);
 	}
 	*next_ret = prev;
 	prev = orig_prev;
 
-	entry = rb_entry(prev, struct tree_entry, rb_node);
+	entry = rb_entry(prev, struct extent_state, rb_node);
 	while (prev && offset < entry->start) {
 		prev = rb_prev(prev);
-		entry = rb_entry(prev, struct tree_entry, rb_node);
+		entry = rb_entry(prev, struct extent_state, rb_node);
 	}
 	*prev_ret = prev;
 
@@ -416,10 +416,10 @@ static int insert_state(struct extent_io_tree *tree,
 
 	node = &tree->state.rb_node;
 	while (*node) {
-		struct tree_entry *entry;
+		struct extent_state *entry;
 
 		parent = *node;
-		entry = rb_entry(parent, struct tree_entry, rb_node);
+		entry = rb_entry(parent, struct extent_state, rb_node);
 
 		if (end < entry->start) {
 			node = &(*node)->rb_left;
@@ -485,10 +485,10 @@ static int split_state(struct extent_io_tree *tree, struct extent_state *orig,
 	parent = &orig->rb_node;
 	node = &parent;
 	while (*node) {
-		struct tree_entry *entry;
+		struct extent_state *entry;
 
 		parent = *node;
-		entry = rb_entry(parent, struct tree_entry, rb_node);
+		entry = rb_entry(parent, struct extent_state, rb_node);
 
 		if (prealloc->end < entry->start) {
 			node = &(*node)->rb_left;
-- 
2.26.3

