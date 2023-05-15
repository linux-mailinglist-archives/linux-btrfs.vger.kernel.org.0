Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC94703DA8
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 May 2023 21:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245134AbjEOTXm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 May 2023 15:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245055AbjEOTXa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 May 2023 15:23:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7D71527B
        for <linux-btrfs@vger.kernel.org>; Mon, 15 May 2023 12:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=L5msNWR3B/Y9LTDtjGtJokRb2du00+ig4TUArap7Tfo=; b=UwnSy4Z3KeivVbtJPWxtBVs9SR
        H8MDt0DAGtNl9EDzYMtEkOgu9h4yeLp2QlzOcfN1spbGnhn2iGufIzwTRI20OEH9VgZr3IhddJKa5
        OjRbv7BDLZxT6IK6jGpeoCyHu1dNkfit5YOZJX486txIaDSSoE9Yse1mJ5PmI5UbCHZGcziCC675x
        cgXocCPJQ31pVM7z8pGY7MCATXKKZWG5tkfHkOWBWJ2nSPBO8PI41m8LNymZHuoy3Rvzj5WrR1nF2
        cvBM4h0GV3lB0nV/52i73YZAOvRwNS7hMT6CAsSZgTeLIKnygsPNQc3nwMjcN/yZ2XU/RHw9F2yJO
        aLyLNtOg==;
Received: from [2001:4bb8:188:2249:ad42:acf3:6731:a041] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pydmz-003HHL-21;
        Mon, 15 May 2023 19:23:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/6] btrfs: move dropping the bg reference out of submit_eb_page
Date:   Mon, 15 May 2023 21:22:54 +0200
Message-Id: <20230515192256.29006-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515192256.29006-1-hch@lst.de>
References: <20230515192256.29006-1-hch@lst.de>
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

Instead of putting the cached bg for zoned metadata writes in
submit_eb_page, let the btrfs_revert_meta_write_pointer and
btrfs_schedule_zone_finish_bg helpers consume it.  This mirrors how the
reference to it is acquired in btrfs_check_meta_write_pointer and
isolated the extent_buffer writeback code from some of the zoned
device implementation details.  It also avoids a reference roundtrip
for the case where btrfs_schedule_zone_finish_bg actually schedules
a zone_finish command.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/extent_io.c | 3 ---
 fs/btrfs/zoned.c     | 7 +++++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d5937ed0962d38..1205b3a3147e7d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1955,8 +1955,6 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 
 	if (!lock_extent_buffer_for_io(eb, wbc)) {
 		btrfs_revert_meta_write_pointer(cache, eb);
-		if (cache)
-			btrfs_put_block_group(cache);
 		free_extent_buffer(eb);
 		return 0;
 	}
@@ -1965,7 +1963,6 @@ static int submit_eb_page(struct page *page, struct writeback_control *wbc,
 		 * Implies write in zoned mode. Mark the last eb in a block group.
 		 */
 		btrfs_schedule_zone_finish_bg(cache, eb);
-		btrfs_put_block_group(cache);
 	}
 	write_one_eb(eb, wbc);
 	free_extent_buffer(eb);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index e4b8134ab70166..eed96ec35052a0 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1752,6 +1752,7 @@ void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
 
 	ASSERT(cache->meta_write_pointer == eb->start + eb->len);
 	cache->meta_write_pointer = eb->start;
+	btrfs_put_block_group(cache);
 }
 
 int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical, u64 length)
@@ -2145,17 +2146,19 @@ void btrfs_schedule_zone_finish_bg(struct btrfs_block_group *bg,
 				   struct extent_buffer *eb)
 {
 	if (!test_bit(BLOCK_GROUP_FLAG_SEQUENTIAL_ZONE, &bg->runtime_flags) ||
-	    eb->start + eb->len * 2 <= bg->start + bg->zone_capacity)
+	    eb->start + eb->len * 2 <= bg->start + bg->zone_capacity) {
+		btrfs_put_block_group(bg);
 		return;
+	}
 
 	if (WARN_ON(bg->zone_finish_work.func == btrfs_zone_finish_endio_workfn)) {
 		btrfs_err(bg->fs_info, "double scheduling of bg %llu zone finishing",
 			  bg->start);
+		btrfs_put_block_group(bg);
 		return;
 	}
 
 	/* For the work */
-	btrfs_get_block_group(bg);
 	atomic_inc(&eb->refs);
 	bg->last_eb = eb;
 	INIT_WORK(&bg->zone_finish_work, btrfs_zone_finish_endio_workfn);
-- 
2.39.2

