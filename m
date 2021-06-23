Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729C13B1387
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jun 2021 07:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhFWF5x (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Jun 2021 01:57:53 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35222 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFWF5w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Jun 2021 01:57:52 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E98021FD45
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Jun 2021 05:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624427734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n/0xu33j7Z+M5mRBiZdFLgQBO529M5ax9gv6Glab24o=;
        b=GOSETx/RSTYU0mofb9lg5o5yvWM1pqhlR0vb6uQrfnNXKnEMjpEDgt/Rkb7Lm3quyHGx8c
        uad3NMv142liL4Q4SvdL5ecTNpJX+DxJC7qlcxrMtxo+WQFvhqkVzMjkFRqcUgjBPrHKwq
        fIhDW2Iwr7bK7SLkuBu/RLE/Cc23NbI=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id EEB90A3B8A
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Jun 2021 05:55:33 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 1/8] btrfs: don't pass compressed pages to btrfs_writepage_endio_finish_ordered()
Date:   Wed, 23 Jun 2021 13:55:22 +0800
Message-Id: <20210623055529.166678-2-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210623055529.166678-1-wqu@suse.com>
References: <20210623055529.166678-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since async_extent holds the compressed page, it would trigger the new
ASSERT() in btrfs_mark_ordered_io_finished() which checks the range is
inside the page.

Since btrfs_writepage_endio_finish_ordered() can accept @page == NULL,
just pass NULL to btrfs_writepage_endio_finish_ordered().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 050c88ab74b5..e102e3672475 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -974,15 +974,12 @@ static noinline void submit_compressed_extents(struct async_chunk *async_chunk)
 				    async_extent->nr_pages,
 				    async_chunk->write_flags,
 				    async_chunk->blkcg_css)) {
-			struct page *p = async_extent->pages[0];
 			const u64 start = async_extent->start;
 			const u64 end = start + async_extent->ram_size - 1;
 
-			p->mapping = inode->vfs_inode.i_mapping;
-			btrfs_writepage_endio_finish_ordered(inode, p, start,
+			btrfs_writepage_endio_finish_ordered(inode, NULL, start,
 							     end, 0);
 
-			p->mapping = NULL;
 			extent_clear_unlock_delalloc(inode, start, end, NULL, 0,
 						     PAGE_END_WRITEBACK |
 						     PAGE_SET_ERROR);
-- 
2.32.0

