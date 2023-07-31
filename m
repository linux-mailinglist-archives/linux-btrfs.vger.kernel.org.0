Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FE9769F41
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Jul 2023 19:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbjGaRUD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Jul 2023 13:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbjGaRTl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Jul 2023 13:19:41 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4CD4487
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Jul 2023 10:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690823919; x=1722359919;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H5O5/TNjnGB0hTLhYOqlAY6fg6UplW4pIlYJuBPhwXY=;
  b=OivaPpiESA0R9yIUzSYWlvDocyw39/qvldsfPvU24cQ/Y94jwL1dz4nx
   91a5H76XacmP+HaGDWZqWG08OgMCXk+K+8uGrsf9wywvxofoXoxffs+X7
   YTu8SQe4exVThx9l2yrCxpvj9mWDfIKJg5RR/ROhoiEpdhQPNcTVFMaez
   pn8Z2pKukrpv9IXFsqX9AfG/J9umRmGHQM8v5ISZPD7/HftiGFe80L+iX
   3Jod3ykMh6Qdj9e8D5rl3BamBfdSXni/ycyYj97C0AnBv/WOi19uEGhKl
   Rt9L0UIlOMlPn9u7ADgyi/nNY+xPmWyHTlHN7g1OhO1Mc8jychkpHNj5Z
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,245,1684771200"; 
   d="scan'208";a="244269550"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2023 01:17:33 +0800
IronPort-SDR: mRcKle7LDQQRsblXjjWuPK4ITKLWJiGtMoWLlvXLENI03/2YbQpgdPllsv+tKVPQxoFZm5r1GK
 29XFZ7nkDswCM1lJV5Zm1Rc8CaObS8BnySy+gS1s4V1L1g2KuvRZGQaBHxihzhLcWAOv/GU4/m
 DqhRHMfPeFBp47zL8Z6g5KoRMVcXcaLpW4FbPTyfRTTJgwgcWAZdUREP68EUtYIlhemyRSQHQm
 dypOJqXkQk5UjA68Fbi2i7qqkDg4FH5nxw6kvMuPOeAZO2jKl1WKT30hgJX2E/dN/O4ZHVryH3
 LUk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Jul 2023 09:31:10 -0700
IronPort-SDR: F94xRnNSW3g6o+CYzCM4nN9qNT8RT4R1UTEK3Go/EjWx0abhwMxHRV/xF+KpCkf2ZL7mPcV7AV
 yUY2CUo71n1ahi84If+s3nY/a1528Yf7noEhOpqhzU8RaM3P+P+AbQcVyGuoN5Pxr8kRpziASf
 2OGLrNL7X1elcEHPL75p0atAFyU3/leeu+HnXoe4i2wtJECkLA+wUbC97EXv9Yl7/Q7J07JDox
 WKYUbheuWa03mk11FaDQBhrJjZZLT2nOPNEGoV3Gt8UqctP8lIXuxO6ZYUUlpYW19R6BTYXqGi
 Mj0=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.18])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 Jul 2023 10:17:33 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     hch@infradead.org, josef@toxicpanda.com, dsterba@suse.cz,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 01/10] btrfs: introduce struct to consolidate extent buffer write context
Date:   Tue,  1 Aug 2023 02:17:10 +0900
Message-ID: <1cc8f3a21680d196751171f09ddb77b9c14a5b9a.1690823282.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690823282.git.naohiro.aota@wdc.com>
References: <cover.1690823282.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Introduce btrfs_eb_write_context to consolidate writeback_control and the
exntent buffer context.

This will help adding a block group context as well.

While at it, move the eb context setting before
btrfs_check_meta_write_pointer(). We can set it here because we anyway need
to skip pages in the same eb if that eb is rejected by
btrfs_check_meta_write_pointer().

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent_io.c | 17 ++++++++++-------
 fs/btrfs/extent_io.h |  5 +++++
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 177d65d51447..40633bc15c97 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1784,9 +1784,9 @@ static int submit_eb_subpage(struct page *page, struct writeback_control *wbc)
  * previous call.
  * Return <0 for fatal error.
  */
-static int submit_eb_page(struct page *page, struct writeback_control *wbc,
-			  struct extent_buffer **eb_context)
+static int submit_eb_page(struct page *page, struct btrfs_eb_write_context *ctx)
 {
+	struct writeback_control *wbc = ctx->wbc;
 	struct address_space *mapping = page->mapping;
 	struct btrfs_block_group *cache = NULL;
 	struct extent_buffer *eb;
@@ -1815,7 +1815,7 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 		return 0;
 	}
 
-	if (eb == *eb_context) {
+	if (eb == ctx->eb) {
 		spin_unlock(&mapping->private_lock);
 		return 0;
 	}
@@ -1824,6 +1824,8 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 	if (!ret)
 		return 0;
 
+	ctx->eb = eb;
+
 	if (!btrfs_check_meta_write_pointer(eb->fs_info, eb, &cache)) {
 		/*
 		 * If for_sync, this hole will be filled with
@@ -1837,8 +1839,6 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 		return ret;
 	}
 
-	*eb_context = eb;
-
 	if (!lock_extent_buffer_for_io(eb, wbc)) {
 		btrfs_revert_meta_write_pointer(cache, eb);
 		if (cache)
@@ -1861,7 +1861,10 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 int btree_write_cache_pages(struct address_space *mapping,
 				   struct writeback_control *wbc)
 {
-	struct extent_buffer *eb_context = NULL;
+	struct btrfs_eb_write_context ctx = {
+		.wbc = wbc,
+		.eb = NULL,
+	};
 	struct btrfs_fs_info *fs_info = BTRFS_I(mapping->host)->root->fs_info;
 	int ret = 0;
 	int done = 0;
@@ -1903,7 +1906,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 		for (i = 0; i < nr_folios; i++) {
 			struct folio *folio = fbatch.folios[i];
 
-			ret = submit_eb_page(&folio->page, wbc, &eb_context);
+			ret = submit_eb_page(&folio->page, &ctx);
 			if (ret == 0)
 				continue;
 			if (ret < 0) {
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index adda14c1b763..e243a8eac910 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -93,6 +93,11 @@ struct extent_buffer {
 #endif
 };
 
+struct btrfs_eb_write_context {
+	struct writeback_control *wbc;
+	struct extent_buffer *eb;
+};
+
 /*
  * Get the correct offset inside the page of extent buffer.
  *
-- 
2.41.0

