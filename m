Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EEE717696
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 08:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbjEaGFZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 02:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbjEaGFY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 02:05:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4BE11C
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 23:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=0qRdnFp6DifbrvpkW0NoRBfwKtfOgSAqng2+KsGs0gw=; b=3TqdFzXQpXYILZl+PB6x8nl37B
        SLz77qf9iw5G7SSwpOMpqLyL2jNLYOM08eRAJqY3kX0WNWVWu5iwctFo8BhFqpsbp9HFSSGP/FFax
        4BS40BB6x57GgdXLVPXxisQALSV+mXcB8prkh1OWdngcaO4jsEOaFFIwW2iOlYK4AiJn+cJE5Cgx+
        Kq5b8phnxl2JYeSaGtv6EK6/2s2N6DSE3+oJeUCLOl/48iK9yP33FvELqGmgATiQOLVUA2lAwMGe1
        l35qDm1xOQ2cpeols0IVoB06gaRba0Hkeii1cwy09CtGBusjNmr3Jv2hdqhKol6z4tRJq12cnER5i
        N9qWK9VQ==;
Received: from [2001:4bb8:182:6d06:f5c3:53d7:b5aa:b6a7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4ExV-00GF4B-0g;
        Wed, 31 May 2023 06:05:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 04/16] btrfs: don't check PageError in btrfs_verify_page
Date:   Wed, 31 May 2023 08:04:53 +0200
Message-Id: <20230531060505.468704-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531060505.468704-1-hch@lst.de>
References: <20230531060505.468704-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_verify_page is called from the readpage completion handler, which
is only used to read pages, or parts of pages that aren't uptodate yet.
The only case where PageError could be set on a page in btrfs is if we
had a previous writeback error, but in that case we won't called readpage
on it, as it has previously been marked uptodate.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a943a66224891a..178e8230c28af9 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -484,7 +484,7 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 static bool btrfs_verify_page(struct page *page, u64 start)
 {
 	if (!fsverity_active(page->mapping->host) ||
-	    PageError(page) || PageUptodate(page) ||
+	    PageUptodate(page) ||
 	    start >= i_size_read(page->mapping->host))
 		return true;
 	return fsverity_verify_page(page);
-- 
2.39.2

