Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6DD347627A
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbhLOUAf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbhLOUAW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:00:22 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B729EC06173E
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:00:21 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id kl7so4462967qvb.3
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=R0Yqbdx52zzymv5qMCjmgCl6pa/p1yR9G70vfd4nzVk=;
        b=ZVcwaQBWjNpYc+Z2npZbiffyL44afMYtVGOS/3vhGtNgIYYacyod3NdZzdhpYfhqo7
         lDOBbj0FFP0+aWEDBKhqKz+B2gCB4pORdIkjMiy7MeNjmPKeeTaIgfKlhJXWUy+TRZ85
         vjr1soO4G1HdHx5kpBL9GNEtd/JJ3sv4u9+lcSfEE+RU/uMDsmWKheLt/Jx7zGP37Aaw
         5t2NIw++xwOYlXYvm3Z99h+ezUrVoYj59Z9fH/dD2G2dl6f6maz+OgwlSZoWWBWjXj+3
         0TvWVyEKAfGZsv0qdMK9uxSD+GZyr7MQ+vRMxV8KXa2R9sjdKK3g77tYHk5lTAIgOmJp
         HVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R0Yqbdx52zzymv5qMCjmgCl6pa/p1yR9G70vfd4nzVk=;
        b=aKImx+uTShxmtStmpULtILCIGyfv+3pmHXtKMeVof/AI6ZkTfghQZdj1RnaUq8sn7P
         CD+tfYAqxHZICbrCq4mds3AOh1DMt22i15wRkxyUg8T916biZhdgXckBxfh//vo1VJWB
         LYOBWApkbei922/ySBY3I+42nat94M7zjgTIt5NN1IUedtqDrXqnMK9/hm7kNULuoBtk
         SRWwVYV9NpsjtyYYN8JGvyAgmdiAGbBB/Pq4OOb5dtSrcEQM+gyp5BwjnyIpkkworCp9
         cpAR9TPrGZYpeCKF+it59GrGzgjQFtwbAaSVGAM2ygGFRByCrmhfXrPHGxGJcm+u154z
         Kt6w==
X-Gm-Message-State: AOAM530tBLEM1vm11JJLP3BuuC1j4OtG3IxNzt+e+o5M9kGoBlGJ9Vlu
        qhFqcWF+FS6e1zQQyO9QhV4ikw3SLjW89w==
X-Google-Smtp-Source: ABdhPJwHnPK9+Ijmkb/DYTT2VRzARzezBR8u012ps0v2YuFv2wUzvnkIRr9po35lHVoMubtL/OCehA==
X-Received: by 2002:a05:6214:2341:: with SMTP id hu1mr13126875qvb.78.1639598420595;
        Wed, 15 Dec 2021 12:00:20 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u10sm2268686qtx.3.2021.12.15.12.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:00:20 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 20/22] btrfs-progs: mkfs: set chunk_item_objectid properly for extent tree v2
Date:   Wed, 15 Dec 2021 14:59:46 -0500
Message-Id: <db59a4fddb5b87786deadf92db5c384818c6600d.1639598278.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639598278.git.josef@toxicpanda.com>
References: <cover.1639598278.git.josef@toxicpanda.com>
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

