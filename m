Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA592B558A
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2019 20:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbfIQSn6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Sep 2019 14:43:58 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38497 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729501AbfIQSn6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Sep 2019 14:43:58 -0400
Received: by mail-qt1-f193.google.com with SMTP id j31so5721018qta.5
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Sep 2019 11:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=q3yCz3OWSJKt06THdJjHiLFdaX0q0cm8at0obtbzLB4=;
        b=rwA0L9RwNm5Dz6EMDmD1THUMiJ5FvlNmk/fFLpXZ0IIvqs+F/+bPkn3x48CeZPRBO0
         DF2H8xEpA524dty6IFXv/rktlHwU0oNfMi9m2AU4Ai7QIWVUQ6ICJ5lIxtHxJ59FZwkC
         GFVjX4vsjvgjkcPdvYuW9JuKt0e2/opI37o0OL//1yL9w4yciHXTvaWOY94XPWvV43w5
         4+NxWV/KK1jAyHa7RojN2/UDTR1NbteY+b6UNcVOX7LiSRg/S56QEpz+WD+6Mcshfxbg
         l180ahiKn9RPNxhbUF7YtWKXn4cyUU6ZPoUmO7chi7dqIIHQTO+JcWvbwvBViQLatmks
         d7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q3yCz3OWSJKt06THdJjHiLFdaX0q0cm8at0obtbzLB4=;
        b=Z8jZ80WBdkN661T2whWBMRU1Sm21Uh1siBF4fLGTPxMd/c+aYWB6yfPyDBe2RF7kiK
         MojTlBaFiY6k9zvtRzCFZRx8o17nsOwf/CO2H4OKN1lgysSwaNlZ7p6tCCQT+BIOQlxG
         Z+/1UD63Nr/lBj5zckeER1PGx0BuZnyd5i3OdA96vA9BqGIyR/ARUDI77QsGsFa+bO/V
         kPC2k0qDflddn6RHp3FXrA8OaWE90mw+UaKE4ANLhYBYHBe0E8VQicUzzi+Q9+DXp/W+
         i7mw4OxguZvb4Pujr4ueiBb+GBPUi/MY3SYIq5f7kQxIen9gsoS+BZA/IMLQOUY5swTG
         I4/g==
X-Gm-Message-State: APjAAAV5qPr/MJFRDt62jvSZZNc/Y4/JwLs0uHxBx0Gcb4rt8EJbDw/C
        X4uXCQuYLxSqSyfohvz0b72G4JMBlbnvcQ==
X-Google-Smtp-Source: APXvYqxWWvwbE7WyY/oeQyUnRrIUVvgVmjavspmbniZFXg8UAU7U3t6Mveh8bgFSLn6h3+RirhHjWA==
X-Received: by 2002:ac8:2eaa:: with SMTP id h39mr166015qta.389.1568745835889;
        Tue, 17 Sep 2019 11:43:55 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id u27sm337737qta.90.2019.09.17.11.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 11:43:55 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/9] btrfs: move the failrec tree stuff into extent-io-tree.h
Date:   Tue, 17 Sep 2019 14:43:39 -0400
Message-Id: <20190917184344.13155-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190917184344.13155-1-josef@toxicpanda.com>
References: <20190917184344.13155-1-josef@toxicpanda.com>
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
index c47cc2586b37..f8134e319b60 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2025,8 +2025,8 @@ u64 count_range_bits(struct extent_io_tree *tree,
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
@@ -2053,8 +2053,8 @@ static noinline int set_state_failrec(struct extent_io_tree *tree, u64 start,
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

