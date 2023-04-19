Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079A46E838E
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjDSVW7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjDSVW6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:22:58 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED037EFD
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:22:33 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id ei23so677900qtb.2
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681939265; x=1684531265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JQGcgc7znl8Vmhgxyjz/2T51un9Yluw+ia9GUneEN1A=;
        b=pQt56q+DJ+5CeP6eANyZ0rKTJx2iI/KL5o++9/U7atkIQO1TBM+8SfRF1rQ2TXqHV0
         p+w29ojSsM7jPMY6kU9bpAKwYOmPioDoiOm7itZlplBS3t77BMYATHsMcVNmNLeLhbMY
         bLm0nrpZqQK6CxqJ+jqaOcPz9UMdk0cChN+0yl5BPogFi9J2y53nH4vJGPfukYcwJSfu
         n/PlWrTc6ZQCqfQEUHvznhTRtnSIbUkErul6/Jsh1GWkLtYr3ziEq3snL+ad/pYz/E0u
         NPG2bXsWO7KovHaW2Gc3wrHxT+NpQKP1osVHuvbuzvA20wE6tU6gWFET/VVKnBLZgeIV
         EOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939265; x=1684531265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQGcgc7znl8Vmhgxyjz/2T51un9Yluw+ia9GUneEN1A=;
        b=VIpvgYf6o35UGuACsMzoWCdK0DD0YoiA038i+6ezw1pH9OycgtR54ePEm/NKdLifTc
         RHjDFpSgbAeY7+5CaatVWfNvf0OyxLdH9/zv87J1alzo9FKqlhRrVf5MhKmXz1T8n+8I
         ePqeZtiomEc1g94rCX5PvHxe00sjtnkoIvFxfsqhefDL4hxIE2Wy7Z07ZHeulxxckloC
         U5m3QaeCa7QXDTD/sa80BdQ3tNLchPmo7YyGIoEVLcKsdF1GJ6bghzUXra9it9CRppFx
         Gx95/4++dhpjXKg7++Ol9S0scrr4Yc/oduE6nk5Splcg45o2sOIcIaV/JKIp8UCRpPks
         sXqQ==
X-Gm-Message-State: AAQBX9fieEK0NIx0lwwkKsW1m7LiEUo964bF+k/ttUK6HIJrQZ3dUvHA
        YiGNDYeKwICm0CylETeUaSFK/VY+eNd4jnJ1pJErfA==
X-Google-Smtp-Source: AKy350aIAI97UbfObTLRYteunt2RPyHJSY6CzfG7imCIkRy+SmdOyovn4DmlWuqF2RdQgqxrdnV+dQ==
X-Received: by 2002:a05:622a:1193:b0:3ed:a811:23d0 with SMTP id m19-20020a05622a119300b003eda81123d0mr8463761qtk.41.1681939265528;
        Wed, 19 Apr 2023 14:21:05 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id b10-20020a05620a0cca00b0074c398c0bf7sm2289663qkj.71.2023.04.19.14.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:21:05 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 09/10] btrfs-progs: rename clear_extent_buffer_dirty => btrfs_clear_buffer_dirty
Date:   Wed, 19 Apr 2023 17:20:49 -0400
Message-Id: <b2492dc25783d9cf8668bfe9952fdb125e358b1f.1681939107.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681939107.git.josef@toxicpanda.com>
References: <cover.1681939107.git.josef@toxicpanda.com>
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

This is a mirror of the change I've done in the kernel, but in progs
it's even more simply because clean_tree_block was just a wrapper around
clear_extent_buffer_dirty.  Change this to btrfs_clear_buffer_dirty, and
then update all the callers to use this helper instead of
clean_tree_block and clear_extent_buffer_dirty.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 cmds/rescue.c               |  2 +-
 kernel-shared/ctree.c       | 12 ++++++------
 kernel-shared/disk-io.c     |  7 +------
 kernel-shared/extent-tree.c |  2 +-
 kernel-shared/extent_io.c   |  2 +-
 kernel-shared/extent_io.h   |  2 +-
 kernel-shared/transaction.c |  4 ++--
 7 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/cmds/rescue.c b/cmds/rescue.c
index cbeaa6f2..b84166ea 100644
--- a/cmds/rescue.c
+++ b/cmds/rescue.c
@@ -340,7 +340,7 @@ static int clear_uuid_tree(struct btrfs_fs_info *fs_info)
 	if (ret < 0)
 		goto out;
 	list_del(&uuid_root->dirty_list);
-	ret = clean_tree_block(uuid_root->node);
+	ret = btrfs_clear_buffer_dirty(uuid_root->node);
 	if (ret < 0)
 		goto out;
 	ret = btrfs_free_tree_block(trans, uuid_root, uuid_root->node, 0, 1);
diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index ea2a7af3..4d33994d 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -433,7 +433,7 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 			ret = btrfs_dec_ref(trans, root, buf, 1);
 			BUG_ON(ret);
 		}
-		clean_tree_block(buf);
+		btrfs_clear_buffer_dirty(buf);
 	}
 	return 0;
 }
