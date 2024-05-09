Return-Path: <linux-btrfs+bounces-4875-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C52558C1431
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 19:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36FF0B21516
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 17:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D52D59158;
	Thu,  9 May 2024 17:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ld+bpno0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="L7wWj9NU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BXuP85l2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SBKGjAyo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07DB54BE0
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 17:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715276399; cv=none; b=q4eUn7SNyAMjD5p9RVHlHBXhi4DH9ZAZeTukxxCkggcMh2kyhYag+1LTkRbq0wG/W37yi9lOHDt71s+Xp/fNAyLNL7XDzLWZua60mi582+xHp+tPiKDLMwFNjVJrgNLGUSIULt6XFRppLYsEUftIqRSjEI1/0YMv4H4hPpzjxvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715276399; c=relaxed/simple;
	bh=tEUhP0g6342f2f443uQvIOvcfXxk1j2dZ7y0egwwt78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNIWj9B6IbHUABPS9jf8grZ1ZWNp1TPyDjAuJIZ2t/IzF91fvPRLeUhsmRGhGaeLglTy6X3AoOMoeokRd84geXsaqY2C8V6zYz92ZR4FdrIkPjiEqPIO16YGRYx8F/S9wipAJsVdoWEx30JC9KEDurnFpKcs8YTgtMlcQ4N7Atg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ld+bpno0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=L7wWj9NU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BXuP85l2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SBKGjAyo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D125D38A6F;
	Thu,  9 May 2024 17:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715276396;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=26wEIv47SUpIQ5CHYtgHaSRZ8kVDmr2pSq0bY3sdOPU=;
	b=ld+bpno0icZe8zTqx96HTPd1vxhp6qSyIaty3wNIhYe6AW5uvLu7Fdj+BGGircZ/AL+quT
	dzrvAK1+EtLjkWLVb7ybebXX5locYVpqwNJVtgVqE7uX6K0cto1JarjUT2qLCVCnQG7NpS
	mX4HdC4dPnDnBwWhmM+vtR8eKJUsxBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715276396;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=26wEIv47SUpIQ5CHYtgHaSRZ8kVDmr2pSq0bY3sdOPU=;
	b=L7wWj9NUfNm+nfwypR+XLjA1Z/WcPxj1gLmdCKiaizPZgfcXivoX3y4KrMggEERTBIHFAR
	BrVWg5x2cqRuXgDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BXuP85l2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=SBKGjAyo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715276395;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=26wEIv47SUpIQ5CHYtgHaSRZ8kVDmr2pSq0bY3sdOPU=;
	b=BXuP85l2vhe+mZjg8slJN36Dx0N5wtZqrHk+VUNmF7jdZ+1Pb1AYVTuRXjTQLTkq3Y1pk7
	MxJm1woOe92Y+NNh2UqSrTYyO9BBPxss4X4WPL/MinfWUY2qIxcIDdUkNpRSnAmAU9azrP
	rePbgvvr80zTgcJUDqLBLZQL5/p2KW4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715276395;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=26wEIv47SUpIQ5CHYtgHaSRZ8kVDmr2pSq0bY3sdOPU=;
	b=SBKGjAyoswa/CRntOQ5boQuSGHMYzJcs0sYjwTsWlXBa4Etwg2bcE3fc4twvcux+W8n5Z1
	3ADTp7iNon3fp7CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A738113A24;
	Thu,  9 May 2024 17:39:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WzuiKGsKPWYMOAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 09 May 2024 17:39:55 +0000
Date: Thu, 9 May 2024 19:39:52 +0200
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 0/2] don't hold dev_replace rwsem over whole of
 btrfs_map_block
