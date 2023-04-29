Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C7E6F2631
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 22:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjD2UH4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 16:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjD2UHx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 16:07:53 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3110826A2
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:07:45 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-b9a6f17f2b6so14180163276.1
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682798864; x=1685390864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xZAeofo2K+pYk8Er0WS21gWHrYXLDgN+I/eX2G11YDU=;
        b=0SHciu5B4GdydqABszMDaVfXbE/ES9fbxSQMfmXXI9pZc9JtH/t5VW2fFI/cW3aTAY
         0Z/u8cm7/LOSRiTDH3Dj7Aj+u1Bad46x9BGBVK5VJkYLCczy0XWNke1gLwBvjH6BTRPk
         kQQoKQifvCFJPb7eymp/hfm8ANjDAizwP+maCXn4wSauoLgw906Td/6058qq9qJg+8Rc
         W/lIy51+iTTZKbEBdhLRcxhhg/JzkEoP8O+98BF2H7bd/8GQdKxtsHjGNi/5g2ZNHevm
         BF9DXgBXQmM7XFehXEuiSJVJXE+g9mfEC0KkZEZhKCt2CXMnQQqSQRl6cxAFFwiLrBLw
         BCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682798864; x=1685390864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZAeofo2K+pYk8Er0WS21gWHrYXLDgN+I/eX2G11YDU=;
        b=M7Uqm2HJvQ+m0ndGe1E5IO2VcSNjtujgHN0HiH81C66YmWUFBZw2yLa3HqiCDZUEE9
         yLTC3RtWrQy27POoQ/R0nkb6EYt/u8xFj05V2p7/DsnG97tQNCS9nefTnUtn6kwtVNft
         H0xV5lWEvz82n68w3HObAOg20b2P2Tgry3qoaqPwvolZRDzf9IM/oxTqBRkYsNvhF6mJ
         pmJBpC1bCaG5HzVB/KmA5f2PVim4ooewyLkB4YkLeqzAGFm5EJotWscAxpdtyaf5Npyp
         QrOcsGlRl0H5PKz8ub5bfyG6yXZWvlooa5P+MQCf29EfOFPtPaKdg6Vzp3Ji1IYEnO6g
         Tl+A==
X-Gm-Message-State: AC+VfDwQWKZsugD9FBNY5PWiaq+TBOb2SYP4cEjZMTcba32+Dn9Ce9ft
        YWQDTE9pUpQkADhLaDvX8TcbEIu3Lu75F47HEsYNaQ==
X-Google-Smtp-Source: ACHHUZ4DQuJUpbm5TLJq1DyjdSE8M42YnpvscHQBhdmf9klcI3Zo0QgEUQYbwpQ/UiMKmjdBxufmrw==
X-Received: by 2002:a81:4f84:0:b0:55a:101e:aaf0 with SMTP id d126-20020a814f84000000b0055a101eaaf0mr483837ywb.16.1682798863938;
        Sat, 29 Apr 2023 13:07:43 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id j62-20020a0de041000000b0054eb6b21b9csm6199294ywe.84.2023.04.29.13.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:07:43 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 12/12] btrfs: rename del_ptr -> btrfs_del_ptr and export it
Date:   Sat, 29 Apr 2023 16:07:21 -0400
Message-Id: <7d772d80cffccb4054b74abd90649e1c4350a361.1682798736.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1682798736.git.josef@toxicpanda.com>
References: <cover.1682798736.git.josef@toxicpanda.com>
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

This exists internal to ctree.c, however btrfs check needs to use it for
some of its operations.  I'd rather not duplicate that code inside of
btrfs check as this is low level and I want to keep this code in one
place, so rename the function to btrfs_del_ptr and export it so that it
can be used inside of btrfs-progs safely.  Add a comment to make sure
this doesn't get removed by a future cleanup.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c | 16 ++++++++--------
 fs/btrfs/ctree.h |  2 ++
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index c95c62baef3e..198773503cfd 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -37,8 +37,6 @@ static int push_node_left(struct btrfs_trans_handle *trans,
 static int balance_node_right(struct btrfs_trans_handle *trans,
 			      struct extent_buffer *dst_buf,
 			      struct extent_buffer *src_buf);
-static void del_ptr(struct btrfs_root *root, struct btrfs_path *path,
-		    int level, int slot);
 
 static const struct btrfs_csums {
 	u16		size;
@@ -1122,7 +1120,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		if (btrfs_header_nritems(right) == 0) {
 			btrfs_clear_buffer_dirty(trans, right);
 			btrfs_tree_unlock(right);
-			del_ptr(root, path, level + 1, pslot + 1);
+			btrfs_del_ptr(root, path, level + 1, pslot + 1);
 			root_sub_used(root, right->len);
 			btrfs_free_tree_block(trans, btrfs_root_id(root), right,
 					      0, 1);
@@ -1168,7 +1166,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 	if (btrfs_header_nritems(mid) == 0) {
 		btrfs_clear_buffer_dirty(trans, mid);
 		btrfs_tree_unlock(mid);
-		del_ptr(root, path, level + 1, pslot);
+		btrfs_del_ptr(root, path, level + 1, pslot);
 		root_sub_used(root, mid->len);
 		btrfs_free_tree_block(trans, btrfs_root_id(root), mid, 0, 1);
 		free_extent_buffer_stale(mid);
@@ -4276,9 +4274,11 @@ int btrfs_duplicate_item(struct btrfs_trans_handle *trans,
  *
  * the tree should have been previously balanced so the deletion does not
  * empty a node.
+ *
+ * This is exported for use inside btrfs-progs, don't un-export it.
  */
-static void del_ptr(struct btrfs_root *root, struct btrfs_path *path,
-		    int level, int slot)
+void btrfs_del_ptr(struct btrfs_root *root, struct btrfs_path *path, int level,
+		   int slot)
 {
 	struct extent_buffer *parent = path->nodes[level];
 	u32 nritems;
@@ -4333,7 +4333,7 @@ static noinline void btrfs_del_leaf(struct btrfs_trans_handle *trans,
 				    struct extent_buffer *leaf)
 {
 	WARN_ON(btrfs_header_generation(leaf) != trans->transid);
-	del_ptr(root, path, 1, path->slots[1]);
+	btrfs_del_ptr(root, path, 1, path->slots[1]);
 
 	/*
 	 * btrfs_free_extent is expensive, we want to make sure we
@@ -4419,7 +4419,7 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 
 			/* push_leaf_left fixes the path.
 			 * make sure the path still points to our leaf
-			 * for possible call to del_ptr below
+			 * for possible call to btrfs_del_ptr below
 			 */
 			slot = path->slots[1];
 			atomic_inc(&leaf->refs);
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 221e230787e3..9dc9315c2bfa 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -541,6 +541,8 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 		      struct extent_buffer **cow_ret, u64 new_root_objectid);
 int btrfs_block_can_be_shared(struct btrfs_root *root,
 			      struct extent_buffer *buf);
+void btrfs_del_ptr(struct btrfs_root *root, struct btrfs_path *path, int level,
+		   int slot);
 void btrfs_extend_item(struct btrfs_path *path, u32 data_size);
 void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end);
 int btrfs_split_item(struct btrfs_trans_handle *trans,
-- 
2.40.0

