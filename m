Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED236A45BD
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Feb 2023 16:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjB0PRN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Feb 2023 10:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjB0PRL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Feb 2023 10:17:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25CE2278E
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Feb 2023 07:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=EUGIVIFE0dVqppB4JfOTcmeQGXbbDEBByUg9Xo7BzFw=; b=3b9yAaBlA400pi8TBcIWT6pgPO
        nNOCZ1Lp+nhNPKN/82jaZAEbWJ/k9PH7zQ2uo5mTMMEU092/DsYce+cTNGBrBOIUJ0/y71PY0U2+N
        cC4Xdy2Yp+Zb0gZKsMWGNLapFSDhsx2pUTZWPElIuX4eNwYSXv8VGMw5KY7l9EWdG5IVaQP/p762c
        pNcE3zcrZnwb1DwoEXo5xABTZNmFwn0Ay947Kw/5GmhL2XTWJZ8Vd1sbsPD0Jcu03AFdMFbi/ne1w
        fmmpuwC+2CHQWRFQeNrN44tPRjjaQ05xOkpN+iCvXONE8uH2t+ALM8r4awqnwdVMSbK2/qjmyulYc
        vEQ0nZCQ==;
Received: from [136.36.117.140] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWfFR-00AAsR-1C; Mon, 27 Feb 2023 15:17:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 01/12] btrfs: don't set force_bio_submit in read_extent_buffer_subpage
Date:   Mon, 27 Feb 2023 08:16:53 -0700
Message-Id: <20230227151704.1224688-2-hch@lst.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230227151704.1224688-1-hch@lst.de>
References: <20230227151704.1224688-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When read_extent_buffer_subpage calls submit_extent_page, it does
so on a freshly initialized btrfs_bio_ctrl structure that can't have
a valid bio to submit.  Clear the force_bio_submit parameter to false
as there is nothing to submit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1034e9c86e9bd4..90842f5a978931 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4448,7 +4448,7 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 	btrfs_subpage_start_reader(fs_info, page, eb->start, eb->len);
 	ret = submit_extent_page(REQ_OP_READ, NULL, &bio_ctrl,
 				 eb->start, page, eb->len,
-				 eb->start - page_offset(page), 0, true);
+				 eb->start - page_offset(page), 0, false);
 	if (ret) {
 		/*
 		 * In the endio function, if we hit something wrong we will
-- 
2.39.1

