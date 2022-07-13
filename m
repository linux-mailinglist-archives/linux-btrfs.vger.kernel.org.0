Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491C6572DFB
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Jul 2022 08:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiGMGOK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 02:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbiGMGOI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 02:14:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1B4B9DAF
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jul 2022 23:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Da2pBud7Jvgbfpt8xoU8KYw5u+k/XkJUWddXo1jmNtk=; b=3bBLH8D/zW1oC3ahvY9wJg22xN
        EriToVKaP+VV3ZPW98svEzSdHOXM9xNaCR5WAVQXK8TwnAv3UW/vWyWAUiUOiIVoVjgqUsPd5DRQD
        0dg4ZQnMnD10e1UY5xaSRmuOMxT7UqBAq+yExNYmBf9X1q+QKAWjOYkPLi79+Xajxrp+R29VFj1w9
        /6LNpiWieSCP5feq5+66emyG3N8o1Qj84/9cMTYw6DkU1nneiYulZi8lG4dpROpzIwq2fCid4K+EP
        xab4ZUGkPo8CNWApkFt/SfN3q30aOP0ZTu4cmjbt78jc8p9tN/JXSMHUKHKxp9C+q+XNePEkt4dXn
        Vc+Vghug==;
Received: from ip4d15c27d.dynamic.kabel-deutschland.de ([77.21.194.125] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBVdM-000T0i-9q; Wed, 13 Jul 2022 06:14:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 01/11] btrfs: don't call bioset_integrity_create for btrfs_bioset
Date:   Wed, 13 Jul 2022 08:13:49 +0200
Message-Id: <20220713061359.1980118-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220713061359.1980118-1-hch@lst.de>
References: <20220713061359.1980118-1-hch@lst.de>
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
index db95de608ce3f..35c609aaeda4a 100644
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

