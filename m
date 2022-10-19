Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC677603B25
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Oct 2022 10:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiJSIKJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Oct 2022 04:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJSIKH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Oct 2022 04:10:07 -0400
Received: from out20-181.mail.aliyun.com (out20-181.mail.aliyun.com [115.124.20.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A22238A2B
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 01:10:03 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0644935|-1;BR=01201311R901S78rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00468577-0.000173471-0.995141;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047194;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.PhKR7Pa_1666167001;
Received: from T640.e16-tech.com(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.PhKR7Pa_1666167001)
          by smtp.aliyun-inc.com;
          Wed, 19 Oct 2022 16:10:01 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Wang Yugui <wangyugui@e16-tech.com>
Subject: [PATCH] btrfs: add macro BTRFS_SEND_BUF_SIZE_V2
Date:   Wed, 19 Oct 2022 16:10:01 +0800
Message-Id: <20221019081001.58288-1-wangyugui@e16-tech.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a macro BTRFS_SEND_BUF_SIZE_V2 and save it just after
BTRFS_SEND_BUF_SIZE_V1.

This is a refactor without any function change.

Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
---
 fs/btrfs/send.c | 2 +-
 fs/btrfs/send.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index ec6e1752af2c..d7eabff2c0b7 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7877,7 +7877,7 @@ long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 	if (sctx->proto >= 2) {
 		u32 send_buf_num_pages;
 
-		sctx->send_max_size = ALIGN(SZ_16K + BTRFS_MAX_COMPRESSED, PAGE_SIZE);
+		sctx->send_max_size = BTRFS_SEND_BUF_SIZE_V2;
 		sctx->send_buf = vmalloc(sctx->send_max_size);
 		if (!sctx->send_buf) {
 			ret = -ENOMEM;
diff --git a/fs/btrfs/send.h b/fs/btrfs/send.h
index f7585cfa7e52..22f055256408 100644
--- a/fs/btrfs/send.h
+++ b/fs/btrfs/send.h
@@ -21,7 +21,8 @@
  * In send stream v1, no command is larger than 64K. In send stream v2, no limit
  * should be assumed.
  */
-#define BTRFS_SEND_BUF_SIZE_V1				SZ_64K
+#define BTRFS_SEND_BUF_SIZE_V1	SZ_64K
+#define BTRFS_SEND_BUF_SIZE_V2	ALIGN(SZ_16K + BTRFS_MAX_COMPRESSED, PAGE_SIZE)
 
 struct inode;
 struct btrfs_ioctl_send_args;
-- 
2.36.2

