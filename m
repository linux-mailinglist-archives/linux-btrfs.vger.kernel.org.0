Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00C23BF952
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jul 2021 13:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhGHLue (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jul 2021 07:50:34 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59872 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbhGHLue (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jul 2021 07:50:34 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F19F921FB4;
        Thu,  8 Jul 2021 11:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625744871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9KNKRMG2To+TRgagWwFbTziKkOc5MhFB9f+EBnoslFQ=;
        b=KY4vmffa6tp01G+oq8Ivo2zjXZMx+/ZNU0hpPg+NoNWUghHviTgvqL609uAeQJN0MynVJx
        Q0pkr9+UVdngIHqhtMfJk/XrF6HKGlqf+SnfjuPqfdZwSxP36cik6f3rOYq1NayVMai4cS
        jceyo/NsmFT7H03ZPGscFYpq3jqMYi8=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id EAEE9A3BA1;
        Thu,  8 Jul 2021 11:47:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D726DDAF79; Thu,  8 Jul 2021 13:45:17 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 5/6] btrfs: compression: drop kmap/kunmap from generic helpers
Date:   Thu,  8 Jul 2021 13:45:17 +0200
Message-Id: <f74ceb3249fae88ebe6bc0d288e56bde292ef885.1625043706.git.dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1625043706.git.dsterba@suse.com>
References: <cover.1625043706.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The pages in compressed_pages are not from highmem anymore so we can
drop the mapping for checksum calculation and inline extent.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c | 3 +--
 fs/btrfs/inode.c       | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 8cf5903a5be2..d40c2c878c83 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -172,10 +172,9 @@ static int check_compressed_csum(struct btrfs_inode *inode, struct bio *bio,
 		/* Hash through the page sector by sector */
 		for (pg_offset = 0; pg_offset < bytes_left;
 		     pg_offset += sectorsize) {
-			kaddr = kmap_atomic(page);
+			kaddr = page_address(page);
 			crypto_shash_digest(shash, kaddr + pg_offset,
 					    sectorsize, csum);
-			kunmap_atomic(kaddr);
 
 			if (memcmp(&csum, cb_sum, csum_size) != 0) {
 				btrfs_print_data_csum_error(inode, disk_start,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e6eb20987351..6993f0ffa9f2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -286,9 +286,8 @@ static int insert_inline_extent(struct btrfs_trans_handle *trans,
 			cur_size = min_t(unsigned long, compressed_size,
 				       PAGE_SIZE);
 
-			kaddr = kmap_atomic(cpage);
+			kaddr = page_address(cpage);
 			write_extent_buffer(leaf, kaddr, ptr, cur_size);
-			kunmap_atomic(kaddr);
 
 			i++;
 			ptr += cur_size;
-- 
2.31.1

