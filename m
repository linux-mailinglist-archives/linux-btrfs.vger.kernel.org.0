Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D506A45C3
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Feb 2023 16:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjB0PRY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Feb 2023 10:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjB0PRP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Feb 2023 10:17:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FB8227A9
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Feb 2023 07:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=e5hvAIEBDieGmaWB2f02k28N/cgM1JkwVknhcs1Dxas=; b=Yv+vPqXlZ+O4UG8dnR+cylX3EF
        EA06L/TKSCY9Gn3QwGK03Z6zs+ypcDwC9paL1R6riLJRz4FC89cBGPCnlvL8gBAVyYHGmchDE918K
        6K7R3te7fGfOI/pCzAjsuLycHGH62xpNUgLoVmfldzquZq7KWtqyQ8PrwEWbXd/IKbXsRoGFsLi+b
        kaSY0PVJFZ5f7ibudPNZuB9ecB7kBy++haHiahnXx9oQKhbuwXCELraDM2V2l6h9C0HaTsiujb3HO
        uWuo0QLrXHRG0Ch9etU6CCfZAFnRzJnbmDqH/DDk/bhFZKAao5JFQJB1cHHxsrbjMXy9Ke1td0CP8
        erjLkB8A==;
Received: from [136.36.117.140] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWfFV-00AAtr-96; Mon, 27 Feb 2023 15:17:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 10/12] btrfs: simplify the error handling in __extent_writepage_io
Date:   Mon, 27 Feb 2023 08:17:02 -0700
Message-Id: <20230227151704.1224688-11-hch@lst.de>
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

Remove the has_error and saved_ret variables, and just jump to
a goto label for error handling from the only place returning
an error from the main loop.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent_io.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b4d986bef2631f..d318b7f1b92cf3 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1502,10 +1502,8 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 	u64 extent_offset;
 	u64 block_start;
 	struct extent_map *em;
-	int saved_ret = 0;
 	int ret = 0;
 	int nr = 0;
-	bool has_error = false;
 	bool compressed;
 
 	ret = btrfs_writepage_cow_fixup(page);
@@ -1556,10 +1554,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		if (IS_ERR(em)) {
 			btrfs_page_set_error(fs_info, page, cur, end - cur + 1);
 			ret = PTR_ERR_OR_ZERO(em);
-			has_error = true;
-			if (!saved_ret)
-				saved_ret = ret;
-			break;
+			goto out_error;
 		}
 
 		extent_offset = cur - em->start;
@@ -1613,18 +1608,19 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 
 		submit_extent_page(bio_ctrl, disk_bytenr, page, iosize,
 				   cur - page_offset(page));
-		ret = 0;
 		cur += iosize;
 		nr++;
 	}
+
+	btrfs_page_assert_not_dirty(fs_info, page);
+	*nr_ret = nr;
+	return 0;
+
+out_error:
 	/*
 	 * If we finish without problem, we should not only clear page dirty,
 	 * but also empty subpage dirty bits
 	 */
-	if (!has_error)
-		btrfs_page_assert_not_dirty(fs_info, page);
-	else
-		ret = saved_ret;
 	*nr_ret = nr;
 	return ret;
 }
-- 
2.39.1

