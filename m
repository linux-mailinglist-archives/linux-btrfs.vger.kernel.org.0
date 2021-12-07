Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1406846AF99
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 02:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344427AbhLGBUs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Dec 2021 20:20:48 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:60564 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245641AbhLGBUp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Dec 2021 20:20:45 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 14C5A1FD5C
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Dec 2021 01:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638839835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/qtHxiehl3XQB0SMBar6eacb+df5PbSJBbb55y7Jmjk=;
        b=u9RhfeO0f51F8Yh83zlydt78m/SNQZMfz/2g2KRsSb89v1ZIruowdvPWHvvu6E/HyXSI+M
        QdZt4LHOGvlGeYtGVQ8y4ZxE/Pl1xBkdgt1ZY8sqOBzHMChv57QvXCP6rObrhYxii08a8R
        hkeENXk9CfrEPtjd5Fqo6ZkTSOZpLWo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 59D7613A5C
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Dec 2021 01:17:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qMKlCBq2rmE8LQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Dec 2021 01:17:14 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/5] btrfs: sysfs: introduce qgroup global attribute groups
Date:   Tue,  7 Dec 2021 09:16:51 +0800
Message-Id: <20211207011655.21579-2-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211207011655.21579-1-wqu@suse.com>
References: <20211207011655.21579-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Although we already have info kobject for each qgroup, we don't have
global qgroup info attributes to show things like enabled or
inconsistent flags.

Add this qgroups attribute groups, and the first member is qgroup_flags,
which is a read-only attribute to show human readable qgroup flags.

The path is:
 /sys/fs/btrfs/<uuid>/qgroups/enabled
 /sys/fs/btrfs/<uuid>/qgroups/inconsistent

The output is pretty simple, just 1 or 0, with "\n".

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/sysfs.c | 73 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 69 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index f9eff3b0f77c..e48904666703 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1820,11 +1820,72 @@ int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)
 	return error;
 }
 
+static ssize_t qgroup_enabled_show(struct kobject *qgroups_kobj,
+				   struct kobj_attribute *a,
+				   char *buf)
+{
+	struct btrfs_fs_info *fs_info = to_fs_info(qgroups_kobj->parent);
+	bool enabled;
+	int ret = 0;
+
+	spin_lock(&fs_info->qgroup_lock);
+	enabled = fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_ON;
+	spin_unlock(&fs_info->qgroup_lock);
+
+	ret += scnprintf(buf, PAGE_SIZE, "%d\n", enabled);
+	return ret;
+}
+
+BTRFS_ATTR(qgroups, enabled, qgroup_enabled_show);
+
+static ssize_t qgroup_inconsistent_show(struct kobject *qgroups_kobj,
+					struct kobj_attribute *a,
+					char *buf)
+{
+	struct btrfs_fs_info *fs_info = to_fs_info(qgroups_kobj->parent);
+	bool inconsistent;
+	int ret = 0;
+
+	spin_lock(&fs_info->qgroup_lock);
+	inconsistent = fs_info->qgroup_flags &
+		       BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
+	spin_unlock(&fs_info->qgroup_lock);
+
+	ret += scnprintf(buf, PAGE_SIZE, "%d\n", inconsistent);
+	return ret;
+}
+
+BTRFS_ATTR(qgroups, inconsistent, qgroup_inconsistent_show);
+
+/*
+ * Qgroups global info
+ *
+ * Path: /sys/fs/btrfs/<uuid>/qgroups/
+ */
+static struct attribute *qgroups_attrs[] = {
+	BTRFS_ATTR_PTR(qgroups, enabled),
+	BTRFS_ATTR_PTR(qgroups, inconsistent),
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
 }
 
+
 #define QGROUP_ATTR(_member, _show_name)					\
 static ssize_t btrfs_qgroup_show_##_member(struct kobject *qgroup_kobj,		\
 					   struct kobj_attribute *a,		\
@@ -1945,11 +2006,15 @@ int btrfs_sysfs_add_qgroups(struct btrfs_fs_info *fs_info)
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
+
 	rbtree_postorder_for_each_entry_safe(qgroup, next,
 					     &fs_info->qgroup_tree, node) {
 		ret = btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
-- 
2.34.1

