Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959025F7AAC
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Oct 2022 17:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiJGPkf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Oct 2022 11:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJGPke (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Oct 2022 11:40:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017C3816BC
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Oct 2022 08:40:32 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8682621874;
        Fri,  7 Oct 2022 15:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665157231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=BoHyNG0KG9f5YLceLKv9Q1ouDvwOyQ/8ZehwDCMiEic=;
        b=tkXSc0Zu7qTHP8Jl6W4oKpIQ8WirPQQvKy7UN3wLKjHwyGQNStuc50TVvkDnuxbINWZ/Va
        NK6BEjKoP+lbaerNdUfjhNzj+jVQbNDpy/EpkU5NvIbCw2mJVPW1lEZJCBw57sYGhDOb+9
        PMkn8nKNoJdcWPCpataGhkFsvDO0SwM=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 6EF432C141;
        Fri,  7 Oct 2022 15:40:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 51C85DA8E0; Fri,  7 Oct 2022 17:40:29 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     boris@bur.io, David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: send: update command for protocol version check
Date:   Fri,  7 Oct 2022 17:40:25 +0200
Message-Id: <20221007154025.13949-1-dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For a protocol and command compatibility we have a helper that hasn't
been updated for v3 yet. We use it for verity so update where necessary.

Fixes: 38622010a6de ("btrfs: send: add support for fs-verity")
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/send.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 178347666235..ec6e1752af2c 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -348,6 +348,7 @@ static bool proto_cmd_ok(const struct send_ctx *sctx, int cmd)
 	switch (sctx->proto) {
 	case 1:	 return cmd <= BTRFS_SEND_C_MAX_V1;
 	case 2:	 return cmd <= BTRFS_SEND_C_MAX_V2;
+	case 3:	 return cmd <= BTRFS_SEND_C_MAX_V3;
 	default: return false;
 	}
 }
@@ -6469,7 +6470,9 @@ static int finish_inode_if_needed(struct send_ctx *sctx, int at_end)
 		if (ret < 0)
 			goto out;
 	}
-	if (sctx->proto >= 3 && sctx->cur_inode_needs_verity) {
+
+	if (proto_cmd_ok(sctx, BTRFS_SEND_C_ENABLE_VERITY)
+	    && sctx->cur_inode_needs_verity) {
 		ret = process_verity(sctx);
 		if (ret < 0)
 			goto out;
-- 
2.37.3

