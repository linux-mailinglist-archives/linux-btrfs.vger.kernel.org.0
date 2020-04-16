Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2C71AD22E
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Apr 2020 23:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgDPVqy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Apr 2020 17:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728528AbgDPVqu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Apr 2020 17:46:50 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F97EC061A0C
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Apr 2020 14:46:50 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id w3so127150plz.5
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Apr 2020 14:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v/fPOjwOAoYka/OhWwVPsC5QhTY/u8lwlVc95DvkDNc=;
        b=J5kms3vTWTNFXnLWB+t72U5h0VHZH5C2jHgArcFlzB/v3LlqdG25R4kJ5CBO80IyoT
         bYUQa37S1vdGmWErDxAa/GvvM5W02vfNtuixM+dNdaieHThnpd2nSzymmqm/nQXLxK3a
         POJkciB+XyNwaohpyTs+dgwHKLw5e+e0aNMd0S8Gl6VRiUzk+ZKQB/5FiLcmtOnXKmOr
         /vFblMmFV5YXICwkd165WC6C3PwrwJeJXxO5odKZU8UmgvAsnNZL/16Exvm/hHXE7+PW
         +mFi29lmZjvoPeSozMKylLtSd4aZjejd5sJeApjF4Y9UVFfSrErlFONpDRTRfnN+lfLx
         CPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v/fPOjwOAoYka/OhWwVPsC5QhTY/u8lwlVc95DvkDNc=;
        b=bDsAK3hdHVRg48UrGaOj3VfPD3CHMydwg4aG2hIlBR1ZPYtZfMjRpL059JrZJA9Xaj
         7ppHVrGBNSkpTtCe6bGUnN2Mk6ecMpwdjYWA5fEaLAsmm0KxYKx2QeqM68CHhLi5daJN
         Zss72/BJMPb4ARQdszDcHK54CAvxrAWmxTrswXtD7zURa7VFfk4OpIziIkMyQP/314EZ
         uxEeqrjaU4tPM0yro97a8KDTvDqmDE+PGvpdWeet28o6SeGzRlARPRIC0iaRFgFXfW0z
         qo0XK0UTVoKbWt7T+h0KCe0eNP05wQDY54nO2LD4AIocL1amHpEaCz1Ukca/Jixl2lg5
         ZP3Q==
X-Gm-Message-State: AGi0PuZmFidijecmTBxp8PfbqICVB56mjBvAUAJRclKPo8thr7sipei9
        1uvs6BJoKUN/h7bdbxrgOCceC5W6dDA=
X-Google-Smtp-Source: APiQypIz4Mf40KrkcRVPtXq2pq7lXraOVtS7Wi01khwI8GD1zffytFJqZI/Eem2QUfGiML3lar92+Q==
X-Received: by 2002:a17:90a:65c5:: with SMTP id i5mr491426pjs.18.1587073609523;
        Thu, 16 Apr 2020 14:46:49 -0700 (PDT)
Received: from vader.tfbnw.net ([2620:10d:c090:400::5:844e])
        by smtp.gmail.com with ESMTPSA id 17sm12440228pgg.76.2020.04.16.14.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 14:46:48 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 14/15] btrfs: get rid of endio_repair_workers
Date:   Thu, 16 Apr 2020 14:46:24 -0700
Message-Id: <eaeb0db9587c36102dbe1caf08d9b5e6e541d28e.1587072977.git.osandov@fb.com>
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