Message-ID: <20240509173952.GM13977@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240508114016.18119-1-jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508114016.18119-1-jth@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.07 / 50.00];
	BAYES_HAM(-2.86)[99.39%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[opensuse.org:url,suse.cz:dkim,suse.cz:replyto]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D125D38A6F
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.07

On Wed, May 08, 2024 at 01:40:14PM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> This is the v2 of 'btrfs: don't hold dev_replace rwsem over whole of
> btrfs_map_block' sent as a series as I've added a 2nd patch, which
> I've came accross while looking at the code.
> 
> @Filipe, unfortunately I can't find the original report from the CI
> anymore, so I don't have the stacktrace handy.

I can reproduce it. Please edit it a bit for the of changelog.

[ 1022.275649] ============================================
[ 1022.276151] WARNING: possible recursive locking detected
[ 1022.277976] 6.9.0-rc7-default+ #417 Not tainted
[ 1022.278419] --------------------------------------------
[ 1022.278916] btrfs/27578 is trying to acquire lock:
[ 1022.279372] ffff888107385ec8 (&fs_info->dev_replace.rwsem){++++}-{3:3}, at: btrfs_map_block+0x25b/0x11e0
[ 1022.280228] 
               but task is already holding lock:
[ 1022.280786] ffff888107385ec8 (&fs_info->dev_replace.rwsem){++++}-{3:3}, at: btrfs_map_block+0x25b/0x11e0
[ 1022.281722] 
               other info that might help us debug this:
[ 1022.282405]  Possible unsafe locking scenario:

[ 1022.282863]        CPU0
[ 1022.283087]        ----
[ 1022.283311]   lock(&fs_info->dev_replace.rwsem);
[ 1022.283676]   lock(&fs_info->dev_replace.rwsem);
[ 1022.284036] 
                *** DEADLOCK ***

[ 1022.284526]  May be due to missing lock nesting notation

[ 1022.285077] 1 lock held by btrfs/27578:
[ 1022.285394]  #0: ffff888107385ec8 (&fs_info->dev_replace.rwsem){++++}-{3:3}, at: btrfs_map_block+0x25b/0x11e0
[ 1022.286109] 
               stack backtrace:
[ 1022.286482] CPU: 3 PID: 27578 Comm: btrfs Not tainted 6.9.0-rc7-default+ #417
[ 1022.287008] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
[ 1022.287924] Call Trace:
[ 1022.288189]  <TASK>
[ 1022.288433]  dump_stack_lvl+0x61/0x80
[ 1022.288799]  validate_chain+0x6ef/0xcc0
[ 1022.289179]  ? check_prev_add+0x12f0/0x12f0
[ 1022.289581]  ? mark_lock+0xe3/0xa10
[ 1022.289936]  __lock_acquire+0x8cf/0xda0
[ 1022.290324]  lock_acquire+0x149/0x3e0
[ 1022.290673]  ? btrfs_map_block+0x25b/0x11e0
[ 1022.291086]  ? lock_sync+0xd0/0xd0
[ 1022.291432]  ? lock_is_held_type+0x83/0xf0
[ 1022.291831]  ? __might_resched+0x162/0x240
[ 1022.292232]  ? rcu_read_unlock+0x80/0x80
[ 1022.292617]  down_read+0x9a/0x370
[ 1022.292959]  ? btrfs_map_block+0x25b/0x11e0
[ 1022.293419]  ? rwsem_down_read_slowpath+0x740/0x740
[ 1022.293876]  ? do_raw_read_unlock+0x23/0x50
[ 1022.294278]  ? _raw_read_unlock+0x1a/0x30
[ 1022.294667]  btrfs_map_block+0x25b/0x11e0
[ 1022.295057]  ? btrfs_map_discard+0x4e0/0x4e0
[ 1022.295478]  ? btrfs_bio_counter_sub+0x70/0x70
[ 1022.295912]  btrfs_submit_chunk+0x1a2/0x950
[ 1022.296313]  ? btrfs_bio_init+0x80/0x80
[ 1022.296691]  ? bio_check_pages_dirty+0x390/0x390
[ 1022.297159]  ? do_raw_spin_unlock+0x8d/0xe0
[ 1022.297652]  ? alloc_test_extent_buffer+0x2c0/0x2c0
[ 1022.298168]  btrfs_submit_bio+0x1c/0x40
[ 1022.298627]  read_extent_buffer_pages+0x26e/0x3b0
[ 1022.299068]  btrfs_read_extent_buffer+0xe1/0x300
[ 1022.299605]  read_tree_block+0x55/0x80
[ 1022.300039]  read_block_for_search+0x3ca/0x520
[ 1022.300500]  ? btrfs_release_path+0x1e0/0x1e0
[ 1022.300937]  ? lock_is_held_type+0x83/0xf0
[ 1022.301414]  ? btrfs_search_slot_get_root+0x280/0x520
[ 1022.301961]  ? __might_sleep+0x28/0xd0
[ 1022.302360]  btrfs_search_slot+0x4a3/0x13b0
[ 1022.302801]  ? balance_level+0x15c0/0x15c0
[ 1022.303195]  ? rcu_is_watching+0x1c/0x40
[ 1022.303648]  ? kmem_cache_alloc+0x262/0x2f0
[ 1022.304076]  ? find_held_lock+0x8a/0xa0
[ 1022.304543]  btrfs_get_raid_extent_offset+0x14e/0x600
[ 1022.305091]  ? btrfs_insert_raid_extent+0x160/0x160
[ 1022.305617]  ? down_read+0xb7/0x370
[ 1022.306027]  ? down_read+0x2e/0x370
[ 1022.306446]  ? set_io_stripe+0x9d/0x140
[ 1022.306924]  btrfs_map_block+0x3e7/0x11e0
[ 1022.307404]  ? btrfs_map_discard+0x4e0/0x4e0
[ 1022.307917]  ? scrub_write_endio+0x1c0/0x1c0
[ 1022.308422]  ? btrfs_bio_init+0x67/0x80
[ 1022.308842]  scrub_submit_extent_sector_read.isra.0+0x308/0x630
[ 1022.309434]  ? scrub_stripe_submit_repair_read+0x440/0x440
[ 1022.310062]  ? _find_next_bit+0x37/0xc0
[ 1022.310483]  ? scrub_submit_initial_read+0x139/0x3e0
[ 1022.311040]  submit_initial_group_read+0x175/0x330
[ 1022.311617]  ? reacquire_held_locks+0x280/0x280
[ 1022.312118]  ? scrub_submit_initial_read+0x3e0/0x3e0
[ 1022.312725]  ? scrub_simple_mirror.isra.0+0x1e9/0x380
[ 1022.313292]  scrub_simple_mirror.isra.0+0x2e7/0x380
[ 1022.313808]  scrub_stripe+0x76d/0x7d0
[ 1022.314255]  ? __lock_acquired+0x1ee/0x400
[ 1022.314740]  ? scrub_setup_ctx+0x210/0x210
[ 1022.315212]  ? btrfs_find_chunk_map+0x37/0x50
[ 1022.315696]  ? do_raw_read_unlock+0x23/0x50
[ 1022.316228]  scrub_chunk+0x137/0x200
[ 1022.316690]  scrub_enumerate_chunks+0x539/0x960
[ 1022.317169]  ? scrub_chunk+0x200/0x200
[ 1022.317608]  ? bit_wait_io_timeout+0x10/0xc0
[ 1022.318101]  ? __up_read+0x175/0x4c0
[ 1022.318558]  ? _down_write_nest_lock+0x190/0x1c0
[ 1022.319067]  ? btrfs_dev_name+0xb0/0xb0
[ 1022.319514]  ? btrfs_scrub_dev+0x313/0x820
[ 1022.320034]  btrfs_scrub_dev+0x3e4/0x820
[ 1022.320518]  ? cleanup_transaction+0x100/0x100
[ 1022.321043]  ? scrub_print_warning_inode+0x540/0x540
[ 1022.321613]  btrfs_dev_replace_start+0x41f/0x550
[ 1022.322150]  ? btrfs_dev_replace_finishing+0xa60/0xa60
[ 1022.322735]  ? do_raw_spin_trylock+0xc7/0x110
[ 1022.323205]  ? do_raw_spin_lock+0x1a0/0x1a0
[ 1022.323581]  btrfs_dev_replace_by_ioctl+0x8e/0xf0
[ 1022.323951]  btrfs_ioctl+0x4cf/0x17c0
[ 1022.324333]  ? do_sigaction+0x234/0x420
[ 1022.324652]  ? btrfs_ioctl_get_supported_features+0x20/0x20
[ 1022.325069]  ? sigaction_compat_abi+0x10/0x10
[ 1022.325494]  ? lock_release+0x9a/0x1a0
[ 1022.325837]  ? __x64_sys_rt_sigaction+0x185/0x1b0
[ 1022.326203]  ? __x64_sys_sigprocmask+0x230/0x230
[ 1022.326682]  ? lockdep_hardirqs_on_prepare+0x13c/0x200
[ 1022.327094]  __x64_sys_ioctl+0xbc/0xe0
[ 1022.327407]  do_syscall_64+0x5b/0xf0
[ 1022.327745]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[ 1022.328217] RIP: 0033:0x7f756e53f3df
[ 1022.330048] RSP: 002b:00007ffd174401c0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[ 1022.330774] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f756e53f3df
[ 1022.331499] RDX: 00007ffd174410b0 RSI: 00000000ca289435 RDI: 0000000000000003
[ 1022.332176] RBP: 00007ffd17440280 R08: 0000000000000000 R09: 0000000000000007
[ 1022.332820] R10: 0000000000000008 R11: 0000000000000246 R12: 00007ffd17443f9e
[ 1022.333452] R13: 0000555f1341a2a0 R14: 0000000000000000 R15: 0000000000000004
[ 1022.334082]  </TASK>

