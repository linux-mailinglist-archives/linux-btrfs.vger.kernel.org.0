Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731C927F2E2
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 22:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbgI3UBj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Sep 2020 16:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbgI3UBi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Sep 2020 16:01:38 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92951C061755
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 13:01:37 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id q5so2818026qkc.2
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 13:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WobvOBhzTUSaULdY03g8qlWp0ZrVM0dAjHmKU+H6kN0=;
        b=ePfkq2SWvN4wImdr5KCwkAunrbpJsoOx9ww/HFwz8j3llg1fUC1Mtl0uuvPghs+BOO
         VYoSsdDdxJxRXoMAGTkmFN0w5xMXOuNIYvjTrASwgBrKOfkIlbFxfOcXGZfr9v0blVs4
         qmdCoYLdtBD7pmc1fI2hNTC/1E3qNWkM/D5i2vIs46b5EPw1fIo4VliyQO5kbr18lnRm
         dzmaC5XCuewsD73PspvEhv7/aqT2G+jCXlZPfOSHT7OA1b+46bdqBI+AUKu1B47tduoJ
         mCFU98SIc+axCrsagcHfwZeQl9tYEZM7vm4iALyJhlOo7Jz2ETV2916hAjLhAZol6QXi
         lDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WobvOBhzTUSaULdY03g8qlWp0ZrVM0dAjHmKU+H6kN0=;
        b=t9GsxAd0Ld2Qea9XGp19RarMTYSQGb8fl3XKTEI6q9/hFtayoSr5bXRQIK+6myJqOi
         wLLNCXji+yXU28zdsOXWLm+QOpHPeHe2s1EoeoKKgQw9N+rSGGjZmWKPIg6eYjcIQg5J
         mBbW3oKWxlh2m0mr1jtZyolR0aBsEoaSlXVwxvyn+y3Xoc9Tr2FhkEdIkvh6QER0mHWZ
         6sxQgeEHWfHRawnvdaTgB/bY7BtZDs8PItHvI3owhpqS18qpeqmfuo02Q+FXcP3mv7cT
         /QsoDbrmD8PUE78U/w7LGSOXyYN4eP05PIh6yeOCOEEUs18Mo1xsgtFF4wbkvRn5hg7o
         4k6g==
X-Gm-Message-State: AOAM531gHWB3InVrF2Qhx3dw4ZAqj2swDF+Lj9d2f+ASe/R67wBxWBdJ
        3k9wtzORGKQRDvQ258qQtPUQpgsDraIJBMyn
X-Google-Smtp-Source: ABdhPJx0OsLNkLawDG0X73DIWvavn2weHTjiwG9eLMeD018/Qf4mcl5Nfq9FCGc0xDz9T6sym5PkEg==
X-Received: by 2002:a37:ef19:: with SMTP id j25mr4013009qkk.363.1601496096374;
        Wed, 30 Sep 2020 13:01:36 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s15sm3198628qkj.21.2020.09.30.13.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 13:01:35 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 7/9] btrfs: implement space clamping for preemptive flushing
Date:   Wed, 30 Sep 2020 16:01:07 -0400
Message-Id: <629f3b0d6b9a100ae2a9ec5826c20cef28eb6b0d.1601495426.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601495426.git.josef@toxicpanda.com>
References: <cover.1601495426.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Starting preemptive flushing at 50% of available free space is a good
start, but some workloads are particularly abusive and can quickly
overwhelm the preemptive flushing code and drive us into using tickets.

Handle this by clamping down on our threshold for starting and
continuing to run preemptive flushing.  This is particularly important
for our overcommit case, as we can really drive the file system into
overages and then it's more difficult to pull it back as we start to
actually fill up the file system.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 20 ++++++++++++++++++--
 fs/btrfs/space-info.h |  3 +++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index a41cf358f438..5ecdd6c41a51 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -206,6 +206,7 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 	INIT_LIST_HEAD(&space_info->ro_bgs);
 	INIT_LIST_HEAD(&space_info->tickets);
 	INIT_LIST_HEAD(&space_info->priority_tickets);
+	space_info->clamp = 1;
 
 	ret = btrfs_sysfs_add_space_info_type(info, space_info);
 	if (ret)
@@ -801,13 +802,13 @@ static inline int need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
 	 * because this doesn't quite work how we want.  If we had more than 50%
 	 * of the space_info used by bytes_used and we had 0 available we'd just
 	 * constantly run the background flusher.  Instead we want it to kick in
-	 * if our reclaimable space exceeds 50% of our available free space.
+	 * if our reclaimable space exceeds our clamped free space.
 	 */
 	thresh = calc_available_free_space(fs_info, space_info,
 					   BTRFS_RESERVE_FLUSH_ALL);
 	thresh += (space_info->total_bytes - space_info->bytes_used -
 		   space_info->bytes_reserved - space_info->bytes_readonly);
-	thresh >>= 1;
+	thresh >>= space_info->clamp;
 
 	used = space_info->bytes_may_use + space_info->bytes_pinned;
 
@@ -1006,6 +1007,7 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 	struct btrfs_block_rsv *delayed_refs_rsv;
 	struct btrfs_block_rsv *global_rsv;
 	struct btrfs_block_rsv *trans_rsv;
+	int loops = 0;
 
 	fs_info = container_of(work, struct btrfs_fs_info,
 			       preempt_reclaim_work);
@@ -1022,6 +1024,8 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 		u64 to_reclaim, block_rsv_size;
 		u64 global_rsv_size = global_rsv->reserved;
 
+		loops++;
+
 		/*
 		 * If we're just full of pinned, commit the transaction.  We
 		 * don't call flush_space(COMMIT_TRANS) here because that has
@@ -1100,6 +1104,10 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 		cond_resched();
 		spin_lock(&space_info->lock);
 	}
+
+	/* We only went through once, back off our clamping. */
+	if (loops == 1 && !space_info->reclaim_size)
+		space_info->clamp = max(1, space_info->clamp - 1);
 	spin_unlock(&space_info->lock);
 }
 
@@ -1499,6 +1507,14 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 			list_add_tail(&ticket.list,
 				      &space_info->priority_tickets);
 		}
+
+		/*
+		 * We were forced to add a reserve ticket, so our preemptive
+		 * flushing is unable to keep up.  Clamp down on the threshold
+		 * for the preemptive flushing in order to keep up with the
+		 * workload.
+		 */
+		space_info->clamp = min(space_info->clamp + 1, 8);
 		trace_btrfs_add_reserve_ticket(fs_info, space_info->flags,
 					       flush, orig_bytes);
 	} else if (!ret && space_info->flags & BTRFS_BLOCK_GROUP_METADATA) {
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 5646393b928c..bcbbfae131f6 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -22,6 +22,9 @@ struct btrfs_space_info {
 				   the space info if we had an ENOSPC in the
 				   allocator. */
 
+	int clamp;		/* Used to scale our threshold for preemptive
+				   flushing. */
+
 	unsigned int full:1;	/* indicates that we cannot allocate any more
 				   chunks for this space */
 	unsigned int chunk_alloc:1;	/* set if we are allocating a chunk */
-- 
2.26.2

