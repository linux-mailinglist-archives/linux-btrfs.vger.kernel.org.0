Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01CB4BB632
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2019 16:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407318AbfIWOFk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Sep 2019 10:05:40 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36596 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404990AbfIWOFk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Sep 2019 10:05:40 -0400
Received: by mail-qt1-f193.google.com with SMTP id o12so17286175qtf.3
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Sep 2019 07:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1caVf9ZbZKBUVg6x4KEYOylegZv48CrFTiPOun1bG/s=;
        b=w5w17Ud/28+pFugLGyBwPy23pAr8froSJFTzNW3IYakAhvTQpuKiqWYMDYfnAkhcpP
         ATobiDoXwe+6EanjDUAbOHS+0hspJXcY0QazTqvXU/ZyKkn+96iB4peuK0ZC5e/4xWXJ
         XqfmrN8NT+VUvDr98kEJNTEC5IeRgLFYpSoDcB0mnfEUK5B4CXOSIb/80eppxBB3zeCE
         634Xxb+YkmRZN+24uIBXSdXhD3izNs+qFMRRnNR22lxCj8M6vUfTEsrnPm/q2r1F4Mrb
         Pet2HFZzGLE746EbD9JqVqwCEah0s0EucyuCqBmJ9uvcDHH1Crm7LprX8Ztf7DT6OWvH
         l6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1caVf9ZbZKBUVg6x4KEYOylegZv48CrFTiPOun1bG/s=;
        b=UXlZ75FY9yshuEab2WpOVoRwsMXrBbg+0W7hj/3d8pRUT//aqxCC18lfLEGX1H0qzr
         RFnNDll3PQk8SItxaNoj9MGySUl7/iTewc874IVwfZzUo2eP4SMcHz5ubySTRpoLAqf/
         NJo320n4d7wdgc4Y9KB/Ske3JFifE11WcQxN/YoQaL6CIfW0zLRDE3PJCC9YG3tcWW0V
         Oj2LuZw7/nua40tbJyCW/lDmIBBu4i1pO/JwSeaO0tn8gr/2+dcO47iNl+zBjBRiIZS7
         V1XyfR0WxTae4Tw+7QSF28hMR8vTBq14tC6Qjcf6R7u9b/2S1+QHw6E9QcUsBP/FZgZo
         5i8A==
X-Gm-Message-State: APjAAAWgCaDsUFjlP37pFWryvrhbaAwj6vq/f+pv9EBXdePylvmeqJOd
        RxA2sB9MlflWJcxgIGtGJI7GDjjJLCXo+g==
X-Google-Smtp-Source: APXvYqy0+Ws1UJrijPiy0HBKTg2uNyrtlS1MtqVOi3ca7rYTzj7lIz7hAkT0YXPfua6cUEUcMNyu7A==
X-Received: by 2002:ac8:6796:: with SMTP id b22mr44943qtp.95.1569247538309;
        Mon, 23 Sep 2019 07:05:38 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id e11sm4885220qkg.134.2019.09.23.07.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 07:05:37 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/9] btrfs: move the failrec tree stuff into extent-io-tree.h
Date:   Mon, 23 Sep 2019 10:05:21 -0400
Message-Id: <20190923140525.14246-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190923140525.14246-1-josef@toxicpanda.com>
References: <20190923140525.14246-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This needs to be cleaned up in the future, but for now it belongs to the
extent-io-tree stuff since it uses the internal tree search code.
Needed to export get_state_failrec and set_state_failrec as well since
we're not going to move the actual IO part of the failrec stuff out at
this point.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.h | 18 ++++++++++++++++++
 fs/btrfs/extent_io.c      |  8 ++++----
 fs/btrfs/extent_io.h      | 11 -----------
 3 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 02fbb0d4fa88..0ba3222ee1f0 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -4,6 +4,7 @@
 #define BTRFS_EXTENT_IO_TREE_H
 
 struct extent_changeset;
