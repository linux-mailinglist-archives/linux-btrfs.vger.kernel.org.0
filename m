Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8EFB485571
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 16:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbiAEPIQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jan 2022 10:08:16 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:42899 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230413AbiAEPIO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jan 2022 10:08:14 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V11dny9_1641395280;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V11dny9_1641395280)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 05 Jan 2022 23:08:12 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        chongjiapeng <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH v2] btrfs: Remove redundant assignment of slot and leaf
Date:   Wed,  5 Jan 2022 23:07:58 +0800
Message-Id: <20220105150758.29670-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: chongjiapeng <jiapeng.chong@linux.alibaba.com>

slot and leaf are being initialized to path->slots[0] and
path->nodes[0], but this is never read as slot and leaf
is overwritten later on. Remove the redundant assignment.

Cleans up the following clang-analyzer warning:

fs/btrfs/tree-log.c:6125:7: warning: Value stored to 'slot' during its
initialization is never read [clang-analyzer-deadcode.DeadStores].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: chongjiapeng <jiapeng.chong@linux.alibaba.com>
---
Changes in v2:
  -Remove redundant assignment of leaf.

 fs/btrfs/tree-log.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 4b89ac769347..d99cda0acd95 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6188,8 +6188,6 @@ static int log_new_ancestors(struct btrfs_trans_handle *trans,
 		if (ret < 0)
 			return ret;
 
-		leaf = path->nodes[0];
-		slot = path->slots[0];
 		if (slot >= btrfs_header_nritems(leaf)) {
 			ret = btrfs_next_leaf(root, path);
 			if (ret < 0)
-- 
2.19.1.6.gb485710b

