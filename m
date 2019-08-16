Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0C72903DC
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2019 16:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfHPOUC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Aug 2019 10:20:02 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45074 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbfHPOUC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Aug 2019 10:20:02 -0400
Received: by mail-qk1-f194.google.com with SMTP id m2so4788412qki.12
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2019 07:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gy7GGv1kGKas0SSIrlucNtmeQ5OueOrHxellHUGWZQs=;
        b=GEL6TFIVSK42+X/Vd+OJwHltYJvzEMFAfjg854QSp/SorQuQlHBfvJTQYPCot1m2g7
         AN1xCFu86CCnO2e4Z91r/kCuyFmSqoWHo8YfYRwdCW5n2j/AOAcxIRBTrChK08j81qUJ
         xYIxoHVePLYg8b0Q4hqRu7l0HMl/RXmAwNUUkAiV4hq2OUxGb63MKLUQtE45xC+JBVX+
         UmNjgXKsMo7g3golwX6xdcb9qtFsypyJTZeTKZXFrqgkpWhYUmVQotSuT/E1iVCc7nDI
         Q7og1HH3qgh/a0vP7DupK6+OilA2VQXew+mW8/0XAJ/r0YiSz1ErSwRZbe0xJsDHILoQ
         I/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gy7GGv1kGKas0SSIrlucNtmeQ5OueOrHxellHUGWZQs=;
        b=RXurhRuZBHDETjVVL39LJxLJDbElPveBLhfbQt2pw6+b/BV4cZnyIuj4GTCRSEF4mm
         nNU2gw+d6Jg8xeJZ88+hUYHF4HyaKPyXU0K719+EQEaGh7le8uktD79Jg3g2RjazXi3K
         mQLtUldijhrI3h8B02PkKpeGwQit4nV8urvWNfyu2kfeEm84qMz5Gybzz0OOIrGtUcqo
         tdBo6ukRA8x1l0eNWMqORyljK20cEkTG9O8doQEgZ2tSUXCbKisqcOiG/KSm9ZXuIGe0
         Hcxk7mrqiUOPR89nKDEXp5oKu/kgY2S8WiirxYNV63f+kOGEVu4atjIZhyoCJLONuQAY
         Vcjw==
X-Gm-Message-State: APjAAAX1zOQqFotBbX8u+XZy+gu4KrBTbJ6GpKDL9/wnonr7yRy+T46b
        Dj8RP6hor1C0Mnjip+OPwHK62221n/K7Vg==
X-Google-Smtp-Source: APXvYqzi7f9aDN1osJNMVtS+uNmSP3etDDj4PD5Ppjs41f+jq054xQ1NwERJZE5BkITcROBp9xqoxA==
X-Received: by 2002:a05:620a:52e:: with SMTP id h14mr9301629qkh.358.1565965199729;
        Fri, 16 Aug 2019 07:19:59 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s4sm3019812qkb.130.2019.08.16.07.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2019 07:19:59 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/8] btrfs: roll tracepoint into btrfs_space_info_update helper
Date:   Fri, 16 Aug 2019 10:19:46 -0400
Message-Id: <20190816141952.19369-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190816141952.19369-1-josef@toxicpanda.com>
References: <20190816141952.19369-1-josef@toxicpanda.com>
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
index cd210550a349..32f9473c8426 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2580,8 +2580,6 @@ static int pin_down_extent(struct btrfs_block_group_cache *cache,
 	spin_unlock(&cache->lock);
 	spin_unlock(&cache->space_info->lock);
 
-	trace_btrfs_space_reservation(fs_info, "pinned",
-				      cache->space_info->flags, num_bytes, 1);
 	percpu_counter_add_batch(&cache->space_info->total_bytes_pinned,
 		    num_bytes, BTRFS_TOTAL_BYTES_PINNED_BATCH);
 	set_extent_dirty(fs_info->pinned_extents, bytenr,
@@ -2839,9 +2837,6 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 		spin_lock(&cache->lock);
 		cache->pinned -= len;
 		btrfs_space_info_update_bytes_pinned(fs_info, space_info, -len);
-
-		trace_btrfs_space_reservation(fs_info, "pinned",
-					      space_info->flags, len, 0);
 		space_info->max_extent_size = 0;
 		percpu_counter_add_batch(&space_info->total_bytes_pinned,
 			    -len, BTRFS_TOTAL_BYTES_PINNED_BATCH);
@@ -2863,10 +2858,6 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
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
index d671d6476eed..780be5df31b4 100644
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
@@ -959,8 +951,6 @@ static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
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

