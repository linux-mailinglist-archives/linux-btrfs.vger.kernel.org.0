Return-Path: <linux-btrfs+bounces-5021-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B55E8C6C2B
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 20:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F4FE1C21360
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 18:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2E9446AC;
	Wed, 15 May 2024 18:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jSe9pE7C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ASx6/Mqv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jSe9pE7C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ASx6/Mqv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A88A2E622
	for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2024 18:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715797878; cv=none; b=VPhIY6noq1B5mkRLRyV8xRTKvD6UQNvBbMOAx3kAMspbXASnB4waxvgsEw/WVTLOUsJrWxHC30kJR9EK+DOctKMnFFEGDH0THSrVZc2g4CG4Ctsf/ARUwuuCz/Qk4R2L2+7Q7Oa6+5+lljX3u0zW6uoP7jFYIl1OtzwPpIczQl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715797878; c=relaxed/simple;
	bh=ToAgG+w28LO7N7M57lvL0ChnxoS8e2dgtJqsTPqAsR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcheWfu5DbBJPUH5gHzhJX7ISslAVnZwJ2vhc7mmkCakAY6c2emzYk02cn3v3Df+XaEHXYvuzanEFL6aXfCfBiH5rR+iw7Ccb9FjeBQERM6ajUl6HOAiAPyvnzsswO7p29+nlPQJ9nhuSNd8N7wHCquM07bwC/fhAOMP0+E+Hms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jSe9pE7C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ASx6/Mqv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jSe9pE7C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ASx6/Mqv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 93DA520A6E;
	Wed, 15 May 2024 18:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715797873;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6ieiZ56SA8+hzKsESHaz8bDp/TFnTPFHOEeSSjueb0M=;
	b=jSe9pE7CLgP7j4ucUx0WZmU3qxZsYJMbpuumn8zSdkW6cZNoIraZLMZIhrmxEjADuQIB7p
	8gJ2UOqKCbR4J60c73D0y9ZfL3EZ2rwss6pV2F4emhYH4jxUSj7Zlg3szFo5l70e+QApBm
	AAdwEvbr4KTvfdGk7xpiRoHbOw2PAlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715797873;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6ieiZ56SA8+hzKsESHaz8bDp/TFnTPFHOEeSSjueb0M=;
	b=ASx6/MqvjkmjE7hqIE3GjivR7z9vIa0ppzeQbzDTBrAjVI9HyUNUPT0ZUAkhFmmU60+HQu
	ha25UO+aHwK959BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715797873;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6ieiZ56SA8+hzKsESHaz8bDp/TFnTPFHOEeSSjueb0M=;
	b=jSe9pE7CLgP7j4ucUx0WZmU3qxZsYJMbpuumn8zSdkW6cZNoIraZLMZIhrmxEjADuQIB7p
	8gJ2UOqKCbR4J60c73D0y9ZfL3EZ2rwss6pV2F4emhYH4jxUSj7Zlg3szFo5l70e+QApBm
	AAdwEvbr4KTvfdGk7xpiRoHbOw2PAlc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715797873;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6ieiZ56SA8+hzKsESHaz8bDp/TFnTPFHOEeSSjueb0M=;
	b=ASx6/MqvjkmjE7hqIE3GjivR7z9vIa0ppzeQbzDTBrAjVI9HyUNUPT0ZUAkhFmmU60+HQu
	ha25UO+aHwK959BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67F861372E;
	Wed, 15 May 2024 18:31:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nVM8GXH/RGa5CgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 15 May 2024 18:31:13 +0000
Date: Wed, 15 May 2024 20:31:08 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: raid56: do extra dumping for
 CONFIG_BTRFS_ASSERT
Message-ID: <20240515183108.GX4449@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <9841445a77c4721b7f5c92e642f7e1abf8689d8a.1715744555.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9841445a77c4721b7f5c92e642f7e1abf8689d8a.1715744555.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,opensuse.org:url]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Wed, May 15, 2024 at 01:14:01PM +0930, Qu Wenruo wrote:
> There are several hard-to-hit ASSERT()s hit inside raid56.
> Unfortunately the ASSERT() expression is a little complex, and except
> the ASSERT(), there is nothing to provide any clue.
> 
> Considering if race is involved, it's pretty hard to reproduce.
> Meanwhile sometimes the dump of the rbio structure can provide some
> pretty good clues, it's worthy to do the extra multi-line dump for
> btrfs raid56 related code.
> 
> The dump looks like this:
> 
>  BTRFS critical (device dm-3): bioc logical=4598530048 full_stripe=4598530048 size=0 map_type=0x81 mirror=0 replace_nr_stripes=0 replace_stripe_src=-1 num_stripes=5
>  BTRFS critical (device dm-3):     nr=0 devid=1 physical=1166147584
>  BTRFS critical (device dm-3):     nr=1 devid=2 physical=1145176064
>  BTRFS critical (device dm-3):     nr=2 devid=4 physical=1145176064
>  BTRFS critical (device dm-3):     nr=3 devid=5 physical=1145176064
>  BTRFS critical (device dm-3):     nr=4 devid=3 physical=1145176064
>  BTRFS critical (device dm-3): rbio flags=0x0 nr_sectors=80 nr_data=4 real_stripes=5 stripe_nsectors=16 scrubp=0 dbitmap=0x0
>  BTRFS critical (device dm-3): logical=4598530048
>  assertion failed: orig_logical >= full_stripe_start && orig_logical + orig_len <= full_stripe_start + rbio->nr_data * BTRFS_STRIPE_LEN, in fs/btrfs/raid56.c:1702

