Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA4A4B61BD
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Feb 2022 04:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbiBODfT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Feb 2022 22:35:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiBODfT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Feb 2022 22:35:19 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCE6AD135;
        Mon, 14 Feb 2022 19:35:09 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V4WD7o9_1644896096;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V4WD7o9_1644896096)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Feb 2022 11:35:06 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     clm@fb.com
Cc:     josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] btrfs: Fix non-kernel-doc comment
Date:   Tue, 15 Feb 2022 11:34:54 +0800
Message-Id: <20220215033454.102725-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Fixes the following W=1 kernel build warning:

fs/btrfs/inode.c:3430: warning: This comment starts with '/**', but
isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Wait for flushing all delayed iputs.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e3fc83793df1..cf970832b929 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3426,7 +3426,7 @@ void btrfs_run_delayed_iputs(struct btrfs_fs_info *fs_info)
 	spin_unlock(&fs_info->delayed_iput_lock);
 }
 
-/**
+/*
  * Wait for flushing all delayed iputs
  *
  * @fs_info:  the filesystem
-- 
2.20.1.7.g153144c

