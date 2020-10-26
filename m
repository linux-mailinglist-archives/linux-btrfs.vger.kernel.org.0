Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E7029873E
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Oct 2020 08:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770929AbgJZHLc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Oct 2020 03:11:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:51300 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1770924AbgJZHLc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Oct 2020 03:11:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603696290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y4XbNc3nRkl/FnavotUGPr6EUfK3Wuu+okZFsUcTFgY=;
        b=dR/i82cU8Hwjwt2eAuBJ1rNkPZchoblD8iLYq8jwqhR6qEAP/b6Lv4KRUlTt8KYITjmeIg
        kKqnFcGCvAxoOfMVq0lhJs9UIMEn+iaP5ANjfIVLfZjflqXhVUyUSNVUEvwyTEJEImdLuz
        6VFAttqoxpdZJD6J+V4Fsx1R5agv4AI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6F70CAD2F
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Oct 2020 07:11:30 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/8] btrfs: scrub: refactor scrub_find_csum()
Date:   Mon, 26 Oct 2020 15:11:11 +0800
Message-Id: <20201026071115.57225-5-wqu@suse.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201026071115.57225-1-wqu@suse.com>
References: <20201026071115.57225-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Function scrub_find_csum() is to locate the csum for bytenr @logical
from sctx->csum_list.

However it lacks a lot of comments to explaining things like how the
csum_list is organized and why we need to drop csum range which is
before us.

Refactor the function by:
- Add more comment explaining the behavior
- Add comment explaining why we need to drop the csum range
- Put the csum copy in the main loop
  This is mostly for the incoming patches to make scrub_find_csum() able
  to find multiple checksums.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 70 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 51 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 321d6d457942..0d078393f986 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2386,37 +2386,69 @@ static void scrub_block_complete(struct scrub_block *sblock)
 	}
 }
 
+static void drop_csum_range(struct scrub_ctx *sctx,
+			    struct btrfs_ordered_sum *sum)
+{
+	u32 sectorsize = sctx->fs_info->sectorsize;
+
+	sctx->stat.csum_discards += sum->len / sectorsize;
+	list_del(&sum->list);
+	kfree(sum);
+}
+
+/*
+ * Find the desired csum for range [@logical, @logical + sectorsize), and
+ * store the csum into @csum.
+ *
+ * The search source is sctx->csum_list, which is a pre-populated list
+ * storing bytenr ordered csum ranges.
+ * We're reponsible to cleanup any range that is before @logical.
+ *
+ * Return 0 if there is no csum for the range.
+ * Return 1 if there is csum for the range and copied to @csum.
+ */
 static int scrub_find_csum(struct scrub_ctx *sctx, u64 logical, u8 *csum)
 {
-	struct btrfs_ordered_sum *sum = NULL;
-	unsigned long index;
-	unsigned long num_sectors;
+	u32 sectorsize = sctx->fs_info->sectorsize;
+	u32 csum_size = sctx->csum_size;
+	bool found = false;
 
 	while (!list_empty(&sctx->csum_list)) {
+		struct btrfs_ordered_sum *sum = NULL;
+		unsigned long index;
+		unsigned long num_sectors;
+
 		sum = list_first_entry(&sctx->csum_list,
 				       struct btrfs_ordered_sum, list);
+		/* The current csum range is beyond our range, no csum found */
 		if (sum->bytenr > logical)
-			return 0;
-		if (sum->bytenr + sum->len > logical)
 			break;
 
-		++sctx->stat.csum_discards;
-		list_del(&sum->list);
-		kfree(sum);
-		sum = NULL;
-	}
-	if (!sum)
-		return 0;
+		/*
+		 * The current sum is before our bytenr, since scrub is
+		 * always done in bytenr order, the csum will never be used
+		 * anymore, clean it up so that later calls won't bother the
+		 * range, and continue search the next range.
+		 */
+		if (sum->bytenr + sum->len <= logical) {
+			drop_csum_range(sctx, sum);
+			continue;
+		}
 
-	index = div_u64(logical - sum->bytenr, sctx->fs_info->sectorsize);
-	ASSERT(index < UINT_MAX);
+		/* Now the csum range covers our bytenr, copy the csum */
+		found = true;
+		index = div_u64(logical - sum->bytenr, sectorsize);
+		num_sectors = sum->len / sectorsize;
 
-	num_sectors = sum->len / sctx->fs_info->sectorsize;
-	memcpy(csum, sum->sums + index * sctx->csum_size, sctx->csum_size);
-	if (index == num_sectors - 1) {
-		list_del(&sum->list);
-		kfree(sum);
+		memcpy(csum, sum->sums + index * csum_size, csum_size);
+
+		/* Cleanup the range if we're at the end of the csum range */
+		if (index == num_sectors - 1)
+			drop_csum_range(sctx, sum);
+		break;
 	}
+	if (!found)
+		return 0;
 	return 1;
 }
 
-- 
2.29.0

