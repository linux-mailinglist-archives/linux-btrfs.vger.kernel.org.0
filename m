Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6220B745629
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jul 2023 09:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjGCHdZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Jul 2023 03:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjGCHdR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Jul 2023 03:33:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC47E50
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Jul 2023 00:33:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0300E1FD6E;
        Mon,  3 Jul 2023 07:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1688369586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k0D/8EJwkLNZiJNZP+bXDDGhBtPoHSUffDal9aANvN8=;
        b=h0lkuw835MzvIUXYllKrYdQ9Awtemkf2wVjOX0UYvPFrNtVgr/FT1yVxSW4wuORlbeBpiL
        lYXeW3wpOLC7r6VVKynoVmC5ojAM6dtVZlgsh2RaBgRQ3k8bS9W0HvWvysdxan2OgU7Knk
        WWf36+La9EKNoS6iLYe2/DF5mpt+UE4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 20A4613276;
        Mon,  3 Jul 2023 07:33:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sKEwN7B5omRoVQAAMHmgww
        (envelope-from <wqu@suse.com>); Mon, 03 Jul 2023 07:33:04 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 07/14] btrfs: scrub: introduce the skeleton for logical-scrub
Date:   Mon,  3 Jul 2023 15:32:31 +0800
Message-ID: <a95469cd1a413630e5ecd18027c53a4a46d3120b.1688368617.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1688368617.git.wqu@suse.com>
References: <cover.1688368617.git.wqu@suse.com>
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

Currently btrfs scrub is a per-device operation, this is fine for most
non-RAID56 profiles, but not a good thing for RAID56 profiles.

The main challenge for RAID56 is, we will read out data stripes more
than one times (one for the data stripe scrub itself, more for
parities).

To address this, and maybe even improve the non-RAID56 scrub, here we
introduce a new scrub flag, SCRUB_LOGICAL.

This would be a per-fs operation, and conflicts with any
dev-scrub/dev-replace.

