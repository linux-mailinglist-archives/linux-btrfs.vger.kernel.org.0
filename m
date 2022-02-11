Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4586B4B1EA6
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 07:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345198AbiBKGmL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Feb 2022 01:42:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345015AbiBKGmJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Feb 2022 01:42:09 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6242E108B
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 22:42:09 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 24E2D21138;
        Fri, 11 Feb 2022 06:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644561728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mZE8Iqaeq3bs+mhfV1N6jiApcQczsS86dnG0MLU7BWY=;
        b=ma3NDKrFtVQxcliNNikFIONsF3wYsOrwoItVY7+Y8SGGypQxCpRq2/pQ59LWVaU30uWK52
        bj2Jwj0i/o/e1VxM95ZU9NbAsZ25Ock5JPNSGrNrpy++wG9RmkLQNTaDB44rlG+GnU6jSA
        M84zbfFfDrAnXt52g2qQ23YH1qKKbQQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4818F13345;
        Fri, 11 Feb 2022 06:42:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oKtFBT8FBmLmUAAAMHmgww
        (envelope-from <wqu@suse.com>); Fri, 11 Feb 2022 06:42:07 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v4 5/5] btrfs: defrag: make btrfs_defrag_file() to report accurate number of defragged sectors
Date:   Fri, 11 Feb 2022 14:41:43 +0800
Message-Id: <9c89c78e2afeaee2cb8461753ab46c65fb505f2c.1644561438.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <cover.1644561438.git.wqu@suse.com>
References: <cover.1644561438.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Previously rework btrfs_defrag_file() can only report the number of
sectors from the first run of defrag_collect_targets().

This number is not accurate as if holes are punched after the first
defrag_collect_targets() call, we will not choose to defrag the holes.

Originally this is to avoid passing @sectors_defragged to every involved
functions.

But now since we have btrfs_defrag_ctrl, there is no need to do such
inaccurate accounting, just update btrfs_defrag_ctrl::sectors_defragged
after a successful defrag_one_locked_target() call.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ioctl.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 28c81ac7b837..e49f745af942 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1471,6 +1471,8 @@ static int defrag_one_range(struct btrfs_inode *inode,
 					       &cached_state);
 		if (ret < 0)
 			break;
+		ctrl->sectors_defragged += entry->len >>
+					   inode->root->fs_info->sectorsize_bits;
 	}
 
 	list_for_each_entry_safe(entry, tmp, &target_list, list) {
@@ -1535,17 +1537,9 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
 				ra, NULL, entry->start >> PAGE_SHIFT,
 				((entry->start + range_len - 1) >> PAGE_SHIFT) -
 				(entry->start >> PAGE_SHIFT) + 1);
-		/*
-		 * Here we may not defrag any range if holes are punched before
-		 * we locked the pages.
-		 * But that's fine, it only affects the @sectors_defragged
-		 * accounting.
-		 */
 		ret = defrag_one_range(inode, ctrl, entry->start, range_len);
 		if (ret < 0)
 			break;
-		ctrl->sectors_defragged += range_len >>
-					   inode->root->fs_info->sectorsize_bits;
 	}
 out:
 	list_for_each_entry_safe(entry, tmp, &target_list, list) {
-- 
2.35.0

