Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEEC6005D5
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 05:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbiJQDwi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Oct 2022 23:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbiJQDwg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Oct 2022 23:52:36 -0400
Received: from out20-219.mail.aliyun.com (out20-219.mail.aliyun.com [115.124.20.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403485209A
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Oct 2022 20:52:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04452334|-1;BR=01201311R151S91rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0282229-0.00151095-0.970266;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047203;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.PeST1Ts_1665978751;
Received: from T640.e16-tech.com(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.PeST1Ts_1665978751)
          by smtp.aliyun-inc.com;
          Mon, 17 Oct 2022 11:52:31 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Wang Yugui <wangyugui@e16-tech.com>
Subject: [PATCH] btrfs-progs: send: sync splice buf size with kernel when proto 2
Date:   Mon, 17 Oct 2022 11:52:31 +0800
Message-Id: <20221017035231.51112-1-wangyugui@e16-tech.com>
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

When 'btrfs send --proto 2', the max buffer in kernel is changed from
BTRFS_SEND_BUF_SIZE_V1(SZ_64K) to (SZ_16K + BTRFS_MAX_COMPRESSED).

The performance is improved when we use the same buf size in btrfs-progs.
without this patch: 57.96s
with this patch: 48.44s

bigger buf size(SZ_512K) is tested too. but it help 'btrfs send --proto 2' /
'btrfs send --proto 1' just little. so we will not use bigger buffer.

Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
---
 cmds/send.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/cmds/send.c b/cmds/send.c
index ec61aaf4..d18a31a1 100644
--- a/cmds/send.c
+++ b/cmds/send.c
@@ -37,7 +37,10 @@
 #include "cmds/commands.h"
 #include "ioctl.h"
 
-#define SEND_BUFFER_SIZE	SZ_64K
+#define BTRFS_SEND_BUF_SIZE_V1	(SZ_64K)
+#define BTRFS_MAX_COMPRESSED	(SZ_128K)
+#define BTRFS_SEND_BUF_SIZE_V2	(SZ_16K + BTRFS_MAX_COMPRESSED)
+
 
 struct btrfs_send {
 	int send_fd;
@@ -201,11 +204,18 @@ static void *read_sent_data(void *arg)
 	struct btrfs_send *sctx = (struct btrfs_send*)arg;
 
 	while (1) {
+		size_t splice_buf_size = BTRFS_SEND_BUF_SIZE_V1;
 		ssize_t sbytes;
 
+		if(sctx->proto > 1){
+			splice_buf_size = BTRFS_SEND_BUF_SIZE_V2;
+
+			/* try to change pipe buffer size */
+			fcntl(sctx->dump_fd, F_SETPIPE_SZ, splice_buf_size);
+		}
 		/* Source is a pipe, output is either file or stdout */
 		sbytes = splice(sctx->send_fd, NULL, sctx->dump_fd,
-				NULL, SEND_BUFFER_SIZE, SPLICE_F_MORE);
+				NULL, splice_buf_size, SPLICE_F_MORE);
 		if (sbytes < 0) {
 			ret = -errno;
 			error("failed to read stream from kernel: %m");
@@ -261,6 +271,9 @@ static int do_send(struct btrfs_send *send, u64 parent_root_id,
 		 */
 		io_send.version = send->proto;
 		io_send.flags |= BTRFS_SEND_FLAG_VERSION;
+
+		fcntl(pipefd[0], F_SETPIPE_SZ, BTRFS_SEND_BUF_SIZE_V2);
+		fcntl(pipefd[1], F_SETPIPE_SZ, BTRFS_SEND_BUF_SIZE_V2);
 	}
 
 	if (!ret)
-- 
2.36.2

