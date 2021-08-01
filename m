Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308A73DCE1D
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Aug 2021 01:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbhHAXf5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 Aug 2021 19:35:57 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58702 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhHAXf5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 Aug 2021 19:35:57 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A446521F93;
        Sun,  1 Aug 2021 23:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627860947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=bmgIxwdkOjYwYHaC5CmaXj9eSFk7eNGjfkjm5sCkh98=;
        b=aDEjSn4TS6ZC+gVQLPxnIvn9FC8FQDP9TjzJ9EbFGUUA0shvJ4rLJatoxbJycMSIMnEZ21
        YA11HGotEV0TmGgjL/dVJN3Oo+oFAaDV7uz7TiEUWi0FiyVenGmHLFpCdksI/VtucQu/zr
        BogWV08jTM5FcKNA0V8MKSJoU6z1bFM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 50B5F1345F;
        Sun,  1 Aug 2021 23:35:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qgJnBtIvB2HEOAAAMHmgww
        (envelope-from <mpdesouza@suse.com>); Sun, 01 Aug 2021 23:35:46 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, fdmanana@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH] btrfs: send: Simplify send_create_inode_if_needed
Date:   Sun,  1 Aug 2021 20:35:49 -0300
Message-Id: <20210801233549.25480-1-mpdesouza@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The out label is being overused, we can simply return if the condition
permits.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/send.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 75cff564dedf..17cd67e41d3a 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -2727,19 +2727,12 @@ static int send_create_inode_if_needed(struct send_ctx *sctx)
 	if (S_ISDIR(sctx->cur_inode_mode)) {
 		ret = did_create_dir(sctx, sctx->cur_ino);
 		if (ret < 0)
-			goto out;
-		if (ret) {
-			ret = 0;
-			goto out;
-		}
+			return ret;
+		if (ret > 0)
+			return 0;
 	}
 
-	ret = send_create_inode(sctx, sctx->cur_ino);
-	if (ret < 0)
-		goto out;
-
-out:
-	return ret;
+	return send_create_inode(sctx, sctx->cur_ino);
 }
 
 struct recorded_ref {
-- 
2.26.2

