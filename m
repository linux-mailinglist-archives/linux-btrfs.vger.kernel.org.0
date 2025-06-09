Return-Path: <linux-btrfs+bounces-14554-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E39AD1842
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 07:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FEFE3A8165
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 05:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B10427FD4F;
	Mon,  9 Jun 2025 05:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="txXAA8Kx";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="txXAA8Kx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0B81E3DE8
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Jun 2025 05:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749446426; cv=none; b=CEL/PpZsvj38Jto6JMS+3l3++jtGz75fxztAEQQpsfXr1+U4Vg/C6qo5/4t9/JsBgXGdzAacRCWmKWeGXv8o+gZfFEle+C3lgnDJK9WNrfa9cZo8uvKlYqpali53bmMRb1LhOZwIPKl5W+Vjwsm7rJYy2JENl7hbDuINb3dOQW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749446426; c=relaxed/simple;
	bh=HWPuGvwHeS5LOuWVmI0CWK51nQ4dgG78rK/h8K77WV4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WoBnYTjTFPJBj+RJ5l2AJx821F9aH71ZZSSB5YRLcJC8W/EuZi+aWHbwOPUrsCdavkh8pNRrK8rVTJdg6drQ/j7wxilPkb2geW11O/LKIeqpAYB8eR5Clh5WN3Hq9pCHQ6N4kV140jDbeUNkwJhyVeB1nUZd90uhg3/ZfTNkT/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=txXAA8Kx; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=txXAA8Kx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 155FF1F38D
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Jun 2025 05:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749446411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x74sMd3m4MJGgF0edVuDUpCJdc//YnF7SP/mOIYROI8=;
	b=txXAA8KxPJOCiSsRHyqsUd+lpTjDwUUPCqA64z4kunHC165ASvPTOPU6K60mt75ZaBzvvP
	etCpagbEZnVbSPkSVQac0afbfBscXZ+3cA1xN44qQXHtlMRKZFyAJ2UOkdNMvhCmFk1EBi
	aCDPq7WnGocY4jsCfrpzuQMFmksauWU=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749446411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x74sMd3m4MJGgF0edVuDUpCJdc//YnF7SP/mOIYROI8=;
	b=txXAA8KxPJOCiSsRHyqsUd+lpTjDwUUPCqA64z4kunHC165ASvPTOPU6K60mt75ZaBzvvP
	etCpagbEZnVbSPkSVQac0afbfBscXZ+3cA1xN44qQXHtlMRKZFyAJ2UOkdNMvhCmFk1EBi
	aCDPq7WnGocY4jsCfrpzuQMFmksauWU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 50B08137FE
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Jun 2025 05:20:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sCIPBQpvRmjqVQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 09 Jun 2025 05:20:10 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/4] btrfs: replace fput() with bdev_fput() for block devices
Date: Mon,  9 Jun 2025 14:49:48 +0930
Message-ID: <eaf6ba3672a82ba940678d269ab16f8a702eaf32.1749446257.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749446257.git.wqu@suse.com>
References: <cover.1749446257.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
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
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

The function fput() will defer the reclaim of a block devices' holder
into a workqueue.

This means even if btrfs has closed a block device, certain call backs
on that block device can still grab the out-of-date holder values.

Thankfully it's not a big deal because btrfs doesn't support any
blk_holder_ops callbacks, thus there is no real holder usage, but the
situation will soon change.

For the future blk_holder_ops call backs, we need to ensure that the
holder value in a btrfs block device is always valid as long as btrfs is
still holding it.

So instead of relying on the deferred reclaim, call bdev_fput() to
immediately reclaim the holder.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/dev-replace.c |  2 +-
 fs/btrfs/ioctl.c       |  4 ++--
 fs/btrfs/volumes.c     | 18 +++++++++---------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index cf63f4b29327..42d795156397 100644
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
index dae946ee6b07..d17d898fd12b 100644
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
@@ -1490,7 +1490,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
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


