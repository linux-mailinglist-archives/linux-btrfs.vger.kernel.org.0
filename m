Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2FA4EEC52
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Apr 2022 13:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344699AbiDALZo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Apr 2022 07:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344444AbiDALZm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Apr 2022 07:25:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7266416CE76
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 04:23:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1BFFD21A91
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 11:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648812230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u8VSkuHpeXe7S6mCAeDG8UgYMxRtoauJzVEggGldLiE=;
        b=KmEX+WD3rlSNW84LGiWfaG5SGt5PoGwAlzIGUNcYR30FWDZ7C+yJpJHsxx/6SW6Quc24Ut
        2ggG96tgRzOMp2GRZ1LZn6UZsxE3/xr1VKvvghx9qopv3s0qNHpeAfsNUh1zPyOvNyxGrd
        ivnRzzp3AbC2cF2GmJZ1tCgzbhwYiFg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 73B03132C1
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 11:23:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AM3mD8XgRmJeFwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Apr 2022 11:23:49 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 01/16] btrfs: open-code rbio_nr_pages()
Date:   Fri,  1 Apr 2022 19:23:16 +0800
Message-Id: <7a98d1699b1e4db5c607a509a5e2e71bc7811178.1648807440.git.wqu@suse.com>
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

The function rbio_nr_pages() is only called once inside alloc_rbio(),
there is no reason to make it dedicated helper.

Furthermore, the return type doesn't match, the function return "unsigned
long" which may not be necessary, while the only caller only uses "int".

Since we're doing cleaning up here, also fix the type to "const unsigned
int" for all involved local variables.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 0e239a4c3b26..ae585ed6a023 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -945,15 +945,6 @@ static struct page *page_in_rbio(struct btrfs_raid_bio *rbio,
 	return rbio->stripe_pages[chunk_page];
 }
 
-/*
- * number of pages we need for the entire stripe across all the
- * drives
- */
-static unsigned long rbio_nr_pages(unsigned long stripe_len, int nr_stripes)
-{
-	return DIV_ROUND_UP(stripe_len, PAGE_SIZE) * nr_stripes;
-}
-
 /*
  * allocation and initial setup for the btrfs_raid_bio.  Not
  * this does not allocate any pages for rbio->pages.
@@ -962,11 +953,12 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
 					 struct btrfs_io_context *bioc,
 					 u64 stripe_len)
 {
+	const unsigned int real_stripes = bioc->num_stripes - bioc->num_tgtdevs;
+	const unsigned int num_pages = DIV_ROUND_UP(stripe_len, PAGE_SIZE) *
+				       real_stripes;
+	const unsigned int stripe_npages = DIV_ROUND_UP(stripe_len, PAGE_SIZE);
 	struct btrfs_raid_bio *rbio;
 	int nr_data = 0;
-	int real_stripes = bioc->num_stripes - bioc->num_tgtdevs;
-	int num_pages = rbio_nr_pages(stripe_len, real_stripes);
-	int stripe_npages = DIV_ROUND_UP(stripe_len, PAGE_SIZE);
 	void *p;
 
 	rbio = kzalloc(sizeof(*rbio) +
-- 
2.35.1

