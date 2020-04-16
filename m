Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468011AD228
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Apr 2020 23:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgDPVqr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Apr 2020 17:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728471AbgDPVqq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Apr 2020 17:46:46 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1357C061A0C
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Apr 2020 14:46:45 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g6so29306pgs.9
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Apr 2020 14:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vY5HUibLoi3EGBd4zQyj1Rq2qF7F5ToVSUzWu/dewGw=;
        b=Y8UoUhVDLvqBKG0Aq8CceeSgZs/NovicrLE0G2m2rzv+2/lN5BF70fuAEr/L7yAMGD
         U1eGUHyOsCWtbOHGYlFEL3VehitpglPIo7EkyMXZtWPNAd7jLFpGHvJRnOINUjeeVGzZ
         9QJApgNPgaBymNEm/5p9mLXCQzuFXVX58pg7zbyw3+ockBj2EkLyAvX8FVAJplo0TaDh
         ZUkuzRVhE7agJ2fEtaqr/KteYtUoBkWtRzL3klewel5g7pryLAQO7iKiGBLJ3tnYkGGc
         q+XfWcNvrvb+ilgg4KjTSUyVfGOp+JuZlbZa/TLDSKzS1dHT2TYbECcyNrbvK9tZLnXM
         4rKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vY5HUibLoi3EGBd4zQyj1Rq2qF7F5ToVSUzWu/dewGw=;
        b=q/lmWWV4ceuQe2+oj3HSTaVoyoWReXck9W1zzWxwl/XarePtIelyWAiYoJZsxKZLlO
         uamJpGGnwJUX2J5MN5weMF0CWkh0QHuGNNP57H7mElWs4bfVwnBjzQNcpBj4SmY9xxZy
         cznbrxjZYi6ztbyOyld5ufgYxE578Sh+F+Dv/kiOt8jdfDQABjv14GvA1MtHflDhr8LH
         6/og4OlT+O+Bn6q41OeuFioLYg/hERhtDQTqzjcLgCu3jl4MLmEaxMAMJZaUFMtQja5S
         bM+ADMHvBkkQfNhiUrbBg38IBvhSGHVjFiPQryqpM/RnFjf4HT9tY0liiOyAE3QXoQ/S
         CiZw==
X-Gm-Message-State: AGi0PuZbWWEPSif3fsjjZFl25A2ZXWvobxpfpsnDl73wspIXO0xHmVvk
        UiIBUoUnMMJhJpAnFuzBgHsjAYdkuuQ=
X-Google-Smtp-Source: APiQypIa/tXRzeuL2YDa6bSPT337H6JymrCYogw1aph58TPbgraC/lKduDngcdLlk70mSqJRKrXdNA==
X-Received: by 2002:a63:cf4e:: with SMTP id b14mr34006297pgj.344.1587073604892;
        Thu, 16 Apr 2020 14:46:44 -0700 (PDT)
Received: from vader.tfbnw.net ([2620:10d:c090:400::5:844e])
        by smtp.gmail.com with ESMTPSA id 17sm12440228pgg.76.2020.04.16.14.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 14:46:44 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 10/15] btrfs: convert btrfs_dio_private->pending_bios to refcount_t
Date:   Thu, 16 Apr 2020 14:46:20 -0700
Message-Id: <14a8c9acc19ad08c31615616d007cc23e70ae0d0.1587072977.git.osandov@fb.com>
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

This is really a reference count now, so convert it to refcount_t and
rename it to refs.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/btrfs_inode.h |  8 ++++++--
 fs/btrfs/inode.c       | 10 +++++-----
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index ad36685ce046..b965fa5429ec 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -7,6 +7,7 @@
 #define BTRFS_INODE_H
 
 #include <linux/hash.h>
+#include <linux/refcount.h>
 #include "extent_map.h"
 #include "extent_io.h"
 #include "ordered-data.h"
@@ -302,8 +303,11 @@ struct btrfs_dio_private {
 	u64 disk_bytenr;
 	u64 bytes;
 
-	/* number of bios pending for this dio */
-	atomic_t pending_bios;
+	/*
+	 * References to this structure. There is one reference per in-flight
+	 * bio plus one while we're still setting up.
+	 */
+	refcount_t refs;
 
 	/* IO errors */
 	int errors;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d7cf248dd634..4b1102f2e6b8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7811,7 +7811,7 @@ static void btrfs_end_dio_bio(struct bio *bio)
 	}
 
 	/* if there are more bios still pending for this dio, just exit */
-	if (!atomic_dec_and_test(&dip->pending_bios))
+	if (!refcount_dec_and_test(&dip->refs))
 		goto out;
 
 	if (dip->errors) {
@@ -7929,7 +7929,7 @@ static struct btrfs_dio_private *btrfs_create_dio_private(struct bio *dio_bio,
 	dip->disk_bytenr = (u64)dio_bio->bi_iter.bi_sector << 9;
 	dip->orig_bio = bio;
 	dip->dio_bio = dio_bio;
-	atomic_set(&dip->pending_bios, 1);
+	refcount_set(&dip->refs, 1);
 
 	if (write) {
 		struct btrfs_dio_data *dio_data = current->journal_info;
@@ -8021,13 +8021,13 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 		 * count. Otherwise, the dip might get freed before we're
 		 * done setting it up.
 		 */
-		atomic_inc(&dip->pending_bios);
+		refcount_inc(&dip->refs);
 
 		status = btrfs_submit_dio_bio(bio, inode, file_offset,
 						async_submit);
 		if (status) {
 			bio_put(bio);
-			atomic_dec(&dip->pending_bios);
+			refcount_dec(&dip->refs);
 			goto out_err;
 		}
 
@@ -8056,7 +8056,7 @@ static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode,
 	 * atomic operations with a return value are fully ordered as per
 	 * atomic_t.txt
 	 */
-	if (atomic_dec_and_test(&dip->pending_bios))
+	if (refcount_dec_and_test(&dip->refs))
 		bio_io_error(dip->orig_bio);
 }
 
-- 
2.26.1

