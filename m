Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754C05699E5
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Jul 2022 07:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbiGGFdE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Jul 2022 01:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGGFdD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Jul 2022 01:33:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9343134C
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jul 2022 22:33:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3C37721D94
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 05:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657171981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c0ZUXn5ypN199wPptlBGguCI5w7lGApL6vasq0MC4OY=;
        b=qPCHSgLPelzS7WCe2a9GhU9mZHuHTjnPSLcXmzi97T4w/92zB2Uyos0jDYJtwyj7s7rZ8G
        bmaBLDl8JvbOawcLeyttaU+qNXceZrtg2Rs4pRVpjdgnFytaMmfpw9KXfcsyqx8INHZIn1
        2a8QJb3FbmA2NQyjwCFB6X/r4CyM0Fs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 95E6113488
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Jul 2022 05:33:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WFx0GAxwxmKcLAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 07 Jul 2022 05:33:00 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 04/12] btrfs: load/create write-intent bitmaps at mount time
Date:   Thu,  7 Jul 2022 13:32:29 +0800
Message-Id: <ea4fb51b43020793d37c022eb0597b851c4c20ad.1657171615.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657171615.git.wqu@suse.com>
References: <cover.1657171615.git.wqu@suse.com>
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

This patch will introduce btrfs_fs_info::wi_ctrl, which will have a
non-highmem page for the write intent bitmaps.

Please note that, if we can't find a valid bitmaps, the newly create one
will only be in memory for now, the bitmaps writeback functionality will
be introduced in the next commit.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/Makefile       |   2 +-
 fs/btrfs/ctree.h        |   1 +
 fs/btrfs/disk-io.c      |   7 ++
 fs/btrfs/write-intent.c | 174 ++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/write-intent.h |  15 ++++
 5 files changed, 198 insertions(+), 1 deletion(-)
 create mode 100644 fs/btrfs/write-intent.c

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 99f9995670ea..af93119d52e2 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -31,7 +31,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 	   backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
 	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o \
 	   block-rsv.o delalloc-space.o block-group.o discard.o reflink.o \
-	   subpage.o tree-mod-log.o
+	   subpage.o tree-mod-log.o write-intent.o
 
 btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
 btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 908a735a66cf..fcc8ae4b7fb4 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -989,6 +989,7 @@ struct btrfs_fs_info {
 	struct workqueue_struct *scrub_wr_completion_workers;
 	struct workqueue_struct *scrub_parity_workers;
 	struct btrfs_subpage_info *subpage_info;
+	struct write_intent_ctrl *wi_ctrl;
 
 	struct btrfs_discard_ctl discard_ctl;
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 963a89cd4bfb..edbb21706bda 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3699,6 +3699,12 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 			  ret);
 		goto fail_block_groups;
 	}
+	ret = btrfs_write_intent_init(fs_info);
+	if (ret) {
+		btrfs_err(fs_info, "failed to init write-intent bitmaps: %d",
+			  ret);
+		goto fail_block_groups;
+	}
 	ret = btrfs_recover_balance(fs_info);
 	if (ret) {
 		btrfs_err(fs_info, "failed to recover balance: %d", ret);
@@ -4639,6 +4645,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 		ret = btrfs_commit_super(fs_info);
 		if (ret)
 			btrfs_err(fs_info, "commit super ret %d", ret);
+		btrfs_write_intent_free(fs_info);
 	}
 
 	if (BTRFS_FS_ERROR(fs_info))
