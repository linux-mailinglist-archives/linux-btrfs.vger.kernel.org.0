Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D479936DE82
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 19:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240429AbhD1Rkz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Apr 2021 13:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242770AbhD1Rjo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Apr 2021 13:39:44 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F9AC061573
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Apr 2021 10:38:59 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id a30so4444165qvb.12
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Apr 2021 10:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=W0QBmd3JB0oGkZyaFdM3QZpUQdmhZeiq7BV9Xb1MG/Y=;
        b=zJrfnhpvu5m6JwuZRwA33yBY9f0M9mP28b5V9GpjJtxu3Z1q5jIpYsHg2ginlmkCni
         U5EjOify0C73Z0Xvh7WAPbznOaz04ZCcuWGr0woMY+0272XKEGfsNtT83/xNNDBB3oWI
         gKWdAtGFKOXPU1bvGOWfeoxPY73/lbHmYBVc6B/fyJURdp9sH/hw1B+X/ZJaMAOmJpRS
         Jcs1aosnP30ucVC4IzNopdwBp9WaiRaQbupq69KXTFOxFD4q2kmN6m5NmFQY02oE1Xp+
         yn0dJHhc+a3dGSUiTRhxNi/2dpM1XbI0yQ6MU+dj4TeQsu2ezB526CNAfPFjE7G20Q1g
         G7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W0QBmd3JB0oGkZyaFdM3QZpUQdmhZeiq7BV9Xb1MG/Y=;
        b=Lax9hbB2DmWwLJEDg4YePPavTA9MXY0kOc6Tgc/v/xlgwUaqbozD0vw/37iU9SJFs0
         w3/BmwCtww8XyTuRR6OQY8UTU3q9cG4yLvb0taoWHWOqb5COW1glsrslORQK+ZaA8rkT
         t6rhzdNLXNLXZmc9JFDo7VZHeNsM8qugKI98uwqr4BoxhG2Gxwgh2QEK1I47lz807Ejz
         mydpKKOfA3WSCLM2gvZ93FWKc39ygFWSbSqtVbuuQMfQj23AzPuKI2E+eu2y84J617b8
         3kEEviSgANx/gkt3Ye+WCk/gj5+cf/F49PQo5J6Gp94y0iF3qgLZrZ+yD/EhzOfLcdJF
         svjQ==
X-Gm-Message-State: AOAM533H1uItTBjzS69cL8uwpG5OQJqdJ1qydBzGl4Mf8zKIOGAjBVAS
        FHUJeVDXCFYS6Tm+hKZxq9x6CvH3WRey2Q==
X-Google-Smtp-Source: ABdhPJxFlyBisYO+95Rh1BlBCposUylQMjOuQtvZTRE7yKluqpYYTzAAI3CLBR2Wuiz0+IfNQnFQWA==
X-Received: by 2002:a0c:e50e:: with SMTP id l14mr6624923qvm.52.1619631538369;
        Wed, 28 Apr 2021 10:38:58 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h188sm306216qkd.23.2021.04.28.10.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 10:38:57 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 6/7] btrfs: only ignore delalloc if delalloc is much smaller than ordered
Date:   Wed, 28 Apr 2021 13:38:47 -0400
Message-Id: <c8ac5979d064d6574eb17a99110ae36023025e3e.1619631053.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1619631053.git.josef@toxicpanda.com>
References: <cover.1619631053.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While testing heavy delalloc workloads I noticed that sometimes we'd
just stop preemptively flushing when we had loads of delalloc available
to flush.  This is because we skip preemptive flushing if delalloc <=
ordered.  However if we start with say 4gib of delalloc, and we flush
2gib of that, we'll stop flushing there, when we still have 2gib of
delalloc to flush.

Instead adjust the ordered bytes down by half, this way if 2/3 of our
outstanding delalloc reservations are tied up by ordered extents we
don't bother preemptive flushing, as we're getting close to the state
where we need to wait on ordered extents.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 4e3857474cfd..cf09b23f3448 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -864,8 +864,14 @@ static bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
 	 * clearly be heavy enough to warrant preemptive flushing.  In the case
 	 * of heavy DIO or ordered reservations, preemptive flushing will just
 	 * waste time and cause us to slow down.
+	 *
+	 * We want to make sure we truly are maxed out on ordered however, so
+	 * cut ordered in half, and if it's still higher than delalloc then we
+	 * can keep flushing.  This is to avoid the case where we start
+	 * flushing, and now delalloc == ordered and we stop preemptively
+	 * flushing when we could still have several gigs of delalloc to flush.
 	 */
-	ordered = percpu_counter_read_positive(&fs_info->ordered_bytes);
+	ordered = percpu_counter_read_positive(&fs_info->ordered_bytes) >> 1;
 	delalloc = percpu_counter_read_positive(&fs_info->delalloc_bytes);
 	if (ordered >= delalloc)
 		used += fs_info->delayed_refs_rsv.reserved +
-- 
2.26.3

