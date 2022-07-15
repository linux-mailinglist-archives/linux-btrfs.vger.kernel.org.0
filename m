Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C4F575BE5
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jul 2022 08:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiGOG6M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jul 2022 02:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGOG6K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jul 2022 02:58:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5FF501BD
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jul 2022 23:58:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 66A741F988
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 06:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657868287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=phoWH/vHTrpFa9cAu7LH8fa7G6ZQCN95EC+LpXMtgdk=;
        b=KHGe5uS4UcFZRBhT5u2CMfPCBsKdc32uH9Jzjr33ptz06y3ke0nOH9RMy/QT3SbaDXKst8
        gEqWqvGiOcvmR25u9aWeU1ZYfLf/IDWH70z+4HzXnTTwRW0u4blI007rXLYJjiKL8Fj1me
        h24n3fxoeu53DRHfbtNjkRaJhXdyGDc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A372E13754
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 06:58:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oOKjGv4P0WKtfQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 06:58:06 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs: output human readable space info flag
Date:   Fri, 15 Jul 2022 14:57:44 +0800
Message-Id: <6fbb3ccbdfba08c675b72bef60ae6ce38cb6fce1.1657867842.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1657867842.git.wqu@suse.com>
References: <cover.1657867842.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For btrfs_space_info, its flags has only 4 possible values:
- BTRFS_BLOCK_GROUP_SYSTEM
- BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_DATA
- BTRFS_BLOCK_GROUP_METADATA
- BTRFS_BLOCK_GROUP_DATA

Thus do debuggers a favor by output a human readable flags in
__btrfs_dump_space_info().

Now the summary line of __btrfs_dump_space_info() looks like:

 BTRFS info (device dm-1: state A): space_info META has 251494400 free, is not full

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/space-info.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 62d25112310d..36b466525318 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -450,14 +450,29 @@ do {									\
 	spin_unlock(&__rsv->lock);					\
 } while (0)
 
+static const char *space_info_flag_to_str(struct btrfs_space_info *space_info)
+{
+	if (space_info->flags == BTRFS_BLOCK_GROUP_SYSTEM)
+		return "SYS";
+
+	/* Handle mixed data+metadata first. */
+	if (space_info->flags == (BTRFS_BLOCK_GROUP_METADATA |
+				  BTRFS_BLOCK_GROUP_DATA))
+		return "DATA+META";
+	if (space_info->flags == BTRFS_BLOCK_GROUP_DATA)
+		return "DATA";
+	return "META";
+}
+
 static void __btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
 				    struct btrfs_space_info *info)
 {
+	const char *flag_str = space_info_flag_to_str(info);
 	lockdep_assert_held(&info->lock);
 
 	/* The free space could be negative in case of overcommit */
-	btrfs_info(fs_info, "space_info %llu has %lld free, is %sfull",
-		   info->flags,
+	btrfs_info(fs_info, "space_info %s has %lld free, is %sfull",
+		   flag_str,
 		   (s64)(info->total_bytes - btrfs_space_info_used(info, true)),
 		   info->full ? "" : "not ");
 	btrfs_info(fs_info,
-- 
2.37.0

