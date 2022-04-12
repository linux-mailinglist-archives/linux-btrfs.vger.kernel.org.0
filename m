Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC53E4FDCB5
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Apr 2022 13:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352426AbiDLKiR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Apr 2022 06:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354483AbiDLKdl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Apr 2022 06:33:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9775640D
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 02:33:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AE0AE21608
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649756018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qb1IRqyNMvjMnEwNvVQY+qZtp2jsfnBGrjqwDqfrF18=;
        b=TA4yuQGWuzvWyPI0VJaRmmwAEj7eJiM6/IHngW/VuPnMp7j9FyA0ldAQFSEJeh4f9HzPTb
        gjMcnifZya+z4uugwCt+VAFOGtr2oefrKJMuC/UonXrfXt6q4YwwKxF3X7MTwEWzjUvBpa
        5uN3Gk57/O4M1i5J5LuFzwrpcBNMWhU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EF74F13A99
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cC9lLXFHVWI8LwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:37 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 11/17] btrfs: open-code rbio_stripe_page_index()
Date:   Tue, 12 Apr 2022 17:33:01 +0800
Message-Id: <5157425e97e212710ee6ef3308f0b84ba0ad3bde.1649753690.git.wqu@suse.com>
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

There is only one caller for that helper now, and we're definitely fine
to open-code it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 928359840e8e..5d383f894eb9 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -697,12 +697,6 @@ static struct sector_ptr *rbio_qstripe_sector(const struct btrfs_raid_bio *rbio,
 	return rbio_stripe_sector(rbio, rbio->nr_data + 1, sector_nr);
 }
 
-static int rbio_stripe_page_index(struct btrfs_raid_bio *rbio, int stripe,
-				  int index)
-{
-	return stripe * rbio->stripe_npages + index;
-}
-
 /*
  * The first stripe in the table for a logical address
  * has the lock.  rbios are added in one of three ways:
@@ -1117,7 +1111,7 @@ static int alloc_rbio_pages(struct btrfs_raid_bio *rbio)
 /* only allocate pages for p/q stripes */
 static int alloc_rbio_parity_pages(struct btrfs_raid_bio *rbio)
 {
-	int data_pages = rbio_stripe_page_index(rbio, rbio->nr_data, 0);
+	int data_pages = rbio->nr_data * rbio->stripe_npages;
 	int ret;
 
 	ret = btrfs_alloc_page_array(rbio->nr_pages - data_pages,
-- 
2.35.1