For the record I'm posting the logs here too:

[ 2612.426259] BTRFS info (device vdb): first mount of filesystem 5a06f8f6-d1c9-40d3-a2b6-edf82f13e058
[ 2612.428963] BTRFS info (device vdb): using crc32c (crc32c-generic) checksum algorithm
[ 2612.431148] BTRFS info (device vdb): using free-space-tree
[ 2612.447409] BTRFS info (device vdb): checking UUID tree
[ 2612.481386] BTRFS info (device vdb): scrub: started on devid 1
[ 2612.490595] BTRFS info (device vdb): scrub: started on devid 5
[ 2612.491050] BTRFS info (device vdb): scrub: started on devid 6
[ 2612.497397] BTRFS info (device vdb): scrub: started on devid 2
[ 2612.505071] BTRFS info (device vdb): scrub: started on devid 3
[ 2612.517931] BTRFS info (device vdb): scrub: started on devid 7
[ 2612.525959] BTRFS info (device vdb): scrub: started on devid 4
[ 2613.261317] BTRFS info (device vdb): dev_replace from /dev/vdc (devid 2) to /dev/vdi started
[ 2613.263922] BTRFS critical (device vdb): bioc logical=39780352 full_stripe=36569088 size=0 map_type=0x84 mirror=0 replace_nr_stripes=1 replace_stripe_src=0 num_stripes=8
[ 2613.269062] BTRFS critical (device vdb):     nr=0 devid=2 physical=3473408
[ 2613.271803] BTRFS critical (device vdb):     nr=1 devid=3 physical=3473408
[ 2613.273624] BTRFS critical (device vdb):     nr=2 devid=4 physical=3473408
[ 2613.275409] BTRFS critical (device vdb):     nr=3 devid=5 physical=3473408
[ 2613.277037] BTRFS critical (device vdb):     nr=4 devid=6 physical=3473408
[ 2613.278717] BTRFS critical (device vdb):     nr=5 devid=7 physical=3473408
[ 2613.280298] BTRFS critical (device vdb):     nr=6 devid=1 physical=24444928
[ 2613.281886] BTRFS critical (device vdb):     nr=7 devid=0 physical=3473408
[ 2613.283633] BTRFS critical (device vdb): rbio flags=0x0 nr_sectors=112 nr_data=6 real_stripes=7 stripe_nsectors=16 scrubp=0 dbitmap=0x0
[ 2613.286665] BTRFS critical (device vdb): logical=39780352
[ 2613.288042] assertion failed: (orig_logical >= full_stripe_start && orig_logical + orig_len <= full_stripe_start + rbio->nr_data * 0x00010000), in fs/btrfs/raid56.c:1731
[ 2613.291839] ------------[ cut here ]------------
[ 2613.293052] kernel BUG at fs/btrfs/raid56.c:1731!
[ 2613.294208] invalid opcode: 0000 [#1] PREEMPT SMP KASAN
[ 2613.294959] CPU: 0 PID: 17987 Comm: fsstress Not tainted 6.9.0-rc7-default+ #94
[ 2613.294959] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
[ 2613.294959] RIP: 0010:rbio_add_bio.cold+0x8c/0x1a6 [btrfs]
[ 2613.294959] RSP: 0018:ffff888009bb7240 EFLAGS: 00010286
[ 2613.294959] RAX: 000000000000009d RBX: 00000000022e0000 RCX: 0000000000000000
[ 2613.294959] RDX: 000000000000009d RSI: 0000000000000004 RDI: ffffed1001376e3b
[ 2613.294959] RBP: ffff88804bf8c000 R08: 0000000000000000 R09: fffffbfff2ea4fcc
[ 2613.294959] R10: 0000000000000003 R11: 0000000000000001 R12: 00000000025f0000
[ 2613.294959] R13: ffff888021d8be00 R14: ffff8880075dd2a0 R15: ffff888021d8f400
[ 2613.294959] FS:  00007f8b66d4bb80(0000) GS:ffff888066e00000(0000) knlGS:0000000000000000
[ 2613.294959] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2613.294959] CR2: 00007f8b66f5c000 CR3: 00000000296a5000 CR4: 00000000000006b0
[ 2613.294959] Call Trace:
[ 2613.294959]  <TASK>
[ 2613.294959]  ? show_trace_log_lvl+0x1f3/0x330
[ 2613.294959]  ? show_trace_log_lvl+0x1f3/0x330
[ 2613.294959]  ? show_trace_log_lvl+0x1f3/0x330
[ 2613.294959]  ? raid56_parity_write+0x8d/0x520 [btrfs]
[ 2613.294959]  ? __die+0x54/0x91
[ 2613.294959]  ? die+0x2a/0x50
[ 2613.294959]  ? do_trap+0x1b7/0x290
[ 2613.294959]  ? rbio_add_bio.cold+0x8c/0x1a6 [btrfs]
[ 2613.294959]  ? rbio_add_bio.cold+0x8c/0x1a6 [btrfs]
[ 2613.294959]  ? do_error_trap+0xa3/0x170
[ 2613.294959]  ? rbio_add_bio.cold+0x8c/0x1a6 [btrfs]
[ 2613.294959]  ? handle_invalid_op+0x2c/0x30
[ 2613.294959]  ? rbio_add_bio.cold+0x8c/0x1a6 [btrfs]
[ 2613.294959]  ? exc_invalid_op+0x29/0x40
[ 2613.294959]  ? asm_exc_invalid_op+0x16/0x20
[ 2613.294959]  ? rbio_add_bio.cold+0x8c/0x1a6 [btrfs]
[ 2613.294959]  raid56_parity_write+0x8d/0x520 [btrfs]
[ 2613.294959]  btrfs_submit_chunk+0x444/0x1780 [btrfs]
[ 2613.294959]  ? btrfs_bio_init+0x100/0x100 [btrfs]
[ 2613.294959]  ? bio_set_pages_dirty+0x4a0/0x4a0
[ 2613.294959]  ? mem_cgroup_css_from_folio+0x97/0x210
[ 2613.294959]  ? write_one_eb+0xc34/0x1620 [btrfs]
[ 2613.294959]  btrfs_submit_bio+0x33/0x70 [btrfs]
[ 2613.294959]  submit_eb_page+0x3fa/0x520 [btrfs]
[ 2613.294959]  btree_write_cache_pages+0x337/0x6e0 [btrfs]
[ 2613.294959]  ? submit_eb_page+0x520/0x520 [btrfs]
[ 2613.294959]  ? ftrace_ops_trampoline+0x95/0x100
[ 2613.294959]  do_writepages+0x163/0x750
[ 2613.294959]  ? write_cache_pages+0x100/0x100
[ 2613.294959]  ? __lock_acquired+0x200/0x830
[ 2613.294959]  ? wbc_attach_and_unlock_inode.part.0+0x339/0x700
[ 2613.294959]  ? do_raw_spin_unlock+0x54/0x220
[ 2613.294959]  ? _raw_spin_unlock+0x29/0x40
[ 2613.294959]  filemap_fdatawrite_wbc+0x10b/0x170
[ 2613.294959]  __filemap_fdatawrite_range+0xab/0xf0
[ 2613.294959]  ? delete_from_page_cache_batch+0x920/0x920
[ 2613.294959]  ? free_extent_state+0x2f/0x3a0 [btrfs]
[ 2613.294959]  btrfs_write_marked_extents+0x15b/0x250 [btrfs]
[ 2613.294959]  ? btrfs_end_transaction_throttle+0x10/0x10 [btrfs]
[ 2613.294959]  ? reacquire_held_locks+0x213/0x4e0
[ 2613.294959]  ? btrfs_commit_transaction+0x152c/0x2ee0 [btrfs]
[ 2613.294959]  btrfs_write_and_wait_transaction+0xfd/0x240 [btrfs]
[ 2613.294959]  ? btrfs_write_marked_extents+0x250/0x250 [btrfs]
[ 2613.294959]  ? _raw_spin_unlock_irqrestore+0x48/0x60
[ 2613.294959]  ? lockdep_hardirqs_on+0x78/0x100
[ 2613.294959]  ? btrfs_commit_transaction+0x15bc/0x2ee0 [btrfs]
[ 2613.294959]  btrfs_commit_transaction+0x1634/0x2ee0 [btrfs]
[ 2613.294959]  ? cleanup_transaction+0x170/0x170 [btrfs]
[ 2613.294959]  ? swake_up_locked+0x1b0/0x1b0
[ 2613.294959]  ? preempt_count_add+0x79/0x150
[ 2613.294959]  ? __up_write+0x1b3/0x520
[ 2613.294959]  btrfs_sync_file+0x6ca/0xb20 [btrfs]
[ 2613.294959]  ? start_ordered_ops.constprop.0+0xf0/0xf0 [btrfs]
[ 2613.294959]  __x64_sys_fsync+0x55/0x80
[ 2613.294959]  do_syscall_64+0x6e/0x140
[ 2613.294959]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[ 2613.294959] RIP: 0033:0x7f8b66e56314
[ 2613.294959] RSP: 002b:00007ffdff102018 EFLAGS: 00000202 ORIG_RAX: 000000000000004a
[ 2613.294959] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f8b66e56314
[ 2613.294959] RDX: 0000000000000114 RSI: 000000000040f048 RDI: 0000000000000003
[ 2613.294959] RBP: 000000000000004c R08: fefefefefefefeff R09: 00007ffdff10202c
[ 2613.294959] R10: 0000000000000000 R11: 0000000000000202 R12: 028f5c28f5c28f5c
[ 2613.294959] R13: 8f5c28f5c28f5c29 R14: 000000000040bdc0 R15: 00007f8b66d4bb08
[ 2613.294959]  </TASK>
[ 2613.294959] Modules linked in: dm_flakey dm_mod btrfs blake2b_generic libcrc32c xor lzo_compress lzo_decompress raid6_pq zstd_decompress zstd_compress xxhash zstd_common loop
[ 2613.414623] ---[ end trace 0000000000000000 ]---
[ 2613.415740] RIP: 0010:rbio_add_bio.cold+0x8c/0x1a6 [btrfs]
[ 2613.421366] RSP: 0018:ffff888009bb7240 EFLAGS: 00010286
[ 2613.425639] RAX: 000000000000009d RBX: 00000000022e0000 RCX: 0000000000000000
[ 2613.427371] RDX: 000000000000009d RSI: 0000000000000004 RDI: ffffed1001376e3b
[ 2613.428968] RBP: ffff88804bf8c000 R08: 0000000000000000 R09: fffffbfff2ea4fcc
[ 2613.430627] R10: 0000000000000003 R11: 0000000000000001 R12: 00000000025f0000
[ 2613.432311] R13: ffff888021d8be00 R14: ffff8880075dd2a0 R15: ffff888021d8f400
[ 2613.434015] FS:  00007f8b66d4bb80(0000) GS:ffff888066e00000(0000) knlGS:0000000000000000
[ 2613.436141] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2613.437544] CR2: 00007f8b66f5c000 CR3: 00000000296a5000 CR4: 00000000000006b0
[ 2613.439333] ------------[ cut here ]------------
[ 2613.440507] WARNING: CPU: 0 PID: 17987 at kernel/exit.c:827 do_exit+0xb5d/0xea0
[ 2613.442304] Modules linked in: dm_flakey dm_mod btrfs blake2b_generic libcrc32c xor lzo_compress lzo_decompress raid6_pq zstd_decompress zstd_compress xxhash zstd_common loop
[ 2613.446163] CPU: 0 PID: 17987 Comm: fsstress Tainted: G      D            6.9.0-rc7-default+ #94
[ 2613.448460] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
[ 2613.451166] RIP: 0010:do_exit+0xb5d/0xea0
[ 2613.456647] RSP: 0018:ffff888009bb7e88 EFLAGS: 00010282
[ 2613.457944] RAX: dffffc0000000000 RBX: ffff8880084b9d80 RCX: 0000000000000000
[ 2613.459774] RDX: 1ffff11001097624 RSI: ffffffff96e0fe20 RDI: ffff8880084bb120
[ 2613.461455] RBP: ffff8880028ac640 R08: 0000000000000000 R09: 0000000000000000
[ 2613.463229] R10: ffffffff97d27187 R11: 0000000000000001 R12: ffff8880084ba4d0
[ 2613.464913] R13: ffff8880032ce8c0 R14: ffff8880084ba4c8 R15: 000000000000000b
[ 2613.466638] FS:  00007f8b66d4bb80(0000) GS:ffff888066e00000(0000) knlGS:0000000000000000
[ 2613.468592] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2613.470002] CR2: 00007f8b66f5c000 CR3: 00000000296a5000 CR4: 00000000000006b0
[ 2613.471852] Call Trace:
[ 2613.472588]  <TASK>
[ 2613.473240]  ? show_trace_log_lvl+0x1f3/0x330
[ 2613.474396]  ? show_trace_log_lvl+0x1f3/0x330
[ 2613.475599]  ? show_trace_log_lvl+0x1f3/0x330
[ 2613.476722]  ? make_task_dead+0xf3/0x110
[ 2613.477756]  ? do_exit+0xb5d/0xea0
[ 2613.478715]  ? __warn+0xc8/0x170
[ 2613.479615]  ? do_exit+0xb5d/0xea0
[ 2613.480538]  ? report_bug+0x1f2/0x3c0
[ 2613.481515]  ? handle_bug+0x65/0x90
[ 2613.482507]  ? exc_invalid_op+0x13/0x40
[ 2613.483524]  ? asm_exc_invalid_op+0x16/0x20
[ 2613.484608]  ? do_exit+0xb5d/0xea0
[ 2613.485534]  ? do_exit+0x14a/0xea0
[ 2613.486505]  ? exit_mm+0x290/0x290
[ 2613.487437]  make_task_dead+0xf3/0x110
[ 2613.488429]  rewind_stack_and_make_dead+0x16/0x20
[ 2613.489627] RIP: 0033:0x7f8b66e56314
[ 2613.494909] RSP: 002b:00007ffdff102018 EFLAGS: 00000202 ORIG_RAX: 000000000000004a
[ 2613.496789] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f8b66e56314
[ 2613.498513] RDX: 0000000000000114 RSI: 000000000040f048 RDI: 0000000000000003
[ 2613.500221] RBP: 000000000000004c R08: fefefefefefefeff R09: 00007ffdff10202c
[ 2613.501904] R10: 0000000000000000 R11: 0000000000000202 R12: 028f5c28f5c28f5c
[ 2613.503732] R13: 8f5c28f5c28f5c29 R14: 000000000040bdc0 R15: 00007f8b66d4bb08
[ 2613.505415]  </TASK>
[ 2613.506097] irq event stamp: 22935
[ 2613.507088] hardirqs last  enabled at (22935): [<ffffffff95081954>] do_error_trap+0xe4/0x170
[ 2613.509134] hardirqs last disabled at (22934): [<ffffffff9689b2df>] exc_invalid_op+0x1f/0x40
[ 2613.511236] softirqs last  enabled at (22886): [<ffffffff9513d3e0>] handle_softirqs+0x4a0/0x8c0
[ 2613.513345] softirqs last disabled at (22859): [<ffffffff9513e13b>] irq_exit_rcu+0xdb/0x150
[ 2613.515460] ---[ end trace 0000000000000000 ]---
[ 2613.516672] BUG: unable to handle page fault for address: ffffffff968a92ea
[ 2613.518298] #PF: supervisor write access in kernel mode
[ 2613.518974] #PF: error_code(0x0003) - permissions violation
[ 2613.518974] PGD 7c490067 P4D 7c490067 PUD 7c491063 PMD 7b8001a1 
[ 2613.518974] Oops: 0003 [#2] PREEMPT SMP KASAN
[ 2613.518974] CPU: 0 PID: 17987 Comm: fsstress Tainted: G      D W          6.9.0-rc7-default+ #94
[ 2613.518974] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
[ 2613.518974] RIP: 0010:__blk_flush_plug+0x138/0x4d0
[ 2613.518974] RSP: 0018:ffff888009bb7a08 EFLAGS: 00010246
[ 2613.518974] RAX: 1ffffffff2d1525d RBX: ffff888009bb7a68 RCX: 1ffff11001376f8d
[ 2613.518974] RDX: ffff888009bb7bc8 RSI: ffff888009bb7be8 RDI: ffff888009bb7a70
[ 2613.518974] RBP: dffffc0000000000 R08: ffff888009bb7be8 R09: fffffbfff2fa4e30
[ 2613.518974] R10: ffffffff97d27187 R11: ffffffff95003236 R12: ffffffff968a92ea
[ 2613.518974] R13: ffff888009bb7a68 R14: 0000000000000001 R15: ffff888009bb7bc8
[ 2613.518974] FS:  0000000000000000(0000) GS:ffff888066e00000(0000) knlGS:0000000000000000
[ 2613.518974] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2613.518974] CR2: ffffffff968a92ea CR3: 00000000296a5000 CR4: 00000000000006b0
[ 2613.518974] Call Trace:
[ 2613.518974]  <TASK>
[ 2613.518974]  ? show_trace_log_lvl+0x1f3/0x330
[ 2613.518974]  ? show_trace_log_lvl+0x1f3/0x330
[ 2613.518974]  ? show_trace_log_lvl+0x1f3/0x330
[ 2613.518974]  ? schedule+0x1a4/0x220
[ 2613.518974]  ? __die+0x54/0x91
[ 2613.518974]  ? __wait_for_common+0x3da/0x5f0
[ 2613.518974]  ? page_fault_oops+0xe1/0x130
[ 2613.518974]  ? __wait_for_common+0x3da/0x5f0
[ 2613.518974]  ? exc_page_fault+0xa5/0xb0
[ 2613.518974]  ? asm_exc_page_fault+0x22/0x30
[ 2613.518974]  ? __wait_for_common+0x3da/0x5f0
[ 2613.518974]  ? rewind_stack_and_make_dead+0x16/0x20
[ 2613.518974]  ? __blk_flush_plug+0x138/0x4d0
[ 2613.518974]  ? lock_sync+0x180/0x180
[ 2613.518974]  ? blk_start_plug_nr_ios+0x270/0x270
[ 2613.518974]  schedule+0x1a4/0x220
[ 2613.518974]  schedule_timeout+0x25e/0x3d0
[ 2613.518974]  ? usleep_range_state+0x170/0x170
[ 2613.518974]  ? rcu_is_watching+0xe/0xb0
[ 2613.518974]  __wait_for_common+0x3da/0x5f0
[ 2613.518974]  ? usleep_range_state+0x170/0x170
[ 2613.518974]  ? out_of_line_wait_on_bit_timeout+0x170/0x170
[ 2613.518974]  ? trace_irq_enable.constprop.0+0x40/0x100
[ 2613.518974]  ? _raw_spin_unlock_irqrestore+0x35/0x60
[ 2613.518974]  ? kill_ioctx+0x1dd/0x2a0
[ 2613.518974]  exit_aio+0x2e5/0x360
[ 2613.518974]  ? __mutex_unlock_slowpath+0x16c/0x630
[ 2613.518974]  ? aio_poll_complete_work+0xa80/0xa80
[ 2613.518974]  mmput+0xa8/0x3b0
[ 2613.518974]  exit_mm+0x1d3/0x290
[ 2613.518974]  do_exit+0x6c9/0xea0
[ 2613.518974]  ? exit_mm+0x290/0x290
[ 2613.518974]  make_task_dead+0xf3/0x110
[ 2613.518974]  rewind_stack_and_make_dead+0x16/0x20
[ 2613.518974] RIP: 0033:0x7f8b66e56314
[ 2613.518974] Code: Unable to access opcode bytes at 0x7f8b66e562ea.
[ 2613.518974] RSP: 002b:00007ffdff102018 EFLAGS: 00000202 ORIG_RAX: 000000000000004a
[ 2613.518974] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f8b66e56314
[ 2613.518974] RDX: 0000000000000114 RSI: 000000000040f048 RDI: 0000000000000003
[ 2613.518974] RBP: 000000000000004c R08: fefefefefefefeff R09: 00007ffdff10202c
[ 2613.518974] R10: 0000000000000000 R11: 0000000000000202 R12: 028f5c28f5c28f5c
[ 2613.518974] R13: 8f5c28f5c28f5c29 R14: 000000000040bdc0 R15: 00007f8b66d4bb08
[ 2613.518974]  </TASK>
[ 2613.518974] Modules linked in: dm_flakey dm_mod btrfs blake2b_generic libcrc32c xor lzo_compress lzo_decompress raid6_pq zstd_decompress zstd_compress xxhash zstd_common loop
[ 2613.518974] CR2: ffffffff968a92ea
[ 2613.518974] ---[ end trace 0000000000000000 ]---
[ 2613.518974] RIP: 0010:rbio_add_bio.cold+0x8c/0x1a6 [btrfs]
[ 2613.518974] RSP: 0018:ffff888009bb7240 EFLAGS: 00010286
[ 2613.518974] RAX: 000000000000009d RBX: 00000000022e0000 RCX: 0000000000000000
[ 2613.518974] RDX: 000000000000009d RSI: 0000000000000004 RDI: ffffed1001376e3b
[ 2613.518974] RBP: ffff88804bf8c000 R08: 0000000000000000 R09: fffffbfff2ea4fcc
[ 2613.518974] R10: 0000000000000003 R11: 0000000000000001 R12: 00000000025f0000
[ 2613.518974] R13: ffff888021d8be00 R14: ffff8880075dd2a0 R15: ffff888021d8f400
[ 2613.518974] FS:  0000000000000000(0000) GS:ffff888066e00000(0000) knlGS:0000000000000000
[ 2613.518974] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2613.518974] CR2: ffffffff968a92ea CR3: 00000000296a5000 CR4: 00000000000006b0
[ 2613.518974] note: fsstress[17987] exited with irqs disabled
[ 2613.629176] Fixing recursive fault but reboot is needed!
[ 2613.630531] BUG: using smp_processor_id() in preemptible [00000000] code: fsstress/17987
[ 2613.632503] caller is __schedule+0xb3/0x1db0
[ 2613.633605] CPU: 0 PID: 17987 Comm: fsstress Tainted: G      D W          6.9.0-rc7-default+ #94
[ 2613.634517] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
[ 2613.634517] Call Trace:
[ 2613.634517]  <TASK>
[ 2613.634517]  dump_stack_lvl+0x61/0x80
[ 2613.634517]  ? __wait_for_common+0x3da/0x5f0
[ 2613.634517]  check_preemption_disabled+0xd7/0xe0
[ 2613.634517]  ? do_task_dead+0x46/0x110
[ 2613.634517]  __schedule+0xb3/0x1db0
[ 2613.634517]  ? lock_acquire+0x392/0x520
[ 2613.634517]  ? lock_sync+0x180/0x180
[ 2613.634517]  ? vprintk_emit+0x14b/0x220
[ 2613.634517]  ? io_schedule_timeout+0x160/0x160
[ 2613.634517]  ? do_raw_spin_lock+0x270/0x270
[ 2613.634517]  ? freeze_kernel_threads+0x70/0x70
[ 2613.634517]  ? do_task_dead+0x46/0x110
[ 2613.634517]  ? rcu_is_watching+0xe/0xb0
[ 2613.634517]  ? do_task_dead+0x46/0x110
[ 2613.634517]  ? __wait_for_common+0x3da/0x5f0
[ 2613.634517]  do_task_dead+0xdc/0x110
[ 2613.634517]  make_task_dead.cold+0x14e/0x178
[ 2613.634517]  rewind_stack_and_make_dead+0x16/0x20
[ 2613.634517] RIP: 0033:0x7f8b66e56314
[ 2613.634517] Code: Unable to access opcode bytes at 0x7f8b66e562ea.
[ 2613.634517] RSP: 002b:00007ffdff102018 EFLAGS: 00000202 ORIG_RAX: 000000000000004a
[ 2613.634517] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f8b66e56314
[ 2613.634517] RDX: 0000000000000114 RSI: 000000000040f048 RDI: 0000000000000003
[ 2613.634517] RBP: 000000000000004c R08: fefefefefefefeff R09: 00007ffdff10202c
[ 2613.634517] R10: 0000000000000000 R11: 0000000000000202 R12: 028f5c28f5c28f5c
[ 2613.634517] R13: 8f5c28f5c28f5c29 R14: 000000000040bdc0 R15: 00007f8b66d4bb08
[ 2613.634517]  </TASK>
[ 2613.675576] BUG: scheduling while atomic: fsstress/17987/0x00000000
[ 2613.677100] INFO: lockdep is turned off.
[ 2613.678119] Modules linked in: dm_flakey dm_mod btrfs blake2b_generic libcrc32c xor lzo_compress lzo_decompress raid6_pq zstd_decompress zstd_compress xxhash zstd_common loop
[ 2613.681958] Preemption disabled at:
[ 2613.681960] [<0000000000000000>] 0x0
[ 2613.683934] CPU: 0 PID: 17987 Comm: fsstress Tainted: G      D W          6.9.0-rc7-default+ #94
[ 2613.686052] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
[ 2613.686681] Call Trace:
[ 2613.686681]  <TASK>
[ 2613.686681]  dump_stack_lvl+0x61/0x80
[ 2613.686681]  __schedule_bug.cold+0xce/0xf4
[ 2613.686681]  schedule_debug+0x1b7/0x210
[ 2613.686681]  __schedule+0x129/0x1db0
[ 2613.686681]  ? lock_acquire+0x392/0x520
[ 2613.686681]  ? vprintk_emit+0x14b/0x220
[ 2613.686681]  ? io_schedule_timeout+0x160/0x160
[ 2613.686681]  ? do_raw_spin_lock+0x270/0x270
[ 2613.686681]  ? freeze_kernel_threads+0x70/0x70
[ 2613.686681]  ? do_task_dead+0x46/0x110
[ 2613.686681]  ? rcu_is_watching+0xe/0xb0
[ 2613.686681]  ? do_task_dead+0x46/0x110
[ 2613.686681]  ? __wait_for_common+0x3da/0x5f0
[ 2613.686681]  do_task_dead+0xdc/0x110
[ 2613.686681]  make_task_dead.cold+0x14e/0x178
[ 2613.686681]  rewind_stack_and_make_dead+0x16/0x20
[ 2613.686681] RIP: 0033:0x7f8b66e56314
[ 2613.686681] Code: Unable to access opcode bytes at 0x7f8b66e562ea.
[ 2613.686681] RSP: 002b:00007ffdff102018 EFLAGS: 00000202 ORIG_RAX: 000000000000004a
[ 2613.686681] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f8b66e56314
[ 2613.686681] RDX: 0000000000000114 RSI: 000000000040f048 RDI: 0000000000000003
[ 2613.686681] RBP: 000000000000004c R08: fefefefefefefeff R09: 00007ffdff10202c
[ 2613.686681] R10: 0000000000000000 R11: 0000000000000202 R12: 028f5c28f5c28f5c
[ 2613.686681] R13: 8f5c28f5c28f5c29 R14: 000000000040bdc0 R15: 00007f8b66d4bb08
[ 2613.686681]  </TASK>
[ 2613.758407] ==================================================================
[ 2613.760215] BUG: KASAN: use-after-free in free_ioctx_reqs+0x48/0x1c0
[ 2613.761736] Write of size 4 at addr ffff888009bb7db0 by task swapper/0/0
[ 2613.762383] 
[ 2613.762383] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D W          6.9.0-rc7-default+ #94
[ 2613.762383] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
[ 2613.762383] Call Trace:
[ 2613.762383]  <IRQ>
[ 2613.762383]  dump_stack_lvl+0x61/0x80
[ 2613.762383]  print_address_description.constprop.0+0x5e/0x2f0
[ 2613.762383]  ? free_ioctx_reqs+0x48/0x1c0
[ 2613.762383]  print_report+0x118/0x216
[ 2613.762383]  ? __virt_addr_valid+0x19b/0x3a0
[ 2613.762383]  ? free_ioctx_reqs+0x48/0x1c0
[ 2613.762383]  kasan_report+0x11d/0x1f0
[ 2613.762383]  ? free_ioctx_reqs+0x48/0x1c0
[ 2613.762383]  kasan_check_range+0xec/0x190
[ 2613.762383]  free_ioctx_reqs+0x48/0x1c0
[ 2613.762383]  percpu_ref_put_many.constprop.0+0x197/0x1d0
[ 2613.762383]  ? rcu_do_batch+0x35a/0xb80
[ 2613.762383]  rcu_do_batch+0x35c/0xb80
[ 2613.762383]  ? rcu_preempt_ctxt_queue+0x1450/0x1450
[ 2613.762383]  ? trace_irq_enable.constprop.0+0x40/0x100
[ 2613.762383]  ? _raw_spin_unlock_irqrestore+0x35/0x60
[ 2613.762383]  rcu_core+0x29c/0x4d0
[ 2613.762383]  handle_softirqs+0x20b/0x8c0
[ 2613.762383]  ? _local_bh_enable+0xa0/0xa0
[ 2613.762383]  ? sched_clock_tick+0x11c/0x270
[ 2613.762383]  irq_exit_rcu+0xdb/0x150
[ 2613.762383]  sysvec_apic_timer_interrupt+0x8a/0xb0
[ 2613.762383]  </IRQ>
[ 2613.762383]  <TASK>
[ 2613.762383]  asm_sysvec_apic_timer_interrupt+0x16/0x20
[ 2613.762383] RIP: 0010:default_idle+0x13/0x20
[ 2613.762383] RSP: 0018:ffffffff97407e20 EFLAGS: 00000246
[ 2613.762383] RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff9689da47
[ 2613.762383] RDX: ffffed100cdff581 RSI: ffffffff96e0fe20 RDI: ffffffff9522cb8f
[ 2613.762383] RBP: 0000000000000000 R08: 0000000000000000 R09: ffffed100cdff580
[ 2613.762383] R10: ffff888066ffac03 R11: 0000000000000000 R12: 1ffffffff2e80fc6
[ 2613.762383] R13: ffffffff9741bd80 R14: dffffc0000000000 R15: 0000000000013d10
[ 2613.762383]  ? ct_kernel_exit.constprop.0+0xe7/0x130
[ 2613.762383]  ? cpuidle_idle_call+0x1bf/0x1e0
[ 2613.762383]  default_idle_call+0x67/0xa0
[ 2613.762383]  cpuidle_idle_call+0x1bf/0x1e0
[ 2613.762383]  ? arch_cpu_idle_exit+0x30/0x30
[ 2613.762383]  ? mark_tsc_async_resets+0x30/0x30
[ 2613.762383]  ? rcu_is_watching+0xe/0xb0
[ 2613.762383]  do_idle+0xe2/0x140
[ 2613.762383]  cpu_startup_entry+0x50/0x60
[ 2613.762383]  rest_init+0x1f6/0x200
[ 2613.762383]  start_kernel+0x2f8/0x300
[ 2613.762383]  x86_64_start_reservations+0x20/0x20
[ 2613.762383]  x86_64_start_kernel+0x76/0x80
[ 2613.762383]  common_startup_64+0x129/0x138
[ 2613.762383]  </TASK>
[ 2613.762383] 
[ 2613.762383] The buggy address belongs to the physical page:
[ 2613.762383] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x9bb7
[ 2613.762383] flags: 0x280000000000(section=1|zone=1)
[ 2613.762383] page_type: 0xffffffff()
[ 2613.762383] raw: 0000280000000000 0000000000000000 dead000000000122 0000000000000000
[ 2613.762383] raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
[ 2613.762383] page dumped because: kasan: bad access detected
[ 2613.762383] 
[ 2613.762383] Memory state around the buggy address:
[ 2613.762383]  ffff888009bb7c80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[ 2613.762383]  ffff888009bb7d00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[ 2613.762383] >ffff888009bb7d80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[ 2613.762383]                                      ^
[ 2613.762383]  ffff888009bb7e00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[ 2613.762383]  ffff888009bb7e80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
[ 2613.762383] ==================================================================

