Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A66785AA0
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbjHWOdc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236484AbjHWOda (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:33:30 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87781E57
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:23 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5924093a9b2so23677667b3.2
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692801202; x=1693406002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T0ZQF567ER/Ck2OhzmAVs5dslXtY3Ed+YTVW2Y/9WFY=;
        b=Dzj9a09CHJAmdBIjo8sF2NoO1frqEMzSEzMnOaz3NCH/P7IpJxVD6uF9+l4Q9YxhiO
         9PISsrXv2txQZAD33mNNih6jbVKVbKW1AarDz/hHhXSHUOMYWUxX/F16iZvAm3hjZDmD
         nwi6Ho0NSRfkgz3vggi5mF333NVsOKutE/IxuGTvLWVCDeZJywbR2O3CR2vsgaSAz8Ze
         zTqR+CJrrvz+Ot9E1upVCZGZTvdCyBPEqQ6KRYMQgBLeeIjJyoy0uCnqFU6kGjLtRT5c
         c6ol+WPdisFmLIzOASyLNbHsrLHBPYiCWSEk7pEnq5pbU7/7Zfm7/d03OgYWuU6w6Mn4
         jT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801202; x=1693406002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T0ZQF567ER/Ck2OhzmAVs5dslXtY3Ed+YTVW2Y/9WFY=;
        b=h95pR7fW6WR3wjhWMIW+DzjlE2/g70JLssGs86KgCkoonG+IdweE09Lu0ZtMF0ilqe
         +ETNutAfp6a5r8KxLY6nw80Ke9ycaUhxsPAB8l5Y3oYIuxIJoLyhzpJ8TCnCyDBZEt+E
         FaB9ReYOaC4Izz7fHZE8on+KQQwUS8L0GvdK3YkOy8BBeTqhA8I/gqq6eiz3Phsd3C7T
         1MeUfPo9X/+LYPR5b510AWkJIyxVCX/HNkGJRanRnC37/UKT8+X+d9T2PDxet9PniXI9
         BoUcTp2VXuHseGv5xqas2nMOCa9LAlrN30XT4RBuIIouOMCkmWjyonCglKt2qhtguxYV
         uViA==
X-Gm-Message-State: AOJu0YyzF2ooS4+2q38nBWpYF4M5xckpbgmRjpJ+LuSZNMEw2iamNvks
        oKEF4JcWcJoaOeUnFiG/0StMBfPXjs8ahlCcdvY=
X-Google-Smtp-Source: AGHT+IG/zs5DjWa9BGMAWs9Qp+dCrvawDSGl0I612pXWxv96HThEcPyzlcH3ub8jPW+ZcuFDJUYQcg==
X-Received: by 2002:a81:920a:0:b0:58c:a87b:6e65 with SMTP id j10-20020a81920a000000b0058ca87b6e65mr15220207ywg.26.1692801201795;
        Wed, 23 Aug 2023 07:33:21 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id m124-20020a0dca82000000b005897fd75c80sm3361612ywd.78.2023.08.23.07.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:33:21 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 11/38] btrfs-progs: update btrfs_extend_item to match the kernel definition
Date:   Wed, 23 Aug 2023 10:32:37 -0400
Message-ID: <0d67f505513af33ba9d49bb3242cc0884b89a370.1692800904.git.josef@toxicpanda.com>
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

Similar to btrfs_truncate_item(), this is void in the kernel as the
failure case is simply BUG_ON().  Additionally there is no root
parameter as it's not used in the function at all.  Make these changes
and update the callers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.c       | 8 ++------
 kernel-shared/ctree.h       | 3 +--
 kernel-shared/dir-item.c    | 4 ++--
 kernel-shared/extent-tree.c | 4 +---
 kernel-shared/file-item.c   | 3 +--
 kernel-shared/inode-item.c  | 5 ++---
 6 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index b5d3d12e..ed8a7002 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -2661,10 +2661,8 @@ void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 	}
 }
 
