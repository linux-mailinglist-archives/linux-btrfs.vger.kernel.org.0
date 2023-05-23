Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBC370D6FA
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 10:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236100AbjEWIQB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 04:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235744AbjEWIPb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 04:15:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA2BE75
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 01:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=z89D5zEJfg+fAuTySzcHbcu3Lw1Db9g2bas+ucs/Rzc=; b=A/OISnxb/AUHva5e4k6ZmhYui0
        J6t+6gdP7iBLvo2AMmindZVzKojezHjuzZcJt2L1H77G8vQonv7waC9s9Trvesudra91cr6RLCI3c
        7kZNnEFeOf6J3jZQxBXqh4jtt9v/xpH6jEawPeeqcYADvozDrn9anGs/AJdb6XZkn7lAX5HLBgKqQ
        YYkiBqR523Aomii0iYcAYQPGDpx6vScaEe+FqIBv4XSVRHmGlYNbJ6kJfZidILRJi692HjhWc6T+N
        STsaG8mtZZHDu4TrNMroo40bDgeEdHQoDml1gwntRfALj5Qk1ZBgSPGLV40KeK5NCoPomATMaAm63
        21BiHpxg==;
Received: from [2001:4bb8:188:23b2:6ade:85c9:530f:6eb0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1N9D-009OTn-0w;
        Tue, 23 May 2023 08:13:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 04/16] btrfs: don't check PageError in btrfs_verify_page
Date:   Tue, 23 May 2023 10:13:10 +0200
Message-Id: <20230523081322.331337-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230523081322.331337-1-hch@lst.de>
References: <20230523081322.331337-1-hch@lst.de>
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
index 4297478a7a625d..b846c46c7a875b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -484,7 +484,7 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 static int btrfs_verify_page(struct page *page, u64 start)
 {
 	if (!fsverity_active(page->mapping->host) ||
-	    PageError(page) || PageUptodate(page) ||
+	    PageUptodate(page) ||
 	    start >= i_size_read(page->mapping->host))
 		return true;
 	return fsverity_verify_page(page);
-- 
2.39.2

