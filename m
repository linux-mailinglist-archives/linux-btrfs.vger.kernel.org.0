Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CB64A94E4
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 09:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344301AbiBDINS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 03:13:18 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:42934 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343500AbiBDINR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Feb 2022 03:13:17 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BD2231F382
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 08:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643962396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=exKzlu2eFMSBeJvECIuDLSzT9zMRII0X4/7ePm9mHDI=;
        b=V5EfZShkYk0M0HHWDxMrqnEwz7lYqGckDOGt8Hc0w1tzoPDeo9CVAXDN/49p8vkyqv/84r
        oc087aja0gF4+YpulM1mwQV7iSx0heOQJxC8JCMtNK8Yl3f7twTx89og4j68RpHaTAtoDS
        A6Caq3olCh6wtE4Dduz1klwQKn6PX3Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E249132DB
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 08:13:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sDGcNhvg/GFUVwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Feb 2022 08:13:15 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/5] btrfs: defrag: make btrfs_defrag_file() to report accurate number of defragged sectors
Date:   Fri,  4 Feb 2022 16:11:58 +0800
Message-Id: <8d7f2e73c9d1b2e6b09d50143beede820e5473c2.1643961719.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <cover.1643961719.git.wqu@suse.com>
References: <cover.1643961719.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
---
 fs/btrfs/ioctl.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index c183c37e2127..567a662df118 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1371,7 +1371,7 @@ static int defrag_one_locked_target(struct btrfs_inode *inode,
 }
 
 static int defrag_one_range(struct btrfs_inode *inode,
-			    const struct btrfs_defrag_ctrl *ctrl,
+			    struct btrfs_defrag_ctrl *ctrl,
 			    u64 start, u32 len)
 {
 	struct extent_state *cached_state = NULL;
@@ -1426,6 +1426,8 @@ static int defrag_one_range(struct btrfs_inode *inode,
 					       &cached_state);
 		if (ret < 0)
 			break;
+		ctrl->sectors_defragged += entry->len >>
+					  inode->root->fs_info->sectorsize_bits;
 	}
 
 	list_for_each_entry_safe(entry, tmp, &target_list, list) {
@@ -1489,17 +1491,9 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
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
-					  inode->root->fs_info->sectorsize_bits;
 	}
 out:
 	list_for_each_entry_safe(entry, tmp, &target_list, list) {
-- 
2.35.0

