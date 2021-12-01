Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93AC946552D
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 19:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352277AbhLASVR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 13:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352248AbhLASVH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 13:21:07 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD67C061574
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Dec 2021 10:17:46 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id s9so22505161qvk.12
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Dec 2021 10:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=R0Yqbdx52zzymv5qMCjmgCl6pa/p1yR9G70vfd4nzVk=;
        b=OM+cqFWb4lf/oSfvJaTw7c5TEBn/pWY9HWyW6a1ABtjjPTd+pINnx+0sCwPeWkwEZ5
         txkKgwnJZPAXpEnZ3VfNoap8K7yeYVqulliGx9M4L1DerO1OcGokusvXATCo82GnQh+h
         kb9EQznT5U4uim2cD9TmndwAoeKis6egD28ikVd+CLibhvJJbBTxIrh32Oszz2vexuZ3
         GF9eBHupiJJx1DPKbsS2l7UqjeyFOL/a7rPP9ZsIUvapUb4pmrEFy+V8BAO9T6M1rC6T
         ZnoYzV/YDlijZcwIu033lC/rduesU2JHgzw4X4dppR6FBd1pRj0BwSfwTPl8Qyv75w7x
         GTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R0Yqbdx52zzymv5qMCjmgCl6pa/p1yR9G70vfd4nzVk=;
        b=F5XhgktPTqP9L/iY5VySspcEhQMy8+6ga6y3+Irm7R0WAKbfdJopUBLhuEGMRNh31p
         r8B+uBa4tC/5aOw2D4VeUuQwe01mLVE8i1ja4Nc2FJH9E1miaUoAyLO4X9cNKMFlHE8F
         2N0SUtrFlRBLkAf+qVD3ybXjTa4A1w8NOR6CHNmWWi38KwEFQ7ouC0SkrzDGdiZCjRtT
         tAswdjAkvZ64Q78f+2U2gayUyE/jC510Tez1GFkBIKsQp68FfXn/qXrmIheOXsm2/PQD
         a+nL6m3r7YQsdLMaEpPCC8vezRgvvcLO7t6uWqxUaf0tdwIgsueZvC8xzp/qGiz5ZUG/
         /m2A==
X-Gm-Message-State: AOAM530iyLupnyNrieJsiCgIOB47e3rgnMKf/wsiZQEudkTo9PgpL3dl
        QSkHm6vAmLSayotCoF7p6btBYDR425/Lkg==
X-Google-Smtp-Source: ABdhPJyQ/BOKn9UJ4tTDJf8Lv5feVNoFaYP9jEX9mapeMavDjl/gpePwyfwO/K+qL66X6zPSFfQ4yA==
X-Received: by 2002:a05:6214:2301:: with SMTP id gc1mr7977485qvb.107.1638382665509;
        Wed, 01 Dec 2021 10:17:45 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o17sm276093qtv.30.2021.12.01.10.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:17:45 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 20/22] btrfs-progs: mkfs: set chunk_item_objectid properly for extent tree v2
Date:   Wed,  1 Dec 2021 13:17:14 -0500
Message-Id: <7c4ad2510de6f6df0efa16278d762ba7d8d9ffc8.1638382588.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638382588.git.josef@toxicpanda.com>
References: <cover.1638382588.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Our initial block group will use global root id 0 with extent tree v2,
so adjust the helper to take the chunk_objectid as an argument, as we'll
set this to 0 for extent tree v2 and then
BTRFS_FIRST_CHUNK_TREE_OBJECTID for extent tree v1.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mkfs/common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index d91b1e6f..a4412a1f 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -192,7 +192,7 @@ static int create_free_space_tree(int fd, struct btrfs_mkfs_config *cfg,
 
 static void write_block_group_item(struct extent_buffer *buf, u32 nr,
 				   u64 objectid, u64 offset, u64 used,
-				   u32 itemoff)
+				   u64 chunk_objectid, u32 itemoff)
 {
 	struct btrfs_block_group_item *bg_item;
 	struct btrfs_disk_key disk_key;
@@ -207,8 +207,7 @@ static void write_block_group_item(struct extent_buffer *buf, u32 nr,
 	bg_item = btrfs_item_ptr(buf, nr, struct btrfs_block_group_item);
 	btrfs_set_block_group_used(buf, bg_item, used);
 	btrfs_set_block_group_flags(buf, bg_item, BTRFS_BLOCK_GROUP_SYSTEM);
-	btrfs_set_block_group_chunk_objectid(buf, bg_item,
-					     BTRFS_FIRST_CHUNK_TREE_OBJECTID);
+	btrfs_set_block_group_chunk_objectid(buf, bg_item, chunk_objectid);
 }
 
 static int create_block_group_tree(int fd, struct btrfs_mkfs_config *cfg,
@@ -219,7 +218,7 @@ static int create_block_group_tree(int fd, struct btrfs_mkfs_config *cfg,
 
 	memset(buf->data + sizeof(struct btrfs_header), 0,
 		cfg->nodesize - sizeof(struct btrfs_header));
-	write_block_group_item(buf, 0, bg_offset, bg_size, bg_used,
+	write_block_group_item(buf, 0, bg_offset, bg_size, bg_used, 0,
 			       __BTRFS_LEAF_DATA_SIZE(cfg->nodesize) -
 			       sizeof(struct btrfs_block_group_item));
 	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_BLOCK_GROUP_TREE]);
@@ -405,6 +404,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 			write_block_group_item(buf, nritems,
 					       system_group_offset,
 					       system_group_size, total_used,
+					       BTRFS_FIRST_CHUNK_TREE_OBJECTID,
 					       itemoff);
 			add_block_group = false;
 			nritems++;
-- 
2.26.3

