Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C966F2654
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 22:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjD2UUY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 16:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjD2UUW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 16:20:22 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FDFE7D
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:17 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-54fe08015c1so18008307b3.3
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682799616; x=1685391616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zxCB5jzJZfUqDLthb+eGYPVJhFCz/EAHRvt4mRIkTZ4=;
        b=IKE++ve3PkkKV7Pw6niKzsMsMfNkKarO2fBVRFYnF6oqTKk0eOwiUWBfTt2AYdzEhM
         rs/coDa8WGwTB5zmO2qxzEqC4g5WNer3EvjKEVlh6Q5x+y8355SnyVkSW7mtv9tQVOKV
         X9bbqVlEJ6Y353WIn+C0b6aRx8A0j3aLO3o67+Ilj9Vb/yFNPsk92vHfDJvc7T7dOedT
         4kyYG8ZJl5CtjUO88j7bbEDqFjA12e169fDThA5GlG3vC0BZbQTE6eQaZjLlEP8s0r8C
         2IfqXtQ9nUe4ChMGqmBOJaOypVJ7ZwVyY6oyCZPc7vEbDieXm9aev+dEiKMlnZEDrlOO
         CEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682799616; x=1685391616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxCB5jzJZfUqDLthb+eGYPVJhFCz/EAHRvt4mRIkTZ4=;
        b=AWUvKuAanNlbo2A/Uzdrgte8UXv4AgNQ6Z+8tVmfdencalI1m4uqED2MVfuAo6iPdq
         kw9TAZcE3LGSMZVLKbBgGikDTarI5OHO8FrQ+ERMbWde6jR7OP6IEh+hDuwLeLobFmZH
         N0gnIo4dQDbbVfRJ9/kDVm4+TZ0gJQPOWeROGZa2sRfQhHLP2uoZa8PagAo+VY96RyiL
         1pk1GkUHkxg6CUPUzolrxVcJPvY0R1MTaFs6LILMnXpcmr2uFA0qs9AusMJZBQadkuLD
         LxQ4PFWUVHwIDu9iNPe4i0FaGVMZNs8hMRWvxRBf8rlBmjGq0FYBOcwOunhyGzKG2Nv9
         qnkg==
X-Gm-Message-State: AC+VfDz102mOU7MGp2vOiLIauVBB8Ul69AKoS/cL7KNdqpfhYxTanyI1
        T53UdsoPXPSlVeJuO8gd6FHCmwnCVuOKRFIE7npvAg==
X-Google-Smtp-Source: ACHHUZ7PTAyapVGLWU4Kg8AH6mTgd9KN9MYlyiWsJ4zfRwcNaNWNBQlKqtV25gAyARskaJ/fPZ3Cpg==
X-Received: by 2002:a0d:f5c7:0:b0:552:9689:72ed with SMTP id e190-20020a0df5c7000000b00552968972edmr6162331ywf.30.1682799615780;
        Sat, 29 Apr 2023 13:20:15 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id e133-20020a81698b000000b00545a08184e9sm6265352ywc.121.2023.04.29.13.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:20:15 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 10/26] btrfs-progs: update btrfs_truncate_item to match the kernel definition
Date:   Sat, 29 Apr 2023 16:19:41 -0400
Message-Id: <5e7702db922b116e91f7481526e60245913cb5c0.1682799405.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1682799405.git.josef@toxicpanda.com>
References: <cover.1682799405.git.josef@toxicpanda.com>
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

This is void in the kernel, and this makes sense in btrfs-progs as it
stands currently as it doesn't actually return an error if there's a
problem, it simply BUG()'s.  Update this to be a void and update the
callers to make it easier to sync ctree.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.c       | 7 ++-----
 kernel-shared/ctree.h       | 2 +-
 kernel-shared/extent-tree.c | 4 +---
 kernel-shared/file-item.c   | 7 ++-----
 4 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index a23128ee..d78a3258 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -2425,9 +2425,8 @@ split:
 	return ret;
 }
 
