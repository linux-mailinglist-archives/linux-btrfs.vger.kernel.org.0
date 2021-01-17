Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22E982F94BE
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Jan 2021 19:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbhAQSzY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Jan 2021 13:55:24 -0500
Received: from smtp-36.italiaonline.it ([213.209.10.36]:33045 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728676AbhAQSzV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Jan 2021 13:55:21 -0500
Received: from venice.bhome ([94.37.172.193])
        by smtp-36.iol.local with ESMTPA
        id 1DCAlJgx8i3tS1DCBlXz6E; Sun, 17 Jan 2021 19:54:39 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1610909679; bh=YdIwnvi/fIZaH2L+UmJGV+Ps2artHONICkzr2BmiFAs=;
        h=From;
        b=EgcPNzajMjIVw/8hcLtsDey3H3rhHOrXrlnZluPZaLOM7Gd9qStLPyVei19lVTO4N
         jcdHauFfaVKRDfVddzAdCt7lvii6l9xArxfCuAKFHS/BxmWCIL+Qjd29X0fvjuP4s7
         8NIozUd5pN1yzVjBSs+JTV2siZ4t3QtmAafvApsx00VYlgRTYKc7r5w1jRXvpYk5Y3
         /sT4Velfg414bTFYWRyoEcXmKJHY0t475aMI2/f1MFb70d1PYnL0E4nCiU8BbWXl4q
         mr9KXPTBRzq9pp/lb98dcCJhk0Ea5AmvJhRGQN6ClCDwcZE6ts5Oia77MAxnhCICc4
         i205nz4KwzIYw==
X-CNFS-Analysis: v=2.4 cv=FqfAQ0nq c=1 sm=1 tr=0 ts=600487ef cx=a_exe
 a=z1y4hvBwYU35dpVEhKc0WA==:117 a=z1y4hvBwYU35dpVEhKc0WA==:17
 a=gA3aMnFg010l5TYKVLEA:9
From:   Goffredo Baroncelli <kreijack@libero.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 4/5] btrfs: add preferred_metadata option.
Date:   Sun, 17 Jan 2021 19:54:34 +0100
Message-Id: <20210117185435.36263-5-kreijack@libero.it>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210117185435.36263-1-kreijack@libero.it>
References: <20210117185435.36263-1-kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfOxzuVv6vOXgl1ERwkvz25hNFma0tmqiJOJr+/xS5vrd73p/7znYVfwyKiU+45TTBalP2nklPUvb7qERVXTNoZ4RIFkXVsAxDraVVFsUIfmIsIg80kHv
 6Tw1FTjXmWsxRLfDRnBf4cE+ZtOcJHDL2c0AalQVZE6+UgoVlzcBSwcptHRso/uQOpIB/txy7VJ/YjBo7j5nlZZt19mBTR4O/zdc2GrvScFM+YEp9AohtyxV
 odulQW5GVb9RhdC1W6vzFXQ/rrYEO/lMKDzeg2Af7f0=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

Add preferred_metadata mount option. This option accept the following values:

- disabled (default):  the disk preferred metadata flag is ignored
- soft:		       the disk preferred metadata flag is a suggestion
                       on which disk the system may use
- metadata:	       the disk preferred metadata flag is a suggestion
                       on which disk the system use for metadata. It is a
		       mandatory requirement for data
- hard:                the disk preferred metadata flag is a mandatory
                       requirement for metadata and


Signed-off-by: Goffredo Baroncelli <kreijack@winwind.it>
---
 fs/btrfs/ctree.h   | 14 ++++++++++++++
 fs/btrfs/disk-io.c |  2 ++
 fs/btrfs/super.c   | 27 +++++++++++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 1d3c1e479f3d..af2e549ef1ab 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -570,6 +570,17 @@ enum btrfs_exclusive_operation {
 	BTRFS_EXCLOP_SWAP_ACTIVATE,
 };
 
