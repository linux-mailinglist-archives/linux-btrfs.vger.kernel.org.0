Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38482479465
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Dec 2021 19:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239838AbhLQSwb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Dec 2021 13:52:31 -0500
Received: from santino.mail.tiscali.it ([213.205.33.245]:53124 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240526AbhLQSw2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Dec 2021 13:52:28 -0500
Received: from venice.bhome ([78.12.25.242])
        by santino.mail.tiscali.it with 
        id XWnP2601f5DQHji01WnTsN; Fri, 17 Dec 2021 18:47:27 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: -100
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From:   Goffredo Baroncelli <kreijack@tiscali.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 6/6] btrfs: add allocation_hint option.
Date:   Fri, 17 Dec 2021 19:47:22 +0100
Message-Id: <3dddd204abe208d8744913c801f32138f4924f4f.1639766364.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1639766364.git.kreijack@inwind.it>
References: <cover.1639766364.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1639766847; bh=Ko04ipVyYH9AXE8DoqsF3+Af5SCYy88vvP2e/sp3RrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=pS0mW5+PMCS0/1mpO/WNgji/RUpsvvdDZnQwg/CLOrTHoEQvRcGxWJuxaRElzwf2S
         +HcgyQ9LDq5c5nhmuQbrG9ZWDKGlZ1CO2acJq+e56KM15OtATsd6JhXYWbR5meN87V
         ba1cuVEGj/bLRBZcwmI1ZcUWAkYbUNmnB9Qhzt10=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

Add allocation_hint mount option. This option accepts the following values:

- 0 (default):  the chunks allocator ignores the disk hints
- 1:            the chunks allocator considers the disk hints

Signed-off-by: Goffredo Baroncelli <kreijack@winwind.it>
---
 fs/btrfs/ctree.h   | 14 ++++++++++++++
 fs/btrfs/disk-io.c |  2 ++
 fs/btrfs/super.c   | 17 +++++++++++++++++
 fs/btrfs/volumes.c |  9 ++++++---
 4 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 778c7c807289..bb31cdcaf959 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -620,6 +620,15 @@ enum btrfs_exclusive_operation {
 	BTRFS_EXCLOP_SWAP_ACTIVATE,
 };
 
+/*
+ * allocation_hint mode
+ */
+
+enum btrfs_allocation_hint_modes {
+	BTRFS_ALLOCATION_HINT_DISABLED,
+	BTRFS_ALLOCATION_HINT_ENABLED
+};
+
 struct btrfs_fs_info {
 	u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
 	unsigned long flags;
@@ -1021,6 +1030,11 @@ struct btrfs_fs_info {
 		u64 zoned;
 	};
 
+	/* allocation_hint mode */
+	int allocation_hint_mode;
+
+	/* Max size to emit ZONE_APPEND write command */
+	u64 max_zone_append_size;
 	struct mutex zoned_meta_io_lock;
 	spinlock_t treelog_bg_lock;
 	u64 treelog_bg;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 02ffb8bc7d6b..09d365a689c9 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3160,6 +3160,8 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	spin_lock_init(&fs_info->swapfile_pins_lock);
 	fs_info->swapfile_pins = RB_ROOT;
 
+	fs_info->allocation_hint_mode = BTRFS_ALLOCATION_HINT_DISABLED;
+
 	fs_info->bg_reclaim_threshold = BTRFS_DEFAULT_RECLAIM_THRESH;
 	INIT_WORK(&fs_info->reclaim_bgs_work, btrfs_reclaim_bgs_work);
 }
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a1c54a2c787c..68911152420a 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -373,6 +373,7 @@ enum {
 	Opt_thread_pool,
 	Opt_treelog, Opt_notreelog,
 	Opt_user_subvol_rm_allowed,
+	Opt_allocation_hint,
 
 	/* Rescue options */
 	Opt_rescue,
@@ -446,6 +447,7 @@ static const match_table_t tokens = {
 	{Opt_treelog, "treelog"},
 	{Opt_notreelog, "notreelog"},
 	{Opt_user_subvol_rm_allowed, "user_subvol_rm_allowed"},
+	{Opt_allocation_hint, "allocation_hint=%d"},
 
 	/* Rescue options */
 	{Opt_rescue, "rescue=%s"},
@@ -903,6 +905,19 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 		case Opt_user_subvol_rm_allowed:
 			btrfs_set_opt(info->mount_opt, USER_SUBVOL_RM_ALLOWED);
 			break;
+		case Opt_allocation_hint:
+			ret = match_int(&args[0], &intarg);
+			if (ret || (intarg != 1 && intarg != 0)) {
+				btrfs_err(info, "invalid allocation_hint= parameter\n");
+				ret = -EINVAL;
+				goto out;
+			}
+			if (intarg)
+				btrfs_info(info, "allocation_hint enabled");
+			else
+				btrfs_info(info, "allocation_hint disabled");
+			info->allocation_hint_mode = intarg;
+			break;
 		case Opt_enospc_debug:
 			btrfs_set_opt(info->mount_opt, ENOSPC_DEBUG);
 			break;
@@ -1497,6 +1512,8 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 		seq_puts(seq, ",clear_cache");
 	if (btrfs_test_opt(info, USER_SUBVOL_RM_ALLOWED))
 		seq_puts(seq, ",user_subvol_rm_allowed");
+	if (info->allocation_hint_mode)
+		seq_puts(seq, ",allocation_hint=1");
 	if (btrfs_test_opt(info, ENOSPC_DEBUG))
 		seq_puts(seq, ",enospc_debug");
 	if (btrfs_test_opt(info, AUTO_DEFRAG))
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9184570c51b0..15302c068008 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5276,10 +5276,13 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
 		devices_info[ndevs].total_avail = total_avail;
 		devices_info[ndevs].dev = device;
 
-		if ((ctl->type & BTRFS_BLOCK_GROUP_DATA) &&
-		     (ctl->type & BTRFS_BLOCK_GROUP_METADATA)) {
+		if (((ctl->type & BTRFS_BLOCK_GROUP_DATA) &&
+		     (ctl->type & BTRFS_BLOCK_GROUP_METADATA)) ||
+		    info->allocation_hint_mode ==
+		     BTRFS_ALLOCATION_HINT_DISABLED) {
 			/*
-			 * if mixed bg set all the alloc_hint
+			 * if mixed bg or the allocator hint is
+			 * disabled, set all the alloc_hint
 			 * fields to the same value, so the sorting
 			 * is not affected
 			 */
-- 
2.34.1

