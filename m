Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE6758B468
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Aug 2022 10:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiHFIDk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 6 Aug 2022 04:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiHFIDj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 6 Aug 2022 04:03:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0896813DE4
        for <linux-btrfs@vger.kernel.org>; Sat,  6 Aug 2022 01:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=g+JZazpHAlObiv8J5zanxwayYMcIfsaMAxpeXkiUG1U=; b=P8VGDtjpG5NpD2XjR6Uyy+Xlap
        CmoZ5x2EOcN0tPz2TQ0JhXt2eICwCyB+V8vboa6S5Rb3AxLs86B4Q+sIY7sMs90m7mc6mDdvp316P
        8+maoLG5QPt2/83vrsI41XslRbdkJLtrvLAHIWlLbHfNoZbGGjMFwt8kVUiDiu72gh6TTmmpM9dQj
        po44EPvc1v2mPgDGBGBi2mIqo7lT5hGpHh5OG4gEWFJbha3ueaMV4+7QnO6MAcQWAjQNzec7mARDf
        eMubYdF+LsS0Po0c71/5FLQyJ1pDzrSW5HoF4juN7kAQ4RuLpzep7NG5/fE0blAVbFkgUAHCdPm1h
        U+MLPHEw==;
Received: from [2001:4bb8:192:6d54:4997:d9fe:27ec:4c3c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKEmV-006LkH-KY; Sat, 06 Aug 2022 08:03:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 01/11] btrfs: don't call bioset_integrity_create for btrfs_bioset
Date:   Sat,  6 Aug 2022 10:03:20 +0200
Message-Id: <20220806080330.3823644-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220806080330.3823644-1-hch@lst.de>
References: <20220806080330.3823644-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs never uses bio integrity data itself, so don't allocate
the integrity pools for btrfs_bioset.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent_io.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6e8e936a8a1ef..ca8b79d991f5e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -255,14 +255,8 @@ int __init extent_io_init(void)
 			BIOSET_NEED_BVECS))
 		goto free_buffer_cache;
 
-	if (bioset_integrity_create(&btrfs_bioset, BIO_POOL_SIZE))
-		goto free_bioset;
-
 	return 0;
 
-free_bioset:
-	bioset_exit(&btrfs_bioset);
-
 free_buffer_cache:
 	kmem_cache_destroy(extent_buffer_cache);
 	extent_buffer_cache = NULL;
-- 
2.30.2

