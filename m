Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6F66D73F5
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Apr 2023 07:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236943AbjDEFt5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 01:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236893AbjDEFts (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 01:49:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F017C4C26;
        Tue,  4 Apr 2023 22:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=vcMv3tvKdemNUTXrzjg4RlFzzLZmXitLif8MJjxnjA8=; b=EHArZHOQHvo1lYWfDQtZn+71Hj
        r1p5zbdo1tHJY4wqResYVY3hqzBcDyzNoirbQJttiHBDtj/Oqs+C8N8inlab16FAeBw1O3yXFyBbK
        xRkWOCvnqSEoLngqoh4Ctq2ugNKuWqTwnM9WbLVTiAFsngQfskEfQ3qGHc65NenpVcsjwnsZ42S3i
        FVZjLnwrT2A0SyvhvHBEJhz8Mt+OlgnRRTvYkCTc5ysusbT8s5Ot1l2wjKkZU/K1ptbNBi5WENcuA
        ZT3i6K8mGWPaW/NbNN2aq5Nz4v+/uAfez/4+HejH9+jgn/nSyvNnpqJN80CBsIvRueZWNlF2ujNOo
        Diwl0vxw==;
Received: from [2001:4bb8:191:a744:c06e:b99:9fd8:3e0] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pjw19-003Ql2-0w;
        Wed, 05 Apr 2023 05:49:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-btrfs@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: [PATCH 1/2] btrfs: don't print the crc32c implementtion at load time
Date:   Wed,  5 Apr 2023 07:49:04 +0200
Message-Id: <20230405054905.94678-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230405054905.94678-1-hch@lst.de>
References: <20230405054905.94678-1-hch@lst.de>
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

Btrfs can use various different checksumming algorithms, and prints
the one used for a given file system at mount time.  Don't bother
printing the crc32c implementation at module load time.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 285c7189b92466..bf79e49157c5e5 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2412,7 +2412,7 @@ static int __init btrfs_print_mod_info(void)
 			", fsverity=no"
 #endif
 			;
-	pr_info("Btrfs loaded, crc32c=%s%s\n", crc32c_impl(), options);
+	pr_info("Btrfs loaded%s\n", options);
 	return 0;
 }
 
-- 
2.39.2

