Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4A6134344
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2020 14:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgAHNDQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jan 2020 08:03:16 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:38338 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726144AbgAHNDQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Jan 2020 08:03:16 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A6D2FF6E7B2383C863CD;
        Wed,  8 Jan 2020 21:03:13 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Wed, 8 Jan 2020
 21:03:05 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>
CC:     <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] btrfs: remove set but not used variable 'root_objectid'
Date:   Wed, 8 Jan 2020 20:58:35 +0800
Message-ID: <20200108125835.45768-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

fs/btrfs/inode.c: In function btrfs_rename:
fs/btrfs/inode.c:9196:6: warning: variable root_objectid set but not used [-Wunused-but-set-variable]

commit f8b3030e0807 ("btrfs: rework arguments of btrfs_unlink_subvol")
left behind this unused variable.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/btrfs/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 493c0fe..990f509 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9204,7 +9204,6 @@ static int btrfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	struct inode *new_inode = d_inode(new_dentry);
 	struct inode *old_inode = d_inode(old_dentry);
 	u64 index = 0;
-	u64 root_objectid;
 	int ret;
 	u64 old_ino = btrfs_ino(BTRFS_I(old_inode));
 	bool log_pinned = false;
@@ -9331,7 +9330,6 @@ static int btrfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		new_inode->i_ctime = current_time(new_inode);
 		if (unlikely(btrfs_ino(BTRFS_I(new_inode)) ==
 			     BTRFS_EMPTY_SUBVOL_DIR_OBJECTID)) {
-			root_objectid = BTRFS_I(new_inode)->location.objectid;
 			ret = btrfs_unlink_subvol(trans, new_dir, new_dentry);
 			BUG_ON(new_inode->i_nlink == 0);
 		} else {
-- 
2.7.4


