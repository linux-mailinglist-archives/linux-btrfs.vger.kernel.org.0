Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54DAA1EA6D4
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 17:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgFAPXV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 11:23:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:57042 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727879AbgFAPXU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 11:23:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 10C82ADF7;
        Mon,  1 Jun 2020 15:23:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 28F76DA79B; Mon,  1 Jun 2020 17:23:17 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 7/9] btrfs: scrub: clean up temporary page variables in scrub_checksum_data
Date:   Mon,  1 Jun 2020 17:23:17 +0200
Message-Id: <0bf855799e7e2b018baf05a76fe1a8e2c03a6b3a.1591024792.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1591024792.git.dsterba@suse.com>
References: <cover.1591024792.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add proper variable for the scrub page and use it instead of repeatedly
dereferencing the other structures.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/scrub.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 16c83130d884..19a64c72f38e 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1786,23 +1786,21 @@ static int scrub_checksum_data(struct scrub_block *sblock)
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	u8 csum[BTRFS_CSUM_SIZE];
-	u8 *on_disk_csum;
-	struct page *page;
+	struct scrub_page *spage;
 	char *kaddr;
 
 	BUG_ON(sblock->page_count < 1);
-	if (!sblock->pagev[0]->have_csum)
+	spage = sblock->pagev[0];
+	if (!spage->have_csum)
 		return 0;
 
-	on_disk_csum = sblock->pagev[0]->csum;
-	page = sblock->pagev[0]->page;
-	kaddr = page_address(page);
+	kaddr = page_address(spage->page);
 
 	shash->tfm = fs_info->csum_shash;
 	crypto_shash_init(shash);
 	crypto_shash_digest(shash, kaddr, PAGE_SIZE, csum);
 
-	if (memcmp(csum, on_disk_csum, sctx->csum_size))
+	if (memcmp(csum, spage->csum, sctx->csum_size))
 		sblock->checksum_error = 1;
 
 	return sblock->checksum_error;
-- 
2.25.0

