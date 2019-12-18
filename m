Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC36123ECD
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 06:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfLRFTK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Dec 2019 00:19:10 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36233 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfLRFTJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Dec 2019 00:19:09 -0500
Received: by mail-pj1-f67.google.com with SMTP id n59so321346pjb.1
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 21:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=32gkv9Lz6mKKiD954RvBEHUyjFTRJxM7+xGT9a2U4a4=;
        b=EJB2JqCEAo+tOLHh9f1n6l1nla6rgtxQkK1W/b5dfHs36I4m04XGhzN6gFMERx6IbI
         9L4e74eZxH8+rHe3kW/Wosk9szDB7U3YQfc7+rDXHQ2Xpbg/Fzn5lpEaU4JtP4NuGGp4
         UG2OjaXA9YpJPJtZ22EXVTFiRMEw+Xly79uUGH4UmSMyEWKsn0h99bsOZR0pLhjVSwIW
         OCFmPPECua+bqx7Tb80YywLMf7KLa3m4leR0jnnQAcgGe6H0MH8hAmUSiHKLWEG4pR9c
         yjHnuM4qvZDjboScpqLLpQE6oN8R7ccYOLYvLdUaA1eBsmYv5BVAESwloLx2pTdtrmac
         kJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=32gkv9Lz6mKKiD954RvBEHUyjFTRJxM7+xGT9a2U4a4=;
        b=RnzRX8t1RdmTH/6PexQABHNlHH1T/S/Y/9P3kXQwO1Cm00E5XF7coHLmh0F2mcGNYt
         xsjvqbIsaBCfBoRReYTsRuRTZTrf+E5VX6W4udexOoJaOMGPhYMq9l/RB7mG502r1C/b
         58Cyv/4Y1nXlTB0ReeXvsBurEdNqmGjXQ5ITeUvhQWBxzawZbfchHBZvAC/7vRPfwYta
         pR2ug8bm53PFFCZpNmUfckBzJYV3Ey6i5laVFQuZAauC1c9vmbTlOp2BpqpVz14Uvfjc
         VpN2dUadLVS0LK2p0yZCChKpa2yxRnfSg454hfk+ST+0IRbyqQnZdVUM/WsRDBiPF+oO
         cdqw==
X-Gm-Message-State: APjAAAUvftisfIvO7LQ9a1s1zJGG6c5HcA/QOW1m7HrMrEMTYM/WnLvf
        Twr+ZSoDY/EH2d3WFMs2gcjDCb7t3mg=
X-Google-Smtp-Source: APXvYqwpVHo8zOWtXC+HLowY1Ez+9T2aU3JQy4SGw1pVwQwxtjRRnJpf+2OlwubY4Pvrxq16Vq/NOA==
X-Received: by 2002:a17:902:aa90:: with SMTP id d16mr521840plr.279.1576646348653;
        Tue, 17 Dec 2019 21:19:08 -0800 (PST)
Received: from p.lan (81.249.92.34.bc.googleusercontent.com. [34.92.249.81])
        by smtp.gmail.com with ESMTPSA id e2sm1014781pfh.84.2019.12.17.21.19.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 21:19:08 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>, Qu Wenruo <wqu@suse.com>
Subject: [PATCH V2 07/10] block-progs: block_group: add dirty_bgs list related memebers
Date:   Wed, 18 Dec 2019 13:18:46 +0800
Message-Id: <20191218051849.2587-8-Damenly_Su@gmx.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
In-Reply-To: <20191218051849.2587-1-Damenly_Su@gmx.com>
References: <20191218051849.2587-1-Damenly_Su@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Su Yue <Damenly_Su@gmx.com>

The old style uses extent bit BLOCK_GROUP_DIRTY to mark dirty block
groups in extent cache. To replace it, add btrfs_trans_handle::dirty_bgs
and btrfs_block_group_cache::dirty_list.

Signed-off-by: Su Yue <Damenly_Su@gmx.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 ctree.h       | 3 +++
 extent-tree.c | 4 ++++
 transaction.c | 1 +
 transaction.h | 3 ++-
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/ctree.h b/ctree.h
index f3f5f52f2559..61ce53c46302 100644
--- a/ctree.h
+++ b/ctree.h
@@ -1119,6 +1119,9 @@ struct btrfs_block_group_cache {
 
 	/* Block group cache stuff */
 	struct rb_node cache_node;
+
+	/* For dirty block groups */
+	struct list_head dirty_list;
 };
 
 struct btrfs_device;
diff --git a/extent-tree.c b/extent-tree.c
index 9e681273d4b8..615d823ec4de 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -2814,6 +2814,8 @@ static int read_one_block_group(struct btrfs_fs_info *fs_info,
 	cache->pinned = 0;
 	cache->flags = btrfs_block_group_flags(&bgi);
 	cache->used = btrfs_block_group_used(&bgi);
+	INIT_LIST_HEAD(&cache->dirty_list);
+
 	if (cache->flags & BTRFS_BLOCK_GROUP_DATA) {
 		bit = BLOCK_GROUP_DATA;
 	} else if (cache->flags & BTRFS_BLOCK_GROUP_SYSTEM) {
@@ -2895,6 +2897,7 @@ btrfs_add_block_group(struct btrfs_fs_info *fs_info, u64 bytes_used, u64 type,
 	cache->key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 	cache->used = bytes_used;
 	cache->flags = type;
+	INIT_LIST_HEAD(&cache->dirty_list);
 
 	exclude_super_stripes(fs_info, cache);
 	ret = update_space_info(fs_info, cache->flags, size, bytes_used,
@@ -2992,6 +2995,7 @@ int btrfs_make_block_groups(struct btrfs_trans_handle *trans,
 		cache->key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 		cache->used = 0;
 		cache->flags = group_type;
+		INIT_LIST_HEAD(&cache->dirty_list);
 
 		ret = update_space_info(fs_info, group_type, group_size,
 					0, &cache->space_info);
diff --git a/transaction.c b/transaction.c
index c9035c765a74..269e52c01d29 100644
--- a/transaction.c
+++ b/transaction.c
@@ -52,6 +52,7 @@ struct btrfs_trans_handle* btrfs_start_transaction(struct btrfs_root *root,
 	root->last_trans = h->transid;
 	root->commit_root = root->node;
 	extent_buffer_get(root->node);
+	INIT_LIST_HEAD(&h->dirty_bgs);
 
 	return h;
 }
diff --git a/transaction.h b/transaction.h
index 750f456b3cc0..8fa65508fa8d 100644
--- a/transaction.h
+++ b/transaction.h
@@ -22,6 +22,7 @@
 #include "kerncompat.h"
 #include "ctree.h"
 #include "delayed-ref.h"
+#include "kernel-lib/list.h"
 
 struct btrfs_trans_handle {
 	struct btrfs_fs_info *fs_info;
@@ -35,7 +36,7 @@ struct btrfs_trans_handle {
 	unsigned long blocks_used;
 	struct btrfs_block_group_cache *block_group;
 	struct btrfs_delayed_ref_root delayed_refs;
-
+	struct list_head dirty_bgs;
 };
 
 struct btrfs_trans_handle* btrfs_start_transaction(struct btrfs_root *root,
-- 
2.21.0 (Apple Git-122.2)

