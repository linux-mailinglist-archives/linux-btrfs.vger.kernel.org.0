Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C65B2B1B61
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 13:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgKMMwW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 07:52:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:46706 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726503AbgKMMwW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 07:52:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605271940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x75kLDj09kPaiJ4b4pXpVWAhmKvmAWPsBk/dhhNad50=;
        b=AP7xnJbKkh5o2w/QDQJH0APQ2DfNrprtxynxWeLsvjsPnqZodN1HFr8kOUIK4WLlmRtwO2
        28NgRwNP5m9lflgBqhyF2JZcsOCyVxRrR89ye7ywItxe2GjYYN7wc5y5oe9qyK4c43SNRK
        W6eERVxn+WY4cXjc0NRqiCJxa8fU+5w=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8F9CDABD9;
        Fri, 13 Nov 2020 12:52:20 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH v2 08/24] btrfs: inode: make btrfs_verify_data_csum() follow sector size
Date:   Fri, 13 Nov 2020 20:51:33 +0800
Message-Id: <20201113125149.140836-9-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201113125149.140836-1-wqu@suse.com>
References: <20201113125149.140836-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently btrfs_verify_data_csum() just pass the whole page to
check_data_csum(), which is fine since we only support sectorsize ==
PAGE_SIZE.

To support subpage, we need to properly honor per-sector
checksum verification, just like what we did in dio read path.

This patch will do the csum verification in a for loop, starts with
pg_off == start - page_offset(page), with sectorsize increasement for
each loop.

For sectorsize == PAGE_SIZE case, the pg_off will always be 0, and we
will only finish with just one loop.

For subpage case, we do the loop to iterate each sector and if we found
any error, we return error.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index bcf3152d0efb..3f19e0e19c96 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2989,10 +2989,11 @@ static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
 int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u64 bio_offset,
 			   struct page *page, u64 start, u64 end, int mirror)
 {
-	size_t offset = start - page_offset(page);
+	u64 pg_off;
 	struct inode *inode = page->mapping->host;
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct btrfs_root *root = BTRFS_I(inode)->root;
+	u32 sectorsize = root->fs_info->sectorsize;
 
 	if (PageChecked(page)) {
 		ClearPageChecked(page);
@@ -3011,7 +3012,16 @@ int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u64 bio_offset,
 		return 0;
 	}
 
-	return check_data_csum(inode, io_bio, bio_offset, page, offset);
+	for (pg_off = start - page_offset(page);
+	     pg_off < end - page_offset(page);
+	     pg_off += sectorsize, bio_offset += sectorsize) {
+		int ret;
+
+		ret = check_data_csum(inode, io_bio, bio_offset, page, pg_off);
+		if (ret < 0)
+			return -EIO;
+	}
+	return 0;
 }
 
 /*
-- 
2.29.2

