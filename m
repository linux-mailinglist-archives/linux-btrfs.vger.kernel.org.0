Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48AC12B9F91
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Nov 2020 02:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgKTBFL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Nov 2020 20:05:11 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8003 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgKTBFL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Nov 2020 20:05:11 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Ccdck2bjvzhdP9;
        Fri, 20 Nov 2020 09:04:54 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Fri, 20 Nov 2020
 09:04:35 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>
CC:     <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH] btrfs: free-space-cache: Fix error return code in __load_free_space_cache
Date:   Fri, 20 Nov 2020 09:08:04 +0800
Message-ID: <20201120010804.440598-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fix to return the error code(instead always 0) when memory allocating
failed in __load_free_space_cache().

Fixes: a67509c30079f4c50 ("Btrfs: add a io_ctl struct and helpers ...")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/btrfs/free-space-cache.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index af0013d3df63..ae4059ce2f84 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -744,8 +744,10 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 	while (num_entries) {
 		e = kmem_cache_zalloc(btrfs_free_space_cachep,
 				      GFP_NOFS);
-		if (!e)
+		if (!e) {
+			ret = -ENOMEM;
 			goto free_cache;
+		}
 
 		ret = io_ctl_read_entry(&io_ctl, e, &type);
 		if (ret) {
@@ -764,6 +766,7 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 			e->trim_state = BTRFS_TRIM_STATE_TRIMMED;
 
 		if (!e->bytes) {
+			ret = -1;
 			kmem_cache_free(btrfs_free_space_cachep, e);
 			goto free_cache;
 		}
@@ -784,6 +787,7 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 			e->bitmap = kmem_cache_zalloc(
 					btrfs_free_space_bitmap_cachep, GFP_NOFS);
 			if (!e->bitmap) {
+				ret = -ENOMEM;
 				kmem_cache_free(
 					btrfs_free_space_cachep, e);
 				goto free_cache;
-- 
2.25.4

