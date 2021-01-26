Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E163057C5
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 11:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S316711AbhAZXJY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 18:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730332AbhAZVZe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jan 2021 16:25:34 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D61AC06178C
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jan 2021 13:24:53 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id u20so8876192qku.7
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jan 2021 13:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nbxjNvoyoMJEwo+xDtgVNcvJKert0+zn7QBpO6m0d0o=;
        b=CLYM1mLFikUX8gyfzIrkbbfdPh1ULdWanqZtp4bOXJbMpiuRFAJQbN0G6rKecdG+Ng
         wORrtQvXSwlwE5SSuThOK6KrDTh1ra53spsVymoChWz+iOHBb5hwoy9WpNMNoYqdUUZA
         nU4/NBmj3O66XCPgxEYqejSYwqQyWLXmSquYdyhB3/aShVcXm3nZrkIun09aiWmkxt3U
         MR14oFwtHZCR68ZrsGZThbDhs65QEaVMIQSFbtErWglYQ2VASWNR32wY3V3rtGw4t+6i
         zmzHK32rvWSDW/HhANubReDGC8GpBN4jb9Pp1aAaMuw2mlCRhBDMjOeSQmKt3cwVUMbQ
         RH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nbxjNvoyoMJEwo+xDtgVNcvJKert0+zn7QBpO6m0d0o=;
        b=RAdpXkeka479I0+nsitFxMmoqW2g4bTzqOUXwDwRaV6a8a9jNC0YOHKLXttIybVBMJ
         6xB8gdFhrSkziSDrd8076kdC40gB1t1MRI0RbukJIeD0G5joBkTJKiAeIMyaocgUxjKH
         kNxs8/nSlaRVXKVLOdp1bUGHBY6sjjiTKcoOk4CkVwzS7VivDn+fkyRqvUvYZ3WYisQI
         lCn+nWK//bb37G1fcOQowfsrBl1LV9VkV9GrSbKzHH6AWec+SzCYZ4CuWbadsH7gdEZ/
         keOYhoBj2u5nAJJUYQ1PPdXIeSNRiUg3nL2p02JUmDbVlluPcDXn2wUabdldcC0hmrNc
         0MEQ==
X-Gm-Message-State: AOAM530RNNM61Ir9XMA4DekKiNXcf2gKZQroLiuW1atvuVxV1SeJZjqC
        LFe/1vRxGlE+mrFeliJ4BqOxPxrSSf33xvJQ
X-Google-Smtp-Source: ABdhPJyAN0FJLtjAEPqRXQJYEDVnTq7Ke3Q7LUQjP28MxrRNStRDujDMdHxe37V92wROmvfrJ5wPDQ==
X-Received: by 2002:a37:48c3:: with SMTP id v186mr7500342qka.434.1611696292359;
        Tue, 26 Jan 2021 13:24:52 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c7sm13684734qtc.82.2021.01.26.13.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 13:24:51 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v4 08/12] btrfs: rework btrfs_calc_reclaim_metadata_size
Date:   Tue, 26 Jan 2021 16:24:32 -0500
Message-Id: <b06b69ab5c961cedcd337d83241d1722e9e13294.1611695838.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1611695838.git.josef@toxicpanda.com>
References: <cover.1611695838.git.josef@toxicpanda.com>
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
index c3c586b33b4b..8f3b4cc8b812 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -759,7 +759,6 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
 {
 	u64 used;
 	u64 avail;
-	u64 expected;
 	u64 to_reclaim = space_info->reclaim_size;
 
 	lockdep_assert_held(&space_info->lock);
@@ -777,28 +776,6 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
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
 
@@ -807,6 +784,7 @@ static bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
 				    u64 used)
 {
 	u64 thresh = div_factor_fine(space_info->total_bytes, 98);
+	u64 to_reclaim, expected;
 
 	/* If we're just plain full then async reclaim just slows us down. */
 	if ((space_info->bytes_used + space_info->bytes_reserved) >= thresh)
@@ -819,7 +797,25 @@ static bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
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

