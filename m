Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D780B75F83F
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jul 2023 15:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjGXN1W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jul 2023 09:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjGXN1S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jul 2023 09:27:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C0BE73
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jul 2023 06:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=PbB1bHaHc9RUosOldd9EfGcBQTtI4MTE+lOImgL0IDY=; b=uUV3nMbAlZett0+hKUIKXwwkRR
        nBdlzpVY8VDcxKHmwQBLwjNoMqn7SW/br4iNhcQm2etHXjhpfpBUbGcwDXOUugHw9ALaxe0rQ8bxw
        ItOJzhcUCYDSz97Wzl4W9O+TpED+gTjMk1o/Gcs46rUwwnxbNZ6GVPnGxhIS1a7gUsY+GtLY/Aq6d
        VLh4RA3UMyErQre+spZEn9UKYTCvMEC20gjiIiiaAOCn1I5wlDaB+wyCMzPefvwsUiD7C3R6zMk/Y
        ABijkmgFPMteRyu1vmxBspnlk7Gx6Je6MpAelo17eQpVZC73lUaCheqtR2xAIcWOxZIAcng61Ror8
        mIwSl8qQ==;
Received: from 67-207-104-238.static.wiline.com ([67.207.104.238] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qNvaY-004RLl-18;
        Mon, 24 Jul 2023 13:27:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/9] btrfs: fix an error handling corner case in cow_file_range
Date:   Mon, 24 Jul 2023 06:26:55 -0700
Message-Id: <20230724132701.816771-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724132701.816771-1-hch@lst.de>
References: <20230724132701.816771-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When the call to btrfs_reloc_clone_csums in cow_file_range returns an
error, we jump to the out_unlock label with the extent_reserved variable
set to false.   The cleanup at the label will then call
extent_clear_unlock_delalloc on the range from start to end.  But we've
already added cur_alloc_size to start, so there might no range be left
from the newly increment start to end.  Move the check for start < end
so that it is reached by also for the !extent_reserved case.

Fixes: a315e68f6e8b ("Btrfs: fix invalid attempt to free reserved space on failure to cow range")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 640e7dd26f6132..84c8c51e20478c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1550,8 +1550,6 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 					     clear_bits,
 					     page_ops);
 		start += cur_alloc_size;
-		if (start >= end)
-			return ret;
 	}
 
 	/*
@@ -1560,9 +1558,11 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	 * space_info's bytes_may_use counter, reserved in
 	 * btrfs_check_data_free_space().
 	 */
-	extent_clear_unlock_delalloc(inode, start, end, locked_page,
-				     clear_bits | EXTENT_CLEAR_DATA_RESV,
-				     page_ops);
+	if (start < end) {
+		clear_bits |= EXTENT_CLEAR_DATA_RESV;
+		extent_clear_unlock_delalloc(inode, start, end, locked_page,
+					     clear_bits, page_ops);
+	}
 	return ret;
 }
 
-- 
2.39.2

