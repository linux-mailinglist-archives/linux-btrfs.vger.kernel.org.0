Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B82762A0F6
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 19:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237647AbiKOSBx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 13:01:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238341AbiKOSBM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 13:01:12 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB38C10AE
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 10:01:00 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A33AE33688;
        Tue, 15 Nov 2022 18:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668535259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m1S9aFMQgZSYdBscg33X+SuuffT4OeQntDrE+719T5g=;
        b=y3Pcok3KHoxrF/lXKuNqsQnliJgVLU7T3SW+nZmMqT93jwRfZe3ztIVqmsVETWpXm8es6j
        Dy3awhZRYpGK03d0/VipBEvbcuTYmubvu4jIwz3JTyoaHEadMVZpQ5iuEk+tegU+Ytg9c/
        omjTTev0adf1oDgtQEhQjKyuHbrfVZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668535259;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m1S9aFMQgZSYdBscg33X+SuuffT4OeQntDrE+719T5g=;
        b=EMoDjGiEDamFEdBqROVOUUrx4kJ6SrQTamq7ObuMLAFDa4UApUDaJJxGjpobB+RKL+HaZz
        lIwoM0IoW2ienNAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5BF9313A91;
        Tue, 15 Nov 2022 18:00:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YRQ5DtvTc2OuZAAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Tue, 15 Nov 2022 18:00:59 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 10/16] btrfs: decide early if range should be async
Date:   Tue, 15 Nov 2022 12:00:28 -0600
Message-Id: <a822dc88a07268a9472823a77f17ee2384408e81.1668530684.git.rgoldwyn@suse.com>
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

This sets the async bit early in the writeback and uses it to decide if
it should write asynchronously.

Since there could be missing pages, check if page is NULL while
performing heuristics.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/compression.c |  4 ++++
 fs/btrfs/inode.c       | 11 +++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 7f6452c4234e..09b846a516ed 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -1610,6 +1610,10 @@ static void heuristic_collect_sample(struct inode *inode, u64 start, u64 end,
 	curr_sample_pos = 0;
 	while (index < index_end) {
 		page = find_get_page(inode->i_mapping, index);
+		if (!page) {
+			index++;
+			continue;
+		}
 		in_data = kmap_local_page(page);
 		/* Handle case where the start is not aligned to PAGE_SIZE */
 		i = start % PAGE_SIZE;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index aa393219019b..070fb7071e39 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2264,8 +2264,7 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 		ASSERT(!zoned || btrfs_is_data_reloc_root(inode->root));
 		ret = run_delalloc_nocow(inode, locked_page, start, end,
 					 page_started, nr_written);
-	} else if (!btrfs_inode_can_compress(inode) ||
-		   !inode_need_compress(inode, start, end)) {
+	} else if (!test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT, &inode->runtime_flags)) {
 		if (zoned)
 			ret = run_delalloc_zoned(inode, locked_page, start, end,
 						 page_started, nr_written);
@@ -2273,7 +2272,6 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct page *locked_page
 			ret = cow_file_range(inode, locked_page, start, end,
 					     page_started, nr_written, 1, NULL);
 	} else {
-		set_bit(BTRFS_INODE_HAS_ASYNC_EXTENT, &inode->runtime_flags);
 		ret = cow_file_range_async(inode, wbc, locked_page, start, end,
 					   page_started, nr_written);
 	}
@@ -8257,9 +8255,14 @@ static int btrfs_writepages(struct address_space *mapping,
 	 */
 	async_wb = btrfs_inode_can_compress(inode) &&
 		   inode_need_compress(inode, start, end);
-	if (!async_wb)
+
+	if (async_wb)
+		set_bit(BTRFS_INODE_HAS_ASYNC_EXTENT, &inode->runtime_flags);
+	else
 		lock_extent(&inode->io_tree, start, end, &cached);
+
 	ret = extent_writepages(mapping, wbc);
+
 	if (!async_wb)
 		unlock_extent(&inode->io_tree, start, end, &cached);
 
-- 
2.35.3

