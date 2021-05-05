Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C3537338F
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 May 2021 03:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhEEB12 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 May 2021 21:27:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17588 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbhEEB10 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 May 2021 21:27:26 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FZfB31LTtz18Jmb;
        Wed,  5 May 2021 09:23:55 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Wed, 5 May 2021 09:26:21 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <dsterba@suse.com>, <josef@toxicpanda.com>, <clm@fb.com>
CC:     <linux-btrfs@vger.kernel.org>, Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH v2] btrfs: add goto in btrfs_defrag_file for error handling
Date:   Wed, 5 May 2021 09:26:28 +0800
Message-ID: <1620177988-6664-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

ret is assigned -EAGAIN at line 1455 and then reassigned defrag_count
at line 1547 after exiting the while loop.this causes the
btrfs_defrag_file function to not return the correct value in the event
of an error, this patch fixed this issue.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---

v2: rewrite the patch, patch name and commit message.
---
 fs/btrfs/ioctl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index ee1dbab..5713450 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1453,7 +1453,7 @@ int btrfs_defrag_file(struct inode *inode, struct file *file,
 		if (btrfs_defrag_cancelled(fs_info)) {
 			btrfs_debug(fs_info, "defrag_file cancelled");
 			ret = -EAGAIN;
-			break;
+			goto error;
 		}
 
 		if (!should_defrag_range(inode, (u64)i << PAGE_SHIFT,
@@ -1531,6 +1531,8 @@ int btrfs_defrag_file(struct inode *inode, struct file *file,
 		}
 	}
 
+	ret = defrag_count;
+error:
 	if ((range->flags & BTRFS_DEFRAG_RANGE_START_IO)) {
 		filemap_flush(inode->i_mapping);
 		if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
@@ -1544,8 +1546,6 @@ int btrfs_defrag_file(struct inode *inode, struct file *file,
 		btrfs_set_fs_incompat(fs_info, COMPRESS_ZSTD);
 	}
 
-	ret = defrag_count;
-
 out_ra:
 	if (do_compress) {
 		btrfs_inode_lock(inode, 0);
-- 
2.7.4

