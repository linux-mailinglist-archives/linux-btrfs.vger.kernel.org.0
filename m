Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C645427422E
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Sep 2020 14:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgIVMiu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Sep 2020 08:38:50 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13825 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726505AbgIVMiu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Sep 2020 08:38:50 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E6F361EEE767D0F7BEFD;
        Tue, 22 Sep 2020 20:38:46 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Tue, 22 Sep 2020 20:38:40 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <clm@fb.com>, <josef@toxicpanda.com>, <dsterba@suse.com>,
        <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH] btrfs: block-group: fix a doc warning in block-group.c
Date:   Tue, 22 Sep 2020 20:37:21 +0800
Message-ID: <1600778241-24895-1-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fix following warning caused by mismatch bewteen function parameters
and comments.
fs/btrfs/block-group.c:1649: warning: Function parameter or member 'fs_info' not described in 'btrfs_rmap_block'

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 fs/btrfs/block-group.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index ea8aaf36..fea6350 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1633,6 +1633,7 @@ static void set_avail_alloc_bits(struct btrfs_fs_info *fs_info, u64 flags)
 
 /**
  * btrfs_rmap_block - Map a physical disk address to a list of logical addresses
+ * @fs_info:	   the fs_info for our fs
  * @chunk_start:   logical address of block group
  * @physical:	   physical address to map to logical addresses
  * @logical:	   return array of logical addresses which map to @physical
-- 
2.8.1

