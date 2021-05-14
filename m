Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685E1380627
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 May 2021 11:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhENJZn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 May 2021 05:25:43 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:59733 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232362AbhENJZl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 May 2021 05:25:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UYqHdQ4_1620984266;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UYqHdQ4_1620984266)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 14 May 2021 17:24:28 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com, nathan@kernel.org,
        ndesaulniers@google.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] btrfs: Remove redundant initialization of 'to_add'
Date:   Fri, 14 May 2021 17:24:25 +0800
Message-Id: <1620984265-53916-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Variable 'to_add' is being initialized however this value is never 
read as 'to_add' is assigned a new value in if statement. Remove the 
redundant assignment. At the same time, move its declaration into the 
if statement, because the variable is not used elsewhere.

Clean up clang warning:

fs/btrfs/extent-tree.c:2773:8: warning: Value stored to 'to_add' during
its initialization is never read [clang-analyzer-deadcode.DeadStores]

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/btrfs/extent-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index f1d15b6..e7b2289 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2774,10 +2774,10 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 		spin_unlock(&cache->lock);
 		if (!readonly && return_free_space &&
 		    global_rsv->space_info == space_info) {
-			u64 to_add = len;
 
 			spin_lock(&global_rsv->lock);
 			if (!global_rsv->full) {
+				u64 to_add;
 				to_add = min(len, global_rsv->size -
 					     global_rsv->reserved);
 				global_rsv->reserved += to_add;
-- 
1.8.3.1

