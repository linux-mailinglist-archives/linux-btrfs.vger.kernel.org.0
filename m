Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7631127DDFA
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 03:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbgI3Bzu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Sep 2020 21:55:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:49540 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729322AbgI3Bzu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Sep 2020 21:55:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601430948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4PpVl209z3KEQlPi7nxsOc6ZqHyPbggMt6Dqzr4kkZc=;
        b=Wm+6sgTUSh6nnnhCx1cUNnLhaPK5UKfMY6sthBKyDkWH30fRZlORMUTV5id1up7m0LDRAC
        gbwyVgSkWGTYaI6gGuetVL9KR0XyRmAt0cA35jsNkUJWZeaZSEqCUtTJKHERnaQ4lO1mou
        6zjGB0ObabQOL0xp0UNEda88Xr+DQqA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5A61DAE07;
        Wed, 30 Sep 2020 01:55:48 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH v3 02/49] btrfs: use iosize while reading compressed pages
Date:   Wed, 30 Sep 2020 09:54:52 +0800
Message-Id: <20200930015539.48867-3-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930015539.48867-1-wqu@suse.com>
References: <20200930015539.48867-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.de>

While using compression, a submitted bio is mapped with a compressed bio
which performs the read from disk, decompresses and returns uncompressed
data to original bio. The original bio must reflect the uncompressed
size (iosize) of the I/O to be performed, or else the page just gets the
decompressed I/O length of data (disk_io_size). The compressed bio
checks the extent map and get the correct length while performing the
I/O from disk.

This came up in subpage work when only compressed length of the original
bio was filled in the page. This worked correctly for pagesize ==
sectorsize because both compressed and uncompressed data are at pagesize
boundaries, and would end up filling the requested page.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/extent_io.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a940edb1e64f..64f7f61ce718 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3162,7 +3162,6 @@ static int __do_readpage(struct page *page,
 	int nr = 0;
 	size_t pg_offset = 0;
 	size_t iosize;
-	size_t disk_io_size;
 	size_t blocksize = inode->i_sb->s_blocksize;
 	unsigned long this_bio_flag = 0;
 	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
@@ -3228,13 +3227,10 @@ static int __do_readpage(struct page *page,
 		iosize = min(extent_map_end(em) - cur, end - cur + 1);
 		cur_end = min(extent_map_end(em) - 1, end);
 		iosize = ALIGN(iosize, blocksize);
-		if (this_bio_flag & EXTENT_BIO_COMPRESSED) {
-			disk_io_size = em->block_len;
+		if (this_bio_flag & EXTENT_BIO_COMPRESSED)
 			offset = em->block_start;
-		} else {
+		else
 			offset = em->block_start + extent_offset;
-			disk_io_size = iosize;
-		}
 		block_start = em->block_start;
 		if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
 			block_start = EXTENT_MAP_HOLE;
@@ -3323,7 +3319,7 @@ static int __do_readpage(struct page *page,
 		}
 
 		ret = submit_extent_page(REQ_OP_READ | read_flags, NULL,
-					 page, offset, disk_io_size,
+					 page, offset, iosize,
 					 pg_offset, bio,
 					 end_bio_extent_readpage, mirror_num,
 					 *bio_flags,
-- 
2.28.0

