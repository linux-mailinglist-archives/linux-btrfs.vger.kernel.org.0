Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7653A4C2BB9
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Feb 2022 13:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbiBXM3a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Feb 2022 07:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbiBXM3Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Feb 2022 07:29:25 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA67269AAC
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Feb 2022 04:28:54 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1B89021155;
        Thu, 24 Feb 2022 12:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645705733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T5ulqCZi825YATFHCgWBmh8z9ETSPkh7Wmvh7vrmUR8=;
        b=bRjG14vxFscrbhWQjeUn4xxJZ4k5YSzBz52QVFlSlIujedQiy+M7kJOkK72amClr9dwCxl
        g9rSx5JL5PgSMDbAsynHuzP5uJSMfgzqH0okucnZ/IiFq545cu50ipzmewQm6XIzvfJYqj
        hA66Q+TfFsb5uYybrl1gk4ASkO9esPw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A5B613AD9;
        Thu, 24 Feb 2022 12:28:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YDZFOAN6F2LhAgAAMHmgww
        (envelope-from <wqu@suse.com>); Thu, 24 Feb 2022 12:28:51 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 6/7] btrfs: defrag: make btrfs_defrag_file() to report accurate number of defragged sectors
Date:   Thu, 24 Feb 2022 20:28:40 +0800
Message-Id: <cb6f80fe54933794d484bb029bee78c7f60354b1.1645705266.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1645705266.git.wqu@suse.com>
References: <cover.1645705266.git.wqu@suse.com>
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
index 72d157b89a17..1f0bf6181013 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1652,6 +1652,8 @@ static int defrag_one_range(struct btrfs_inode *inode,
 					       &cached_state);
 		if (ret < 0)
 			break;
+		ctrl->sectors_defragged += entry->len >>
+					   inode->root->fs_info->sectorsize_bits;
 	}
 
 	list_for_each_entry_safe(entry, tmp, &target_list, list) {
@@ -1716,17 +1718,9 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
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
2.35.1

