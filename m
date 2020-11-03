Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0082A4689
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 14:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbgKCNb5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 08:31:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:44700 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729355AbgKCNbw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Nov 2020 08:31:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604410310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iVfCxhdW+91afVmj5+J1Nffb4dwJMeSGJIR4/4aitvA=;
        b=RA5J2nac2m6j/daZluo32c0GJxWy2uGTYAwM8u524gLjCjRqcCQ6fkrLkLerzPcIlvCATi
        Kyg6Uy1NWYLMJfnsA7FWczWUSDZw7YVeDqv99jmntt6jvce/BQeTtr2UiH/lT0oKJ4Hhbx
        OX3ngxGw9wj2JxGd4luUvy54qRkOQ0s=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BFE51ABF4;
        Tue,  3 Nov 2020 13:31:50 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 11/32] btrfs: disk-io: make csum_tree_block() handle sectorsize smaller than page size
Date:   Tue,  3 Nov 2020 21:30:47 +0800
Message-Id: <20201103133108.148112-12-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201103133108.148112-1-wqu@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For subpage size support, we only need to handle the first page.

To make the code work for both cases, we modify the following behaviors:

- num_pages calcuation
  Instead of "nodesize >> PAGE_SHIFT", we go
  "DIV_ROUND_UP(nodesize, PAGE_SIZE)", this ensures we get at least one
  page for subpage size support, while still get the same result for
  regular page size.

- The length for the first run
  Instead of PAGE_SIZE - BTRFS_CSUM_SIZE, we go min(PAGE_SIZE, nodesize)
  - BTRFS_CSUM_SIZE.
  This allows us to handle both cases well.

- The start location of the first run
  Instead of always use BTRFS_CSUM_SIZE as csum start position, add
  offset_in_page(eb->start) to get proper offset for both cases.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/disk-io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 1b527b2d16d8..9a72cb5ef31e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -211,16 +211,16 @@ void btrfs_set_buffer_lockdep_class(u64 objectid, struct extent_buffer *eb,
 static void csum_tree_block(struct extent_buffer *buf, u8 *result)
 {
 	struct btrfs_fs_info *fs_info = buf->fs_info;
-	const int num_pages = fs_info->nodesize >> PAGE_SHIFT;
+	const int num_pages = DIV_ROUND_UP(fs_info->nodesize, PAGE_SIZE);
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	char *kaddr;
 	int i;
 
 	shash->tfm = fs_info->csum_shash;
 	crypto_shash_init(shash);
-	kaddr = page_address(buf->pages[0]);
+	kaddr = page_address(buf->pages[0]) + offset_in_page(buf->start);
 	crypto_shash_update(shash, kaddr + BTRFS_CSUM_SIZE,
-			    PAGE_SIZE - BTRFS_CSUM_SIZE);
+		min_t(u32, PAGE_SIZE, fs_info->nodesize) - BTRFS_CSUM_SIZE);
 
 	for (i = 1; i < num_pages; i++) {
 		kaddr = page_address(buf->pages[i]);
-- 
2.29.2

