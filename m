Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6B744CA6A
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbhKJUSZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbhKJUST (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:18:19 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DC9C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:31 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id j17so3298380qtx.2
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/FJNx6VxGzdc1ZIFGXKzziSVuIBNTd7ofz7OLEjtAkM=;
        b=WH2HqM4BlwNmXWA8IesMWoMzLnVg3W/U6jft4pNgzhRSXQnqOfh5RMAV2qq8P1+0qx
         I3ovcC0AybEgkMdwKA/gcD/pkjoOcQuAgWbQ9EVpF14xi05XxF7ikGy1TywvZk2W2J+T
         2I784LqJpRRbeIca274LkXvhMxf7Z7Y1A8qzQ1wZWqbyMSCc3jFZaiUIcM701t3E++Hk
         vZq91WSwT/5mgt08uDvg9BO8/w2HaFJxvfZw6KYozlEtbaPzBa3YzokCFm9WVb0H7dxY
         9zntkICazMHUNilqJUo2qXubvEhUn9Z81T4fjzG9IrBkpuUfHYLsCY3zKPmFtu0f0Fdy
         1Fgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/FJNx6VxGzdc1ZIFGXKzziSVuIBNTd7ofz7OLEjtAkM=;
        b=CHWjvn7lX+cFbTlT+4/KFfYq0V3Rw+eOPwuOUXzJlyl5TazC7qT7q2Up++s61wg86G
         S4dGPz1k43JzN/3+03M87eJQAF+lz9azi3SWwMh8AOZ7wal4n/RmMAiUKhOqWQ+B5YQj
         nFNNcgsBVs5Kmttt1YDeb6iCVoWzKL/fCmz/C5bZXDj+KqismGjucoD5RUO4IwpKsiaM
         oEDWkdhFV4KnR0xH6XU36O9SPysObwcamXLAQghttj06/w7t3EFuKc3fjTiloPfwnZof
         YAtO1ek4+MqAyoydHgLujHK28+YLrLycx/2TeMeAQPl7aB9ze/O8NOwrhZA2FiuU5z6L
         dGqA==
X-Gm-Message-State: AOAM531Ytf8eyUvHEfJQWM48lfOc0vp7CvOo5f1+1YAZeDivcTYT2vWQ
        LkPtEWUbbvuVL7cY1Fq+NXDKivUgAnSqDg==
X-Google-Smtp-Source: ABdhPJwv2yi9GBOmD6KQrKG/kUogsP8pDXYcTQx7Rw9cHtXf3zdjmpvn4ByqPCyHYPWYwMaT0xlZIg==
X-Received: by 2002:ac8:5e10:: with SMTP id h16mr1857141qtx.261.1636575330847;
        Wed, 10 Nov 2021 12:15:30 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h11sm462831qkp.46.2021.11.10.12.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:15:30 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 28/30] btrfs-progs: mkfs: set chunk_item_objectid properly for extent tree v2
Date:   Wed, 10 Nov 2021 15:14:40 -0500
Message-Id: <5615450f3dc9e4847a51205eb57b3fbf9821c036.1636575147.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636575146.git.josef@toxicpanda.com>
References: <cover.1636575146.git.josef@toxicpanda.com>
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
index 71589c0d..479b1150 100644
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
@@ -404,6 +403,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 			write_block_group_item(buf, nritems,
 					       system_group_offset,
 					       system_group_size, total_used,
+					       BTRFS_FIRST_CHUNK_TREE_OBJECTID,
 					       itemoff);
 			add_block_group = false;
 			nritems++;
-- 
2.26.3

