Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58EEF3FC51C
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 11:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbhHaJuK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 05:50:10 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52142 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240598AbhHaJuJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 05:50:09 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C3CA3221C7
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Aug 2021 09:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630403353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rYmxGqD04xgK541Hgb3/mLSRaahqFvFjT4reQEqnOKk=;
        b=uuW6M5kMc0Sw9bowNyzUAyHdTTON1rMOFwagLu2P2+44n7c3PWVD53891qg4eXcyRZIrqN
        vL3e/XVE7xscPzCWByEoqQpfZFXb7+akgb+T/OppxaTRNJDh1Giddnsnv+WQPetiDDckgu
        7C2uhByHjciBP3WbVqROjjA0FSl37SY=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id EC2FF136DF
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Aug 2021 09:49:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id oGtIKRj7LWGMcgAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Aug 2021 09:49:12 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/5] btrfs: skip subtree scan if it's too high to avoid low stall in btrfs_commit_transaction()
Date:   Tue, 31 Aug 2021 17:49:03 +0800
Message-Id: <20210831094903.111432-6-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210831094903.111432-1-wqu@suse.com>
References: <20210831094903.111432-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs qgroup has a long history of bringing performance penalty in
btrfs_commit_transaction().

Although we tried our best to migrate such impact, there is still an
unsolved call site, btrfs_drop_snapshot().

This function will find the highest shared tree block and modify its
extent ownership to do a subvolume/snapshot dropping.

Such change will affect the whole subtree, and cause tons of qgroup
dirty extents and stall btrfs_commit_transaction().

To avoid such problem, here we introduce a new sysfs interface,
/sys/fs/btrfs/<uuid>/qgroups/drop_subptree_threshold, to determine at
whether and at which level we should skip qgroup accounting for subtree
dropping.

The default value is BTRFS_MAX_LEVEL, thus every subtree drop will go
through qgroup accounting, to ensure qgroup numbers are kept as
consistent as possible.

While for performance sensitive users, they can change the values to
more reasonable values like 3, to make any subtree, which is at or higher
than level 3, to mark qgroup inconsistent and skip the accounting.

The cost is obvious, the qgroup number is no longer consistent, but at
least performance is more reasonable, and users have the control.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h   |  1 +
 fs/btrfs/disk-io.c |  1 +
 fs/btrfs/qgroup.c  | 18 ++++++++++++++++++
 fs/btrfs/sysfs.c   | 39 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 59 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 38870ae46cbb..158291993a97 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -938,6 +938,7 @@ struct btrfs_fs_info {
 	struct completion qgroup_rescan_completion;
 	struct btrfs_work qgroup_rescan_work;
 	bool qgroup_rescan_running;	/* protected by qgroup_rescan_lock */
+	u8 qgroup_drop_subtree_thres;
 
 	/* filesystem state */
 	unsigned long fs_state;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 41ea50f48cfe..0f2861e7b696 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2281,6 +2281,7 @@ static void btrfs_init_qgroup(struct btrfs_fs_info *fs_info)
 	fs_info->qgroup_seq = 1;
 	fs_info->qgroup_ulist = NULL;
 	fs_info->qgroup_rescan_running = false;
+	fs_info->qgroup_drop_subtree_thres = BTRFS_MAX_LEVEL;
 	mutex_init(&fs_info->qgroup_rescan_lock);
 }
 
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 291c404e8718..8dd29db48f75 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -1211,6 +1211,7 @@ int btrfs_quota_disable(struct btrfs_fs_info *fs_info)
 	quota_root = fs_info->quota_root;
 	fs_info->quota_root = NULL;
 	fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_ON;
+	fs_info->qgroup_drop_subtree_thres = BTRFS_MAX_LEVEL;
 	spin_unlock(&fs_info->qgroup_lock);
 
 	btrfs_free_qgroup_config(fs_info);
@@ -2239,6 +2240,7 @@ int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	int ret = 0;
 	int level;
+	u8 drop_subptree_thres;
 	struct extent_buffer *eb = root_eb;
 	struct btrfs_path *path = NULL;
 
@@ -2248,6 +2250,22 @@ int btrfs_qgroup_trace_subtree(struct btrfs_trans_handle *trans,
 	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &fs_info->flags))
 		return 0;
 
+	spin_lock(&fs_info->qgroup_lock);
+	drop_subptree_thres = fs_info->qgroup_drop_subtree_thres;
+	spin_unlock(&fs_info->qgroup_lock);
+	/*
+	 * This function only get called for snapshot drop, if we hit a high
+	 * node here, it means we are going to change ownership for quite a lot
+	 * of extents, which will greatly slow down btrfs_commit_transaction().
+	 *
+	 * So here if we find a high tree here, we just skip the accounting and
+	 * mark qgroup inconsistent.
+	 */
+	if (root_level >= drop_subptree_thres) {
+		qgroup_mark_inconsistent(fs_info);
+		return 0;
+	}
+
 	if (!extent_buffer_uptodate(root_eb)) {
 		ret = btrfs_read_buffer(root_eb, root_gen, root_level, NULL);
 		if (ret)
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 72edc6011d01..9316e9411171 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1859,6 +1859,44 @@ static ssize_t qgroup_flags_show(struct kobject *qgroups_kobj,
 
 BTRFS_ATTR(qgroups, qgroup_flags, qgroup_flags_show);
 
+static ssize_t qgroup_drop_subtree_thres_show(struct kobject *qgroups_kobj,
+					      struct kobj_attribute *a,
+					      char *buf)
+{
+	struct btrfs_fs_info *fs_info = to_fs_info(qgroups_kobj->parent);
+	u8 result;
+
+	spin_lock(&fs_info->qgroup_lock);
+	result = fs_info->qgroup_drop_subtree_thres;
+	spin_unlock(&fs_info->qgroup_lock);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", result);
+}
+
+static ssize_t qgroup_drop_subtree_thres_store(struct kobject *qgroups_kobj,
+					       struct kobj_attribute *a,
+					       const char *buf, size_t len)
+{
+	struct btrfs_fs_info *fs_info = to_fs_info(qgroups_kobj->parent);
+	u8 new_thres;
+	int ret;
+
+	ret = kstrtou8(buf, 10, &new_thres);
+	if (ret)
+		return -EINVAL;
+
+	if (new_thres > BTRFS_MAX_LEVEL)
+		return -EINVAL;
+
+	spin_lock(&fs_info->qgroup_lock);
+	fs_info->qgroup_drop_subtree_thres = new_thres;
+	spin_unlock(&fs_info->qgroup_lock);
+	return len;
+}
+
+BTRFS_ATTR_RW(qgroups, drop_subtree_threshold, qgroup_drop_subtree_thres_show,
+	      qgroup_drop_subtree_thres_store);
+
 /*
  * Qgroups global info
  *
@@ -1866,6 +1904,7 @@ BTRFS_ATTR(qgroups, qgroup_flags, qgroup_flags_show);
  */
 static struct attribute *qgroups_attrs[] = {
 	BTRFS_ATTR_PTR(qgroups, qgroup_flags),
+	BTRFS_ATTR_PTR(qgroups, drop_subtree_threshold),
 	NULL
 };
 ATTRIBUTE_GROUPS(qgroups);
-- 
2.33.0

