Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E31E4C048D
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 23:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbiBVW0y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Feb 2022 17:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiBVW0y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Feb 2022 17:26:54 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BF3B10BC
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:26:28 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id f21so1810461qke.13
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Feb 2022 14:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=eebjVxdqAOalvSrcPJ6qj94x200V0G2iIgEVMzI3ork=;
        b=Pa2k/vL/aIk+dx1OkHxXIG3oTttVUotQw0oi+B1pzSWamNrq/GtOe7XgWziaWp6fva
         N0f7AU5XH4qShys6jpG+Pbu0UBsL7mQhXYmYQhfIe1K9+G1Gv0iaPwu9Dm3pGsw4rsJx
         r3P3IUYTs3crdN6tMsgM6DsLtOzGc7DZ4clO6CfHLdxgPtGdFx5dLCl4MidGNb/Qpugu
         2+NuhUKkRz+mQ7lgZ5yyEx93ojhg8qg8SDP9v5g1eP8O2BBSX5WxmK7eRSw/e2oMs9HP
         KDhgwvJoEVE0xHWAb3L5DV70YcV59x50OIdaasgHr7lOhfQ+mOd7J2TKEFO0bUDu6lJP
         bl8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eebjVxdqAOalvSrcPJ6qj94x200V0G2iIgEVMzI3ork=;
        b=VO41Ptnr5UXXnKp+g8AxV9OMw77I6VVxD+nZAZRRNiBcCnMlMIAGxQ3jShMeDqt+WY
         eG6d4+X83CSee1erfnn41Qs0MDJ8iF9O5uE+AQ4UPxe9/5nkUGXJ8RDIEuj/7wn35S6h
         MFgapDkRq3EGPN5OGbCiPGatR6vJtuhxGqwOYYGgOqOH/GXiRw7l+LoiP/CdSPwWJH3J
         62CGPW2uXP4mbJhhlKFf6xEe+zb5K+kH3fqwi1geXIi8EY+3IgjHCIfgN8EsNRyoJMJ0
         9ljmweGfAOeVxtyDSKIOuczEF3ukny+idwBz/gwitFuG8fktfXIB0RrvF8+T+d8hgMki
         Zljg==
X-Gm-Message-State: AOAM5313YSbS7RtbLfiiI6V7kKboKuEdhQbLG/wrkP5rsR51klnBhkIt
        4f2n54ldGTWpWjGHWIUCJgG7XYpNUuCeHPcj
X-Google-Smtp-Source: ABdhPJzMUETcopHJd8GzJ09mE9DI802AtCPWi8oAPU7A03DaCl0RrMApVKRJXfRhsSjs0Qk7vpMHXw==
X-Received: by 2002:a37:a0c6:0:b0:60b:54ea:29dc with SMTP id j189-20020a37a0c6000000b0060b54ea29dcmr16691756qke.354.1645568787201;
        Tue, 22 Feb 2022 14:26:27 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k5sm554291qkk.82.2022.02.22.14.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 14:26:26 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 02/13] btrfs-progs: store LEAF_DATA_SIZE in the mkfs_config
Date:   Tue, 22 Feb 2022 17:26:12 -0500
Message-Id: <3dfc516330a61f54ec9dbc2b59ad38d96992e59a.1645568701.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1645568701.git.josef@toxicpanda.com>
References: <cover.1645568701.git.josef@toxicpanda.com>
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

We use __BTRFS_LEAF_DATA_SIZE() in a few places for mkfs.  With extent
tree v2 we'll be increasing the size of btrfs_header, so it'll be kind
of annoying to add flags to all callers of __BTRFS_LEAF_DATA_SIZE, so
simply calculate it once and put it in the mkfs_config and use that.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mkfs/common.c | 9 ++++-----
 mkfs/common.h | 1 +
 mkfs/main.c   | 1 +
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index 9608d27f..aee4b9fb 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -93,7 +93,7 @@ static int btrfs_create_tree_root(int fd, struct btrfs_mkfs_config *cfg,
 
 	btrfs_set_disk_key_type(&disk_key, BTRFS_ROOT_ITEM_KEY);
 	btrfs_set_disk_key_offset(&disk_key, 0);
-	itemoff = __BTRFS_LEAF_DATA_SIZE(cfg->nodesize) - sizeof(root_item);
+	itemoff = cfg->leaf_data_size - sizeof(root_item);
 
 	for (i = 0; i < blocks_nr; i++) {
 		blk = blocks[i];
@@ -148,7 +148,7 @@ static int create_free_space_tree(int fd, struct btrfs_mkfs_config *cfg,
 {
 	struct btrfs_free_space_info *info;
 	struct btrfs_disk_key disk_key;
-	int itemoff = __BTRFS_LEAF_DATA_SIZE(cfg->nodesize);
+	int itemoff = cfg->leaf_data_size;
 	int nritems = 0;
 	int ret;
 
@@ -427,7 +427,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 		cfg->nodesize - sizeof(struct btrfs_header));
 	nritems = 0;
 	item_size = sizeof(*dev_item);
-	itemoff = __BTRFS_LEAF_DATA_SIZE(cfg->nodesize) - item_size;
+	itemoff = cfg->leaf_data_size - item_size;
 
 	/* first device 1 (there is no device 0) */
 	btrfs_set_disk_key_objectid(&disk_key, BTRFS_DEV_ITEMS_OBJECTID);
@@ -515,8 +515,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	memset(buf->data + sizeof(struct btrfs_header), 0,
 		cfg->nodesize - sizeof(struct btrfs_header));
 	nritems = 0;
-	itemoff = __BTRFS_LEAF_DATA_SIZE(cfg->nodesize) -
-		sizeof(struct btrfs_dev_extent);
+	itemoff = cfg->leaf_data_size - sizeof(struct btrfs_dev_extent);
 
 	btrfs_set_disk_key_objectid(&disk_key, 1);
 	btrfs_set_disk_key_offset(&disk_key, system_group_offset);
diff --git a/mkfs/common.h b/mkfs/common.h
index 66c9d9d0..428cd366 100644
--- a/mkfs/common.h
+++ b/mkfs/common.h
@@ -76,6 +76,7 @@ struct btrfs_mkfs_config {
 	u32 nodesize;
 	u32 sectorsize;
 	u32 stripesize;
+	u32 leaf_data_size;
 	/* Bitfield of incompat features, BTRFS_FEATURE_INCOMPAT_* */
 	u64 features;
 	/* Bitfield of BTRFS_RUNTIME_FEATURE_* */
diff --git a/mkfs/main.c b/mkfs/main.c
index f9e8be74..3dd06979 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1413,6 +1413,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	mkfs_cfg.features = features;
 	mkfs_cfg.runtime_features = runtime_features;
 	mkfs_cfg.csum_type = csum_type;
+	mkfs_cfg.leaf_data_size = __BTRFS_LEAF_DATA_SIZE(nodesize);
 	if (zoned)
 		mkfs_cfg.zone_size = zone_size(file);
 	else
-- 
2.26.3

