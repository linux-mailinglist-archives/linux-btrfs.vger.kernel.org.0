Return-Path: <linux-btrfs+bounces-1969-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A74BA844710
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 19:25:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F77BB24F73
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 18:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B34130E4C;
	Wed, 31 Jan 2024 18:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="myKPil1I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4D124HyP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="myKPil1I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4D124HyP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E391F12FF78
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 18:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706725478; cv=none; b=o7jDWilQt+ld7WStgBKkCTEwcM3aTgprT5FmfPe/8FRPBlkGqVDHGP60KYQ3guZYp/vnA1x8JeEhDY+dwPsgP4XNzdIUHNlOuM2S2CrBh3RPWLqTc8sdohAsbwj7Byur8r9AQXyiqJlCqUbaQDVPFmlVo/x3z7iKJiZwsLlBCvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706725478; c=relaxed/simple;
	bh=J/VpHCs+0w4nM+v8W02V2pR/4jP5rIRI0WMrSKhW8Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmLAM30EjPcyDtd8aWx92fmUlZntWZ3rqh/9yC3SSsgznohuKKqB7XmQoGrwoxycX7F9xtR1uZ0C7Za4ALVMyKq1JLdMU3UEFdBEA2rK+v1fhTy6IHbpa0IX24T4IhysX6ljSxLkE1S6c+sPKCB9uZshtGC/kL7pu3hegYQP++8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=myKPil1I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4D124HyP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=myKPil1I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4D124HyP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 27A0821F0B;
	Wed, 31 Jan 2024 18:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706725475;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jmr9VKpC6h8MK1KfCB3vUhH2iGqb8mOSVy8iFCQF26A=;
	b=myKPil1I6Z6Bod1a/qk8VJF+ds7yHL3m0QgIc589BxT8eThsUAsSmXc0PYrUAUuyI2fuG+
	kgs1Yc1XsXMwYKfzkugzs59alSCUkW/mVy0aLJy5txflVgxMel5mdMCStdzkeJ9R5TS+hm
	/ZV4FWlM2U1BFTkODh0umAnya/2pykk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706725475;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jmr9VKpC6h8MK1KfCB3vUhH2iGqb8mOSVy8iFCQF26A=;
	b=4D124HyPzCidYcU1zxvgbhmzS4vizkiVOqyqqUo6BWo7y9afBJ7t3mSvKNnZeXvKEvnK2d
	HZu3wopveJNqYOCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706725475;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jmr9VKpC6h8MK1KfCB3vUhH2iGqb8mOSVy8iFCQF26A=;
	b=myKPil1I6Z6Bod1a/qk8VJF+ds7yHL3m0QgIc589BxT8eThsUAsSmXc0PYrUAUuyI2fuG+
	kgs1Yc1XsXMwYKfzkugzs59alSCUkW/mVy0aLJy5txflVgxMel5mdMCStdzkeJ9R5TS+hm
	/ZV4FWlM2U1BFTkODh0umAnya/2pykk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706725475;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jmr9VKpC6h8MK1KfCB3vUhH2iGqb8mOSVy8iFCQF26A=;
	b=4D124HyPzCidYcU1zxvgbhmzS4vizkiVOqyqqUo6BWo7y9afBJ7t3mSvKNnZeXvKEvnK2d
	HZu3wopveJNqYOCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 06C77139D9;
	Wed, 31 Jan 2024 18:24:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id dwcyAWOQumUcJgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 31 Jan 2024 18:24:35 +0000
Date: Wed, 31 Jan 2024 19:24:09 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: mkfs: use flock() to properly prevent
 race with udev
Message-ID: <20240131182409.GO31555@twin.jikos.cz>
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
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.80 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 URIBL_BLOCKED(0.00)[suse.com:email];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWO(0.00)[2];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

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

The other possible user could be btrfs-convert as it also writes data
and changes the UUID.

> Issue: #734
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks for fixing it.

