Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C54899F7D
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2019 21:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388839AbfHVTLK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Aug 2019 15:11:10 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:40268 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387990AbfHVTLK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Aug 2019 15:11:10 -0400
Received: by mail-yb1-f194.google.com with SMTP id g7so2952031ybd.7
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2019 12:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=v1pSaaDbSqj2cZfBASQp5Ma0F6NJ1GGvihHWqIN/iu4=;
        b=YqzJX+AmKD4sn2ylNCPAeoBSxvk7j4VzzHPA7OeUL2VdS+jMt7M3wO7ULMpx/R5Pxm
         TO65UNh2d0JYK88gbSByi4lFm9pl71JIcSiGHW2FB0cNj1GDXvYtRGBJvZBTsVctDH2i
         Arg2a+Di8XUnYL1i7WMu2CMOI/mya3XHUBIxR2aK9KJPpT9EWcnjPuPGYuwxcysDCV/a
         ziO9WjBKhFi4Rqn5fgQK43kMnFOUQ8sbuYE5sTng9LJNBrbecM6IwuBoXcxTZrgD3nuA
         4sN6Ygn15rEMd8OxzL8QTWDYCgryt88l9qbcJXSQ5ND4H1DB/usiP09nB9qMZifuYfHS
         bjuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v1pSaaDbSqj2cZfBASQp5Ma0F6NJ1GGvihHWqIN/iu4=;
        b=EY1VT6LZz1IRxYIr9o8wUZuV+kioDp4Pq4c5RFuq6HxwQunGv7aIunHHOdjER3Q7MH
         KlEgDFZZZ0TBIIge6DQ81oLuU9aI0MAM7uXSkK3h6eTGgqQHfhERg57c/MdpZJjNkiDy
         9kViGyfem9BoYCMk+LGsPBFLk8M0iwMrn0e2WRO5veSRdgiwHM6BbjN9UnV0nmeChDSn
         UJ6q+6TzzWyFjAxG64u7c7ke+U9eQJfVDhgQcuOsYicVuS79g52BLkzuaAUdITFtAyk4
         csNliw5zG4B6IIeOOeAmyF0tXnnzK1bTpkUK6RKEzBUojb2OpUC3XF0mXBIyKIoIQAkl
         tG+Q==
X-Gm-Message-State: APjAAAUcEcuVKOeyo+7Qot90vC3PGuf1fiLpKseodaurRBetVHEBUCKw
        xcNkmPeam2YzVwsaO6WSC+oMVQDOuFM4pQ==
X-Google-Smtp-Source: APXvYqy699hgn8kL+K/KLCvJ7LQQvuIJhiiM/5oWN//jaHVgWbLmBMSHZDzT2NLRNsdXzw4iVtUibg==
X-Received: by 2002:a25:aa23:: with SMTP id s32mr377645ybi.198.1566501069209;
        Thu, 22 Aug 2019 12:11:09 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d191sm267851ywh.12.2019.08.22.12.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 12:11:08 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 2/9] btrfs: roll tracepoint into btrfs_space_info_update helper
Date:   Thu, 22 Aug 2019 15:10:55 -0400
Message-Id: <20190822191102.13732-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822191102.13732-1-josef@toxicpanda.com>
References: <20190822191102.13732-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We duplicate this tracepoint everywhere we call these helpers, so update
the helper to have the tracepoint as well.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c    |  3 ---
 fs/btrfs/block-rsv.c      |  5 -----
 fs/btrfs/delalloc-space.c |  4 ----
 fs/btrfs/extent-tree.c    |  9 ---------
 fs/btrfs/space-info.c     | 10 ----------
 fs/btrfs/space-info.h     | 10 +++++++---
 6 files changed, 7 insertions(+), 34 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 262e62ef52a5..9867c5d98650 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2696,9 +2696,6 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 			spin_unlock(&cache->lock);
 			spin_unlock(&cache->space_info->lock);
 
-			trace_btrfs_space_reservation(info, "pinned",
-						      cache->space_info->flags,
-						      num_bytes, 1);
 			percpu_counter_add_batch(
 					&cache->space_info->total_bytes_pinned,
 					num_bytes,
diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 698470b9f32d..c64b460a4301 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -283,16 +283,11 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
 			block_rsv->reserved += num_bytes;
 			btrfs_space_info_update_bytes_may_use(fs_info, sinfo,
 							      num_bytes);
-			trace_btrfs_space_reservation(fs_info, "space_info",
-						      sinfo->flags, num_bytes,
-						      1);
 		}
 	} else if (block_rsv->reserved > block_rsv->size) {
 		num_bytes = block_rsv->reserved - block_rsv->size;
 		btrfs_space_info_update_bytes_may_use(fs_info, sinfo,
 						      -num_bytes);
-		trace_btrfs_space_reservation(fs_info, "space_info",
-				      sinfo->flags, num_bytes, 0);
 		block_rsv->reserved = block_rsv->size;
 	}
 
diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index d2dfc201b2e1..1fc6bef3ccdf 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -130,8 +130,6 @@ int btrfs_alloc_data_chunk_ondemand(struct btrfs_inode *inode, u64 bytes)
 		return -ENOSPC;
 	}
 	btrfs_space_info_update_bytes_may_use(fs_info, data_sinfo, bytes);
-	trace_btrfs_space_reservation(fs_info, "space_info",
-				      data_sinfo->flags, bytes, 1);
 	spin_unlock(&data_sinfo->lock);
 
 	return 0;