diff --git a/fs/btrfs/write-intent.c b/fs/btrfs/write-intent.c
new file mode 100644
index 000000000000..a7ed21182525
--- /dev/null
+++ b/fs/btrfs/write-intent.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "ctree.h"
+#include "volumes.h"
+#include "write-intent.h"
+
+/*
+ * Return 0 if a valid write intent bitmap can be found.
+ * Return 1 if no valid write intent bitmap can be found.
+ * Return <0 for other fatal errors.
+ */
+static int write_intent_load(struct btrfs_device *device, struct page *dst)
+{
+	struct btrfs_fs_info *fs_info = device->fs_info;
+	struct write_intent_super *wis;
+	struct bio *bio;
+	int ret;
+
+	bio = bio_alloc(device->bdev, 1, REQ_OP_READ | REQ_SYNC | REQ_META,
+			GFP_NOFS);
+	/* It's backed by fs_bioset. */
+	ASSERT(bio);
+	bio->bi_iter.bi_sector = BTRFS_DEVICE_RANGE_RESERVED >> SECTOR_SHIFT;
+	__bio_add_page(bio, dst, WRITE_INTENT_BITMAPS_SIZE, 0);
+	ret = submit_bio_wait(bio);
+	if (ret < 0)
+		return ret;
+
+	wis = page_address(dst);
+	if (wi_super_magic(wis) != WRITE_INTENT_SUPER_MAGIC)
+		return 1;
+
+	/* Stale bitmaps, doesn't belong to our fs. */
+	if (memcmp(wis->fsid, device->fs_devices->fsid, BTRFS_FSID_SIZE))
+		return 1;
+
+	/* Above checks pass, but still csum mismatch, a big problem. */
+	if (btrfs_super_csum_type(fs_info->super_copy) !=
+	    wi_super_csum_type(wis)) {
+		btrfs_err(fs_info,
+		"csum type mismatch, write intent bitmap has %u fs has %u",
+			  wi_super_csum_type(wis),
+			  btrfs_super_csum_type(fs_info->super_copy));
+		return -EUCLEAN;
+	}
+
+	if (wi_super_flags(wis) & ~WRITE_INTENT_FLAGS_SUPPORTED) {
+		btrfs_err(fs_info, "unsupported flags 0x%llx",
+			  wi_super_flags(wis) & ~WRITE_INTENT_FLAGS_SUPPORTED);
+		return -EOPNOTSUPP;
+	}
+
+	return ret;
+}
+
+static void write_intent_init(struct btrfs_fs_info *fs_info)
+{
+	struct write_intent_ctrl *ctrl = fs_info->wi_ctrl;
+	struct write_intent_super *wis;
+
+	ASSERT(ctrl);
+	ASSERT(ctrl->page);
+
+	/* Always start event count from 1. */
+	atomic64_set(&ctrl->event, 1);
+	ctrl->blocksize = WRITE_INTENT_BLOCKSIZE;
+	memzero_page(ctrl->page, 0, WRITE_INTENT_BITMAPS_SIZE);
+
+	wis = page_address(ctrl->page);
+	memcpy(wis->fsid, fs_info->fs_devices->fsid, BTRFS_FSID_SIZE);
+	wi_set_super_magic(wis, WRITE_INTENT_SUPER_MAGIC);
+	wi_set_super_csum_type(wis, btrfs_super_csum_type(fs_info->super_copy));
+	wi_set_super_events(wis, 1);
+	wi_set_super_flags(wis, WRITE_INTENT_FLAGS_SUPPORTED);
+	wi_set_super_size(wis, WRITE_INTENT_BITMAPS_SIZE);
+	wi_set_super_blocksize(wis, ctrl->blocksize);
+	wi_set_super_nr_entries(wis, 0);
+	btrfs_info(fs_info, "creating new write intent bitmaps");
+}
+
+int btrfs_write_intent_init(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_device *highest_dev = NULL;
+	struct btrfs_device *dev;
+	struct write_intent_super *wis;
+	u64 highest_event = 0;
+	int ret;
+
+	ASSERT(fs_info->wi_ctrl == NULL);
+	if (!btrfs_fs_compat_ro(fs_info, WRITE_INTENT_BITMAP))
+		return 0;
+
+	fs_info->wi_ctrl = kzalloc(sizeof(*fs_info->wi_ctrl), GFP_NOFS);
+	if (!fs_info->wi_ctrl)
+		return -ENOMEM;
+
+	fs_info->wi_ctrl->page = alloc_page(GFP_NOFS);
+	if (!fs_info->wi_ctrl->page) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	/*
+	 * Go through every writeable device to find the highest event.
+	 *
+	 * Only the write-intent with highest event number makes sense.
+	 * If during bitmap writeback we lost power, some dev may have old
+	 * bitmap which is already stale.
+	 */
+	list_for_each_entry(dev, &fs_info->fs_devices->devices, dev_list) {
+		u64 cur_event;
+
+		if (!dev->bdev)
+			continue;
+
+		ret = write_intent_load(dev, fs_info->wi_ctrl->page);
+		if (ret > 0)
+			continue;
+		if (ret < 0) {
+			btrfs_err(fs_info,
+			"failed to load write intent from devid %llu: %d",
+				  dev->devid, ret);
+			goto cleanup;
+		}
+		wis = page_address(fs_info->wi_ctrl->page);
+		cur_event = wi_super_events(wis);
+		if (cur_event > highest_event) {
+			highest_dev = dev;
+			highest_event = cur_event;
+		}
+	}
+
+	/* Load the bitmap with lowest event as our bitmap. */
+	if (highest_dev) {
+		ret = write_intent_load(highest_dev, fs_info->wi_ctrl->page);
+		if (ret < 0) {
+			btrfs_err(fs_info,
+			"failed to load write intent from devid %llu: %d",
+				  dev->devid, ret);
+			goto cleanup;
+		}
+		wis = page_address(fs_info->wi_ctrl->page);
+		atomic64_set(&fs_info->wi_ctrl->event, wi_super_events(wis));
+		fs_info->wi_ctrl->blocksize = wi_super_blocksize(wis);
+		btrfs_info(fs_info,
+			"loaded write intent bitmaps, event count %llu",
+			atomic64_read(&fs_info->wi_ctrl->event));
+		return 0;
+	}
+
+	/* No valid bitmap found, create a new one. */
+	write_intent_init(fs_info);
+	return 0;
+cleanup:
+	if (fs_info->wi_ctrl) {
+		if (fs_info->wi_ctrl->page)
+			__free_page(fs_info->wi_ctrl->page);
+		kfree(fs_info->wi_ctrl);
+		fs_info->wi_ctrl = NULL;
+	}
+	return ret;
+}
+
+void btrfs_write_intent_free(struct btrfs_fs_info *fs_info)
+{
+	struct write_intent_ctrl *ctrl = fs_info->wi_ctrl;
+
+	if (!ctrl)
+		return;
+	ASSERT(ctrl->page);
+	__free_page(ctrl->page);
+	kfree(ctrl);
+	fs_info->wi_ctrl = NULL;
+}
diff --git a/fs/btrfs/write-intent.h b/fs/btrfs/write-intent.h
index b851917bb0b6..2c5cd434e978 100644
--- a/fs/btrfs/write-intent.h
+++ b/fs/btrfs/write-intent.h
@@ -106,6 +106,18 @@ struct write_intent_entry {
 /* The number of bits we can have in one entry. */
 #define WRITE_INTENT_BITS_PER_ENTRY		(64)
 
+/* In-memory write-intent control structure. */
+struct write_intent_ctrl {
+	/* For the write_intent super and entries. */
+	struct page *page;
+
+	/* Cached event counter.*/
+	atomic64_t event;
+
+	/* Cached blocksize from write intent super. */
+	u32 blocksize;
+};
+
 /*
  * ON-DISK FORMAT
  * ==============
@@ -196,4 +208,7 @@ static inline void wie_set_bitmap(struct write_intent_entry *entry,
 #endif
 }
 
+int btrfs_write_intent_init(struct btrfs_fs_info *fs_info);
+void btrfs_write_intent_free(struct btrfs_fs_info *fs_info);
+
 #endif
-- 
2.36.1

