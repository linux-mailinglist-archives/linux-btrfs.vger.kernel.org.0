Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68AFD3D92E5
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jul 2021 18:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237456AbhG1QL1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Jul 2021 12:11:27 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42944 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237503AbhG1QLV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Jul 2021 12:11:21 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BAE441FFD6;
        Wed, 28 Jul 2021 16:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627488678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=y1sdxzbGBABVjokd+1EaKmbi+dfUGIHC5EMvmm6bTtk=;
        b=B9egfmdOTdR+pfRcc0Z7mtAFlyaMWPx6ZMaIrB7IWzvVe64i5rVZYc7MbG36Yd6e0U1OgS
        gJQMh4dsVfcKygREzduDLpqheLrMaykIStBUuQ1XlLETNBrwg0cZBCgvdykdv2xGJ08AwI
        cI4Rkc95VLyNIFWCpMirlVpuUUeVwpQ=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id B2170A3B8D;
        Wed, 28 Jul 2021 16:11:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C9ADFDA8A7; Wed, 28 Jul 2021 18:08:33 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     gustavo@embeddedor.com, wqu@suse.com,
        David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: calculate number of eb pages properly in csum_tree_block
Date:   Wed, 28 Jul 2021 18:08:00 +0200
Message-Id: <20210728160800.21341-1-dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Building with -Warray-bounds on systems with 64K pages there's a
warning:

  fs/btrfs/disk-io.c: In function ‘csum_tree_block’:
  fs/btrfs/disk-io.c:226:34: warning: array subscript 1 is above array bounds of ‘struct page *[1]’ [-Warray-bounds]
    226 |   kaddr = page_address(buf->pages[i]);
        |                        ~~~~~~~~~~^~~
  ./include/linux/mm.h:1630:48: note: in definition of macro ‘page_address’
   1630 | #define page_address(page) lowmem_page_address(page)
        |                                                ^~~~
  In file included from fs/btrfs/ctree.h:32,
                   from fs/btrfs/disk-io.c:23:
  fs/btrfs/extent_io.h:98:15: note: while referencing ‘pages’
     98 |  struct page *pages[1];
        |               ^~~~~

The compiler has no way to know that in that case the nodesize is exactly
PAGE_SIZE, so the resulting number of pages will be correct (1).

Let's use num_extent_pages that makes the case nodesize == PAGE_SIZE
explicitly 1.

Reported-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b75ffc1214ed..2dd56ee23b35 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -210,7 +210,7 @@ void btrfs_set_buffer_lockdep_class(u64 objectid, struct extent_buffer *eb,
 static void csum_tree_block(struct extent_buffer *buf, u8 *result)
 {
 	struct btrfs_fs_info *fs_info = buf->fs_info;
-	const int num_pages = fs_info->nodesize >> PAGE_SHIFT;
+	const int num_pages = num_extent_pages(buf);
 	const int first_page_part = min_t(u32, PAGE_SIZE, fs_info->nodesize);
 	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
 	char *kaddr;
-- 
2.31.1