@@ -183,8 +181,6 @@ void btrfs_free_reserved_data_space_noquota(struct inode *inode, u64 start,
 	data_sinfo = fs_info->data_sinfo;
 	spin_lock(&data_sinfo->lock);
 	btrfs_space_info_update_bytes_may_use(fs_info, data_sinfo, -len);
-	trace_btrfs_space_reservation(fs_info, "space_info",
-				      data_sinfo->flags, len, 0);
 	spin_unlock(&data_sinfo->lock);
 }
 
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 444844b431f7..8c3e8fdbf2c1 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2583,8 +2583,6 @@ static int pin_down_extent(struct btrfs_block_group_cache *cache,
 	spin_unlock(&cache->lock);
 	spin_unlock(&cache->space_info->lock);
 
-	trace_btrfs_space_reservation(fs_info, "pinned",
-				      cache->space_info->flags, num_bytes, 1);
 	percpu_counter_add_batch(&cache->space_info->total_bytes_pinned,
 		    num_bytes, BTRFS_TOTAL_BYTES_PINNED_BATCH);
 	set_extent_dirty(fs_info->pinned_extents, bytenr,
@@ -2842,9 +2840,6 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 		spin_lock(&cache->lock);
 		cache->pinned -= len;
 		btrfs_space_info_update_bytes_pinned(fs_info, space_info, -len);
-
-		trace_btrfs_space_reservation(fs_info, "pinned",
-					      space_info->flags, len, 0);
 		space_info->max_extent_size = 0;
 		percpu_counter_add_batch(&space_info->total_bytes_pinned,
 			    -len, BTRFS_TOTAL_BYTES_PINNED_BATCH);
@@ -2866,10 +2861,6 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 						space_info, to_add);
 				if (global_rsv->reserved >= global_rsv->size)
 					global_rsv->full = 1;
-				trace_btrfs_space_reservation(fs_info,
-							      "space_info",
-							      space_info->flags,
-							      to_add, 1);
 				len -= to_add;
 			}
 			spin_unlock(&global_rsv->lock);
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 33fa0ba49759..a0a36d5768e1 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -279,8 +279,6 @@ void btrfs_space_info_add_old_bytes(struct btrfs_fs_info *fs_info,
 		goto again;
 	}
 	btrfs_space_info_update_bytes_may_use(fs_info, space_info, -num_bytes);
-	trace_btrfs_space_reservation(fs_info, "space_info",
-				      space_info->flags, num_bytes, 0);
 	spin_unlock(&space_info->lock);
 }
 
@@ -301,9 +299,6 @@ void btrfs_space_info_add_new_bytes(struct btrfs_fs_info *fs_info,
 		ticket = list_first_entry(head, struct reserve_ticket,
 					  list);
 		if (num_bytes >= ticket->bytes) {
-			trace_btrfs_space_reservation(fs_info, "space_info",
-						      space_info->flags,
-						      ticket->bytes, 1);
 			list_del_init(&ticket->list);
 			num_bytes -= ticket->bytes;
 			btrfs_space_info_update_bytes_may_use(fs_info,
@@ -313,9 +308,6 @@ void btrfs_space_info_add_new_bytes(struct btrfs_fs_info *fs_info,
 			space_info->tickets_id++;
 			wake_up(&ticket->wait);
 		} else {
-			trace_btrfs_space_reservation(fs_info, "space_info",
-						      space_info->flags,
-						      num_bytes, 1);
 			btrfs_space_info_update_bytes_may_use(fs_info,
 							      space_info,
 							      num_bytes);
@@ -1014,8 +1006,6 @@ static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
 			   system_chunk))) {
 		btrfs_space_info_update_bytes_may_use(fs_info, space_info,
 						      orig_bytes);
-		trace_btrfs_space_reservation(fs_info, "space_info",
-					      space_info->flags, orig_bytes, 1);
 		ret = 0;
 	}
 
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index c2b54b8e1a14..025f7ce2c9b1 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -87,14 +87,18 @@ static inline bool btrfs_mixed_space_info(struct btrfs_space_info *space_info)
  *
  * Declare a helper function to detect underflow of various space info members
  */
-#define DECLARE_SPACE_INFO_UPDATE(name)					\
+#define DECLARE_SPACE_INFO_UPDATE(name, trace_name)			\
 static inline void							\
 btrfs_space_info_update_##name(struct btrfs_fs_info *fs_info,		\
 			       struct btrfs_space_info *sinfo,		\
 			       s64 bytes)				\
 {									\
+	u64 abs_bytes = (bytes < 0) ? -bytes : bytes;			\
 	lockdep_assert_held(&sinfo->lock);				\
 	trace_update_##name(fs_info, sinfo, sinfo->name, bytes);	\
+	trace_btrfs_space_reservation(fs_info, trace_name,		\
+				      sinfo->flags, abs_bytes,		\
+				      bytes > 0);			\
 	if (bytes < 0 && sinfo->name < -bytes) {			\
 		WARN_ON(1);						\
 		sinfo->name = 0;					\
@@ -103,8 +107,8 @@ btrfs_space_info_update_##name(struct btrfs_fs_info *fs_info,		\
 	sinfo->name += bytes;						\
 }
 
-DECLARE_SPACE_INFO_UPDATE(bytes_may_use);
-DECLARE_SPACE_INFO_UPDATE(bytes_pinned);
+DECLARE_SPACE_INFO_UPDATE(bytes_may_use, "space_info");
+DECLARE_SPACE_INFO_UPDATE(bytes_pinned, "pinned");
 
 void btrfs_space_info_add_new_bytes(struct btrfs_fs_info *fs_info,
 				    struct btrfs_space_info *space_info,
-- 
2.21.0

