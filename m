Return-Path: <linux-btrfs+bounces-14857-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6686DAE3D24
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 12:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BAF61883973
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 10:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2003235BEE;
	Mon, 23 Jun 2025 10:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="H40uk5HX";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="H40uk5HX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EF9239E97
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 10:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750675631; cv=none; b=kXlRCry2OMN7K/rljariKq14RxJO5u+5KMhf7Dp7L1whGER2Nqp4c9zsynZyYcDHTgKOk5hvWm2cUesAMnf8w6nuXidQv1mo87Tjd6XBqs9Vjq093CEAgJ2i1LBEi/b7YWYw855EMMU7oCh71ECEPk1r9oxbEl1ehEq2P6KwGPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750675631; c=relaxed/simple;
	bh=kcwzyIrBzH4CxWCTnY52gaiSZxzA47D5pB6TmoHlVps=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W14BqoNjmoEpKROQoqpELEWAehy3WfqNWdNJ2Cn0mx3Nu32Q232iCeiFbTivYFzvhh49vD85EyX6FPb18MJIbMok911EOZlHkDMv19aTlB5ut+fVPAeTCxFWrb0ySxhv12QohqWwUS18wK2RxTXuO1VcBbPr28ddT7DziT56lCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=H40uk5HX; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=H40uk5HX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6100A1F441
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 10:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750675623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5rt/2OI9FZ7EatOR0YFI3vQ5o/RMMNc5sY9MAKlMk8=;
	b=H40uk5HXCuD+dvNlPJKx3YSZWQVSAfBy5D9DXaVkzTNaKdFgPdl4LGWxks31+t6Mgcy1P9
	eF+VWuQ9f9MMJaszmz1gFEUKSJLxjJjYTEoVU4czA/ebT4L0tQyK5yOjGj2Y6IQXIZKUgQ
	3/hnNOoT80F8RNxIeyxGnOGEsX28rpc=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=H40uk5HX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750675623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5rt/2OI9FZ7EatOR0YFI3vQ5o/RMMNc5sY9MAKlMk8=;
	b=H40uk5HXCuD+dvNlPJKx3YSZWQVSAfBy5D9DXaVkzTNaKdFgPdl4LGWxks31+t6Mgcy1P9
	eF+VWuQ9f9MMJaszmz1gFEUKSJLxjJjYTEoVU4czA/ebT4L0tQyK5yOjGj2Y6IQXIZKUgQ
	3/hnNOoT80F8RNxIeyxGnOGEsX28rpc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0DAB13485
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 10:47:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yLMQGaYwWWgeJAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 10:47:02 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v4 5/8] btrfs: call bdev_fput() to reclaim the blk_holder immediately
Date: Mon, 23 Jun 2025 20:16:49 +0930
Message-ID: <d6e8ebc1af59cd37556a2923548791f964926566.1750674924.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750674924.git.wqu@suse.com>
References: <cover.1750674924.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:mid,suse.com:email];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:mid,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 6100A1F441
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.01

As part of the preparation for btrfs blk_holder_ops, we want to ensure
the holder of a block device has a proper lifespan.

However btrfs is always using fput() to close a block device, which has
one problem:

- fput() is deferred
  Meaning we can have a block device with invalid (aka, freed) holder.

To avoid the problem, and align the behavior to all the existing codes,
just call bdev_fput() instead.

There is some extra requirement on the locking, but that's all resolved
by previous patches and we should be safe to call bdev_fput().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/dev-replace.c |  2 +-
 fs/btrfs/ioctl.c       |  4 ++--
 fs/btrfs/volumes.c     | 18 +++++++++---------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 2decb9fff445..6576867cc1e9 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -327,7 +327,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 	return 0;
 
 error:
-	fput(bdev_file);
+	bdev_fput(bdev_file);
 	return ret;
 }
 
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 4eda35bdba71..608a63f07e6b 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2700,7 +2700,7 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
 err_drop:
 	mnt_drop_write_file(file);
 	if (bdev_file)
-		fput(bdev_file);
+		bdev_fput(bdev_file);
 out:
 	btrfs_put_dev_args_from_path(&args);
 	kfree(vol_args);
@@ -2751,7 +2751,7 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
 
 	mnt_drop_write_file(file);
 	if (bdev_file)
-		fput(bdev_file);
+		bdev_fput(bdev_file);
 out:
 	btrfs_put_dev_args_from_path(&args);
 out_free:
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1ebfc69012a2..3e701790dde9 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -488,7 +488,7 @@ btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
 	if (holder) {
 		ret = set_blocksize(*bdev_file, BTRFS_BDEV_BLOCKSIZE);
 		if (ret) {
-			fput(*bdev_file);
+			bdev_fput(*bdev_file);
 			goto error;
 		}
 	}
@@ -496,7 +496,7 @@ btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
 	*disk_super = btrfs_read_disk_super(bdev, 0, false);
 	if (IS_ERR(*disk_super)) {
 		ret = PTR_ERR(*disk_super);
-		fput(*bdev_file);
+		bdev_fput(*bdev_file);
 		goto error;
 	}
 
@@ -720,7 +720,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 
 error_free_page:
 	btrfs_release_disk_super(disk_super);
-	fput(bdev_file);
+	bdev_fput(bdev_file);
 
 	return -EINVAL;
 }
@@ -1070,7 +1070,7 @@ static void __btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices,
 			continue;
 
 		if (device->bdev_file) {
-			fput(device->bdev_file);
+			bdev_fput(device->bdev_file);
 			device->bdev = NULL;
 			device->bdev_file = NULL;
 			fs_devices->open_devices--;
@@ -1117,7 +1117,7 @@ static void btrfs_close_bdev(struct btrfs_device *device)
 		invalidate_bdev(device->bdev);
 	}
 
-	fput(device->bdev_file);
+	bdev_fput(device->bdev_file);
 }
 
 static void btrfs_close_one_device(struct btrfs_device *device)
@@ -1490,7 +1490,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path,
 	btrfs_release_disk_super(disk_super);
 
 error_bdev_put:
-	fput(bdev_file);
+	bdev_fput(bdev_file);
 
 	return device;
 }
@@ -2294,7 +2294,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 	 * free the device.
 	 *
 	 * We cannot call btrfs_close_bdev() here because we're holding the sb
-	 * write lock, and fput() on the block device will pull in the
+	 * write lock, and bdev_fput() on the block device will pull in the
 	 * ->open_mutex on the block device and it's dependencies.  Instead
 	 *  just flush the device and let the caller do the final bdev_release.
 	 */
@@ -2473,7 +2473,7 @@ int btrfs_get_dev_args_from_path(struct btrfs_fs_info *fs_info,
 	else
 		memcpy(args->fsid, disk_super->fsid, BTRFS_FSID_SIZE);
 	btrfs_release_disk_super(disk_super);
-	fput(bdev_file);
+	bdev_fput(bdev_file);
 	return 0;
 }
 
@@ -2921,7 +2921,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 error_free_device:
 	btrfs_free_device(device);
 error:
-	fput(bdev_file);
+	bdev_fput(bdev_file);
 	if (locked) {
 		mutex_unlock(&uuid_mutex);
 		up_write(&sb->s_umount);
-- 
2.49.0


