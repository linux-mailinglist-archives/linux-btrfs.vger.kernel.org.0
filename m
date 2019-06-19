Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7B64BAB3
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 16:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbfFSOEs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 10:04:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:42886 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729463AbfFSOEo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 10:04:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4F48BAD7C
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2019 14:04:43 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 3/4] btrfs: Remove old send implementation
Date:   Wed, 19 Jun 2019 17:04:39 +0300
Message-Id: <20190619140440.5550-4-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190619140440.5550-1-nborisov@suse.com>
References: <20190619140440.5550-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit ba23855cdc89 ("btrfs-progs: send: use splice syscall instead of
read/write to transfer buffer") changed the send implementation to use
splice(). The old read/write implementation hasn't be used for at least
3 years, it's time to remove it.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 cmds-send.c | 61 -----------------------------------------------------
 1 file changed, 61 deletions(-)

diff --git a/cmds-send.c b/cmds-send.c
index 6496d8e39bbf..1735c35dca74 100644
--- a/cmds-send.c
+++ b/cmds-send.c
@@ -207,67 +207,6 @@ static int add_clone_source(struct btrfs_send *sctx, u64 root_id)
 	return 0;
 }
 
-#if 0
-static int write_buf(int fd, const char *buf, size_t size)
-{
-	int ret;
-	size_t pos = 0;
-
-	while (pos < size) {
-		ssize_t wbytes;
-
-		wbytes = write(fd, buf + pos, size - pos);
-		if (wbytes < 0) {
-			ret = -errno;
-			error("failed to dump stream: %s", strerror(-ret));
-			goto out;
-		}
-		if (!wbytes) {
-			ret = -EIO;
-			error("failed to dump stream: %s", strerror(-ret));
-			goto out;
-		}
-		pos += wbytes;
-	}
-	ret = 0;
-
-out:
-	return ret;
-}
-
-static void* read_sent_data_copy(void *arg)
-{
-	int ret;
-	struct btrfs_send *sctx = (struct btrfs_send*)arg;
-	char buf[SEND_BUFFER_SIZE];
-
-	while (1) {
-		ssize_t rbytes;
-
-		rbytes = read(sctx->send_fd, buf, sizeof(buf));
-		if (rbytes < 0) {
-			ret = -errno;
-			error("failed to read stream from kernel: %s",
-				strerror(-ret));
-			goto out;
-		}
-		if (!rbytes) {
-			ret = 0;
-			goto out;
-		}
-		ret = write_buf(sctx->dump_fd, buf, rbytes);
-		if (ret < 0)
-			goto out;
-	}
-
-out:
-	if (ret < 0)
-		exit(-ret);
-
-	return ERR_PTR(ret);
-}
-#endif
-
 static void *read_sent_data(void *arg)
 {
 	int ret;
-- 
2.17.1