This patch only implements the basic exclusion checks.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c         |  1 +
 fs/btrfs/fs.h              | 12 +++++++
 fs/btrfs/ioctl.c           |  6 +++-
 fs/btrfs/scrub.c           | 72 +++++++++++++++++++++++++++++++++++++-
 fs/btrfs/scrub.h           |  2 ++
 include/uapi/linux/btrfs.h | 11 ++++--
 6 files changed, 100 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7513388b0567..c11f28becaf2 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1850,6 +1850,7 @@ static void btrfs_init_scrub(struct btrfs_fs_info *fs_info)
 {
 	mutex_init(&fs_info->scrub_lock);
 	atomic_set(&fs_info->scrubs_running, 0);
+	atomic_set(&fs_info->scrubs_logical_running, 0);
 	atomic_set(&fs_info->scrub_pause_req, 0);
 	atomic_set(&fs_info->scrubs_paused, 0);
 	atomic_set(&fs_info->scrub_cancel_req, 0);
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 203d2a267828..f3d50f97ab27 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -632,7 +632,19 @@ struct btrfs_fs_info {
 
 	/* Private scrub information */
 	struct mutex scrub_lock;
+
+	/*
+	 * Number of running scrubbing, including both dev-scrub (at most
+	 * one dev-scrub on each device) and logical-scrub (at most
+	 * one logical-scrub for each fs).
+	 */
 	atomic_t scrubs_running;
+
+	/*
+	 * Number of running logical scrubbing, there is at most one running
+	 * logical scrub for each fs.
+	 */
+	atomic_t scrubs_logical_running;
 	atomic_t scrub_pause_req;
 	atomic_t scrubs_paused;
 	atomic_t scrub_cancel_req;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index edbbd5cf23fc..1a1afcce73e0 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3179,7 +3179,11 @@ static long btrfs_ioctl_scrub(struct file *file, void __user *arg)
 			goto out;
 	}
 
-	ret = btrfs_scrub_dev(fs_info, sa->devid, sa->start, sa->end,
+	if (sa->flags & BTRFS_SCRUB_LOGICAL)
+		ret = btrfs_scrub_logical(fs_info, sa->start, sa->end,
+				&sa->progress, sa->flags & BTRFS_SCRUB_READONLY);
+	else
+		ret = btrfs_scrub_dev(fs_info, sa->devid, sa->start, sa->end,
 			      &sa->progress, sa->flags & BTRFS_SCRUB_READONLY,
 			      0);
 
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 1e49bb066619..ff637f83aa0e 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -178,7 +178,8 @@ struct scrub_ctx {
 	int			first_free;
 	int			cur_stripe;
 	atomic_t		cancel_req;
-	int			readonly;
+	bool			readonly;
+	bool			scrub_logical;
 	int			sectors_per_bio;
 
 	/* Number of stripes we have in @stripes. */
@@ -2835,6 +2836,14 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 		goto out;
 	}
 
+	/* Dev-scrub conflicts with logical-scrub. */
+	if (atomic_read(&fs_info->scrubs_logical_running)) {
+		mutex_unlock(&fs_info->scrub_lock);
+		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
+		ret = -EINPROGRESS;
+		goto out;
+	}
+
 	down_read(&fs_info->dev_replace.rwsem);
 	if (dev->scrub_ctx ||
 	    (!is_dev_replace &&
@@ -2945,6 +2954,67 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 	return ret;
 }
 
+int btrfs_scrub_logical(struct btrfs_fs_info *fs_info, u64 start, u64 end,
+			struct btrfs_scrub_progress *progress, bool readonly)
+{
+	struct scrub_ctx *sctx;
+	int ret;
+
+	if (btrfs_fs_closing(fs_info))
+		return -EAGAIN;
+
+	/* At mount time we have ensured nodesize is in the range of [4K, 64K]. */
+	ASSERT(fs_info->nodesize <= BTRFS_STRIPE_LEN);
+
+	sctx = scrub_setup_ctx(fs_info, false);
+	if (IS_ERR(sctx))
+		return PTR_ERR(sctx);
+	sctx->scrub_logical = true;
+	sctx->readonly = readonly;
+
+	ret = scrub_workers_get(fs_info, false);
+	if (ret)
+		goto out_free_ctx;
+
+	/* Make sure we're the only running scrub. */
+	mutex_lock(&fs_info->scrub_lock);
+	if (atomic_read(&fs_info->scrubs_running)) {
+		mutex_unlock(&fs_info->scrub_lock);
+		ret = -EINPROGRESS;
+		goto out;
+	}
+	down_read(&fs_info->dev_replace.rwsem);
+	if (btrfs_dev_replace_is_ongoing(&fs_info->dev_replace)) {
+		up_read(&fs_info->dev_replace.rwsem);
+		mutex_unlock(&fs_info->scrub_lock);
+		ret = -EINPROGRESS;
+		goto out;
+	}
+	up_read(&fs_info->dev_replace.rwsem);
+	/*
+	 * Checking @scrub_pause_req here, we can avoid
+	 * race between committing transaction and scrubbing.
+	 */
+	__scrub_blocked_if_needed(fs_info);
+	atomic_inc(&fs_info->scrubs_running);
+	atomic_inc(&fs_info->scrubs_logical_running);
+	mutex_unlock(&fs_info->scrub_lock);
+
+	/* The main work would be implemented. */
+	ret = -EOPNOTSUPP;
+
+	atomic_dec(&fs_info->scrubs_running);
+	atomic_dec(&fs_info->scrubs_logical_running);
+	wake_up(&fs_info->scrub_pause_wait);
+	if (progress)
+		memcpy(progress, &sctx->stat, sizeof(*progress));
+out:
+	scrub_workers_put(fs_info);
+out_free_ctx:
+	scrub_free_ctx(sctx);
+	return ret;
+}
+
 void btrfs_scrub_pause(struct btrfs_fs_info *fs_info)
 {
 	mutex_lock(&fs_info->scrub_lock);
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
index 7639103ebf9d..22db0f71083e 100644
--- a/fs/btrfs/scrub.h
+++ b/fs/btrfs/scrub.h
@@ -6,6 +6,8 @@
 int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 		    u64 end, struct btrfs_scrub_progress *progress,
 		    int readonly, int is_dev_replace);
+int btrfs_scrub_logical(struct btrfs_fs_info *fs_info, u64 start, u64 end,
+			struct btrfs_scrub_progress *progress, bool readonly);
 void btrfs_scrub_pause(struct btrfs_fs_info *fs_info);
 void btrfs_scrub_continue(struct btrfs_fs_info *fs_info);
 int btrfs_scrub_cancel(struct btrfs_fs_info *info);
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index dbb8b96da50d..fa5cb3b3611b 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -186,8 +186,15 @@ struct btrfs_scrub_progress {
 					 * Intermittent error. */
 };
 
-#define BTRFS_SCRUB_READONLY	1
-#define BTRFS_SCRUB_SUPPORTED_FLAGS	(BTRFS_SCRUB_READONLY)
+#define BTRFS_SCRUB_READONLY	(1ULL << 0)
+
+/*
+ * Regular scrub is based on device, while with this flag, scrub is
+ * based on logical, and @devid would be ignored.
+ */
+#define BTRFS_SCRUB_LOGICAL	(1ULL << 1)
+#define BTRFS_SCRUB_SUPPORTED_FLAGS	(BTRFS_SCRUB_READONLY |\
+					 BTRFS_SCRUB_LOGICAL)
 struct btrfs_ioctl_scrub_args {
 	__u64 devid;				/* in */
 	__u64 start;				/* in */
-- 
2.41.0

