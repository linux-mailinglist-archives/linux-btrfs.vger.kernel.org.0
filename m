Return-Path: <linux-btrfs+bounces-4876-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE3D8C143B
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 19:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFD58B22010
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 17:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9946FB9D;
	Thu,  9 May 2024 17:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eZqR11Jo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aOKp0hn+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eZqR11Jo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aOKp0hn+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ACF6CDDB
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 17:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715276591; cv=none; b=DDzcYS9rUvGwZqrsJCyh9h/YJ3C1XHrH4v8qGhGhtKrYKLCnUThMPM5FfFIxbLKpRgNkWulBQL69JIANfNW2ofVHnLwiwBsTZCn6wQAIKK/hu1fy88xUG6tCEVvAUZd01nq6btH8AXao8opwQYbp22sB6wBEneeytxOmVC2jCwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715276591; c=relaxed/simple;
	bh=c9Pkxb6Vcfy/oQsp6CdvS0c2z9nf8VbtJeWhOr2z+OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOX/aNnm/cAJaLtDtvrIeQSDY55YckZQzX4BqBIGvw3H5syl5tbypzzbw0oQoxSXBKdwxxaXQAq2q8ppuReg3k6XjohiHcuMnYqseOpk7++P5OKMnqMYzq9G4pvWIbdPMyfMXhV2SaatCOkTTf/2ylCS3gr7hYkvoxtqQ3LAP8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eZqR11Jo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aOKp0hn+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eZqR11Jo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aOKp0hn+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C260C38A81;
	Thu,  9 May 2024 17:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715276586;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rOljxOWKRQLrnC0v9Yvs4gl1qk1pIrZsbWhvPaz/JOM=;
	b=eZqR11JooCl6Yh2sWoBkKsvFDEpIkS7XlOvFYuwR4GjkmNGXmeFU5xd5nS5H5+Bqzj2hSs
	X+fqGYzIZorz95wCAvwKAu5XFyj2GdDIpukw9hP9z5oiB99REVr+vlaQYM6/OijVtXikUQ
	sDPFkWANnsIKWWAH2J0Nwdi11QY1HuA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715276586;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rOljxOWKRQLrnC0v9Yvs4gl1qk1pIrZsbWhvPaz/JOM=;
	b=aOKp0hn+12fJWmfG2ByCpfn6PIfgoFxNhigvuIrlxAurD2HW2AT6DZtNxTKYAKn96dkpYf
	9ljeBPfE5EfKdLAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eZqR11Jo;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=aOKp0hn+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715276586;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rOljxOWKRQLrnC0v9Yvs4gl1qk1pIrZsbWhvPaz/JOM=;
	b=eZqR11JooCl6Yh2sWoBkKsvFDEpIkS7XlOvFYuwR4GjkmNGXmeFU5xd5nS5H5+Bqzj2hSs
	X+fqGYzIZorz95wCAvwKAu5XFyj2GdDIpukw9hP9z5oiB99REVr+vlaQYM6/OijVtXikUQ
	sDPFkWANnsIKWWAH2J0Nwdi11QY1HuA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715276586;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rOljxOWKRQLrnC0v9Yvs4gl1qk1pIrZsbWhvPaz/JOM=;
	b=aOKp0hn+12fJWmfG2ByCpfn6PIfgoFxNhigvuIrlxAurD2HW2AT6DZtNxTKYAKn96dkpYf
	9ljeBPfE5EfKdLAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A39813A24;
	Thu,  9 May 2024 17:43:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mDp+JSoLPWb8OAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 09 May 2024 17:43:06 +0000
Date: Thu, 9 May 2024 19:43:03 +0200
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 0/2] don't hold dev_replace rwsem over whole of
 btrfs_map_block
Message-ID: <20240509174303.GN13977@twin.jikos.cz>
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
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C260C38A81
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[opensuse.org:url,suse.cz:dkim,suse.cz:replyto];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]

On Wed, May 08, 2024 at 01:40:14PM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> This is the v2 of 'btrfs: don't hold dev_replace rwsem over whole of
> btrfs_map_block' sent as a series as I've added a 2nd patch, which
> I've came accross while looking at the code.
> 
> @Filipe, unfortunately I can't find the original report from the CI
> anymore, so I don't have the stacktrace handy.

