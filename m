Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB30F70D6F9
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 10:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbjEWIP4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 04:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235398AbjEWIPY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 04:15:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D533EE66
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 01:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=IUmTL5+pWvpwNn1uvL4NqYHkpeBI72qFbIWfkPv20CY=; b=yEmp79myg84O6IOBUO1e6E9u/7
        CryiiXpkHEt6z/iKeFrHAELCqHGvBBnWpXf8eMGkl9qQL5qauceISW0t9+0wjNkxB5343c5UECHeZ
        5Uapzxb9mGfYdn+V8J+YO14y5gu17GlDKns6M/DLyweijMmSeTRNAIvAqLaromb7dNb/c/GwcioTb
        li6OmVgXnRXhOcLZyEQsgeXF4fK48VbDH20Dw59sxOTKwg1VrNNh/ANp2NBo8Tlkxh0O2tJBDvh1J
        YHBlPMt6fEYkgDyZrNe6hwHPsVc8ylaxKDm/Y3uYLz2aKWil4TDuQH2BZVXDPD7X1xCVy5bAjYycR
        EVlnL6lA==;
Received: from [2001:4bb8:188:23b2:6ade:85c9:530f:6eb0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q1N9A-009OTS-22;
        Tue, 23 May 2023 08:13:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 03/16] btrfs: unify fsverify vs other read error handling in end_page_read
Date:   Tue, 23 May 2023 10:13:09 +0200
Message-Id: <20230523081322.331337-4-hch@lst.de>
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

Don't special case the fsverify error handling and clear the uptodate
bit for them as well like other readpage implementations (iomap, buffer,
mpage) do.

Fixes: 146054090b08 ("btrfs: initial fsverity support")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index fc48888742debd..4297478a7a625d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -497,12 +497,8 @@ static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
 	ASSERT(page_offset(page) <= start &&
 	       start + len <= page_offset(page) + PAGE_SIZE);
 
-	if (uptodate) {
-		if (!btrfs_verify_page(page, start)) {
-			btrfs_page_set_error(fs_info, page, start, len);
-		} else {
-			btrfs_page_set_uptodate(fs_info, page, start, len);
-		}
+	if (uptodate && btrfs_verify_page(page, start)) {
+		btrfs_page_set_uptodate(fs_info, page, start, len);
 	} else {
 		btrfs_page_clear_uptodate(fs_info, page, start, len);
 		btrfs_page_set_error(fs_info, page, start, len);
-- 
2.39.2

