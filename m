Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6325287D73
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Oct 2020 22:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730752AbgJHUtN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Oct 2020 16:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730070AbgJHUtM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Oct 2020 16:49:12 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7E1C0613D2
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Oct 2020 13:49:11 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id z33so2444820qth.8
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Oct 2020 13:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qw2hbRdXo/2OvsCJ5TNWt3ZvM3FC6SJw1vzpAUuKLgg=;
        b=nG0c6Z5QD2ka7I/BZL4qR4jXkvAnYR/mtN9DiViE4m8MZUAhdLWfR8wNJr9GxMN4O9
         ipdmW2PiLJQ9L+JyfALashxKhuKWTtammBmXvOU8EEX40Jh9bxk27Fj37yjd0m3t0jE3
         rcQM2CD12tg7h29pa/OB4fwKzSNd7KkYF3goWp4M7Rg2g1vVNWFBCgCtflu/XMgfcCXp
         Xifwl+o1Coj79L/IzfH40USoJ/F6clHMDiQvGlZrhNUrTMvLjX7agBpaDVdWKVNuQpSO
         L5U8XxTzWAFU+UiuXwIWkkn73tj5EyeASURsAGx3LwBIc4nkeyXkAUDqH9E+dMKrEipJ
         Fa5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qw2hbRdXo/2OvsCJ5TNWt3ZvM3FC6SJw1vzpAUuKLgg=;
        b=ondyYkCpRlsxZ/mfVfs1DwlHwFsGedZoK9shWC0mQ/V9p/GyS1ytvXNclySScvwr1q
         FPNVBb7xjfxRPPMFnrDSzcgJvmyoZCBiVdozF6bxBk35iHbaCpEtWn45IlvW23u5Iaci
         SrH+4mvMic1qJlf+YcarQBUGE/JI2EDbSHlfKW5uXlhKZmxtdboRzyOLF6Yhzih96T2X
         raL+ZgdgmiEY9N+3AclSpXfpUf6BdS9a4sQ9XEzLvmwmek5sXaUtkEFCl1l7ZR/qIEzr
         JzLrFFmGGiQD7wdTTq+QlwTSPzGwq0yHy/lLvPG3MAuiJy3uBt16MH5cwwYnU0otu4a9
         SOJg==
X-Gm-Message-State: AOAM532zUxugTB7jUuykovESfBTHk+M/I5QcS0rO/qg8AyrwSlRz793S
        QZWpnrLqRBedEpKPmolBGsmkjabgJyDYdmBH
X-Google-Smtp-Source: ABdhPJzTBI1kQOZneBFhr/C+3uQMPz5g87a0RHHCWAUQ4pzfCJgJCZ4DfCxkK5+DtbEKkqtlpGO3FA==
X-Received: by 2002:ac8:7b3d:: with SMTP id l29mr10844924qtu.366.1602190150231;
        Thu, 08 Oct 2020 13:49:10 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t3sm4737097qtq.24.2020.10.08.13.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 13:49:09 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 07/11] btrfs: rework btrfs_calc_reclaim_metadata_size
Date:   Thu,  8 Oct 2020 16:48:51 -0400
Message-Id: <2017283776449f9c59db05f301e7929e0a8db0bf.1602189832.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602189832.git.josef@toxicpanda.com>
References: <cover.1602189832.git.josef@toxicpanda.com>
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

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 44 ++++++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 7770372a892b..82cc3985a4b6 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -761,7 +761,6 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
 {
 	u64 used;
 	u64 avail;
-	u64 expected;
 	u64 to_reclaim = space_info->reclaim_size;
 
 	lockdep_assert_held(&space_info->lock);
@@ -779,28 +778,6 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
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
 
@@ -809,6 +786,7 @@ static inline bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
 					   u64 used)
 {
 	u64 thresh = div_factor_fine(space_info->total_bytes, 98);
+	u64 to_reclaim, expected;
 
 	/* If we're just plain full then async reclaim just slows us down. */
 	if ((space_info->bytes_used + space_info->bytes_reserved) >= thresh)
@@ -821,7 +799,25 @@ static inline bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
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