@@ -936,7 +936,7 @@ static int balance_level(struct btrfs_trans_handle *trans,
 		root->node = child;
 		add_root_to_dirty_list(root);
 		path->nodes[level] = NULL;
-		clean_tree_block(mid);
+		btrfs_clear_buffer_dirty(mid);
 		/* once for the path */
 		free_extent_buffer(mid);
 
@@ -991,7 +991,7 @@ static int balance_level(struct btrfs_trans_handle *trans,
 			u64 bytenr = right->start;
 			u32 blocksize = right->len;
 
-			clean_tree_block(right);
+			btrfs_clear_buffer_dirty(right);
 			free_extent_buffer(right);
 			right = NULL;
 			wret = btrfs_del_ptr(root, path, level + 1, pslot + 1);
@@ -1039,7 +1039,7 @@ static int balance_level(struct btrfs_trans_handle *trans,
 		/* we've managed to empty the middle node, drop it */
 		u64 bytenr = mid->start;
 		u32 blocksize = mid->len;
-		clean_tree_block(mid);
+		btrfs_clear_buffer_dirty(mid);
 		free_extent_buffer(mid);
 		mid = NULL;
 		wret = btrfs_del_ptr(root, path, level + 1, pslot);
@@ -3012,7 +3012,7 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		if (leaf == root->node) {
 			btrfs_set_header_level(leaf, 0);
 		} else {
-			clean_tree_block(leaf);
+			btrfs_clear_buffer_dirty(leaf);
 			wret = btrfs_del_leaf(trans, root, path, leaf);
 			BUG_ON(ret);
 			if (wret)
@@ -3048,7 +3048,7 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			}
 
 			if (btrfs_header_nritems(leaf) == 0) {
-				clean_tree_block(leaf);
+				btrfs_clear_buffer_dirty(leaf);
 				path->slots[1] = slot;
 				ret = btrfs_del_leaf(trans, root, path, leaf);
 				BUG_ON(ret);
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 7ee45ad1..7bbcc381 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -2255,11 +2255,6 @@ skip_commit:
 	return err;
 }
 
-int clean_tree_block(struct extent_buffer *eb)
-{
-	return clear_extent_buffer_dirty(eb);
-}
-
 void btrfs_mark_buffer_dirty(struct extent_buffer *eb)
 {
 	set_extent_buffer_dirty(eb);
@@ -2303,7 +2298,7 @@ int btrfs_delete_and_free_root(struct btrfs_trans_handle *trans,
 		return ret;
 
 	list_del(&root->dirty_list);
-	ret = clean_tree_block(root->node);
+	ret = btrfs_clear_buffer_dirty(root->node);
 	if (ret)
 		return ret;
 	ret = btrfs_free_tree_block(trans, root, root->node, 0, 1);
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index cfce4426..4dfb35d4 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -1902,7 +1902,7 @@ static int pin_down_bytes(struct btrfs_trans_handle *trans, u64 bytenr,
 		if (header_owner != BTRFS_TREE_LOG_OBJECTID &&
 		    header_transid == trans->transid &&
 		    !btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
-			clean_tree_block(buf);
+			btrfs_clear_buffer_dirty(buf);
 			free_extent_buffer(buf);
 			return 1;
 		}
diff --git a/kernel-shared/extent_io.c b/kernel-shared/extent_io.c
index f740b3a6..4dff81bd 100644
--- a/kernel-shared/extent_io.c
+++ b/kernel-shared/extent_io.c
@@ -579,7 +579,7 @@ int set_extent_buffer_dirty(struct extent_buffer *eb)
 	return 0;
 }
 
-int clear_extent_buffer_dirty(struct extent_buffer *eb)
+int btrfs_clear_buffer_dirty(struct extent_buffer *eb)
 {
 	struct extent_io_tree *tree = &eb->fs_info->dirty_buffers;
 	if (eb->flags & EXTENT_BUFFER_DIRTY) {
diff --git a/kernel-shared/extent_io.h b/kernel-shared/extent_io.h
index 103f93cb..09f3c82a 100644
--- a/kernel-shared/extent_io.h
+++ b/kernel-shared/extent_io.h
@@ -124,7 +124,7 @@ void memset_extent_buffer(const struct extent_buffer *eb, char c,
 int extent_buffer_test_bit(const struct extent_buffer *eb, unsigned long start,
 			   unsigned long nr);
 int set_extent_buffer_dirty(struct extent_buffer *eb);
-int clear_extent_buffer_dirty(struct extent_buffer *eb);
+int btrfs_clear_buffer_dirty(struct extent_buffer *eb);
 int read_data_from_disk(struct btrfs_fs_info *info, void *buf, u64 logical,
 			u64 *len, int mirror);
 int write_data_to_disk(struct btrfs_fs_info *info, void *buf, u64 offset,
diff --git a/kernel-shared/transaction.c b/kernel-shared/transaction.c
index b16c07c3..f99bc684 100644
--- a/kernel-shared/transaction.c
+++ b/kernel-shared/transaction.c
@@ -161,7 +161,7 @@ again:
 				goto cleanup;
 			}
 			start += eb->len;
-			clear_extent_buffer_dirty(eb);
+			btrfs_clear_buffer_dirty(eb);
 			free_extent_buffer(eb);
 		}
 	}
@@ -184,7 +184,7 @@ cleanup:
 			eb = find_first_extent_buffer(fs_info, start);
 			BUG_ON(!eb || eb->start != start);
 			start += eb->len;
-			clear_extent_buffer_dirty(eb);
+			btrfs_clear_buffer_dirty(eb);
 			free_extent_buffer(eb);
 		}
 	}
-- 
2.40.0

