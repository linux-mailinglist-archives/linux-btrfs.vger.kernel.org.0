Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1833BF94E
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jul 2021 13:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhGHLuZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jul 2021 07:50:25 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56146 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbhGHLuZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jul 2021 07:50:25 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A6A1A201B9;
        Thu,  8 Jul 2021 11:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625744862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EUBU1jmEaEEyRqmsER6L0TdoJSggSox1IKLZ8pejV7c=;
        b=GHfPk0fRVEhGHC3mMKonwnT+ClnYo2fl7rsspeeLQC6n7+D6km55do+Oi4OxMd76rdqgXN
        y+C7RF84QEpdj/0J5URgyUBOFasb2rwqj22v50hZavP7tNwJYKe9i7PpLqx2Q45voPX1Wm
        45GFeTGBXXujQYi0Mvwb7laSAcVIwcQ=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A0E2EA3B9C;
        Thu,  8 Jul 2021 11:47:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8D327DAF79; Thu,  8 Jul 2021 13:45:08 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/6] btrfs: drop from __GFP_HIGHMEM all allocations
Date:   Thu,  8 Jul 2021 13:45:08 +0200
Message-Id: <9cab2dea36bf688d8bfbb876ee1f24daee752200.1625043706.git.dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1625043706.git.dsterba@suse.com>
References: <cover.1625043706.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The highmem flag is used for allocating pages for compression and for
raid56 pages. The high memory makes sense on 32bit systems but is not
without problems. On 64bit system's it's just another layer of wrappers.

The time the pages are allocated for compression or raid56 is relatively
short (about a transaction commit), so the pages are not blocked
indefinitely. As the number of pages depends on the amount of data being
written/read, there's a theoretical problem. A fast device on a 32bit
system could use most of the low memory pool, while with the highmem
allocation that would not happen. This was possibly the original idea
long time ago, but nowadays we optimize for 64bit systems.

This patch removes all usage of the __GFP_HIGHMEM flag for page
allocation, the kmap/kunmap are still in place and will be removed in
followup patches. Remaining is masking out the bit in
alloc_extent_state and __lookup_free_space_inode, that can safely stay.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c |  3 +--
 fs/btrfs/lzo.c         |  4 ++--
 fs/btrfs/raid56.c      | 10 +++++-----
 fs/btrfs/zlib.c        |  6 +++---
 fs/btrfs/zstd.c        |  6 +++---
 5 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 9a023ae0f98b..8cf5903a5be2 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -721,8 +721,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 		goto fail1;
 
 	for (pg_index = 0; pg_index < nr_pages; pg_index++) {
-		cb->compressed_pages[pg_index] = alloc_page(GFP_NOFS |
-							      __GFP_HIGHMEM);
+		cb->compressed_pages[pg_index] = alloc_page(GFP_NOFS);
 		if (!cb->compressed_pages[pg_index]) {
 			faili = pg_index - 1;
 			ret = BLK_STS_RESOURCE;
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index cd042c7567a4..2bebb60c5830 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -146,7 +146,7 @@ int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
 	 * store the size of all chunks of compressed data in
 	 * the first 4 bytes
 	 */
-	out_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
+	out_page = alloc_page(GFP_NOFS);
 	if (out_page == NULL) {
 		ret = -ENOMEM;
 		goto out;
@@ -216,7 +216,7 @@ int lzo_compress_pages(struct list_head *ws, struct address_space *mapping,
 					goto out;
 				}
 
-				out_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
+				out_page = alloc_page(GFP_NOFS);
 				if (out_page == NULL) {
 					ret = -ENOMEM;
 					goto out;
diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 244d499ebc72..a40a45a007d4 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1035,7 +1035,7 @@ static int alloc_rbio_pages(struct btrfs_raid_bio *rbio)
 	for (i = 0; i < rbio->nr_pages; i++) {
 		if (rbio->stripe_pages[i])
 			continue;
-		page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
+		page = alloc_page(GFP_NOFS);
 		if (!page)
 			return -ENOMEM;
 		rbio->stripe_pages[i] = page;
@@ -1054,7 +1054,7 @@ static int alloc_rbio_parity_pages(struct btrfs_raid_bio *rbio)
 	for (; i < rbio->nr_pages; i++) {
 		if (rbio->stripe_pages[i])
 			continue;
-		page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
+		page = alloc_page(GFP_NOFS);
 		if (!page)
 			return -ENOMEM;
 		rbio->stripe_pages[i] = page;
@@ -2300,7 +2300,7 @@ static int alloc_rbio_essential_pages(struct btrfs_raid_bio *rbio)
 			if (rbio->stripe_pages[index])
 				continue;
 
-			page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
+			page = alloc_page(GFP_NOFS);
 			if (!page)
 				return -ENOMEM;
 			rbio->stripe_pages[index] = page;
@@ -2350,14 +2350,14 @@ static noinline void finish_parity_scrub(struct btrfs_raid_bio *rbio,
 	if (!need_check)
 		goto writeback;
 
-	p_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
+	p_page = alloc_page(GFP_NOFS);
 	if (!p_page)
 		goto cleanup;
 	SetPageUptodate(p_page);
 
 	if (has_qstripe) {
 		/* RAID6, allocate and map temp space for the Q stripe */
-		q_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
+		q_page = alloc_page(GFP_NOFS);
 		if (!q_page) {
 			__free_page(p_page);
 			goto cleanup;
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index c3fa7d3fa770..2c792bc5a987 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -121,7 +121,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 	workspace->strm.total_in = 0;
 	workspace->strm.total_out = 0;
 
-	out_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
+	out_page = alloc_page(GFP_NOFS);
 	if (out_page == NULL) {
 		ret = -ENOMEM;
 		goto out;
@@ -202,7 +202,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 				ret = -E2BIG;
 				goto out;
 			}
-			out_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
+			out_page = alloc_page(GFP_NOFS);
 			if (out_page == NULL) {
 				ret = -ENOMEM;
 				goto out;
@@ -240,7 +240,7 @@ int zlib_compress_pages(struct list_head *ws, struct address_space *mapping,
 				ret = -E2BIG;
 				goto out;
 			}
-			out_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
+			out_page = alloc_page(GFP_NOFS);
 			if (out_page == NULL) {
 				ret = -ENOMEM;
 				goto out;
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index 3e26b466476a..9451d2bb984e 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -405,7 +405,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 
 
 	/* Allocate and map in the output buffer */
-	out_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
+	out_page = alloc_page(GFP_NOFS);
 	if (out_page == NULL) {
 		ret = -ENOMEM;
 		goto out;
@@ -452,7 +452,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 				ret = -E2BIG;
 				goto out;
 			}
-			out_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
+			out_page = alloc_page(GFP_NOFS);
 			if (out_page == NULL) {
 				ret = -ENOMEM;
 				goto out;
@@ -512,7 +512,7 @@ int zstd_compress_pages(struct list_head *ws, struct address_space *mapping,
 			ret = -E2BIG;
 			goto out;
 		}
-		out_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
+		out_page = alloc_page(GFP_NOFS);
 		if (out_page == NULL) {
 			ret = -ENOMEM;
 			goto out;
-- 
2.31.1

