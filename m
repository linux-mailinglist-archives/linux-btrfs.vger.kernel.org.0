Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789FE1AD222
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Apr 2020 23:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgDPVqk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Apr 2020 17:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728432AbgDPVqk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Apr 2020 17:46:40 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68B7C061A0C
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Apr 2020 14:46:38 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id cl8so131085pjb.3
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Apr 2020 14:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7URV1UXPA4e6eDFDJgHNM1H+5oNq+PRNWisnAs9Npn0=;
        b=Znx6AbTtASxUQz0JnVHgwk9HslE39nBt8PoYmhS5MbR5a6qHNJP1DYk5ssyZgLhlNl
         brJAikPVRArH3phVJpfKj6lZa6wDAensZOS9b/LXnIiilv2ULbbhAzya2offO6bJetBe
         Yax29TeIinLUp5HovBGW4fzF8/N/GJXU2dh1mV+4bUd54/t3qrz8Wfjov6frc7vKHKbP
         +VdbJeiAfSVhLNnfJzzobSc5Mz5vU9aSgllhQ/92Xh9Fon7Skdqsi4xWeGYD6jQNbiFd
         lMCcTXPZmEFAGQD7ZCBr9gythgYKgOefldQpeuwMyNoL96AUonXAVs0aA1Rn/2i0+ddP
         UxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7URV1UXPA4e6eDFDJgHNM1H+5oNq+PRNWisnAs9Npn0=;
        b=cUUqBAW5nlwXW+rX2/YtcC1O0EFtU3Z6H0AipbpqDa+Q5mu7hieDoM21Hqqx6odtJ6
         KzbJnjaRWF+qG8Qj1PA/PGoBh+h6Xb63R4zF8y+YKRN0GzTaSDCjQ1H0NVccYaG5QMh3
         18PUPj/jh2qV+1/cnGbte0w1boSZWBX3CbErzt0eqVxW+rAWY4URFsF3iGq4exhe5OfC
         foIELX7+hGEsCCa8MCwmxHZOFMLDIjVydHB0s2IarOtdSFJDVIf6mjO6dFmU8gJ/RzD1
         25Qvz/Z0CWbi2F0OKZfhJbBNyeMSXmhxApuiMhmzDe2HdC7VmDUnm8M2zFNFyWFpaAF4
         qsZA==
X-Gm-Message-State: AGi0Pua2hpPHl3Qeb9orgQesXwdKaqHYzWj1+TdrlNWJR6aOgOGDm9Ca
        ucncECUvIz9dO3zKfd3oOuTYljUtgHU=
X-Google-Smtp-Source: APiQypIdIwt7l3WeT7Pg+ZyJOtZolew/bpA6CwcOtFarU1PMjASX/I5D18TzYXzcQXXSZdwAHUQJpQ==
X-Received: by 2002:a17:90a:6fe4:: with SMTP id e91mr500132pjk.28.1587073598097;
        Thu, 16 Apr 2020 14:46:38 -0700 (PDT)
Received: from vader.tfbnw.net ([2620:10d:c090:400::5:844e])
        by smtp.gmail.com with ESMTPSA id 17sm12440228pgg.76.2020.04.16.14.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 14:46:37 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 04/15] btrfs: look at full bi_io_vec for repair decision
Date:   Thu, 16 Apr 2020 14:46:14 -0700
Message-Id: <fbfeded0671dbb2ef682478aebd5693f96fbdeb6.1587072977.git.osandov@fb.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <cover.1587072977.git.osandov@fb.com>
References: <cover.1587072977.git.osandov@fb.com>
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
 fs/btrfs/extent_io.c | 33 +++++++++++++++++++++++++++------
 fs/btrfs/extent_io.h |  5 +++--
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 39e45b8a5031..712f49607d3a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2537,8 +2537,9 @@ int btrfs_get_io_failure_record(struct inode *inode, u64 start, u64 end,
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
@@ -2561,7 +2562,7 @@ bool btrfs_check_repairable(struct inode *inode, unsigned failed_bio_pages,
 	 *	a) deliver good data to the caller
 	 *	b) correct the bad sectors on disk
 	 */
-	if (failed_bio_pages > 1) {
+	if (need_validation) {
 		/*
 		 * to fulfill b), we need to know the exact failing sectors, as
 		 * we don't want to rewrite any more than the failed ones. thus,
@@ -2633,6 +2634,24 @@ struct bio *btrfs_create_repair_bio(struct inode *inode, struct bio *failed_bio,
 	return bio;
 }
 
+static bool btrfs_io_needs_validation(struct inode *inode, struct bio *bio)
+{
+	struct bio_vec *bvec;
+	u64 len = 0;
+	int i;
+
+	/*
+	 * We need to validate each sector individually if the failed I/O was
+	 * for multiple sectors.
+	 */
+	bio_for_each_bvec_all(bvec, bio, i) {
+		len += bvec->bv_len;
+		if (len > inode->i_sb->s_blocksize)
+			return true;
+	}
+	return false;
+}
+
 /*
  * This is a generic handler for readpage errors. If other copies exist, read
  * those and write back good data to the failed position. Does not investigate
@@ -2647,11 +2666,11 @@ static int bio_readpage_error(struct bio *failed_bio, u64 phy_offset,
 	struct inode *inode = page->mapping->host;
 	struct extent_io_tree *tree = &BTRFS_I(inode)->io_tree;
 	struct extent_io_tree *failure_tree = &BTRFS_I(inode)->io_failure_tree;
+	bool need_validation;
 	struct bio *bio;
 	int read_mode = 0;
 	blk_status_t status;
 	int ret;
-	unsigned failed_bio_pages = failed_bio->bi_iter.bi_size >> PAGE_SHIFT;
 
 	BUG_ON(bio_op(failed_bio) == REQ_OP_WRITE);
 
@@ -2659,13 +2678,15 @@ static int bio_readpage_error(struct bio *failed_bio, u64 phy_offset,
 	if (ret)
 		return ret;
 
-	if (!btrfs_check_repairable(inode, failed_bio_pages, failrec,
+	need_validation = btrfs_io_needs_validation(inode, failed_bio);
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
index 2ed65bd0760e..26c0fce0bb64 100644
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
2.26.1

