Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA01785A9A
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236477AbjHWOd3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236467AbjHWOd0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:33:26 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECFFE79
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:15 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d71c3a32e1aso5300350276.3
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692801194; x=1693405994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e1wMhu87fj8yCR2Ff3q/jizxT4irK1HD29PxYua+r/A=;
        b=PzywyVbCvrOtHsdVb6mi6Br7IIa8Wg59OxEKlZaoPU1v77ENAeL8ToEnV/Ar3im0Kj
         2KB9NnVcLLw2ZGC/QG1seGzb0Ry1eWAo//2RUm5gXLx4gL0Hyr5zLik7ECEUJLdqvpa7
         h2eeOhLejdvs11Oc9V596V0JZhesMHhGQYejWBtRgyBLpFcF8HYljehM+uN3RvH5x5ZE
         nm9SLlyUiWXJZtuyqhKLiRG5eqfkPaGigsFHnauI7/rGc8QFB9RAjMzh6cFMUPlfZh5C
         Ok8aYELlAAaz1rKqpqrtM64K+/oLqE0lZOF4sY7icf6PX7VQ6aHKy35T6rsOLUpB4hgL
         qHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801194; x=1693405994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1wMhu87fj8yCR2Ff3q/jizxT4irK1HD29PxYua+r/A=;
        b=QMASbMidVOzM+NVVxLaZrGofzEgEXHfBAwCjoZpZTnqrooYl4me4kQv73Cl9vL4PQP
         mOIMRTxcrcSvb9TvvTKHtR1OJcrR/EuMgpHe0XAsfrnOjoZDYpctK2gRwOAlOXvT0yWX
         g5If7sVCHhQSW9Q+JogYphS8AHhqgb67MASAr6pfv09/6qwXPiK560cKXFe44ADYnhpm
         OkHl4HU6+Ig0JYUuQ1W6zEnVRBfgeTzaMqUqkzuwh3Y5FmlLX3bMSRjI/voKOyYGF0NZ
         4Ho89nkxwAhlEccNc+tdGscoY9Ez0XCsAmH7x7o7VjcUhskEb8AX/g4qqERt7iNLmHte
         ybFw==
X-Gm-Message-State: AOJu0YzP5ylHivG3OoMp0+SL7F+2MYdNBihwfaC/hO2ogjO9lBp3vqgE
        acO5mAc7oxZQdG5kcAg8xCCD8DYdLXRJu0Ndi9Q=
X-Google-Smtp-Source: AGHT+IF+ifNJdwDotM5yA4ylXn5hm22d+PyFAAev3G2L63ImiP83hqkcV6q1c55/2t1qaiaN656zJw==
X-Received: by 2002:a25:bccb:0:b0:d50:60a4:a1b6 with SMTP id l11-20020a25bccb000000b00d5060a4a1b6mr11218388ybm.63.1692801194331;
        Wed, 23 Aug 2023 07:33:14 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id y127-20020a253285000000b00d74c43dad49sm1495108yby.48.2023.08.23.07.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:33:14 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 05/38] btrfs-progs: pass btrfs_trans_handle through btrfs_clear_buffer_dirty
Date:   Wed, 23 Aug 2023 10:32:31 -0400
Message-ID: <7bb1e13416572388567f149591690ab8b80b6d1d.1692800904.git.josef@toxicpanda.com>
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
index e244d1af..cf39edd3 100644
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
index 6e88b4a9..a87a79b2 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -571,7 +571,7 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 			ret = btrfs_dec_ref(trans, root, buf, 1);
 			BUG_ON(ret);
 		}
-		btrfs_clear_buffer_dirty(buf);
+		btrfs_clear_buffer_dirty(trans, buf);
 	}
 	return 0;
 }
@@ -917,7 +917,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		root->node = child;
 		add_root_to_dirty_list(root);
 		path->nodes[level] = NULL;
-		btrfs_clear_buffer_dirty(mid);
+		btrfs_clear_buffer_dirty(trans, mid);
 		/* once for the path */
 		free_extent_buffer(mid);
 
@@ -971,7 +971,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 			u64 bytenr = right->start;
 			u32 blocksize = right->len;
 
-			btrfs_clear_buffer_dirty(right);
+			btrfs_clear_buffer_dirty(trans, right);
 			free_extent_buffer(right);
 			right = NULL;
 			wret = btrfs_del_ptr(root, path, level + 1, pslot + 1);
