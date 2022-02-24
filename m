Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F9B4C2BB2
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Feb 2022 13:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbiBXM32 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Feb 2022 07:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbiBXM3Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Feb 2022 07:29:25 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D068F269A8A
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Feb 2022 04:28:51 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8E05721155;
        Thu, 24 Feb 2022 12:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645705730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wWAHNnO9bY1qa0fgAiXQkxIgj1h9XZS1HqWPc1IuRaE=;
        b=Vsj3nu0eZQ11l2Xfq46OuEhm/MWZQlyz1yjWyUiBJcarzGC+JR66DejmcC9TVfk44vlGxn
        5A18k5jsWZkAkbYQxYbu+Lg/c2lkJrE7nyMwUNEfAM6AqkZxtMp+P6O2p2BOoPux+rPQ2e
        QFHJPtHn+5oI3Z82VWVKrbQRtWbg9xE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9CF4313AD9;
        Thu, 24 Feb 2022 12:28:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YMqZGAF6F2LhAgAAMHmgww
        (envelope-from <wqu@suse.com>); Thu, 24 Feb 2022 12:28:49 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 4/7] btrfs: defrag: introduce btrfs_defrag_ctrl structure for later usage
Date:   Thu, 24 Feb 2022 20:28:38 +0800
Message-Id: <a08f4e4364d32eaf164b3590b20a1a74b7cd0e03.1645705266.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1645705266.git.wqu@suse.com>
References: <cover.1645705266.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

- Set default values.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.h | 19 +++++++++++++++++++
 fs/btrfs/ioctl.c | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c72790c3bd41..97a9f17fc7f1 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3325,6 +3325,25 @@ int btrfs_fileattr_set(struct user_namespace *mnt_userns,
 int btrfs_ioctl_get_supported_features(void __user *arg);
 void btrfs_sync_inode_flags_to_i_flags(struct inode *inode);
 int __pure btrfs_is_empty_uuid(u8 *uuid);
+
+struct btrfs_defrag_ctrl {
+	/* Input, read-only fields */
+	u64	start;
+	u64	len;
+	u32	extent_thresh;
+	u64	newer_than;
+	u64	max_sectors_to_defrag;
+	u8	compress;
+	u8	flags;
+
+	/* Output fields */
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
index 7183af333c98..1ee2db269bc3 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1749,6 +1749,47 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
 	return ret;
 }
 
+/*
+ * Convert the old ioctl format to the new btrfs_defrag_ctrl structure.
+ *
+ * Will also do basic tasks like setting default values and sanity checks.
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
2.35.1

