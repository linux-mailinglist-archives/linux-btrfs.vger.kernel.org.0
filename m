Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48494EEC56
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Apr 2022 13:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345493AbiDALZ4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Apr 2022 07:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345500AbiDALZv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Apr 2022 07:25:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71B81959FA
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 04:24:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F054921A91
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 11:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648812239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/fFNCXXuKGfgMVKXgTqLEfMvWOnWXJ24uDqZn+sCnA4=;
        b=EBNP/zh27mHDx2oOHAY44GUm2W+uGxWmaK580sicu4wxINAiiPtusqUbO+s/89FP/d1rI4
        21NFhpDP+ydSkchCOG0nzbijJ3zj+uTzXeQCOluIYfC75EA3xqM9P6/sSawX0SaJCCDsiX
        Du7ko1KqrNjSEjUlUoRHO5/DhVTdkrw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AD37D132C1
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Apr 2022 11:23:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4ObOHs7gRmJeFwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Apr 2022 11:23:58 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 10/16] btrfs: open-code rbio_stripe_page_index()
Date:   Fri,  1 Apr 2022 19:23:25 +0800
Message-Id: <dc402b70e4dea8f2ccda06c33896406caf918846.1648807440.git.wqu@suse.com>
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

There is only one caller for that helper now, and we're definitely fine
to open-code it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 61df2b3636d2..998c30867554 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -699,12 +699,6 @@ static struct sector_ptr *rbio_qstripe_sector(const struct btrfs_raid_bio *rbio,
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
@@ -1131,9 +1125,7 @@ static int alloc_rbio_parity_pages(struct btrfs_raid_bio *rbio)
 	int i;
 	struct page *page;
 
-	i = rbio_stripe_page_index(rbio, rbio->nr_data, 0);
-
-	for (; i < rbio->nr_pages; i++) {
+	for (i = rbio->nr_data * rbio->stripe_npages; i < rbio->nr_pages; i++) {
 		if (rbio->stripe_pages[i])
 			continue;
 		page = alloc_page(GFP_NOFS);
-- 
2.35.1

