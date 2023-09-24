Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537FE7AC6BB
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Sep 2023 08:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjIXGOm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Sep 2023 02:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXGOm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Sep 2023 02:14:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A73106
        for <linux-btrfs@vger.kernel.org>; Sat, 23 Sep 2023 23:14:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5827A1F45F
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Sep 2023 06:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695536074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mD6MJ9iLgAZP8XODmQXxYo795hI8vlMbjwjQKyRVQdA=;
        b=t+Z9i5f8Pj4gpk0zwxDAi5NsrwciPD9dMLUULZCm2dkXtfNVRBH3Mtz5QcNH4DRxhxPfOF
        9Un8Pd1EaFqdUWy2IFtv47YSMJhFnf+dx4ykU9/6CU2uB6n9jcKIexxrv8CV4lxXWh5Lht
        Xcdpffv42pjUaaWNth5iE1DZFw2E1/U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8AA64138FE
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Sep 2023 06:14:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CFy2EsnTD2X+CgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Sep 2023 06:14:33 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: introduce allow_backup_super_failure sysfs interface
Date:   Sun, 24 Sep 2023 15:44:12 +0930
Message-ID: <d3141862047ff54818407044d26e1aac93c97ed7.1695535440.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695535440.git.wqu@suse.com>
References: <cover.1695535440.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently btrfs allows the backup super block to fail its writeback, as
long as the primary one is still fine.

This tolerance may be a little too loose for some debug purposes, thus
this patch would introduce the following sysfs interface:

  /sys/fs/btrfs/<uuid>/debug/allow_backup_super_failure

Which is a read-write entry, its content is 0/1, indicating if we allow
backup super blocks to fail its writeback.
The default value is 1, meaning we allow backup super blocks to fail its
writeback.

Writing anything but 0 would set the value to 1.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c |  7 +++++--
 fs/btrfs/fs.h      |  3 +++
 fs/btrfs/sysfs.c   | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index dc577b3c53f6..d8eb968e9e5e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2722,6 +2722,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	INIT_LIST_HEAD(&fs_info->allocated_roots);
 	INIT_LIST_HEAD(&fs_info->allocated_ebs);
 	spin_lock_init(&fs_info->eb_leak_lock);
+	fs_info->allow_backup_super_failure = true;
 #endif
 	extent_map_tree_init(&fs_info->mapping_tree);
 	btrfs_init_block_rsv(&fs_info->global_block_rsv,
@@ -3841,8 +3842,10 @@ static int write_dev_supers(struct btrfs_device *device,
  */
 static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 {
+	struct btrfs_fs_info *fs_info = device->fs_info;
 	int i;
 	int errors = 0;
+	bool allow_super_failure = READ_ONCE(fs_info->allow_backup_super_failure);
 	bool primary_failed = false;
 	int ret;
 	u64 bytenr;
@@ -3890,8 +3893,8 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 	}
 
 	/* log error, force error return */
-	if (primary_failed) {
-		btrfs_err(device->fs_info, "error writing primary super block to device %llu",
+	if (primary_failed || (!allow_super_failure && errors)) {
+		btrfs_err(device->fs_info, "error writing super block to device %llu",
 			  device->devid);
 		return -1;
 	}
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 19f9a444bcd8..2dff41cb463d 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -685,6 +685,9 @@ struct btrfs_fs_info {
 	struct btrfs_work qgroup_rescan_work;
 	/* Protected by qgroup_rescan_lock */
 	bool qgroup_rescan_running;
+
+	/* If we allow backup superblocks writeback to fail. */
+	bool allow_backup_super_failure;
 	u8 qgroup_drop_subtree_thres;
 
 	/*
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 8b75e974f30b..852090622a76 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -614,12 +614,49 @@ static const struct attribute *discard_attrs[] = {
 
 #ifdef CONFIG_BTRFS_DEBUG
 
+static ssize_t allow_backup_super_failure_show(struct kobject *debug_kobj,
+					       struct kobj_attribute *a,
+					       char *buf)
+{
+	struct btrfs_fs_info *fs_info = to_fs_info(debug_kobj->parent);
+
+	ASSERT(fs_info);
+	return sysfs_emit(buf, "%d\n",
+			  READ_ONCE(fs_info->allow_backup_super_failure));
+}
+
+static ssize_t allow_backup_super_failure_store(struct kobject *debug_kobj,
+						struct kobj_attribute *a,
+						const char *buf, size_t len)
+{
+	struct btrfs_fs_info *fs_info = to_fs_info(debug_kobj->parent);
+	u8 new_number;
+	int ret;
+
+	ASSERT(fs_info);
+
+	ret = kstrtos8(buf, 10, &new_number);
+	if (ret)
+		return -EINVAL;
+	WRITE_ONCE(fs_info->allow_backup_super_failure, !!new_number);
+	return len;
+}
+BTRFS_ATTR_RW(debug, allow_backup_super_failure, allow_backup_super_failure_show,
+	      allow_backup_super_failure_store);
+
 /*
  * Per-filesystem runtime debugging exported via sysfs.
  *
  * Path: /sys/fs/btrfs/UUID/debug/
+ *
+ * - allow_backup_super_failure
+ *   RW, binary (0/1), determins if we allow backup superblock writeback to fail.
+ *
+ *   NOTE: Even with this set to 1, btrfs may still allow some errors to
+ *	   happen as btrfs can tolerate up to "rw_devs - 1" failures.
  */
 static const struct attribute *btrfs_debug_mount_attrs[] = {
+	BTRFS_ATTR_PTR(debug, allow_backup_super_failure),
 	NULL,
 };
 
-- 
2.42.0

