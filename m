Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571EC646417
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Dec 2022 23:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiLGW22 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Dec 2022 17:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiLGW21 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Dec 2022 17:28:27 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BFC81D8E
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Dec 2022 14:28:26 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id x28so16251930qtv.13
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Dec 2022 14:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qm071SMDR2NnJ115/TnXgUIANBPM1dlkDB4AQkH670Y=;
        b=2bHM8FM+8otp7seyJOb0vqEuqYQwbZ8TTRACz3T0u98hGtryiWJcv1IDSM3hgLD6Fh
         39iaTl/K6K4Sd+pZ7AjNaPWw8P0tK4QaWHxghXSPMKNgojttcf0pviZHI+zf7n5Dz2xf
         Q8wx/WUGOKpIgmxJzRyOiyBmIlY81asWqRHmczXuIN5hqK/gElPaj524BU7vLFBQa1hS
         vWRxJGuEecl5xG2ggditdrR/iUuLOiOevDapztBCPhvxN8xBdlVNo+kAeY1dRj/l63nJ
         soKBsEb4aYKqnawdqcHaEllKP/1uLCywD3gR/u897dBb6JAi312noh+BYwYtl8bmHxi9
         7UXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qm071SMDR2NnJ115/TnXgUIANBPM1dlkDB4AQkH670Y=;
        b=JLX5XpNbJd9YKrIauepfStsdPATSrAzqeT46a1XqY4jrlaw5JQteRqGN80cLULKxEJ
         YBsS/GUDDEouOTCp6PzAYCawkkkqvQmPzz+Q4qc8HJ3bhrT6vKSiGFRsRSLYrb6x0qmt
         REgBGxWeDAnJKx2ZYX8y8eQ+SGxodiDocufMSHq/8TYIjMpL/jyWkeqZtLYWcuTDLMLy
         Ldv0FQ9ClQwVUrYdW+2bTSPtzp1zmlkBPRPO6d58cvIqqkzjFWgDU394kKMEtPWRn0tg
         h70GBtZAHqEaYqFqPVzUmWA8PA+zuCS0PGajsYxFEHGdxMmYduHswzMx87BFQS4gjBqB
         bLcA==
X-Gm-Message-State: ANoB5pkqrzOrBA5kSoJ33wRtmzpZ3AusYCO1lJp7jPN291uJTJBDzcIk
        HbDgEG3zAdad/WEuLXxo7UCG2WIutqFpGk0X
X-Google-Smtp-Source: AA0mqf7y0HTwDvBQEEDRIWvRvSOnibUo3bNjQFhPjZjvHNO0PqTd7D7k9uWkQcNRjqXYvERJ/zWjvg==
X-Received: by 2002:ac8:1098:0:b0:3a5:3819:51da with SMTP id a24-20020ac81098000000b003a5381951damr1405673qtj.38.1670452104798;
        Wed, 07 Dec 2022 14:28:24 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id j13-20020a05620a288d00b006fbbdc6c68fsm18467144qkp.68.2022.12.07.14.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 14:28:24 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 7/8] btrfs: combine btrfs_clear_buffer_dirty and clear_extent_buffer_dirty
Date:   Wed,  7 Dec 2022 17:28:10 -0500
Message-Id: <10d22123b5e1cdbbefab86e0667d81951f537f77.1670451918.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1670451918.git.josef@toxicpanda.com>
References: <cover.1670451918.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_clear_buffer_dirty just does the test_clear_bit() and then calls
clear_extent_buffer_dirty and does the dirty metadata accounting.
Combine this into clear_extent_buffer_dirty and make the result
btrfs_clear_buffer_dirty.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c   | 13 -------------
 fs/btrfs/extent_io.c | 11 ++++++++++-
 fs/btrfs/extent_io.h |  2 +-
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b8f1ac54d10c..8edbf73d8707 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -965,19 +965,6 @@ struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 
 }
 
-void btrfs_clear_buffer_dirty(struct extent_buffer *buf)
-{
-	struct btrfs_fs_info *fs_info = buf->fs_info;
-	btrfs_assert_tree_write_locked(buf);
-
-	if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &buf->bflags)) {
-		percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
-					 -buf->len,
-					 fs_info->dirty_metadata_batch);
-		clear_extent_buffer_dirty(buf);
-	}
-}
-
 static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 			 u64 objectid)
 {
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7cd4065acc82..c242aabfa863 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4813,12 +4813,21 @@ static void clear_subpage_extent_buffer_dirty(const struct extent_buffer *eb)
 	WARN_ON(atomic_read(&eb->refs) == 0);
 }
 
-void clear_extent_buffer_dirty(const struct extent_buffer *eb)
+void btrfs_clear_buffer_dirty(struct extent_buffer *eb)
 {
+	struct btrfs_fs_info *fs_info = eb->fs_info;
 	int i;
 	int num_pages;
 	struct page *page;
 
+	btrfs_assert_tree_write_locked(eb);
+
+	if (!test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags))
+		return;
+
+	percpu_counter_add_batch(&fs_info->dirty_metadata_bytes, -eb->len,
+				 fs_info->dirty_metadata_batch);
+
 	if (eb->fs_info->nodesize < PAGE_SIZE)
 		return clear_subpage_extent_buffer_dirty(eb);
 
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index a024655d4237..41fc887d6cfe 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -261,7 +261,6 @@ void extent_buffer_bitmap_set(const struct extent_buffer *eb, unsigned long star
 void extent_buffer_bitmap_clear(const struct extent_buffer *eb,
 				unsigned long start, unsigned long pos,
 				unsigned long len);
-void clear_extent_buffer_dirty(const struct extent_buffer *eb);
 bool set_extent_buffer_dirty(struct extent_buffer *eb);
 void set_extent_buffer_uptodate(struct extent_buffer *eb);
 void clear_extent_buffer_uptodate(struct extent_buffer *eb);
@@ -273,6 +272,7 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 				  u32 bits_to_clear, unsigned long page_ops);
 int extent_invalidate_folio(struct extent_io_tree *tree,
 			    struct folio *folio, size_t offset);
+void btrfs_clear_buffer_dirty(struct extent_buffer *buf);
 
 int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array);
 
-- 
2.26.3

