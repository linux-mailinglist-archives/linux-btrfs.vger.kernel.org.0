Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10B4EDC455
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2019 14:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409963AbfJRMGY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Oct 2019 08:06:24 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4731 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2409959AbfJRMGX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Oct 2019 08:06:23 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C6A009722F2450F91989;
        Fri, 18 Oct 2019 20:06:19 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Fri, 18 Oct 2019
 20:06:12 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>
CC:     <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] btrfs: Make init_tree_roots static
Date:   Fri, 18 Oct 2019 20:06:04 +0800
Message-ID: <20191018120604.29508-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fix sparse warning:

fs/btrfs/disk-io.c:2534:12: warning:
 symbol 'init_tree_roots' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/btrfs/disk-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d078276..cb187f5 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2531,7 +2531,7 @@ static int btrfs_validate_write_super(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
-int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
+static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
 {
 	int backup_index = find_newest_super_backup(fs_info);
 	struct btrfs_super_block *sb = fs_info->super_copy;
-- 
2.7.4


