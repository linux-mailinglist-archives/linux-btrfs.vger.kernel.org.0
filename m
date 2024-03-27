Return-Path: <linux-btrfs+bounces-3684-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B31B88F12B
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 22:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E7571C2EAC5
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 21:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78654153579;
	Wed, 27 Mar 2024 21:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yfpobhUg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="trQ+zlv3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yfpobhUg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="trQ+zlv3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B431A152532;
	Wed, 27 Mar 2024 21:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711575918; cv=none; b=Ii7DzxFxPlfc7vdEwExDN6pgxnWCqMRelKfwluSJF+GJqQ+W6F0RoVVXq2jeo+EINOsMYJK3KlLiwQJjx9PpQzonVm/LPwMSQVV9ucdhhfXsCTIH2oEGYtFjZ0DDSrAuGHkOeHn697yrnXjPORYDWN18LtWkcRCkknPHXPX89cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711575918; c=relaxed/simple;
	bh=SOc/XQwFa+yBtf35557/o9VMVygf4mGBjGof6MpezFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpfcUXVQHUTDN2FwRxlg+cAqBbI+J2zHS+7LQhk/V+zFk3zgzRFa9r16+DrrXV0FgMYo8YgJ8FySWCWwFy0fu8Q5J8LDJJHiR8/nxaqYXK+TKcBxyIidfv2VXLhv37zdR05WllyN739NDjk4VBibkNhHUezBWHosjDUhH9572Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yfpobhUg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=trQ+zlv3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yfpobhUg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=trQ+zlv3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7DE2522B9E;
	Wed, 27 Mar 2024 21:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711575914;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GYSrlk1FplivjVsKqpeABcsJVFei8YwAw4wGQlG9hb8=;
	b=yfpobhUgvEsDs4feIjULv7QGn6KGgghk57xwgbu3vRhdOvVAMx0jRGUqc05DvZMbXzsyoR
	efnhisav2IqwUyKF/e78bl0DEdI0lN7kte+H5MUjaTUogo7zs/0OXV0laROva3+siP6FkY
	lzfdJWjDx4RSVOCdInMukyRDVjzNQg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711575914;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GYSrlk1FplivjVsKqpeABcsJVFei8YwAw4wGQlG9hb8=;
	b=trQ+zlv3ApC954wKR3btpr9tVOQahJDSSEPfAxygF4aWpNufCcQKGMmVN1zF04hg0TYJ3T
	4mUdGFEmR2hTR8Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711575914;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GYSrlk1FplivjVsKqpeABcsJVFei8YwAw4wGQlG9hb8=;
	b=yfpobhUgvEsDs4feIjULv7QGn6KGgghk57xwgbu3vRhdOvVAMx0jRGUqc05DvZMbXzsyoR
	efnhisav2IqwUyKF/e78bl0DEdI0lN7kte+H5MUjaTUogo7zs/0OXV0laROva3+siP6FkY
	lzfdJWjDx4RSVOCdInMukyRDVjzNQg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711575914;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GYSrlk1FplivjVsKqpeABcsJVFei8YwAw4wGQlG9hb8=;
	b=trQ+zlv3ApC954wKR3btpr9tVOQahJDSSEPfAxygF4aWpNufCcQKGMmVN1zF04hg0TYJ3T
	4mUdGFEmR2hTR8Dg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5956313215;
	Wed, 27 Mar 2024 21:45:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id /q+sFWqTBGZFJQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 27 Mar 2024 21:45:14 +0000
Date: Wed, 27 Mar 2024 22:37:51 +0100
From: David Sterba <dsterba@suse.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, anand.jain@oracle.com,
	Alex Romosan <aromosan@gmail.com>,
	CHECK_1234543212345@protonmail.com, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: FAILED: Patch "btrfs: do not skip re-registration for the
 mounted device" failed to apply to 6.8-stable tree
