Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56042889CA
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Oct 2020 15:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388601AbgJIN2w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Oct 2020 09:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388573AbgJIN2u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Oct 2020 09:28:50 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D5DC0613D2
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Oct 2020 06:28:48 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id c23so7923750qtp.0
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Oct 2020 06:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MmfoaI3eJ+kGiCbdPPVipxfRlFoYOgOLm0TS7DpTfzc=;
        b=CghjXa7JWyEBrmTpxwvm0f9wtQ3rOOOgv6jW2Fp8EnE32sLIxcIzTswdg24vA/V++J
         zop+GxNxVqWrmjlufPAQyQWoozTCjerO2XhGRU9sp5BDKn4I85LDZ2r2QfXT/6OZN3Jk
         9YPnWaZXuysmf92bF8Gz1CxLRmJVLToA1YvDDB3/oeAfBpPgrosYje4rT3pyGo/bZtUN
         bIXcesWAGnLc0J6++2KSK1+ZHNOQ6dzNw6O2+PsrSI9BZSjwxPi6Ed5vLIOw6kQ3W6mu
         6D4sHbiL4MGb98nHor/DIp1GI8IQT0q9aMIJMXISbuVEOW+cFIPTfTGHnHXdB/oSCsNH
         m6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MmfoaI3eJ+kGiCbdPPVipxfRlFoYOgOLm0TS7DpTfzc=;
        b=AY51WG9L9t5fKadus1iT9fMdDUFo4lSJx7seILQ9MM2IxP5tHDF5Q4YhwjV5E2tY4x
         XTDrT0v7+qu4QSamD0T3Psiz6PqT24gnYXr9A4PZyMc7Tupqp5zRrAj7gc/gJLDqJpf2
         ol398Em+CSw1XReC199LTjtIbQ6GbWXfd1jwW+WJtU0Gq4y5c71Xbfak2On4Uetm2tyq
         lRPnCHFbfE0HnqNFjtO0Cu/m6OA/4EIaDoSpny35X02EeBKfmy6Td67O5HCdUCYO/Bbm
         IIhDbgflbWO07yKBEdg5+Qfqj2R28qRJupVzcXIGb3nKk6GZQVGXQshewI+XjOpNFx4P
         eI4g==
X-Gm-Message-State: AOAM5303rpkuIHBW/S1PEj6AkDHDwcaJomibdMvGMf2topZDOSyrM7bl
        D0QLvvkORO2bybAx7IX3g2zkhtz4TZ9kRuDN
X-Google-Smtp-Source: ABdhPJxKVbHk/O8GdQW6c0byhd9G0kiuAcLFqlARWgLBOB6kjK4ieyZW00yJcAtDr2d49OHY+kDB6Q==
X-Received: by 2002:ac8:37ef:: with SMTP id e44mr13293046qtc.342.1602250127150;
        Fri, 09 Oct 2020 06:28:47 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m97sm6204442qte.55.2020.10.09.06.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 06:28:46 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 08/12] btrfs: rework btrfs_calc_reclaim_metadata_size
Date:   Fri,  9 Oct 2020 09:28:25 -0400
Message-Id: <a4040579beba8551fd0aed11826749e82310df29.1602249928.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602249928.git.josef@toxicpanda.com>
References: <cover.1602249928.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently btrfs_calc_reclaim_metadata_size does two things, it returns
the space currently required for flushing by the tickets, and if there
are no tickets it calculates a value for the preemptive flushing.

However for the normal ticketed flushing we really only care about the
space required for tickets.  We will accidentally come in and flush one
time, but as soon as we see there are no tickets we bail out of our
flushing.

Fix this by making btrfs_calc_reclaim_metadata_size really only tell us
what is required for flushing if we have people waiting on space.  Then
move the preemptive flushing logic into need_preemptive_reclaim().  We
ignore btrfs_calc_reclaim_metadata_size() in need_preemptive_reclaim()
because if we are in this path then we made our reservation and there
are not pending tickets currently, so we do not need to check it, simply
do the fuzzy logic to check if we're getting low on space.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 44 ++++++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 4a25f48fa000..03141251d44e 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -756,7 +756,6 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
 {
 	u64 used;
 	u64 avail;
-	u64 expected;
 	u64 to_reclaim = space_info->reclaim_size;
 
 	lockdep_assert_held(&space_info->lock);
@@ -774,28 +773,6 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
 	if (space_info->total_bytes + avail < used)
 		to_reclaim += used - (space_info->total_bytes + avail);
 
-	if (to_reclaim)
-		return to_reclaim;
-
-	to_reclaim = min_t(u64, num_online_cpus() * SZ_1M, SZ_16M);
-	if (btrfs_can_overcommit(fs_info, space_info, to_reclaim,
-				 BTRFS_RESERVE_FLUSH_ALL))
-		return 0;
-
-	used = btrfs_space_info_used(space_info, true);
-
-	if (btrfs_can_overcommit(fs_info, space_info, SZ_1M,
-				 BTRFS_RESERVE_FLUSH_ALL))
-		expected = div_factor_fine(space_info->total_bytes, 95);
-	else
-		expected = div_factor_fine(space_info->total_bytes, 90);
-
-	if (used > expected)
-		to_reclaim = used - expected;
-	else
-		to_reclaim = 0;
-	to_reclaim = min(to_reclaim, space_info->bytes_may_use +
-				     space_info->bytes_reserved);
 	return to_reclaim;
 }
 
@@ -804,6 +781,7 @@ static inline bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
 					   u64 used)
 {
 	u64 thresh = div_factor_fine(space_info->total_bytes, 98);
+	u64 to_reclaim, expected;
 
 	/* If we're just plain full then async reclaim just slows us down. */
 	if ((space_info->bytes_used + space_info->bytes_reserved) >= thresh)
@@ -816,7 +794,25 @@ static inline bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
 	if (space_info->reclaim_size)
 		return 0;
 
-	if (!btrfs_calc_reclaim_metadata_size(fs_info, space_info))
+	to_reclaim = min_t(u64, num_online_cpus() * SZ_1M, SZ_16M);
+	if (btrfs_can_overcommit(fs_info, space_info, to_reclaim,
+				 BTRFS_RESERVE_FLUSH_ALL))
+		return 0;
+
+	used = btrfs_space_info_used(space_info, true);
+	if (btrfs_can_overcommit(fs_info, space_info, SZ_1M,
+				 BTRFS_RESERVE_FLUSH_ALL))
+		expected = div_factor_fine(space_info->total_bytes, 95);
+	else
+		expected = div_factor_fine(space_info->total_bytes, 90);
+
+	if (used > expected)
+		to_reclaim = used - expected;
+	else
+		to_reclaim = 0;
+	to_reclaim = min(to_reclaim, space_info->bytes_may_use +
+				     space_info->bytes_reserved);
+	if (!to_reclaim)
 		return 0;
 
 	return (used >= thresh && !btrfs_fs_closing(fs_info) &&
-- 
2.26.2

