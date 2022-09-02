Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1450B5AB95F
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 22:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiIBURQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 16:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiIBURE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 16:17:04 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22273DCFF1
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 13:17:03 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id mn13so2273971qvb.4
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Sep 2022 13:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=6ZQnR23OaOG/Iymrw+qbPSLF/p8xklzJyAl1vI8Hhu0=;
        b=0POTDz2OzbXsIsYwqFihJeKB7vb689Jk/225a4HimdrGqaLX8LsVN9NfJp2BC0RPdi
         5rie2velU6xSN581ZYrhFP9R5GWa4g58CPtrPKrW/74qWu6YAwAyc+UVbB7/EUXbuQqv
         5TACZKiF7C+wTw4m4YlDnKxQw8HIOsVuH1c+vc3RM/4ugW7pN+OIVHDU+swhE8vh9lpf
         HoKr6JLGQ/unGvRdR3vEKuFjsPO76XtR3Y4XY62EuZBACJK/pGsZSOPQbCc3m4NRTi0R
         rt77jmyYfZHKyVGspFsgZh7ovS7LNciaRhEl0UEqNI/EnkvxUW/pCqYinEyokOFAhESI
         rBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6ZQnR23OaOG/Iymrw+qbPSLF/p8xklzJyAl1vI8Hhu0=;
        b=R5rqVcp8uzKxAy0atZ2gjxMKZgo1x4n69wK67GVNlcSW5G4yv2feBCzgB98zApePUC
         2+XGiN7CReUeYeZZNT7xf/aOo6hRVlRhm9l0xtScI4new5rUZVgyd67fSfKZ933v2aL1
         av8rwd/Zqta7Med3SyPEYg5UnPXgHC6ZqEcDDr64BdD8AvayxCX6X0G+/OkmkaRFhuqR
         PSE4Q75i3aKc4RKZHpMVXquY53NSqVazcalcXnlQYW/CbR2SShUlKcjv7Wep8TDYhvTQ
         gxN2qkBfQ/9257mE9ctfFizO2QqxdjtYqRS5Rv1YloXgtHa0IRmotVpAHZ9nOFjNbPBi
         fXZQ==
X-Gm-Message-State: ACgBeo2UhWeMwRP7goJOsCP0PYGENlCWh/4VGeEV4is000A0OP2KFozK
        idmK3oDcZ7hLp6POMg/hfkTUkNTrdHI0XA==
X-Google-Smtp-Source: AA6agR58JVgvrjep6N0J8KZ7AgCFjSunfgAQxnzR3rCCknMsZEdnmMQHeYb1TGW4bMC3R+KidVO0vw==
X-Received: by 2002:a05:6214:f0e:b0:499:56:c8cb with SMTP id gw14-20020a0562140f0e00b004990056c8cbmr24127298qvb.4.1662149821827;
        Fri, 02 Sep 2022 13:17:01 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z4-20020ac84544000000b00343057845f7sm1517916qtn.20.2022.09.02.13.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:17:01 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 13/31] btrfs: remove struct tree_entry
Date:   Fri,  2 Sep 2022 16:16:18 -0400
Message-Id: <f71750ffad07b44b64a5385d19f33a920af7db55.1662149276.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1662149276.git.josef@toxicpanda.com>
References: <cover.1662149276.git.josef@toxicpanda.com>
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
 fs/btrfs/extent-io-tree.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 850c4e1c83f5..4e3cbb4edbe2 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -71,12 +71,6 @@ static inline void __btrfs_debug_check_extent_io_range(const char *caller,
 #define btrfs_debug_check_extent_io_range(c, s, e)	do {} while (0)
 #endif
 
-struct tree_entry {
-	u64 start;
-	u64 end;
-	struct rb_node rb_node;
-};
-
 /*
  * For the file_extent_tree, we want to hold the inode lock when we lookup and
  * update the disk_i_size, but lockdep will complain because our io_tree we hold
@@ -258,11 +252,11 @@ static inline struct rb_node *tree_search_for_insert(struct extent_io_tree *tree
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
@@ -280,7 +274,7 @@ static inline struct rb_node *tree_search_for_insert(struct extent_io_tree *tree
 	/* Search neighbors until we find the first one past the end */
 	while (prev && offset > entry->end) {
 		prev = rb_next(prev);
-		entry = rb_entry(prev, struct tree_entry, rb_node);
+		entry = rb_entry(prev, struct extent_state, rb_node);
 	}
 
 	return prev;
@@ -315,14 +309,14 @@ static struct rb_node *tree_search_prev_next(struct extent_io_tree *tree,
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
@@ -335,15 +329,15 @@ static struct rb_node *tree_search_prev_next(struct extent_io_tree *tree,
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
 
@@ -426,10 +420,10 @@ static int insert_state(struct extent_io_tree *tree,
 
 	node = &tree->state.rb_node;
 	while (*node) {
-		struct tree_entry *entry;
+		struct extent_state *entry;
 
 		parent = *node;
-		entry = rb_entry(parent, struct tree_entry, rb_node);
+		entry = rb_entry(parent, struct extent_state, rb_node);
 
 		if (end < entry->start) {
 			node = &(*node)->rb_left;
@@ -495,10 +489,10 @@ static int split_state(struct extent_io_tree *tree, struct extent_state *orig,
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

