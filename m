Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE6FB17EB45
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Mar 2020 22:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgCIVdN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Mar 2020 17:33:13 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40256 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgCIVdN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Mar 2020 17:33:13 -0400
Received: by mail-pj1-f67.google.com with SMTP id gv19so474771pjb.5
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Mar 2020 14:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bo8A9fMohBCy3HQvkvJX3dofLmoGfNBNutXhMY2i4vE=;
        b=o9/tbouRUzcLt7HJ9XRV9XdGLcewdba936kmr7+b0UFl8nM27MObUYeCZwHgrz1lEE
         qvrOVZraRz4kPjum+PWZToiMDMvurU1KBnJBtm31kb6B3fuvOyyB9oQhgiFjKMOQDxQ/
         vNGBGdezU8qVs64x7NbBz9NWGCXXA72A6HIM1+LpoAeC1X2X3W3g1EaJKkvSUoCYV1Fs
         1/JcV+SN5b3hjmtKeIsofMSK9U3jCJFxm0WZvCRYuIoHca9S40Mxd+BqBj8jSFEAV9cX
         oXo49/h6BZbPzw1aEdVaOPTMP4FiaK5LvjJx95aunR3z327IbWLt30DT4PuZJkLNO0/i
         r0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bo8A9fMohBCy3HQvkvJX3dofLmoGfNBNutXhMY2i4vE=;
        b=UXMSd+Q5w8X6vVah/hiIvb5ZvpTQfehit+KLf3lknj51jEZyNuHjRaHOI1HD6a4rRE
         XFj1IWOK6VQYsd1Wo6GkzS8FHagQQSD+GMA3S3Az2kIT+jkLgrPbwheOmg4HE4WGfql/
         sZX0/08XsJHg6dmzKv0pemY/n8Z/wHKpGZemPBmzHyT1BcwPqj6/XkiHlUazuYhdESnB
         uGfWTWwP0XsGij9Fm2W/g93kpQhw19LVBLfTkAIUMcwxZzbVPWEYhMbI0+kDRlNuhsJ2
         gD9/BC+UbJ8s3f4orL33FVuQv1I2oWhLjuRidLyAFGDfT68zfnVHC93qbyiitKt4AeTq
         +fxQ==
X-Gm-Message-State: ANhLgQ3PKjAZffjZI/AUcTMppenHFPApoGBkcEven9GIMlT0Io0MSWYa
        /atE3npqAdVEhm+lrmmhQQSxFsFM/oI=
X-Google-Smtp-Source: ADFU+vtLMdcHnF3vI8YZ7mlZqsO6JCIqAU/fPJskzkHCJKjPjtJQ1+dNyn3iGEtwPhiYqSJwdd299A==
X-Received: by 2002:a17:902:a415:: with SMTP id p21mr18044318plq.57.1583789590532;
        Mon, 09 Mar 2020 14:33:10 -0700 (PDT)
Received: from vader.tfbnw.net ([2620:10d:c090:400::5:fe90])
        by smtp.gmail.com with ESMTPSA id 13sm44221683pgo.13.2020.03.09.14.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 14:33:10 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, Christoph Hellwig <hch@lst.de>
Subject: [PATCH 14/15] btrfs: get rid of endio_repair_workers
Date:   Mon,  9 Mar 2020 14:32:40 -0700
Message-Id: <222e3f12f3a9130ec95d0c52be44b497989f8370.1583789410.git.osandov@fb.com>
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

This was originally added in commit 8b110e393c5a ("Btrfs: implement
repair function when direct read fails") because the original bio waited
for the repair bio to complete, so the repair I/O couldn't go through
the same workqueue. As of the previous commit, this is no longer true,
so this separate workqueue is unnecessary.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/ctree.h   | 1 -
 fs/btrfs/disk-io.c | 8 +-------
 fs/btrfs/disk-io.h | 1 -
 fs/btrfs/inode.c   | 2 +-
 4 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index ecd016f7dab1..91c7ea587fcd 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -759,7 +759,6 @@ struct btrfs_fs_info {
 	struct btrfs_workqueue *endio_workers;
 	struct btrfs_workqueue *endio_meta_workers;
 	struct btrfs_workqueue *endio_raid56_workers;
-	struct btrfs_workqueue *endio_repair_workers;
 	struct btrfs_workqueue *rmw_workers;
 	struct btrfs_workqueue *endio_meta_write_workers;
 	struct btrfs_workqueue *endio_write_workers;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 6b00ddea0b48..e2d7915f5b03 100644
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
@@ -1955,7 +1953,6 @@ static void btrfs_stop_all_workers(struct btrfs_fs_info *fs_info)
 	btrfs_destroy_workqueue(fs_info->workers);
 	btrfs_destroy_workqueue(fs_info->endio_workers);
 	btrfs_destroy_workqueue(fs_info->endio_raid56_workers);
-	btrfs_destroy_workqueue(fs_info->endio_repair_workers);
 	btrfs_destroy_workqueue(fs_info->rmw_workers);
 	btrfs_destroy_workqueue(fs_info->endio_write_workers);
 	btrfs_destroy_workqueue(fs_info->endio_freespace_worker);
@@ -2141,8 +2138,6 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info,
 	fs_info->endio_raid56_workers =
 		btrfs_alloc_workqueue(fs_info, "endio-raid56", flags,
 				      max_active, 4);
-	fs_info->endio_repair_workers =
-		btrfs_alloc_workqueue(fs_info, "endio-repair", flags, 1, 0);
 	fs_info->rmw_workers =
 		btrfs_alloc_workqueue(fs_info, "rmw", flags, max_active, 2);
 	fs_info->endio_write_workers =
@@ -2166,7 +2161,6 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info,
 	      fs_info->flush_workers &&
 	      fs_info->endio_workers && fs_info->endio_meta_workers &&
 	      fs_info->endio_meta_write_workers &&
-	      fs_info->endio_repair_workers &&
 	      fs_info->endio_write_workers && fs_info->endio_raid56_workers &&
 	      fs_info->endio_freespace_worker && fs_info->rmw_workers &&
 	      fs_info->caching_workers && fs_info->readahead_workers &&
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 59c885860bf8..aef643f26d0c 100644
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
index ef302b7c6c2d..7f00fee5169b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7416,7 +7416,7 @@ static inline blk_status_t submit_dio_repair_bio(struct inode *inode,
 
 	BUG_ON(bio_op(bio) == REQ_OP_WRITE);
 
-	ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DIO_REPAIR);
+	ret = btrfs_bio_wq_end_io(fs_info, bio, BTRFS_WQ_ENDIO_DATA);
 	if (ret)
 		return ret;
 
-- 
2.25.1

