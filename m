Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D1527F2DD
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 22:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbgI3UB3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Sep 2020 16:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730220AbgI3UB3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Sep 2020 16:01:29 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D623C061755
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 13:01:29 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id z18so1599523qvp.6
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 13:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wi12q4gwTIvlj3+vc+nfUztA8uzv6orsPeZOxM6Vbjc=;
        b=ZQsR9aN+zdBARPz+NRuE35I5SqFru0gdhW1qw+buSJpf6D3kdYzMzEMiBe7Q+hgE5v
         T2YGt+iCSiwF2Q9bcK8rh4jeUUw5QD1KyTLkGF3uEOqthnIBjAcRXANuTN5zrCzzdXuL
         UakV1GbytmUOZ/68RhB6mQ2i/umX1NUFHd7tLa8v8x2ActRRhBFYlbBzK+aWqVo8Z5Wu
         w2tfBXjjoqg0a1WDpTnJsYerQZFbWavqudkOI91//ZM9SV2PDxfMrh8l4WSh2E1+uM+/
         nUGFc2HgFtnWB6ZwdkrUAhPi0H6kv6KwCETd2X2uCUz1JlZBiqY01ZrdrufN91jupIi+
         OwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wi12q4gwTIvlj3+vc+nfUztA8uzv6orsPeZOxM6Vbjc=;
        b=ie+sOp5jELYqOwmR6nSTSz1cpk1YTGJBdguAEWLWHvc0+1a2JK3iEwuOCr3Iy2WT30
         LsjtkcSxAbCMZMKE4Otd1Vhgqg2a4NajUkvlPIGb5P/b5e9fUSobMCOPl/UJfgA7ng/6
         MAEr+Gj9pF7kdZWPhvQl9flY+ArOCg3KlVr3hASr6LLkYFQ9s6JYhUBuRFgVrxdziZHn
         1XyzHJMjgCbcvNrKN495z/VoNzFzf6LILoTmwaXYYtehmbYTMbWtYzvDc2RsaEkCMhkG
         UpNun7VI0pMMT2q/PT1GfmSXKa0IXDYuSpQ0x+R5v+WP0slsWCe+5mQyq9tJ2j0j6UtH
         yTqg==
X-Gm-Message-State: AOAM530ev2Fb1XJNoqUOfCdbI8oKbG9WIfE/pSvjdUXeoUAbRm0MKC2s
        yKRY1ILFKY4zc85pYd2zs15Ru/HiCFjr8CYD
X-Google-Smtp-Source: ABdhPJwhwV8jzdAlxaekRjeDjmPkkiP8rw0ekkGh3ViVtWhP8tu/6bGDqa+Z7mnTrBDxrrGH/Omf+Q==
X-Received: by 2002:ad4:42c7:: with SMTP id f7mr849075qvr.11.1601496088116;
        Wed, 30 Sep 2020 13:01:28 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o4sm3225362qkj.22.2020.09.30.13.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 13:01:27 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/9] btrfs: rename need_do_async_reclaim
Date:   Wed, 30 Sep 2020 16:01:03 -0400
Message-Id: <0a1d66e4cc97d705ec58980f5883cf2a763a44f6.1601495426.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601495426.git.josef@toxicpanda.com>
References: <cover.1601495426.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

All of our normal flushing is asynchronous reclaim, so this helper is
poorly named.  This is more checking if we need to preemptively flush
space, so rename it to need_preemptive_reclaim.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 024daa843c56..98207ea57a3d 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -795,9 +795,9 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
 	return to_reclaim;
 }
 
-static inline int need_do_async_reclaim(struct btrfs_fs_info *fs_info,
-					struct btrfs_space_info *space_info,
-					u64 used)
+static inline int need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
+					  struct btrfs_space_info *space_info,
+					  u64 used)
 {
 	u64 thresh = div_factor_fine(space_info->total_bytes, 98);
 
@@ -1015,7 +1015,7 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 
 	spin_lock(&space_info->lock);
 	used = btrfs_space_info_used(space_info, true);
-	while (need_do_async_reclaim(fs_info, space_info, used)) {
+	while (need_preemptive_reclaim(fs_info, space_info, used)) {
 		enum btrfs_reserve_flush_enum flush;
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

