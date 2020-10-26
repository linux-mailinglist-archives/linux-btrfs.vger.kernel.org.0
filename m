Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6072298741
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Oct 2020 08:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770938AbgJZHLk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Oct 2020 03:11:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:51374 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1770928AbgJZHLj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Oct 2020 03:11:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603696298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JpYrpieoUMSTgeAERV2vEnfaYH5wBiO28P6Lqwc4t3M=;
        b=UAG95atZ5N4EKaeIJu0FDSj3Vi3bGn29lTifz8caCE6okAkmAm2nYpEjB6qa0POWDNKkk7
        xxsPYZSj6SpmTYf+WmoAhHwHVbXi8r2Ts6IimV4D5YvFB4tsV323V5oEQ2V5yeAoduGdOa
        zm2VykSFjM7Larj9WDm6LBqrqyLDphI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1E7D6ACA3
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Oct 2020 07:11:38 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 7/8] btrfs: scrub: support subpage tree block scrub
Date:   Mon, 26 Oct 2020 15:11:14 +0800
Message-Id: <20201026071115.57225-8-wqu@suse.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201026071115.57225-1-wqu@suse.com>
References: <20201026071115.57225-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

To support subpage tree block scrub, scrub_checksum_tree_block() only
needs to learn 2 new tricks:
- Follow scrub_page::page_len
  Now scrub_page only represents one sector, we need to follow it
  properly.

- Run checksum on all sectors
  Since scrub_page only represents one sector, we need to run hash on
  all sectors, no longer just (nodesize >> PAGE_SIZE).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 10836aec389f..13355cc2b1ae 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1841,15 +1841,21 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 	struct scrub_ctx *sctx = sblock->sctx;
 	struct btrfs_header *h;
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
+	u32 sectorsize = sctx->fs_info->sectorsize;
+	u32 nodesize = sctx->fs_info->nodesize;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	u8 calculated_csum[BTRFS_CSUM_SIZE];
 	u8 on_disk_csum[BTRFS_CSUM_SIZE];
-	const int num_pages = sctx->fs_info->nodesize >> PAGE_SHIFT;
+	const int num_sectors = nodesize / sectorsize;
 	int i;
 	struct scrub_page *spage;
 	char *kaddr;
 
 	BUG_ON(sblock->page_count < 1);
+
+	/* Each pagev[] is in fact just one sector, not a full page */
+	ASSERT(sblock->page_count == num_sectors);
+
 	spage = sblock->pagev[0];
 	kaddr = page_address(spage->page);
 	h = (struct btrfs_header *)kaddr;
@@ -1878,11 +1884,11 @@ static int scrub_checksum_tree_block(struct scrub_block *sblock)
 	shash->tfm = fs_info->csum_shash;
 	crypto_shash_init(shash);
 	crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
-			    PAGE_SIZE - BTRFS_CSUM_SIZE);
+			    spage->page_len - BTRFS_CSUM_SIZE);
 
-	for (i = 1; i < num_pages; i++) {
+	for (i = 1; i < num_sectors; i++) {
 		kaddr = page_address(sblock->pagev[i]->page);
-		crypto_shash_update(shash, kaddr, PAGE_SIZE);
+		crypto_shash_update(shash, kaddr, sblock->pagev[i]->page_len);
 	}
 
 	crypto_shash_final(shash, calculated_csum);
-- 
2.29.0

