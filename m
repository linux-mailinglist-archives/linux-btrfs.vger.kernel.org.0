Return-Path: <linux-btrfs+bounces-1981-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F044844C6F
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 00:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECBD1285BDA
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 23:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E63148FF4;
	Wed, 31 Jan 2024 23:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p3KRIIuv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="osGTj/AR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p3KRIIuv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="osGTj/AR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CA114831D
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 23:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706742283; cv=none; b=aoLzBK5oYGubWvW51I4/JLLsduGL2dCY+kiC7JKBlhqenWrgxQ4+YJPysLDjPMhO+UgWwYSsyQrWj4o4Z8YwvmfErwMXEU7Q03SsNIBi37FC49/P1bF8bBKaRytuMg6H9eq65UL3Zxlbm7i3JeCHnDn/EL/YJyWuTVE6nTYt/AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706742283; c=relaxed/simple;
	bh=Zwr+6+hIpUO3EX0C7zitPXYQHEX5g7nJ0Hz+hwqxH1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+6q2b9P7I3IVzADF90obR4ivKNcBEi+ixRtBTEK6EMHDYQAU9FWB/jV3mC+2XJ3cDW9/fvOSLjzLGPAduZ6CKR2PACv4Em+UTHH1MpASCaErjspjBozFwYOCcKSuJ0mV9kFmqSQwvDxwgJfj8sDwoDXPSdsJ8ry5N+2Bfx2GTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p3KRIIuv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=osGTj/AR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p3KRIIuv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=osGTj/AR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3042021EF9;
	Wed, 31 Jan 2024 23:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706742279;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hemTIC/uhQiM3pBdXtHDwIG5kYD8CE7wQ3XHBctI1sY=;
	b=p3KRIIuvuCl9rs/gxpRRz/p7OyZVp5neWNX9gPxS0z2ZPuG/SK0fCEPKNX+1lG1h6qB6Ez
	JDOPDlopBBl/0d12OVqdggZQd1eXcUoW/4qxK/z5vlsn7ZFn5L0uSRSqQLybnbeibhU87Y
	uJVfKLzlcAmyWwF8QlM4PDTcFIp8a8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706742279;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hemTIC/uhQiM3pBdXtHDwIG5kYD8CE7wQ3XHBctI1sY=;
	b=osGTj/ARcDc++JZpwNWHtCQVWaImRbpL4zN0+IeG3o+DJtkcVPH/RzJcCscRBRIbdGPGS9
	CUZ66E9YF7SV1WAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706742279;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hemTIC/uhQiM3pBdXtHDwIG5kYD8CE7wQ3XHBctI1sY=;
	b=p3KRIIuvuCl9rs/gxpRRz/p7OyZVp5neWNX9gPxS0z2ZPuG/SK0fCEPKNX+1lG1h6qB6Ez
	JDOPDlopBBl/0d12OVqdggZQd1eXcUoW/4qxK/z5vlsn7ZFn5L0uSRSqQLybnbeibhU87Y
	uJVfKLzlcAmyWwF8QlM4PDTcFIp8a8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706742279;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hemTIC/uhQiM3pBdXtHDwIG5kYD8CE7wQ3XHBctI1sY=;
	b=osGTj/ARcDc++JZpwNWHtCQVWaImRbpL4zN0+IeG3o+DJtkcVPH/RzJcCscRBRIbdGPGS9
	CUZ66E9YF7SV1WAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 169A1139D9;
	Wed, 31 Jan 2024 23:04:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id QFNTBQfSumUjWwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 31 Jan 2024 23:04:39 +0000
Date: Thu, 1 Feb 2024 00:04:13 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: mkfs: use flock() to properly prevent
 race with udev
Message-ID: <20240131230413.GT31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <49bbb80e37990b0614f0929ac302560b27d2d933.1706594470.git.wqu@suse.com>
 <20240131182409.GO31555@twin.jikos.cz>
 <6b1001cb-7df0-4ffc-ab15-cd25223da9d6@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b1001cb-7df0-4ffc-ab15-cd25223da9d6@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.80 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
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

On Thu, Feb 01, 2024 at 09:08:31AM +1030, Qu Wenruo wrote:
> 
> 
> On 2024/2/1 04:54, David Sterba wrote:
> > On Tue, Jan 30, 2024 at 04:31:17PM +1030, Qu Wenruo wrote:
> >> [BUG]
> >> Even after commit b2a1be83b85f ("btrfs-progs: mkfs: keep file
> >> descriptors open during whole time"), there is still a bug report about
> >> blkid failed to grab the FSID:
> >>
> >>   device=/dev/loop0
> >>   fstype=btrfs
> >>
> >>   wipefs -a "$device"*
> >>
> >>   parted -s "$device" \
> >>       mklabel gpt \
> >>       mkpart '"EFI system partition"' fat32 1MiB 513MiB \
> >>       set 1 esp on \
> >>       mkpart '"root partition"' "$fstype" 513MiB 100%
> >>
> >>   udevadm settle
> >>   partitions=($(lsblk -n -o path "$device"))
> >>
> >>   mkfs.fat -F 32 ${partitions[1]}
> >>   mkfs."$fstype" ${partitions[2]}
> >>   udevadm settle
> >>
> >> The above script can sometimes result empty fsid:
> >>
> >>   loop0
> >>   |-loop0p1 BDF3-552B
> >>   `-loop0p2
> >>
> >> [CAUSE]
> >> Although commit b2a1be83b85f ("btrfs-progs: mkfs: keep file descriptors
> >> open during whole time") changed the lifespan of the fds, it doesn't
> >> properly inform udev about our change to certain partition.
> >>
> >> Thus for a multi-partition case, udev can start scanning the whole disk,
> >> meanwhile our mkfs is still happening halfway.
> >>
> >> If the scan is done before our new super blocks written, and our close()
> >> calls happens later just before the current scan is finished, udev can
> >> got the temporary super blocks (which is not a valid one).
> >>
> >> And since our close() calls happens during the scan, there would be no
> >> new scan, thus leading to the bad result.
> >>
> >> [FIX]
> >> The proper way to avoid race with udev is to flock() the whole disk
> >> (aka, the parent block device, not the partition disk).
> >>
> >> Thus this patch would introduce such mechanism by:
> >>
> >> - btrfs_flock_one_device()
> >>    This would resolve the path to a whole disk path.
> >>    Then make sure the whole disk is not already locked (this can happen
> >>    for cases like "mkfs.btrfs -f /dev/sda[123]").
> >>
> >>    If the device is not already locked, then flock() the device, and
> >>    insert a new entry into the list.
> >>
> >> - btrfs_unlock_all_devices()
> >>    Would go unlock all devices recorded in locked_devices list, and free
> >>    the memory.
> >>
> >> And mkfs.btrfs would be the first one to utilize the new mechanism, to
> >> prevent such race with udev.
> > 
> > The other possible user could be btrfs-convert as it also writes data
> > and changes the UUID.
> > 
> >> Issue: #734
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> > 
> > Added to devel, thanks for fixing it.
> 
> Sorry, this v2 is still incorrect, as it doesn't use the correct device 
> number, the proper fix is in my flock branch.
> 
> But I'll send out a v3 just in case.

I noticed the update after I replied, the commit in devel is from your
repository. There were added hunks in btrfs_flock_one_device() adding
path_dump, and some typos fixed.

