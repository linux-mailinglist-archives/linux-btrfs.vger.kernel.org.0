Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954C270D6F6
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 10:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbjEWIPz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 04:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbjEWIPX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 04:15:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808E5E45
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 01:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=JXJubYclaxIEtCd1baDv6x3BrOt9KI7/Qw4mBSHvllU=; b=ue264ARyzASJJTGw/GnJjcd3xZ
        x88DbDOdCBuoTfK1u7m0ixuHrL4AH1Hk/mFcNrGlb2xquuwGq0H2H06fbMYrEZBWjIXxWavV8wgXI
        VbaFYMUSwIjnb/hNkZjdnu9VBgT5vKRrMgpMN0QdLbSbkAmi5KEsO7LjJ68a2eC0ep6D1sbjQpzUF
        IjvmGT/Yh8tFpA4q8W+ahZ6nFrS5jhCoIJx/GybRpjOKmFjd2g82cc/Zuxs4N/O1ufGU5AVRpmk2n
        qxmAZ1VUEAxGMVdwd7blYp/GcuA77U5Tze7yRzpoFcQb0DAnoB21wax+TT1p2bWu2AZgaBL2uEzC2
        RIYlJJSg==;
Received: from [2001:4bb8:188:23b2:6ade:85c9:530f:6eb0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1N98-009OTA-02;
        Tue, 23 May 2023 08:13:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 02/16] btrfs: factor out a btrfs_verify_page helper
Date:   Tue, 23 May 2023 10:13:08 +0200
Message-Id: <20230523081322.331337-3-hch@lst.de>
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

Split all the conditionals for the fsverity calls in end_page_read into
a btrfs_verify_page helper to keep the code readable and make additional
refacoring easier.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c1b0ca94be34e1..fc48888742debd 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -481,6 +481,15 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 			       start, end, page_ops, NULL);
 }
 
+static int btrfs_verify_page(struct page *page, u64 start)
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

