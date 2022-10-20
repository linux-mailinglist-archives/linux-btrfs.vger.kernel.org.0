Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8ADB606685
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 18:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiJTQ7p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 12:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiJTQ7l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 12:59:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6323132A87
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 09:59:34 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 496111FDB9;
        Thu, 20 Oct 2022 16:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666285173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k0s/tiFEI8ClQywm88meIuHHdefJNv6C1pxYcMdrzfg=;
        b=KO/eTHI5LdEP+8Efy/LlNc4E+1DTXJs/3bLsUrU+1VPbtbeIrNCmsO4JDI4ZLd9PziHGDt
        ckHpWrXODdm0eEg2zbrmAzl4o5BAe6ID4T5EAOBR8bDkmUTJuF0HnrJ4sMhlOE3GPNzn2J
        YgMfLTND46qJ+LavwHhiNpQ6PGXea8Q=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 3F8422C141;
        Thu, 20 Oct 2022 16:59:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 96C10DA79B; Thu, 20 Oct 2022 18:59:23 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v2 3/4] btrfs: switch GFP_NOFS to GFP_KERNEL in scrub_setup_recheck_block
Date:   Thu, 20 Oct 2022 18:59:23 +0200
Message-Id: <4c5a570245c2938265bd5f8ef2b23c66026126ea.1666285085.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1666285085.git.dsterba@suse.com>
References: <cover.1666285085.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
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
index e419c9f948e8..5dc3183d88a0 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1493,7 +1493,7 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 			return -EIO;
 		}
 
-		recover = kzalloc(sizeof(struct scrub_recover), GFP_NOFS);
+		recover = kzalloc(sizeof(struct scrub_recover), GFP_KERNEL);
 		if (!recover) {
 			btrfs_put_bioc(bioc);
 			btrfs_bio_counter_dec(fs_info);
@@ -1516,7 +1516,7 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 			sblock = sblocks_for_recheck[mirror_index];
 			sblock->sctx = sctx;
 
-			sector = alloc_scrub_sector(sblock, logical, GFP_NOFS);
+			sector = alloc_scrub_sector(sblock, logical, GFP_KERNEL);
 			if (!sector) {
 				spin_lock(&sctx->stat_lock);
 				sctx->stat.malloc_errors++;
-- 
2.37.3

