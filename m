Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDDEC1AD227
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Apr 2020 23:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgDPVqq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Apr 2020 17:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728471AbgDPVqo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Apr 2020 17:46:44 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D09FC061A0F
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Apr 2020 14:46:43 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 188so18552pgj.13
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Apr 2020 14:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0bAwaqJo49nfZ89MyQ5vav/YmbVLjZ8t78bJXkRNkEo=;
        b=nUrxtyk/cWVOYK605qManYjhWmmDlpyhftoOr6VQg322UTWwHESDH/KUyaYD7pDiJI
         Gqpv+4w9r6MYq2Uyqz6xZo+RwoSAq8C6QkHtYCsNxdT55A6c7i+ZDK97IdQMZoL3jgZh
         VoDPghaNIJkxWRMgPxlEcVysaO6g+2O77pSjO4mmx1jpOV7/WiZKaa2jrPTsRo1ujtdd
         sGGS+pG5t/ZSRiuy7kLwXxP0BSc4ZwUVMhgp/QLSI97TwfkXyQ87XGgmmvggNxn0gMFM
         pfl/HjI/2e6Qr8TJYnS2TXe22Op3K77LmbmHdhPBxTk9UzowBzvi210NDgzsE3qRNRln
         0PYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0bAwaqJo49nfZ89MyQ5vav/YmbVLjZ8t78bJXkRNkEo=;
        b=QalYm9FXoZyLZqEKPsBQsQh3Qp2GJnWReWMZR73hzC3lReXvehtUCn2q+MyzT7tjYq
         +kCMXQF+op+xJdSXbyRbivaQB8K7sLMnSXcvHzn/UHgd0HsEF0+3WlG25LpfVyYj7lvt
         KEfZaTNtTpsc9i5KalufnYNd/JS7l3rrw2lsNS2DE0jjE0eQ/TJRqelLBHqzf76VHh0/
         kqoFgPYfAcbQJIzr23SJyoOFIeyVygbhg4QvmS9KyORqldwqiiOtZmmBTfJxP2iwcBhD
         KaEXLIMlzEff0vrzPcYJO/uVLJPCgPiqaKvkcZC+rkXzgNZNjbbmZiUu0BZejJuBzz9T
         hOqg==
X-Gm-Message-State: AGi0PubPiNmLGpalWwI6Eqig/ABJa6C0NLtRkXOJvvwZQ6gq3DuR6tRV
        puUpAW0qqMdQctRoBxHXiPhFmk0eTT0=
X-Google-Smtp-Source: APiQypKWtUd1Wx+cLpg9Qn8ML1MuU4fHTe7X8ka8sFztKDudai0mpg1Ss69iRMOkkxN2a187Y6ZrpA==
X-Received: by 2002:a63:c34e:: with SMTP id e14mr34064356pgd.212.1587073602620;
        Thu, 16 Apr 2020 14:46:42 -0700 (PDT)
Received: from vader.tfbnw.net ([2620:10d:c090:400::5:844e])
        by smtp.gmail.com with ESMTPSA id 17sm12440228pgg.76.2020.04.16.14.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 14:46:42 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 08/15] btrfs: make btrfs_check_repairable() static
Date:   Thu, 16 Apr 2020 14:46:18 -0700
Message-Id: <1fb537b8b19364290de431a48a243800ce930c3b.1587072977.git.osandov@fb.com>
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

Since its introduction in commit 2fe6303e7cd0 ("Btrfs: split
bio_readpage_error into several functions"), btrfs_check_repairable()
has only been used from extent_io.c where it is defined.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/extent_io.c | 7 ++++---
 fs/btrfs/extent_io.h | 3 ---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 25dd42437cbd..85e98ba349a8 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2537,9 +2537,10 @@ int btrfs_get_io_failure_record(struct inode *inode, u64 start, u64 end,
 	return 0;
 }
 
-bool btrfs_check_repairable(struct inode *inode, bool need_validation,
-			    struct io_failure_record *failrec,
-			    int failed_mirror)
+static bool btrfs_check_repairable(struct inode *inode,
+				   bool need_validation,
+				   struct io_failure_record *failrec,
+				   int failed_mirror)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	int num_copies;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 26c0fce0bb64..f4dfac756455 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -312,9 +312,6 @@ struct io_failure_record {
 };
 
 
-bool btrfs_check_repairable(struct inode *inode, bool need_validation,
-			    struct io_failure_record *failrec,
-			    int failed_mirror);
 struct bio *btrfs_create_repair_bio(struct inode *inode, struct bio *failed_bio,
 				    struct io_failure_record *failrec,
 				    struct page *page, int pg_offset, int icsum,
-- 
2.26.1

