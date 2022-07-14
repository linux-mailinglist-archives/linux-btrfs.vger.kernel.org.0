Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A8657487A
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jul 2022 11:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237672AbiGNJTa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jul 2022 05:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238149AbiGNJSy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jul 2022 05:18:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDBA4E851
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jul 2022 02:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ylVZrdyb4c5dMvhHxoKGUHRjzVIElkHPrYgh+SD3vMY=; b=CJ0Wv3LUkGY/bB8y6SIIuhYWCN
        GPX4vPRr14zwIpBL2eHNIjFflrkmOtWHtKa6U0FvjJinvczkyDToMCc4DPjHLVQCI0g2aKWEX7UeV
        Uur8fm0JH1UeP3gLDQy/hnf9OMYKz+dDE1yNtfNdO0blC7KMKMF1/MI6Pf0/1gQbDqEVJ88c220Qd
        uBaDhW9q+DXp1F/kcXt7U148ZEdjiDDeOC8FGeLN4P+959pqWWMDbVnE8WrKhWUy7eFrkaSGmjDaN
        KUtneNcDHLk0RokQWSLACtDgoYxxHW4+1Ubo9s9Roa/d9vJH+z3osq58mBh05XoBAdvHBa02oZzyW
        SsN47Qeg==;
Received: from ip4d15c27d.dynamic.kabel-deutschland.de ([77.21.194.125] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oBux9-00Cj5J-Ry; Thu, 14 Jul 2022 09:16:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        naohiro.aota@wdc.com
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: align max_zone_append_size to the sector size
Date:   Thu, 14 Jul 2022 11:16:09 +0200
Message-Id: <20220714091609.2892621-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
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

max_zone_append_size and thus the maximum extent size needs to be aligned
to the sector size, else a lot code becomes rather unhappy and various
alignment asserts trigger.

Fixes: 385ea2aea011 ("btrfs: replace BTRFS_MAX_EXTENT_SIZE with fs_info->max_extent_size")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/zoned.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 3b45b35aa945c..fbad2e489dc80 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -739,7 +739,8 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 	}
 
 	fs_info->zone_size = zone_size;
-	fs_info->max_zone_append_size = max_zone_append_size;
+	fs_info->max_zone_append_size =
+		ALIGN(max_zone_append_size, fs_info->sectorsize);
 	fs_info->fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_ZONED;
 	if (fs_info->max_zone_append_size < fs_info->max_extent_size)
 		fs_info->max_extent_size = fs_info->max_zone_append_size;
-- 
2.30.2

