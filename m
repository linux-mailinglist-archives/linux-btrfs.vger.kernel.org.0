Return-Path: <linux-btrfs+bounces-1950-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C49D843778
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 08:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10FC1C25796
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 07:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3064466B4C;
	Wed, 31 Jan 2024 07:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KHrJHxgy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2RJPfMVa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KHrJHxgy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2RJPfMVa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280BF664C6
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 07:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706685235; cv=none; b=Fevona7T1QlxC3cP3sisTdIjRAaDL22JSMtNEA33M2iBxA243A5gANtP2C9nPaIcJFt3tKLJIyR891SBK1iXdWRKhnQ/9SrwrhRRJXOWVxyBgkyomx11wUSjOTNZiVQK/9iNZRI94GwECj9h1uE+zzxclZhDF+vX+GqQDhpfWqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706685235; c=relaxed/simple;
	bh=IZGLSCWlCub38uP7SZu+Iln40JNn5TO93oI5c8naTHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3+/IYDsOEh6DyM95Ei2YmFPnJIQuZiNfJcKH9+KvJzRLs0xy3vVuif3HekvEGoBubNb6RWViNSe7/tN58tLqwLP7qS9wz/ZdLXq6/HvAIRNR+8YbuSiXxJVMvQaI71khgzeZX32EqcjyXJB3hq8dE/cFHhNv/LMf1A2sHfMqu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KHrJHxgy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2RJPfMVa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KHrJHxgy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2RJPfMVa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1B88C22116;
	Wed, 31 Jan 2024 07:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706685225;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6z9WrSPpjv4tVCvCQ2BhSmAM67acryUNitZBB0z2ZDI=;
	b=KHrJHxgy38uatamdv4n0DIRhiJRvjx3fJQrN3WRhEoKYIgqAB1K7641V1BIzOU+tRVzMms
	wMgLdugY4PUGlCb16jegtB+Mjq6tYaVkHifuLTbDG9FVeauGc9NayIklKb1PvzU2kMUVHx
	FCyOgiVavclKrHzxIRGO3m5j9fmmF0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706685225;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6z9WrSPpjv4tVCvCQ2BhSmAM67acryUNitZBB0z2ZDI=;
	b=2RJPfMVa2lz4ojRys/oDCh7RCi0i1SX9Ku4I7YBjz1n8901ab2M7ywOyIn9bpOE91AVcYL
	AqRVDI5IOQ22KFCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706685225;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6z9WrSPpjv4tVCvCQ2BhSmAM67acryUNitZBB0z2ZDI=;
	b=KHrJHxgy38uatamdv4n0DIRhiJRvjx3fJQrN3WRhEoKYIgqAB1K7641V1BIzOU+tRVzMms
	wMgLdugY4PUGlCb16jegtB+Mjq6tYaVkHifuLTbDG9FVeauGc9NayIklKb1PvzU2kMUVHx
	FCyOgiVavclKrHzxIRGO3m5j9fmmF0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706685225;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6z9WrSPpjv4tVCvCQ2BhSmAM67acryUNitZBB0z2ZDI=;
	b=2RJPfMVa2lz4ojRys/oDCh7RCi0i1SX9Ku4I7YBjz1n8901ab2M7ywOyIn9bpOE91AVcYL
	AqRVDI5IOQ22KFCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E7EEF132FA;
	Wed, 31 Jan 2024 07:13:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id uzMzOCjzuWX3CAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 31 Jan 2024 07:13:44 +0000
Date: Wed, 31 Jan 2024 08:13:19 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: mkfs: use flock() to properly prevent
 race with udev
Message-ID: <20240131071319.GH31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <49bbb80e37990b0614f0929ac302560b27d2d933.1706594470.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49bbb80e37990b0614f0929ac302560b27d2d933.1706594470.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KHrJHxgy;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2RJPfMVa
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.21
X-Rspamd-Queue-Id: 1B88C22116
X-Spam-Flag: NO

