Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7EE3602E6C
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Oct 2022 16:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiJRO1r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Oct 2022 10:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiJRO1q (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Oct 2022 10:27:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B1EC0981
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 07:27:45 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 188B51FD9C;
        Tue, 18 Oct 2022 14:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666103264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lzFFr3x6V34+dftiSXn+8k33YPo52MjKwQnbxj+59ws=;
        b=SB9aYmO9lbm25zwW8hH/h0wr/m9TXpf0pFWczCiBjlKuPGyKBJwMlYh8kAgeM3pc5WEQnM
        6zn7WYlQ5mLDYz74tkdJzpDkDgXWvF3f77JPTe7sotPPNwc9MjnsKUhIs1W6jgXHSXXJ1a
        RTzZ8Fqh+kw1lqusWXFXBOHKxnhtbuc=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0E3332C141;
        Tue, 18 Oct 2022 14:27:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A789ADA79B; Tue, 18 Oct 2022 16:27:35 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 3/4] btrfs: switch GFP_NOFS to GFP_KERNEL in scrub_setup_recheck_block
Date:   Tue, 18 Oct 2022 16:27:35 +0200
Message-Id: <aed6063361919c409c72b208d361be0a5d094b3a.1666103172.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1666103172.git.dsterba@suse.com>
References: <cover.1666103172.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's only one caller that calls scrub_setup_recheck_block in the
memalloc_nofs_save/_restore protection so it's effectively already
GFP_NOFS and it's safe to use GFP_KERNEL.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/scrub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 9e3b2e60e571..2fc70a2cc7fe 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1491,7 +1491,7 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 			return -EIO;
 		}
 
-		recover = kzalloc(sizeof(struct scrub_recover), GFP_NOFS);
+		recover = kzalloc(sizeof(struct scrub_recover), GFP_KERNEL);
 		if (!recover) {
 			btrfs_put_bioc(bioc);
 			btrfs_bio_counter_dec(fs_info);
@@ -1514,7 +1514,7 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 			sblock = sblocks_for_recheck[mirror_index];
 			sblock->sctx = sctx;
 
-			sector = alloc_scrub_sector(sblock, logical, GFP_NOFS);
+			sector = alloc_scrub_sector(sblock, logical, GFP_KERNEL);
 			if (!sector) {
 				spin_lock(&sctx->stat_lock);
 				sctx->stat.malloc_errors++;
-- 
2.37.3

