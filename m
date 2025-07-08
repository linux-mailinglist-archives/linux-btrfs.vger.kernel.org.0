Return-Path: <linux-btrfs+bounces-15333-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89721AFCF31
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 17:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5321616BCC7
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 15:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D3D2E11B9;
	Tue,  8 Jul 2025 15:27:25 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230FA2E090F
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Jul 2025 15:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988444; cv=none; b=OoRRQ/s+IaRrltElGXc45XydLMIKxotHPwmUgWH+MecJtDmK7tdk5tPjPm0QMQ1/XGFlKpdWA8UtTcfpKNROt3KF7ZGdoILqiPRg3Qum9THxJhAfSryFxLCdn1f+xb4dmSa68dc4Cns4wMOxa8or4gPFYWjj9pMod4ULfX3a9m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988444; c=relaxed/simple;
	bh=YhYMYq9Ndrou1yWCAVILZes3gSpg9oPrP/6eaYJmvNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evtPSbVHUHN+T/gFVtlbFxEDahVVjclK5JjJ15ztatYot4p0U7OjB3tCBqTDoFDv65vv1fmrUK/2yYvKzaFVbomwT57bFF5JW+R5/suMGT02RRlKVG+hv0oSl/96UA6cdnk+tGjtTd1AqwXQJ+gGIQ+/a3fszj+tvBrC0lbsF9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6440E1F395;
	Tue,  8 Jul 2025 15:27:21 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43E0D13A54;
	Tue,  8 Jul 2025 15:27:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tGACENk4bWiVXAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 08 Jul 2025 15:27:21 +0000
Date: Tue, 8 Jul 2025 17:27:16 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] btrfs: do not poke into bdev's page cache
Message-ID: <20250708152715.GO4453@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1751965333.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1751965333.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 6440E1F395
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Tue, Jul 08, 2025 at 06:36:31PM +0930, Qu Wenruo wrote:
> [ABUSE OF BDEV'S PAGE CACHE]
> Btrfs has a long history using bdev's page cache for super block IOs.
> This looks weird, but is mostly for the sake of concurrency.
> 
> However this has already caused problems, for example when the block
> layer page cache enables large folio support, it triggers an ASSERT()
> inside btrfs, this is fixed by commit 65f2a3b2323e ("btrfs: remove folio
> order ASSERT()s in super block writeback path"), but it is already a
> warning.
> 
> [MOVEING AWAY FROM BDEV'S PAGE CACHE]
> Thankfully we're moving away from the bdev's page cache already, starting
> with commit bc00965dbff7 ("btrfs: count super block write errors in
> device instead of tracking folio error state"), we no longer relies on
> page cache to detect super block IO errors.
> 
> We still have the following paths using bdev's page cache, and those
> points will be addressed in this series:
> 
> - Reading super blocks
>   This is the easist one to kill, just kmalloc() and bdev_rw_virt() will
>   handle it well.
> 
> - Scratching super blocks
>   Previously we just zero out the magic, but leaving everything else
>   there.
>   We rely on the block layer to write the involved blocks.
> 
>   Here we follow btrfs_read_disk_super() by kzalloc()ing a dummy super
>   block, and write the full super block back to disk.
> 
> - Writing super blocks
>   Although write_dev_supers() is alreadying using the bio interface, it
>   still relies on the bdev's page cache.
> 
>   One of the reason is, we want to submit all super blocks of a device
>   in one go, and each super block of the same block device is slightly
>   different, thus we go using page cache, so that each super block can
>   have its own backing folio.
> 
>   Here we solve it by pre-allocating super block buffers.
>   This also makes endio function much simpler, no need to iterate the
>   bio to unlock the folio.
> 
> - Waiting super blocks
>   Instead of locking the folio to make sure its IO is done, just use an
>   atomic and wait queue head to do it the usual way.
> 
> By this we solve the problem and all IOs are done using bio interface.
> 
> [THE COST AND REASON FOR RFC]
> But this brings some overhead, thus I marked the series RFC:
> 
> - Extra 12K memory usage for each block device
>   I hope the extra cost is acceptable for modern day systems.
> 
> - Extra memory copy for super block writeback
>   Previously we do the copy into the bdev's page cache, then submit the
>   IO using folio from the bdev page cache.
> 
>   This updates the page cache and do the IO in one go.
> 
>   But now we memcpy() into the preallocated super block buffer, not
>   updating the bdev's page cache directly.
>   If by somehow the block device drive determines to copy the bio's
>   content to page cache, it will need to do one extra memory copy.
> 
> - Extra memory allocation for btrfs_scratch_superblock()
>   Previously we need no memory allocation, thus no error handling
>   needed.
> 
>   But now we need extra memory allocation, and such allocation is just
>   to write zero into block devices. Thus the cost is a little hard to
>   accept.
> 
> - No more cached super block during device scan
>   But the cost should be minimal.

I have a similar patchset, there was a discussion about how to write the
super block
https://lore.kernel.org/all/Yn%2FtxWbij5voeGOB@casper.infradead.org/

I did separate pages and bios for the write, not using the page cache
and IIRC there were some problems with userspace interaction as it
depends on the page cache as the synchronization point.

The preallocation of 3 pages per device is IMHO acceptable and it avoids
any potential memory allocation failures when we're writing the most
critical block.

