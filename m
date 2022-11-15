Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400E862A0F8
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 19:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238424AbiKOSBz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 13:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbiKOSBM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 13:01:12 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224861092
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 10:01:07 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D34AD33688;
        Tue, 15 Nov 2022 18:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668535265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z03a08xyeEMLVwMbsWvdMMDA7ZqAQ5+EsgQ/J6+4MDM=;
        b=odgGQwKfcWkqOynvBCNE5qh+YvzBDpnal3DZ+CezrghH5t+sp1poJMM4prXs4v1dMv4SBx
        B6hKsN/7tloQmNLgzbKm6w57u0C/rVfyJ3A9ZG7t/8qkyaaLQAdphga6swC2jih/ovNPhb
        QGFAg1asCYDWxiBFNJXAeRxQlC74sP0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668535265;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z03a08xyeEMLVwMbsWvdMMDA7ZqAQ5+EsgQ/J6+4MDM=;
        b=p+WceA6jxlnor3lbz9bEqhN/gK/vUkZyIS3RScnJLPaiR62KcUMIsCdcF/2OxLcigGvSfm
        309z+IDpWfAxPgBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8C20E13A91;
        Tue, 15 Nov 2022 18:01:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id INI+GuHTc2O6ZAAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Tue, 15 Nov 2022 18:01:05 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 13/16] btrfs: writepage fixup lock rearrangement
Date:   Tue, 15 Nov 2022 12:00:31 -0600
Message-Id: <996e43b8178ba3e5f9db220cc9e5d437c3794f06.1668530684.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668530684.git.rgoldwyn@suse.com>
References: <cover.1668530684.git.rgoldwyn@suse.com>
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

Perform extent lock before pages while performing
writepage_fixup_worker.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/inode.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b421260d52e2..2806ef69122e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2909,6 +2909,7 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 	u64 page_end;
 	int ret = 0;
 	bool free_delalloc_space = true;
+	bool flushed = false;
 
 	fixup = container_of(work, struct btrfs_writepage_fixup, work);
 	page = fixup->page;
@@ -2920,9 +2921,16 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
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
@@ -2965,19 +2973,18 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
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
 		btrfs_start_ordered_extent(ordered, 1);
 		btrfs_put_ordered_extent(ordered);
+
 		goto again;
 	}
 
@@ -3000,7 +3007,6 @@ static void btrfs_writepage_fixup_worker(struct btrfs_work *work)
 	if (free_delalloc_space)
 		btrfs_delalloc_release_space(inode, data_reserved, page_start,
 					     PAGE_SIZE, true);
-	unlock_extent(&inode->io_tree, page_start, page_end, &cached_state);
 out_page:
 	if (ret) {
 		/*
-- 
2.35.3

