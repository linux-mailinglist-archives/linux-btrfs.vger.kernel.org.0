Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78EC7AC6BC
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Sep 2023 08:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjIXGOp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Sep 2023 02:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjIXGOo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Sep 2023 02:14:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14D4107
        for <linux-btrfs@vger.kernel.org>; Sat, 23 Sep 2023 23:14:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A0C1A1F460
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Sep 2023 06:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695536075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VusPkr1JMDUAE/itWlwjBU8XrQVnp3B7voq51eliLCw=;
        b=P92lIQ9YWuvHLtdQcjYncKzIR96dg+TDZ//v9vrkx0ARpuOY9EOa/4qbFuinHsltE9PlQf
        ++iIE6DpNf+K7x6BwYnh7AWmyD7iKID1p4cas0HNuc53uVNsjcpv6FWXpNxsGSt/zevDGy
        DyKKER8OInaEso8+2KSveKlwqKabTe4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D14E1138FE
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Sep 2023 06:14:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2PWLI8rTD2X+CgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Sep 2023 06:14:34 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs: introduce super_failure_tolerance sysfs interface
Date:   Sun, 24 Sep 2023 15:44:13 +0930
Message-ID: <9cc262a52ddb23a7948c8338b660449ec8598914.1695535440.git.wqu@suse.com>
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

Currently btrfs has a questionable tolerance on how many devices can
fail their super blocks writeback, it allows "num_devices - 1" to
fail.

This can already be problematic for multi-device btrfses, but
unfortunately I don't have anything better for now.

Instead this patch would allow debug builds to configure the tolerance
by the new sysfs interface:

  /sys/fs/btrfs/<uuid>/debug/super_failure_tolerance

This value is s8, for values >= 0 it's the tolerance number directly.
E.g. if the value is 0, we do not allow any device to fail its super
block writeback.
If the value is 2, and the fs only have 2 devices, it means we allow all
devices to fail their super block writeback (aka, very dangerous).

If the value is minus, then the tolerance is num_devices plus this
value.
E.g. if the value is -1 (default), and we have 2 devices, it means the
tolerance is 1 (at most one device can fail).
If the value is -2, and we have 1 devices, this means we allow all
devices to fail (again, very dangerous).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 27 ++++++++++++++++++++++++---
 fs/btrfs/fs.h      | 18 ++++++++++++++++++
 fs/btrfs/sysfs.c   | 30 ++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d8eb968e9e5e..062e28ac94b1 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2723,6 +2723,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	INIT_LIST_HEAD(&fs_info->allocated_ebs);
 	spin_lock_init(&fs_info->eb_leak_lock);
 	fs_info->allow_backup_super_failure = true;
+	fs_info->super_failure_tolerance = -1;
 #endif
 	extent_map_tree_init(&fs_info->mapping_tree);
 	btrfs_init_block_rsv(&fs_info->global_block_rsv,
@@ -4033,6 +4034,26 @@ int btrfs_get_num_tolerated_disk_barrier_failures(u64 flags)
 	return min_tolerated;
 }
 
+static int calculate_max_super_errors(struct btrfs_fs_info *fs_info)
+{
+	int num_devs = btrfs_super_num_devices(fs_info->super_copy);
+	int tolerance_value = READ_ONCE(fs_info->super_failure_tolerance);
+
+	if (tolerance_value >= 0)
+		return tolerance_value;
+
+	ASSERT(num_devs >= 0);
+
+	/*
+	 * Now tolerance_value is minus, check if
+	 * abs(@tolerance_value) is > @num_devices. If so we allow all devices
+	 * to fail.
+	 */
+	if (-tolerance_value >= num_devs)
+		return INT_MAX;
+	return num_devs + tolerance_value;
+}
+
 int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors)
 {
 	struct list_head *head;
@@ -4060,7 +4081,7 @@ int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors)
 
 	mutex_lock(&fs_info->fs_devices->device_list_mutex);
 	head = &fs_info->fs_devices->devices;
-	max_errors = btrfs_super_num_devices(fs_info->super_copy) - 1;
+	max_errors = calculate_max_super_errors(fs_info);
 
 	if (do_barriers) {
 		ret = barrier_all_devices(fs_info);
@@ -4138,8 +4159,8 @@ int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors)
 	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
 	if (total_errors > max_errors) {
 		btrfs_handle_fs_error(fs_info, -EIO,
-				      "%d errors while writing supers",
-				      total_errors);
+			"failed to write supers: errors %d tolerance %d",
+				      total_errors, max_errors);
 		return -EIO;
 	}
 	return 0;
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 2dff41cb463d..7608a1cf612f 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -688,6 +688,24 @@ struct btrfs_fs_info {
 
 	/* If we allow backup superblocks writeback to fail. */
 	bool allow_backup_super_failure;
+
+	/*
+	 * Tolerance on how many devices can fail their superblock writeback.
+	 *
+	 * If the value >= 0, then the value itself is the tolerance.
+	 * If the value < 0, then it would be (rw_devices - value) as the tolerance.
+	 *
+	 * Default value is -1.
+	 *
+	 * E.g. 0 means we do not accept any device to fail its super blocks writeback.
+	 *
+	 * If there are 3 devices and the value is -1, then it means we allow up to 2
+	 * devices to fail its super blocks writeback.
+	 *
+	 * If there are 3 devices and the value is -3 or -4, we would allow all devices
+	 * to fail their super blocks writeback, which can be very DANGEROUS!
+	 */
+	s8 super_failure_tolerance;
 	u8 qgroup_drop_subtree_thres;
 
 	/*
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 852090622a76..bd9f574c2471 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -644,6 +644,35 @@ static ssize_t allow_backup_super_failure_store(struct kobject *debug_kobj,
 BTRFS_ATTR_RW(debug, allow_backup_super_failure, allow_backup_super_failure_show,
 	      allow_backup_super_failure_store);
 
+static ssize_t super_failure_tolerance_show(struct kobject *debug_kobj,
+					    struct kobj_attribute *a,
+					    char *buf)
+{
+	struct btrfs_fs_info *fs_info = to_fs_info(debug_kobj->parent);
+
+	ASSERT(fs_info);
+	return sysfs_emit(buf, "%d\n",
+			  READ_ONCE(fs_info->super_failure_tolerance));
+}
+
+static ssize_t super_failure_tolerance_store(struct kobject *debug_kobj,
+					     struct kobj_attribute *a,
+					     const char *buf, size_t len)
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
+	WRITE_ONCE(fs_info->super_failure_tolerance, new_number);
+	return len;
+}
+BTRFS_ATTR_RW(debug, super_failure_tolerance, super_failure_tolerance_show,
+	      super_failure_tolerance_store);
 /*
  * Per-filesystem runtime debugging exported via sysfs.
  *
@@ -657,6 +686,7 @@ BTRFS_ATTR_RW(debug, allow_backup_super_failure, allow_backup_super_failure_show
  */
 static const struct attribute *btrfs_debug_mount_attrs[] = {
 	BTRFS_ATTR_PTR(debug, allow_backup_super_failure),
+	BTRFS_ATTR_PTR(debug, super_failure_tolerance),
 	NULL,
 };
 
-- 
2.42.0

