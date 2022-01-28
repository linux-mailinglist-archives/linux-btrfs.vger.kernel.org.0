Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD2749F4FC
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 09:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347223AbiA1INV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 03:13:21 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:35354 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347219AbiA1INU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 03:13:20 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7CD962171F
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jan 2022 08:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643357599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qbHywrSkxCUJlkVYXfxPRcZj6wrMlFryOqmtlh2Qnug=;
        b=gFr/0TtLdSS0yY162xXXjo/snzFZjM7hcK/nO234mOLd+lrnPrG+zvYjbixH7EzLaVXZyj
        8ZbC/rkp/uCzECvBf2RgIg98qoyLlQYjYmHtVz21nfCEaesfCvAgMeB5Gi4FXuAcIj8MxA
        8ZI+smbAVV434zoIf7UWe4oJozipuCI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D325B139C4
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jan 2022 08:13:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CJdDJ56l82FjVQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jan 2022 08:13:18 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: defrag: introduce btrfs_defrag_ctrl structure for later usage
Date:   Fri, 28 Jan 2022 16:12:56 +0800
Message-Id: <d5da1d1dc6ebc1395621e4fd6391a73e55a7ac8c.1643357469.git.wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643357469.git.wqu@suse.com>
References: <cover.1643357469.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently btrfs_defrag_file() accepts not only
btrfs_ioctl_defrag_range_args but also other parameters like @newer_than
and @max_sectors_to_defrag for extra policies.

Those extra values are hidden from defrag ioctl and even caused bugs in
the past due to different behaviors based on those extra values.

Here we introduce a new structure, btrfs_defrag_ctrl, to include:

- all members in btrfs_ioctl_defrag_range_args

- @max_sectors_to_defrag and @newer_than

- Extra values which callers of btrfs_defrag_file() may care
  Like @sectors_defragged and @last_scanned.

With the new structure, also introduce a new helper,
btrfs_defrag_ioctl_args_to_ctrl() to:

- Do extra sanity check on @compress and @flags

- Do range alignment when possible

- Set the default value.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h | 19 +++++++++++++++++++
 fs/btrfs/ioctl.c | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b4a9b1c58d22..0a441bd703a0 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3267,6 +3267,25 @@ int btrfs_fileattr_set(struct user_namespace *mnt_userns,
 int btrfs_ioctl_get_supported_features(void __user *arg);
 void btrfs_sync_inode_flags_to_i_flags(struct inode *inode);
 int __pure btrfs_is_empty_uuid(u8 *uuid);
+
+struct btrfs_defrag_ctrl {
+	/* Values below are for defrag policy */
+	u64	start;
+	u64	len;
+	u32	extent_thresh;
+	u64	newer_than;
+	u64	max_sectors_to_defrag;
+	u8	compress;
+	u8	flags;
+
+	/* Values below are the defrag result */
+	u64	sectors_defragged;
+	u64	last_scanned;	/* Exclusive bytenr */
+};
+int btrfs_defrag_ioctl_args_to_ctrl(struct btrfs_fs_info *fs_info,
+				    struct btrfs_ioctl_defrag_range_args *args,
+				    struct btrfs_defrag_ctrl *ctrl,
+				    u64 max_sectors_to_defrag, u64 newer_than);
 int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 		      struct btrfs_ioctl_defrag_range_args *range,
 		      u64 newer_than, unsigned long max_to_defrag);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 3d3331dd0902..f9b9ee6c50da 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1499,6 +1499,47 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
 	return ret;
 }
 
+/*
+ * Convert the old ioctl format to the new btrfs_defrag_ctrl structure.
+ *
+ * Will also do basic task like setting default values and sanity check.
+ */
+int btrfs_defrag_ioctl_args_to_ctrl(struct btrfs_fs_info *fs_info,
+				    struct btrfs_ioctl_defrag_range_args *args,
+				    struct btrfs_defrag_ctrl *ctrl,
+				    u64 max_sectors_to_defrag, u64 newer_than)
+{
+	u64 range_end;
+
+	if (args->flags & ~BTRFS_DEFRAG_RANGE_FLAGS_MASK)
+		return -EOPNOTSUPP;
+	if (args->compress_type >= BTRFS_NR_COMPRESS_TYPES)
+		return -EOPNOTSUPP;
+
+	ctrl->start = round_down(args->start, fs_info->sectorsize);
+	/*
+	 * If @len does not overflow with @start nor is -1, align the length.
+	 * Otherwise set it to (u64)-1 so later btrfs_defrag_file() will
+	 * determine the length using isize.
+	 */
+	if (!check_add_overflow(args->start, args->len, &range_end) &&
+	    args->len != (u64)-1)
+		ctrl->len = round_up(range_end, fs_info->sectorsize) -
+			    ctrl->start;
+	else
+		ctrl->len = -1;
+	ctrl->flags = args->flags;
+	ctrl->compress = args->compress_type;
+	if (args->extent_thresh == 0)
+		ctrl->extent_thresh = SZ_256K;
+	else
+		ctrl->extent_thresh = args->extent_thresh;
+	ctrl->newer_than = newer_than;
+	ctrl->last_scanned = 0;
+	ctrl->sectors_defragged = 0;
+	return 0;
+}
+
 /*
  * Entry point to file defragmentation.
  *
-- 
2.34.1

