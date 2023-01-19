Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F2C6745A7
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jan 2023 23:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjASWOf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Jan 2023 17:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjASWNv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Jan 2023 17:13:51 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AB3E3A8
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 13:53:39 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id t7so2498980qvv.3
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 13:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qm071SMDR2NnJ115/TnXgUIANBPM1dlkDB4AQkH670Y=;
        b=wfHzZXNRvq0UfoDrzwn+7Zz0OMOZlxaMclfVq4l6JfPNAp7MbF0Nt63srxZ67L3lYM
         HKH84OKBbcY8gkNCwrL7B3xiSfA4yJ25NSMFyEad8DsPnJB1t9r3gIpTFggaLR8uHnrV
         vUSR2mcd/vcfHvpGmz2ITxRhcyvuDBg5wkIFIqqUFl4T49o0bDqgk2visVodx5H7En63
         Mac+9w4Nkyga9Nior6EAvvRET4ohmWWHtyY6AHCl8+q148Sgem8ydFT8v6gY8IVh5IS2
         4ninXgpxAW6zlvJTBVhYFP41z5l5sqc7I3L//ch/JMzSiykWWeOXlUr/81qUTnV0QP8U
         EBQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qm071SMDR2NnJ115/TnXgUIANBPM1dlkDB4AQkH670Y=;
        b=1RP4OyaQu42X/1O0/nyWOL/QB1UQQsViSTzUS9TboZ9oGweZC3jmnRQGE788mYjOcN
         MPFK17y0y+jva+4AxxphNf7hUTNoBU3rA0I8oH6NR9wCHwdxA3c6UPabyot738vyP4mY
         t0FRcv8pvdLqC6DQdsIW6Zbj2OiEIO/e0+NCv/cGTmG0+in8G/jxwpwwXrRG6ntCIntn
         aLtinU566SG/KDLAbUT/OEDkf2OpPScq/0l7K0pKpMO4NwgZAdlHrqptjvZYBwZTKL0R
         Br0U4ikyBpZKMhM1wfVn0rAlyErLuVnvqblhtdY8i8TWbGk/ysjggL/QxdPIWMkkIFts
         0tSw==
X-Gm-Message-State: AFqh2krIlw8UvqhItPEmUN/EDQUGz9VM0gbDsJ75et89fOZqJGhVUVMf
        8+usOLKKgud9t57lzgQe48tI86nXffDuhHojR5w=
X-Google-Smtp-Source: AMrXdXv3GHZxTWEACxoy7Lu5e5e1L26xTsOgIjckZsHC6s2fW62b1jAt7CU9n5Nnc03g6NDg/yoL2A==
X-Received: by 2002:a05:6214:5241:b0:534:224c:14f3 with SMTP id kf1-20020a056214524100b00534224c14f3mr18454097qvb.38.1674165218451;
        Thu, 19 Jan 2023 13:53:38 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id q44-20020a05620a2a6c00b006fc9fe67e34sm10767374qkp.81.2023.01.19.13.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 13:53:38 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 8/9] btrfs: combine btrfs_clear_buffer_dirty and clear_extent_buffer_dirty
Date:   Thu, 19 Jan 2023 16:53:24 -0500
Message-Id: <a8ef7c6915384c87d830e52125d7d0c4a625d15a.1674164991.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1674164991.git.josef@toxicpanda.com>
References: <cover.1674164991.git.josef@toxicpanda.com>
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

