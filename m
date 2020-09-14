Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38AF268894
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Sep 2020 11:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgINJhS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Sep 2020 05:37:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:41180 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbgINJhQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Sep 2020 05:37:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2C5E8AD21;
        Mon, 14 Sep 2020 09:37:31 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 1/9] btrfs: Remove btree_readpage
Date:   Mon, 14 Sep 2020 12:37:03 +0300
Message-Id: <20200914093711.13523-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914093711.13523-1-nborisov@suse.com>
References: <20200914093711.13523-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is no way for this function to be called as ->readpage() since
it's called from
generic_file_buffered_read/filemap_fault/do_read_cache_page/readhead
code. BTRFS doesn't utilize the first 3 for the btree inode and
implements it's owon readhead mechanism. So simply remove the function.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/disk-io.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7147237d9bf0..d63498f3c75f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -949,11 +949,6 @@ static int btree_writepages(struct address_space *mapping,
 	return btree_write_cache_pages(mapping, wbc);
 }
 
-static int btree_readpage(struct file *file, struct page *page)
-{
-	return extent_read_full_page(page, btree_get_extent, 0);
-}
-
 static int btree_releasepage(struct page *page, gfp_t gfp_flags)
 {
 	if (PageWriteback(page) || PageDirty(page))
@@ -993,7 +988,6 @@ static int btree_set_page_dirty(struct page *page)
 }
 
 static const struct address_space_operations btree_aops = {
-	.readpage	= btree_readpage,
 	.writepages	= btree_writepages,
 	.releasepage	= btree_releasepage,
 	.invalidatepage = btree_invalidatepage,
-- 
2.17.1

