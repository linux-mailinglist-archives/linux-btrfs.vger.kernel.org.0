Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBF1397AF1
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jun 2021 22:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbhFAUEo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Jun 2021 16:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbhFAUEn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Jun 2021 16:04:43 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE341C061574
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Jun 2021 13:03:00 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id k2so99215qvc.5
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Jun 2021 13:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4qmtazbkym22eb7blFO7YLzYXjfkMWpZKdK9G0QTHso=;
        b=y9ToYR82Rsrt/pDH4Bd6nW+V7pSsoVrta4/ALYu5Q7CaPh3l4Lo0znFkKVOK29xujc
         D5iWdy8EE7fIUXNrvjX3wsL9THQlqqphBxil/r076u4iwO+wyfEs9XSpMj6rCjCVZKca
         AAoqQPY4QF93By2uAImqd0PJdLa8E5TbVnaJDR5PBOrsbbF/Tscaq9HJb1VgxO5e5NMt
         02EgN0gt0Ta0SbCngudOcDi4s0sxOrV70ALu1MHCBPfS2glgr9piUakxSf9Y9068FMvi
         Kvh2wvDx/OMGu/Q2TXaRCTSdA2UiG4cCwXQ2+VgP7kRViO8TkNMKxr2jr0p9K0s7OItE
         XWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4qmtazbkym22eb7blFO7YLzYXjfkMWpZKdK9G0QTHso=;
        b=Er8qb2RLR/Y622nyd02jbofhIAuknO3EQAwCJFOJEe3XFR7dC3JYOWYCFtvcrnAAB1
         zpgXyOu8o6YyfDn+Ko9LVUXuNskABhMNaHfG0BL4FW+n5jeBC6/Huktjs5zJmikiF1x/
         S2+X3KRVJVNJgIKr4Gk9hcGxdjxQSxp3yddQXGtsatEjUSoeIfW7qXvLnjPj8O/zdZiV
         hSdaP92it1E24PdHIjQ5oMPMd1bbl1cafrnb+te5zOcvyctTzTync9+diTbnkbjQbhal
         SZ0l5QyEXDqB8xyZGChOmnHhDepzgE3CF0FCbNFtzGfwj0XDyXHVMhlL7Y79MELTWczO
         O/IA==
X-Gm-Message-State: AOAM532NhxyfXLmjiskBM8V5wDlVvowVwz4NFRvgHzLdxe5CkmTntfeR
        +/mfllhmTMgXclObSdWCtcUv/7AcRkbwoA==
X-Google-Smtp-Source: ABdhPJxehGeH3xXEwZ+hfkdbDO1d2/q43IPTTcTolLZuuZLQgKB+KeKD1+LpBgES6tgMXVTWkThBig==
X-Received: by 2002:a0c:8e4c:: with SMTP id w12mr24443458qvb.3.1622577779522;
        Tue, 01 Jun 2021 13:02:59 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x5sm7686885qkj.46.2021.06.01.13.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 13:02:59 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: add a way to monitor for ENOSPC events on a file system
Date:   Tue,  1 Jun 2021 16:02:58 -0400
Message-Id: <095765eb9c19463b7b0a490a9168326f2d314e68.1622577768.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

At Facebook's scale of btrfs deployment it's difficult to determine if
there's a systemic problem in our ENOSPC handling, or if it's simply
misbehaving tasks.  Part of monitoring btrfs at any scale is having data
about what is happening on a file system.  To that end, export the
number of ENOSPC events we've had per space_info via sysfs.  This
provides production users of btrfs to better monitor if they're having
problems, as sometimes userspace fails in different and interesting ways
that may be difficult to tie back to an errant (or even legitimate)
ENOSPC.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c |  8 ++++++++
 fs/btrfs/space-info.h |  6 ++++++
 fs/btrfs/sysfs.c      | 12 ++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index fc329aff478f..af467e888545 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -213,6 +213,7 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 	INIT_LIST_HEAD(&space_info->ro_bgs);
 	INIT_LIST_HEAD(&space_info->tickets);
 	INIT_LIST_HEAD(&space_info->priority_tickets);
+	atomic_set(&space_info->enospc_events, 0);
 	space_info->clamp = 1;
 
 	ret = btrfs_sysfs_add_space_info_type(info, space_info);
@@ -1674,6 +1675,11 @@ int btrfs_reserve_metadata_bytes(struct btrfs_root *root,
 			ret = 0;
 	}
 	if (ret == -ENOSPC) {
+		if (flush == BTRFS_RESERVE_FLUSH_ALL ||
+		    flush == BTRFS_RESERVE_FLUSH_ALL_STEAL ||
+		    flush == BTRFS_RESERVE_FLUSH_EVICT)
+			atomic_inc(&block_rsv->space_info->enospc_events);
+
 		trace_btrfs_space_reservation(fs_info, "space_info:enospc",
 					      block_rsv->space_info->flags,
 					      orig_bytes, 1);
@@ -1707,6 +1713,8 @@ int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
 
 	ret = __reserve_bytes(fs_info, data_sinfo, bytes, flush);
 	if (ret == -ENOSPC) {
+		if (flush == BTRFS_RESERVE_FLUSH_DATA)
+			atomic_inc(&data_sinfo->enospc_events);
 		trace_btrfs_space_reservation(fs_info, "space_info:enospc",
 					      data_sinfo->flags, bytes, 1);
 		if (btrfs_test_opt(fs_info, ENOSPC_DEBUG))
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index b1a8ffb03b3e..11eff2139aae 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -73,6 +73,12 @@ struct btrfs_space_info {
 	 */
 	u64 tickets_id;
 
+	/*
+	 * Counter for the number of times user facing flush actions have
+	 * failed.
+	 */
+	atomic_t enospc_events;
+
 	struct rw_semaphore groups_sem;
 	/* for block groups in our same type */
 	struct list_head block_groups[BTRFS_NR_RAID_TYPES];
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 4b508938e728..52c5311873d3 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -674,6 +674,15 @@ static ssize_t btrfs_space_info_show_total_bytes_pinned(struct kobject *kobj,
 	return scnprintf(buf, PAGE_SIZE, "%lld\n", val);
 }
 
+static ssize_t btrfs_space_info_show_enospc_events(struct kobject *kobj,
+						   struct kobj_attribute *a,
+						   char *buf)
+{
+	struct btrfs_space_info *sinfo = to_space_info(kobj);
+	int events = atomic_read(&sinfo->enospc_events);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", events);
+}
+
 SPACE_INFO_ATTR(flags);
 SPACE_INFO_ATTR(total_bytes);
 SPACE_INFO_ATTR(bytes_used);
@@ -686,6 +695,8 @@ SPACE_INFO_ATTR(disk_used);
 SPACE_INFO_ATTR(disk_total);
 BTRFS_ATTR(space_info, total_bytes_pinned,
 	   btrfs_space_info_show_total_bytes_pinned);
+BTRFS_ATTR(space_info, enospc_events,
+	   btrfs_space_info_show_enospc_events);
 
 static struct attribute *space_info_attrs[] = {
 	BTRFS_ATTR_PTR(space_info, flags),
@@ -699,6 +710,7 @@ static struct attribute *space_info_attrs[] = {
 	BTRFS_ATTR_PTR(space_info, disk_used),
 	BTRFS_ATTR_PTR(space_info, disk_total),
 	BTRFS_ATTR_PTR(space_info, total_bytes_pinned),
+	BTRFS_ATTR_PTR(space_info, enospc_events),
 	NULL,
 };
 ATTRIBUTE_GROUPS(space_info);
-- 
2.26.3