And right after the stack trace I found this, it could be the same
use-after-free that Filipe fixed, I haven't analyzed it:

[ 1040.699694] BUG: KASAN: slab-use-after-free in btrfs_insert_one_raid_extent+0x1e2/0x430
[ 1040.700735] Read of size 8 at addr ffff888113385880 by task kworker/u32:12/13766

[ 1040.701948] CPU: 3 PID: 13766 Comm: kworker/u32:12 Not tainted 6.9.0-rc7-default+ #417
[ 1040.702834] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
[ 1040.704167] Workqueue: btrfs-endio-write btrfs_work_helper
[ 1040.704861] Call Trace:
[ 1040.705242]  <TASK>
[ 1040.705581]  dump_stack_lvl+0x61/0x80
[ 1040.706069]  print_address_description.constprop.0+0x75/0x310
[ 1040.706652]  ? btrfs_insert_one_raid_extent+0x1e2/0x430
[ 1040.707315]  print_report+0x118/0x216
[ 1040.707837]  ? btrfs_insert_one_raid_extent+0x1e2/0x430
[ 1040.708434]  ? __virt_addr_valid+0x11e/0x2b0
[ 1040.708877]  ? btrfs_insert_one_raid_extent+0x1e2/0x430
[ 1040.709507]  kasan_report+0x11d/0x1f0
[ 1040.710013]  ? btrfs_insert_one_raid_extent+0x1e2/0x430
[ 1040.710677]  btrfs_insert_one_raid_extent+0x1e2/0x430
[ 1040.711313]  ? record_root_in_trans+0x164/0x1a0
[ 1040.711781]  ? btrfs_lru_cache_clear+0x80/0x80
[ 1040.712232]  ? btrfs_record_root_in_trans+0xa8/0xc0
[ 1040.712716]  ? start_transaction+0x154/0xa50
[ 1040.713154]  btrfs_insert_raid_extent+0x9d/0x160
[ 1040.713681]  btrfs_finish_one_ordered+0x5af/0xb60
[ 1040.714220]  ? rcu_is_watching+0x1c/0x40
[ 1040.714712]  ? lock_acquire+0xc1/0x3e0
[ 1040.715220]  ? btrfs_unlink_subvol+0x650/0x650
[ 1040.715705]  ? do_raw_spin_trylock+0xc7/0x110
[ 1040.716274]  btrfs_work_helper+0x118/0x310
[ 1040.716822]  ? rcu_is_watching+0x1c/0x40
[ 1040.717329]  process_one_work+0x4be/0x9f0
[ 1040.717750]  ? pwq_dec_nr_in_flight+0x250/0x250
[ 1040.718350]  ? __list_add_valid_or_report+0x3f/0x70
[ 1040.718980]  worker_thread+0x38d/0x680
[ 1040.720200]  ? __kthread_parkme+0xc8/0xe0
[ 1040.720764]  ? rescuer_thread+0x5e0/0x5e0
[ 1040.721307]  kthread+0x171/0x1b0
[ 1040.723690]  ? kthread+0xe5/0x1b0
[ 1040.724181]  ? kthread_complete_and_exit+0x20/0x20
[ 1040.724782]  ret_from_fork+0x28/0x50
[ 1040.726471]  ? kthread_complete_and_exit+0x20/0x20
[ 1040.726930]  ret_from_fork_asm+0x11/0x20
[ 1040.727415]  </TASK>

[ 1040.727863] Allocated by task 27528:
[ 1040.728109]  kasan_save_stack+0x37/0x60
[ 1040.728360]  kasan_save_track+0x10/0x30
[ 1040.728602]  __kasan_kmalloc+0x83/0x90
[ 1040.728845]  btrfs_alloc_device+0xa4/0x2e0
[ 1040.729094]  btrfs_init_dev_replace_tgtdev.constprop.0+0x1a4/0x4b0
[ 1040.729444]  btrfs_dev_replace_start+0xdf/0x550
[ 1040.729713]  btrfs_dev_replace_by_ioctl+0x8e/0xf0
[ 1040.730010]  btrfs_ioctl+0x4cf/0x17c0
[ 1040.730292]  __x64_sys_ioctl+0xbc/0xe0
[ 1040.730836]  do_syscall_64+0x5b/0xf0
[ 1040.731352]  entry_SYSCALL_64_after_hwframe+0x4b/0x53

