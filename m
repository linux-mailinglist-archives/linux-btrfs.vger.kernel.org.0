Return-Path: <linux-btrfs+bounces-12123-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F0BA58B95
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 06:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 191BB3AB403
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 05:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807211B87D1;
	Mon, 10 Mar 2025 05:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZJPl28sP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZJPl28sP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1594F2F28
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 05:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741583726; cv=none; b=eM5yp4iv8zafV4GazIDzJFgU1A5y/I11X5hoYjDI+3rqDZzL0tAB2wcNv9WUnn235gSyXu4CUWyCLp1Qcm9RqxJwjGpGlNYgzqunkO9LNuNQJsGj2S8UydO4W4aB7G+/dOCIchUgNLe+7GwSlca596Yuby120X5exmHyOUWqKFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741583726; c=relaxed/simple;
	bh=wCwXYh8ZIYnbTWC6tUaDby+Zfwe0jSEA3tUfccxz5SE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mwfkdMWS6BbFXYMrrmJRSS/XM0El0LyPA8tYtuu3DxdByHtU4hlxn6HR1CEilAirZ7yVu/4DeyFb3up61m0XagUtWfL5aEkdDcKmI0GDRkGxcHzy0gwMW802zClGgbyPRBCjPwIoreETZk1wNOJNe2SOcHb4k08cvbyGxo0mqCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZJPl28sP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZJPl28sP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9491C1F444
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 05:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741583716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nOMo5LX7/LjYLxYrsrab3rDtMmdQxPGiFEjUJ92v2xw=;
	b=ZJPl28sPtnvVRSRTwmF/nbY797fxcd6soyPTypN2q0FVhy6XsIIDUinoRG8/RFBqiPRYAC
	PMPyLcOigpmrN5UnGjzw+rbqs3MS47fi8Nzo/PcUsdulHmlzw5qojVHjFUPGpKbgCvvPQV
	jUG0JqM8m/1YiMdjcbVsL6RLCbLlKeQ=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741583716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nOMo5LX7/LjYLxYrsrab3rDtMmdQxPGiFEjUJ92v2xw=;
	b=ZJPl28sPtnvVRSRTwmF/nbY797fxcd6soyPTypN2q0FVhy6XsIIDUinoRG8/RFBqiPRYAC
	PMPyLcOigpmrN5UnGjzw+rbqs3MS47fi8Nzo/PcUsdulHmlzw5qojVHjFUPGpKbgCvvPQV
	jUG0JqM8m/1YiMdjcbVsL6RLCbLlKeQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76F6713AF2
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 05:15:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8KcCCGN1zmf8CwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 05:15:15 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: add extra warning if delayed iput is added when it's not allowed
Date: Mon, 10 Mar 2025 15:44:56 +1030
Message-ID: <65dce6b59ca3aa2bcd2e492271dcc3faa6f0a9ad.1741583506.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Since I have triggered the ASSERT() on the delayed iput too many times,
now is the time to add some extra debug warnings for delayed iput.

All delayed iputs should be queued after all ordered extents finish
their IO and all involved workqueues are flushed.

Thus after the btrfs_run_delayed_iputs() inside close_ctree(), there
should be no more delayed puts added.

So introduce a new BTRFS_FS_STATE_NO_DELAYED_IPUT, set after the above
mentioned timing.
And all btrfs_add_delayed_iput() will check that flag and give a
WARN_ON_ONCE() for debug builds.

And since we're here, remove the btrfs_run_delayed_iputs() call inside
btrfs_error_commit_super().
As that function will only wait for ordered extents to finish their IO,
delayed iputs will only be added when those ordered extents all finished
and removed from io tree, this is only ensured after the workqueue
flush.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Set the new flag early
- Make the new flag unconditional except the WARN_ON_ONCE() check
- Remove the btrfs_run_delayed_iputs() inside btrfs_error_commit_super()
---
 fs/btrfs/disk-io.c | 6 ++----
 fs/btrfs/fs.h      | 3 +++
 fs/btrfs/inode.c   | 4 ++++
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 671f11787f34..466d9c434030 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4384,6 +4384,8 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	/* Ordered extents for free space inodes. */
 	btrfs_flush_workqueue(fs_info->endio_freespace_worker);
 	btrfs_run_delayed_iputs(fs_info);
+	/* There should be no more workload to generate new delayed iputs. */
+	set_bit(BTRFS_FS_STATE_NO_DELAYED_IPUT, &fs_info->fs_state);
 
 	cancel_work_sync(&fs_info->async_reclaim_work);
 	cancel_work_sync(&fs_info->async_data_reclaim_work);
@@ -4540,10 +4542,6 @@ static void btrfs_error_commit_super(struct btrfs_fs_info *fs_info)
 	/* cleanup FS via transaction */
 	btrfs_cleanup_transaction(fs_info);
 
-	mutex_lock(&fs_info->cleaner_mutex);
-	btrfs_run_delayed_iputs(fs_info);
-	mutex_unlock(&fs_info->cleaner_mutex);
-
 	down_write(&fs_info->cleanup_work_sem);
 	up_write(&fs_info->cleanup_work_sem);
 }
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index b8c2e59ffc43..3a9e0a4c54e5 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -117,6 +117,9 @@ enum {
 	/* Indicates there was an error cleaning up a log tree. */
 	BTRFS_FS_STATE_LOG_CLEANUP_ERROR,
 
+	/* No more delayed iput can be queued. */
+	BTRFS_FS_STATE_NO_DELAYED_IPUT,
+
 	BTRFS_FS_STATE_COUNT
 };
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8ac4858b70e7..d2bf81c08f13 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3435,6 +3435,10 @@ void btrfs_add_delayed_iput(struct btrfs_inode *inode)
 	if (atomic_add_unless(&inode->vfs_inode.i_count, -1, 1))
 		return;
 
+#ifdef CONFIG_BTRFS_DEBUG
+	WARN_ON_ONCE(test_bit(BTRFS_FS_STATE_NO_DELAYED_IPUT, &fs_info->fs_state));
+#endif
+
 	atomic_inc(&fs_info->nr_delayed_iputs);
 	/*
 	 * Need to be irq safe here because we can be called from either an irq
-- 
2.48.1


