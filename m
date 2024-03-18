Return-Path: <linux-btrfs+bounces-3361-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2902087EF96
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 19:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93767B22FA0
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 18:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9BE5674F;
	Mon, 18 Mar 2024 18:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vEEi8o2c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3RyFTjBC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hjkhLwAo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mf9mLmCE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D4556461;
	Mon, 18 Mar 2024 18:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710785831; cv=none; b=TOICClRJ6osAYs/XBCip26OK99BF/3FqeKDiFfQn6dVFSh8ybdKC8fZFWBhJLhm1SB9gPIv993GdZnmv1qjMNWFX5uSWxCFqEPbxsiX+yLpoMYf6bjQs3aM39mNxRmI+8dkjyN5xkhV2d2xCr3AE/5wKtG/uvOD+CCLjWqTNNXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710785831; c=relaxed/simple;
	bh=CcumTjkEt/BkqU3Lg6d5flvRRmyHqsbgdTcldRpY0aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOyDO3OMy/dlDtWGBG/wOQB0Mtj8mNY+zNMLh8+VyQlfxk0paWFccS+dLiSroBCRBZn0NwLhKG4ddYN4Uw1Ubk9Llci3G9hycE7NPwifLmI9ZX9280+CsPPdvpT0vXtIuLXCQrDyjtWo3AesRD1Wom9O88Fh/zSn3ed/hRhqrtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vEEi8o2c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3RyFTjBC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hjkhLwAo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mf9mLmCE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EFD6634D74;
	Mon, 18 Mar 2024 18:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710785828;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W9Z4jhO80KHLDYd1qVpp1xJgYMtf8C7hK7OeSa5PUrQ=;
	b=vEEi8o2cjp5lahTvnr9NRTdloKEYYV2kzNSrmW9pTr94huuu9wEfM3LNow33vLknZM6G+E
	bsXizUgaKBBscteoj5ElF7Dmj+WeS2oudAsDkuUMw6cBzKklnpR1zL0GffyHgrqdQ8jPEg
	r/G2fBtwsG9x11RD5+oLV4aa7cTgPdA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710785828;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W9Z4jhO80KHLDYd1qVpp1xJgYMtf8C7hK7OeSa5PUrQ=;
	b=3RyFTjBCGIPJMWd4gASD36zHiCzSkWdsrUFUieSu3wsmj+jdcGcrkMx1hoCikw+qbp+3zd
	ww/s3n6/JvDv0pCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710785827;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W9Z4jhO80KHLDYd1qVpp1xJgYMtf8C7hK7OeSa5PUrQ=;
	b=hjkhLwAoHaK0M3wo4Q+Ry3cDg4w+tVGwTbg7VV7q3I6Y5TPXH6BhBCN2KpMjql5oZP+T7w
	7d7sZs3ILoOE+xxxKE0jbQFTLgubqgkLdFLQgnDvKr+1wXH779UeLHCzomn5qxck6P9ayk
	jWo+ujNFE6eue37jMGReFESj8jloxtc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710785827;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W9Z4jhO80KHLDYd1qVpp1xJgYMtf8C7hK7OeSa5PUrQ=;
	b=mf9mLmCEthf2A5M24sxFLlkS8W3HabqOrDtZFk9hwmR1GTt7ynoh+vjshYVoYfHp3EV2Ei
	8g8JU5CtFVwKe+CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6211136A8;
	Mon, 18 Mar 2024 18:17:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e7cXNCOF+GXzCwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 18 Mar 2024 18:17:07 +0000
Date: Mon, 18 Mar 2024 19:09:54 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org,
	Alex Romosan <aromosan@gmail.com>,
	CHECK_1234543212345@protonmail.com, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v5] btrfs: do not skip re-registration for the mounted
 device
Message-ID: <20240318180954.GE16737@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <57a63f9905549f22618a85991b775fba76104412.1710732026.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57a63f9905549f22618a85991b775fba76104412.1710732026.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,protonmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,protonmail.com,suse.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Mon, Mar 18, 2024 at 10:13:13AM +0530, Anand Jain wrote:
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
> Tested-by: Alex Romosan <aromosan@gmail.com>
> Tested-by: CHECK_1234543212345@protonmail.com
> Reviewed-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v5:
> Fix the linux-next build failure reported here:
>   https://lore.kernel.org/all/20240318091755.1d0f696f@canb.auug.org.au/
> As the Linux-next branch no longer has the this commit,
> I've sent out the entire patch again.

Thanks but this won't work. The code in v5 is against current master
with bdev_handle -> file_bdev change but the patch gets merged from
branch that does not have that.

For backport to stable we'll need the v4 version while for merge to
master (in the next pull request) it's going to be v5.

I'll do a separate pull request with this change on the correct base and
we'll have to let stable team know which patch to pick.

