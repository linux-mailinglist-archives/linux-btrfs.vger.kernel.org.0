Return-Path: <linux-btrfs+bounces-14703-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 607D4ADC180
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 07:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832EB188ED90
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 05:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1366A23B627;
	Tue, 17 Jun 2025 05:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KpINuSXM";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vGb985zn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7441BC2D1
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 05:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750137622; cv=none; b=k3qNiHadQZi4Q1vpvhLd5pVNlzWlPQBymhzE6MZ+pzsqeyrnwwb75axmq7PQIIbSUDLF1bEPBJ7BULH5n/kdZqafHpeRNQXhztoTjkaAXtr6OkTm4Jt9ZAKLeeVwnu09iTm+xlhJrkVM0gJHKTBKxDjIWAAEYcbA/kKVS6S2PRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750137622; c=relaxed/simple;
	bh=xsmF6+431Maeo1nlesBf0GOA9FZJqekYe/4m6lvJgqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ivYbLLuxCbj4w7iK7cIsPBt/pza0RVE69mJd2MjqrBumYJeMmKTGkr53LwS9RGe8NWsxRjkjzZLmJF/m+zjOcMhY1nV49X9icJM5NU4uU1TCS9BdF5HAno3+332WQK6Bt6Be3QAiKXWOl/3AW3qF0QxtXA7di8UXq3XaNGr8WNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KpINuSXM; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=vGb985zn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A19BB211F8;
	Tue, 17 Jun 2025 05:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750137608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q5778LEWjGTGpfTuraPvqsw5lLEc234poOqluGEbXM4=;
	b=KpINuSXMNogixtPOIjFU//zAmWTRNBwTifjWI7/n36wM/WHGd8zIHBAbnQteVPqhLJa6Qm
	N2kFwkMXQXQ+CfAowWVMOhLo0UET4DMbT/+jrVodPDDUI5Nrwb/TB3yxpKDCTQhYWcV//k
	i8Hw25QyNem2I1TczAj+roIAjnN4Z/g=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750137606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q5778LEWjGTGpfTuraPvqsw5lLEc234poOqluGEbXM4=;
	b=vGb985znO5xznm0DBhKe14DpmFieyRQ8Bli18PY6N1sLFGB7eWkDORfdSVUu4z39WJXojA
	vN7eLqFh2biYwVNM8MbgW1T7BzwMmmQbWrPUHS+bcw7T0I26rI8iY++YI3MdljQK6cmjqt
	kx13AfBXOOegGwS2nrU8PzIr/Qm9XrE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6563A139E2;
	Tue, 17 Jun 2025 05:20:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4AsyCgX7UGgePwAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 17 Jun 2025 05:20:05 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 3/6] btrfs: call btrfs_close_devices from ->kill_sb
Date: Tue, 17 Jun 2025 14:49:36 +0930
Message-ID: <b9f99472e5388fdae1da21976a32ea720606ad73.1750137547.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750137547.git.wqu@suse.com>
References: <cover.1750137547.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 

From: Christoph Hellwig <hch@lst.de>

Although btrfs is not yet implementing blk_holder_ops yet, there is a
requirement for a proper blk_holder_ops:

- blkdev_put() must not be called under sb->s_umount
  The blkdev_put()/bdev_fput() must not be called under sb->s_umount to
  avoid lock order reversal with disk->open_mutex.
  This is for the proper blk_holder_ops callbacks.

  Currently we're fine because we call regular fput() which defers the
  blk holder reclaiming.

To prepare for the future of blk_holder_ops, move the
btrfs_close_devices() calls into btrfs_free_fs_info().

That will be called from kill_sb() callbacks, which is also called for
error handing during mount failures, or there is already an existing
super block.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c |  4 ++--
 fs/btrfs/super.c   | 28 +++++++++-------------------
 2 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0d6ad7512f21..a9689cb98a90 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1246,6 +1246,8 @@ void btrfs_free_fs_info(struct btrfs_fs_info *fs_info)
 {
 	struct percpu_counter *em_counter = &fs_info->evictable_extent_maps;
 
+	if (fs_info->fs_devices)
+		btrfs_close_devices(fs_info->fs_devices);
 	percpu_counter_destroy(&fs_info->stats_read_blocks);
 	percpu_counter_destroy(&fs_info->dirty_metadata_bytes);
 	percpu_counter_destroy(&fs_info->delalloc_bytes);
@@ -3681,7 +3683,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 
 	iput(fs_info->btree_inode);
 fail:
-	btrfs_close_devices(fs_info->fs_devices);
 	ASSERT(ret < 0);
 	return ret;
 }
@@ -4428,7 +4429,6 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	iput(fs_info->btree_inode);
 
 	btrfs_mapping_tree_free(fs_info);
-	btrfs_close_devices(fs_info->fs_devices);
 }
 
 void btrfs_mark_buffer_dirty(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index c5c3ad40d07e..41c824d216fc 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1869,18 +1869,14 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 	if (ret)
 		return ret;
 
-	if (!(fc->sb_flags & SB_RDONLY) && fs_devices->rw_devices == 0) {
-		ret = -EACCES;
-		goto error;
-	}
+	if (!(fc->sb_flags & SB_RDONLY) && fs_devices->rw_devices == 0)
+		return -EACCES;
 
 	bdev = fs_devices->latest_dev->bdev;
 
 	sb = sget_fc(fc, btrfs_fc_test_super, set_anon_super_fc);
-	if (IS_ERR(sb)) {
-		ret = PTR_ERR(sb);
-		goto error;
-	}
+	if (IS_ERR(sb))
+		return PTR_ERR(sb);
 
 	set_device_specific_options(fs_info);
 
@@ -1889,17 +1885,15 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 		 * Not the first mount of the fs thus got an existing super block.
 		 *
 		 * Will reuse the returned super block, fs_info and fs_devices.
-		 */
-		ASSERT(fc->s_fs_info == fs_info);
-
-		/*
+		 *
 		 * fc->s_fs_info is not touched and will be later freed by
 		 * put_fs_context() through btrfs_free_fs_context().
 		 * 
-		 * But we have opened fs_devices at the beginning of the
-		 * function, thus still need to close them manually.
+		 * And the fs_info->fs_devices will also be closed by
+		 * btrfs_free_fs_context().
 		 */
-		btrfs_close_devices(fs_devices);
+		ASSERT(fc->s_fs_info == fs_info);
+
 		/*
 		 * At this stage we may have RO flag mismatch between
 		 * fc->sb_flags and sb->s_flags.  Caller should detect such
@@ -1928,10 +1922,6 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 
 	fc->root = dget(sb->s_root);
 	return 0;
-
-error:
-	btrfs_close_devices(fs_devices);
-	return ret;
 }
 
 /*
-- 
2.49.0


