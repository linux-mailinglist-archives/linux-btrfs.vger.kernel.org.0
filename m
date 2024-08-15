Return-Path: <linux-btrfs+bounces-7216-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D0B9539CA
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2024 20:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96AD21F25167
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2024 18:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0A957CB6;
	Thu, 15 Aug 2024 18:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XCKE5v3f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7P8noHA9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XCKE5v3f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7P8noHA9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A5733997;
	Thu, 15 Aug 2024 18:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723745874; cv=none; b=ujKbXzRor+YPsvATo73gAIJ71FvdVElsT9TLDwFw6zLF9UeYIvYW+nXESZmygQ+MB/Wd7NRNDumDVdv2eoSYo8YzcOX0mnnTi6xwKnm0DLgnAtlgxStEYZ9BnHxrYp666/aYFswsemloUDCe0esvzS376wSPCBu+b2Wvv7+oe8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723745874; c=relaxed/simple;
	bh=ofNqli1JBkls2t6p95Ji7pKm8nbifIMyy887RHt+/rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XaZywO5a8TXbZXb48S+Lz3kxxlLdya0pZZJb7eIgIh3sPsOlhI2LPhuEn2yZKDKf3ElHs4BIcn8RTg6EN3VxRnuidVBT/QZ9RLJqsMCZwjRMU+vC/NcfmcBwgdUSQ+oiPXMlLxsOUFnc5t8muU+o528a9j0eLE/KdZcstgKV9ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XCKE5v3f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7P8noHA9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XCKE5v3f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7P8noHA9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3B0541FD2D;
	Thu, 15 Aug 2024 18:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723745869;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kgtaDZbdUoZCGSTogCf3PoP0l3wj8rYd4DVvfeL2Zvk=;
	b=XCKE5v3f1NWVL+fVaRLZ9N2OGpULSED+xO7Fhn4tt68Jpg8panBLtfQdcsErgk1l6L/NLQ
	yPPo+ikYDXlR/DUHLVaXUiFK20n+qNAZyCRIf7I4mNeCBh8SBUpkE1sIAouTtFJWcBeCfa
	rYkRtzmdGaA1M1r1Z29DgUZ9axngYPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723745869;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kgtaDZbdUoZCGSTogCf3PoP0l3wj8rYd4DVvfeL2Zvk=;
	b=7P8noHA9t5eJs4UUgrgeEOyicqeptwp1opoIG8a8jJlLpRpH0K5P+/ueCsWGa5h4u4/hI3
	h2dwsgXMyu4nzgDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XCKE5v3f;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7P8noHA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723745869;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kgtaDZbdUoZCGSTogCf3PoP0l3wj8rYd4DVvfeL2Zvk=;
	b=XCKE5v3f1NWVL+fVaRLZ9N2OGpULSED+xO7Fhn4tt68Jpg8panBLtfQdcsErgk1l6L/NLQ
	yPPo+ikYDXlR/DUHLVaXUiFK20n+qNAZyCRIf7I4mNeCBh8SBUpkE1sIAouTtFJWcBeCfa
	rYkRtzmdGaA1M1r1Z29DgUZ9axngYPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723745869;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kgtaDZbdUoZCGSTogCf3PoP0l3wj8rYd4DVvfeL2Zvk=;
	b=7P8noHA9t5eJs4UUgrgeEOyicqeptwp1opoIG8a8jJlLpRpH0K5P+/ueCsWGa5h4u4/hI3
	h2dwsgXMyu4nzgDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01DE81342D;
	Thu, 15 Aug 2024 18:17:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1TFMO0xGvmanPQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 15 Aug 2024 18:17:48 +0000
Date: Thu, 15 Aug 2024 20:17:39 +0200
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	"open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: don't take dev_replace rwsem on task already
 holding it
Message-ID: <20240815181739.GE25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <9e26957661751f7697220d978a9a7f927d0ec378.1723726582.git.jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e26957661751f7697220d978a9a7f927d0ec378.1723726582.git.jth@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TO_DN_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 
X-Rspamd-Queue-Id: 3B0541FD2D

