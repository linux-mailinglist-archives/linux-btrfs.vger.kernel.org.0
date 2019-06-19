Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DECB04C02C
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 19:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbfFSRre (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 13:47:34 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34494 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfFSRre (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 13:47:34 -0400
Received: by mail-qt1-f193.google.com with SMTP id m29so49108qtu.1
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2019 10:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=0Le4tJJiaii2CNKJjjbS65um7/4wYlEwlzk3V2ySveY=;
        b=BhKBe5Xo0L6Po3iYS8OGynGG/XmcdnmRaVFzdnnU1o5U3doFGNyeEuKYRvBrfxYKr4
         7AXpGDmw89tI3fFrdlg7Y+HgVJKEkrqbT4nNva/U5kPMZje1OV4JAW9u3kpM5YfGKUsS
         q3pKxv34tmAQB70UCqCR6eZV/mlxznvfpLsACbiQzL3tc6MZ5NFfNQeipxXPsn6cExC2
         LFC15BC8+yy9sWEOnMwXQghSvQQXzyOAWk3OpfucuUGcbfPqqXLWzdxhaU+kA8FyGBKs
         NYLbsfc0xUmLoDSwQftFig94MYx6yiWMRELS/0qh11/RLRaODksAOPHWy8BuqFf8z7pj
         6qQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=0Le4tJJiaii2CNKJjjbS65um7/4wYlEwlzk3V2ySveY=;
        b=RvbGCWzphXARL+0LLJDjaCiwMA4LArH9PzUmfOYdLdg6gc9G2mtSFmvGGHQ1QRfjWh
         5UebumY0su2I00C6mvoh7Irpod3Hg85y+rWu4yRldwKF3tcwwAxfHhNQ2ltm95mBytw5
         e19DMGn+kTUM5yplIGk1SA94+2+Jao+3ds6GL6n7VqTjGv8s64enC6FcHWZOe+NgxZpZ
         ZTVpE+rhZYeMCTFi5J0zDqJ2wLD8v0yd8v26BVxjugo8bLSMnn99z9olWXNhrzXvETsS
         ZMNmShshbCaSp6CZwLSR+UWCBAOmiiYaWjRBQ8RxJt3DeUt4dtqJpfZLE/oyJfQvrLrD
         DEZQ==
X-Gm-Message-State: APjAAAWKyA83pidyjK3tPJj7427BHaCT9ajTvbcKi1CUNtKtC6TzAYT0
        oKDftk9hwxQwELMSoOI2XRtJS00jhBMcog==
X-Google-Smtp-Source: APXvYqzQKx9SD+URTl8wd5Y0l5ndE9y6xzhd48GE5u6Ty8wmGMDxwNNa/v7CoJVxOqqmFxpJPxkUwQ==
X-Received: by 2002:ac8:3132:: with SMTP id g47mr53331343qtb.155.1560966452845;
        Wed, 19 Jun 2019 10:47:32 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z18sm13004014qka.12.2019.06.19.10.47.32
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 10:47:32 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/8] btrfs: export __btrfs_block_rsv_release
Date:   Wed, 19 Jun 2019 13:47:19 -0400
Message-Id: <20190619174724.1675-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190619174724.1675-1-josef@toxicpanda.com>
References: <20190619174724.1675-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The delalloc reserve stuff calls this directly because it cares about
the qgroup accounting stuff, so export it so we can move it around.  Fix
btrfs_block_rsv_release() to just be a static inline since it just calls
__btrfs_block_rsv_release() with NULL for the qgroup stuff.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-rsv.h   | 13 ++++++++++---
 fs/btrfs/extent-tree.c | 13 +++----------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/block-rsv.h b/fs/btrfs/block-rsv.h
index 1ddc0659c678..dcea4bdb3817 100644
--- a/fs/btrfs/block-rsv.h
+++ b/fs/btrfs/block-rsv.h
@@ -75,9 +75,16 @@ int btrfs_block_rsv_use_bytes(struct btrfs_block_rsv *block_rsv,
 int btrfs_cond_migrate_bytes(struct btrfs_fs_info *fs_info,
 			     struct btrfs_block_rsv *dest, u64 num_bytes,
 			     int min_factor);
-void btrfs_block_rsv_release(struct btrfs_fs_info *fs_info,
-			     struct btrfs_block_rsv *block_rsv,
-			     u64 num_bytes);
 void btrfs_block_rsv_add_bytes(struct btrfs_block_rsv *block_rsv,
 			       u64 num_bytes, bool update_size);
+u64 __btrfs_block_rsv_release(struct btrfs_fs_info *fs_info,
+			      struct btrfs_block_rsv *block_rsv,
+			      u64 num_bytes, u64 *qgroup_to_release);
+
+static inline void btrfs_block_rsv_release(struct btrfs_fs_info *fs_info,
+					   struct btrfs_block_rsv *block_rsv,
+					   u64 num_bytes)
+{
+	__btrfs_block_rsv_release(fs_info, block_rsv, num_bytes, NULL);
+}
 #endif /* BTRFS_BLOCK_RSV_H */
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 2c81c546f0fc..d6aff56337aa 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4678,9 +4678,9 @@ int btrfs_block_rsv_refill(struct btrfs_root *root,
 	return ret;
 }
 
-static u64 __btrfs_block_rsv_release(struct btrfs_fs_info *fs_info,
-				     struct btrfs_block_rsv *block_rsv,
-				     u64 num_bytes, u64 *qgroup_to_release)
+u64 __btrfs_block_rsv_release(struct btrfs_fs_info *fs_info,
+			      struct btrfs_block_rsv *block_rsv,
+			      u64 num_bytes, u64 *qgroup_to_release)
 {
 	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
 	struct btrfs_block_rsv *delayed_rsv = &fs_info->delayed_refs_rsv;
@@ -4696,13 +4696,6 @@ static u64 __btrfs_block_rsv_release(struct btrfs_fs_info *fs_info,
 				       qgroup_to_release);
 }
 
-void btrfs_block_rsv_release(struct btrfs_fs_info *fs_info,
-			     struct btrfs_block_rsv *block_rsv,
-			     u64 num_bytes)
-{
-	__btrfs_block_rsv_release(fs_info, block_rsv, num_bytes, NULL);
-}
-
 /**
  * btrfs_inode_rsv_release - release any excessive reservation.
  * @inode - the inode we need to release from.
-- 
2.14.3

