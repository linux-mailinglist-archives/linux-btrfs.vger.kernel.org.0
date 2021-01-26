Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC07304D49
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 00:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732155AbhAZXIS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 18:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730309AbhAZVZa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jan 2021 16:25:30 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA43C06178A
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jan 2021 13:24:49 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id o18so13361093qtp.10
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jan 2021 13:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rb3tEVR+RJdcRH0E4zwHW4rQSrwygXpZYeMKtm460as=;
        b=Tb0pqCI6vfUWafTMUJk4ZCHaWJXOi3rn9BkZHmSPvAnQgkCrsttuWz5IkfRxYG3LVk
         VTGsjKrQ7vIwfO+L2PLhTkbW8QDtDfTuDcIzO4gRwTwWKmPayU1ZjJHfOj1LBHCbjNEk
         aAIlq9JdWZWHciSOfSRMBDO7Yh1QGC/0RIQj9G9py9nYtkE7nv+C39xc5tzHkDqcFrrq
         eqIfjmNZUil8JakojcBow7ItCv/qDqQLR+JWbkK+8eeChOVnpWDMiHB++uU/DUzKLpLl
         uTmQ/rcxCyoYVhdGnlpPUU9LDt62FrUY6KLXBKJlBFFuXJyDHJkdug6byBiT+n4rBzD0
         acvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rb3tEVR+RJdcRH0E4zwHW4rQSrwygXpZYeMKtm460as=;
        b=KruOkiDVeXotokMj1Ub7p9GzYdptI0yagreSPOo1sJzj5K3opnoJc6F7TGNuynkaP0
         2vCBl2uf6lkMTIGZtq7HDZj5mf6BDks+tOUW+hUhSjNTMaTC9eQC597pSaJnvRI//vd0
         Jeh6V/dhBzdZiPUTsGIKBc1AMfQZnJMzAySdL+6N5u2W+vcpCLdJVSl79pjRKYJZCAMY
         sCODxUFogroinZ4qsw8dmHmLUEeMwOPCPklz+uvD3OaSuzcgBAdP+3XyDit/7ZmrYMna
         DuzrYPPaiQGROOdbqOyYFjIvf9L90MYjDGfvB6wAkFbxwHUomhasIHMsTT6JClEeL1VV
         D77g==
X-Gm-Message-State: AOAM533iahgxVF5Nqk+QVvn/kMkN5Z2R6wGCLFkPwtLu0gZTCynDDVuC
        hNM40Cd1nNkpJJb0uMUd4nSD95gKLXyFnCAv
X-Google-Smtp-Source: ABdhPJwSTctsDLQ/NLvXUE/vpJV3PlL5HiyCDwVbiZWg0GTnR1WBQUZkXxnzch/ooA/r6JmVNW4+/w==
X-Received: by 2002:ac8:1381:: with SMTP id h1mr7087501qtj.205.1611696288358;
        Tue, 26 Jan 2021 13:24:48 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c17sm8389329qka.16.2021.01.26.13.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 13:24:47 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v4 06/12] btrfs: rename need_do_async_reclaim
Date:   Tue, 26 Jan 2021 16:24:30 -0500
Message-Id: <913d82b259a192f395c486a27cb8a08002f58473.1611695838.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1611695838.git.josef@toxicpanda.com>
References: <cover.1611695838.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

All of our normal flushing is asynchronous reclaim, so this helper is
poorly named.  This is more checking if we need to preemptively flush
space, so rename it to need_preemptive_reclaim.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index f05c97a2ae7c..e68cd73b4222 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -802,9 +802,9 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
 	return to_reclaim;
 }
 
-static inline int need_do_async_reclaim(struct btrfs_fs_info *fs_info,
-					struct btrfs_space_info *space_info,
-					u64 used)
+static bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
+				    struct btrfs_space_info *space_info,
+				    u64 used)
 {
 	u64 thresh = div_factor_fine(space_info->total_bytes, 98);
 
@@ -1022,7 +1022,7 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 
 	spin_lock(&space_info->lock);
 	used = btrfs_space_info_used(space_info, true);
-	while (need_do_async_reclaim(fs_info, space_info, used)) {
+	while (need_preemptive_reclaim(fs_info, space_info, used)) {
 		enum btrfs_flush_state flush;
 		u64 delalloc_size = 0;
 		u64 to_reclaim, block_rsv_size;
@@ -1509,7 +1509,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 		 * the async reclaim as we will panic.
 		 */
 		if (!test_bit(BTRFS_FS_LOG_RECOVERING, &fs_info->flags) &&
-		    need_do_async_reclaim(fs_info, space_info, used) &&
+		    need_preemptive_reclaim(fs_info, space_info, used) &&
 		    !work_busy(&fs_info->preempt_reclaim_work)) {
 			trace_btrfs_trigger_flush(fs_info, space_info->flags,
 						  orig_bytes, flush, "preempt");
-- 
2.26.2