On Thu, Aug 15, 2024 at 02:57:05PM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Running fstests btrfs/011 with MKFS_OPTIONS="-O rst" to force the usage of
> the RAID stripe-tree, we get the following splat from lockdep:
> 
>  BTRFS info (device sdd): dev_replace from /dev/sdd (devid 1) to /dev/sdb started
> 
>  ============================================
>  WARNING: possible recursive locking detected
>  6.11.0-rc3-btrfs-for-next #599 Not tainted
>  --------------------------------------------
>  btrfs/2326 is trying to acquire lock:
>  ffff88810f215c98 (&fs_info->dev_replace.rwsem){++++}-{3:3}, at: btrfs_map_block+0x39f/0x2250
> 
>  but task is already holding lock:
>  ffff88810f215c98 (&fs_info->dev_replace.rwsem){++++}-{3:3}, at: btrfs_map_block+0x39f/0x2250
> 
>  other info that might help us debug this:
>   Possible unsafe locking scenario:
> 
>         CPU0
>         ----
>    lock(&fs_info->dev_replace.rwsem);
>    lock(&fs_info->dev_replace.rwsem);
> 
>   *** DEADLOCK ***
> 
>   May be due to missing lock nesting notation
> 
>  1 lock held by btrfs/2326:
>   #0: ffff88810f215c98 (&fs_info->dev_replace.rwsem){++++}-{3:3}, at: btrfs_map_block+0x39f/0x2250
> 
>  stack backtrace:
>  CPU: 1 UID: 0 PID: 2326 Comm: btrfs Not tainted 6.11.0-rc3-btrfs-for-next #599
>  Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x5b/0x80
>   __lock_acquire+0x2798/0x69d0
>   ? __pfx___lock_acquire+0x10/0x10
>   ? __pfx___lock_acquire+0x10/0x10
>   lock_acquire+0x19d/0x4a0
>   ? btrfs_map_block+0x39f/0x2250
>   ? __pfx_lock_acquire+0x10/0x10
>   ? find_held_lock+0x2d/0x110
>   ? lock_is_held_type+0x8f/0x100
>   down_read+0x8e/0x440
>   ? btrfs_map_block+0x39f/0x2250
>   ? __pfx_down_read+0x10/0x10
>   ? do_raw_read_unlock+0x44/0x70
>   ? _raw_read_unlock+0x23/0x40
>   btrfs_map_block+0x39f/0x2250
>   ? btrfs_dev_replace_by_ioctl+0xd69/0x1d00
>   ? btrfs_bio_counter_inc_blocked+0xd9/0x2e0
>   ? __kasan_slab_alloc+0x6e/0x70
>   ? __pfx_btrfs_map_block+0x10/0x10
>   ? __pfx_btrfs_bio_counter_inc_blocked+0x10/0x10
>   ? kmem_cache_alloc_noprof+0x1f2/0x300
>   ? mempool_alloc_noprof+0xed/0x2b0
>   btrfs_submit_chunk+0x28d/0x17e0
>   ? __pfx_btrfs_submit_chunk+0x10/0x10
>   ? bvec_alloc+0xd7/0x1b0
>   ? bio_add_folio+0x171/0x270
>   ? __pfx_bio_add_folio+0x10/0x10
>   ? __kasan_check_read+0x20/0x20
>   btrfs_submit_bio+0x37/0x80
>   read_extent_buffer_pages+0x3df/0x6c0
>   btrfs_read_extent_buffer+0x13e/0x5f0
>   read_tree_block+0x81/0xe0
>   read_block_for_search+0x4bd/0x7a0
>   ? __pfx_read_block_for_search+0x10/0x10
>   btrfs_search_slot+0x78d/0x2720
>   ? __pfx_btrfs_search_slot+0x10/0x10
>   ? lock_is_held_type+0x8f/0x100
>   ? kasan_save_track+0x14/0x30
>   ? __kasan_slab_alloc+0x6e/0x70
>   ? kmem_cache_alloc_noprof+0x1f2/0x300
>   btrfs_get_raid_extent_offset+0x181/0x820
>   ? __pfx_lock_acquire+0x10/0x10
>   ? __pfx_btrfs_get_raid_extent_offset+0x10/0x10
>   ? down_read+0x194/0x440
>   ? __pfx_down_read+0x10/0x10
>   ? do_raw_read_unlock+0x44/0x70
>   ? _raw_read_unlock+0x23/0x40
>   btrfs_map_block+0x5b5/0x2250
>   ? __pfx_btrfs_map_block+0x10/0x10
>   scrub_submit_initial_read+0x8fe/0x11b0
>   ? __pfx_scrub_submit_initial_read+0x10/0x10
>   submit_initial_group_read+0x161/0x3a0
>   ? lock_release+0x20e/0x710
>   ? __pfx_submit_initial_group_read+0x10/0x10
>   ? __pfx_lock_release+0x10/0x10
>   scrub_simple_mirror.isra.0+0x3eb/0x580
>   scrub_stripe+0xe4d/0x1440
>   ? lock_release+0x20e/0x710
>   ? __pfx_scrub_stripe+0x10/0x10
>   ? __pfx_lock_release+0x10/0x10
>   ? do_raw_read_unlock+0x44/0x70
>   ? _raw_read_unlock+0x23/0x40
>   scrub_chunk+0x257/0x4a0
>   scrub_enumerate_chunks+0x64c/0xf70
>   ? __mutex_unlock_slowpath+0x147/0x5f0
>   ? __pfx_scrub_enumerate_chunks+0x10/0x10
>   ? bit_wait_timeout+0xb0/0x170
>   ? __up_read+0x189/0x700
>   ? scrub_workers_get+0x231/0x300
>   ? up_write+0x490/0x4f0
>   btrfs_scrub_dev+0x52e/0xcd0
>   ? create_pending_snapshots+0x230/0x250
>   ? __pfx_btrfs_scrub_dev+0x10/0x10
>   btrfs_dev_replace_by_ioctl+0xd69/0x1d00
>   ? lock_acquire+0x19d/0x4a0
>   ? __pfx_btrfs_dev_replace_by_ioctl+0x10/0x10
>   ? lock_release+0x20e/0x710
>   ? btrfs_ioctl+0xa09/0x74f0
>   ? __pfx_lock_release+0x10/0x10
>   ? do_raw_spin_lock+0x11e/0x240
>   ? __pfx_do_raw_spin_lock+0x10/0x10
>   btrfs_ioctl+0xa14/0x74f0
>   ? lock_acquire+0x19d/0x4a0
>   ? find_held_lock+0x2d/0x110
>   ? __pfx_btrfs_ioctl+0x10/0x10
>   ? lock_release+0x20e/0x710
>   ? do_sigaction+0x3f0/0x860
>   ? __pfx_do_vfs_ioctl+0x10/0x10
>   ? do_raw_spin_lock+0x11e/0x240
>   ? lockdep_hardirqs_on_prepare+0x270/0x3e0
>   ? _raw_spin_unlock_irq+0x28/0x50
>   ? do_sigaction+0x3f0/0x860
>   ? __pfx_do_sigaction+0x10/0x10
>   ? __x64_sys_rt_sigaction+0x18e/0x1e0
>   ? __pfx___x64_sys_rt_sigaction+0x10/0x10
>   ? __x64_sys_close+0x7c/0xd0
>   __x64_sys_ioctl+0x137/0x190
>   do_syscall_64+0x71/0x140
>   entry_SYSCALL_64_after_hwframe+0x76/0x7e
>  RIP: 0033:0x7f0bd1114f9b
>  Code: Unable to access opcode bytes at 0x7f0bd1114f71.
>  RSP: 002b:00007ffc8a8c3130 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>  RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f0bd1114f9b
>  RDX: 00007ffc8a8c35e0 RSI: 00000000ca289435 RDI: 0000000000000003
>  RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000007
>  R10: 0000000000000008 R11: 0000000000000246 R12: 00007ffc8a8c6c85
>  R13: 00000000398e72a0 R14: 0000000000004361 R15: 0000000000000004
>   </TASK>
> 
> This happens because on RAID stripe-tree filesystems we recurse back into
> btrfs_map_block() on scrub to perform the logical to device physical
> mapping.
> 
> But as the device replace task is already holding the dev_replace::rwsem
> we deadlock.
> 
> So don't take the dev_replace::rwsem in case our task is the task performing
> the device replace.
> 
> Suggested-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/dev-replace.c | 2 ++
>  fs/btrfs/fs.h          | 2 ++
>  fs/btrfs/volumes.c     | 4 +++-
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
> index 83d5cdd77f29..604399e59a3d 100644
> --- a/fs/btrfs/dev-replace.c
> +++ b/fs/btrfs/dev-replace.c
> @@ -641,6 +641,7 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
>  		return ret;
>  
>  	down_write(&dev_replace->rwsem);
> +	dev_replace->replace_task = current;
>  	switch (dev_replace->replace_state) {
>  	case BTRFS_IOCTL_DEV_REPLACE_STATE_NEVER_STARTED:
>  	case BTRFS_IOCTL_DEV_REPLACE_STATE_FINISHED:
> @@ -994,6 +995,7 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
>  	list_add(&tgt_device->dev_alloc_list, &fs_devices->alloc_list);
>  	fs_devices->rw_devices++;
>  
> +	dev_replace->replace_task = NULL;
>  	up_write(&dev_replace->rwsem);
>  	btrfs_rm_dev_replace_blocked(fs_info);
>  
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 3d6d4b503220..53824da92cc3 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -317,6 +317,8 @@ struct btrfs_dev_replace {
>  
>  	struct percpu_counter bio_counter;
>  	wait_queue_head_t replace_wait;
> +
> +	struct task_struct *replace_task;

Wasn't the idea to use pid for that, and not a raw pointer?

