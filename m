Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC20F699A2F
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Feb 2023 17:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjBPQfO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Feb 2023 11:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjBPQfJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Feb 2023 11:35:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000C84ECD7
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Feb 2023 08:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=apwvBmoOBBU4EmE5ohvT41/0dH15V6j0567gOTaunqk=; b=x8UScBLdhawSsudZ0OtRHqmiQC
        ovhN9KYTT7jBVwd6KrkYST9p/vZrOk1nmnasXXCzPruswT5XhS1Wpjy0X2lVrxAdEEfX3+9jOkjg9
        9HR3sDne3o2RALZopBMqvTt2R1ooVRcksgm9B4q37HDOe8E1tk70H8Ofc1jddRMy18omjQsnX5mWR
        S+wA5yQpT1AbYdLVO9ct6aT6E9PjnWDVlreDPMX7m4pHxaiccTXuLj6KuwUxkHLye4cD3Qc4/JUtk
        ZZJ56XV7V9gw4qT12HGm12eu8uEzXL60cfgMMV377OlxWUvPuPabmcyExP3ViifkuGzyU0COaRfVh
        PFsIsm0w==;
Received: from [2001:4bb8:181:6771:37af:42b9:3236:81df] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pShDu-00BD4q-40; Thu, 16 Feb 2023 16:35:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 10/12] btrfs: simplify the error handling in __extent_writepage_io
Date:   Thu, 16 Feb 2023 17:34:35 +0100
Message-Id: <20230216163437.2370948-11-hch@lst.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230216163437.2370948-1-hch@lst.de>
References: <20230216163437.2370948-1-hch@lst.de>
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
---
 fs/btrfs/extent_io.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4b27cc50f8b926..4b493f4ee5b2c1 100644
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

