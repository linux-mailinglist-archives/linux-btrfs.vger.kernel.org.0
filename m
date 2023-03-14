Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965456B8B0B
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 07:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCNGRL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 02:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjCNGRK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 02:17:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030D679B08
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Mar 2023 23:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=7NM/Q3gGl4/n4XP7OUJDq9qpA/aF9eNuVJD/ObDGwrU=; b=w3pMLdUWd4ZKrgiAzPhDj1Svpo
        CBEc1xfNCsFLRJ900sd/XjCbjtFkAikfWISFxiwRC3frr8rN2b/n+JIEUhKcQZ9WFfM3w9c4+ubF/
        MVPSHo4FkRCGW81gdg3mLpbhhbCFdwR1YdU7Tw9X6ZkIqlcsjM9M5UG31+P/0dmmp6lRD8pjlO7ed
        Z7n/PriSkXk9ziWqR+9XyHbahVjM4G23LvhHZdRhf/weY3tqGCsCDcAT72TgRZhaJMTycEm4Ka4w+
        j4bXDS8y7lZerK2/Z/NNTacrPd5mKY7M6C/v213r9NmZl2mv3jIx1ijwFmWamb8aJZM8b+tsT+ICi
        dRYnSfkg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pbxy2-009Ag9-RX; Tue, 14 Mar 2023 06:17:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>
Subject: [PATCH 01/21] btrfs: mark extent_buffer_under_io static
Date:   Tue, 14 Mar 2023 07:16:35 +0100
Message-Id: <20230314061655.245340-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314061655.245340-1-hch@lst.de>
References: <20230314061655.245340-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

extent_buffer_under_io is only used in extent_io.c, so mark it static.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 2 +-
 fs/btrfs/extent_io.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1221f699ffc596..302af9b01bda2a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3420,7 +3420,7 @@ static void __free_extent_buffer(struct extent_buffer *eb)
 	kmem_cache_free(extent_buffer_cache, eb);
 }
 
-int extent_buffer_under_io(const struct extent_buffer *eb)
+static int extent_buffer_under_io(const struct extent_buffer *eb)
 {
 	return (atomic_read(&eb->io_pages) ||
 		test_bit(EXTENT_BUFFER_WRITEBACK, &eb->bflags) ||
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 4341ad978fb8e4..342412d37a7b4b 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -265,7 +265,6 @@ void extent_buffer_bitmap_clear(const struct extent_buffer *eb,
 bool set_extent_buffer_dirty(struct extent_buffer *eb);
 void set_extent_buffer_uptodate(struct extent_buffer *eb);
 void clear_extent_buffer_uptodate(struct extent_buffer *eb);
-int extent_buffer_under_io(const struct extent_buffer *eb);
 void extent_range_clear_dirty_for_io(struct inode *inode, u64 start, u64 end);
 void extent_range_redirty_for_io(struct inode *inode, u64 start, u64 end);
 void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
-- 
2.39.2