-int btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
+void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 {
-	int ret = 0;
 	int slot;
 	struct extent_buffer *leaf;
 	u32 nritems;
@@ -2442,7 +2441,7 @@ int btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 
 	old_size = btrfs_item_size(leaf, slot);
 	if (old_size == new_size)
-		return 0;
+		return;
 
 	nritems = btrfs_header_nritems(leaf);
 	data_end = leaf_data_end(leaf);
@@ -2508,12 +2507,10 @@ int btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 	btrfs_set_item_size(leaf, slot, new_size);
 	btrfs_mark_buffer_dirty(leaf);
 
-	ret = 0;
 	if (btrfs_leaf_free_space(leaf) < 0) {
 		btrfs_print_leaf(leaf);
 		BUG();
 	}
-	return ret;
 }
 
 int btrfs_extend_item(struct btrfs_root *root, struct btrfs_path *path,
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index e54d3bc3..18562f3b 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -969,7 +969,7 @@ int btrfs_create_root(struct btrfs_trans_handle *trans,
 		      struct btrfs_fs_info *fs_info, u64 objectid);
 int btrfs_extend_item(struct btrfs_root *root, struct btrfs_path *path,
 		u32 data_size);
-int btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end);
+void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end);
 int btrfs_split_item(struct btrfs_trans_handle *trans,
 		     struct btrfs_root *root,
 		     struct btrfs_path *path,
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index fa83d152..718a4fc9 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -1129,7 +1129,6 @@ static int update_inline_extent_backref(struct btrfs_trans_handle *trans,
 	u32 item_size;
 	int size;
 	int type;
-	int ret;
 	u64 refs;
 
 	leaf = path->nodes[0];
@@ -1169,8 +1168,7 @@ static int update_inline_extent_backref(struct btrfs_trans_handle *trans,
 			memmove_extent_buffer(leaf, ptr, ptr + size,
 					      end - ptr - size);
 		item_size -= size;
-		ret = btrfs_truncate_item(path, item_size, 1);
-		BUG_ON(ret);
+		btrfs_truncate_item(path, item_size, 1);
 	}
 	btrfs_mark_buffer_dirty(leaf);
 	return 0;
diff --git a/kernel-shared/file-item.c b/kernel-shared/file-item.c
index 87f80bfe..6e0f7381 100644
--- a/kernel-shared/file-item.c
+++ b/kernel-shared/file-item.c
@@ -356,7 +356,6 @@ static noinline int truncate_one_csum(struct btrfs_root *root,
 	u64 csum_end;
 	u64 end_byte = bytenr + len;
 	u32 blocksize = root->fs_info->sectorsize;
-	int ret;
 
 	leaf = path->nodes[0];
 	csum_end = btrfs_item_size(leaf, path->slots[0]) / csum_size;
@@ -372,8 +371,7 @@ static noinline int truncate_one_csum(struct btrfs_root *root,
 		 */
 		u32 new_size = (bytenr - key->offset) / blocksize;
 		new_size *= csum_size;
-		ret = btrfs_truncate_item(path, new_size, 1);
-		BUG_ON(ret);
+		btrfs_truncate_item(path, new_size, 1);
 	} else if (key->offset >= bytenr && csum_end > end_byte &&
 		   end_byte > key->offset) {
 		/*
@@ -385,8 +383,7 @@ static noinline int truncate_one_csum(struct btrfs_root *root,
 		u32 new_size = (csum_end - end_byte) / blocksize;
 		new_size *= csum_size;
 
-		ret = btrfs_truncate_item(path, new_size, 0);
-		BUG_ON(ret);
+		btrfs_truncate_item(path, new_size, 0);
 
 		key->offset = end_byte;
 		btrfs_set_item_key_safe(root->fs_info, path, key);
-- 
2.40.0

