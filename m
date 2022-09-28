Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6555ED7E4
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Sep 2022 10:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbiI1IgT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Sep 2022 04:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbiI1IgO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Sep 2022 04:36:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1199DDA2
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 01:36:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9B52E1F8B3
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 08:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664354169; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+VJiN2lY+uw+3pR0u2g8ww7nMg3esG0uXpOsXRo17Io=;
        b=EEFiqd6DkJfZ2rw2o49GvJlZcGIPl5DCf0pk1XTWShfSE4PZRc8MiwODlhfaMeYykEpUlY
        MwFc25nyAJEvJoulbFlMcd5IdOWWaFRxoNk2AkFeZbhlOd/vjtVRn3HChRb+r30XYl+WnK
        i4HuB2BuB1tH0SUJBbEQxVuKD04s/EU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E2B5613A84
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 08:36:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KF6MKXgHNGO2VgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 08:36:08 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH PoC v2 03/10] btrfs: scrub: introduce a place holder helper scrub_fs_iterate_bgs()
Date:   Wed, 28 Sep 2022 16:35:40 +0800
Message-Id: <9a80361fc9cc1176e08a3c670ea960b9616dc00d.1664353497.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1664353497.git.wqu@suse.com>
References: <cover.1664353497.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This new helper is mostly the same as scrub_enumerate_chunks(), but with
some small changes:

- No need for dev-replace branches

- No need to search dev-extent tree
  We can directly iterate the block groups.

The new helper currently will only iterate all the bgs, but doing
nothing for the iterated bgs.

Also one smaller helper is introduced:

- scrub_fs_alloc_ctx()
  To allocate a scrub_fs_ctx, which has way less members (for now and
  for the future) compared to scrub_ctx.

  The scrub_fs_ctx will have a very defined lifespan (only inside
  btrfs_scrub_fs(), and can only have one scrub_fs_ctx, thus not need to
  be ref counted)

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 164 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 162 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index d3d64f048c7b..97da8545c9ab 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -198,6 +198,24 @@ struct scrub_ctx {
 	refcount_t              refs;
 };
 
+/* This structure should only has a lifespan inside btrfs_scrub_fs(). */
+struct scrub_fs_ctx {
+	struct btrfs_fs_info		*fs_info;
+
+	/* Current block group we're scurbbing. */
+	struct btrfs_block_group	*cur_bg;
+
+	/* Current logical bytenr being scrubbed. */
+	u64				cur_logical;
+
+	atomic_t			bios_under_io;
+
+	bool				readonly;
+
+	/* There will and only be one thread touching @stat. */
+	struct btrfs_scrub_fs_progress	stat;
+};
+
 struct scrub_warning {
 	struct btrfs_path	*path;
 	u64			extent_item_size;
@@ -4427,6 +4445,126 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 	return ret;
 }
 
