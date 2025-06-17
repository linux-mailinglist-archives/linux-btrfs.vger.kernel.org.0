Return-Path: <linux-btrfs+bounces-14702-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E5BADC17F
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 07:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B03D3175EAA
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 05:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C787823B614;
	Tue, 17 Jun 2025 05:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="V7maqiOH";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="V7maqiOH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042AB1DE8AD
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 05:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750137617; cv=none; b=eazKac3K4wPOpcgUUIdbBHHtwDUt1gWPlW7pbgvglZ4OB38O6eE1pRKlRLo86ttl02bZU5ZMNzQDT8yxYX1JNcC6V7yWII7syn49Sdm68QlT21N9Mv93LlZfalfiAiOx8RovU0/v1K3FtQAojto/o61CmSb9Q2ZCUw3ROVAM5Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750137617; c=relaxed/simple;
	bh=kcwzyIrBzH4CxWCTnY52gaiSZxzA47D5pB6TmoHlVps=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B8J45Jxv2LIbifEtQUHRRmXXcNmwGoxVb5H7d7ATC72Aj7SumqW/EWPztQjs5labbhBOKIryIs9yoI4tYA2JUnfATji8Dl38uQ4Vu4DV4OrOfqhd0PAKK9qfPQAXoUKOP4bbdiauSpWfB3lRIJPF5Q55wnWK9jO6y7Qpa9BabRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=V7maqiOH; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=V7maqiOH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D76771F38C
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 05:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750137607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5rt/2OI9FZ7EatOR0YFI3vQ5o/RMMNc5sY9MAKlMk8=;
	b=V7maqiOHR1Vh+6ibBGqXD8x8GVP6CgkYoNZHpYBbjNxyaFCaI8p7rPBg1vMm6xS32m2xit
	F4Ce45cxd4qbecVeY8Kf/OVmouAJl0VPPnc0Ov6kAURkCVA+v2djrqSN8xc9TybEk2tOsb
	X0RePvmu9S4owl9D0yVHwpGz9lYMko8=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=V7maqiOH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750137607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5rt/2OI9FZ7EatOR0YFI3vQ5o/RMMNc5sY9MAKlMk8=;
	b=V7maqiOHR1Vh+6ibBGqXD8x8GVP6CgkYoNZHpYBbjNxyaFCaI8p7rPBg1vMm6xS32m2xit
	F4Ce45cxd4qbecVeY8Kf/OVmouAJl0VPPnc0Ov6kAURkCVA+v2djrqSN8xc9TybEk2tOsb
	X0RePvmu9S4owl9D0yVHwpGz9lYMko8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F9C413A69
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 05:20:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gHnHNAb7UGgePwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 05:20:06 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 4/6] btrfs: call bdev_fput() to reclaim the blk_holder immediately
Date: Tue, 17 Jun 2025 14:49:37 +0930
Message-ID: <d6e8ebc1af59cd37556a2923548791f964926566.1750137547.git.wqu@suse.com>
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
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:mid,suse.com:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: D76771F38C
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