+struct io_failure_record;
 
 /* bits for the extent state */
 #define EXTENT_DIRTY		(1U << 0)
@@ -227,4 +228,21 @@ bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
 			       u64 *end, u64 max_bytes,
 			       struct extent_state **cached_state);
 
+/* This should be reworked in the future and put elsewhere. */
+int get_state_failrec(struct extent_io_tree *tree, u64 start,
+		      struct io_failure_record **failrec);
+int set_state_failrec(struct extent_io_tree *tree, u64 start,
+		      struct io_failure_record *failrec);
+void btrfs_free_io_failure_record(struct btrfs_inode *inode, u64 start,
+		u64 end);
+int btrfs_get_io_failure_record(struct inode *inode, u64 start, u64 end,
+				struct io_failure_record **failrec_ret);
+int free_io_failure(struct extent_io_tree *failure_tree,
+		    struct extent_io_tree *io_tree,
+		    struct io_failure_record *rec);
+int clean_io_failure(struct btrfs_fs_info *fs_info,
+		     struct extent_io_tree *failure_tree,
+		     struct extent_io_tree *io_tree, u64 start,
+		     struct page *page, u64 ino, unsigned int pg_offset);
+
 #endif /* BTRFS_EXTENT_IO_TREE_H */
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 690e1ac0b54d..8767b9ba848b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2026,8 +2026,8 @@ u64 count_range_bits(struct extent_io_tree *tree,
  * set the private field for a given byte offset in the tree.  If there isn't
  * an extent_state there already, this does nothing.
  */
-static noinline int set_state_failrec(struct extent_io_tree *tree, u64 start,
-		struct io_failure_record *failrec)
+int set_state_failrec(struct extent_io_tree *tree, u64 start,
+		      struct io_failure_record *failrec)
 {
 	struct rb_node *node;
 	struct extent_state *state;
@@ -2054,8 +2054,8 @@ static noinline int set_state_failrec(struct extent_io_tree *tree, u64 start,
 	return ret;
 }
 
-static noinline int get_state_failrec(struct extent_io_tree *tree, u64 start,
-		struct io_failure_record **failrec)
+int get_state_failrec(struct extent_io_tree *tree, u64 start,
+		      struct io_failure_record **failrec)
 {
 	struct rb_node *node;
 	struct extent_state *state;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 8c782d061132..e22045cef89b 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -296,10 +296,6 @@ struct btrfs_inode;
 int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 		      u64 length, u64 logical, struct page *page,
 		      unsigned int pg_offset, int mirror_num);
-int clean_io_failure(struct btrfs_fs_info *fs_info,
-		     struct extent_io_tree *failure_tree,
-		     struct extent_io_tree *io_tree, u64 start,
-		     struct page *page, u64 ino, unsigned int pg_offset);
 void end_extent_writepage(struct page *page, int err, u64 start, u64 end);
 int btrfs_repair_eb_io_failure(struct extent_buffer *eb, int mirror_num);
 
@@ -323,19 +319,12 @@ struct io_failure_record {
 };
 
 
-void btrfs_free_io_failure_record(struct btrfs_inode *inode, u64 start,
-		u64 end);
-int btrfs_get_io_failure_record(struct inode *inode, u64 start, u64 end,
-				struct io_failure_record **failrec_ret);
 bool btrfs_check_repairable(struct inode *inode, unsigned failed_bio_pages,
 			    struct io_failure_record *failrec, int fail_mirror);
 struct bio *btrfs_create_repair_bio(struct inode *inode, struct bio *failed_bio,
 				    struct io_failure_record *failrec,
 				    struct page *page, int pg_offset, int icsum,
 				    bio_end_io_t *endio_func, void *data);
-int free_io_failure(struct extent_io_tree *failure_tree,
-		    struct extent_io_tree *io_tree,
-		    struct io_failure_record *rec);
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 bool find_lock_delalloc_range(struct inode *inode,
 			     struct page *locked_page, u64 *start,
-- 
2.21.0

