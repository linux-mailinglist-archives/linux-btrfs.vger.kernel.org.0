Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD2B60668D
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 19:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiJTQ7s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 12:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiJTQ7n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 12:59:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF587C7A
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Oct 2022 09:59:37 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6316022B31;
        Thu, 20 Oct 2022 16:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666285175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=odfBrLhK1dXsFhtBNknK9sltiXrscJGJON2f0r4pmFo=;
        b=vPmeOB+hsYqi/050uEK4cKTXvzg1YmG/nldj9cXAKOglSf+EFX2lqwkhS9kmGOjUFbUgsg
        s2nCJmxorEMnZ2Obby0MktPLInLySu3Rc0XvDoXPaJtUE3E+g8ydw2eBp1PN6TNxBppq7H
        /XJIoV42fiGYO443S6dUf/ZBnb1OC7Q=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5A8D72C145;
        Thu, 20 Oct 2022 16:59:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id B4F4EDA79B; Thu, 20 Oct 2022 18:59:25 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v2 4/4] btrfs: sink gfp_t parameter to alloc_scrub_sector
Date:   Thu, 20 Oct 2022 18:59:25 +0200
Message-Id: <d238cf31fc15311088104ae347c3d19c6a1bc30a.1666285085.git.dsterba@suse.com>
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

All callers pas GFP_KERNEL as parameter so we can use it directly in
alloc_scrub_sector.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/scrub.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 5dc3183d88a0..f50979511794 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -297,7 +297,7 @@ static struct scrub_block *alloc_scrub_block(struct scrub_ctx *sctx,
  * Will also allocate new pages for @sblock if needed.
  */
 static struct scrub_sector *alloc_scrub_sector(struct scrub_block *sblock,
-					       u64 logical, gfp_t gfp)
+					       u64 logical)
 {
 	const pgoff_t page_index = (logical - sblock->logical) >> PAGE_SHIFT;
 	struct scrub_sector *ssector;
@@ -305,7 +305,7 @@ static struct scrub_sector *alloc_scrub_sector(struct scrub_block *sblock,
 	/* We must never have scrub_block exceed U32_MAX in size. */
 	ASSERT(logical - sblock->logical < U32_MAX);
 
-	ssector = kzalloc(sizeof(*ssector), gfp);
+	ssector = kzalloc(sizeof(*ssector), GFP_KERNEL);
 	if (!ssector)
 		return NULL;
 
@@ -313,7 +313,7 @@ static struct scrub_sector *alloc_scrub_sector(struct scrub_block *sblock,
 	if (!sblock->pages[page_index]) {
 		int ret;
 
-		sblock->pages[page_index] = alloc_page(gfp);
+		sblock->pages[page_index] = alloc_page(GFP_KERNEL);
 		if (!sblock->pages[page_index]) {
 			kfree(ssector);
 			return NULL;
@@ -1516,7 +1516,7 @@ static int scrub_setup_recheck_block(struct scrub_block *original_sblock,
 			sblock = sblocks_for_recheck[mirror_index];
 			sblock->sctx = sctx;
 
-			sector = alloc_scrub_sector(sblock, logical, GFP_KERNEL);
+			sector = alloc_scrub_sector(sblock, logical);
 			if (!sector) {
 				spin_lock(&sctx->stat_lock);
 				sctx->stat.malloc_errors++;
@@ -2438,7 +2438,7 @@ static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
 		 */
 		u32 l = min(sectorsize, len);
 
-		sector = alloc_scrub_sector(sblock, logical, GFP_KERNEL);
+		sector = alloc_scrub_sector(sblock, logical);
 		if (!sector) {
 			spin_lock(&sctx->stat_lock);
 			sctx->stat.malloc_errors++;
@@ -2775,7 +2775,7 @@ static int scrub_sectors_for_parity(struct scrub_parity *sparity,
 	for (index = 0; len > 0; index++) {
 		struct scrub_sector *sector;
 
-		sector = alloc_scrub_sector(sblock, logical, GFP_KERNEL);
+		sector = alloc_scrub_sector(sblock, logical);
 		if (!sector) {
 			spin_lock(&sctx->stat_lock);
 			sctx->stat.malloc_errors++;
-- 
2.37.3

