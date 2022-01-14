Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC8948E873
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jan 2022 11:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240475AbiANKl6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jan 2022 05:41:58 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:43117 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233947AbiANKl5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jan 2022 05:41:57 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V1o6OlK_1642156898;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V1o6OlK_1642156898)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 14 Jan 2022 18:41:55 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] btrfs: zoned: Remove redundant initialization of to_add
Date:   Fri, 14 Jan 2022 18:41:36 +0800
Message-Id: <20220114104136.3531-1-jiapeng.chong@linux.alibaba.com>
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
 fs/btrfs/extent-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d89273c4b6b8..37117b62d005 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2766,7 +2766,7 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 		spin_unlock(&cache->lock);
 		if (!readonly && return_free_space &&
 		    global_rsv->space_info == space_info) {
-			u64 to_add = len;
+			u64 to_add;
 
 			spin_lock(&global_rsv->lock);
 			if (!global_rsv->full) {
-- 
2.20.1.7.g153144c

