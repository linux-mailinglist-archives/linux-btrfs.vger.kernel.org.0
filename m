Return-Path: <linux-btrfs+bounces-15081-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61489AED3D7
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 07:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3CCD7A8FC5
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 05:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451B51E51FB;
	Mon, 30 Jun 2025 05:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SVHI8s+v";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SVHI8s+v"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBF51DE3BA
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 05:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751261412; cv=none; b=OcOHneCrjSdZEmbw6+fy0xZLJYluX7Y4ay2Xkr+oAp/7/cksxPprdHoejpmblrnHYYdwEdjW+nZB0yvV7UWUs9pdT2hgcplIwBldnGSSziyVaVILEFEgkq5uQP9QqWS/zPYCU4+YIU7QmycplqAXfqKLQtZ7aRAhjrESTLHJIYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751261412; c=relaxed/simple;
	bh=7iKwxv8DhUv4OAdsIFkEe0tkjIrj/1YpgILXoM/wLa4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MswcFaSLnt+p2sybTxtOby0VT0TK2yNJAkR12L3MnvMGWoCDyDZ4Ln1n3GqHjPDckXMBvfbPRNEZJyStgDm8/FKRaR94nw7r9Lgix69TBKX/aRt4vMIgDikzXUNatLpTXUv/bGMPi4uOGJQ3fot99mw7J6X8Jv1bVVEyJ1PNwCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SVHI8s+v; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SVHI8s+v; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CD4AC21165
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 05:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751261379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ckBL+X3B46jFDR3zCJSqUzRGeDY8YxnlCdCzXUrN9zI=;
	b=SVHI8s+vmib0nNXXxJOlyvKVmedeTllepWi3Q9fZXXKLbVIsgj5+JtbOAOjHR59B6BYWWg
	ZoRoBRCxDdmpYxUM1L/bY+u5IArRqhZK3bW4uLt0h2HvVn8gkesRU8xUXOfEOxXaFsUYx7
	P1egCB7BR28WvENjh1MveWd9lgpKa+o=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751261379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ckBL+X3B46jFDR3zCJSqUzRGeDY8YxnlCdCzXUrN9zI=;
	b=SVHI8s+vmib0nNXXxJOlyvKVmedeTllepWi3Q9fZXXKLbVIsgj5+JtbOAOjHR59B6BYWWg
	ZoRoBRCxDdmpYxUM1L/bY+u5IArRqhZK3bW4uLt0h2HvVn8gkesRU8xUXOfEOxXaFsUYx7
	P1egCB7BR28WvENjh1MveWd9lgpKa+o=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 087DC139D4
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 05:29:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CLhSLsIgYmi4SAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 05:29:38 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v6 5/8] btrfs: call bdev_fput() to reclaim the blk_holder immediately
Date: Mon, 30 Jun 2025 14:59:09 +0930
Message-ID: <1226b19a41622a2f5725a5ffc9285b83e0d72544.1751261286.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751261286.git.wqu@suse.com>
References: <cover.1751261286.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.968];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
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
X-Spam-Score: -2.79

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
index bd2761799181..473450ee0408 100644
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
index 5068f1fa86f6..65763bc6a0f6 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2699,7 +2699,7 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
 err_drop:
 	mnt_drop_write_file(file);
 	if (bdev_file)
-		fput(bdev_file);
+		bdev_fput(bdev_file);
 out:
 	btrfs_put_dev_args_from_path(&args);
 	kfree(vol_args);
@@ -2750,7 +2750,7 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
 
 	mnt_drop_write_file(file);
 	if (bdev_file)
-		fput(bdev_file);
+		bdev_fput(bdev_file);
 out:
 	btrfs_put_dev_args_from_path(&args);
 out_free:
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index bb63729770d9..f51c81c1682c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -489,7 +489,7 @@ btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
 	if (holder) {
 		ret = set_blocksize(*bdev_file, BTRFS_BDEV_BLOCKSIZE);
 		if (ret) {
-			fput(*bdev_file);
+			bdev_fput(*bdev_file);
 			goto error;
 		}
 	}
@@ -497,7 +497,7 @@ btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
 	*disk_super = btrfs_read_disk_super(bdev, 0, false);
 	if (IS_ERR(*disk_super)) {
 		ret = PTR_ERR(*disk_super);
-		fput(*bdev_file);
+		bdev_fput(*bdev_file);
 		goto error;
 	}
 
@@ -721,7 +721,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 
 error_free_page:
 	btrfs_release_disk_super(disk_super);
-	fput(bdev_file);
+	bdev_fput(bdev_file);
 
 	return -EINVAL;
 }
@@ -1071,7 +1071,7 @@ static void __btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices,
 			continue;
 
 		if (device->bdev_file) {
-			fput(device->bdev_file);
+			bdev_fput(device->bdev_file);
 			device->bdev = NULL;
 			device->bdev_file = NULL;
 			fs_devices->open_devices--;
@@ -1118,7 +1118,7 @@ static void btrfs_close_bdev(struct btrfs_device *device)
 		invalidate_bdev(device->bdev);
 	}
 
-	fput(device->bdev_file);
+	bdev_fput(device->bdev_file);
 }
 
 static void btrfs_close_one_device(struct btrfs_device *device)
@@ -1491,7 +1491,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path,
 	btrfs_release_disk_super(disk_super);
 
 error_bdev_put:
-	fput(bdev_file);
+	bdev_fput(bdev_file);
 
 	return device;
 }
@@ -2295,7 +2295,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 	 * free the device.
 	 *
 	 * We cannot call btrfs_close_bdev() here because we're holding the sb
-	 * write lock, and fput() on the block device will pull in the
+	 * write lock, and bdev_fput() on the block device will pull in the
 	 * ->open_mutex on the block device and it's dependencies.  Instead
 	 *  just flush the device and let the caller do the final bdev_release.
 	 */
@@ -2474,7 +2474,7 @@ int btrfs_get_dev_args_from_path(struct btrfs_fs_info *fs_info,
 	else
 		memcpy(args->fsid, disk_super->fsid, BTRFS_FSID_SIZE);
 	btrfs_release_disk_super(disk_super);
-	fput(bdev_file);
+	bdev_fput(bdev_file);
 	return 0;
 }
 
@@ -2922,7 +2922,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 error_free_device:
 	btrfs_free_device(device);
 error:
-	fput(bdev_file);
+	bdev_fput(bdev_file);
 	if (locked) {
 		mutex_unlock(&uuid_mutex);
 		up_write(&sb->s_umount);
-- 
2.50.0


