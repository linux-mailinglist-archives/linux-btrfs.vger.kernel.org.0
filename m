Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50E930B213
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Feb 2021 22:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbhBAV3K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Feb 2021 16:29:10 -0500
Received: from smtp-36.italiaonline.it ([213.209.10.36]:46918 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232322AbhBAV3G (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Feb 2021 16:29:06 -0500
Received: from venice.bhome ([84.220.24.72])
        by smtp-36.iol.local with ESMTPA
        id 6gkAlJHqMi3tS6gkClGsx4; Mon, 01 Feb 2021 22:28:24 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1612214904; bh=4pM90owA0lQuOq3sYarqIs3hyXtA+t9DmatR8v2mPtc=;
        h=From;
        b=JDTpQ2E9CupMknuntp1HbfBqbiRNRYYhwUxM5FizMzNE8IPz4zgIYtItD14ofzs1Q
         ACB9zaYRsPbLSyfBMskfU2r92n3J9/Y2gp6aQ5Sj4oexhbBI6umwYlvPWyc01VeL6R
         Fe4Pr6GSLj4+w4xgMfuej07a5fCYfB60T2t8VZCYsHL3eKlvq05uwkM/KO678ZuRC0
         IMGSwgivPqkKXqsSlZX3+bXaG5fBP70zsmD7XBxfQPZ/cwuEN01357hHcw9GuUKUbn
         Pb269yGdsuHP9++tEJLns0xRzXwA6x+SzCc9IsKUOIQ6sLMuL1bGG9ou/WmLia7Xjj
         Nns006e05y1lg==
X-CNFS-Analysis: v=2.4 cv=FqfAQ0nq c=1 sm=1 tr=0 ts=60187278 cx=a_exe
 a=tAq5w2qrEf5dL+VNPEPBHQ==:117 a=tAq5w2qrEf5dL+VNPEPBHQ==:17
 a=WOvS8Uw1l4o9L0ZJ_KUA:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 4/5] btrfs: add allocation_hint option.
Date:   Mon,  1 Feb 2021 22:28:19 +0100
Message-Id: <20210201212820.64381-5-kreijack@libero.it>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210201212820.64381-1-kreijack@libero.it>
References: <20210201212820.64381-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfD1wutszHKIlUZTwtbSYl9z/+e0rnW7j20qXXiecWT5AXhz1p+eoq7tfP/qkU18tBxI9hlc8b8fyHHAUb+UiBU9dxOKncAAE1Ax1BwTnR3D1zRLzikXh
 L+S6DNQY6KDcXRnYcJdQI2Bo7+IlDMykKZ6jEhGNNoB4oqwzsv+2kRnyr7C8B9E5yWP+X8UVILmdPSYpPNTAywRp04BU3U6AM2jF6VqBiFkf/cJZKfjVFhWW
 xPf6g9OdpZsmUnI/+mUGmXNUv30pNEKFUw1sSeRxD2gmi2RDNlpfYcVObDHregTq
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

Add allocation_hint mount option. This option accepts the following values:

- 0 (default):  the chunks allocator ignores the disk hints
- 1:            the chunks allocator considers the disk hints

Signed-off-by: Goffredo Baroncelli <kreijack@winwind.it>
---
 fs/btrfs/ctree.h   | 12 ++++++++++++
 fs/btrfs/disk-io.c |  2 ++
 fs/btrfs/super.c   | 17 +++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 1d3c1e479f3d..5cd6d658f157 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -570,6 +570,15 @@ enum btrfs_exclusive_operation {
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
@@ -961,6 +970,9 @@ struct btrfs_fs_info {
 		u64 zoned;
 	};
 
+	/* allocation_hint mode */
+	int allocation_hint_mode;
+
 	/* Max size to emit ZONE_APPEND write command */
 	u64 max_zone_append_size;
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 765deefda92b..1edd219c347c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2794,6 +2794,8 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	fs_info->swapfile_pins = RB_ROOT;
 
 	fs_info->send_in_progress = 0;
+
+	fs_info->allocation_hint_mode = BTRFS_ALLOCATION_HINT_DISABLED;
 }
 
 static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block *sb)
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 022f20810089..d0c69c950cd9 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -359,6 +359,7 @@ enum {
 	Opt_thread_pool,
 	Opt_treelog, Opt_notreelog,
 	Opt_user_subvol_rm_allowed,
+	Opt_allocation_hint,
 
 	/* Rescue options */
 	Opt_rescue,
@@ -432,6 +433,7 @@ static const match_table_t tokens = {
 	{Opt_treelog, "treelog"},
 	{Opt_notreelog, "notreelog"},
 	{Opt_user_subvol_rm_allowed, "user_subvol_rm_allowed"},
+	{Opt_allocation_hint, "allocation_hint=%d"},
 
 	/* Rescue options */
 	{Opt_rescue, "rescue=%s"},
@@ -889,6 +891,19 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
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
@@ -1495,6 +1510,8 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 		seq_puts(seq, ",clear_cache");
 	if (btrfs_test_opt(info, USER_SUBVOL_RM_ALLOWED))
 		seq_puts(seq, ",user_subvol_rm_allowed");
+	if (info->allocation_hint_mode)
+		seq_puts(seq, ",allocation_hint=1");
 	if (btrfs_test_opt(info, ENOSPC_DEBUG))
 		seq_puts(seq, ",enospc_debug");
 	if (btrfs_test_opt(info, AUTO_DEFRAG))
-- 
2.30.0

