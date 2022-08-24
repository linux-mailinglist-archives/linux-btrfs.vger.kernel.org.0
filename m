Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD4B59F0AE
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Aug 2022 03:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbiHXBOe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Aug 2022 21:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbiHXBOb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Aug 2022 21:14:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C610C7E819
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Aug 2022 18:14:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6DA6F1F8B2
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Aug 2022 01:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661303669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DSn7OW/vOdVaaT+V+10YdwQLfcrSgzdSUa18q7kMSA0=;
        b=h4737EiUaN4w+qtUdvDQEhRNSoMKzBKceYIqKC3rrrjMd0nSWHaWA9bZHYjig0LYyDs0Bc
        mOJKA/JcYsF+9qyin/vYT+qTZg3QZ1n42e+0td68pGsHBR3TdFI5YSSprPOJFXzWOL+Vbg
        epN6fkqY5fC1b/rK4kFl+xiNvESPpTo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B2E4913A89
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Aug 2022 01:14:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +JvLHXR7BWNnWAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Aug 2022 01:14:28 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 1/5] btrfs: sysfs: introduce qgroup global attribute groups
Date:   Wed, 24 Aug 2022 09:14:05 +0800
Message-Id: <89ed239c3cef1d1f2f89fb7b40bd2a7a4634de61.1661302005.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1661302005.git.wqu@suse.com>
References: <cover.1661302005.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 84a992681801..6dc06300b666 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -2019,11 +2019,72 @@ int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)
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
@@ -2144,11 +2205,15 @@ int btrfs_sysfs_add_qgroups(struct btrfs_fs_info *fs_info)
 	if (fs_info->qgroups_kobj)
 		return 0;
 
-	fs_info->qgroups_kobj = kobject_create_and_add("qgroups", fsid_kobj);
-	if (!fs_info->qgroups_kobj) {
-		ret = -ENOMEM;
+	fs_info->qgroups_kobj = kzalloc(sizeof(struct kobject), GFP_KERNEL);
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
2.37.2

