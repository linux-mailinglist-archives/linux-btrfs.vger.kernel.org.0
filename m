Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F9F20C635
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jun 2020 07:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgF1FHY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Jun 2020 01:07:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:50848 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbgF1FHY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Jun 2020 01:07:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 35811AD7B
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Jun 2020 05:07:23 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/2] btrfs: use __u16 for the return value of btrfs_qgroup_level()
Date:   Sun, 28 Jun 2020 13:07:14 +0800
Message-Id: <20200628050715.60961-2-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200628050715.60961-1-wqu@suse.com>
References: <20200628050715.60961-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs qgroup level is limited to u16, so no need to use u64 for it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c               | 2 +-
 include/uapi/linux/btrfs_tree.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 74eb98479109..014d32429165 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -538,7 +538,7 @@ bool btrfs_check_quota_leak(struct btrfs_fs_info *fs_info)
 			if (qgroup->rsv.values[i]) {
 				ret = true;
 				btrfs_warn(fs_info,
-		"qgroup %llu/%llu has unreleased space, type %d rsv %llu",
+		"qgroup %hu/%llu has unreleased space, type %d rsv %llu",
 				   btrfs_qgroup_level(qgroup->qgroupid),
 				   btrfs_qgroup_subvolid(qgroup->qgroupid),
 				   i, qgroup->rsv.values[i]);
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index a3f3975df0de..9ba64ca6b4ac 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -913,9 +913,9 @@ struct btrfs_free_space_info {
 #define BTRFS_FREE_SPACE_USING_BITMAPS (1ULL << 0)
 
 #define BTRFS_QGROUP_LEVEL_SHIFT		48
-static inline __u64 btrfs_qgroup_level(__u64 qgroupid)
+static inline __u16 btrfs_qgroup_level(__u64 qgroupid)
 {
-	return qgroupid >> BTRFS_QGROUP_LEVEL_SHIFT;
+	return (__u16)(qgroupid >> BTRFS_QGROUP_LEVEL_SHIFT);
 }
 
 /*
-- 
2.27.0

