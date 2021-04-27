Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61E736BD05
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Apr 2021 03:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbhD0BvC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 21:51:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17040 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbhD0BvB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 21:51:01 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FTl4Y4x7lzNyLk;
        Tue, 27 Apr 2021 09:47:09 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Tue, 27 Apr 2021 09:50:08 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>
CC:     <linux-btrfs@vger.kernel.org>, Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH] btrfs: delete unneeded assignments in btrfs_defrag_file
Date:   Tue, 27 Apr 2021 09:50:21 +0800
Message-ID: <1619488221-29490-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

ret is assigned -EAGAIN at line 1455 and then reassigned defrag_count
at line 1547 after exiting the while loop, but the btrfs_defrag_file
function returns a negative number indicating that the execution failed
because it does not make sense to reassign defrag_count to ret, so
delete it.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 fs/btrfs/ioctl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index ee1dbab..2b3b228 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1544,8 +1544,6 @@ int btrfs_defrag_file(struct inode *inode, struct file *file,
 		btrfs_set_fs_incompat(fs_info, COMPRESS_ZSTD);
 	}
 
-	ret = defrag_count;
-
 out_ra:
 	if (do_compress) {
 		btrfs_inode_lock(inode, 0);
-- 
2.7.4

