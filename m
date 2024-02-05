Return-Path: <linux-btrfs+bounces-2116-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1309784A127
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 18:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9279E1F23BBD
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Feb 2024 17:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BF947F59;
	Mon,  5 Feb 2024 17:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ucQRWF0q";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ucQRWF0q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D0A44C6A;
	Mon,  5 Feb 2024 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707155063; cv=none; b=ZsenZ38PDrt6SBKEcQPODhdfvbUh9lQL+hYuLu1ovmQlj8lVPisfDGXuf7QCAKOCXFxySAkc2BbEP2lmDRRgiyLOR9KQnZNhDNtSolWRXovn9T1EH4lNoSwFE8HaaYj/AoZiqp4c/6ysIddFKLRRDNplDRZ3OFCbke5sHSiC63o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707155063; c=relaxed/simple;
	bh=VaYkPQonRrPJyGK9blIaGwDRF+zb6YXxXWeCmZ82wX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iQX2dizzu0guCBn69wmhvnoQoFkWKPmT9uUGlauoh0lA8rHZMqvFZ36jzBUc7fnEbABvlonhVNmDu7dviQZ2txwyfctJEjqSsFW90sfqJ1RUL0pBQnxUA9ARDLF0gXfMvmhXm3t2Ym1KhjUzcmxwN5bjhzni5m8zYbDI/dgRsiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ucQRWF0q; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ucQRWF0q; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BBE9621FD3;
	Mon,  5 Feb 2024 17:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707155058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3EIrfn5IRDZ12Upv2XPd1+741HecZVWlh/BTIH7rk2A=;
	b=ucQRWF0qbPwgDW5jmBygJFJ5ZhhE2MUdb0LYadoNRmCzE/NV6VqwcdM92xepvWFvw4i33A
	z8VPpnLHjKyZgcxHvKj3fk5/zybWFZY15p8u1Ku8jQ/nicrcqTyWvte7vU8/6nn+j1+hhR
	FmMx4j0ro9KsR1oaRWbKzaPaSiWaBR4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1707155058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3EIrfn5IRDZ12Upv2XPd1+741HecZVWlh/BTIH7rk2A=;
	b=ucQRWF0qbPwgDW5jmBygJFJ5ZhhE2MUdb0LYadoNRmCzE/NV6VqwcdM92xepvWFvw4i33A
	z8VPpnLHjKyZgcxHvKj3fk5/zybWFZY15p8u1Ku8jQ/nicrcqTyWvte7vU8/6nn+j1+hhR
	FmMx4j0ro9KsR1oaRWbKzaPaSiWaBR4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AADD0136F5;
	Mon,  5 Feb 2024 17:44:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ySGwKXIewWVEJAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 05 Feb 2024 17:44:18 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	stable@vger.kernel.org
Subject: [PATCH] btrfs: always scan a single device when mounted
Date: Mon,  5 Feb 2024 18:43:39 +0100
Message-ID: <20240205174340.30327-1-dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ucQRWF0q
X-Spamd-Result: default: False [-0.31 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.31
X-Rspamd-Queue-Id: BBE9621FD3
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

There are reports that since version 6.7 update-grub fails to find the
device of the root on systems without initrd and on a single device.

This looks like the device name changed in the output of
/proc/self/mountinfo:

6.5-rc5 working

  18 1 0:16 / / rw,noatime - btrfs /dev/sda8 ...

6.7 not working:

  17 1 0:15 / / rw,noatime - btrfs /dev/root ...

and "update-grub" shows this error:

  /usr/sbin/grub-probe: error: cannot find a device for / (is /dev mounted?)

This looks like it's related to the device name, but grub-probe
recognizes the "/dev/root" path and tries to find the underlying device.
However there's a special case for some filesystems, for btrfs in
particular.

The generic root device detection heuristic is not done and it all
relies on reading the device infos by a btrfs specific ioctl. This ioctl
returns the device name as it was saved at the time of device scan (in
this case it's /dev/root).

The change in 6.7 for temp_fsid to allow several single device
filesystem to exist with the same fsid (and transparently generate a new
UUID at mount time) was to skip caching/registering such devices.

This also skipped mounted device. One step of scanning is to check if
the device name hasn't changed, and if yes then update the cached value.

This broke the grub-probe as it always read the device /dev/root and
couldn't find it in the system. A temporary workaround is to create a
symlink but this does not survive reboot.

The right fix is to allow updating the device path of a mounted
filesystem even if this is a single device one. This does not affect the
temp_fsid feature, the UUID of the mounted filesystem remains the same
and the matching is based on device major:minor which is unique per
mounted filesystem.

As the main part of device scanning and list update is done in
device_list_add() that handles all corner cases and locking, it is
extended to take a parameter that tells it to do everything as before,
except adding a new device entry.

This covers the path when the device (that exists for all mounted
devices) name changes, updating /dev/root to /dev/sdx. Any other single
device with filesystem is skipped.

Note that if a system is booted and initial mount is done on the
/dev/root device, this will be the cached name of the device. Only after
the command "btrfs device rescan" it will change as it triggers the
rename.

The fix was verified by users whose systems were affected.

CC: stable@vger.kernel.org # 6.7+
Fixes: bc27d6f0aa0e ("btrfs: scan but don't register device on single device filesystem")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=218353
Link: https://lore.kernel.org/lkml/CAKLYgeJ1tUuqLcsquwuFqjDXPSJpEiokrWK2gisPKDZLs8Y2TQ@mail.gmail.com/
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/volumes.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 474ab7ed65ea..f2c2f7ca5c3d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -738,6 +738,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 	bool same_fsid_diff_dev = false;
 	bool has_metadata_uuid = (btrfs_super_incompat_flags(disk_super) &
 		BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
+	bool can_create_new = *new_device_added;
 
 	if (btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_CHANGING_FSID_V2) {
 		btrfs_err(NULL,
@@ -753,6 +754,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		return ERR_PTR(error);
 	}
 
+	*new_device_added = false;
 	fs_devices = find_fsid_by_device(disk_super, path_devt, &same_fsid_diff_dev);
 
 	if (!fs_devices) {
@@ -804,6 +806,15 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 			return ERR_PTR(-EBUSY);
 		}
 
+		if (!can_create_new) {
+			pr_info(
+	"BTRFS: device fsid %pU devid %llu transid %llu %s skip registration scanned by %s (%d)\n",
+				disk_super->fsid, devid, found_transid, path,
+				current->comm, task_pid_nr(current));
+			mutex_unlock(&fs_devices->device_list_mutex);
+			return NULL;
+		}
+
 		nofs_flag = memalloc_nofs_save();
 		device = btrfs_alloc_device(NULL, &devid,
 					    disk_super->dev_item.uuid, path);
@@ -1355,27 +1366,14 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 		goto error_bdev_put;
 	}
 
-	if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
-	    !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING)) {
-		dev_t devt;
-
-		ret = lookup_bdev(path, &devt);
-		if (ret)
-			btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
-				   path, ret);
-		else
-			btrfs_free_stale_devices(devt, NULL);
-
-		pr_debug("BTRFS: skip registering single non-seed device %s\n", path);
-		device = NULL;
-		goto free_disk_super;
-	}
+	if (mount_arg_dev || btrfs_super_num_devices(disk_super) != 1 ||
+	    (btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING))
+		new_device_added = true;
 
 	device = device_list_add(path, disk_super, &new_device_added);
 	if (!IS_ERR(device) && new_device_added)
 		btrfs_free_stale_devices(device->devt, device);
 
-free_disk_super:
 	btrfs_release_disk_super(disk_super);
 
 error_bdev_put:
-- 
2.42.1


