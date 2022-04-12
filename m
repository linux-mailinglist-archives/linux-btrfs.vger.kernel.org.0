Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61604FDCB7
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Apr 2022 13:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352792AbiDLKiV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Apr 2022 06:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354236AbiDLKdi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Apr 2022 06:33:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1FC5B3E6
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 02:33:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7931F1F868
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649756008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vdEIW+dERhtnPCEpETDl1BkasADb+RZg7Bj1YnQPZQo=;
        b=HtG6wawy8TCF3n7ysjf8/XOFV9V4zj6qeG4rkIffm9YxUPCVlkyobaLEwyEu2Lyhc+VCew
        bl6nf3Tn/ItK4j1v+F/y+ekb6/PbYbeJTukbS0ea8M+7WiyVbbYGhHxjsnKVIKHWqaqW+o
        8QrJgmVnwAxjuk6Xyv71hJYw1r9st5s=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C0CED13A99
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oOrLIWdHVWI8LwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:27 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 02/17] btrfs: open-code rbio_nr_pages()
Date:   Tue, 12 Apr 2022 17:32:52 +0800
Message-Id: <7fcf0989da8af2f95e99cdc520adae57a27e7124.1649753690.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649753690.git.wqu@suse.com>
References: <cover.1649753690.git.wqu@suse.com>
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

The function rbio_nr_pages() is only called once inside alloc_rbio(),
there is no reason to make it dedicated helper.

Furthermore, the return type doesn't match, the function return "unsigned
long" which may not be necessary, while the only caller only uses "int".

Since we're doing cleaning up here, also fix the type to "const unsigned
int" for all involved local variables.

This change will slightly modify the timing of the ASSERT() on
@stripe_len though.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index daffa3076325..a16297b04db6 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -945,16 +945,6 @@ static struct page *page_in_rbio(struct btrfs_raid_bio *rbio,
 	return rbio->stripe_pages[chunk_page];
 }
 
-/*
- * number of pages we need for the entire stripe across all the
- * drives
- */
-static unsigned long rbio_nr_pages(u32 stripe_len, int nr_stripes)
-{
-	ASSERT(IS_ALIGNED(stripe_len, PAGE_SIZE));
-	return (stripe_len >> PAGE_SHIFT) * nr_stripes;
-}
-
 /*
  * allocation and initial setup for the btrfs_raid_bio.  Not
  * this does not allocate any pages for rbio->pages.
@@ -963,13 +953,15 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 					 struct btrfs_io_context *bioc,
 					 u32 stripe_len)
 {
+	const unsigned int real_stripes = bioc->num_stripes - bioc->num_tgtdevs;
+	const unsigned int stripe_npages = stripe_len >> PAGE_SHIFT;
+	const unsigned int num_pages = stripe_npages * real_stripes;
 	struct btrfs_raid_bio *rbio;
 	int nr_data = 0;
-	int real_stripes = bioc->num_stripes - bioc->num_tgtdevs;
-	int num_pages = rbio_nr_pages(stripe_len, real_stripes);
-	int stripe_npages = stripe_len >> PAGE_SHIFT;
 	void *p;
 
+	ASSERT(IS_ALIGNED(stripe_len, PAGE_SIZE));
+
 	rbio = kzalloc(sizeof(*rbio) +
 		       sizeof(*rbio->stripe_pages) * num_pages +
 		       sizeof(*rbio->bio_pages) * num_pages +
-- 
2.35.1

