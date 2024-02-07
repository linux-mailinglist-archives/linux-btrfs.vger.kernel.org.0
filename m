Return-Path: <linux-btrfs+bounces-2205-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC0E84C742
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 10:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B38081C25854
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 09:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E25E21112;
	Wed,  7 Feb 2024 09:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S4CTJURE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fLhv+C4p";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S4CTJURE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fLhv+C4p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4826D23746;
	Wed,  7 Feb 2024 09:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707297897; cv=none; b=iN80A4n/S/mOSpav6BeWbGRjOYKxCHmYjbLRqpU+M8gCgszmYVLBmSg63FKAkkoCd25/1A0TEoZ9rDJLrqqds57naTsDdYy+7Oq9CC5e2Iu/fb7ilzxmUGBBn9BsDTKtlqKKqhyEweIlWfVObzkwYHLckY2UdVJpk5zawR9GSDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707297897; c=relaxed/simple;
	bh=6dUh4xArYdsoWeio+UrRMyC3pYp1lv4Jdl+HUZsr2/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olfsN7NoD6q59Yxefzt/OjFjyCy+1tYjk4Cf5fY8kIyb4iu9NR3KO9p7L4O2y9xJVENXtV/7vONVop22klvFpR2jTbvT4qgkPtwuLbNGF0fYrTRsTw5AWcL2kqAHRClocJHXUPIG6gtsFZjOO4C/quDJAwzJu4glKKhBXOVRbJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S4CTJURE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fLhv+C4p; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S4CTJURE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fLhv+C4p; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6BF921FBBC;
	Wed,  7 Feb 2024 09:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707297893;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fAR/CLf67NfAYA1+gdQtMrHw0KP5I9cP8E3Ie5fCUuI=;
	b=S4CTJURE3FILIvrYoBqJorEPIzzUr0phFTkDQCucCgQKbBAKHiApHCxARGSM2h5SIGjpTA
	4HvSq23UOZaLWSwjRd74BQDSBu08odXxIopGt66V5D/Ivest/x0x+bV0+MqY/fTjTuV+Qp
	8TSBW3hVA3VwIiW4ovldR3gHUyDnagI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707297893;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fAR/CLf67NfAYA1+gdQtMrHw0KP5I9cP8E3Ie5fCUuI=;
	b=fLhv+C4p/89LvUuc9uFXQzw8hNvkgdzbXXN2b52F6ZeotbQ65Tvz1zcr6hKvR7L2sD9jPf
	4TI902Afu/x03wBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707297893;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fAR/CLf67NfAYA1+gdQtMrHw0KP5I9cP8E3Ie5fCUuI=;
	b=S4CTJURE3FILIvrYoBqJorEPIzzUr0phFTkDQCucCgQKbBAKHiApHCxARGSM2h5SIGjpTA
	4HvSq23UOZaLWSwjRd74BQDSBu08odXxIopGt66V5D/Ivest/x0x+bV0+MqY/fTjTuV+Qp
	8TSBW3hVA3VwIiW4ovldR3gHUyDnagI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707297893;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fAR/CLf67NfAYA1+gdQtMrHw0KP5I9cP8E3Ie5fCUuI=;
	b=fLhv+C4p/89LvUuc9uFXQzw8hNvkgdzbXXN2b52F6ZeotbQ65Tvz1zcr6hKvR7L2sD9jPf
	4TI902Afu/x03wBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F5EF139D8;
	Wed,  7 Feb 2024 09:24:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fqlID2VMw2UQTwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 07 Feb 2024 09:24:53 +0000
Date: Wed, 7 Feb 2024 10:24:23 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] btrfs: always scan a single device when mounted
Message-ID: <20240207092423.GS355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240205174340.30327-1-dsterba@suse.com>
 <adf78c77-160b-4d6d-ade8-c6926c3d9d6f@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adf78c77-160b-4d6d-ade8-c6926c3d9d6f@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.80 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

