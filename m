Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40B14823F7
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Dec 2021 13:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhLaMXW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Dec 2021 07:23:22 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:47460 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229985AbhLaMXV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Dec 2021 07:23:21 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V0QymRZ_1640953388;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V0QymRZ_1640953388)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 31 Dec 2021 20:23:19 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] btrfs: Remove redundant initialization of slot
Date:   Fri, 31 Dec 2021 20:23:06 +0800
Message-Id: <20211231122306.13720-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

slot is being initialized to path->slots[0] but this is never
read as slot is overwritten later on. Remove the redundant
initialization.

Cleans up the following clang-analyzer warning:

fs/btrfs/tree-log.c:6125:7: warning: Value stored to 'slot' during its
initialization is never read [clang-analyzer-deadcode.DeadStores].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/btrfs/tree-log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 9165486b554e..c083562a3334 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6122,7 +6122,7 @@ static int log_new_ancestors(struct btrfs_trans_handle *trans,
 	while (true) {
 		struct btrfs_fs_info *fs_info = root->fs_info;
 		struct extent_buffer *leaf = path->nodes[0];
-		int slot = path->slots[0];
+		int slot;
 		struct btrfs_key search_key;
 		struct inode *inode;
 		u64 ino;
-- 
2.20.1.7.g153144c