Message-ID: <20240327213751.GW14596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240327120640.2824671-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327120640.2824671-1-sashal@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yfpobhUg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=trQ+zlv3
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,protonmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[vger.kernel.org,oracle.com,gmail.com,protonmail.com,suse.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -4.21
X-Rspamd-Queue-Id: 7DE2522B9E
X-Spam-Flag: NO

On Wed, Mar 27, 2024 at 08:06:40AM -0400, Sasha Levin wrote:
> The patch below does not apply to the 6.8-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Please use the version below, applies cleanly on 6.7.x and 6.8.x.

---

From: Anand Jain <anand.jain@oracle.com>
Subject: [PATCH] btrfs: do not skip re-registration for the mounted device

[ Upstream commit d565fffa68560ac540bf3d62cc79719da50d5e7a ]

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
filesystem even if this is a single device one.

In the fix, check if the device's major:minor number matches with the
cached device. If they do, then we can allow the scan to happen so that
device_list_add() can take care of updating the device path. The file
descriptor remains unchanged.

This does not affect the temp_fsid feature, the UUID of the mounted
filesystem remains the same and the matching is based on device major:minor
which is unique per mounted filesystem.

This covers the path when the device (that exists for all mounted
devices) name changes, updating /dev/root to /dev/sdx. Any other single
device with filesystem and is not mounted is still skipped.

Note that if a system is booted and initial mount is done on the
/dev/root device, this will be the cached name of the device. Only after
the command "btrfs device scan" it will change as it triggers the
rename.

The fix was verified by users whose systems were affected.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=218353
Link: https://lore.kernel.org/lkml/CAKLYgeJ1tUuqLcsquwuFqjDXPSJpEiokrWK2gisPKDZLs8Y2TQ@mail.gmail.com/
Fixes: bc27d6f0aa0e ("btrfs: scan but don't register device on single device filesystem")
CC: stable@vger.kernel.org # 6.7+
Tested-by: Alex Romosan <aromosan@gmail.com>
Tested-by: CHECK_1234543212345@protonmail.com
Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/volumes.c | 57 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f627674b37db..6f4dd3ebbf7a 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1290,6 +1290,47 @@ int btrfs_forget_devices(dev_t devt)
 	return ret;
 }
 
+static bool btrfs_skip_registration(struct btrfs_super_block *disk_super,
+				    const char *path, dev_t devt,
+				    bool mount_arg_dev)
+{
+	struct btrfs_fs_devices *fs_devices;
+
+	/*
+	 * Do not skip device registration for mounted devices with matching
+	 * maj:min but different paths. Booting without initrd relies on
+	 * /dev/root initially, later replaced with the actual root device.
+	 * A successful scan ensures grub2-probe selects the correct device.
+	 */
+	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
+		struct btrfs_device *device;
+
+		mutex_lock(&fs_devices->device_list_mutex);
+
+		if (!fs_devices->opened) {
+			mutex_unlock(&fs_devices->device_list_mutex);
+			continue;
+		}
+
+		list_for_each_entry(device, &fs_devices->devices, dev_list) {
+			if (device->bdev && (device->bdev->bd_dev == devt) &&
+			    strcmp(device->name->str, path) != 0) {
+				mutex_unlock(&fs_devices->device_list_mutex);
+
+				/* Do not skip registration. */
+				return false;
+			}
+		}
+		mutex_unlock(&fs_devices->device_list_mutex);
+	}
+
+	if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
+	    !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING))
+		return true;
+
+	return false;
+}
+
 /*
  * Look for a btrfs signature on a device. This may be called out of the mount path
  * and we are not allowed to call set_blocksize during the scan. The superblock
@@ -1346,18 +1387,14 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 		goto error_bdev_put;
 	}
 
-	if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
-	    !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING)) {
-		dev_t devt;
+	if (btrfs_skip_registration(disk_super, path, bdev_handle->bdev->bd_dev,
+				    mount_arg_dev)) {
+		pr_debug("BTRFS: skip registering single non-seed device %s (%d:%d)\n",
+			  path, MAJOR(bdev_handle->bdev->bd_dev),
+			  MINOR(bdev_handle->bdev->bd_dev));
 
-		ret = lookup_bdev(path, &devt);
-		if (ret)
-			btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
-				   path, ret);
-		else
-			btrfs_free_stale_devices(devt, NULL);
+		btrfs_free_stale_devices(bdev_handle->bdev->bd_dev, NULL);
 
-		pr_debug("BTRFS: skip registering single non-seed device %s\n", path);
 		device = NULL;
 		goto free_disk_super;
 	}
-- 
2.44.0


