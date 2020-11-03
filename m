Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14DCA2A468A
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 14:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgKCNb7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 08:31:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:44832 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729355AbgKCNb7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Nov 2020 08:31:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604410318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lZ2lwAe8nNrxrkFCmTtjimcAOM0pzjMfD/ZzzyG/psg=;
        b=WSZOrNjOUrXoX6yrzEvrDkynjVA9XCfyiiuxfzTQwbXdfC8lNJRUUuJpTY/7HxIosnwRW3
        JbW97u9POKpALIJuXJOIY7GhyCneOwljPXuIlqgYKJnyT7F4+P/x/Kht+mwRkGqCX8onc7
        m6eOc/zK73BtNSBXPsMmcC5NMvTo8Qc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1C9FEABF4;
        Tue,  3 Nov 2020 13:31:58 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 14/32] btrfs: inode: make btrfs_readpage_end_io_hook() follow sector size
Date:   Tue,  3 Nov 2020 21:30:50 +0800
Message-Id: <20201103133108.148112-15-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201103133108.148112-1-wqu@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
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

For subpage case, we do the loop to iterate each sector and if we found
any error, we return error.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c54e0ed0b938..0432ca58eade 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2888,9 +2888,11 @@ int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u64 phy_offset,
 			   struct page *page, u64 start, u64 end, int mirror)
 {
 	size_t offset = start - page_offset(page);
+	size_t pg_off;
 	struct inode *inode = page->mapping->host;
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct btrfs_root *root = BTRFS_I(inode)->root;
+	u32 sectorsize = root->fs_info->sectorsize;
 
 	if (PageChecked(page)) {
 		ClearPageChecked(page);
@@ -2910,7 +2912,15 @@ int btrfs_verify_data_csum(struct btrfs_io_bio *io_bio, u64 phy_offset,
 	}
 
 	phy_offset >>= root->fs_info->sectorsize_bits;
-	return check_data_csum(inode, io_bio, phy_offset, page, offset);
+	for (pg_off = offset; pg_off < end - page_offset(page);
+	     pg_off += sectorsize, phy_offset++) {
+		int ret;
+
+		ret = check_data_csum(inode, io_bio, phy_offset, page, pg_off);
+		if (ret < 0)
+			return -EIO;
+	}
+	return 0;
 }
 
 /*
-- 
2.29.2

