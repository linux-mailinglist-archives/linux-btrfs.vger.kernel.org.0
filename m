Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3496A8BBE
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 23:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjCBWZj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 17:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjCBWZi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 17:25:38 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C511EBDC
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 14:25:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 976882006A;
        Thu,  2 Mar 2023 22:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677795936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rXW5FQGj9VNsz5SGumcDH4TmXBqBNvJ99X65t2v1X8c=;
        b=ezSeHnC8Ku0zTh9IHE7Gdd2MfSw16PiuVE/+/bOK6U9pEbKgC5BlTPMoznPGgv8yIv4jnS
        hA4kDCXhcRMlM98DWdtEHCQf2uhHJ5hdSSzo1or2W6e1WdlgcIYBoGtalnKFTiyvUwTviC
        dZy7elLAcN0X2aMNbAClRWMNnQl7gH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677795936;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rXW5FQGj9VNsz5SGumcDH4TmXBqBNvJ99X65t2v1X8c=;
        b=LouYuMCE95ipcXvQAJ6JrPQW+QXnDpR/iKA5qgjfrHuKu2mstk/xXTi9gnwLuPXwP7nAjr
        wk37I6rWL5KerrDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5358A13349;
        Thu,  2 Mar 2023 22:25:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id axXtDGAiAWTVSQAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Thu, 02 Mar 2023 22:25:36 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 14/21] btrfs: writepage fixup lock rearrangement
Date:   Thu,  2 Mar 2023 16:24:59 -0600
Message-Id: <0513454915b54ca4572e30c5d42915fa987ad245.1677793433.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1677793433.git.rgoldwyn@suse.com>
References: <cover.1677793433.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Perform extent lock before pages while performing
writepage_fixup_worker.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ed3553ff2c31..f879c65ee8cc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2722,6 +2722,7 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 	u64 page_end;
 	int ret = 0;
 	bool free_delalloc_space = true;
+	bool flushed = false;
 
 	fixup = container_of(work, struct btrfs_writepage_fixup, work);
 	page = fixup->page;
@@ -2733,9 +2734,16 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 	 * This is similar to page_mkwrite, we need to reserve the space before
 	 * we take the page lock.
 	 */
+reserve:
 	ret = btrfs_delalloc_reserve_space(inode, &data_reserved, page_start,
 					   PAGE_SIZE);
+	if (ret == -EDQUOT && !flushed) {
+		btrfs_qgroup_flush(inode->root);
+		flushed = true;
+		goto reserve;
+	}
 again:
+	lock_extent(&inode->io_tree, page_start, page_end, NULL);
 	lock_page(page);
 
 	/*
@@ -2778,19 +2786,18 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 	if (ret)
 		goto out_page;
 
-	lock_extent(&inode->io_tree, page_start, page_end, &cached_state);
-
 	/* already ordered? We're done */
 	if (PageOrdered(page))
 		goto out_reserved;
 
 	ordered = btrfs_lookup_ordered_range(inode, page_start, PAGE_SIZE);
 	if (ordered) {
-		unlock_extent(&inode->io_tree, page_start, page_end,
-			      &cached_state);
 		unlock_page(page);
+		unlock_extent(&inode->io_tree, page_start, page_end,
+			      NULL);
 		btrfs_start_ordered_extent(ordered);
 		btrfs_put_ordered_extent(ordered);
+
 		goto again;
 	}
 
@@ -2813,7 +2820,6 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 	if (free_delalloc_space)
 		btrfs_delalloc_release_space(inode, data_reserved, page_start,
 					     PAGE_SIZE, true);
-	unlock_extent(&inode->io_tree, page_start, page_end, &cached_state);
 out_page:
 	if (ret) {
 		/*
-- 
2.39.2

