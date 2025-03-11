Return-Path: <linux-btrfs+bounces-12176-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E166A5B723
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 04:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD9CC7A6BD5
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 03:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB45D1E98ED;
	Tue, 11 Mar 2025 03:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ngnT8Luy";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ngnT8Luy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B88566A
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 03:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741662624; cv=none; b=ufBVSVxVHjH6TWmKrvU5wRl6PJNDllJF+o9Ba+hpkoSEX2Qp7nZHZug+EBnWd3BC0ubXEVYii76liHo9LOsmzCjnbkLOvDuTX4VfktQf6xzLaDfQoYFRAaZUT0nFH6mONK87hlu3v8+iKHlNej8XQcPxtGYHBBaED4D0E0/Hoi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741662624; c=relaxed/simple;
	bh=BUYP2/avv2M+DgA4iS1mHyjQ3HzxG4q6/jaAyCTLWxE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DiIA/u4KQf5eoWcLjFkE0kjtRD6PzmncX+5r2skB7rZL8aCZtHJibH2gaxDT2DMuf7wvjBeUEwUvoQ8zs6bxbgj2L+91hADkPD/Fml9AAopErpaeXdx40317phHgFldQPcMl702uL/42R/gPzUnCX1Zv0fqKGNSIVDN9Cd02ZXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ngnT8Luy; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ngnT8Luy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DA4851F38A
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 03:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741662619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Djt9mpxhs2PRsxlJPoON0HILRK/1NQxXFfO8s7nSqD8=;
	b=ngnT8Luygr6r2y+IT+cvLrZ9jOXyYTRhKv6utzfMTQ76ozkzaYPmJBkURykGG5c8ZAB/V2
	3H8YaHgvh0/vcY8c17JX7A3g6gbmQu3pDWc6/Kj/AmMBWc84aY9UmCuf6g2Pl6D1hlouFl
	N1xFJA4tDlwyujHSD5wNQWhC5a79YZY=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741662619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Djt9mpxhs2PRsxlJPoON0HILRK/1NQxXFfO8s7nSqD8=;
	b=ngnT8Luygr6r2y+IT+cvLrZ9jOXyYTRhKv6utzfMTQ76ozkzaYPmJBkURykGG5c8ZAB/V2
	3H8YaHgvh0/vcY8c17JX7A3g6gbmQu3pDWc6/Kj/AmMBWc84aY9UmCuf6g2Pl6D1hlouFl
	N1xFJA4tDlwyujHSD5wNQWhC5a79YZY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC12A13874
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 03:10:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dPcOHZqpz2erCgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 03:10:18 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3] btrfs: add extra warning if delayed iput is added when it's not allowed
Date: Tue, 11 Mar 2025 13:39:56 +1030
Message-ID: <c9858984b0807f758c8f1f5f64c1ec95c78930b2.1741662594.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

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
v3:
- Rebased to the latest for-next
  Which has the removal of btrfs_run_delayed_iputs() from
  btrfs_error_commit_super() in the previous patch.

- Make the WARN_ON_ONCE() unconditional in btrfs_add_delayed_iput()

v2:
- Set the new flag early
- Make the new flag unconditional except the WARN_ON_ONCE() check
- Remove the btrfs_run_delayed_iputs() inside btrfs_error_commit_super()
---
 fs/btrfs/disk-io.c | 2 ++
 fs/btrfs/fs.h      | 3 +++
 fs/btrfs/inode.c   | 1 +
 3 files changed, 6 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0afd3c0f2fab..56e55f7a0f24 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4397,6 +4397,8 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	/* Ordered extents for free space inodes. */
 	btrfs_flush_workqueue(fs_info->endio_freespace_worker);
 	btrfs_run_delayed_iputs(fs_info);
+	/* There should be no more workload to generate new delayed iputs. */
+	set_bit(BTRFS_FS_STATE_NO_DELAYED_IPUT, &fs_info->fs_state);
 
 	cancel_work_sync(&fs_info->async_reclaim_work);
 	cancel_work_sync(&fs_info->async_data_reclaim_work);
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index c799dfba5ebd..5a346d4a4b91 100644
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
index e7e6accbaf6c..5c0a41c32dab 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3438,6 +3438,7 @@ void btrfs_add_delayed_iput(struct btrfs_inode *inode)
 	if (atomic_add_unless(&inode->vfs_inode.i_count, -1, 1))
 		return;
 
+	WARN_ON_ONCE(test_bit(BTRFS_FS_STATE_NO_DELAYED_IPUT, &fs_info->fs_state));
 	atomic_inc(&fs_info->nr_delayed_iputs);
 	/*
 	 * Need to be irq safe here because we can be called from either an irq
-- 
2.48.1


