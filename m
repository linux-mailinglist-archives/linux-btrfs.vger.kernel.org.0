Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E8D27DE11
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 03:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbgI3B4j (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 21:56:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:50394 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729633AbgI3B4j (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 21:56:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601430997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wG8i2qZPHuSRdrKvzdn0GkTtfAS+II+TO0OzVlkgGEA=;
        b=ET9Q3q0FtspWy3ihmLLGx0ucrVZBe81gr5ehfxxhL1FKsaBxpsP1UdebSCUQWR8goNFFyT
        gjwiqc7d/znHJBbQZxs+lrancvBrF8VbvCDOOuIPjjhgkkINeXVpn/rnkRrBlltk4j5q6c
        u4h6SZIlQWI74TtUiR8/+QtGkohXDdg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 34848AF95;
        Wed, 30 Sep 2020 01:56:37 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH v3 24/49] btrfs: inode: make btrfs_readpage_end_io_hook() follow sector size
Date:   Wed, 30 Sep 2020 09:55:14 +0800
Message-Id: <20200930015539.48867-25-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930015539.48867-1-wqu@suse.com>
References: <20200930015539.48867-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently btrfs_readpage_end_io_hook() just pass the whole page to
check_data_csum(), which is fine since we only support sectorsize ==
PAGE_SIZE.

To support subpage, we need to properly honor per-sector
checksum verification, just like what we did in dio read path.

This patch will do the csum verification in a for loop, starts with
pg_off == start - page_offset(page), with sectorsize increasement for
each loop.

For sectorsize == PAGE_SIZE case, the pg_off will always be 0, and we
will only finish with just one loop.

For subpage, we do the proper loop.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 10ea6a92685b..2ee6ff186be4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2849,9 +2849,12 @@ static int btrfs_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
 				      u64 start, u64 end, int mirror)
 {
 	size_t offset = start - page_offset(page);
+	size_t pg_off;
 	struct inode *inode = page->mapping->host;
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct btrfs_root *root = BTRFS_I(inode)->root;
+	u32 sectorsize = root->fs_info->sectorsize;
+	bool found_err = false;
 
 	if (PageChecked(page)) {
 		ClearPageChecked(page);
@@ -2868,7 +2871,17 @@ static int btrfs_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
 	}
 
 	phy_offset >>= inode->i_sb->s_blocksize_bits;
-	return check_data_csum(inode, io_bio, phy_offset, page, offset);
+	for (pg_off = offset; pg_off < end - page_offset(page);
+	     pg_off += sectorsize, phy_offset++) {
+		int ret;
+
+		ret = check_data_csum(inode, io_bio, phy_offset, page, pg_off);
+		if (ret < 0)
+			found_err = true;
+	}
+	if (found_err)
+		return -EIO;
+	return 0;
 }
 
 /*
-- 
2.28.0

