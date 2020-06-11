Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7941F5F45
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jun 2020 02:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgFKAiQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Jun 2020 20:38:16 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:26096 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbgFKAiQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Jun 2020 20:38:16 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id 71129FAD066F789DF247;
        Thu, 11 Jun 2020 08:38:14 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notes_smtp.zte.com.cn [10.30.1.239])
        by mse-fl1.zte.com.cn with ESMTP id 05B0cAYw089867;
        Thu, 11 Jun 2020 08:38:10 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2020061108383704-3897443 ;
          Thu, 11 Jun 2020 08:38:37 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        wang.liang82@zte.com.cn, Liao Pingfang <liao.pingfang@zte.com.cn>
Subject: [PATCH v2] btrfs: Remove unnecessary failure messages during memory allocation
Date:   Thu, 11 Jun 2020 08:40:36 +0800
Message-Id: <1591836036-26253-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2020-06-11 08:38:37,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2020-06-11 08:38:14,
        Serialize complete at 2020-06-11 08:38:14
X-MAIL: mse-fl1.zte.com.cn 05B0cAYw089867
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Liao Pingfang <liao.pingfang@zte.com.cn>

As there is a dump_stack() done on memory allocation
failures, these messages might as well be deleted instead.

Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
---
Changes in v2: Remove these error messages instead of changing them.

 fs/btrfs/check-integrity.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 32e11a2..d8d26f9 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -632,7 +632,6 @@ static int btrfsic_process_superblock(struct btrfsic_state *state,
 
 	selected_super = kzalloc(sizeof(*selected_super), GFP_NOFS);
 	if (NULL == selected_super) {
-		pr_info("btrfsic: error, kmalloc failed!\n");
 		return -ENOMEM;
 	}
 
@@ -795,7 +794,6 @@ static int btrfsic_process_superblock_dev_mirror(
 	if (NULL == superblock_tmp) {
 		superblock_tmp = btrfsic_block_alloc();
 		if (NULL == superblock_tmp) {
-			pr_info("btrfsic: error, kmalloc failed!\n");
 			ret = -1;
 			goto out;
 		}
@@ -1313,7 +1311,6 @@ static int btrfsic_create_link_to_next_block(
 	if (NULL == l) {
 		l = btrfsic_block_link_alloc();
 		if (NULL == l) {
-			pr_info("btrfsic: error, kmalloc failed!\n");
 			btrfsic_release_block_ctx(next_block_ctx);
 			*next_blockp = NULL;
 			return -1;
@@ -1470,7 +1467,6 @@ static int btrfsic_handle_extent_data(
 					mirror_num,
 					&block_was_created);
 			if (NULL == next_block) {
-				pr_info("btrfsic: error, kmalloc failed!\n");
 				btrfsic_release_block_ctx(&next_block_ctx);
 				return -1;
 			}
@@ -2013,7 +2009,6 @@ static void btrfsic_process_written_block(struct btrfsic_dev_state *dev_state,
 
 		block = btrfsic_block_alloc();
 		if (NULL == block) {
-			pr_info("btrfsic: error, kmalloc failed!\n");
 			btrfsic_release_block_ctx(&block_ctx);
 			goto continue_loop;
 		}
@@ -2234,7 +2229,6 @@ static int btrfsic_process_written_superblock(
 					mirror_num,
 					&was_created);
 			if (NULL == next_block) {
-				pr_info("btrfsic: error, kmalloc failed!\n");
 				btrfsic_release_block_ctx(&tmp_next_block_ctx);
 				return -1;
 			}
@@ -2543,7 +2537,6 @@ static struct btrfsic_block_link *btrfsic_block_link_lookup_or_add(
 	if (NULL == l) {
 		l = btrfsic_block_link_alloc();
 		if (NULL == l) {
-			pr_info("btrfsic: error, kmalloc failed!\n");
 			return NULL;
 		}
 
@@ -2590,7 +2583,6 @@ static struct btrfsic_block *btrfsic_block_lookup_or_add(
 
 		block = btrfsic_block_alloc();
 		if (NULL == block) {
-			pr_info("btrfsic: error, kmalloc failed!\n");
 			return NULL;
 		}
 		dev_state = btrfsic_dev_state_lookup(block_ctx->dev->bdev->bd_dev);
@@ -2829,7 +2821,6 @@ int btrfsic_mount(struct btrfs_fs_info *fs_info,
 
 		ds = btrfsic_dev_state_alloc();
 		if (NULL == ds) {
-			pr_info("btrfs check-integrity: kmalloc() failed!\n");
 			mutex_unlock(&btrfsic_mutex);
 			return -ENOMEM;
 		}
-- 
2.9.5

