Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC8267D720
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jan 2023 22:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjAZVBY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Jan 2023 16:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbjAZVBX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Jan 2023 16:01:23 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9984ABE2
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Jan 2023 13:01:12 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id d132so3627143ybb.5
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Jan 2023 13:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=69AIUmk2BRx6jNUD0FIu6c40P8sXnw5ME97i0/q1z8o=;
        b=bOUWDoWQoWUFbNVS3USYcgFYtRItyI5VmDY/EBPIa+tDBA/EW3Hrf/WioVEt6mCuht
         gWF/2M0oNCZU1NlA7mLwd+514CAPdu1Rj7jsQzB0v44nflX9QotvK+dvlIsxNWSk6g6K
         x7iKE2rATNlYCfbEMFP2d5x+1UfRxUQEJxeyk/UQQj5imtSPOXDJsPauoT51JjPNblUM
         MLs3tRYkBL//lwnWdWqK+L7QGoLuYNhnY7db5jRqFbprWgVxywepTrSnClh53n+b/pLH
         KtHoaX0e6tBIGreJqCERZGApkzVFJ94hQy9pJymRAlM0iCYk4eYDJxvuZYD6NxxuIAy9
         C7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=69AIUmk2BRx6jNUD0FIu6c40P8sXnw5ME97i0/q1z8o=;
        b=uXvU/mcIO32T0IoXc1PDQas4MXcI8cfAM/olxcebCqTIpiHRYj13aZigjY/e05j8Qu
         3zT1iv9M1vmFnY0mP0E9ZuGZo6hPGmrck23FFbasGsqs06c309tPiJW8g2ocznxrYrtO
         34QL2r9k8HQAL8Qjin2sUGOTlHJ5qN7ULcuC4iPolu12fdn/zIkZHKqXESeJwIV5jX8s
         sD0T8JVpiAbypjRLL3jWTE+DUjK5rDFIUIvM2Mbd5zGtg660VUc/xQMIHlJq3pDGz0h4
         9cePZy0Y0grRgdpQJItxibRXjSX5NJV8ga1+SQ6CikKcX8/7aOFU3K5Hh0NF07jRTd9I
         pxww==
X-Gm-Message-State: AFqh2koXF3IRiXH0GlGJVHA/Uz2xi3Nfmh44VLYBJXnCn5sZcKkISFKE
        8ZM/nOg4PfF6DVV8bwqy//knuEArU77/tNXd9vI=
X-Google-Smtp-Source: AMrXdXsMR2bQFGdbEVs8k/1FjOKcVu5/n4cCR1MtISDC4Rbrbz8b3JDgVPpCdlwoEbVcL4iOgtQtAA==
X-Received: by 2002:a25:ec0c:0:b0:802:a54a:9123 with SMTP id j12-20020a25ec0c000000b00802a54a9123mr15690716ybh.11.1674766870851;
        Thu, 26 Jan 2023 13:01:10 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id t18-20020a05620a451200b00706adbdf8b8sm1599168qkp.83.2023.01.26.13.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 13:01:10 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 6/7] btrfs: combine btrfs_clear_buffer_dirty and clear_extent_buffer_dirty
Date:   Thu, 26 Jan 2023 16:00:59 -0500
Message-Id: <71d246feb82c0d657ad24ea5106b549e334be17f.1674766637.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1674766637.git.josef@toxicpanda.com>
References: <cover.1674766637.git.josef@toxicpanda.com>
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
 fs/btrfs/disk-io.c   | 16 ----------------
 fs/btrfs/extent_io.c | 16 +++++++++++++++-
 fs/btrfs/extent_io.h |  5 ++++-
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 319d664e1782..68b40c3b0dbb 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -965,22 +965,6 @@ struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 
 }
 
-void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
-			      struct extent_buffer *buf)
-{
-	struct btrfs_fs_info *fs_info = buf->fs_info;
-	if (!trans || btrfs_header_generation(buf) == trans->transid) {
-		btrfs_assert_tree_write_locked(buf);
-
-		if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &buf->bflags)) {
-			percpu_counter_add_batch(&fs_info->dirty_metadata_bytes,
-						 -buf->len,
-						 fs_info->dirty_metadata_batch);
-			clear_extent_buffer_dirty(buf);
-		}
-	}
-}
-
 static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 			 u64 objectid)
 {
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7cd4065acc82..62ca6a23d99b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -36,6 +36,7 @@
 #include "file.h"
 #include "dev-replace.h"
 #include "super.h"
+#include "transaction.h"
 
 static struct kmem_cache *extent_buffer_cache;
 
@@ -4813,12 +4814,25 @@ static void clear_subpage_extent_buffer_dirty(const struct extent_buffer *eb)
 	WARN_ON(atomic_read(&eb->refs) == 0);
 }
 
-void clear_extent_buffer_dirty(const struct extent_buffer *eb)
+void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
+			      struct extent_buffer *eb)
 {
+	struct btrfs_fs_info *fs_info = eb->fs_info;
 	int i;
 	int num_pages;
 	struct page *page;
 
+	btrfs_assert_tree_write_locked(eb);
+
+	if (trans && btrfs_header_generation(eb) != trans->transid)
+		return;
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
index a024655d4237..abebe803bcad 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -11,6 +11,8 @@
 #include "ulist.h"
 #include "misc.h"
 
+struct btrfs_trans_handle;
+
 enum {
 	EXTENT_BUFFER_UPTODATE,
 	EXTENT_BUFFER_DIRTY,
@@ -261,7 +263,6 @@ void extent_buffer_bitmap_set(const struct extent_buffer *eb, unsigned long star
 void extent_buffer_bitmap_clear(const struct extent_buffer *eb,
 				unsigned long start, unsigned long pos,
 				unsigned long len);
-void clear_extent_buffer_dirty(const struct extent_buffer *eb);
 bool set_extent_buffer_dirty(struct extent_buffer *eb);
 void set_extent_buffer_uptodate(struct extent_buffer *eb);
 void clear_extent_buffer_uptodate(struct extent_buffer *eb);
@@ -273,6 +274,8 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 				  u32 bits_to_clear, unsigned long page_ops);
 int extent_invalidate_folio(struct extent_io_tree *tree,
 			    struct folio *folio, size_t offset);
+void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
+			      struct extent_buffer *buf);
 
 int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array);
 
-- 
2.26.3