+static struct scrub_fs_ctx *scrub_fs_alloc_ctx(struct btrfs_fs_info *fs_info,
+					       bool readonly)
+{
+	struct scrub_fs_ctx *sfctx;
+	int ret;
+
+	sfctx = kzalloc(sizeof(*sfctx), GFP_KERNEL);
+	if (!sfctx) {
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	sfctx->fs_info = fs_info;
+	sfctx->readonly = readonly;
+	atomic_set(&sfctx->bios_under_io, 0);
+	return sfctx;
+error:
+	kfree(sfctx);
+	return ERR_PTR(ret);
+}
+
+static int scrub_fs_iterate_bgs(struct scrub_fs_ctx *sfctx, u64 start, u64 end)
+{
+	struct btrfs_fs_info *fs_info = sfctx->fs_info;
+	u64 cur = start;
+	int ret;
+
+	while (cur < end) {
+		struct btrfs_block_group *bg;
+		bool ro_set = false;
+
+		bg = btrfs_lookup_first_block_group(fs_info, cur);
+		if (!bg)
+			break;
+		if (bg->start + bg->length >= end) {
+			btrfs_put_block_group(bg);
+			break;
+		}
+		spin_lock(&bg->lock);
+
+		/* Already deleted bg, skip to the next one. */
+		if (test_bit(BLOCK_GROUP_FLAG_REMOVED, &bg->runtime_flags)) {
+			spin_unlock(&bg->lock);
+			cur = bg->start + bg->length;
+			btrfs_put_block_group(bg);
+			continue;
+		}
+		btrfs_freeze_block_group(bg);
+		spin_unlock(&bg->lock);
+
+		/*
+		 * we need call btrfs_inc_block_group_ro() with scrubs_paused,
+		 * to avoid deadlock caused by:
+		 * btrfs_inc_block_group_ro()
+		 * -> btrfs_wait_for_commit()
+		 * -> btrfs_commit_transaction()
+		 * -> btrfs_scrub_pause()
+		 */
+		scrub_pause_on(fs_info);
+
+		/*
+		 * Check the comments before btrfs_inc_block_group_ro() inside
+		 * scrub_enumerate_chunks() for reasons.
+		 */
+		ret = btrfs_inc_block_group_ro(bg, false);
+		if (ret == 0)
+			ro_set = true;
+		if (ret == -ETXTBSY) {
+			btrfs_warn(fs_info,
+		   "skipping scrub of block group %llu due to active swapfile",
+				   bg->start);
+			scrub_pause_off(fs_info);
+			ret = 0;
+			goto next;
+		}
+		if (ret < 0 && ret != -ENOSPC) {
+			btrfs_warn(fs_info,
+				   "failed setting block group ro: %d", ret);
+			scrub_pause_off(fs_info);
+			goto next;
+		}
+
+		scrub_pause_off(fs_info);
+
+		/* Place holder for the real chunk scrubbing code. */
+		ret = 0;
+
+		if (ro_set)
+			btrfs_dec_block_group_ro(bg);
+
+		/*
+		 * We might have prevented the cleaner kthread from deleting
+		 * this block group if it was already unused because we raced
+		 * and set it to RO mode first. So add it back to the unused
+		 * list, otherwise it might not ever be deleted unless a manual
+		 * balance is triggered or it becomes used and unused again.
+		 */
+		spin_lock(&bg->lock);
+		if (!test_bit(BLOCK_GROUP_FLAG_REMOVED, &bg->runtime_flags) &&
+		    !bg->ro && bg->reserved == 0 && bg->used == 0) {
+			spin_unlock(&bg->lock);
+			if (btrfs_test_opt(fs_info, DISCARD_ASYNC))
+				btrfs_discard_queue_work(&fs_info->discard_ctl,
+							 bg);
+			else
+				btrfs_mark_bg_unused(bg);
+		} else {
+			spin_unlock(&bg->lock);
+		}
+next:
+		cur = bg->start + bg->length;
+
+		btrfs_unfreeze_block_group(bg);
+		btrfs_put_block_group(bg);
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
 /*
  * Unlike btrfs_scrub_dev(), this function works completely in logical bytenr
  * level, and has the following advantage:
@@ -4474,6 +4612,8 @@ int btrfs_scrub_fs(struct btrfs_fs_info *fs_info, u64 start, u64 end,
 		   struct btrfs_scrub_fs_progress *progress,
 		   bool readonly)
 {
+	struct scrub_fs_ctx *sfctx;
+	unsigned int nofs_flag;
 	int ret;
 
 	if (btrfs_fs_closing(fs_info))
@@ -4510,8 +4650,25 @@ int btrfs_scrub_fs(struct btrfs_fs_info *fs_info, u64 start, u64 end,
 	btrfs_info(fs_info, "scrub_fs: started");
 	mutex_unlock(&fs_info->scrub_lock);
 
-	/* Place holder for real workload. */
-	ret = -EOPNOTSUPP;
+	sfctx = scrub_fs_alloc_ctx(fs_info, readonly);
+	if (IS_ERR(sfctx)) {
+		ret = PTR_ERR(sfctx);
+		sfctx = NULL;
+		goto out;
+	}
+
+	if (progress)
+		memcpy(&sfctx->stat, progress, sizeof(*progress));
+
+	/*
+	 * Check the comments before memalloc_nofs_save() in btrfs_scrub_dev()
+	 * for reasons.
+	 */
+	nofs_flag = memalloc_nofs_save();
+	ret = scrub_fs_iterate_bgs(sfctx, start, end);
+	memalloc_nofs_restore(nofs_flag);
+out:
+	kfree(sfctx);
 
 	mutex_lock(&fs_info->scrub_lock);
 	atomic_dec(&fs_info->scrubs_running);
@@ -4520,6 +4677,9 @@ int btrfs_scrub_fs(struct btrfs_fs_info *fs_info, u64 start, u64 end,
 	mutex_unlock(&fs_info->scrub_lock);
 	wake_up(&fs_info->scrub_pause_wait);
 
+	if (progress)
+		memcpy(progress, &sfctx->stat, sizeof(*progress));
+
 	return ret;
 }
 
-- 
2.37.3

