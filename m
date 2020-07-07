Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306772172B6
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 17:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbgGGPnO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 11:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbgGGPnN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jul 2020 11:43:13 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5876C061755
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jul 2020 08:43:13 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id d27so32074073qtg.4
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jul 2020 08:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wOl3r3XCtXoWmA1dQ3UTMbZ8Zu77pCaRE4U/fVaboV8=;
        b=veM8OZDDxbHJ83QdQrZtBUvdDKDYAzMl3lANMcx23NxFPUt5MvHzD05WamxqbhJghv
         FuMkrStDjEkVqT72ihu67wXmQol5sQ1DNdnr4csK4fxU5uEq1LHFkeX2VsCppKJhoyKe
         mv7JPnbhQe1qUG0AoiZO9vYgzi3VQCmcy98sSGnvMD42ZLOzEhpqSuvNtMf5P1Z2686w
         oNLaL5hj1YThxGxvBRbHVcgGCfQmFhZSpfGtsr7VdoCV+NX7UTo4CkFANxmiVA+xpbAw
         F3+VQUILzQpsQhr2/+QMA9EbjABpwZL7KwV4mRo0jsUzQ9vFNUb+VupNj8pBh+e4sT3H
         YZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wOl3r3XCtXoWmA1dQ3UTMbZ8Zu77pCaRE4U/fVaboV8=;
        b=IphahFqtHibaYeSJIN3IbmUUyCPSwTa7khI5QovOZYuic3ciwlAFEFcLJCr8ufrxWC
         7N+3h5d0J95jgnsw8GsdcHDjMnSdeWM1tWyfPqtZKk6bkI/s8x+dthAxPk42c73VboHo
         MoceRDxVMXqjVlcjAlY/mzGlIgFDjTMkUuu8V+2cmIwd/ASOiy9ncLsidOGXuKvkcyc4
         F5Y5BhG9w4ZvgrHMudfP/1o2B3MOtPRZ39+MV9oKvXw8E0cNNNGZuijxZWiyaSV3hv6v
         9sffMlu55uceG+URpgOm3tFNQToyM/auLvjM4ZYg8ejhVte61v8bDLFY/jaL8XQ6f8M9
         rlBQ==
X-Gm-Message-State: AOAM530tOCKQpls1/qq3jQgbrFKIloOW8dz2Wm1IXZ99tK3Y5oC8r0G2
        0ogQlKzwpr2HO3Mqg9n5/b1iCuf3tEiK5Q==
X-Google-Smtp-Source: ABdhPJzZvIWbDqegIjOTjwrb4+FFirzHnFcYXm69ksbyd7KLJQABs7tG5sLncFEWF6Jbg5kC+2KK5A==
X-Received: by 2002:ac8:1090:: with SMTP id a16mr57530037qtj.181.1594136592628;
        Tue, 07 Jul 2020 08:43:12 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a185sm24356091qkg.3.2020.07.07.08.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 08:43:12 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 12/23] btrfs: add flushing states for handling data reservations
Date:   Tue,  7 Jul 2020 11:42:35 -0400
Message-Id: <20200707154246.52844-13-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200707154246.52844-1-josef@toxicpanda.com>
References: <20200707154246.52844-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently the way we do data reservations is by seeing if we have enough
space in our space_info.  If we do not and we're a normal inode we'll

1) Attempt to force a chunk allocation until we can't anymore.
2) If that fails we'll flush delalloc, then commit the transaction, then
   run the delayed iputs.

If we are a free space inode we're only allowed to force a chunk
allocation.  In order to use the normal flushing mechanism we need to
encode this into a flush state array for normal inodes.  Since both will
start with allocating chunks until the space info is full there is no
need to add this as a flush state, this will be handled specially.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h      | 2 ++
 fs/btrfs/space-info.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 93cd1ff878cb..efa72a204b91 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2569,6 +2569,8 @@ enum btrfs_reserve_flush_enum {
 	 */
 	BTRFS_RESERVE_FLUSH_LIMIT,
 	BTRFS_RESERVE_FLUSH_EVICT,
+	BTRFS_RESERVE_FLUSH_DATA,
+	BTRFS_RESERVE_FLUSH_FREE_SPACE_INODE,
 	BTRFS_RESERVE_FLUSH_ALL,
 	BTRFS_RESERVE_FLUSH_ALL_STEAL,
 };
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 0b6566a3da61..e041b1d58e28 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1018,6 +1018,12 @@ static const enum btrfs_flush_state evict_flush_states[] = {
 	COMMIT_TRANS,
 };
 
+static const enum btrfs_flush_state data_flush_states[] = {
+	FLUSH_DELALLOC_WAIT,
+	COMMIT_TRANS,
+	RUN_DELAYED_IPUTS,
+};
+
 static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 				struct btrfs_space_info *space_info,
 				struct reserve_ticket *ticket,
-- 
2.24.1

