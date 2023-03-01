Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7D46A7600
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Mar 2023 22:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjCAVO5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Mar 2023 16:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjCAVOv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Mar 2023 16:14:51 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A836148E19
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Mar 2023 13:14:50 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id l18so14865149qtp.1
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Mar 2023 13:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112; t=1677705289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i3jERBXIZtx0+5ilMG0Cro9ewl9XbGgWQPBUuQ4eiLw=;
        b=eKLZjQ45viDOfBG4YtptLjua58wlKKi5B+Paa8/GMhn/uUxIVH54zGUivkZqbZYqek
         fD7M6A10NzBIalZwvBudCImQzKn7yQ0mp5/+mFcvPgpPcYSVlSR316rA2grS6eSwkGGr
         oKk0IvQzZzyoMSwHzZ+CQFEaZsPlqtzphoC8fl8UoCUuDbpMC2cxpPWUZQHxrYwTSe0s
         G0lR8pgD11xmpLQzndcBXERW3wCcwkJZ2xDcIaRXKyNl7NSd0Xdf56CSuk+5lOT57lKW
         5oSG9LBHf5NAo7mI5U5F2L5aKqVTllKnr/QK2V1f4mCyCoOOuJYBzrYRX0JBP//Gw+F8
         pylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677705289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3jERBXIZtx0+5ilMG0Cro9ewl9XbGgWQPBUuQ4eiLw=;
        b=yIOgTNIGvatp/EUynRaYDotG69vOIg36+5+9VQ2h2w+neXLgs3EFKYUoSrpp4wlUSp
         7mUr8jlyy9d4knKxU6SDO7u6OykRA9ktIiUsLHls38lsPyyjeG0uxWE2OGIHeTRCJJ0y
         tAvoGP0bbVwgBuEjOmK9nPg0Z9PJnkJn42fgshLYdowczomeyo8MfWB9AwLDWgoyLFs3
         VP/UamY6AXfY4Oonoo6QOo7/+akjg+iPdFB7dJTvCYl7PviL02bewhXOf2KISUPR9jCe
         kX6UkEZUsnteqpEhKhoYFayA+ulFRnz1sURtFsrqd6VxTQHtOaYHnI+Gtq7yrcJ6vBS+
         Sl6Q==
X-Gm-Message-State: AO0yUKWudtAVFepXFNuGjCTyg1YXI8rvLP0DBgbg8p37PPI2kqk38UIE
        uRNUw2HL2COovi8geMsT9wRGhag8Ac6wCarBDZg=
X-Google-Smtp-Source: AK7set/84E7w1cQA8ut/KbmCZxuic/biZ8LiUBMzsXj0teMxgK/i497Ge0daYJTpWrhtliuAzPvwMg==
X-Received: by 2002:ac8:7f4e:0:b0:3bf:d71e:5af4 with SMTP id g14-20020ac87f4e000000b003bfd71e5af4mr13988296qtk.26.1677705289375;
        Wed, 01 Mar 2023 13:14:49 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id j129-20020a37b987000000b0074233b15a72sm9549949qkf.116.2023.03.01.13.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 13:14:48 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/3] btrfs: clean up space_info usage in  btrfs_update_block_group
Date:   Wed,  1 Mar 2023 16:14:43 -0500
Message-Id: <f7a7a4beb5d9f249204fbca72a04b4cd78274c18.1677705092.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1677705092.git.josef@toxicpanda.com>
References: <cover.1677705092.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We do

cache->space_info->counter += num_bytes;

Everywhere in here.  This is makes the lines longer than they need to
be, and will be especially noticeable when I add the active tracking in,
so add a temp variable for the space_info so this is cleaner.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5b10401d803b..3eff0b35e139 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3474,6 +3474,7 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 	spin_unlock(&info->delalloc_root_lock);
 
 	while (total) {
+		struct btrfs_space_info *space_info;
 		bool reclaim = false;
 
 		cache = btrfs_lookup_block_group(info, bytenr);
@@ -3481,6 +3482,7 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 			ret = -ENOENT;
 			break;
 		}
+		space_info = cache->space_info;
 		factor = btrfs_bg_type_to_factor(cache->flags);
 
 		/*
@@ -3495,7 +3497,7 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 		byte_in_group = bytenr - cache->start;
 		WARN_ON(byte_in_group > cache->length);
 
-		spin_lock(&cache->space_info->lock);
+		spin_lock(&space_info->lock);
 		spin_lock(&cache->lock);
 
 		if (btrfs_test_opt(info, SPACE_CACHE) &&
@@ -3508,24 +3510,24 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 			old_val += num_bytes;
 			cache->used = old_val;
 			cache->reserved -= num_bytes;
-			cache->space_info->bytes_reserved -= num_bytes;
-			cache->space_info->bytes_used += num_bytes;
-			cache->space_info->disk_used += num_bytes * factor;
+			space_info->bytes_reserved -= num_bytes;
+			space_info->bytes_used += num_bytes;
+			space_info->disk_used += num_bytes * factor;
 			spin_unlock(&cache->lock);
-			spin_unlock(&cache->space_info->lock);
+			spin_unlock(&space_info->lock);
 		} else {
 			old_val -= num_bytes;
 			cache->used = old_val;
 			cache->pinned += num_bytes;
-			btrfs_space_info_update_bytes_pinned(info,
-					cache->space_info, num_bytes);
-			cache->space_info->bytes_used -= num_bytes;
-			cache->space_info->disk_used -= num_bytes * factor;
+			btrfs_space_info_update_bytes_pinned(info, space_info,
+							     num_bytes);
+			space_info->bytes_used -= num_bytes;
+			space_info->disk_used -= num_bytes * factor;
 
 			reclaim = should_reclaim_block_group(cache, num_bytes);
 
 			spin_unlock(&cache->lock);
-			spin_unlock(&cache->space_info->lock);
+			spin_unlock(&space_info->lock);
 
 			set_extent_dirty(&trans->transaction->pinned_extents,
 					 bytenr, bytenr + num_bytes - 1,
-- 
2.26.3

