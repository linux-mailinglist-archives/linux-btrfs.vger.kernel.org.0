Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790F31EA6D1
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 17:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgFAPXS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 11:23:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:57030 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgFAPXS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 11:23:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D2BCFB175;
        Mon,  1 Jun 2020 15:23:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DE57DDA79B; Mon,  1 Jun 2020 17:23:14 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 6/9] btrfs: scrub: simplify data block checksum calculation
Date:   Mon,  1 Jun 2020 17:23:14 +0200
Message-Id: <8fa6b04b12f289eba740727af0378bb1b07b7de5.1591024792.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1591024792.git.dsterba@suse.com>
References: <cover.1591024792.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have sectorsize same as PAGE_SIZE, the checksum can be calculated in
one go.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/scrub.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index aecaf5c7f655..16c83130d884 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1789,37 +1789,19 @@ static int scrub_checksum_data(struct scrub_block *sblock)
 	u8 *on_disk_csum;
 	struct page *page;
 	char *kaddr;
-	u64 len;
-	int index;
 
 	BUG_ON(sblock->page_count < 1);
 	if (!sblock->pagev[0]->have_csum)
 		return 0;
 
-	shash->tfm = fs_info->csum_shash;
-	crypto_shash_init(shash);
-
 	on_disk_csum = sblock->pagev[0]->csum;
 	page = sblock->pagev[0]->page;
 	kaddr = page_address(page);
 
-	len = sctx->fs_info->sectorsize;
-	index = 0;
-	for (;;) {
-		u64 l = min_t(u64, len, PAGE_SIZE);
-
-		crypto_shash_update(shash, kaddr, l);
-		len -= l;
-		if (len == 0)
-			break;
-		index++;
-		BUG_ON(index >= sblock->page_count);
-		BUG_ON(!sblock->pagev[index]->page);
-		page = sblock->pagev[index]->page;
-		kaddr = page_address(page);
-	}
+	shash->tfm = fs_info->csum_shash;
+	crypto_shash_init(shash);
+	crypto_shash_digest(shash, kaddr, PAGE_SIZE, csum);
 
-	crypto_shash_final(shash, csum);
 	if (memcmp(csum, on_disk_csum, sctx->csum_size))
 		sblock->checksum_error = 1;
 
-- 
2.25.0

