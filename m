Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2948B4AA6FA
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Feb 2022 06:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241659AbiBEFs4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Feb 2022 00:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238376AbiBEFsy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Feb 2022 00:48:54 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F63C061353
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 21:48:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 41EC41F38F;
        Sat,  5 Feb 2022 05:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644039689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=02L0HoLtMSHPOcKXdiN6lIKkZ87naoBB2uiW42uGWl4=;
        b=TVZZdQxZyB6/4cBQyUjsbSnRKzmVyUnO6ZsV435oJS+uh9m/sJL8qegNReD85Y3v504a5S
        j6XLb5tFUA11e7uXqaV83BJb71pq/dM+ItK/lPZRsopaTUDt+9N/RSbYBFKqK3OEP0YhHx
        a2VNsK8T4wVO4ropSiGkWfeVhvxBtZc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 665F413A6D;
        Sat,  5 Feb 2022 05:41:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WGOmDAgO/mFCQAAAMHmgww
        (envelope-from <wqu@suse.com>); Sat, 05 Feb 2022 05:41:28 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v3 4/5] btrfs: defrag: make btrfs_defrag_file() to report accurate number of defragged sectors
Date:   Sat,  5 Feb 2022 13:41:05 +0800
Message-Id: <d5ba94597c9462a6fe60db64dd51dd6dafef6748.1644039495.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <cover.1644039494.git.wqu@suse.com>
References: <cover.1644039494.git.wqu@suse.com>
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
 fs/btrfs/ioctl.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index e100305d8bc2..fb991a8f3929 100644
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

