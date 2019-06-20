Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 157BB4DA58
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2019 21:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfFTTia (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jun 2019 15:38:30 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43815 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbfFTTi3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jun 2019 15:38:29 -0400
Received: by mail-yw1-f66.google.com with SMTP id t2so1656909ywe.10
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jun 2019 12:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=5ObubgDIl6spVlT+V1GbxyX1qGlHPSOK0P/+qq978SA=;
        b=0lqglXp8xp4mOG/APA4ojOMI9H1fE6yDjd/zMG6cI/AAsYDPZwRxvmvq5TAMtqOSg8
         MJffqI/8fyb1zs4408WKitJ0LC+9ViWcmZqncc1wMpiNcqVLqXHnhC0S9x7Tm+tnnWKB
         CdwUkqgb8dPcL6NOHtljil7scBW6c+j3wS/5GuWtgf6OeIn9QMjVmiA3Fo0LJr3z1thv
         g0f+DZDJE0jhCGWDuGSbe9hBuXpPeR2IC9Cej7ynEp/R9P6192VN0AgOOoND87QArGMi
         NGSSieLp+UnvgIUj+FVz+qAdrIDiGQT01+L2mMU5Xr6m7t9kO8ZhDZHbSV8bIHdaYgal
         QrSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=5ObubgDIl6spVlT+V1GbxyX1qGlHPSOK0P/+qq978SA=;
        b=gAUdMVkBQL9nnNco7WhJtRKZ/LfZfwNcCT22ZTbqZpkh4c1CBnjWqcO43PxY+QL0oz
         QsQ8ebyciqtkQ52ltBEdhdtkeebesOOKOzyTYRgoIiwxdEF+I97lT0ZVqCHlVFeM7Y9f
         4sF+shODl2nmuzl9iFldsoz4m37pFYUTI3wBI9tyPuwb26nzK8+LzymQyhdTAvGLX6oD
         RIc1uvnJEoQHZczZilEWF761dv7OPHPjz4f3WJElTioosXFmiA7w1FRqhCQrMhh2AYkZ
         67JVvqsx1fLSwt1aePfcABofPEqwFESaGyf0thMai+R2sh0WuS13cTb7CYdKhUQj9pKh
         kGzQ==
X-Gm-Message-State: APjAAAXtqXblv7ln3qafOnLPqnrPrHhlPC6IwowXam5HLVZycOlmwSag
        vwogz/S6O+W0LnOuEctySfU/e5uNIXx5pA==
X-Google-Smtp-Source: APXvYqz9tfweXXEEzN1+X2KOC1iCBaGZU7m6ZD+MbgOqBqyZZ9hkIlcjjR78gKByrUxXwqw/fTj3Eg==
X-Received: by 2002:a81:5f8a:: with SMTP id t132mr31475507ywb.381.1561059508853;
        Thu, 20 Jun 2019 12:38:28 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 204sm115437ywg.67.2019.06.20.12.38.28
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 12:38:28 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 12/25] btrfs: temporarily export inc_block_group_ro
Date:   Thu, 20 Jun 2019 15:37:54 -0400
Message-Id: <20190620193807.29311-13-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190620193807.29311-1-josef@toxicpanda.com>
References: <20190620193807.29311-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is used in a few logical parts of the block group code, temporarily
export it so we can move things in pieces.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.h |  2 ++
 fs/btrfs/extent-tree.c | 15 ++++++++-------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 058b55cd6d29..6a1644908556 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -188,4 +188,6 @@ btrfs_block_group_cache_done(struct btrfs_block_group_cache *cache)
 		cache->cached == BTRFS_CACHE_ERROR;
 }
 
+int __btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache,
+			       int force);
 #endif /* BTRFS_BLOCK_GROUP_H */
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index c5ffa3db9533..79ef07cdff6b 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6685,7 +6685,8 @@ static u64 update_block_group_flags(struct btrfs_fs_info *fs_info, u64 flags)
 	return flags;
 }
 
-static int inc_block_group_ro(struct btrfs_block_group_cache *cache, int force)
+int __btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache,
+			       int force)
 {
 	struct btrfs_space_info *sinfo = cache->space_info;
 	u64 num_bytes;
@@ -6790,14 +6791,14 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache)
 			goto out;
 	}
 
-	ret = inc_block_group_ro(cache, 0);
+	ret = __btrfs_inc_block_group_ro(cache, 0);
 	if (!ret)
 		goto out;
 	alloc_flags = get_alloc_profile(fs_info, cache->space_info->flags);
 	ret = btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
 	if (ret < 0)
 		goto out;
-	ret = inc_block_group_ro(cache, 0);
+	ret = __btrfs_inc_block_group_ro(cache, 0);
 out:
 	if (cache->flags & BTRFS_BLOCK_GROUP_SYSTEM) {
 		alloc_flags = update_block_group_flags(fs_info, cache->flags);
@@ -7524,7 +7525,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 
 		set_avail_alloc_bits(info, cache->flags);
 		if (btrfs_chunk_readonly(info, cache->key.objectid)) {
-			inc_block_group_ro(cache, 1);
+			__btrfs_inc_block_group_ro(cache, 1);
 		} else if (btrfs_block_group_used(&cache->item) == 0) {
 			ASSERT(list_empty(&cache->bg_list));
 			btrfs_mark_bg_unused(cache);
@@ -7546,11 +7547,11 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 		list_for_each_entry(cache,
 				&space_info->block_groups[BTRFS_RAID_RAID0],
 				list)
-			inc_block_group_ro(cache, 1);
+			__btrfs_inc_block_group_ro(cache, 1);
 		list_for_each_entry(cache,
 				&space_info->block_groups[BTRFS_RAID_SINGLE],
 				list)
-			inc_block_group_ro(cache, 1);
+			__btrfs_inc_block_group_ro(cache, 1);
 	}
 
 	btrfs_add_raid_kobjects(info);
@@ -8058,7 +8059,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		spin_unlock(&block_group->lock);
 
 		/* We don't want to force the issue, only flip if it's ok. */
-		ret = inc_block_group_ro(block_group, 0);
+		ret = __btrfs_inc_block_group_ro(block_group, 0);
 		up_write(&space_info->groups_sem);
 		if (ret < 0) {
 			ret = 0;
-- 
2.14.3

