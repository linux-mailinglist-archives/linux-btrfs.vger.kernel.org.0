Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48A1564FE6
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Jul 2022 10:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiGDIoO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Jul 2022 04:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiGDIoN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Jul 2022 04:44:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7A36398
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Jul 2022 01:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=C2AHFILAQKGzS1NDagCTwruWBjmSP46eANpQAgxCEeY=; b=ZsNkvBh1OpUvpgB6ky17mpFpHA
        VGMJDYNYZqWdv+GmPz/hqVo0ysA6YnCZJOTllc83KRJ6UtMtXyZqAj+Ku9C0O74wq9d9tnaEtqvfV
        ybNt0Aqdkvv3rhmpI1xveVJOsxkAVriKSs75R5KTwf2WnxHZecQ9+xXXLrS/xrrE0pRrGwuN3GgPS
        s+S8qU8zcgJ76YHMRPxiR9P6taD3Uh9UWfrvdpdmiqQbFbHJH2qXofCt5VoSzcnEtW70bzEwoo4Ti
        lHbBxCb2GlM6e704TPPscF7797Ca6l2/gCrzL+BJeoDDJE5nb5J2+YR8Zkbv//PN0CHt/Jj1KlxUB
        sXRpehxg==;
Received: from [2001:4bb8:189:3c4a:9cc7:69df:e5dc:ef11] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8Hgh-0068Hf-0c; Mon, 04 Jul 2022 08:44:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/7] btrfs: don't call bioset_integrity_create for btrfs_bioset
Date:   Mon,  4 Jul 2022 10:44:00 +0200
Message-Id: <20220704084406.106929-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220704084406.106929-1-hch@lst.de>
References: <20220704084406.106929-1-hch@lst.de>
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
---
 fs/btrfs/extent_io.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 587d2ba20b53b..5fe3e0d306297 100644
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

