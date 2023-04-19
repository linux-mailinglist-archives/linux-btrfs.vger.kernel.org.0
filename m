Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE96A6E83A1
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Apr 2023 23:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbjDSVZR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Apr 2023 17:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbjDSVZA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Apr 2023 17:25:00 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C656C61BE
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:24:31 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id op30so1112319qvb.3
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Apr 2023 14:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1681939470; x=1684531470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xm2lhsMie+Od/1P9VjOhQGQvmSmj+F3rtAw8v4XruEI=;
        b=4e+kokLpL1YdbpdV9pQJvJHFuUieqOJsENRZFr8BsTf5wSlgdQXRK6Ii4kiifYA9R5
         pD3eR8SH13GGjwerYaa7VXkf5RTbxPKB4o2987cNF9qRW9DH+9GKTzCpE9SD1nk65XwZ
         ztpmRyjqFitpGelgIYWRBlezZNmBRXeOdtsMY0sTYMI2M0dWxoZeFhJ1IJ9TIHEVcvTP
         Pbkqtq5NQoiSrqOmwJzu/6MkUIwhOIhxCuIVykuvEaNLCh/1/vzzUogW+/3dfL0KzdIN
         8zrJhkJX63GskdTW+jKQcbv4pdnobCDLYkYuqnHKFVGQ5Uj+dvYLxTQu3aKL03O5Hxnx
         UA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681939470; x=1684531470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xm2lhsMie+Od/1P9VjOhQGQvmSmj+F3rtAw8v4XruEI=;
        b=BEcjMlyRL2zTT2Ee309Y0Ou/HJe3MDG1CbHW/2w0JCo+YaD1mZl0RKfcEU1WN6zxuu
         UOtq7EMk25MUaH86uSEPGqOAq2RszOJd6JcJsAH3I/G880qjgZ2zaTlnUyicLTjzr057
         YJeQz3ZqhzCq8qSZXiS6b4KHl+tZXKYQlrU7yycORTZtcBTyXEW2pQ6u+17PD9WW0wxg
         AidHrY7ubNu0q/uQj7tl6ydOIoWirtwkoaQXXQWU+8dsWTLWuGy2B4c5aM3wN7E/qVFx
         gAgkP6XzNKTYBYUN4q2i4INCKm1i23xpjpysZRVzwJjJ8x1RX8WcW8pFMsiOqIjK73UV
         /1UQ==
X-Gm-Message-State: AAQBX9eKU+vTz79U2mtKmkfpfQqfoDunToCeBFOIxkQK8DlljyZpkMwx
        5k+mbi6JGifzmSi4Yi17zgahoWwo6gKxUed18Lz3WQ==
X-Google-Smtp-Source: AKy350boAZGjEAx6JbMzoprlwTEcm/jgvD3LHdUMqdItibDlOU/24QZuWobQVD1JzPUJLnQ80vzG/w==
X-Received: by 2002:a05:6214:e4f:b0:5ef:8159:b9a9 with SMTP id o15-20020a0562140e4f00b005ef8159b9a9mr16084935qvc.21.1681939470214;
        Wed, 19 Apr 2023 14:24:30 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id eb3-20020a05620a480300b0074b5219b63esm4023476qkb.121.2023.04.19.14.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 14:24:29 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 13/18] btrfs-progs: add an atomic arg to btrfs_buffer_uptodate
Date:   Wed, 19 Apr 2023 17:24:04 -0400
Message-Id: <51dfbda01b5de4ee153c1b34e22d9753d9dc389e.1681939316.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1681939316.git.josef@toxicpanda.com>
References: <cover.1681939316.git.josef@toxicpanda.com>
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

We have this extra argument in the kernel to indicate if we are atomic
and thus can't lock the io_tree when checking the transid for an extent
buffer.  This isn't necessary in btrfs-progs, but to allow for easier
sync'ing of ctree.c add this argument to our copy of
btrfs_buffer_uptodate.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check/main.c                | 2 +-
 check/mode-lowmem.c         | 2 +-
 kernel-shared/disk-io.c     | 9 +++++----
 kernel-shared/disk-io.h     | 3 ++-
 kernel-shared/extent-tree.c | 2 +-
 5 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/check/main.c b/check/main.c
