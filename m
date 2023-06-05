Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3734272216E
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jun 2023 10:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjFEIv2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Jun 2023 04:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjFEIv1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Jun 2023 04:51:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72999C7
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Jun 2023 01:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=z1/npQfrXTKm2ARaNE/Kd0T6Kt3AKB1lPqLFlJcnJQg=; b=cuKUUjf09P9eNoZqlI+RsAUveo
        murexJYETXoJ2Yn5QgypAs1bWPUHmo0IbMtEOn5q2l/2B1sqA2J0NAIJdRW8vrGnK+x7cV0uE3EPc
        V5iJp/b6Vzf+4JxoaDUXTkLRvkKWr/ptVWrinJy7BhiI7Qs8XAI7vwsGsmqP92JSwONjmN39X8Ami
        iPIFPyQNleOYTIEuOzOz/QS+2OBy9rDleYBjHQmN8ldD+XUWu5aaTzpCK4Z4/BdGXo5VXEoygdGP0
        YOLst4k7MXKaVoiPSASRrpv34OEPx4bxUKMMBeHOIc1ZwzT/yCdbTrd+EWi9qlGOGmJ7jopwNrmSR
        Wu//brFQ==;
Received: from [2001:4bb8:191:e9d5:e931:d7f5:9239:69f3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q65vv-00ElIV-0b;
        Mon, 05 Jun 2023 08:51:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 3/4] btrfs: split out a helper to handle single BGs from btrfs_load_block_group_zone_info
Date:   Mon,  5 Jun 2023 10:51:07 +0200
Message-Id: <20230605085108.580976-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230605085108.580976-1-hch@lst.de>
References: <20230605085108.580976-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Split the code handling a type single block group from
btrfs_load_block_group_zone_info to make the code more readable.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/zoned.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 533cbe849cd60f..ea1f7f26a42249 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1373,6 +1373,24 @@ static int btrfs_load_zone_info(struct btrfs_fs_info *fs_info, int zone_idx,
 	return 0;
 }
 
+static int btrfs_load_block_group_single(struct btrfs_block_group *bg,
+					 struct zone_info *info,
+					 unsigned long *active)
+{
+	if (info->alloc_offset == WP_MISSING_DEV) {
+		btrfs_err(bg->fs_info,
+			"zoned: cannot recover write pointer for zone %llu",
+			info->physical);
+		return -EIO;
+	}
+
+	bg->alloc_offset = info->alloc_offset;
+	bg->zone_capacity = info->capacity;
+	if (test_bit(0, active))
+		set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &bg->runtime_flags);
+	return 0;
+}
+
 int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 {
 	struct btrfs_fs_info *fs_info = cache->fs_info;
@@ -1460,17 +1478,8 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 
 	switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
 	case 0: /* single */
-		if (zone_info[0].alloc_offset == WP_MISSING_DEV) {
-			btrfs_err(fs_info,
-			"zoned: cannot recover write pointer for zone %llu",
-				zone_info[0].physical);
-			ret = -EIO;
-			goto out;
-		}
-		cache->alloc_offset = zone_info[0].alloc_offset;
-		cache->zone_capacity = zone_info[0].capacity;
-		if (test_bit(0, active))
-			set_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &cache->runtime_flags);
+		ret = btrfs_load_block_group_single(cache, &zone_info[0],
+						    active);
 		break;
 	case BTRFS_BLOCK_GROUP_DUP:
 		if (map->type & BTRFS_BLOCK_GROUP_DATA) {
-- 
2.39.2

