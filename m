Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A4A4B1EA7
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 07:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344307AbiBKGmI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Feb 2022 01:42:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243111AbiBKGmH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Feb 2022 01:42:07 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276C4E7B
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Feb 2022 22:42:07 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D35831F3A8;
        Fri, 11 Feb 2022 06:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644561725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jK8566jstSdpxbLwzdhxUJi12QI/QNrXo1mJZZuHCEQ=;
        b=tbSmI4CR+P57YQmN4L2v1CBfJtiZgdqI5RcdsaJ4T+D7VFxGBv1AnhYfk8Qd2td7h/AL1T
        u8If+8fLCSYcLXICbIQhf/Fkz78YatjGjymkqa2fCOkIoi7AeBaadkVhIfLmH62Vqry7Ri
        b3/aUJ+6IjOp6+322khVd8bUKbIM42A=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0326E13345;
        Fri, 11 Feb 2022 06:42:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mKzHLzwFBmLmUAAAMHmgww
        (envelope-from <wqu@suse.com>); Fri, 11 Feb 2022 06:42:04 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v4 3/5] btrfs: defrag: introduce btrfs_defrag_ctrl structure for later usage
Date:   Fri, 11 Feb 2022 14:41:41 +0800
Message-Id: <6c510d7fa56144209fa3287c731cac48f76bc856.1644561438.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <cover.1644561438.git.wqu@suse.com>
References: <cover.1644561438.git.wqu@suse.com>
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
index fa4d29026275..c6a971033336 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1563,6 +1563,47 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
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

