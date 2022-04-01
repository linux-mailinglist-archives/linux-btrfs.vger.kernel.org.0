Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E927E4EEC5D
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Apr 2022 13:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345501AbiDALZ5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Apr 2022 07:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345502AbiDALZx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Apr 2022 07:25:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE97195DB5
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 04:24:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F226721A97
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 11:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648812240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cGgKS8+zdxu4TqWjD5EXxsPP3PRCkZrK6D2fatichGI=;
        b=K8sizbz980BVF+HSr9rPzxNl/2f5AfZHWe9JvOD2Xlz9BNHr0aAWs0MzvmqwIaHalLrcdu
        PLZw2pdbs5reqApnA9R/hxWHQj1Rhv0uXF28wK9xHjCqxZrl29P/HH1/l5Wql6Mn9Ct/sV
        4NnFBxf+AciC8zp9vmegVVQoSjX7taE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5C304132C1
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 11:24:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SNcwCtDgRmJeFwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Apr 2022 11:24:00 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 11/16] btrfs: make raid56_add_scrub_pages() subpage compatible
Date:   Fri,  1 Apr 2022 19:23:26 +0800
Message-Id: <c5e3e0a462a0b0af79ffd5c017425249e7c36c79.1648807440.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648807440.git.wqu@suse.com>
References: <cover.1648807440.git.wqu@suse.com>
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

This requires one extra parameter @pgoff for the function.

In the current code base, scrub is still one page per sector, thus the
new parameter will always be 0.

It needs the extra subpage scrub optimization code to fully take
advantage.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 10 ++++++----
 fs/btrfs/raid56.h |  2 +-
 fs/btrfs/scrub.c  |  6 +++++-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 998c30867554..74e246f4758e 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2418,17 +2418,19 @@ struct btrfs_raid_bio *raid56_parity_alloc_scrub_rbio(struct bio *bio,
 
 /* Used for both parity scrub and missing. */
 void raid56_add_scrub_pages(struct btrfs_raid_bio *rbio, struct page *page,
-			    u64 logical)
+			    unsigned int pgoff, u64 logical)
 {
+	const u32 sectorsize = rbio->bioc->fs_info->sectorsize;
 	int stripe_offset;
 	int index;
 
 	ASSERT(logical >= rbio->bioc->raid_map[0]);
-	ASSERT(logical + PAGE_SIZE <= rbio->bioc->raid_map[0] +
+	ASSERT(logical + sectorsize <= rbio->bioc->raid_map[0] +
 				rbio->stripe_len * rbio->nr_data);
 	stripe_offset = (int)(logical - rbio->bioc->raid_map[0]);
-	index = stripe_offset >> PAGE_SHIFT;
-	rbio->bio_pages[index] = page;
+	index = stripe_offset / sectorsize;
+	rbio->bio_sectors[index].page = page;
+	rbio->bio_sectors[index].pgoff = pgoff;
 }
 
 /*
diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
index 72c00fc284b5..c52cf690bd9e 100644
--- a/fs/btrfs/raid56.h
+++ b/fs/btrfs/raid56.h
@@ -36,7 +36,7 @@ int raid56_parity_write(struct bio *bio, struct btrfs_io_context *bioc,
 			u64 stripe_len);
 
 void raid56_add_scrub_pages(struct btrfs_raid_bio *rbio, struct page *page,
-			    u64 logical);
+			    unsigned int pgoff, u64 logical);
 
 struct btrfs_raid_bio *raid56_parity_alloc_scrub_rbio(struct bio *bio,
 				struct btrfs_io_context *bioc, u64 stripe_len,
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 3f073d80755a..66ca71a4e570 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2222,7 +2222,11 @@ static void scrub_missing_raid56_pages(struct scrub_block *sblock)
 	for (i = 0; i < sblock->sector_count; i++) {
 		struct scrub_sector *sector = sblock->sectors[i];
 
-		raid56_add_scrub_pages(rbio, sector->page, sector->logical);
+		/*
+		 * For now, our scrub is still one page per-sector, so pgoff
+		 * is always 0.
+		 */
+		raid56_add_scrub_pages(rbio, sector->page, 0, sector->logical);
 	}
 
 	btrfs_init_work(&sblock->work, scrub_missing_raid56_worker, NULL, NULL);
-- 
2.35.1

