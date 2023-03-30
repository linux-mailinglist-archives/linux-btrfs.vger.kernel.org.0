Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B358C6CFB8A
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 08:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjC3GbK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Mar 2023 02:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjC3GbI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Mar 2023 02:31:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CD94C3B
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Mar 2023 23:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=2tOevcsmIsATWobeokHa9OhlXHzX5+w8N9oqbV5Bd3I=; b=HxCIE34meTeJYkADraSzCzSbdK
        I0Y6Y8y1bfsNxwAx1e5RpRPsE3tgOiJ6N4kaZUmXwGyi9J32zD3ZiIB7r/Hlxtu51e9diKj7nPWBG
        9RB9/8n3lWPtzu+6CF7oYaleM8d7ChKXDSe7SX2CAE4mcebvxfa0ecQW7fXI3io23HGqnYR5wkmbv
        pH5+6KmEnjs1QQQ9vCt1Z7d0M1K2rPNeVVHyB34VuXfGbG3RFYRVBNjpBCf++Xre4Y+8xW0pP6ia6
        lhVVzOdGTkdAKwIceWsNKhBLs/wDPHf9wxbMDrzTr9E6sINUR7hk7FTt7rGCgR13kJxirnK1AZUbh
        UmvABpkQ==;
Received: from [182.171.77.115] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1phloQ-002lam-1q;
        Thu, 30 Mar 2023 06:31:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Qu Wenruo <wqu@suse.com>
Subject: [PATCH 02/21] btrfs: fix sub-page error bit in end_bio_subpage_eb_writepage
Date:   Thu, 30 Mar 2023 15:30:40 +0900
Message-Id: <20230330063059.1574380-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330063059.1574380-1-hch@lst.de>
References: <20230330063059.1574380-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Call btrfs_page_clear_uptodate instead of ClearPageUptodate to properly
manage the uptodate bit for the subpage case.

Reported-by: Qu Wenruo <quwenruo.btrfs@gmx.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 302af9b01bda2a..2bc141b3f3bc4b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1914,7 +1914,8 @@ static void end_bio_subpage_eb_writepage(struct btrfs_bio *bbio)
 
 			if (bio->bi_status ||
 			    test_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags)) {
-				ClearPageUptodate(page);
+				btrfs_page_clear_uptodate(fs_info, page,
+							  eb->start, eb->len);
 				set_btree_ioerr(page, eb);
 			}
 
-- 
2.39.2

