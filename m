Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9722F3B73B2
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Jun 2021 15:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbhF2OCL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Jun 2021 10:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbhF2OCI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Jun 2021 10:02:08 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346A9C0617A6
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Jun 2021 06:59:40 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id v139so3818293qkb.9
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Jun 2021 06:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4ITw8yYO9Mm2EpdRdd+ThoxB7QMMRcOH9aOSdlmSits=;
        b=zel7JVoULkqbaP8qxscO6Snjr185un1aVs6n69TVIE2ow8ljx1kLuJ3hbBwcdWF2hL
         lvlP8kGzZYprBVwJAVmRpORO0WL3q1YlvL0X3bax0f04lv7B8lG5I5JzlpJQvRZDiqbk
         BCyGw+2PBcAECTWQHk28r6hrmT+JHYnyr/vxMl3Y5UqueX3iyONyr8+PKlgB41HCwrEQ
         Zij0gAO2E8zngLniRq6bjBZa90B0eSaQtnt9S41cjmwLJcFa93qyRMyPoKh0O37hno/L
         YQGBvFn9DfjGPeiIn2OfMhjVQmbIvbrEmKMXDAfqGoQHLPixbVRXhXiuJjPAdwR4gf9K
         ZhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ITw8yYO9Mm2EpdRdd+ThoxB7QMMRcOH9aOSdlmSits=;
        b=O0L5T0per4TJ9TrSpiw0471pA7pakS/Mc9F6ZoN0MccI6eUMEbLPpJW0BHOFbqEQSS
         V4yA9WSSBrZQ40azfD3Ym/Z8nIauonvXyYiYLKratB49La9J7gY0Iu+EslKz2fWyG/J/
         ejofs8mknLuoTHVyrknaRJxf7+JJnnRSKzLXDSeYG54+GxPO8vznc9VsmCPUK4RRQOqh
         EnIzjMcWUm78Mba7VOMWPljSJCy5EV33j5HXjoTMAE1oU5IA2yH2iNt11nMXtghgwSNP
         UBa/5fo/qVyVZrUpkS1UwtWMCm7MOZTwHBur5TSanCIBnYDL2EZaBC0HQc2N/qTZDjZa
         EObg==
X-Gm-Message-State: AOAM533CidcUdJhFn/7Jgv/rCn/2PLdssXtc0RdV/HtqTCOVkOJmhbhg
        ZtK5Csr3y4yCXsHdyAWWNo2Pxbq6vFhY3g==
X-Google-Smtp-Source: ABdhPJwvB4exiECoyL1Kq02QkN6xQhdmPZSvL7JXsenHOqVC0ZFyGDrdokutjMOIGDGDgLxiIx63zQ==
X-Received: by 2002:a37:d55:: with SMTP id 82mr17882732qkn.330.1624975178981;
        Tue, 29 Jun 2021 06:59:38 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j3sm9592144qth.63.2021.06.29.06.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 06:59:38 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 8/8] fs: kill sync_inode
Date:   Tue, 29 Jun 2021 09:59:24 -0400
Message-Id: <9e3df65d3e9c7f35acc5434188ec2eaea669c363.1624974951.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1624974951.git.josef@toxicpanda.com>
References: <cover.1624974951.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that all users of sync_inode() have been deleted, remove
sync_inode().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fs-writeback.c  | 19 +------------------
 include/linux/fs.h |  1 -
 2 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index e91980f49388..706dad22f735 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2608,23 +2608,6 @@ int write_inode_now(struct inode *inode, int sync)
 }
 EXPORT_SYMBOL(write_inode_now);
 
-/**
- * sync_inode - write an inode and its pages to disk.
- * @inode: the inode to sync
- * @wbc: controls the writeback mode
- *
- * sync_inode() will write an inode and its pages to disk.  It will also
- * correctly update the inode on its superblock's dirty inode lists and will
- * update inode->i_state.
- *
- * The caller must have a ref on the inode.
- */
-int sync_inode(struct inode *inode, struct writeback_control *wbc)
-{
-	return writeback_single_inode(inode, wbc);
-}
-EXPORT_SYMBOL(sync_inode);
-
 /**
  * sync_inode_metadata - write an inode to disk
  * @inode: the inode to sync
@@ -2641,6 +2624,6 @@ int sync_inode_metadata(struct inode *inode, int wait)
 		.nr_to_write = 0, /* metadata-only */
 	};
 
-	return sync_inode(inode, &wbc);
+	return writeback_single_inode(inode, &wbc);
 }
 EXPORT_SYMBOL(sync_inode_metadata);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index aace07f88b73..7c33e5414747 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2458,7 +2458,6 @@ static inline void file_accessed(struct file *file)
 
 extern int file_modified(struct file *file);
 
-int sync_inode(struct inode *inode, struct writeback_control *wbc);
 int sync_inode_metadata(struct inode *inode, int wait);
 
 struct file_system_type {
-- 
2.26.3

