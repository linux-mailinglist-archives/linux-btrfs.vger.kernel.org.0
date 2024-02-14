Return-Path: <linux-btrfs+bounces-2372-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4E7854358
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 08:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F123528E4F1
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Feb 2024 07:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794701170A;
	Wed, 14 Feb 2024 07:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i71glT7C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x0eJQ9A3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i71glT7C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x0eJQ9A3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86716111B5;
	Wed, 14 Feb 2024 07:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707895017; cv=none; b=upZAOeuLsZeJ4BgdEGesU7V2UktTmGuXD5+pRhSrnGLFh9xIu8Wi13L9dyO3KVVE4CNUQyHslX0v/3Qo4nwCMMj5655Tv+0+UUDo0XMZF1/gspUdOaHaHuD0l+SdDljwUSRwnUKt1kKkLQGDQ4EHSOrM6EtK4z/HOIHwACA1XUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707895017; c=relaxed/simple;
	bh=PRaho9Lsuh8wUCTTzE5bFWBJmTQKUBTjUwE1AhcZ+tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y00zdWRgrOa4Snh6eRp6vzvCp5TQxNNE06Ob4Fl+UDMwHZxv92T8ARYuHrZqT2OgvsH3MMkWXwJLcF2S9Axulv7eUhrU/otNy5pgMJoWc6w94JftSRgMb0wHrET0frrmzTqzYcqlAYmxKtSkLFLJazM8E43TPrBAJByJT/jvpcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i71glT7C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x0eJQ9A3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i71glT7C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x0eJQ9A3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7E4B61F7DE;
	Wed, 14 Feb 2024 07:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707895013;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ScPkoj0V7Gt3bE0h7L3gJL4vW80ApKfAZOdEsqMCBus=;
	b=i71glT7CMUczkdpx8IuRmxGJRxl+Kc0hzC2xG81AygEkFxiFAZFCnT+U8nlcLsXWDuFY9s
	H8qdfoVU868V3myObcIPgfbrSLqZ/Ff431lY6xfupxyOu0uTskPC1Fk5W/1ojQx2xE4Anu
	bQeDyx1xm1wZ0SWO695v0mc5kz229tY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707895013;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ScPkoj0V7Gt3bE0h7L3gJL4vW80ApKfAZOdEsqMCBus=;
	b=x0eJQ9A3T4yaev9KO0AGs5npO2KfFnz+lNSR6Rg5lP8EwIAhIJzUvh1qGLkoINiney/QZ+
	FGDUkfIBda3js+DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707895013;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ScPkoj0V7Gt3bE0h7L3gJL4vW80ApKfAZOdEsqMCBus=;
	b=i71glT7CMUczkdpx8IuRmxGJRxl+Kc0hzC2xG81AygEkFxiFAZFCnT+U8nlcLsXWDuFY9s
	H8qdfoVU868V3myObcIPgfbrSLqZ/Ff431lY6xfupxyOu0uTskPC1Fk5W/1ojQx2xE4Anu
	bQeDyx1xm1wZ0SWO695v0mc5kz229tY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707895013;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ScPkoj0V7Gt3bE0h7L3gJL4vW80ApKfAZOdEsqMCBus=;
	b=x0eJQ9A3T4yaev9KO0AGs5npO2KfFnz+lNSR6Rg5lP8EwIAhIJzUvh1qGLkoINiney/QZ+
	FGDUkfIBda3js+DA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A38113A1A;
	Wed, 14 Feb 2024 07:16:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id x5KPFeVozGUKLAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 14 Feb 2024 07:16:53 +0000
Date: Wed, 14 Feb 2024 08:16:20 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com, aromosan@gmail.com,
	bernd.feige@gmx.net, CHECK_1234543212345@protonmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: do not skip re-registration for the mounted
 device
Message-ID: <20240214071620.GL355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <88673c60b1d866c289ef019945647adfc8ab51d0.1707781507.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88673c60b1d866c289ef019945647adfc8ab51d0.1707781507.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net,protonmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,suse.com,gmail.com,gmx.net,protonmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Tue, Feb 13, 2024 at 09:13:56AM +0800, Anand Jain wrote:
> There are reports that since version 6.7 update-grub fails to find the
> device of the root on systems without initrd and on a single device.
> 
> This looks like the device name changed in the output of
> /proc/self/mountinfo:
> 
> 6.5-rc5 working
> 
>   18 1 0:16 / / rw,noatime - btrfs /dev/sda8 ...
> 
> 6.7 not working:
> 
>   17 1 0:15 / / rw,noatime - btrfs /dev/root ...
> 
> and "update-grub" shows this error:
> 
>   /usr/sbin/grub-probe: error: cannot find a device for / (is /dev mounted?)
> 
> This looks like it's related to the device name, but grub-probe
> recognizes the "/dev/root" path and tries to find the underlying device.
> However there's a special case for some filesystems, for btrfs in
> particular.
> 
> The generic root device detection heuristic is not done and it all
> relies on reading the device infos by a btrfs specific ioctl. This ioctl
> returns the device name as it was saved at the time of device scan (in
> this case it's /dev/root).
> 
> The change in 6.7 for temp_fsid to allow several single device
> filesystem to exist with the same fsid (and transparently generate a new
> UUID at mount time) was to skip caching/registering such devices.
> 
> This also skipped mounted device. One step of scanning is to check if
> the device name hasn't changed, and if yes then update the cached value.
> 
> This broke the grub-probe as it always read the device /dev/root and
> couldn't find it in the system. A temporary workaround is to create a
> symlink but this does not survive reboot.
> 
> The right fix is to allow updating the device path of a mounted
> filesystem even if this is a single device one.
> 
> In the fix, check if the device's major:minor number matches with the
> cached device. If they do, then we can allow the scan to happen so that
> device_list_add() can take care of updating the device path. The file
> descriptor remains unchanged.
> 
> This does not affect the temp_fsid feature, the UUID of the mounted
> filesystem remains the same and the matching is based on device major:minor
> which is unique per mounted filesystem.
> 
> This covers the path when the device (that exists for all mounted
> devices) name changes, updating /dev/root to /dev/sdx. Any other single
> device with filesystem and is not mounted is still skipped.
> 
> Note that if a system is booted and initial mount is done on the
> /dev/root device, this will be the cached name of the device. Only after
> the command "btrfs device scan" it will change as it triggers the
> rename.
> 
> The fix was verified by users whose systems were affected.
> 
> CC: stable@vger.kernel.org # 6.7+
> Fixes: bc27d6f0aa0e ("btrfs: scan but don't register device on single device filesystem")
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=218353
> Link: https://lore.kernel.org/lkml/CAKLYgeJ1tUuqLcsquwuFqjDXPSJpEiokrWK2gisPKDZLs8Y2TQ@mail.gmail.com/
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> Tested-by: Alex Romosan <aromosan@gmail.com>
> Tested-by: CHECK_1234543212345@protonmail.com

Reviewed-by: David Sterba <dsterba@suse.com>

When you commit the patch, please reorder the tags according to
https://btrfs.readthedocs.io/en/latest/dev/Developer-s-FAQ.html#ordering