This was originally added in commit 8b110e393c5a ("Btrfs: implement
repair function when direct read fails") to avoid a deadlock. In that
commit, the direct I/O read endio executes on the endio_workers
workqueue, submits a repair bio, and waits for it to complete. The
repair bio endio must execute on a different workqueue, otherwise it
could block on the endio_workers workqueue becoming available, which
won't happen because the original endio is blocked on the repair bio.

As of the previous commit, the original endio doesn't wait for the
repair bio, so this separate workqueue is unnecessary.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/ctree.h   | 1 -
 fs/btrfs/disk-io.c | 8 +-------
 fs/btrfs/disk-io.h | 1 -
 fs/btrfs/inode.c   | 2 +-
 4 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c322568231a4..91b9052f315e 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -758,7 +758,6 @@ struct btrfs_fs_info {
 	struct btrfs_workqueue *endio_workers;
 	struct btrfs_workqueue *endio_meta_workers;
 	struct btrfs_workqueue *endio_raid56_workers;
-	struct btrfs_workqueue *endio_repair_workers;
 	struct btrfs_workqueue *rmw_workers;
 	struct btrfs_workqueue *endio_meta_write_workers;
 	struct btrfs_workqueue *endio_write_workers;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a6cb5cbbdb9f..22efd6defcf7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -709,9 +709,7 @@ static void end_workqueue_bio(struct bio *bio)
 		else
 			wq = fs_info->endio_write_workers;
 	} else {
-		if (unlikely(end_io_wq->metadata == BTRFS_WQ_ENDIO_DIO_REPAIR))
-			wq = fs_info->endio_repair_workers;
-		else if (end_io_wq->metadata == BTRFS_WQ_ENDIO_RAID56)
+		if (end_io_wq->metadata == BTRFS_WQ_ENDIO_RAID56)
 			wq = fs_info->endio_raid56_workers;
 		else if (end_io_wq->metadata)
 			wq = fs_info->endio_meta_workers;
@@ -1942,7 +1940,6 @@ static void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
 	btrfs_destroy_workqueue(fs_info->workers);
 	btrfs_destroy_workqueue(fs_info->endio_workers);
 	btrfs_destroy_workqueue(fs_info->endio_raid56_workers);
-	btrfs_destroy_workqueue(fs_info->endio_repair_workers);
 	btrfs_destroy_workqueue(fs_info->rmw_workers);
 	btrfs_destroy_workqueue(fs_info->endio_write_workers);
 	btrfs_destroy_workqueue(fs_info->endio_freespace_worker);
@@ -2148,8 +2145,6 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info,
 	fs_info->endio_raid56_workers =
 		btrfs_alloc_workqueue(fs_info, "endio-raid56", flags,
 				      max_active, 4);
-	fs_info->endio_repair_workers =
-		btrfs_alloc_workqueue(fs_info, "endio-repair", flags, 1, 0);
 	fs_info->rmw_workers =
 		btrfs_alloc_workqueue(fs_info, "rmw", flags, max_active, 2);
 	fs_info->endio_write_workers =
@@ -2173,7 +2168,6 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info,
 	      fs_info->flush_workers &&
 	      fs_info->endio_workers && fs_info->endio_meta_workers &&
 	      fs_info->endio_meta_write_workers &&
-	      fs_info->endio_repair_workers &&
 	      fs_info->endio_write_workers && fs_info->endio_raid56_workers &&
 	      fs_info->endio_freespace_worker && fs_info->rmw_workers &&
 	      fs_info->caching_workers && fs_info->readahead_workers &&
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index cd629113f61c..734bc5270b6a 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -25,7 +25,6 @@ enum btrfs_wq_endio_type {
 	BTRFS_WQ_ENDIO_METADATA,
 	BTRFS_WQ_ENDIO_FREE_SPACE,
 	BTRFS_WQ_ENDIO_RAID56,
-	BTRFS_WQ_ENDIO_DIO_REPAIR,
 };
 
 static inline u64 btrfs_sb_offset(int mirror)
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2580f2d251d4..72fb398a88f7 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7388,7 +7388,7 @@ static inline blk_status_t submit_dio_repair_bio(struct inode *inode,
 
 	BUG_ON(bio_op(bio) == REQ_OP_WRITE);
 
-	ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DIO_REPAIR);
+	ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
 	if (ret)
 		return ret;
 
-- 
2.26.1

