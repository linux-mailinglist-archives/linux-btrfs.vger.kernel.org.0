Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4822717698
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 08:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbjEaGFU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 02:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjEaGFT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 02:05:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEFD11C
        for <linux-btrfs@vger.kernel.org>; Tue, 30 May 2023 23:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=oAVqdlqWdwKkStitJSHtqa34ShHS8IoE+KVEKcpOlsw=; b=R2pUAVtIoMmuiT2wUMzPkffoCV
        ZVTDN8wTHT3cIcyOVW2BNfsCnVkJLXQyXpL2tijOQeGjkKqMFlB27FA8tZ9AVU1l1Mg3BKCBAInkw
        Uba8YRjGt0ZsDqrIqBUU1EvamtprkfUQUojMQucJV4GT9d0N91cZCUuybaWPxsFYkEHFF3f9saP0u
        jtqbH437gRxHoxWxHGxn4+9pNVNmV42LfXOfTnm9DfCOV8jGsnsKBJGQutDHgAU6ufwCUq/gFNfl/
        NM20JXQJ9R86GwToI/jhTid1sQxikbVeDwQpUtq16vWvLIm4/HnKSpJ4phy+BTUZVtKXVfJ6Pc7sE
        uxRKkkLg==;
Received: from [2001:4bb8:182:6d06:f5c3:53d7:b5aa:b6a7] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4ExP-00GF3I-0S;
        Wed, 31 May 2023 06:05:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 02/16] btrfs: factor out a btrfs_verify_page helper
Date:   Wed, 31 May 2023 08:04:51 +0200
Message-Id: <20230531060505.468704-3-hch@lst.de>
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

Split all the conditionals for the fsverity calls in end_page_read into
a btrfs_verify_page helper to keep the code readable and make additional
refacoring easier.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 0726c82db309a2..8e42ce48b52e4a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -481,6 +481,15 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 			       start, end, page_ops, NULL);
 }
 
+static bool btrfs_verify_page(struct page *page, u64 start)
+{
+	if (!fsverity_active(page->mapping->host) ||
+	    PageError(page) || PageUptodate(page) ||
+	    start >= i_size_read(page->mapping->host))
+		return true;
+	return fsverity_verify_page(page);
+}
+
 static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
@@ -489,11 +498,7 @@ static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 	       start + len <= page_offset(page) + PAGE_SIZE);
 
 	if (uptodate) {
-		if (fsverity_active(page->mapping->host) &&
-		    !PageError(page) &&
-		    !PageUptodate(page) &&
-		    start < i_size_read(page->mapping->host) &&
-		    !fsverity_verify_page(page)) {
+		if (!btrfs_verify_page(page, start)) {
 			btrfs_page_set_error(fs_info, page, start, len);
 		} else {
 			btrfs_page_set_uptodate(fs_info, page, start, len);
-- 
2.39.2

