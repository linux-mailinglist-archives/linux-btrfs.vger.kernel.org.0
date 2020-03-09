Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE03017EB3A
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Mar 2020 22:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgCIVdB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Mar 2020 17:33:01 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45601 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbgCIVdB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Mar 2020 17:33:01 -0400
Received: by mail-pl1-f193.google.com with SMTP id b22so4520040pls.12
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Mar 2020 14:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9PGvqJ2BUvDQxTmPLiiPTrQxtqUzNKxmoj31iqotjZM=;
        b=HRiSjGnmE4GTiups6Z+JVIwXeHKK3V72HEmHnBC83Xtj94OuIQQlL1FZynuiDjWTto
         s7U0nGxrFMwi9EGg6VtYC7JmS+fguDAdK+kBlag5Vp6/0rC9rD0liGT8J9qkn0DlQCka
         Rl4KjIh9/Q0vkaS35Aa5ChORG5nOf0+YIDMOoxh8X3ROOZRtfweNqJzngzygr4bt6ZWx
         oJIcerNfGfHxCp+sGjC3l4PHLi7siMqApg3QKo5+C65XKpK4my0FLrJtNEncbVjXRe2o
         S/OVrE/C7mbEJ441DYC1q8T2HYBtjNP5bYwLQa7SFvu8bfmYjJX6v9PXvNuzGR3Oo0Bf
         TjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9PGvqJ2BUvDQxTmPLiiPTrQxtqUzNKxmoj31iqotjZM=;
        b=KmDR3vY9jZJFV980xAZmE+AeC1dveSH+dZLbYqoSQNGYaOYvpy10DRVCdxT6tkkI9c
         OD7fJ0yt8JMg/jsg0lDyMQYw2/mHdKj6SldDZ1RjG035A3r0uXgF03Ax71ILn9XJM2O+
         PK0O8CO73QibgUL8CJ6k6dUYOjIbwNFnwc/mp49uFMB9By68ha4YvWgT/qMC4laQTku8
         ovFzMD/QN+LucuY6j2Me3bzOObIxa23N06O+XjWoAPtEjqBwDW7IQZocER8l6JzAnvAc
         6KVs/k6Cvb3JzjY4BCo67z5uE1DpAK7fFrjde16gE2qvMMOvPm5kLrz76ett9APHVnhM
         w3OA==
X-Gm-Message-State: ANhLgQ3lh9UzgN6DmhWurp99qn3jEydY+RiM1QI168p4p9rpZU6TKKCS
        V4+IsEzCE9TRsBhr+kmcnJAELXm1bBA=
X-Google-Smtp-Source: ADFU+vukP0f/foyDhE128pHDbI9Q6bQYnxdbA1Slkn2i5ugrfRNmeUjhgmqVkBu0URC/wPtm98V+sA==
X-Received: by 2002:a17:902:be03:: with SMTP id r3mr17654461pls.137.1583789577980;
        Mon, 09 Mar 2020 14:32:57 -0700 (PDT)
Received: from vader.tfbnw.net ([2620:10d:c090:400::5:fe90])
        by smtp.gmail.com with ESMTPSA id 13sm44221683pgo.13.2020.03.09.14.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 14:32:57 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 03/15] btrfs: look at full bi_io_vec for repair decision
Date:   Mon,  9 Mar 2020 14:32:29 -0700
Message-Id: <c0f65f07b18eee7cef4e0b0b439a45ae437a11c6.1583789410.git.osandov@fb.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583789410.git.osandov@fb.com>
References: <cover.1583789410.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Read repair does two things: it finds a good copy of data to return to
the reader, and it corrects the bad copy on disk. If a read of multiple
sectors has an I/O error, repair does an extra "validation" step that
issues a separate read for each sector. This allows us to find the exact
failing sectors and only rewrite those.

This heuristic is implemented in
bio_readpage_error()/btrfs_check_repairable() as:

	failed_bio_pages = failed_bio->bi_iter.bi_size >> PAGE_SHIFT;
	if (failed_bio_pages > 1)
		do validation

However, at this point, bi_iter may have already been advanced. This
means that we'll skip the validation step and rewrite the entire failed
read.

Fix it by getting the actual size from the biovec (which we can do
because this is only called for non-cloned bios, although that will
change in a later commit).

Fixes: 8a2ee44a371c ("btrfs: look at bi_size for repair decisions")
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/extent_io.c | 28 ++++++++++++++++++++++------
 fs/btrfs/extent_io.h |  5 +++--
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 837262d54e28..279731bff0a8 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2528,8 +2528,9 @@ int btrfs_get_io_failure_record(struct inode *inode, u64 start, u64 end,
 	return 0;
 }
 
-bool btrfs_check_repairable(struct inode *inode, unsigned failed_bio_pages,
-			   struct io_failure_record *failrec, int failed_mirror)
+bool btrfs_check_repairable(struct inode *inode, bool need_validation,
+			    struct io_failure_record *failrec,
+			    int failed_mirror)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	int num_copies;
@@ -2552,7 +2553,7 @@ bool btrfs_check_repairable(struct inode *inode, unsigned failed_bio_pages,
 	 *	a) deliver good data to the caller
 	 *	b) correct the bad sectors on disk
 	 */
-	if (failed_bio_pages > 1) {
+	if (need_validation) {
 		/*
 		 * to fulfill b), we need to know the exact failing sectors, as
 		 * we don't want to rewrite any more than the failed ones. thus,
@@ -2638,11 +2639,13 @@ static int bio_readpage_error(struct bio *failed_bio, u64 phy_offset,
 	struct inode *inode = page->mapping->host;
 	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
 	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
+	bool need_validation = false;
+	u64 len;
+	int i;
 	struct bio *bio;
 	int read_mode = 0;
 	blk_status_t status;
 	int ret;
-	unsigned failed_bio_pages = failed_bio->bi_iter.bi_size >> PAGE_SHIFT;
 
 	BUG_ON(bio_op(failed_bio) == REQ_OP_WRITE);
 
@@ -2650,13 +2653,26 @@ static int bio_readpage_error(struct bio *failed_bio, u64 phy_offset,
 	if (ret)
 		return ret;
 
-	if (!btrfs_check_repairable(inode, failed_bio_pages, failrec,
+	/*
+	 * We need to validate each sector individually if the I/O was for
+	 * multiple sectors.
+	 */
+	len = 0;
+	for (i = 0; i < failed_bio->bi_vcnt; i++) {
+		len += failed_bio->bi_io_vec[i].bv_len;
+		if (len > inode->i_sb->s_blocksize) {
+			need_validation = true;
+			break;
+		}
+	}
+
+	if (!btrfs_check_repairable(inode, need_validation, failrec,
 				    failed_mirror)) {
 		free_io_failure(failure_tree, tree, failrec);
 		return -EIO;
 	}
 
-	if (failed_bio_pages > 1)
+	if (need_validation)
 		read_mode |= REQ_FAILFAST_DEV;
 
 	phy_offset >>= inode->i_sb->s_blocksize_bits;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 234622101230..64e176995af2 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -312,8 +312,9 @@ struct io_failure_record {
 };
 
 
-bool btrfs_check_repairable(struct inode *inode, unsigned failed_bio_pages,
-			    struct io_failure_record *failrec, int fail_mirror);
+bool btrfs_check_repairable(struct inode *inode, bool need_validation,
+			    struct io_failure_record *failrec,
+			    int failed_mirror);
 struct bio *btrfs_create_repair_bio(struct inode *inode, struct bio *failed_bio,
 				    struct io_failure_record *failrec,
 				    struct page *page, int pg_offset, int icsum,
-- 
2.25.1

