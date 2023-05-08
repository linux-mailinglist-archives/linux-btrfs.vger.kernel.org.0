Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0266FB354
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 May 2023 16:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbjEHO6r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 10:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjEHO6o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 10:58:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8EE107
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 07:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=I7HJnOa8J0XLSThohBQpTEvQuNmPq89F1WcyMgS4eT8=; b=t9yrX9Pp7tDdTu7ZRa4zSUjFGs
        P2nH267flWrQnhBpwjvnzPAY4qttEWpd1/zd8A1imxzIDT6bpvgaSjDESQfe//MQ0axWmzVH1baK/
        wxCI3Hx86eVBOKWhSqYp3Ki3BgFfczyxBDY2JK0PtqGcsv8uwdfla9kBKarS4qM9uPE10/Vj2NbRN
        aWF/MQRFJpGzlcWvsnjJUB+LksjtauqI8K+n23Vt5z/Q9zrhECkvXCmZ0BLGw/ZSf2ar0UKprjUSX
        akgshmgtW+lhuYSHUHGUBIxXBsJPTnMr1dC0g/jlj86CWNAHMhPMu6J5f+UlCNtE8p4251hidZ5ls
        UDcUAjJw==;
Received: from [208.98.210.70] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pw2K1-000ogW-2F;
        Mon, 08 May 2023 14:58:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org (open list:BTRFS FILE SYSTEM)
Subject: [PATCH 2/3] btrfs: fix dirty_metadata_bytes for redirtied buffers
Date:   Mon,  8 May 2023 07:58:38 -0700
Message-Id: <20230508145839.43725-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230508145839.43725-1-hch@lst.de>
References: <20230508145839.43725-1-hch@lst.de>
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

dirty_metadata_bytes is decremented in both places that clear the dirty
bit in a buffer, but only incremented in btrfs_mark_buffer_dirty, which
means that a buffer that is redirtied using btrfs_redirty_list_add won't
be added to dirty_metadata_bytes, but it will be subtracted when written
out, leading an inconsistency in the counter.

Move the dirty_metadata_bytes from btrfs_mark_buffer_dirty into
set_extent_buffer_dirty to also account for the redirty case, and remove
the now unused set_extent_buffer_dirty return value.

Fixes: d3575156f662 ("btrfs: zoned: redirty released extent buffers")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/disk-io.c   | 7 +------
 fs/btrfs/extent_io.c | 7 ++++---
 fs/btrfs/extent_io.h | 2 +-
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 96f144094af687..acd8ebf2824d18 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4661,7 +4661,6 @@ void btrfs_mark_buffer_dirty(struct extent_buffer *buf)
 {
 	struct btrfs_fs_info *fs_info = buf->fs_info;
 	u64 transid = btrfs_header_generation(buf);
-	int was_dirty;
 
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 	/*
@@ -4676,11 +4675,7 @@ void btrfs_mark_buffer_dirty(struct extent_buffer *buf)
 	if (transid != fs_info->generation)
 		WARN(1, KERN_CRIT "btrfs transid mismatch buffer %llu, found %llu running %llu\n",
 			buf->start, transid, fs_info->generation);
-	was_dirty = set_extent_buffer_dirty(buf);
-	if (!was_dirty)
-		percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
-					 buf->len,
-					 fs_info->dirty_metadata_batch);
+	set_extent_buffer_dirty(buf);
 #ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
 	/*
 	 * Since btrfs_mark_buffer_dirty() can be called with item pointer set
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a1adadd5d25ddb..a829390632a538 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4148,7 +4148,7 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
 	WARN_ON(atomic_read(&eb->refs) == 0);
 }
 
-bool set_extent_buffer_dirty(struct extent_buffer *eb)
+void set_extent_buffer_dirty(struct extent_buffer *eb)
 {
 	int i;
 	int num_pages;
@@ -4183,13 +4183,14 @@ bool set_extent_buffer_dirty(struct extent_buffer *eb)
 					     eb->start, eb->len);
 		if (subpage)
 			unlock_page(eb->pages[0]);
+		percpu_counter_add_batch(&eb->fs_info->dirty_metadata_bytes,
+					 eb->len,
+					 eb->fs_info->dirty_metadata_batch);
 	}
 #ifdef CONFIG_BTRFS_DEBUG
 	for (i = 0; i < num_pages; i++)
 		ASSERT(PageDirty(eb->pages[i]));
 #endif
-
-	return was_dirty;
 }
 
 void clear_extent_buffer_uptodate(struct extent_buffer *eb)
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 4341ad978fb8e4..f937654230d3c5 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -262,7 +262,7 @@ void extent_buffer_bitmap_set(const struct extent_buffer *eb, unsigned long star
 void extent_buffer_bitmap_clear(const struct extent_buffer *eb,
 				unsigned long start, unsigned long pos,
 				unsigned long len);
-bool set_extent_buffer_dirty(struct extent_buffer *eb);
+void set_extent_buffer_dirty(struct extent_buffer *eb);
 void set_extent_buffer_uptodate(struct extent_buffer *eb);
 void clear_extent_buffer_uptodate(struct extent_buffer *eb);
 int extent_buffer_under_io(const struct extent_buffer *eb);
-- 
2.39.2