[ 1040.732308] Freed by task 27578:
[ 1040.732780]  kasan_save_stack+0x37/0x60
[ 1040.733458]  kasan_save_track+0x10/0x30
[ 1040.733982]  kasan_save_free_info+0x37/0x50
[ 1040.734454]  poison_slab_object+0x19d/0x1e0
[ 1040.734908]  __kasan_slab_free+0x10/0x30
[ 1040.735287]  kfree+0xf8/0x2d0
[ 1040.735750]  btrfs_rm_dev_replace_free_srcdev+0x7a/0x150
[ 1040.736377]  btrfs_dev_replace_finishing+0x90d/0xa60
[ 1040.736983]  btrfs_dev_replace_start+0x429/0x550
[ 1040.737552]  btrfs_dev_replace_by_ioctl+0x8e/0xf0
[ 1040.738113]  btrfs_ioctl+0x4cf/0x17c0
[ 1040.738601]  __x64_sys_ioctl+0xbc/0xe0
[ 1040.739155]  do_syscall_64+0x5b/0xf0
[ 1040.739759]  entry_SYSCALL_64_after_hwframe+0x4b/0x53

[ 1040.740712] The buggy address belongs to the object at ffff888113385800
                which belongs to the cache kmalloc-1k of size 1024
[ 1040.741932] The buggy address is located 128 bytes inside of
                freed 1024-byte region [ffff888113385800, ffff888113385c00)

[ 1040.743275] The buggy address belongs to the physical page:
[ 1040.743997] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x113380
[ 1040.745033] head: order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[ 1040.745867] flags: 0x4500000000840(slab|head|section=34|zone=2)
[ 1040.746766] page_type: 0xffffffff()
[ 1040.747241] raw: 0004500000000840 ffff8881000430c0 ffff88813f3c7210 ffff88813f304e10
[ 1040.747981] raw: 0000000000000000 00000000000a000a 00000001ffffffff 0000000000000000
[ 1040.748723] head: 0004500000000840 ffff8881000430c0 ffff88813f3c7210 ffff88813f304e10
[ 1040.749474] head: 0000000000000000 00000000000a000a 00000001ffffffff 0000000000000000
[ 1040.750291] head: 0004500000000003 ffff88813f2ce001 dead000000000122 00000000ffffffff
[ 1040.751227] head: 0000000800000000 0000000000000000 00000000ffffffff 0000000000000000
[ 1040.751961] page dumped because: kasan: bad access detected

