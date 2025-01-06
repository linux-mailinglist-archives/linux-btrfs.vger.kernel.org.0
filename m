Return-Path: <linux-btrfs+bounces-10746-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A69A02818
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 15:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D329D7A1102
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 14:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB20D1DC9A3;
	Mon,  6 Jan 2025 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e2XqOX8k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wWtfyEJD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="e2XqOX8k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wWtfyEJD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC441E487
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Jan 2025 14:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736174034; cv=none; b=LkUJvDV1jSXWbIRUb48m4VpVvdwYXV6LGgJ2qzEn+EGDqu2hgBgmamNttLT4a6uE3Gc46lzHBL/owxgofVOETk68sHUsyGh6g9HipfiASB5caiMBg703acWeqEFMoa2KOdKUHmjZ3KA1xFOM1kn6tgX45KhCikPBC644PuJ3uOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736174034; c=relaxed/simple;
	bh=nkYtB5LNNdmdVzMlpTKLycsCJbMjcCXDPmkvtpyISlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0BJd6wVTOEinbLfsbakGGS/RisJBlOvSnFUJOJ6Dow4n3nKUzGNBlaOCZOmTC7pAekMw0k3ygGaHPV4mwBf0XuGDE6ENa+nIyTXeCo3NAB4NE61MbsAsWBX+9RKBZL5IFE0NvToJvEBiJPBVQtwI9NvwoKhgA/lI1Z8L1P6TpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e2XqOX8k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wWtfyEJD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=e2XqOX8k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wWtfyEJD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2D81C2115D;
	Mon,  6 Jan 2025 14:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736174030;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g/lEcnRd2n6V31VL1j5kfWsMuPsJl7OnvoOvogwXEfE=;
	b=e2XqOX8kAzcyXYq2qpM82vX1LWmurdp5kSyoR6vISJlnfG/xE4VGPVJRAhCmz7CSusaeLI
	KbfFOVJhJDdg1+ODUWJJkyTLvWlpX4z3wzDeG2PNTuzrzK+FI22BbrC42XUa2OjODuhfdi
	Sey4gZUgdtldO8VaSKfyDsh/WS4F6zo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736174030;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g/lEcnRd2n6V31VL1j5kfWsMuPsJl7OnvoOvogwXEfE=;
	b=wWtfyEJD1cwPxNXvD9L3t+dqEFAalno1Vz2WW/z8RdWBTDrou9sY/aXb0fh7MIwsJ9sHJb
	+smF1NUsZkdY30DQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=e2XqOX8k;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wWtfyEJD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736174030;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g/lEcnRd2n6V31VL1j5kfWsMuPsJl7OnvoOvogwXEfE=;
	b=e2XqOX8kAzcyXYq2qpM82vX1LWmurdp5kSyoR6vISJlnfG/xE4VGPVJRAhCmz7CSusaeLI
	KbfFOVJhJDdg1+ODUWJJkyTLvWlpX4z3wzDeG2PNTuzrzK+FI22BbrC42XUa2OjODuhfdi
	Sey4gZUgdtldO8VaSKfyDsh/WS4F6zo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736174030;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g/lEcnRd2n6V31VL1j5kfWsMuPsJl7OnvoOvogwXEfE=;
	b=wWtfyEJD1cwPxNXvD9L3t+dqEFAalno1Vz2WW/z8RdWBTDrou9sY/aXb0fh7MIwsJ9sHJb
	+smF1NUsZkdY30DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0FA5C137DA;
	Mon,  6 Jan 2025 14:33:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qoKcA87pe2d8OwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 06 Jan 2025 14:33:50 +0000
Date: Mon, 6 Jan 2025 15:33:40 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, David Duchesne <aether@disroot.org>
Subject: Re: [PATCH v2] btrfs: prefer to use "/dev/mapper/name" soft link
 instead of "/dev/dm-*"
Message-ID: <20250106143340.GY31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <fb12d07525d725188649f8dae90c0cfc8d31a0db.1735767974.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb12d07525d725188649f8dae90c0cfc8d31a0db.1735767974.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 2D81C2115D
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,twin.jikos.cz:mid,suse.cz:replyto,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Jan 02, 2025 at 08:16:32AM +1030, Qu Wenruo wrote:
> [BUG]
> There is a gentoo bug report that upstream commit a5d74fa24752

This is commit reference to the stable tree so you should either mention
the relevant git tree or use the correct commit from linux.git which is
2e8b6bc0ab41ce41e6dfcc204b6cc01d5abbc952.

