Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDBB785A9E
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbjHWOdb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236474AbjHWOd2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:33:28 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8069110C8
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:21 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-591ba8bd094so40602087b3.3
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692801200; x=1693406000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ibct8f7AJuY8Z6fao388LFVCMbEZ3mOrYQLAIVnkyFY=;
        b=o7zpwxQdnPDcpXyJbsDeyqPca4j1AASQILSi/Wbfkrfh/vVF2xtw/XS9K/m3WoHHvy
         CdltY+d/FTjYVntDRle3dLwQd0xZ676zEgprkdLIZNBmgXUCpx086SYKTR00Zarcez3x
         eA0usQFvyNQ24BToZaA279nKEGDvsk7c4BQj5YQnwf+73dYMtVb5IToTYZCTcHQt8mzB
         6kxbw5vFDugPB+K6+BbURTewb7j+h+YaOVJn9evjsVsXjkVjo4cOOCfEYV5GcVtQGRqv
         xqYNOsUOy+agA2SAeEfZNxI8ZheMwZBpyijroNeSHS5g0fyhBRb6DLyeg364x80g7FXv
         a2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801200; x=1693406000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ibct8f7AJuY8Z6fao388LFVCMbEZ3mOrYQLAIVnkyFY=;
        b=hzYRTXg7zdi3gU3EfFoEPtoE8AQhqCxTmDHKG58iGH2sBEVT37PwCrVanUBUr6kbFM
         7DffdKNBvPRE8n29BV/rvIXsj6KF/No2/0uMONqQ1+nEHBn9Fd9NW/uFzKN0UoQu3Qjp
         3O4ICcHxX14mLSUnNZFzmCM68t72g5hoZWQ0mVELZNoW6funXWEGmlYm+GmCKDEx46jf
         ekKS+Eew7WsQUign7PVlHXp32hmzmClFMW0NW3hxwXs4G3un7UvBup1e8fD+FYhjLQv6
         rXtIu+73UVFYLkrieqhgDCf77ZLVG3dVhZ73AVN3YBEAPYkp1BN3jg2PBN8w0A8CYBDZ
         81oA==
X-Gm-Message-State: AOJu0YyB9XG1MpOkqXPWFwZW5Qel37oar7XVuI9qqS6mRDRiIWSxulsu
        2txLoQ26dNPlmMx4zAwqaQLAAxIqJxD/YZbw/Kw=
X-Google-Smtp-Source: AGHT+IE5atLrZAAaTal2hV9U2ghLgggPGftRxk4oc4/Q0Fan0KjEazOA1cS39xz6nmjxCYcL1QzXCg==
X-Received: by 2002:a81:6cd5:0:b0:54f:ba89:225d with SMTP id h204-20020a816cd5000000b0054fba89225dmr11909804ywc.19.1692801200592;
        Wed, 23 Aug 2023 07:33:20 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id a124-20020a818a82000000b005869ca8da8esm3325366ywg.146.2023.08.23.07.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:33:20 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 10/38] btrfs-progs: update btrfs_truncate_item to match the kernel definition
Date:   Wed, 23 Aug 2023 10:32:36 -0400
Message-ID: <bf51280d97b9108ff88b06d2d7acfeb15a2f10ff.1692800904.git.josef@toxicpanda.com>
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
index 2f96d701..b5d3d12e 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -2573,9 +2573,8 @@ split:
 	return ret;
 }
 
-int btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
+void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 {
-	int ret = 0;
 	int slot;
 	struct extent_buffer *leaf;
 	u32 nritems;
@@ -2590,7 +2589,7 @@ int btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
 
 	old_size = btrfs_item_size(leaf, slot);
 	if (old_size == new_size)
-		return 0;
+		return;
 
 	nritems = btrfs_header_nritems(leaf);
 	data_end = leaf_data_end(leaf);
@@ -2656,12 +2655,10 @@ int btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end)
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
index bf5dde14..81d71d36 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -970,7 +970,7 @@ int btrfs_create_root(struct btrfs_trans_handle *trans,
 		      struct btrfs_fs_info *fs_info, u64 objectid);
 int btrfs_extend_item(struct btrfs_root *root, struct btrfs_path *path,
 		u32 data_size);
-int btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end);
+void btrfs_truncate_item(struct btrfs_path *path, u32 new_size, int from_end);
 int btrfs_split_item(struct btrfs_trans_handle *trans,
 		     struct btrfs_root *root,
 		     struct btrfs_path *path,
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index f23c28af..001cffd1 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -1128,7 +1128,6 @@ static int update_inline_extent_backref(struct btrfs_trans_handle *trans,
 	u32 item_size;
 	int size;
 	int type;
-	int ret;
 	u64 refs;
 
 	leaf = path->nodes[0];
@@ -1168,8 +1167,7 @@ static int update_inline_extent_backref(struct btrfs_trans_handle *trans,
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
index 30a89094..e23e679e 100644
--- a/kernel-shared/file-item.c
+++ b/kernel-shared/file-item.c
@@ -346,7 +346,6 @@ static noinline int truncate_one_csum(struct btrfs_root *root,
 	u64 csum_end;
 	u64 end_byte = bytenr + len;
 	u32 blocksize = root->fs_info->sectorsize;
-	int ret;
 
 	leaf = path->nodes[0];
 	csum_end = btrfs_item_size(leaf, path->slots[0]) / csum_size;
@@ -362,8 +361,7 @@ static noinline int truncate_one_csum(struct btrfs_root *root,
 		 */
 		u32 new_size = (bytenr - key->offset) / blocksize;
 		new_size *= csum_size;
-		ret = btrfs_truncate_item(path, new_size, 1);
-		BUG_ON(ret);
+		btrfs_truncate_item(path, new_size, 1);
 	} else if (key->offset >= bytenr && csum_end > end_byte &&
 		   end_byte > key->offset) {
 		/*
@@ -375,8 +373,7 @@ static noinline int truncate_one_csum(struct btrfs_root *root,
 		u32 new_size = (csum_end - end_byte) / blocksize;
 		new_size *= csum_size;
 
-		ret = btrfs_truncate_item(path, new_size, 0);
-		BUG_ON(ret);
+		btrfs_truncate_item(path, new_size, 0);
 
 		key->offset = end_byte;
 		btrfs_set_item_key_safe(root->fs_info, path, key);
-- 
2.41.0

