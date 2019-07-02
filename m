Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3A6D5D14F
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2019 16:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfGBOQS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Jul 2019 10:16:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8685 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726341AbfGBOQR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 2 Jul 2019 10:16:17 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B363CEA918F6B4BF7E6F;
        Tue,  2 Jul 2019 22:16:10 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Tue, 2 Jul 2019
 22:16:03 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
        <nborisov@suse.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-btrfs@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] btrfs: remove set but not used variable 'offset'
Date:   Tue, 2 Jul 2019 22:15:21 +0800
Message-ID: <20190702141521.48932-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

fs/btrfs/volumes.c: In function __btrfs_map_block:
fs/btrfs/volumes.c:6023:6: warning:
 variable offset set but not used [-Wunused-but-set-variable]

It is not used any more since commit 343abd1c0ca9 ("btrfs: Use
btrfs_get_io_geometry appropriately")

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/btrfs/volumes.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d1fd910..5d5a9ff 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6020,7 +6020,6 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 {
 	struct extent_map *em;
 	struct map_lookup *map;
-	u64 offset;
 	u64 stripe_offset;
 	u64 stripe_nr;
 	u64 stripe_len;
@@ -6055,7 +6054,6 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 	map = em->map_lookup;
 
 	*length = geom.len;
-	offset = geom.offset;
 	stripe_len = geom.stripe_len;
 	stripe_nr = geom.stripe_nr;
 	stripe_offset = geom.stripe_offset;
-- 
2.7.4


