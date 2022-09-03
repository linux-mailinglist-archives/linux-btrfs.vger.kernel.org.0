Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EB35ABDCC
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Sep 2022 10:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbiICIUA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 3 Sep 2022 04:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbiICIT6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 3 Sep 2022 04:19:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AEB32BBB
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 01:19:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C5DB43372C
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 08:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662193192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2zuLox11DLccbl2kjlWI78IIfPcKb7m3OP9oqCANzbs=;
        b=Ze2AZmclBxVs3h7yPGxIFIFXRhuNdFnCb8+14pdZQn3cjsQvbEY0o74umgRk68LsmubWhJ
        biI5vnNx4v3RY2S5NeDCSBNxRFhmlYSbSmWq2L+g6EGz3qWZEsWRqyeDtKD7CeoudaYDu4
        kq9fbtoARO9PAtaNFKs4xvLrXUHrh5E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2036E139F9
        for <linux-btrfs@vger.kernel.org>; Sat,  3 Sep 2022 08:19:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aMA3HScOE2OzagAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 03 Sep 2022 08:19:51 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH PoC 2/9] btrfs: scrub: introduce place holder for btrfs_scrub_fs()
Date:   Sat,  3 Sep 2022 16:19:22 +0800
Message-Id: <f5548a9dff5061103cfe2806e3d123f8310a2ebd.1662191784.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1662191784.git.wqu@suse.com>
References: <cover.1662191784.git.wqu@suse.com>
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

The new function btrfs_scrub_fs() will do the exclusive checking against
regular scrub and dev-replace, then return -EOPNOTSUPP as a place
holder.

Also to let regular scrub/dev-replace to be exclusive against
btrfs_scrub_fs(), also introduce btrfs_fs_info::scrub_fs_running member.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.h |   4 ++
 fs/btrfs/ioctl.c |  41 +++++++++++++++++-
 fs/btrfs/scrub.c | 105 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 149 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 3dc30f5e6fd0..0b360d9ec2e0 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -955,6 +955,7 @@ struct btrfs_fs_info {
 	/* private scrub information */
 	struct mutex scrub_lock;
 	atomic_t scrubs_running;
+	atomic_t scrub_fs_running;
 	atomic_t scrub_pause_req;
 	atomic_t scrubs_paused;
 	atomic_t scrub_cancel_req;
@@ -4063,6 +4064,9 @@ int btrfs_should_ignore_reloc_root(struct btrfs_root *root);
 int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 		    u64 end, struct btrfs_scrub_progress *progress,
 		    int readonly, int is_dev_replace);
+int btrfs_scrub_fs(struct btrfs_fs_info *fs_info, u64 start, u64 end,
+		   struct btrfs_scrub_fs_progress *progress,
+		   bool readonly);
 void btrfs_scrub_pause(struct btrfs_fs_info *fs_info);
 void btrfs_scrub_continue(struct btrfs_fs_info *fs_info);
 int btrfs_scrub_cancel(struct btrfs_fs_info *info);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 3df3bcdf06eb..8219e2554734 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4112,6 +4112,45 @@ static long btrfs_ioctl_scrub_progress(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
+static long btrfs_ioctl_scrub_fs(struct file *file, void __user *arg)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(file_inode(file)->i_sb);
+	struct btrfs_ioctl_scrub_fs_args *sfsa;
+	bool readonly = false;
+	int ret;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	sfsa = memdup_user(arg, sizeof(*sfsa));
+	if (IS_ERR(sfsa))
+		return PTR_ERR(sfsa);
+
+	if (sfsa->flags & ~BTRFS_SCRUB_FS_FLAG_SUPP) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+	if (sfsa->flags & BTRFS_SCRUB_FS_FLAG_READONLY)
+		readonly = true;
+
+	if (!readonly) {
+		ret = mnt_want_write_file(file);
+		if (ret)
+			goto out;
+	}
+
+	ret = btrfs_scrub_fs(fs_info, sfsa->start, sfsa->end, &sfsa->progress,
+			     readonly);
+	if (copy_to_user(arg, sfsa, sizeof(*sfsa)))
+		ret = -EFAULT;
+
+	if (!readonly)
+		mnt_drop_write_file(file);
+out:
+	kfree(sfsa);
+	return ret;
+}
+
 static long btrfs_ioctl_get_dev_stats(struct btrfs_fs_info *fs_info,
 				      void __user *arg)
 {
@@ -5509,7 +5548,7 @@ long btrfs_ioctl(struct file *file, unsigned int
 	case BTRFS_IOC_SCRUB_PROGRESS:
 		return btrfs_ioctl_scrub_progress(fs_info, argp);
 	case BTRFS_IOC_SCRUB_FS:
-		return -EOPNOTSUPP;
+		return btrfs_ioctl_scrub_fs(file, argp);
 	case BTRFS_IOC_SCRUB_FS_CANCEL:
 		return -EOPNOTSUPP;
 	case BTRFS_IOC_SCRUB_FS_PROGRESS:
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 755273b77a3f..09a1ab6ac54e 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -4295,6 +4295,15 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 	}
 
 	mutex_lock(&fs_info->scrub_lock);
+
+	/* Conflict with scrub_fs ioctls. */
+	if (atomic_read(&fs_info->scrub_fs_running)) {
+		mutex_unlock(&fs_info->scrub_lock);
+		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
+		ret = -EINPROGRESS;
+		goto out;
+	}
+
 	if (!test_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &dev->dev_state) ||
 	    test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &dev->dev_state)) {
 		mutex_unlock(&fs_info->scrub_lock);
@@ -4416,6 +4425,102 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 	return ret;
 }
 
