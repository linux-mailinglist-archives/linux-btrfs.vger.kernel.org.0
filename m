Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DFA6F2668
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 22:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjD2UUO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 16:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjD2UUN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 16:20:13 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B451210A
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:11 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-552a6357d02so16102387b3.3
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682799610; x=1685391610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zFTqikvgjo5fVhqkz4RgFb15k/CN+mj8A4rT4aIo58c=;
        b=c7i4S6ZOw1YXBJNKNohMeXGjm+IK8bjhhJTu42gjPuZialSoNnciNbAa+kTC0SM5Rz
         tSpBckov0QACWqb0gsmEbuAL9IgkA0WO5WzqPoVamSUZnUnLOiDycj8Kh+zo0AO0Mo2Z
         6qseuKDTyXTch62wQW+24PBURIA/5Z3xZXoytGkKH3fySRYAG06Wv6H4ysVxomTRiF+t
         z4gEcWfLSPVnS+nlGaIEwwDdXulCueGzwrTjgyWfgaPtkTgMB8zEsBf2KRvGAeSuA5BQ
         JHR3cTgKpr2qoTDfCHzPJfOfBumZ8mOfSO+FW6Xrq2YcCdRPQqRvyznycrG9vgziOeb5
         M9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682799610; x=1685391610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFTqikvgjo5fVhqkz4RgFb15k/CN+mj8A4rT4aIo58c=;
        b=JTUUQoGRi+gZbVy63sOrAc/r5f41+MruwrE434CY9mCTuC1ubiezLp5Xc3h+2ImyuE
         alGBCtl47ElTAlgHEU14UX/zEXBCGhHw6RkOrhnZbBGTcs6SlkhZw/UV9HXBCNzLHUp+
         fTZs0agBdZboOnH7D9RKoFyWRwR8MKtt6U/mYl6p1TyHOp8kUJwpi2C/ABscFt2XdGHb
         KOhhqRKwMW7wCc0jKKzFBLupMN2zdPP3m3d3Zrw/Q+GpWIhLtqjG7isylHLYMTGsJAqo
         sGinTtIvid7YmTpwxBzk6R5sV/3/uGTx0LbIJh53rgeuotoaAr63OlrbS/xr7f4rStYh
         cXEw==
X-Gm-Message-State: AC+VfDybHJo5eoXHUv1K7YQwWg+nCI5mgBEFwlyKQWrWv+uR/s8EkdrQ
        1N2wIoyM9li4Og+rNmu0c8L7v3WC2AGjEF2zOBmL+w==
X-Google-Smtp-Source: ACHHUZ66qvKNEavufDIhWbTnVAU3/KIjSRgothi4QlunhmC4UfSudXqGT1Zg7300aSyLgdYE5DD9Mg==
X-Received: by 2002:a0d:db93:0:b0:541:85e1:3a87 with SMTP id d141-20020a0ddb93000000b0054185e13a87mr7642823ywe.33.1682799610375;
        Sat, 29 Apr 2023 13:20:10 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id v5-20020a814805000000b0054fba955474sm6259085ywa.17.2023.04.29.13.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:20:10 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 05/26] btrfs-progs: pass btrfs_trans_handle through btrfs_clear_buffer_dirty
Date:   Sat, 29 Apr 2023 16:19:36 -0400
Message-Id: <dc4c6f6a95ade7034ee01a4758b8268c88510e2d.1682799405.git.josef@toxicpanda.com>
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

This is the calling convention in the kernel because we track dirty
blocks per transaction instead of globally in the fs_info.  Simply
mirror what we do in the kernel to make it easier to sync ctree.c
locally.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 cmds/rescue.c               |  2 +-
 kernel-shared/ctree.c       | 12 ++++++------
 kernel-shared/disk-io.c     |  2 +-
 kernel-shared/extent-tree.c |  2 +-
 kernel-shared/extent_io.c   |  3 ++-
 kernel-shared/extent_io.h   |  4 +++-
 kernel-shared/transaction.c |  4 ++--
 7 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/cmds/rescue.c b/cmds/rescue.c
index 5551374d..75a4192f 100644
--- a/cmds/rescue.c
+++ b/cmds/rescue.c
@@ -340,7 +340,7 @@ static int clear_uuid_tree(struct btrfs_fs_info *fs_info)
 	if (ret < 0)
 		goto out;
 	list_del(&uuid_root->dirty_list);
-	ret = btrfs_clear_buffer_dirty(uuid_root->node);
+	ret = btrfs_clear_buffer_dirty(trans, uuid_root->node);
 	if (ret < 0)
 		goto out;
 	ret = btrfs_free_tree_block(trans, btrfs_root_id(uuid_root),
diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 3cb3378e..b127dcf9 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -434,7 +434,7 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 			ret = btrfs_dec_ref(trans, root, buf, 1);
 			BUG_ON(ret);
 		}
-		btrfs_clear_buffer_dirty(buf);
+		btrfs_clear_buffer_dirty(trans, buf);
 	}
 	return 0;
 }