> ("btrfs: avoid unnecessary device path update for the same device") breaks
> 6.6 LTS kernel behavior where previously lsblk can properly show multiple
> mount points of the same btrfs:
> 
>  With kernel 6.6.62:
>  NAME         MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS
>  sdb            8:16   0   9,1T  0 disk
>  `-sdb1         8:17   0   9,1T  0 part
>    `-hdd2     254:6    0   9,1T  0 crypt /mnt/hdd2
>                                          /var/cache/distfiles
>                                          /var/cache/binpkgs
> 
> But not with that upstream commit backported:
> 
>  With kernel 6.6.67:
>  sdb            8:16   0   9,1T  0 disk
>  `-sdb1         8:17   0   9,1T  0 part
>    `-hdd2     254:6    0   9,1T  0 crypt /mnt/hdd2
> 
> [CAUSE]
> With that upstream patch backported to 6.6 LTS, the main change is in
> the mount info result:
> 
> Before:
>  /dev/mapper/hdd2 /mnt/hdd2 btrfs rw,relatime,space_cache=v2,subvolid=382,subvol=/hdd2 0 0
>  /dev/mapper/hdd2 /mnt/dump btrfs rw,relatime,space_cache=v2,subvolid=393,subvol=/dump 0 0
> 
> After:
>  /dev/dm-1 /mnt/hdd2 btrfs rw,relatime,space_cache=v2,subvolid=382,subvol=/hdd2 0 0
>  /dev/dm-1 /mnt/dump btrfs rw,relatime,space_cache=v2,subvolid=393,subvol=/dump 0 0
> 
> I believe that change of mount device is causing problems for lsblk.
> 
> And before that patch, even if udev registered "/dev/dm-1" to btrfs,
> later mount triggered a rescan and change the name back to
> "/dev/mapper/hdd2" thus older kernels will work as expected.
> 
> But after that patch, if udev registered "/dev/dm-1", then mount
> triggered a rescan, but since btrfs detects both "/dev/dm-1" and
> "/dev/mapper/hdd2" are pointing to the same block device, btrfs refuses
> to do the rename, causing the less human readable "/dev/dm-1" to be
> there forever, and trigger the bug for lsblk.
> 
> Fortunately for newer kernels, I guess due to the migration to fsconfig
> mount API, even if the end user explicitly mount the fs using
> "/dev/dm-1", the mount will resolve the path to "/dev/mapper/hdd2" link
> anyway.
> 
> So for newer kernels it won't be a big deal but one extra safety net.
> 
> [FIX]
> Add an extra exception for is_same_device(), that if both paths are
> pointing to the same device, but the newer path begins with "/dev/mapper"
> and the older path is not, then still treat them as different devices,
> so that we can rename to use the more human readable device path.
> 
> Reported-by: David Duchesne <aether@disroot.org>
> Link: https://bugs.gentoo.org/947126
> Fixes: a5d74fa24752 ("btrfs: avoid unnecessary device path update for the same device")

This should reference linux.git commit, there are checkers in linux-next
that detect foreign commits I think.

> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Fix unnecessary rename where the filename is the same
>   The problem is in the exception handling that if both old and new path
>   matches, we will still do the rename.
>   Fix it by revert the exception check condition and setting is_same to true when
>   path_equal() is true.
> 
> - Fix special chars in the commit message
> ---
>  fs/btrfs/volumes.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index c8b079ad1dfa..5a0327e11807 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -832,8 +832,21 @@ static bool is_same_device(struct btrfs_device *device, const char *new_path)
>  	ret = kern_path(new_path, LOOKUP_FOLLOW, &new);
>  	if (ret)
>  		goto out;
> -	if (path_equal(&old, &new))
> +	if (path_equal(&old, &new)) {
>  		is_same = true;
> +		/*
> +		 * Special case for device mapper with its soft links.
                                                           symlinks.

> +		 *
> +		 * We can have the old path as "/dev/dm-3", but udev triggered
> +		 * rescan on the soft link "/dev/mapper/test".
                                 symlink

> +		 * In that case we want to rename to that mapper link, to avoid
> +		 * a bug in libblkid where it can not handle multiple mount
                                              cannot

> +		 * points if the device is "/dev/dm-3".
> +		 */
> +		if (strncmp(old_path, "/dev/mapper/", strlen("/dev/mapper")) &&
> +		    !strncmp(new_path, "/dev/mapper/", strlen("/dev/mapper")))

Why one path uses trailing "/" and the the other does not? Also please
use explict == 0 for strncmp().