On Wed, Feb 07, 2024 at 10:44:22AM +0530, Anand Jain wrote:
> 
> 
> On 2/5/24 23:13, David Sterba wrote:
> > There are reports that since version 6.7 update-grub fails to find the
> > device of the root on systems without initrd and on a single device.
> > 
> > This looks like the device name changed in the output of
> > /proc/self/mountinfo:
> > 
> > 6.5-rc5 working
> > 
> >    18 1 0:16 / / rw,noatime - btrfs /dev/sda8 ...
> > 
> > 6.7 not working:
> > 
> >    17 1 0:15 / / rw,noatime - btrfs /dev/root ...
> > 
> > and "update-grub" shows this error:
> > 
> >    /usr/sbin/grub-probe: error: cannot find a device for / (is /dev mounted?)
> > 
> > This looks like it's related to the device name, but grub-probe
> > recognizes the "/dev/root" path and tries to find the underlying device.
> > However there's a special case for some filesystems, for btrfs in
> > particular.
> > 
> > The generic root device detection heuristic is not done and it all
> > relies on reading the device infos by a btrfs specific ioctl. This ioctl
> > returns the device name as it was saved at the time of device scan (in
> > this case it's /dev/root).
> > 
> > The change in 6.7 for temp_fsid to allow several single device
> > filesystem to exist with the same fsid (and transparently generate a new
> > UUID at mount time) was to skip caching/registering such devices.
> > 
> 
> > This also skipped mounted device.
> 
> It's reasonable. However is there any logs from the debug message to 
> confirm?
> 
> 
> > One step of scanning is to check if
> > the device name hasn't changed, and if yes then update the cached value.
> 
> > 
> > This broke the grub-probe as it always read the device /dev/root and
> > couldn't find it in the system. A temporary workaround is to create a
> > symlink but this does not survive reboot.
> > 
> 
> > The right fix is to allow updating the device path of a mounted
> > filesystem even if this is a single device one.
> 
> And at the same time, if the device is not mounted, it still does
> not register the single device. As in the original design.
> 
> > This does not affect the
> > temp_fsid feature, the UUID of the mounted filesystem remains the same
> > and the matching is based on device major:minor which is unique per
> > mounted filesystem.
> > 
> 
> It looks like the logic in find_fsid_by_device() does not verify if the 
> %fsid_fs_devices and %devt_fs_devices are the same. I am concerned that
> if they aren't, and %devt_fs_devices is matched by devt only, it implies
> that the rest of the populated values in fs_devices may be inconsistent
> (from the super).

And this actually a problem, a lot of fstests fail with
messages like:

btrfs/004        [22:53:33][  346.883630] run fstests btrfs/004 at 2024-02-06 22:53:34
[  347.513164] BTRFS: device fsid e161b391-e959-419b-b6a6-9c1a371a6c15 devid 1 transid 11 /dev/vda scanned by mount (30014)
[  347.515665] BTRFS info (device vda): first mount of filesystem e161b391-e959-419b-b6a6-9c1a371a6c15
[  347.516597] BTRFS info (device vda): using crc32c (crc32c-generic) checksum algorithm
[  347.517716] BTRFS info (device vda): using free-space-tree
[  347.996843] BTRFS: device fsid d9f25a27-92c4-4ff3-a2da-634546711e68 devid 1 transid 6 /dev/vdb skip registration scanned by mkfs.btrfs (30078)
[  348.009943] BTRFS: device fsid d9f25a27-92c4-4ff3-a2da-634546711e68 devid 1 transid 6 /dev/vdb scanned by mount (30082)
[  348.013764] BTRFS info (device vdb): first mount of filesystem d9f25a27-92c4-4ff3-a2da-634546711e68
[  348.014943] BTRFS info (device vdb): using crc32c (crc32c-generic) checksum algorithm
[  348.015949] BTRFS error (device vdb): superblock fsid doesn't match fsid of fs_devices: d9f25a27-92c4-4ff3-a2da-634546711e68 != 3fb9009e-b1d5-46ac-ba94-8120384610e4
[  348.017653] BTRFS error (device vdb): superblock metadata_uuid doesn't match metadata uuid of fs_devices: d9f25a27-92c4-4ff3-a2da-634546711e68 != 3fb9009e-b1d5-46ac-ba94-8120384610e4

this

[  348.019590] BTRFS error (device vdb): dev_item UUID does not match metadata fsid: 3fb9009e-b1d5-46ac-ba94-8120384610e4 != d9f25a27-92c4-4ff3-a2da-634546711e68
[  348.021313] BTRFS error (device vdb): superblock contains fatal errors
[  348.022263] BTRFS error (device vdb): open_ctree failed
[failed, exit status 1][  348.058344] BTRFS info (device vda): last unmount of filesystem e161b391-e959-419b-b6a6-9c1a371a6c15

and there are messages about using temp-fsid feature but that's not what
I'd expect, apparently the uuids get totally mixed up:

btrfs/002        [22:52:24][  276.908253] run fstests btrfs/002 at 2024-02-06 22:52:24
[  277.531910] BTRFS: device fsid e161b391-e959-419b-b6a6-9c1a371a6c15 devid 1 transid 9 /dev/vda scanned by mount (15065)
[  277.534162] BTRFS info (device vda): first mount of filesystem e161b391-e959-419b-b6a6-9c1a371a6c15
[  277.535108] BTRFS info (device vda): using crc32c (crc32c-generic) checksum algorithm
[  277.535913] BTRFS info (device vda): using free-space-tree
[  277.782925] BTRFS: device fsid c69cb0c6-6ca1-4e07-9e4e-c5b5cc09b2c9 devid 1 transid 6 /dev/vdb skip registration scanned by mkfs.btrfs (15109)
[  277.824885] BTRFS: device /dev/vdb using temp-fsid d1299d0e-92d4-47a5-b6e7-5f998f86c5f0
[  277.827699] BTRFS: device fsid c69cb0c6-6ca1-4e07-9e4e-c5b5cc09b2c9 devid 1 transid 6 /dev/vdb scanned by mount (15117)
[  277.830983] BTRFS info (device vdb): first mount of filesystem c69cb0c6-6ca1-4e07-9e4e-c5b5cc09b2c9
[  277.832252] BTRFS info (device vdb): using crc32c (crc32c-generic) checksum algorithm
[  277.833325] BTRFS info (device vdb): using free-space-tree
[  277.847045] BTRFS info (device vdb): checking UUID tree
[  294.727566] grep (19725) used greatest stack depth: 24816 bytes left
[  294.788244] dd (19697) used greatest stack depth: 24544 bytes left
[  295.631873] dd (19752) used greatest stack depth: 24328 bytes left
[  317.755256] BTRFS info (device vdb): last unmount of filesystem d1299d0e-92d4-47a5-b6e7-5f998f86c5f0
[  317.820227] BTRFS info (device vda): last unmount of filesystem e161b391-e959-419b-b6a6-9c1a371a6c15

> I had a bunch of test cases for temp-fsid, I need to (find them) and
> send it out.
> 
> > As the main part of device scanning and list update is done in
> > device_list_add() that handles all corner cases and locking, it is
> > extended to take a parameter that tells it to do everything as before,
> > except adding a new device entry.
> 
> Hm. %new_device_added was for btrfs_scan_one_device() so that it can
> call btrfs_free_stale_devices(), removing any stale devices if present.
> However, theoretically, there shouldn't be any stale devices. Let's keep
> it for now, as the find_fsid_by_device() logic might return incorrect
> fs_devices (I need to confirm this again).

Ok, that's a reasonable idea.

> > This covers the path when the device (that exists for all mounted
> > devices) name changes, updating /dev/root to /dev/sdx. Any other single
> > device with filesystem is skipped.
> > 
> > Note that if a system is booted and initial mount is done on the
> > /dev/root device, this will be the cached name of the device. Only after
> > the command "btrfs device rescan" it will change as it triggers the
> 
> "btrfs device scan"
> 
> > rename.
> > 
> > The fix was verified by users whose systems were affected.
> > 
> > CC: stable@vger.kernel.org # 6.7+
> > Fixes: bc27d6f0aa0e ("btrfs: scan but don't register device on single device filesystem")
> > Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=218353
> > Link: https://lore.kernel.org/lkml/CAKLYgeJ1tUuqLcsquwuFqjDXPSJpEiokrWK2gisPKDZLs8Y2TQ@mail.gmail.com/
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >   fs/btrfs/volumes.c | 30 ++++++++++++++----------------
> >   1 file changed, 14 insertions(+), 16 deletions(-)
> > 
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index 474ab7ed65ea..f2c2f7ca5c3d 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -738,6 +738,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
> >   	bool same_fsid_diff_dev = false;
> >   	bool has_metadata_uuid = (btrfs_super_incompat_flags(disk_super) &
> >   		BTRFS_FEATURE_INCOMPAT_METADATA_UUID);
> 
> 
> > +	bool can_create_new = *new_device_added;
> 
> 
> >   
> >   	if (btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_CHANGING_FSID_V2) {
> >   		btrfs_err(NULL,
> > @@ -753,6 +754,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
> >   		return ERR_PTR(error);
> >   	}
> >   
> 
> 
> > +	*new_device_added = false;
> 
> 
> 
> >   	fs_devices = find_fsid_by_device(disk_super, path_devt, &same_fsid_diff_dev);
> >   
> >   	if (!fs_devices) {
> > @@ -804,6 +806,15 @@ static noinline struct btrfs_device *device_list_add(const char *path,
> >   			return ERR_PTR(-EBUSY);
> >   		}
> >   
> > +		if (!can_create_new) {
> 
> 
> 
> > +			pr_info(
> > +	"BTRFS: device fsid %pU devid %llu transid %llu %s skip registration scanned by %s (%d)\n",
> > +				disk_super->fsid, devid, found_transid, path,
> > +				current->comm, task_pid_nr(current));
> > +			mutex_unlock(&fs_devices->device_list_mutex);
> > +			return NULL;
> > +		}
> > +
> 
> 
> I just ran the temp-fsid test cases attached here. Comparing the output
> with and without this patch seems to be breaking something in the
> temp-fsid feature. I need to further verify. I will convert this test
> to fstests. However, in the meantime, it can be used to verify.

Yeah, at this state the patch is broken.

