Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0917D602E6E
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Oct 2022 16:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbiJRO1v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Oct 2022 10:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiJRO1s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Oct 2022 10:27:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98757C098A
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Oct 2022 07:27:47 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 379DA2072A;
        Tue, 18 Oct 2022 14:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666103266; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TzpKuf8eHbqy1xMBoR1NUCvs1QFJO3V3rUl9QUTsSd4=;
        b=VXSMLhn+8X8dvNaeG90m+zQO7zT41aCA/N7XReB4UswONYGlTDYX7FNVmZDQ+6k03PVwB8
        OczmOgVwpd+Yt7/MIHc6UJs48kl7xTDgjtW8T8su2ANn966LWJMRowl1loWMncca5QWw7h
        MBgJwsgczg5Pc3ysHDSvjjsCluOrjCk=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2ED982C141;
        Tue, 18 Oct 2022 14:27:46 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CDF81DA79B; Tue, 18 Oct 2022 16:27:37 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 4/4] btrfs: sink gfp_t parameter to alloc_scrub_sector
Date:   Tue, 18 Oct 2022 16:27:37 +0200
Message-Id: <a33272553ef02334c55eb6fea1c286bef8c7c871.1666103172.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1666103172.git.dsterba@suse.com>
References: <cover.1666103172.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

All callers pas GFP_KERNEL as parameter so we can use it directly in
alloc_scrub_sector.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/scrub.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 2fc70a2cc7fe..79d0ef534d5f 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -295,7 +295,7 @@ static struct scrub_block *alloc_scrub_block(struct scrub_ctx *sctx,
  * Will also allocate new pages for @sblock if needed.
  */
 static struct scrub_sector *alloc_scrub_sector(struct scrub_block *sblock,
-					       u64 logical, gfp_t gfp)
+					       u64 logical)
 {
 	const pgoff_t page_index = (logical - sblock->logical) >> PAGE_SHIFT;
 	struct scrub_sector *ssector;
@@ -303,7 +303,7 @@ static struct scrub_sector *alloc_scrub_sector(struct scrub_block *sblock,
 	/* We must never have scrub_block exceed U32_MAX in size. */
 	ASSERT(logical - sblock->logical < U32_MAX);
 
-	ssector = kzalloc(sizeof(*ssector), gfp);
+	ssector = kzalloc(sizeof(*ssector), GFP_KERNEL);
 	if (!ssector)
 		return NULL;
 
@@ -311,7 +311,7 @@ static struct scrub_sector *alloc_scrub_sector(struct scrub_block *sblock,
 	if (!sblock->pages[page_index]) {
 		int ret;
 
-		sblock->pages[page_index] = alloc_page(gfp);
+		sblock->pages[page_index] = alloc_page(GFP_KERNEL);
 		if (!sblock->pages[page_index]) {
 			kfree(ssector);
 			return NULL;
@@ -1514,7 +1514,7 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 			sblock = sblocks_for_recheck[mirror_index];
 			sblock->sctx = sctx;
 
-			sector = alloc_scrub_sector(sblock, logical, GFP_KERNEL);
+			sector = alloc_scrub_sector(sblock, logical);
 			if (!sector) {
 				spin_lock(&sctx->stat_lock);
 				sctx->stat.malloc_errors++;
@@ -2436,7 +2436,7 @@ static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
 		 */
 		u32 l = min(sectorsize, len);
 
-		sector = alloc_scrub_sector(sblock, logical, GFP_KERNEL);
+		sector = alloc_scrub_sector(sblock, logical);
 		if (!sector) {
 			spin_lock(&sctx->stat_lock);
 			sctx->stat.malloc_errors++;
@@ -2773,7 +2773,7 @@ static int scrub_sectors_for_parity(struct scrub_parity *sparity,
 	for (index = 0; len > 0; index++) {
 		struct scrub_sector *sector;
 
-		sector = alloc_scrub_sector(sblock, logical, GFP_KERNEL);
+		sector = alloc_scrub_sector(sblock, logical);
 		if (!sector) {
 			spin_lock(&sctx->stat_lock);
 			sctx->stat.malloc_errors++;
-- 
2.37.3

