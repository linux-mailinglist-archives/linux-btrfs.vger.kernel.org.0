Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D947D6B8B0C
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 07:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjCNGRQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 02:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjCNGRO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 02:17:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA96F79B0F
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Mar 2023 23:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=aZuiwvPIfBQ8r9trPk6IpxO8Goh3uSw8ist6yJ2ZzDw=; b=fpJPQcQBfmV+BsU0jCMVM6hO/7
        MTpAmoNG4X+I69m/y5+E7QdQBoGos1hrYTg5A3vRK1dRvm1W2meSdXO+KEcwB24YxGzIlHfsHfVKC
        xYyzOrhz2igGBOjxO2JQE+h5lZ/epUQ1WxOLuQCzCH6Y7rJwuXkW7F4iDz/uU6JZRDgHUSmTST4ss
        29ekNlrViGUgzayigsOKsodA4SEk/DUTkepZ4C3pikbFI6PeX4h6NXSoc5VI8IhU/oawPWnk72VcT
        Ap5QaL1ZSYxIgrfi7Nsi/+t/v5mUNKJx+kiaPiH1swIW+eb+WtZy9LYPPPi/vTtzeXyRuI8YfhTU7
        KpHEg0bQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pbxy5-009AgW-BX; Tue, 14 Mar 2023 06:17:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: [PATCH 02/21] btrfs: fix sub-page error bit in end_bio_subpage_eb_writepage
Date:   Tue, 14 Mar 2023 07:16:36 +0100
Message-Id: <20230314061655.245340-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314061655.245340-1-hch@lst.de>
References: <20230314061655.245340-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Call btrfs_page_clear_uptodate instead of ClearPageUptodate to properly
manage the error bit for the subpage case.

Reported-by: Qu Wenruo <quwenruo.btrfs@gmx.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
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