On Tue, Jan 30, 2024 at 04:31:17PM +1030, Qu Wenruo wrote:
> [BUG]
> Even after commit b2a1be83b85f ("btrfs-progs: mkfs: keep file
> descriptors open during whole time"), there is still a bug report about
> blkid failed to grab the FSID:
> 
>  device=/dev/loop0
>  fstype=btrfs
> 
>  wipefs -a "$device"*
> 
>  parted -s "$device" \
>      mklabel gpt \
>      mkpart '"EFI system partition"' fat32 1MiB 513MiB \
>      set 1 esp on \
>      mkpart '"root partition"' "$fstype" 513MiB 100%
> 
>  udevadm settle
>  partitions=($(lsblk -n -o path "$device"))
> 
>  mkfs.fat -F 32 ${partitions[1]}
>  mkfs."$fstype" ${partitions[2]}
>  udevadm settle

As mentioned in the issue 'udevadm lock <command>' can be used as a
workaround until mkfs does the locking but we can also use that for
testing, ie lock a device and then try mkfs.

> 
> The above script can sometimes result empty fsid:
> 
>  loop0
>  |-loop0p1 BDF3-552B
>  `-loop0p2
> 
> [CAUSE]
> Although commit b2a1be83b85f ("btrfs-progs: mkfs: keep file descriptors
> open during whole time") changed the lifespan of the fds, it doesn't
> properly inform udev about our change to certain partition.
> 
> Thus for a multi-partition case, udev can start scanning the whole disk,
> meanwhile our mkfs is still happening halfway.
> 
> If the scan is done before our new super blocks written, and our close()
> calls happens later just before the current scan is finished, udev can
> got the temporary super blocks (which is not a valid one).
> 
> And since our close() calls happens during the scan, there would be no
> new scan, thus leading to the bad result.
> 
> [FIX]
> The proper way to avoid race with udev is to flock() the whole disk
> (aka, the parent block device, not the partition disk).
> 
> Thus this patch would introduce such mechanism by:
> 
> - btrfs_flock_one_device()
>   This would resolve the path to a whole disk path.
>   Then make sure the whole disk is not already locked (this can happen
>   for cases like "mkfs.btrfs -f /dev/sda[123]").
> 
>   If the device is not already locked, then flock() the device, and
>   insert a new entry into the list.
> 
> - btrfs_unlock_all_devices()
>   Would go unlock all devices recorded in locked_devices list, and free
>   the memory.
> 
> And mkfs.btrfs would be the first one to utilize the new mechanism, to
> prevent such race with udev.
> 
> Issue: #734
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Fix the patch prefix
>   From "btrfs" to "btrfs-progs"
> ---
>  common/device-utils.c | 114 ++++++++++++++++++++++++++++++++++++++++++
>  common/device-utils.h |   3 ++
>  mkfs/main.c           |  11 ++++
>  3 files changed, 128 insertions(+)
> 
> diff --git a/common/device-utils.c b/common/device-utils.c
> index f86120afa00c..88c21c66382d 100644
> --- a/common/device-utils.c
> +++ b/common/device-utils.c
> @@ -17,11 +17,13 @@
>  #include <sys/ioctl.h>
>  #include <sys/stat.h>
>  #include <sys/types.h>
> +#include <sys/file.h>
>  #include <linux/limits.h>
>  #ifdef BTRFS_ZONED
>  #include <linux/blkzoned.h>
>  #endif
>  #include <linux/fs.h>
> +#include <linux/kdev_t.h>
>  #include <limits.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> @@ -48,6 +50,24 @@
>  #define BLKDISCARD	_IO(0x12,119)
>  #endif
> 
> +static LIST_HEAD(locked_devices);
> +
> +/*
> + * This is to record flock()ed devices.
> + * For flock() to prevent udev races, we must lock the parent block device,
> + * but we may hit cases like "mkfs.btrfs -f /dev/sda[123]", in that case
> + * we should only lock "/dev/sda" once.
> + *
> + * This structure would be used to record any flocked block device (not
> + * the partition one), and avoid double locking.
> + */
> +struct btrfs_locked_wholedisk {

Please pick a different name, we've been calling it devices, although
you can find 'disk' references but mainly for historical reasons (eg.
when it's in a structure). In this case it's a block device.

