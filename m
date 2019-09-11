Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29865AFFF5
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 17:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbfIKP0Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 11:26:25 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45376 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728536AbfIKP0Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 11:26:25 -0400
Received: by mail-qt1-f196.google.com with SMTP id r15so25699356qtn.12
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2019 08:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SjOtCqTXDwvjKFZHNTrsvQfgbzZ3kx7I+ZJpR0mRn3A=;
        b=X5bmGPjog8Y33yNdN4VhAF07Gd/bWNeUW7gdKxyFfCRw8wfXqN/LmsY1g6hK7YDAv5
         Il+xvFVxiVAU3sQE8/JEVSyLI7AGEG58FlTZVMWJSfhSB5JZpSQv1hoHYXyBsMV+loj8
         6CR8dSKQqfc8tktXBJI+zK9fr5aP7V/e7q359YrxsHf3mAU6Ki5RNz8mwXl9Z/w5vOzk
         x6YhrhihJjT/06fpP/O8wIgfgCvg0Q+rMdfLkJcDtUE1ZOnXIuKXMvA1myfbMfA4cjBN
         bJZlj2MKhRJmgpei4sAmyM6jy1RM8LgzdRtliWhszL29kQid0qYOUPm8JCqTVwSrpUVC
         61Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SjOtCqTXDwvjKFZHNTrsvQfgbzZ3kx7I+ZJpR0mRn3A=;
        b=Krc7UtgIUj/tI9hf0g0kHxq0mFEQGC6bSrqSBVgh7G2i6ZKtOT+84gg4gncNcyrRRA
         +dLFQ32UZ941aXK/Qi2T2ethMzj9E67GP7zGsAXXKRPmGyeyjWVdDPjfqCdMyWvVrN+a
         5O+e1rj5W7lvrJN6vSm5fNSkmcWrGkn/PjBbn9KHw/vSXDBDG0BbQZFrQRYNuV0VM5RU
         TXPP6cFkbKaV2HNIPs7H+QxfS4djpG7ma+7uw+xLPNb8569kkUVXK0tvJR4C20hHD5yg
         CVbap6YsQL64TZMO2DRhxMj6DxwRGAOmWkpIsR+ZvygOvNdPjpJa/1I6iU9l5bzVO4Qy
         uOGw==
X-Gm-Message-State: APjAAAXP8aFLMSpDki/VwP47FFNYMoH+0d0RgZ3wG5w9d0onuzIydwzW
        pBZsTUuxMFE+84o59zkFj7TeL/cfj2rvKA==
X-Google-Smtp-Source: APXvYqxxKvTG3pqLZkzNP1vkHEZ6yDnt17NBCXOP1KVQMwztOjighbYg2aVXNJuvqH5OWRoy7G7AMQ==
X-Received: by 2002:a0c:f70c:: with SMTP id w12mr22087314qvn.200.1568215583474;
        Wed, 11 Sep 2019 08:26:23 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id g31sm14656649qte.78.2019.09.11.08.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 08:26:22 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/9] btrfs: move the failrec tree stuff into extent-io-tree.h
Date:   Wed, 11 Sep 2019 11:26:07 -0400
Message-Id: <20190911152611.3393-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190911152611.3393-1-josef@toxicpanda.com>
References: <20190911152611.3393-1-josef@toxicpanda.com>
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
index 1c301681babe..547c0c91eabc 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -4,6 +4,7 @@
 #define BTRFS_EXTENT_IO_TREE_H
 
 struct extent_changeset;
+struct io_failure_record;
 
 /* bits for the extent state */
 #define EXTENT_DIRTY		(1U << 0)
@@ -226,4 +227,21 @@ int extent_invalidatepage(struct extent_io_tree *tree,
 bool find_delalloc_range(struct extent_io_tree *tree, u64 *start, u64 *end,
 			 u64 max_bytes, struct extent_state **cached_state);
 
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
index 751353c88203..d8b07e95d4c2 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2024,8 +2024,8 @@ u64 count_range_bits(struct extent_io_tree *tree,
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
@@ -2052,8 +2052,8 @@ static noinline int set_state_failrec(struct extent_io_tree *tree, u64 start,
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

