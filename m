Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F92495E86
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jan 2022 12:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350186AbiAULoM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jan 2022 06:44:12 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:45428 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245752AbiAULoL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jan 2022 06:44:11 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V2RLK.V_1642765433;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V2RLK.V_1642765433)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 21 Jan 2022 19:43:57 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH v2] btrfs: zoned: Remove redundant initialization of to_add
Date:   Fri, 21 Jan 2022 19:43:51 +0800
Message-Id: <20220121114351.93220-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

to_add is being initialized to len but this is never read as
to_add is overwritten later on. Remove the redundant
initialization.

Cleans up the following clang-analyzer warning:

fs/btrfs/extent-tree.c:2769:8: warning: Value stored to 'to_add' during
its initialization is never read [clang-analyzer-deadcode.DeadStores].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v2:
  -"to_add" is define within the if (!global_rsv->full) branch.

 fs/btrfs/extent-tree.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d89273c4b6b8..8e91adbf352e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2766,12 +2766,10 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 		spin_unlock(&cache->lock);
 		if (!readonly && return_free_space &&
 		    global_rsv->space_info == space_info) {
-			u64 to_add = len;
-
 			spin_lock(&global_rsv->lock);
 			if (!global_rsv->full) {
-				to_add = min(len, global_rsv->size -
-					     global_rsv->reserved);
+				u64 to_add = min(len, global_rsv->size -
+						 global_rsv->reserved);
 				global_rsv->reserved += to_add;
 				btrfs_space_info_update_bytes_may_use(fs_info,
 						space_info, to_add);
-- 
2.20.1.7.g153144c

