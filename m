Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8696F5AFB
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 May 2023 17:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjECPZB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 May 2023 11:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjECPY4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 May 2023 11:24:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7899161B2
        for <linux-btrfs@vger.kernel.org>; Wed,  3 May 2023 08:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=BbzPorAN5u7Hr31LkgBd/3OGVW0x+YFgqwmznrgQGOU=; b=o39uo8ltoam09ecEovg2vrGjpG
        8sQ7nW1ucPJsm8iiKO8MnszFZ1K3Gtj4Dl1DFP8lYjtRWHwip1PaiCu7bbBpxxEuDacZYpWm4c0MK
        Z4W/YHqDndnJEWDippuf5K1dwyBT/fH4K6VMGClQCwp/7byjOD1RKizXB7n7YySR+atmY2RquLZma
        7x2ygLoUWBfEBLX11lATDWaHBKH0r4JkFV91yU0nbW4zNma7cSVFRcYrf6tKwSInpojfS8x5iCfmG
        FJNHa1jtibv57jIPTjv+yRyv8DZyloIH4Z8ypqi3LCsOy6OAOy2u4qLsMMdOztnx9CMLpEZI/GxJ+
        ePy04l4A==;
Received: from [2001:4bb8:181:617f:7279:c4cd:ae56:e444] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1puELd-004xdQ-05;
        Wed, 03 May 2023 15:24:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>
Subject: [PATCH 03/21] btrfs: move setting the buffer uptodate out of validate_extent_buffer
Date:   Wed,  3 May 2023 17:24:23 +0200
Message-Id: <20230503152441.1141019-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230503152441.1141019-1-hch@lst.de>
References: <20230503152441.1141019-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Setting the buffer uptodate in a function that is named as a validation
helper is a it confusing.  Move the call from validate_extent_buffer to
the one of its two callers that didn't already have a duplicate call
to set_extent_buffer_uptodate.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 59ea049fe7ee0d..33a1ed6e68ed3e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -590,9 +590,7 @@ static int validate_extent_buffer(struct extent_buffer *eb,
 	if (found_level > 0 && btrfs_check_node(eb))
 		ret = -EIO;
 
-	if (!ret)
-		set_extent_buffer_uptodate(eb);
-	else
+	if (ret)
 		btrfs_err(fs_info,
 		"read time tree block corruption detected on logical %llu mirror %u",
 			  eb->start, eb->read_mirror);
@@ -684,6 +682,8 @@ int btrfs_validate_metadata_buffer(struct btrfs_bio *bbio,
 		goto err;
 	}
 	ret = validate_extent_buffer(eb, &bbio->parent_check);
+	if (!ret)
+		set_extent_buffer_uptodate(eb);
 err:
 	if (ret) {
 		/*
-- 
2.39.2