-int btrfs_extend_item(struct btrfs_root *root, struct btrfs_path *path,
-		      u32 data_size)
+void btrfs_extend_item(struct btrfs_path *path, u32 data_size)
 {
-	int ret = 0;
 	int slot;
 	struct extent_buffer *leaf;
 	u32 nritems;
@@ -2712,12 +2710,10 @@ int btrfs_extend_item(struct btrfs_root *root, struct btrfs_path *path,
 	btrfs_set_item_size(leaf, slot, old_size + data_size);
 	btrfs_mark_buffer_dirty(leaf);
 
-	ret = 0;
 	if (btrfs_leaf_free_space(leaf) < 0) {
 		btrfs_print_leaf(leaf);
 		BUG();
 	}
-	return ret;
 }
 
 /*
@@ -3366,7 +3362,7 @@ int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
 		 * ret == -EEXIST case, An item with that type already exists.
 		 * Extend the item and store the new subvol_id at the end.
 		 */
-		btrfs_extend_item(uuid_root, path, sizeof(subvol_id_le));
+		btrfs_extend_item(path, sizeof(subvol_id_le));
 		eb = path->nodes[0];
 		slot = path->slots[0];
 		offset = btrfs_item_ptr_offset(eb, slot);
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 81d71d36..c7321a40 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -968,8 +968,7 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 		      struct extent_buffer **cow_ret, u64 new_root_objectid);
 int btrfs_create_root(struct btrfs_trans_handle *trans,
 		      struct btrfs_fs_info *fs_info, u64 objectid);
-int btrfs_extend_item(struct btrfs_root *root, struct btrfs_path *path,
-		u32 data_size);
+void btrfs_extend_item(struct btrfs_path *path, u32 data_size);
 void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end);
 int btrfs_split_item(struct btrfs_trans_handle *trans,
 		     struct btrfs_root *root,
diff --git a/kernel-shared/dir-item.c b/kernel-shared/dir-item.c
index abf7d047..cb70d7c8 100644
--- a/kernel-shared/dir-item.c
+++ b/kernel-shared/dir-item.c
@@ -48,8 +48,8 @@ static struct btrfs_dir_item *insert_with_overflow(struct btrfs_trans_handle
 		di = btrfs_match_dir_item_name(root, path, name, name_len);
 		if (di)
 			return ERR_PTR(-EEXIST);
-		ret = btrfs_extend_item(root, path, data_size);
-		WARN_ON(ret > 0);
+		btrfs_extend_item(path, data_size);
+		ret = 0;
 	}
 	if (ret < 0)
 		return ERR_PTR(ret);
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 001cffd1..543a9952 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -1039,7 +1039,6 @@ static int setup_inline_extent_backref(struct btrfs_root *root,
 	u64 refs;
 	int size;
 	int type;
-	int ret;
 
 	leaf = path->nodes[0];
 	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_extent_item);
@@ -1048,8 +1047,7 @@ static int setup_inline_extent_backref(struct btrfs_root *root,
 	type = extent_ref_type(parent, owner);
 	size = btrfs_extent_inline_ref_size(type);
 
-	ret = btrfs_extend_item(root, path, size);
-	BUG_ON(ret);
+	btrfs_extend_item(path, size);
 
 	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_extent_item);
 	refs = btrfs_extent_refs(leaf, ei);
diff --git a/kernel-shared/file-item.c b/kernel-shared/file-item.c
index e23e679e..7baa5614 100644
--- a/kernel-shared/file-item.c
+++ b/kernel-shared/file-item.c
@@ -282,8 +282,7 @@ int btrfs_csum_file_block(struct btrfs_trans_handle *trans, u64 logical,
 		diff = diff - btrfs_item_size(leaf, path->slots[0]);
 		if (diff != csum_size)
 			goto insert;
-		ret = btrfs_extend_item(root, path, diff);
-		BUG_ON(ret);
+		btrfs_extend_item(path, diff);
 		goto csum;
 	}
 
diff --git a/kernel-shared/inode-item.c b/kernel-shared/inode-item.c
index 891ae40a..d0705267 100644
--- a/kernel-shared/inode-item.c
+++ b/kernel-shared/inode-item.c
@@ -78,8 +78,7 @@ int btrfs_insert_inode_ref(struct btrfs_trans_handle *trans,
 			goto out;
 
 		old_size = btrfs_item_size(path->nodes[0], path->slots[0]);
-		ret = btrfs_extend_item(root, path, ins_len);
-		BUG_ON(ret);
+		btrfs_extend_item(path, ins_len);
 		ref = btrfs_item_ptr(path->nodes[0], path->slots[0],
 				     struct btrfs_inode_ref);
 		ref = (struct btrfs_inode_ref *)((unsigned long)ref + old_size);
@@ -352,7 +351,7 @@ int btrfs_insert_inode_extref(struct btrfs_trans_handle *trans,
 						   name, name_len, NULL))
 			goto out;
 
-		btrfs_extend_item(root, path, ins_len);
+		btrfs_extend_item(path, ins_len);
 		ret = 0;
 	}
 
-- 
2.41.0

