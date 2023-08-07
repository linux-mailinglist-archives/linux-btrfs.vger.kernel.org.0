Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67DC772A37
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Aug 2023 18:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjHGQMt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Aug 2023 12:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjHGQMs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Aug 2023 12:12:48 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC205E76
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Aug 2023 09:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691424766; x=1722960766;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hEywDfmvO3mobl2uiu8JD84L3g+QIR8D8FwM+TiwcvE=;
  b=iScAW44IErUlJqoxJhscOlnH9yGH+KvEnnVZICWi2B7BZ/5zq01hKdEf
   PGvrYn4vb1GvWdMqoHL8uNnOhiOZAJsE713bOYGSBOmh/zuPpILT66+8Z
   tmbQq0vhns7uYnqIybshZKDp+U34b+aGtMwVlr1WXFv/iww+69cr3NTnT
   NdxhZZmRd2G2J7PyhuHHeQnY4xj2OUg3uQtjEISJ0mjznlpj6vNbdWhQ1
   n+fpM/o+xlIPUhscEUMCUpEKXa0MwpzmfYe4shLYUQYCFbsBIfrsxlOcm
   8gKfzzH6ZSUad1zpWVThbj2254ucUNS6rp93cKCh1zNcFYwaxgDsr3K21
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,262,1684771200"; 
   d="scan'208";a="240710983"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2023 00:12:46 +0800
IronPort-SDR: aY/BE4pFqEI1c8iQhmWEYQz738Bg64hEogXtwrkgBrSAZvtAP0vrCWWu+n6cBDqo38E/ganuw7
 lcO134zfCV6r/k0ICz36OpyOB6KxfRQHX3c/Tve2fKShjXTBj3/AcjFD1VBjiEFOHAQGE8tBuA
 BZOEn2JhbvTs1N9Dx/j77fsUkDTU6luGU/DDVakyTaku8ejF+MJ16xQv0j6rNP5NuhP2beQ7+W
 g7K/GyfakEuoDfiYCkAKKTWP2eTQlFYzt6lri51w16es6Xc4ksJrXA8btJiqrBDgTCspsHGkHa
 TDg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Aug 2023 08:26:14 -0700
IronPort-SDR: nVMXp/mkvL1brcCRlHcet2/qX1q3UniVFgGFYf74WFDa2zmQGqS1St4bC2O5TDxBm4+tsezJgD
 NFyPpucXv8qXVt6rDMWWg129cI4FIZwYBjijHQMYV3oe4e58wfAD5cWK9ChBamOSZ3pD2MfU/M
 pLdhMmPDf8x6oTWjfF+A9gvNFgkoWj6fKPyffUVrXPEAuER3A6p6BXXUtxyDDs/sxMm2J414CE
 3iXgJhIetYuLZeATsbAL8oa7UVxVwMEq0NvQHJsGuIuxQNDVLjwbPtpFGdjWYR1gCgQBGQ1qMv
 oFQ=
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.46])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Aug 2023 09:12:46 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     hch@infradead.org, josef@toxicpanda.com, dsterba@suse.cz,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 01/10] btrfs: introduce struct to consolidate extent buffer write context
Date:   Tue,  8 Aug 2023 01:12:31 +0900
Message-ID: <501942a77f2f0b80705f158cec13ba5e7777be3d.1691424260.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691424260.git.naohiro.aota@wdc.com>
References: <cover.1691424260.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent_io.c | 14 +++++++-------
 fs/btrfs/extent_io.h |  5 +++++
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 177d65d51447..5905d2d42aab 100644
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
@@ -1861,7 +1861,7 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 int btree_write_cache_pages(struct address_space *mapping,
 				   struct writeback_control *wbc)
 {
-	struct extent_buffer *eb_context = NULL;
+	struct btrfs_eb_write_context ctx = { .wbc = wbc };
 	struct btrfs_fs_info *fs_info = BTRFS_I(mapping->host)->root->fs_info;
 	int ret = 0;
 	int done = 0;
@@ -1903,7 +1903,7 @@ int btree_write_cache_pages(struct address_space *mapping,
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

