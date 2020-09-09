Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8525262C76
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Sep 2020 11:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgIIJtg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Sep 2020 05:49:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:53988 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728325AbgIIJtU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 9 Sep 2020 05:49:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9EF95B15E;
        Wed,  9 Sep 2020 09:49:19 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 01/10] btrfs: Remove btree_readpage
Date:   Wed,  9 Sep 2020 12:49:05 +0300
Message-Id: <20200909094914.29721-2-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200909094914.29721-1-nborisov@suse.com>
References: <20200909094914.29721-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

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

