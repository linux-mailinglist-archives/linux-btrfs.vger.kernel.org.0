Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0DC4AA6F5
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Feb 2022 06:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241486AbiBEFr3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Feb 2022 00:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbiBEFr2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 5 Feb 2022 00:47:28 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EFEC061347
        for <linux-btrfs@vger.kernel.org>; Fri,  4 Feb 2022 21:47:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BB41C210F0;
        Sat,  5 Feb 2022 05:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644039686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y0+yWR/0w6wmJYw3e0tMDTwqkr9NwCdnpDnJo1MC+wI=;
        b=UOPiWolUzZmGB6xtAQ6Aa7aA70c2eowWEBzagNRuIxAk9KSdE4gt8fBHkSJkhAge+4mzJu
        YSLyjC6M0NAi1dL9JZbJwaZJiFIFB/dSqdR4S0HDUUj4WHmnKOH/xvhKdGuiJT6v6z+1g+
        ouIXlC0hCqclQWaZM/QLf6d8Qx/zmf8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DEC3313A6D;
        Sat,  5 Feb 2022 05:41:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MFjuKQUO/mFCQAAAMHmgww
        (envelope-from <wqu@suse.com>); Sat, 05 Feb 2022 05:41:25 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v3 2/5] btrfs: defrag: introduce btrfs_defrag_ctrl structure for later usage
Date:   Sat,  5 Feb 2022 13:41:03 +0800
Message-Id: <91007f0a0eb5d3213c2191abd97114b197f8aa44.1644039495.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <cover.1644039494.git.wqu@suse.com>
References: <cover.1644039494.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
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
index 9f7a950b8a69..670622fddd62 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3318,6 +3318,25 @@ int btrfs_fileattr_set(struct user_namespace *mnt_userns,
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
index 001b0882dfd8..c265b19885db 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1509,6 +1509,47 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
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
2.35.0

