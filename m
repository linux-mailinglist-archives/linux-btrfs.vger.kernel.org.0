Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC6A3BB501
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jul 2021 04:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhGECDz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 4 Jul 2021 22:03:55 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53474 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhGECDx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 4 Jul 2021 22:03:53 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 20DC12264A
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jul 2021 02:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625450476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+99e25y+ynUz+vYPwDfXy1RK4PjQ5j7RoOFAXVOo5WI=;
        b=Bn/eOVtcvPyJmSrMX8m/vqkfRygJnL9kb+0JVsdSN6hErw5PA6JROpcNYm5o5FARmmEbR+
        pXIll3TkcaXeVrGkpZbuAwY2incC7+dMf37LQh/a/kqyc2L5Fc/7WtCFT66hymDJidhVKd
        EIxnytyHj5ug8SpuXAxyQuCRGn0fh84=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E51213522
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jul 2021 02:01:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gGWFCOtn4mAVSQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Jul 2021 02:01:15 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v6 02/15] btrfs: remove the GFP_HIGHMEM flag for compression code
Date:   Mon,  5 Jul 2021 10:00:57 +0800
Message-Id: <20210705020110.89358-3-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210705020110.89358-1-wqu@suse.com>
References: <20210705020110.89358-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This allows later decompress functions to get rid of kmap()/kunmap()
pairs.

And since all other filesystems are getting rid of HIGHMEM, it should
not be a problem for btrfs.

Although we removed the HIGHMEM allocation, we still keep the
kmap()/kunmap() pairs.
They will be removed when involved functions are refactored later.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 3 +--
 fs/btrfs/lzo.c         | 4 ++--
 fs/btrfs/zlib.c        | 6 +++---
 fs/btrfs/zstd.c        | 6 +++---
 4 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 19da933c5f1c..8318e56b5ab4 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -724,8 +724,7 @@ blk_status_t btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
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
2.32.0

