Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 517F24469E4
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbhKEUoD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbhKEUn5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:43:57 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74FDC061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:41:17 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id v4so8306259qtw.8
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/FJNx6VxGzdc1ZIFGXKzziSVuIBNTd7ofz7OLEjtAkM=;
        b=NSL7sFouUoz3EnbD1F+IjpkB42ksgwQL364gwjyb50W9TXGB7aLVmYQ62jX+sByYRI
         G+7In+m2IFZwaiROIX9atM0n0dgypNJRp150XGDZOfFSSjdqj5O60UThnDm4QpRMxoWh
         4k3+wQfpHQWZyucp1yJsEiRN/UH/N547lA7d3xaEzZZ4E5/PbWfqm/+jQOCKLwsoblv6
         xUY/SM+kGTOdvNnI1pS0I7jl0Z1CF5EN4A0U4FgQSvTU6VSAq0+K4302++DaepgtE3yS
         u4RFKBiwvQ+drvyreN7zSmaJJfx3wlRfcJBWGdxEQ9+13g5BBsy6gD1NXJloM4proUMS
         9Qsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/FJNx6VxGzdc1ZIFGXKzziSVuIBNTd7ofz7OLEjtAkM=;
        b=oeigeDjwC0RDYEmKihr+LWvyRs39bE44W3nLj7i85L8Ru+uhcbjsi3Bm5uVtv0Q3Db
         jY+bFbnYLWIpRfySCsge1yEjMHcQgbeH0Wf9uqP73G+pJFb1MRLB8nApJPtFzS98J9qG
         lsnoo8urRfCZTL/aKCmi8VNNYavxW7Ko9zfVkled9E/ElG1s25uN3m24S1gBfW4v3xmb
         sc7X1S8lt6LzOHvwdt7mtvDBb/8qAW35e0+HKFI+Q2QfswMStPRX390P3eHahRwLtjt2
         dmWIVe8MlPv8wqwja8E/9OjsJVzfEeNjX4x2z8FDRHwz9RxNA373vibM0rDrTFxU7Z59
         r8CA==
X-Gm-Message-State: AOAM5310feQ/dES6yebMwSDB4QsNDNdHabP1DQzTDG2N8/c4MwvN8zEx
        3uuLEzbEIvp3bwQVCJCWKIjhQeuOYOv+mA==
X-Google-Smtp-Source: ABdhPJwQNZjghGGyMhEkRQw94bFnV2h9cfs6/7mpnKYd7TtQV7mBZ0FimDR6PW8F89L51ImPPgPenQ==
X-Received: by 2002:ac8:5d49:: with SMTP id g9mr43735437qtx.380.1636144876753;
        Fri, 05 Nov 2021 13:41:16 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y7sm6592113qtj.39.2021.11.05.13.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:41:16 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 20/22] btrfs-progs: mkfs: set chunk_item_objectid properly for extent tree v2
Date:   Fri,  5 Nov 2021 16:40:46 -0400
Message-Id: <f05cc4c7f922fc25d53dc63264519841cc72eddd.1636144276.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144275.git.josef@toxicpanda.com>
References: <cover.1636144275.git.josef@toxicpanda.com>
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