index 610c3091..f15272bf 100644
--- a/check/main.c
+++ b/check/main.c
@@ -1895,7 +1895,7 @@ static int walk_down_tree(struct btrfs_root *root, struct btrfs_path *path,
 		}
 
 		next = btrfs_find_tree_block(gfs_info, bytenr, gfs_info->nodesize);
-		if (!next || !btrfs_buffer_uptodate(next, ptr_gen)) {
+		if (!next || !btrfs_buffer_uptodate(next, ptr_gen, 0)) {
 			free_extent_buffer(next);
 			reada_walk_down(root, cur, path->slots[*level]);
 			next = read_tree_block(gfs_info, bytenr,
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 83b86e63..fb294c90 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -5043,7 +5043,7 @@ static int walk_down_tree(struct btrfs_root *root, struct btrfs_path *path,
 		}
 
 		next = btrfs_find_tree_block(gfs_info, bytenr, gfs_info->nodesize);
-		if (!next || !btrfs_buffer_uptodate(next, ptr_gen)) {
+		if (!next || !btrfs_buffer_uptodate(next, ptr_gen, 0)) {
 			free_extent_buffer(next);
 			reada_walk_down(root, cur, path->slots[*level]);
 			next = read_tree_block(gfs_info, bytenr,
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 3b3188da..29fe9027 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -246,7 +246,7 @@ void readahead_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 	struct btrfs_device *device;
 
 	eb = btrfs_find_tree_block(fs_info, bytenr, fs_info->nodesize);
-	if (!(eb && btrfs_buffer_uptodate(eb, parent_transid)) &&
+	if (!(eb && btrfs_buffer_uptodate(eb, parent_transid, 0)) &&
 	    !btrfs_map_block(fs_info, READ, bytenr, &length, &multi, 0,
 			     NULL)) {
 		device = multi->stripes[0].dev;
@@ -367,7 +367,7 @@ struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 	if (!eb)
 		return ERR_PTR(-ENOMEM);
 
-	if (btrfs_buffer_uptodate(eb, parent_transid))
+	if (btrfs_buffer_uptodate(eb, parent_transid, 0))
 		return eb;
 
 	num_copies = btrfs_num_copies(fs_info, eb->start, eb->len);
@@ -478,7 +478,7 @@ int write_tree_block(struct btrfs_trans_handle *trans,
 		BUG();
 	}
 
-	if (trans && !btrfs_buffer_uptodate(eb, trans->transid))
+	if (trans && !btrfs_buffer_uptodate(eb, trans->transid, 0))
 		BUG();
 
 	btrfs_clear_header_flag(eb, BTRFS_HEADER_FLAG_CSUM_NEW);
@@ -2262,7 +2262,8 @@ void btrfs_mark_buffer_dirty(struct extent_buffer *eb)
 	set_extent_buffer_dirty(eb);
 }
 
-int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid)
+int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid,
+			  int atomic)
 {
 	int ret;
 
diff --git a/kernel-shared/disk-io.h b/kernel-shared/disk-io.h
index f349b3ef..ed7f9259 100644
--- a/kernel-shared/disk-io.h
+++ b/kernel-shared/disk-io.h
@@ -201,7 +201,8 @@ struct btrfs_root *btrfs_read_fs_root_no_cache(struct btrfs_fs_info *fs_info,
 					       struct btrfs_key *location);
 int btrfs_free_fs_root(struct btrfs_root *root);
 void btrfs_mark_buffer_dirty(struct extent_buffer *buf);
-int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid);
+int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid,
+			  int atomic);
 int btrfs_set_buffer_uptodate(struct extent_buffer *buf);
 int btrfs_csum_data(struct btrfs_fs_info *fs_info, u16 csum_type, const u8 *data,
 		    u8 *out, size_t len);
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 5c33fd53..062ff4a7 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -1893,7 +1893,7 @@ static int pin_down_bytes(struct btrfs_trans_handle *trans, u64 bytenr,
 	 * reuse anything from the tree log root because
 	 * it has tiny sub-transactions.
 	 */
-	if (btrfs_buffer_uptodate(buf, 0)) {
+	if (btrfs_buffer_uptodate(buf, 0, 0)) {
 		u64 header_owner = btrfs_header_owner(buf);
 		u64 header_transid = btrfs_header_generation(buf);
 		if (header_owner != BTRFS_TREE_LOG_OBJECTID &&
-- 
2.40.0