[ 1040.752735] Memory state around the buggy address:
[ 1040.753213]  ffff888113385780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[ 1040.753960]  ffff888113385800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 1040.754660] >ffff888113385880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 1040.755360]                    ^
[ 1040.755725]  ffff888113385900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 1040.756435]  ffff888113385980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 1040.757274] ==================================================================
[ 1041.613686] BTRFS info (device vdd): scrub: started on devid 1
[ 1041.613740] BTRFS info (device vdd): scrub: started on devid 2
[ 1042.472852] assertion failed: i < stripe->nr_sectors, in fs/btrfs/scrub.c:753
[ 1042.473680] ------------[ cut here ]------------
[ 1042.474180] kernel BUG at fs/btrfs/scrub.c:753!
[ 1042.474550] invalid opcode: 0000 [#1] PREEMPT SMP KASAN
[ 1042.474954] CPU: 0 PID: 27589 Comm: btrfs Tainted: G    B              6.9.0-rc7-default+ #417
[ 1042.475640] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
[ 1042.476821] RIP: 0010:calc_sector_number.cold+0x3d/0x5d
[ 1042.477428] Code: a5 ff 8b 4c 24 08 e9 a9 8d 7c ff b9 f1 02 00 00 48 c7 c2 00 ac 38 a4 48 c7 c6 e0 b1 38 a4 48 c7 c7 c0 ac 38 a4 e8 0e 8d fb ff <0f> 0b 89 ca 48 89 ee 48 c7 c7 c0 1b ea a4 89 4c 24 08 e8 d7 52 a5
[ 1042.479196] RSP: 0018:ffff8881066cf5a0 EFLAGS: 00010286
[ 1042.479840] RAX: 0000000000000041 RBX: ffff8881033e89c0 RCX: 0000000000000000
[ 1042.480706] RDX: 0000000000000041 RSI: ffffffffa3137b3d RDI: ffffed1020cd9ea7
[ 1042.481511] RBP: 000000000000000f R08: 0000000000000000 R09: fffffbfff4957b9c
[ 1042.482360] R10: 0000000000000003 R11: 0000000000000001 R12: ffff88810654f080
[ 1042.483170] R13: 0000000000000010 R14: ffff88813f3c6ec0 R15: ffff8881033e8a72
[ 1042.483957] FS:  00007fd36967e6c0(0000) GS:ffff888119600000(0000) knlGS:0000000000000000
[ 1042.484860] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1042.485584] CR2: 00005586a760b560 CR3: 0000000100e82000 CR4: 00000000000006b0
[ 1042.486319] Call Trace:
[ 1042.486620]  <TASK>
[ 1042.486940]  ? show_trace_log_lvl+0x1e9/0x2e0
[ 1042.487501]  ? scrub_read_endio+0x5a/0x290
[ 1042.488060]  ? __die+0x4f/0x8c
[ 1042.488513]  ? die+0x25/0x40
[ 1042.488855]  ? do_trap+0x125/0x180
[ 1042.489277]  ? calc_sector_number.cold+0x3d/0x5d
[ 1042.489878]  ? calc_sector_number.cold+0x3d/0x5d
[ 1042.490488]  ? do_error_trap+0x8b/0x130
[ 1042.491002]  ? calc_sector_number.cold+0x3d/0x5d
[ 1042.491541]  ? handle_invalid_op+0x38/0x40
[ 1042.492009]  ? calc_sector_number.cold+0x3d/0x5d
[ 1042.492542]  ? exc_invalid_op+0x29/0x40
[ 1042.493035]  ? asm_exc_invalid_op+0x16/0x20
[ 1042.493575]  ? this_cpu_in_panic+0x1d/0x30
[ 1042.494034]  ? calc_sector_number.cold+0x3d/0x5d
[ 1042.494535]  scrub_read_endio+0x5a/0x290
[ 1042.495058]  scrub_submit_extent_sector_read.isra.0+0x60a/0x630
[ 1042.495695]  ? scrub_stripe_submit_repair_read+0x440/0x440
[ 1042.496321]  ? _find_next_bit+0x37/0xc0
[ 1042.496855]  ? scrub_submit_initial_read+0x139/0x3e0
[ 1042.497367]  submit_initial_group_read+0x175/0x330
[ 1042.497926]  ? lock_sync+0xd0/0xd0
[ 1042.498329]  ? scrub_submit_initial_read+0x3e0/0x3e0
[ 1042.498885]  ? rcu_read_unlock+0x80/0x80
[ 1042.499383]  scrub_simple_mirror.isra.0+0x2e7/0x380
[ 1042.499965]  scrub_stripe+0x76d/0x7d0
[ 1042.500469]  ? rcu_is_watching+0x1c/0x40
[ 1042.500898]  ? rcu_is_watching+0x1c/0x40
[ 1042.501399]  ? scrub_setup_ctx+0x210/0x210
[ 1042.501887]  ? __down_write_trylock+0xf8/0x260
[ 1042.502428]  ? down_read_trylock+0x50/0x50
[ 1042.502977]  ? __might_resched+0x162/0x240
[ 1042.503462]  ? rcu_read_unlock+0x80/0x80
[ 1042.503980]  ? do_raw_read_unlock+0x23/0x50
[ 1042.504501]  scrub_chunk+0x137/0x200
[ 1042.505023]  scrub_enumerate_chunks+0x539/0x960
[ 1042.505594]  ? scrub_chunk+0x200/0x200
[ 1042.506084]  ? do_raw_spin_unlock+0x8d/0xe0
[ 1042.506562]  ? bit_wait_io_timeout+0x10/0xc0
[ 1042.507087]  ? do_raw_spin_trylock+0xc7/0x110
[ 1042.507635]  btrfs_scrub_dev+0x3e4/0x820
[ 1042.508105]  ? scrub_print_warning_inode+0x540/0x540
[ 1042.508666]  ? mnt_get_write_access+0x6a/0x120
[ 1042.509177]  ? mnt_get_write_access+0xfd/0x120
[ 1042.509788]  btrfs_ioctl+0x79d/0x17c0
[ 1042.510236]  ? btrfs_ioctl_get_supported_features+0x20/0x20
[ 1042.510852]  ? lock_sync+0xd0/0xd0
[ 1042.511274]  ? do_raw_spin_trylock+0xc7/0x110
[ 1042.511751]  ? do_raw_spin_lock+0x1a0/0x1a0
[ 1042.512374]  ? rcu_is_watching+0x1c/0x40
[ 1042.512957]  ? rcu_is_watching+0x1c/0x40
[ 1042.513538]  ? lock_release+0x52/0x1a0
[ 1042.514104]  ? __fget_files+0x13b/0x230
[ 1042.514669]  __x64_sys_ioctl+0xbc/0xe0
[ 1042.515235]  do_syscall_64+0x5b/0xf0
[ 1042.515777]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[ 1042.516471] RIP: 0033:0x7fd369fa03df
[ 1042.516968] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
[ 1042.518755] RSP: 002b:00007fd36967dc80 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[ 1042.519784] RAX: ffffffffffffffda RBX: 00005627eeea1758 RCX: 00007fd369fa03df
[ 1042.520548] RDX: 00005627eeea1758 RSI: 00000000c400941b RDI: 0000000000000003
[ 1042.521301] RBP: 0000000000000000 R08: 00007fd36967e6c0 R09: 32203a6b63617473
[ 1042.521944] R10: 0000000000000000 R11: 0000000000000246 R12: fffffffffffffdb8
[ 1042.522786] R13: 0000000000000002 R14: 00007ffecdb6f450 R15: 00007fd368e7e000
[ 1042.523695]  </TASK>
[ 1042.523965] Modules linked in: loop
[ 1042.524367] ---[ end trace 0000000000000000 ]---
[ 1042.524856] RIP: 0010:calc_sector_number.cold+0x3d/0x5d
[ 1042.525382] Code: a5 ff 8b 4c 24 08 e9 a9 8d 7c ff b9 f1 02 00 00 48 c7 c2 00 ac 38 a4 48 c7 c6 e0 b1 38 a4 48 c7 c7 c0 ac 38 a4 e8 0e 8d fb ff <0f> 0b 89 ca 48 89 ee 48 c7 c7 c0 1b ea a4 89 4c 24 08 e8 d7 52 a5
[ 1042.527082] RSP: 0018:ffff8881066cf5a0 EFLAGS: 00010286
[ 1042.527686] RAX: 0000000000000041 RBX: ffff8881033e89c0 RCX: 0000000000000000
[ 1042.528388] RDX: 0000000000000041 RSI: ffffffffa3137b3d RDI: ffffed1020cd9ea7
[ 1042.529109] RBP: 000000000000000f R08: 0000000000000000 R09: fffffbfff4957b9c
[ 1042.529830] R10: 0000000000000003 R11: 0000000000000001 R12: ffff88810654f080
[ 1042.530583] R13: 0000000000000010 R14: ffff88813f3c6ec0 R15: ffff8881033e8a72
[ 1042.531412] FS:  00007fd36967e6c0(0000) GS:ffff888119600000(0000) knlGS:0000000000000000
[ 1042.534519] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1042.535162] CR2: 00005586a760b560 CR3: 0000000100e82000 CR4: 00000000000006b0