+/*
+ * 'preferred_metadata' mode
+ */
+
+enum btrfs_preferred_metadata_mode {
+	BTRFS_PM_DISABLED,
+	BTRFS_PM_HARD,
+	BTRFS_PM_METADATA,
+	BTRFS_PM_SOFT
+};
+
 struct btrfs_fs_info {
 	u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
 	unsigned long flags;
@@ -961,6 +972,9 @@ struct btrfs_fs_info {
 		u64 zoned;
 	};
 
+	/* preferred_metadata mode */
+	int preferred_metadata_mode;
+
 	/* Max size to emit ZONE_APPEND write command */
 	u64 max_zone_append_size;
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 765deefda92b..c0d9e6572e63 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2794,6 +2794,8 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	fs_info->swapfile_pins = RB_ROOT;
 
 	fs_info->send_in_progress = 0;
+
+	fs_info->preferred_metadata_mode = BTRFS_PM_DISABLED;
 }
 
 static int init_mount_fs_info(struct btrfs_fs_info *fs_info, struct super_block *sb)
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 022f20810089..b7abc25c9637 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -359,6 +359,7 @@ enum {
 	Opt_thread_pool,
 	Opt_treelog, Opt_notreelog,
 	Opt_user_subvol_rm_allowed,
+	Opt_preferred_metadata,
 
 	/* Rescue options */
 	Opt_rescue,
@@ -432,6 +433,7 @@ static const match_table_t tokens = {
 	{Opt_treelog, "treelog"},
 	{Opt_notreelog, "notreelog"},
 	{Opt_user_subvol_rm_allowed, "user_subvol_rm_allowed"},
+	{Opt_preferred_metadata, "preferred_metadata=%s"},
 
 	/* Rescue options */
 	{Opt_rescue, "rescue=%s"},
@@ -889,6 +891,23 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 		case Opt_user_subvol_rm_allowed:
 			btrfs_set_opt(info->mount_opt, USER_SUBVOL_RM_ALLOWED);
 			break;
+		case Opt_preferred_metadata:
+			if (!strcmp(args[0].from, "hard")) {
+				info->preferred_metadata_mode = BTRFS_PM_HARD;
+			} else if (!strcmp(args[0].from, "metadata")) {
+				info->preferred_metadata_mode = BTRFS_PM_METADATA;
+			} else if (!strcmp(args[0].from, "soft")) {
+				info->preferred_metadata_mode = BTRFS_PM_SOFT;
+			} else if (!strcmp(args[0].from, "disabled")) {
+				info->preferred_metadata_mode = BTRFS_PM_DISABLED;
+			} else  {
+				btrfs_err(info,
+					"unknown option '%s' in preferred_metadata",
+					args[0].from);
+				ret = -EINVAL;
+				goto out;
+			}
+			break;
 		case Opt_enospc_debug:
 			btrfs_set_opt(info->mount_opt, ENOSPC_DEBUG);
 			break;
@@ -1495,6 +1514,14 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 		seq_puts(seq, ",clear_cache");
 	if (btrfs_test_opt(info, USER_SUBVOL_RM_ALLOWED))
 		seq_puts(seq, ",user_subvol_rm_allowed");
+	if (info->preferred_metadata_mode == BTRFS_PM_HARD)
+		seq_puts(seq, ",preferred_metadata=hard");
+	else if (info->preferred_metadata_mode == BTRFS_PM_METADATA)
+		seq_puts(seq, ",preferred_metadata=metadata");
+	else if (info->preferred_metadata_mode == BTRFS_PM_SOFT)
+		seq_puts(seq, ",preferred_metadata=soft");
+	else if (info->preferred_metadata_mode == BTRFS_PM_DISABLED)
+                seq_puts(seq, ",preferred_metadata=disabled");
 	if (btrfs_test_opt(info, ENOSPC_DEBUG))
 		seq_puts(seq, ",enospc_debug");
 	if (btrfs_test_opt(info, AUTO_DEFRAG))
-- 
2.30.0

