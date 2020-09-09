Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2E42630F2
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Sep 2020 17:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbgIIPtu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Sep 2020 11:49:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41702 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730581AbgIIPtp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Sep 2020 11:49:45 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 354901E989B60028A84F;
        Wed,  9 Sep 2020 21:52:51 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Wed, 9 Sep 2020
 21:52:41 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
        <nborisov@suse.com>
CC:     <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] btrfs: Remove unused function calc_global_rsv_need_space()
Date:   Wed, 9 Sep 2020 21:51:42 +0800
Message-ID: <20200909135142.27352-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It is not used since commit 0096420adb03 ("btrfs: do not
account global reserve in can_overcommit")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/btrfs/space-info.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index b733718f45d3..0f16a2ce5401 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -301,11 +301,6 @@ struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
 	return NULL;
 }
 
-static inline u64 calc_global_rsv_need_space(struct btrfs_block_rsv *global)
-{
-	return (global->size << 1);
-}
-
 static u64 calc_available_free_space(struct btrfs_fs_info *fs_info,
 			  struct btrfs_space_info *space_info,
 			  enum btrfs_reserve_flush_enum flush)
-- 
2.17.1


