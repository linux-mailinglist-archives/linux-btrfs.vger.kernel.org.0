Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDC14DA55
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2019 21:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfFTTiZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jun 2019 15:38:25 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:39138 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbfFTTiZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jun 2019 15:38:25 -0400
Received: by mail-yb1-f195.google.com with SMTP id i6so1674281ybq.6
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jun 2019 12:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=Q8S6UUNx70PPY6AbOEcmX+YJ6dNnd1YV2pFFNI9PY+M=;
        b=MWoLYTF+lgCjb4TxwGMzOAxkEg/CFOQ1O70ePsU35VM+yYQHbxj13lbfE5AUICeWyi
         U6AjeKzXfoURnlA0W12lHWShi9CUvYzy+DyOlPCFlSAKZFyoKD5FiIWb5vUAeyLMtBOx
         O3xgZlT8+4fIh5IgNBHzVPATZ9QbSWlvXwxnFkE6o45CiIdJU5PnjWZFKjaXzlSVuY8G
         0NiAZ9wVp94CnQynYqwScqa6yizPyFEmxGMXEtO3pkjI0PoeRbytSEVww7hLQgpTB3kj
         du8gtLSljTCu+SDl6ILgVR1EtaGcFCHquLon+WzGcEc3A8AmHWhM1iJWlwsFY8DyH710
         /lTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=Q8S6UUNx70PPY6AbOEcmX+YJ6dNnd1YV2pFFNI9PY+M=;
        b=ZUQdhk20IFPjZxgzUCSBjz8mP+Flr2p6/k9szkTNc7HVNzIVtiuggxxtNmbPsQDIcf
         aAAexJG3o4ozcVNWRd0K9zoH2xwrFWhQ4eVLgp//grroofBEpRcvNNd2hpVO9zUL7upZ
         KYwHSb7DUSGgB9rVOYay3nYl1cFyf3OS+SRA1vhOtd6dnrFjZ9RH03JbdoIjzGM4phWQ
         2SgVYA28htZQUOSWkmeQ81BmUJE/44U6dwlQh7iEBUaAO8FFzNpUuHRoJfgZFc2xna/x
         MzauUcxaWH6taxbYb/Y/MzUXXc8caxLMSVsi0k/qxkQbqPYtZ7cNCgNahEQh3GfgJGvh
         NQMw==
X-Gm-Message-State: APjAAAWC7vwbYaE3IhnWhbm9WTzqzZTGO5NUufsn7HJqHy7HznrGfGbQ
        Sf0MdGzXEmNhAy2wV/2Gv2wZYeQMaxamyA==
X-Google-Smtp-Source: APXvYqzBf0E0xUUX7GsAaxFVk6uJCl0GWRkIoZb8bZ9apY7O+wn2gjRSttAWAJRwB4aj2xQe4o3Rqg==
X-Received: by 2002:a25:2594:: with SMTP id l142mr22805865ybl.344.1561059504108;
        Thu, 20 Jun 2019 12:38:24 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id u3sm101273ywc.104.2019.06.20.12.38.23
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 12:38:23 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 09/25] btrfs: temporarily export fragment_free_space
Date:   Thu, 20 Jun 2019 15:37:51 -0400
Message-Id: <20190620193807.29311-10-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190620193807.29311-1-josef@toxicpanda.com>
References: <20190620193807.29311-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is used in caching and reading block groups, so export it while we
move these chunks independently.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.h | 1 +
 fs/btrfs/extent-tree.c | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 8cac9c5f1711..b249237ef175 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -151,6 +151,7 @@ btrfs_should_fragment_free_space(struct btrfs_block_group_cache *block_group)
 	       (btrfs_test_opt(fs_info, FRAGMENT_DATA) &&
 		block_group->flags &  BTRFS_BLOCK_GROUP_DATA);
 }
+void btrfs_fragment_free_space(struct btrfs_block_group_cache *block_group);
 #endif
 
 struct btrfs_block_group_cache *
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 9b5853e5dd14..1513cae23106 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -205,7 +205,7 @@ void btrfs_put_caching_control(struct btrfs_caching_control *ctl)
 }
 
 #ifdef CONFIG_BTRFS_DEBUG
-static void fragment_free_space(struct btrfs_block_group_cache *block_group)
+void btrfs_fragment_free_space(struct btrfs_block_group_cache *block_group)
 {
 	struct btrfs_fs_info *fs_info = block_group->fs_info;
 	u64 start = block_group->key.objectid;
@@ -442,7 +442,7 @@ static noinline void caching_thread(struct btrfs_work *work)
 		block_group->space_info->bytes_used += bytes_used >> 1;
 		spin_unlock(&block_group->lock);
 		spin_unlock(&block_group->space_info->lock);
-		fragment_free_space(block_group);
+		btrfs_fragment_free_space(block_group);
 	}
 #endif
 
@@ -549,7 +549,7 @@ int btrfs_cache_block_group(struct btrfs_block_group_cache *cache,
 			cache->space_info->bytes_used += bytes_used >> 1;
 			spin_unlock(&cache->lock);
 			spin_unlock(&cache->space_info->lock);
-			fragment_free_space(cache);
+			btrfs_fragment_free_space(cache);
 		}
 #endif
 		mutex_unlock(&caching_ctl->mutex);
@@ -8103,7 +8103,7 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 		u64 new_bytes_used = size - bytes_used;
 
 		bytes_used += new_bytes_used >> 1;
-		fragment_free_space(cache);
+		btrfs_fragment_free_space(cache);
 	}
 #endif
 	/*
-- 
2.14.3