@@ -760,7 +760,7 @@ static int balance_level(struct btrfs_trans_handle *trans,
 		root->node = child;
 		add_root_to_dirty_list(root);
 		path->nodes[level] = NULL;
-		btrfs_clear_buffer_dirty(mid);
+		btrfs_clear_buffer_dirty(trans, mid);
 		/* once for the path */
 		free_extent_buffer(mid);
 
@@ -814,7 +814,7 @@ static int balance_level(struct btrfs_trans_handle *trans,
 			u64 bytenr = right->start;
 			u32 blocksize = right->len;
 
-			btrfs_clear_buffer_dirty(right);
+			btrfs_clear_buffer_dirty(trans, right);
 			free_extent_buffer(right);
 			right = NULL;
 			wret = btrfs_del_ptr(root, path, level + 1, pslot + 1);
@@ -861,7 +861,7 @@ static int balance_level(struct btrfs_trans_handle *trans,
 		/* we've managed to empty the middle node, drop it */
 		u64 bytenr = mid->start;
 		u32 blocksize = mid->len;
-		btrfs_clear_buffer_dirty(mid);
+		btrfs_clear_buffer_dirty(trans, mid);
 		free_extent_buffer(mid);
 		mid = NULL;
 		wret = btrfs_del_ptr(root, path, level + 1, pslot);
@@ -2834,7 +2834,7 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		if (leaf == root->node) {
 			btrfs_set_header_level(leaf, 0);
 		} else {
-			btrfs_clear_buffer_dirty(leaf);
+			btrfs_clear_buffer_dirty(trans, leaf);
 			wret = btrfs_del_leaf(trans, root, path, leaf);
 			BUG_ON(ret);
 			if (wret)
@@ -2870,7 +2870,7 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			}
 
 			if (btrfs_header_nritems(leaf) == 0) {
-				btrfs_clear_buffer_dirty(leaf);
+				btrfs_clear_buffer_dirty(trans, leaf);
 				path->slots[1] = slot;
 				ret = btrfs_del_leaf(trans, root, path, leaf);
 				BUG_ON(ret);
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 536b7119..3e0c3534 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -2318,7 +2318,7 @@ int btrfs_delete_and_free_root(struct btrfs_trans_handle *trans,
 		return ret;
 
 	list_del(&root->dirty_list);
-	ret = btrfs_clear_buffer_dirty(root->node);
+	ret = btrfs_clear_buffer_dirty(trans, root->node);
 	if (ret)
 		return ret;
 	ret = btrfs_free_tree_block(trans, btrfs_root_id(root), root->node, 0, 1);
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 062ff4a7..bbce9587 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -1899,7 +1899,7 @@ static int pin_down_bytes(struct btrfs_trans_handle *trans, u64 bytenr,
 		if (header_owner != BTRFS_TREE_LOG_OBJECTID &&
 		    header_transid == trans->transid &&
 		    !btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
-			btrfs_clear_buffer_dirty(buf);
+			btrfs_clear_buffer_dirty(trans, buf);
 			free_extent_buffer(buf);
 			return 1;
 		}
diff --git a/kernel-shared/extent_io.c b/kernel-shared/extent_io.c
index 105b5ec8..e38bb1ed 100644
--- a/kernel-shared/extent_io.c
+++ b/kernel-shared/extent_io.c
@@ -585,7 +585,8 @@ int set_extent_buffer_dirty(struct extent_buffer *eb)
 	return 0;
 }
 
-int btrfs_clear_buffer_dirty(struct extent_buffer *eb)
+int btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
+			     struct extent_buffer *eb)
 {
 	struct extent_io_tree *tree = &eb->fs_info->dirty_buffers;
 	if (eb->flags & EXTENT_BUFFER_DIRTY) {
diff --git a/kernel-shared/extent_io.h b/kernel-shared/extent_io.h
index a1cda3a5..f573a4e2 100644
--- a/kernel-shared/extent_io.h
+++ b/kernel-shared/extent_io.h
@@ -54,6 +54,7 @@ static inline int le_test_bit(int nr, const u8 *addr)
 }
 
 struct btrfs_fs_info;
+struct btrfs_trans_handle;
 
 struct extent_buffer {
 	struct cache_extent cache_node;
@@ -125,7 +126,8 @@ void memset_extent_buffer(const struct extent_buffer *eb, char c,
 int extent_buffer_test_bit(const struct extent_buffer *eb, unsigned long start,
 			   unsigned long nr);
 int set_extent_buffer_dirty(struct extent_buffer *eb);
-int btrfs_clear_buffer_dirty(struct extent_buffer *eb);
+int btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
+			     struct extent_buffer *eb);
 int read_data_from_disk(struct btrfs_fs_info *info, void *buf, u64 logical,
 			u64 *len, int mirror);
 int write_data_to_disk(struct btrfs_fs_info *info, void *buf, u64 offset,
diff --git a/kernel-shared/transaction.c b/kernel-shared/transaction.c
index f99bc684..1e1ec85b 100644
--- a/kernel-shared/transaction.c
+++ b/kernel-shared/transaction.c
@@ -161,7 +161,7 @@ again:
 				goto cleanup;
 			}
 			start += eb->len;
-			btrfs_clear_buffer_dirty(eb);
+			btrfs_clear_buffer_dirty(trans, eb);
 			free_extent_buffer(eb);
 		}
 	}
@@ -184,7 +184,7 @@ cleanup:
 			eb = find_first_extent_buffer(fs_info, start);
 			BUG_ON(!eb || eb->start != start);
 			start += eb->len;
-			btrfs_clear_buffer_dirty(eb);
+			btrfs_clear_buffer_dirty(trans, eb);
 			free_extent_buffer(eb);
 		}
 	}
-- 
2.40.0

