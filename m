Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 056374AB75
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 22:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730557AbfFRUJp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 16:09:45 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36343 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbfFRUJp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 16:09:45 -0400
Received: by mail-qk1-f196.google.com with SMTP id g18so9450789qkl.3
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2019 13:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=NdMZqCEF7NawmklxP0botS918EFPcYHBg7IA6YH2Z5Y=;
        b=Pi8tSDCai1UHdqdwoweEb19cD16fkg6tiabdAHI7CIAQUtp2YpDt1vR4ap5VEEmWyg
         5OkmDViidrAJuvRxYU8Us9A0NG4tjU1BbkKrmAWRX0xulBpcSKNXNPaRpQtiYWovjvKK
         ZIeLD4kUx8Y77oNTs3RDD/wSfzOHWDgmW7lxvGu9tvq0GSOeAjF0HdfzrpQ6xMXpkBvV
         GFoFYCcMCn/Qaie5hvkdME5HoVSgtrg1tRUWOioiKWfCN5SXqFSP3r3NKFzmZ5vVYlN6
         m0jbahtv8xCtNO8cinG5rVnatxcW/H/x+Kz9VB37Zbhx76E+1nTtaHjOrKTIsOIsEDc1
         IqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=NdMZqCEF7NawmklxP0botS918EFPcYHBg7IA6YH2Z5Y=;
        b=Y37befUCqyE9Ynj252r5arlWG5DLzC3ZcdNCXknCM4dmwFXa5X6cI00ZJkaHXQsw6a
         tOR95SpRFet/08Yl+iLdCf12/vjOMwywvuotj2tqaTTlEG8OIVxhV8qgVlaN1/BjdQc3
         jML8oyP8uGKXaiUSxXJhk7Qpvr+/JBJnSPDaYxWBtP8hihcuVYysmCtqfatKhWeElD7e
         sqO8YNhi2FxVME6ZZuf5SBdm6n3w/54VBLBS+mYls5LoRivC9lfhSWX3Jsm3uNlbIU1Z
         Z3qxI4X0rHr7bqKOm9XT9/IomoOABODGunLxFrcuKTmP4RmcDKXkZmARemCbqipQp+DO
         ZRXA==
X-Gm-Message-State: APjAAAUqB5BQOQxjXtzMg9J1aVVCrQqVD/ni9wv6xfkTR58x6thv1H6z
        4CKNVTvUu/EuvZC5CJPErUAHggeOiMNeUw==
X-Google-Smtp-Source: APXvYqyrIqAuYX2SfVH8y1zex231Ye6EDr08rEO1SoPO6E4/Y61NtmPeRFXoCmkTNmjfnMJZ6U5pbw==
X-Received: by 2002:a05:620a:69c:: with SMTP id f28mr9358660qkh.274.1560888583963;
        Tue, 18 Jun 2019 13:09:43 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id a11sm8374771qkn.26.2019.06.18.13.09.43
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 13:09:43 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 08/11] btrfs: export block_rsv_use_bytes
Date:   Tue, 18 Jun 2019 16:09:23 -0400
Message-Id: <20190618200926.3352-9-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190618200926.3352-1-josef@toxicpanda.com>
References: <20190618200926.3352-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We are going to need this to move the metadata reservation stuff to
space_info.c.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h       |  2 ++
 fs/btrfs/extent-tree.c | 14 ++++++--------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index cceb1b5fab33..2aeb323cc86e 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2828,6 +2828,8 @@ int btrfs_block_rsv_refill(struct btrfs_root *root,
 int btrfs_block_rsv_migrate(struct btrfs_block_rsv *src_rsv,
 			    struct btrfs_block_rsv *dst_rsv, u64 num_bytes,
 			    bool update_size);
+int btrfs_block_rsv_use_bytes(struct btrfs_block_rsv *block_rsv,
+			      u64 num_bytes);
 int btrfs_cond_migrate_bytes(struct btrfs_fs_info *fs_info,
 			     struct btrfs_block_rsv *dest, u64 num_bytes,
 			     int min_factor);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 86f5b26c0bf1..d21ee7af1e3e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -53,8 +53,6 @@ static int find_next_key(struct btrfs_path *path, int level,
 static void dump_space_info(struct btrfs_fs_info *fs_info,
 			    struct btrfs_space_info *info, u64 bytes,
 			    int dump_block_groups);
-static int block_rsv_use_bytes(struct btrfs_block_rsv *block_rsv,
-			       u64 num_bytes);
 
 static noinline int
 block_group_cache_done(struct btrfs_block_group_cache *cache)
@@ -5033,7 +5031,7 @@ static int reserve_metadata_bytes(struct btrfs_root *root,
 	if (ret == -ENOSPC &&
 	    unlikely(root->orphan_cleanup_state == ORPHAN_CLEANUP_STARTED)) {
 		if (block_rsv != global_rsv &&
-		    !block_rsv_use_bytes(global_rsv, orig_bytes))
+		    !btrfs_block_rsv_use_bytes(global_rsv, orig_bytes))
 			ret = 0;
 	}
 	if (ret == -ENOSPC) {
@@ -5069,8 +5067,8 @@ static struct btrfs_block_rsv *get_block_rsv(
 	return block_rsv;
 }
 
-static int block_rsv_use_bytes(struct btrfs_block_rsv *block_rsv,
-			       u64 num_bytes)
+int btrfs_block_rsv_use_bytes(struct btrfs_block_rsv *block_rsv,
+			      u64 num_bytes)
 {
 	int ret = -ENOSPC;
 	spin_lock(&block_rsv->lock);
@@ -5268,7 +5266,7 @@ int btrfs_block_rsv_migrate(struct btrfs_block_rsv *src,
 {
 	int ret;
 
-	ret = block_rsv_use_bytes(src, num_bytes);
+	ret = btrfs_block_rsv_use_bytes(src, num_bytes);
 	if (ret)
 		return ret;
 
@@ -8142,7 +8140,7 @@ use_block_rsv(struct btrfs_trans_handle *trans,
 	if (unlikely(block_rsv->size == 0))
 		goto try_reserve;
 again:
-	ret = block_rsv_use_bytes(block_rsv, blocksize);
+	ret = btrfs_block_rsv_use_bytes(block_rsv, blocksize);
 	if (!ret)
 		return block_rsv;
 
@@ -8180,7 +8178,7 @@ use_block_rsv(struct btrfs_trans_handle *trans,
 	 */
 	if (block_rsv->type != BTRFS_BLOCK_RSV_GLOBAL &&
 	    block_rsv->space_info == global_rsv->space_info) {
-		ret = block_rsv_use_bytes(global_rsv, blocksize);
+		ret = btrfs_block_rsv_use_bytes(global_rsv, blocksize);
 		if (!ret)
 			return global_rsv;
 	}
-- 
2.14.3

