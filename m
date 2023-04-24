Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BF86EC353
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Apr 2023 02:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjDXAtL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Apr 2023 20:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDXAtK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Apr 2023 20:49:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6F71BD9
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Apr 2023 17:49:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4077521A1D
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Apr 2023 00:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682297345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=HfvGBQwoFoVD6H0kIdM2pC2bI4AlqsoLibPF5uvP7E8=;
        b=RQmUQ/myecWXCIlh02TA3ebkXfb30PoFCYMYsebaE1xoaWZlG/5f9LTtEhSDIcWIZAWXsE
        Y8KyXpwpHctM9AdYJCZSmINXa//WSKn66txhYH8DWX1lkkLXT8v4MkjSy4I1UReyyX4P6Q
        YGU9EfD0LSVRotLtIgbWUL2HIl3dHXY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A5043138E5
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Apr 2023 00:49:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Edj1HADSRWTlJAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Apr 2023 00:49:04 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC] btrfs: make dev-scrub as an exclusive operation
Date:   Mon, 24 Apr 2023 08:48:47 +0800
Message-Id: <ef0c22ce3cf2f7941634ed1cb2ca718f04ce675d.1682296794.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
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

[PROBLEMS]
Currently dev-scrub is not an exclusive operation, thus it's possible to
run scrub with balance at the same time.

But there are possible several problems when such concurrency is
involved:

- Scrub can lead to false alerts due to removed block groups
  When balance is finished, it would delete the source block group
  and may even do an discard.

  In that case if a scrub is still running for that block group, we
  can lead to false alerts on bad checksum.

- Balance is already checking the checksum
  Thus we're doing double checksum verification, under most cases it's
  just a waste of IO and CPU time.

- Extra chance of unnecessary -ENOSPC
  Both balance and scrub would try to mark the target block group
  read-only.
  With more block groups marked read-only, we have higher chance to
  hit early -ENOSPC.

[ENHANCEMENT]
Let's make dev-scrub as an exclusive operation, but unlike regular
exclusive operations, we need to allow multiple dev-scrub to run
concurrently.

Thus we introduce a new member, fs_info::exclusive_dev_scrubs, to record
how many dev scrubs are running.
And only set fs_info::exclusive_operation back to NONE when no more
dev-scrub is running.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Reason for RFC:

This change is a change to the dev-scrub behavior, now we have extra
error patterns.

And some existing test cases would be invalid, as they expect
concurrent scrub and balance as a background stress.

Although this makes later logical bytenr based scrub much easier to
implement (needs to be exclusive with dev-scrub).
---
 fs/btrfs/disk-io.c |  1 +
 fs/btrfs/fs.h      |  5 ++++-
 fs/btrfs/ioctl.c   | 29 ++++++++++++++++++++++++++++-
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 59ea049fe7ee..c6323750be18 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2957,6 +2957,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	atomic_set(&fs_info->async_delalloc_pages, 0);
 	atomic_set(&fs_info->defrag_running, 0);
 	atomic_set(&fs_info->nr_delayed_iputs, 0);
+	atomic_set(&fs_info->exclusive_dev_scrubs, 0);
 	atomic64_set(&fs_info->tree_mod_seq, 0);
 	fs_info->global_root_tree = RB_ROOT;
 	fs_info->max_inline = BTRFS_DEFAULT_MAX_INLINE;
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 0d98fc5f6f44..ff7c0c1fb145 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -335,7 +335,7 @@ struct btrfs_discard_ctl {
 };
 
 /*
- * Exclusive operations (device replace, resize, device add/remove, balance)
+ * Exclusive operations (device replace, resize, device add/remove, balance, scrub)
  */
 enum btrfs_exclusive_operation {
 	BTRFS_EXCLOP_NONE,
@@ -344,6 +344,7 @@ enum btrfs_exclusive_operation {
 	BTRFS_EXCLOP_DEV_ADD,
 	BTRFS_EXCLOP_DEV_REMOVE,
 	BTRFS_EXCLOP_DEV_REPLACE,
+	BTRFS_EXCLOP_DEV_SCRUB,
 	BTRFS_EXCLOP_RESIZE,
 	BTRFS_EXCLOP_SWAP_ACTIVATE,
 };
@@ -744,6 +745,8 @@ struct btrfs_fs_info {
 
 	/* Type of exclusive operation running, protected by super_lock */
 	enum btrfs_exclusive_operation exclusive_operation;
+	/* Number of running dev_scrubs for exclusive operations. */
+	atomic_t exclusive_dev_scrubs;
 
 	/*
 	 * Zone size > 0 when in ZONED mode, otherwise it's used for a check
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 25833b4eeaf5..4be89198baed 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -403,6 +403,20 @@ bool btrfs_exclop_start(struct btrfs_fs_info *fs_info,
 	spin_lock(&fs_info->super_lock);
 	if (fs_info->exclusive_operation == BTRFS_EXCLOP_NONE) {
 		fs_info->exclusive_operation = type;
+		if (type == BTRFS_EXCLOP_DEV_SCRUB)
+			atomic_inc(&fs_info->exclusive_dev_scrubs);
+		ret = true;
+		spin_unlock(&fs_info->super_lock);
+		return ret;
+	}
+
+	/*
+	 * For dev-scrub, we allow multiple scrubs to be run concurrently
+	 * as it's a per-device operation.
+	 */
+	if (type == BTRFS_EXCLOP_DEV_SCRUB &&
+	    fs_info->exclusive_operation == type) {
+		atomic_inc(&fs_info->exclusive_dev_scrubs);
 		ret = true;
 	}
 	spin_unlock(&fs_info->super_lock);
@@ -442,7 +456,12 @@ void btrfs_exclop_start_unlock(struct btrfs_fs_info *fs_info)
 void btrfs_exclop_finish(struct btrfs_fs_info *fs_info)
 {
 	spin_lock(&fs_info->super_lock);
-	WRITE_ONCE(fs_info->exclusive_operation, BTRFS_EXCLOP_NONE);
+	if (fs_info->exclusive_operation == BTRFS_EXCLOP_DEV_SCRUB) {
+		if (atomic_dec_and_test(&fs_info->exclusive_dev_scrubs))
+			WRITE_ONCE(fs_info->exclusive_operation, BTRFS_EXCLOP_NONE);
+	} else {
+		WRITE_ONCE(fs_info->exclusive_operation, BTRFS_EXCLOP_NONE);
+	}
 	spin_unlock(&fs_info->super_lock);
 	sysfs_notify(&fs_info->fs_devices->fsid_kobj, NULL, "exclusive_operation");
 }
@@ -3172,9 +3191,17 @@ static long btrfs_ioctl_scrub(struct file *file, void __user *arg)
 			goto out;
 	}
 
+	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_DEV_SCRUB)) {
+		ret = BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
+		if (!(sa->flags & BTRFS_SCRUB_READONLY))
+			mnt_drop_write_file(file);
+		goto out;
+	}
+
 	ret = btrfs_scrub_dev(fs_info, sa->devid, sa->start, sa->end,
 			      &sa->progress, sa->flags & BTRFS_SCRUB_READONLY,
 			      0);
+	btrfs_exclop_finish(fs_info);
 
 	/*
 	 * Copy scrub args to user space even if btrfs_scrub_dev() returned an
-- 
2.39.2

