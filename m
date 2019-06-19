Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C76334C02E
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 19:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbfFSRrh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 13:47:37 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36723 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730259AbfFSRrh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 13:47:37 -0400
Received: by mail-qk1-f194.google.com with SMTP id g18so91100qkl.3
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2019 10:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=G6aG0Ob336hf8B5SkmsW7dMhHqR/PJThsUQXDluglbE=;
        b=Vhm0yHOD/BH9ECv+SJPZdtbllve7+PEeYgvu/QRpHLWfIqPZJYAaJwZGeSlls0u72p
         ZSxfVNJVxK6Jq4Yb9J+8be2ZU8/NdgZGOnJIjISdYYjDb4RQV+MbeT3KyALaH4QyooZG
         7l6hxw5UK3wjEGA1k5uXottJzAgUg7fZ82b9d1wmmSrVJxkzA+l+sicGborXa1YsyBlK
         8vF4tQZSqNullgzlc+9oDNl06Hv1s72j863X/X9QHHuz7XIIAMs4/I7uDMPgy7MJOn6i
         HpSr0DDlAVSXtguFo58SxK6NcqqDtJOGNAvy6L8Pg2uCn/NtCHsRTP8gRVp513RSN22B
         N+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=G6aG0Ob336hf8B5SkmsW7dMhHqR/PJThsUQXDluglbE=;
        b=FjBlQhCAZIbquz+KImBPAGi5zYX0pEVnyZANRSYY4n+VeItmxbyJ9rC3Eiaeo8JlyX
         Yc4ttmdqznBHWK3pSSf0OyAqFw3Zvbd3QjnHo98Dx6sriyJRwaMlgLtJR2tVeYlram0b
         3AFqFCN+MkmEYauKOt+2W0mkzsF/dE8TVP8+L0NtVSheu8BLvx9QCisUzG5T348eU2/Y
         u53C4R+WdkX4VIj4TmLLGAgLmWSZW778N7fuU27vHDr+uN9J/3mcauw7eOATq048o7NB
         mguTxMrCSJDFMzUUPuWsRlWfi9932rygvoYdFwB3CsHqGRZAq814qrHQeLEsQuJrssfW
         B8Lw==
X-Gm-Message-State: APjAAAXT62sKucCU+SjJmK1VN7dpgG2+Abgf98X9QB4Nb6DK9qqfb0X8
        LPLRrI3UJWqTHwtwOO2tR5WkbQzWd5T2XQ==
X-Google-Smtp-Source: APXvYqwKugL88qtHioYvcMWbIcOuph/mnBpdPmWy4Y0CcDmDOMF4yKnZ5ACFYoQ3j9M7bdXlSYxhNA==
X-Received: by 2002:a37:a017:: with SMTP id j23mr100426322qke.258.1560966456076;
        Wed, 19 Jun 2019 10:47:36 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d123sm11896879qkb.94.2019.06.19.10.47.35
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 10:47:35 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/8] btrfs: stop using block_rsv_release_bytes everywhere
Date:   Wed, 19 Jun 2019 13:47:21 -0400
Message-Id: <20190619174724.1675-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20190619174724.1675-1-josef@toxicpanda.com>
References: <20190619174724.1675-1-josef@toxicpanda.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

block_rsv_release_bytes() is the internal to the block_rsv code, and
shouldn't be called directly by anything else.  Switch all users to the
exported helpers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 6995edf887e1..d1fce37107b4 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4750,12 +4750,11 @@ static void btrfs_inode_rsv_release(struct btrfs_inode *inode, bool qgroup_free)
 void btrfs_delayed_refs_rsv_release(struct btrfs_fs_info *fs_info, int nr)
 {
 	struct btrfs_block_rsv *block_rsv = &fs_info->delayed_refs_rsv;
-	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
 	u64 num_bytes = btrfs_calc_trans_metadata_size(fs_info, nr);
 	u64 released = 0;
 
-	released = block_rsv_release_bytes(fs_info, block_rsv, global_rsv,
-					   num_bytes, NULL);
+	released = __btrfs_block_rsv_release(fs_info, block_rsv, num_bytes,
+					     NULL);
 	if (released)
 		trace_btrfs_space_reservation(fs_info, "delayed_refs_rsv",
 					      0, released, 0);
@@ -4840,8 +4839,7 @@ static void init_global_block_rsv(struct btrfs_fs_info *fs_info)
 
 static void release_global_block_rsv(struct btrfs_fs_info *fs_info)
 {
-	block_rsv_release_bytes(fs_info, &fs_info->global_block_rsv, NULL,
-				(u64)-1, NULL);
+	btrfs_block_rsv_release(fs_info, &fs_info->global_block_rsv, (u64)-1);
 	WARN_ON(fs_info->trans_block_rsv.size > 0);
 	WARN_ON(fs_info->trans_block_rsv.reserved > 0);
 	WARN_ON(fs_info->chunk_block_rsv.size > 0);
@@ -4890,8 +4888,8 @@ void btrfs_trans_release_chunk_metadata(struct btrfs_trans_handle *trans)
 
 	WARN_ON_ONCE(!list_empty(&trans->new_bgs));
 
-	block_rsv_release_bytes(fs_info, &fs_info->chunk_block_rsv, NULL,
-				trans->chunk_bytes_reserved, NULL);
+	btrfs_block_rsv_release(fs_info, &fs_info->chunk_block_rsv,
+				trans->chunk_bytes_reserved);
 	trans->chunk_bytes_reserved = 0;
 }
 
@@ -7441,7 +7439,7 @@ static void unuse_block_rsv(struct btrfs_fs_info *fs_info,
 			    struct btrfs_block_rsv *block_rsv, u32 blocksize)
 {
 	btrfs_block_rsv_add_bytes(block_rsv, blocksize, false);
-	block_rsv_release_bytes(fs_info, block_rsv, NULL, 0, NULL);
+	btrfs_block_rsv_release(fs_info, block_rsv, 0);
 }
 
 /*
-- 
2.14.3

