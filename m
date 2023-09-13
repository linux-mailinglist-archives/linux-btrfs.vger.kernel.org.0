Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA13E79E3FB
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Sep 2023 11:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239360AbjIMJnm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Sep 2023 05:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239011AbjIMJnl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Sep 2023 05:43:41 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D1C196;
        Wed, 13 Sep 2023 02:43:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vs-FEgu_1694598210;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Vs-FEgu_1694598210)
          by smtp.aliyun-inc.com;
          Wed, 13 Sep 2023 17:43:34 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] btrfs: Remove some unused functions
Date:   Wed, 13 Sep 2023 17:43:27 +0800
Message-Id: <20230913094327.98852-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

These functions are defined in the qgroup.c file, but not called
elsewhere, so delete these unused functions.

fs/btrfs/qgroup.c:149:19: warning: unused function 'qgroup_to_aux'.
fs/btrfs/qgroup.c:154:36: warning: unused function 'unode_aux_to_qgroup'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6566
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/btrfs/qgroup.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index a51f1ceb867a..d977c4f109fc 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -146,16 +146,6 @@ struct btrfs_qgroup_list {
 	struct btrfs_qgroup *member;
 };
 
-static inline u64 qgroup_to_aux(struct btrfs_qgroup *qg)
-{
-	return (u64)(uintptr_t)qg;
-}
-
-static inline struct btrfs_qgroup* unode_aux_to_qgroup(struct ulist_node *n)
-{
-	return (struct btrfs_qgroup *)(uintptr_t)n->aux;
-}
-
 static int
 qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 		   int init_flags);
-- 
2.20.1.7.g153144c

