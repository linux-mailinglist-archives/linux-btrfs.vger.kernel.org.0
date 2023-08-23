Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9645785AB2
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbjHWOdo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236516AbjHWOdo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:33:44 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CEDE54
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:42 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-59209b12c50so38716057b3.0
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692801221; x=1693406021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1VZ0u/h3MaEVNSrqFw3lZ2LvelYuaUdBTBHZTg32hUU=;
        b=HVjJGI0eXjzE1qY74e8PM7ecoQjlmJytpyG5iAwB4F0/HcarvZBMmkWZ8ch+cihT/u
         1J9wcwSFW27Z1u7+fWEDbjLU3enQ6y9qsokDgYdZK5nOvsl0Kiz5ZBCeAzOWKJIv84B3
         eQl2SpPcjWAFy7UQQTDUT9Zmd0akb2sBHxzS/PYGhptRS7ZkyGAPEn6TqhQAFby7gwBh
         iBA+kO5Lq+TYsfHIcioWHGEH8lMEzLullRSI6e2n+/2FJnLxMpv/LVPOMay/RS75e+gd
         GHxvrSu8xNWgtZ1lMpbgLaVKnUp6z51RSuwe14SlRIOiAD+BwuIv/mi//YONrfAkFcru
         Axtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801222; x=1693406022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1VZ0u/h3MaEVNSrqFw3lZ2LvelYuaUdBTBHZTg32hUU=;
        b=Q4/JtXOIDwHoh7WyFIk/A3LeMoAPad3D3NUF1OxC+IR2Et7QRNoKHuV2QaXjxRFVXC
         3sTtR6gQ3eG4UNHcz6EHJ2uOmfls08srABb+5hRRh6loYDk6pNJHA1+78TICr++Xxd/7
         wUYsVlyrMGWyyLg40SivihTyXsF6jTkos8cc62iWc+wE6B2X7UPdXZSJ/0E5IkXPIv8x
         TPWe2fLIUyUtG7hgD8B2CSWWnl9ApcBohZ7llGdPVjnDFtj1+s9lLKiDtXipgYj2vvQh
         en8vLlIXSk8QPO3faae18xh8KTs5qHYU9lqw2sKQAgSeI3Vgf8XMOzfwFa6PZfJFJlIV
         i1Eg==
X-Gm-Message-State: AOJu0YwEm0FPbDHRa0W90mfned+LQInTSSV/sHujSJLFATMgO8uQv7Uj
        +bXM0MM9CoABWQXut4ymA9xA3XUYMrQ5O2HUoZM=
X-Google-Smtp-Source: AGHT+IF4NDC1TbLkP7BoRWuOJCKyE6+OEiIO6bhCVy55ughlGZKsPkTWL5ueZIjaP4mdsfs4WYlJKg==
X-Received: by 2002:a81:4e11:0:b0:561:429e:acd2 with SMTP id c17-20020a814e11000000b00561429eacd2mr12446383ywb.35.1692801221730;
        Wed, 23 Aug 2023 07:33:41 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id j80-20020a819253000000b005845e6f9b50sm3370069ywg.113.2023.08.23.07.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:33:41 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 28/38] btrfs-progs: update btrfs_cow_block to match the in-kernel definition
