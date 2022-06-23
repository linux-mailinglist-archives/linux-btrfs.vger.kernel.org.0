Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AFF557E64
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jun 2022 17:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiFWPBm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jun 2022 11:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbiFWPBm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jun 2022 11:01:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452AB26577
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Jun 2022 08:01:41 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id ED4A2219A1;
        Thu, 23 Jun 2022 15:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655996499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=15xDqXdCJXAZOj0Kv7RNyaHdDP6gYIv3hGaVO8v62Nw=;
        b=P3xDE+JR3oa6ZKe4kgWZkzQ42m/KRID70Oa18NB2CWrrF2HD9VkPYAIb5pWwwKjzoradB5
        CPSeg0/OcjXJ+p5tDKd4lS/UO6gW5OrCCo5P2MToNh2+0S0eCMZ/0yquaiuAzdJO7AGFAy
        u6AN4xV6hYXiUxMURQdMZqOvQyjZGBE=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E45122C142;
        Thu, 23 Jun 2022 15:01:39 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D8BFBDA82F; Thu, 23 Jun 2022 16:57:02 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/2] btrfs: merge calculations for simple striped profiles in btrfs_rmap_block
Date:   Thu, 23 Jun 2022 16:57:02 +0200
Message-Id: <d2e7f661607ee0e14b26455228dc74a12b5cbd98.1655996117.git.dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1655996117.git.dsterba@suse.com>
References: <cover.1655996117.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Use the same expression for stripe_nr for RAID0 (map->sub_stripes is 1)
and RAID10 (map->sub_stripes is 2), with equivalent results.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/block-group.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 13358fbc1629..e930749770ac 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1816,11 +1816,10 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
 		stripe_nr = physical - map->stripes[i].physical;
 		stripe_nr = div64_u64_rem(stripe_nr, map->stripe_len, &offset);
 
-		if (map->type & BTRFS_BLOCK_GROUP_RAID10) {
+		if (map->type & (BTRFS_BLOCK_GROUP_RAID0 |
+				 BTRFS_BLOCK_GROUP_RAID10)) {
 			stripe_nr = stripe_nr * map->num_stripes + i;
 			stripe_nr = div_u64(stripe_nr, map->sub_stripes);
-		} else if (map->type & BTRFS_BLOCK_GROUP_RAID0) {
-			stripe_nr = stripe_nr * map->num_stripes + i;
 		}
 		/*
 		 * The remaining case would be for RAID56, multiply by
-- 
2.36.1

