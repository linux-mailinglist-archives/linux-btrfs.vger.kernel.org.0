Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 839A49E9C0
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 15:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbfH0Nn4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 09:43:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59928 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725825AbfH0Nn4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 09:43:56 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8C556A8516FCBAFD2D28;
        Tue, 27 Aug 2019 21:43:53 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 27 Aug 2019
 21:43:46 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>
CC:     <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] btrfs: Make inc_block_group_ro static
Date:   Tue, 27 Aug 2019 21:43:12 +0800
Message-ID: <20190827134312.15216-1-yuehaibing@huawei.com>
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

fs/btrfs/block-group.c:1183:5: warning:
 symbol 'inc_block_group_ro' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/btrfs/block-group.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 3147e84..8cc7768 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1180,7 +1180,7 @@ struct btrfs_trans_handle *btrfs_start_trans_remove_block_group(
  * data in this block group. That check should be done by relocation routine,
  * not this function.
  */
-int inc_block_group_ro(struct btrfs_block_group_cache *cache, int force)
+static int inc_block_group_ro(struct btrfs_block_group_cache *cache, int force)
 {
 	struct btrfs_space_info *sinfo = cache->space_info;
 	u64 num_bytes;
-- 
2.7.4


