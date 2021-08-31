Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB7C3FC516
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Aug 2021 11:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbhHaJuF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Aug 2021 05:50:05 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52130 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbhHaJuE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Aug 2021 05:50:04 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5B115221C9
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Aug 2021 09:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1630403348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QqgwYz/Qzw12vSTPCFO7SHwsXBtzcEyiYQ9Pwjej8yk=;
        b=KxkZGZmyNZlqv15qt5rn7EjoJZehXtYSYofPlHu7IP1ImV7Gy8EvDKCjhwai+D7MoTGcQL
        qlXLH5j09UJeUG83DnLbVPQTujoNYe5C0z1WquTmIzPnEP96RWF/GVuVQSiOaITHXpLgk8
        FeqloU2RFX3a200aPVj6MnTTtRv3Zg4=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 82668136DF
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Aug 2021 09:49:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id IFWKDxP7LWGMcgAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Aug 2021 09:49:07 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/5] btrfs: sysfs: introduce qgroup global attribute groups
Date:   Tue, 31 Aug 2021 17:48:59 +0800
Message-Id: <20210831094903.111432-2-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210831094903.111432-1-wqu@suse.com>
References: <20210831094903.111432-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Although we already have info kobject for each qgroup, we don't have
global qgroup info attributes to show things like qgroup flags.

Add this qgroups attribute groups, and the first member is qgroup_flags,
which is a read-only attribute to show human readable qgroup flags.

The path is:
 /sys/fs/btrfs/<uuid>/qgroups/qgroup_flags

The output would look like:
 ON | INCONSISTENT

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/sysfs.c | 67 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 63 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 25a6f587852b..72edc6011d01 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1825,6 +1825,62 @@ int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)
 	return error;
 }
 
+static ssize_t qgroup_flags_show(struct kobject *qgroups_kobj,
+				 struct kobj_attribute *a,
+				 char *buf)
+{
+	struct btrfs_fs_info *fs_info = to_fs_info(qgroups_kobj->parent);
+	u64 qgroup_flags;
+	bool first = true;
+	int ret = 0;
+
+	spin_lock(&fs_info->qgroup_lock);
+	qgroup_flags = fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAGS_MASK;
+	spin_unlock(&fs_info->qgroup_lock);
+
+	if (qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_ON) {
+		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
+				(first ? "" : " | "), "ON");
+		first = false;
+	}
+	if (qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN) {
+		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
+				(first ? "" : " | "), "RESCAN");
+		first = false;
+	}
+	if (qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT) {
+		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
+				(first ? "" : " | "), "INCONSISTENT");
+		first = false;
+	}
+	ret += scnprintf(buf + ret, PAGE_SIZE - ret, "\n");
+	return ret;
+}
+
+BTRFS_ATTR(qgroups, qgroup_flags, qgroup_flags_show);
+
+/*
+ * Qgroups global info
+ *
+ * Path: /sys/fs/btrfs/<uuid>/qgroups/
+ */
+static struct attribute *qgroups_attrs[] = {
+	BTRFS_ATTR_PTR(qgroups, qgroup_flags),
+	NULL
+};
+ATTRIBUTE_GROUPS(qgroups);
+
+static void qgroups_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
+static struct kobj_type qgroups_ktype = {
+	.sysfs_ops = &kobj_sysfs_ops,
+	.default_groups = qgroups_groups,
+	.release = qgroups_release,
+};
+
 static inline struct btrfs_fs_info *qgroup_kobj_to_fs_info(struct kobject *kobj)
 {
 	return to_fs_info(kobj->parent->parent);
@@ -1950,11 +2006,14 @@ int btrfs_sysfs_add_qgroups(struct btrfs_fs_info *fs_info)
 	if (fs_info->qgroups_kobj)
 		return 0;
 
-	fs_info->qgroups_kobj = kobject_create_and_add("qgroups", fsid_kobj);
-	if (!fs_info->qgroups_kobj) {
-		ret = -ENOMEM;
+	fs_info->qgroups_kobj = kmalloc(sizeof(struct kobject), GFP_KERNEL);
+	if (!fs_info->qgroups_kobj)
+		return -ENOMEM;
+
+	ret = kobject_init_and_add(fs_info->qgroups_kobj, &qgroups_ktype,
+				   fsid_kobj, "qgroups");
+	if (ret < 0)
 		goto out;
-	}
 	rbtree_postorder_for_each_entry_safe(qgroup, next,
 					     &fs_info->qgroup_tree, node) {
 		ret = btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
-- 
2.33.0