@@ -1018,7 +1018,7 @@ static noinline int balance_level(struct btrfs_trans_handle *trans,
 		/* we've managed to empty the middle node, drop it */
 		u64 bytenr = mid->start;
 		u32 blocksize = mid->len;
-		btrfs_clear_buffer_dirty(mid);
+		btrfs_clear_buffer_dirty(trans, mid);
 		free_extent_buffer(mid);
 		mid = NULL;
 		wret = btrfs_del_ptr(root, path, level + 1, pslot);
@@ -2982,7 +2982,7 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		if (leaf == root->node) {
 			btrfs_set_header_level(leaf, 0);
 		} else {
-			btrfs_clear_buffer_dirty(leaf);
+			btrfs_clear_buffer_dirty(trans, leaf);
 			wret = btrfs_del_leaf(trans, root, path, leaf);
 			BUG_ON(ret);
 			if (wret)
@@ -3018,7 +3018,7 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 			}
 
 			if (btrfs_header_nritems(leaf) == 0) {
-				btrfs_clear_buffer_dirty(leaf);
+				btrfs_clear_buffer_dirty(trans, leaf);
 				path->slots[1] = slot;
 				ret = btrfs_del_leaf(trans, root, path, leaf);
 				BUG_ON(ret);
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 6a3178a8..35b6cde9 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -2289,7 +2289,7 @@ int btrfs_delete_and_free_root(struct btrfs_trans_handle *trans,
 		return ret;
 
 	list_del(&root->dirty_list);
-	ret = btrfs_clear_buffer_dirty(root->node);
+	ret = btrfs_clear_buffer_dirty(trans, root->node);
 	if (ret)
 		return ret;
 	ret = btrfs_free_tree_block(trans, btrfs_root_id(root), root->node, 0, 1);
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 91dd7ca1..8c7dab3f 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -1898,7 +1898,7 @@ static int pin_down_bytes(struct btrfs_trans_handle *trans, u64 bytenr,
 		if (header_owner != BTRFS_TREE_LOG_OBJECTID &&
 		    header_transid == trans->transid &&
 		    !btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
-			btrfs_clear_buffer_dirty(buf);
+			btrfs_clear_buffer_dirty(trans, buf);
 			free_extent_buffer(buf);
 			return 1;
 		}
diff --git a/kernel-shared/extent_io.c b/kernel-shared/extent_io.c
index c653d7c3..503b63e2 100644
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
index 520ccd78..243ffe74 100644
--- a/kernel-shared/extent_io.h
+++ b/kernel-shared/extent_io.h
@@ -54,6 +54,7 @@ static inline int le_test_bit(int nr, const u8 *addr)
 }
 
 struct btrfs_fs_info;
+struct btrfs_trans_handle;
 
 struct extent_buffer {
 	struct cache_extent cache_node;
@@ -128,7 +129,8 @@ void memset_extent_buffer(const struct extent_buffer *eb, char c,
 int extent_buffer_test_bit(const struct extent_buffer *eb, unsigned long start,
 			   unsigned long nr);
 int set_extent_buffer_dirty(struct extent_buffer *eb);
-int btrfs_clear_buffer_dirty(struct extent_buffer *eb);
+int btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
+			     struct extent_buffer *eb);
 int read_data_from_disk(struct btrfs_fs_info *info, void *buf, u64 logical,
 			u64 *len, int mirror);
 int write_data_to_disk(struct btrfs_fs_info *info, const void *buf, u64 offset,
diff --git a/kernel-shared/transaction.c b/kernel-shared/transaction.c
index 49b435f6..87d86fcd 100644
--- a/kernel-shared/transaction.c
+++ b/kernel-shared/transaction.c
@@ -163,7 +163,7 @@ again:
 				goto cleanup;
 			}
 			start += eb->len;
-			btrfs_clear_buffer_dirty(eb);
+			btrfs_clear_buffer_dirty(trans, eb);
 			free_extent_buffer(eb);
 		}
 	}
@@ -186,7 +186,7 @@ cleanup:
 			eb = find_first_extent_buffer(fs_info, start);
 			BUG_ON(!eb || eb->start != start);
 			start += eb->len;
-			btrfs_clear_buffer_dirty(eb);
+			btrfs_clear_buffer_dirty(trans, eb);
 			free_extent_buffer(eb);
 		}
 	}
-- 
2.41.0