+/*
+ * Unlike btrfs_scrub_dev(), this function works completely in logical bytenr
+ * level, and has the following advantage:
+ *
+ * - Better error reporting
+ *   The new btrfs_scrub_fs_progress has better classified errors, more
+ *   members to include parity errors.
+ *
+ * - Always scrub one block group at one time
+ *   btrfs_scrub_dev() works by starting one scrub for each device.
+ *   This can cause asynchronised progress, and mark multiple block groups
+ *   RO, reducing the avaialbe space unnecessarily.
+ *
+ * - Less IO for RAID56
+ *   Instead of treating RAID56 data and P/Q stripes differently, here we only
+ *   scrub a full stripe at most once.
+ *   Instead of the 2x read for data stripes (one for scrubbing the data stripe itself,
+ *   the other one from scrubbing the P/Q stripe).
+ *
+ * - No bio formshaping and streamlined code
+ *   Always submit bio for all involved mirrors (or data/p/q stripes for
+ *   RAID56), wait for the IO, then run the check.
+ *
+ *   Thus there are at most nr_mirrors (nr_stripes for RAID56) bios on-the-fly,
+ *   and for each device, there is always at most one bio for scrub.
+ *
+ *   This would greatly simplify all involved code.
+ *
+ * - No need to support dev-replace
+ *   Thus we can have simpler code.
+ *
+ * Unfortunately this ioctl has the following disadvantage so far:
+ *
+ * - No resume after unmount
+ *   We may need extra on-disk format to save the progress.
+ *   Thus we may need a new RO compat flags for the resume ability.
+ *
+ * - Conflicts with dev-replace/scrub
+ *
+ * - Needs kernel support.
+ *
+ * - Not fully finished
+ */
+int btrfs_scrub_fs(struct btrfs_fs_info *fs_info, u64 start, u64 end,
+		   struct btrfs_scrub_fs_progress *progress,
+		   bool readonly)
+{
+	int ret;
+
+	if (btrfs_fs_closing(fs_info))
+		return -EAGAIN;
+
+	if (btrfs_is_zoned(fs_info))
+		return -EOPNOTSUPP;
+
+	/*
+	 * Metadata and data unit should be able to be contained inside one
+	 * stripe.
+	 */
+	ASSERT(fs_info->nodesize <= BTRFS_STRIPE_LEN);
+	ASSERT(fs_info->sectorsize <= BTRFS_STRIPE_LEN);
+
+	mutex_lock(&fs_info->scrub_lock);
+	/* This function conflicts with scrub/dev-replace. */
+	if (atomic_read(&fs_info->scrubs_running)) {
+		mutex_unlock(&fs_info->scrub_lock);
+		return -EINPROGRESS;
+	}
+
+	/* And there can only be one running btrfs_scrub_fs(). */
+	if (atomic_read(&fs_info->scrub_fs_running)) {
+		mutex_unlock(&fs_info->scrub_lock);
+		return -EINPROGRESS;
+	}
+
+	__scrub_blocked_if_needed(fs_info);
+	atomic_inc(&fs_info->scrub_fs_running);
+
+	/* This is to allow existing scrub pause to be reused. */
+	atomic_inc(&fs_info->scrubs_running);
+	btrfs_info(fs_info, "scrub_fs: started");
+	mutex_unlock(&fs_info->scrub_lock);
+
+	/* Place holder for real workload. */
+	ret = -EOPNOTSUPP;
+
+	mutex_lock(&fs_info->scrub_lock);
+	atomic_dec(&fs_info->scrubs_running);
+	atomic_dec(&fs_info->scrub_fs_running);
+	btrfs_info(fs_info, "scrub_fs: finished with status: %d", ret);
+	mutex_unlock(&fs_info->scrub_lock);
+	wake_up(&fs_info->scrub_pause_wait);
+
+	return ret;
+}
+
 void btrfs_scrub_pause(struct btrfs_fs_info *fs_info)
 {
 	mutex_lock(&fs_info->scrub_lock);
-- 
2.37.3

