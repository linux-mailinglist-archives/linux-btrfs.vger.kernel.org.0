Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D201287D71
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Oct 2020 22:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730738AbgJHUtK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Oct 2020 16:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730070AbgJHUtJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Oct 2020 16:49:09 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360E5C0613D2
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Oct 2020 13:49:08 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id a23so8424567qkg.13
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Oct 2020 13:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x92GZ9vI+s90nNZj2+FRkrNJVlyuJkfTrWIDkz/tp/g=;
        b=Ib0tRl+E3ZexekmcVx1CkTqLO5drrNx7nM6QHsgblFAdwCoeS9YYuomFUsybOHjOQ4
         hudOGIViUthSie/3wg+3WtvmL79Pjpn36EqkZdYw687vWvo3L3KcuvKpWkil0rf9WPaL
         hNbi/Ry/wPt9Usw3vzznc3N9KJKLbIadjUSX3uLLD/NfKwtovH220+A9ZV0AEm8ILEjo
         65pIBhgDbQpD/wFL2ygkJZIq3mJ+HVbmA++P6Ym6C9+LBrYEG4yYlstKks4QxOEy0xwf
         tv/kTicdzi0h49MUHprPzYZY+B1FS4UZ2elk7+KSCXmAhZ163Dw9JerjO3CFCGN2zlY0
         Zkeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x92GZ9vI+s90nNZj2+FRkrNJVlyuJkfTrWIDkz/tp/g=;
        b=ehRZwbs4wSpyYqDCOBz7BgkNP9cg8WbEl7/q49lAHXH79l6aC0I2MSqzA980GzaK87
         7KSV6PgtHGvIMdryNt1ywAMfiT/3mHHndojvOsFMnTdPf7qkbfw07svMYe7W14+T50NA
         j8mhaza4LELfLFS9qhFdctWQIRzK8a4vsETvZM7PlzdtK88rhoRClT7mMGTiyvl1ofM7
         W5k6nF0/saqygeoKxnEa6jt6B7j5V0fudJ3ECOfwtAnHYzTrkjptFLnvvHQPAffr/H08
         eeDD84dcBi0BIXMhEZmN9XoIKp5fKlzPEznjw0iX49W0pHC8R9FdDJIoGGTRsDGX8uyh
         3V6Q==
X-Gm-Message-State: AOAM533jngK0zIH+GC7SbOfWYECLlYEywqqN28E6fUjpUuACAOCTCjY2
        Qj6y7okRbgdOHudXbH+W7eBy0DmXYQ/Rcfa8
X-Google-Smtp-Source: ABdhPJxJlqsiomOIoyd/NNUkD1ZWyvX8QgWjs6oHLxbK7KlgqwscU5ngrHmbMdYJ9Karvfxhejvlvw==
X-Received: by 2002:a37:4bc5:: with SMTP id y188mr6037844qka.429.1602190146920;
        Thu, 08 Oct 2020 13:49:06 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h47sm4922615qtc.80.2020.10.08.13.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 13:49:06 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 05/11] btrfs: rename need_do_async_reclaim
Date:   Thu,  8 Oct 2020 16:48:49 -0400
Message-Id: <2acc05d33ceb7cff539d4a4d8065c530c8e4433e.1602189832.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602189832.git.josef@toxicpanda.com>
References: <cover.1602189832.git.josef@toxicpanda.com>
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
index be054c5b39f6..f16abb214825 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -804,9 +804,9 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
 	return to_reclaim;
 }
 
-static inline int need_do_async_reclaim(struct btrfs_fs_info *fs_info,
-					struct btrfs_space_info *space_info,
-					u64 used)
+static inline bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
+					   struct btrfs_space_info *space_info,
+					   u64 used)
 {
 	u64 thresh = div_factor_fine(space_info->total_bytes, 98);
 
@@ -1024,7 +1024,7 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 
 	spin_lock(&space_info->lock);
 	used = btrfs_space_info_used(space_info, true);
-	while (need_do_async_reclaim(fs_info, space_info, used)) {
+	while (need_preemptive_reclaim(fs_info, space_info, used)) {
 		enum btrfs_reserve_flush_enum flush;
 		u64 delalloc_size = 0;
 		u64 to_reclaim, block_rsv_size;
@@ -1501,7 +1501,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
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