Date:   Wed, 23 Aug 2023 10:32:54 -0400
Message-ID: <282e8789254caaed291d825616d0c1d3fe203e3e.1692800904.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692800904.git.josef@toxicpanda.com>
References: <cover.1692800904.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_cow_block takes the lockdep nesting enum in the kernel.  Update
the definition to match the kernel version to make sync'ing ctree.c into
btrfs-progs more straightforward.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.c       | 24 +++++++++++++++---------
 kernel-shared/ctree.h       |  3 ++-
 kernel-shared/transaction.c |  3 ++-
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index e3b29a3a..13f8a437 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -557,7 +557,8 @@ static inline int should_cow_block(struct btrfs_trans_handle *trans,
 int btrfs_cow_block(struct btrfs_trans_handle *trans,
 		    struct btrfs_root *root, struct extent_buffer *buf,
 		    struct extent_buffer *parent, int parent_slot,
-		    struct extent_buffer **cow_ret)
+		    struct extent_buffer **cow_ret,
+		    enum btrfs_lock_nesting nest)
 {
 	u64 search_start;
 	int ret;
@@ -788,7 +789,8 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		/* promote the child to a root */
 		child = btrfs_read_node_slot(mid, 0);
 		BUG_ON(!extent_buffer_uptodate(child));
-		ret = btrfs_cow_block(trans, root, child, mid, 0, &child);
+		ret = btrfs_cow_block(trans, root, child, mid, 0, &child,
+				      BTRFS_NESTING_NORMAL);
 		BUG_ON(ret);
 
 		root->node = child;
@@ -813,7 +815,8 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 	left = btrfs_read_node_slot(parent, pslot - 1);
 	if (extent_buffer_uptodate(left)) {
 		wret = btrfs_cow_block(trans, root, left,
-				       parent, pslot - 1, &left);
+				       parent, pslot - 1, &left,
+				       BTRFS_NESTING_NORMAL);
 		if (wret) {
 			ret = wret;
 			goto enospc;
@@ -822,7 +825,8 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 	right = btrfs_read_node_slot(parent, pslot + 1);
 	if (extent_buffer_uptodate(right)) {
 		wret = btrfs_cow_block(trans, root, right,
-				       parent, pslot + 1, &right);
+				       parent, pslot + 1, &right,
+				       BTRFS_NESTING_NORMAL);
 		if (wret) {
 			ret = wret;
 			goto enospc;
@@ -980,7 +984,8 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 			wret = 1;
 		} else {
 			ret = btrfs_cow_block(trans, root, left, parent,
-					      pslot - 1, &left);
+					      pslot - 1, &left,
+					      BTRFS_NESTING_NORMAL);
 			if (ret)
 				wret = 1;
 			else {
@@ -1023,7 +1028,7 @@ static noinline int push_nodes_for_insert(struct btrfs_trans_handle *trans,
 		} else {
 			ret = btrfs_cow_block(trans, root, right,
 					      parent, pslot + 1,
-					      &right);
+					      &right, BTRFS_NESTING_NORMAL);
 			if (ret)
 				wret = 1;
 			else {
@@ -1213,7 +1218,7 @@ again:
 			wret = btrfs_cow_block(trans, root, b,
 					       p->nodes[level + 1],
 					       p->slots[level + 1],
-					       &b);
+					       &b, BTRFS_NESTING_NORMAL);
 			if (wret) {
 				free_extent_buffer(b);
 				return wret;
@@ -1822,7 +1827,7 @@ static int push_leaf_right(struct btrfs_trans_handle *trans, struct btrfs_root
 
 	/* cow and double check */
 	ret = btrfs_cow_block(trans, root, right, upper,
-			      slot + 1, &right);
+			      slot + 1, &right, BTRFS_NESTING_NORMAL);
 	if (ret) {
 		free_extent_buffer(right);
 		return 1;
@@ -1968,7 +1973,8 @@ static int push_leaf_left(struct btrfs_trans_handle *trans, struct btrfs_root
 
 	/* cow and double check */
 	ret = btrfs_cow_block(trans, root, left,
-			      path->nodes[1], slot - 1, &left);
+			      path->nodes[1], slot - 1, &left,
+			      BTRFS_NESTING_NORMAL);
 	if (ret) {
 		/* we hit -ENOSPC, but it isn't fatal here */
 		free_extent_buffer(left);
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 2f6a0cab..07a5992c 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -957,7 +957,8 @@ int btrfs_previous_extent_item(struct btrfs_root *root,
 int btrfs_cow_block(struct btrfs_trans_handle *trans,
 		    struct btrfs_root *root, struct extent_buffer *buf,
 		    struct extent_buffer *parent, int parent_slot,
-		    struct extent_buffer **cow_ret);
+		    struct extent_buffer **cow_ret,
+		    enum btrfs_lock_nesting nest);
 int btrfs_copy_root(struct btrfs_trans_handle *trans,
 		      struct btrfs_root *root,
 		      struct extent_buffer *buf,
diff --git a/kernel-shared/transaction.c b/kernel-shared/transaction.c
index 87d86fcd..48947d10 100644
--- a/kernel-shared/transaction.c
+++ b/kernel-shared/transaction.c
@@ -100,7 +100,8 @@ int commit_tree_roots(struct btrfs_trans_handle *trans,
 
 	eb = fs_info->tree_root->node;
 	extent_buffer_get(eb);
-	ret = btrfs_cow_block(trans, fs_info->tree_root, eb, NULL, 0, &eb);
+	ret = btrfs_cow_block(trans, fs_info->tree_root, eb, NULL, 0, &eb,
+			      BTRFS_NESTING_NORMAL);
 	free_extent_buffer(eb);
 	if (ret)
 		return ret;
-- 
2.41.0

