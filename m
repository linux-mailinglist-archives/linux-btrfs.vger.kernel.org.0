Return-Path: <linux-btrfs+bounces-13976-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0390DAB59D6
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 18:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0037C7B11A3
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 May 2025 16:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DB92BEC4C;
	Tue, 13 May 2025 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c+iWUD3U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GXFkfLM6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c+iWUD3U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GXFkfLM6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D441F03C0
	for <linux-btrfs@vger.kernel.org>; Tue, 13 May 2025 16:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747153725; cv=none; b=i8gCIrDUCCAZsJb9oViTrYX5klqHMWdbIr6IX/EPIHFRokIpL8+UNwX8LADdUZzbQwox+YIHcCbMq0bN6V2DTRxIaDYznIF52ED7cBqklfLatBveTG6hMhpFHk1If9oG9/c7dZJKSKIwzxnL2RZip/Fo4kNPZICQ+cxQNoXgLk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747153725; c=relaxed/simple;
	bh=9bwxlCsRBcLv0NvvdgpjIpAXcU8yxhbZsXToP15CVN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rn+t1/1RPFPFtVk0/QCy1dsCwUjYz5mJR7AZCRkMmVhrQHVm1x4KqwrVZwRflbP+h1YPDSxBBxH/xUSe9+Yp+HHbqX3sM4amUTXZcF/HUjZoCWOMk0wZIdE9bI6lfNcAJzKP1LaUuic3xXImQSeVq9xaoVpD+p9+l2sVyKAdlBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c+iWUD3U; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GXFkfLM6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c+iWUD3U; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GXFkfLM6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 19470211D1;
	Tue, 13 May 2025 16:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747153720;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0REsCQLIDRvowuESA9a7z8fh6gu/E+iTv6JfzsQ+9bg=;
	b=c+iWUD3UjVNEny775lVDdAwQ1p1qowLaOYwC7o5H5OmuzkAza09XykxiRXGJiiJ/S/Dwyn
	vO+hDBkWPiFzqCdoEhLXwpxEFL/PCUSImdcrxti/JQEWvFS3fVdvHPrpaT+KNj0dZoDNVx
	VAn4ufvf8QlM0LwTQol51GRi57lMteE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747153720;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0REsCQLIDRvowuESA9a7z8fh6gu/E+iTv6JfzsQ+9bg=;
	b=GXFkfLM6CxcMNJAHdunpeg0NWezxCfWIQ9pN9W8JUArJxIxJpRWNRNcG/AMdNQtDT8RBRZ
	TYshQ0BaOSkTOjBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747153720;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0REsCQLIDRvowuESA9a7z8fh6gu/E+iTv6JfzsQ+9bg=;
	b=c+iWUD3UjVNEny775lVDdAwQ1p1qowLaOYwC7o5H5OmuzkAza09XykxiRXGJiiJ/S/Dwyn
	vO+hDBkWPiFzqCdoEhLXwpxEFL/PCUSImdcrxti/JQEWvFS3fVdvHPrpaT+KNj0dZoDNVx
	VAn4ufvf8QlM0LwTQol51GRi57lMteE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747153720;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0REsCQLIDRvowuESA9a7z8fh6gu/E+iTv6JfzsQ+9bg=;
	b=GXFkfLM6CxcMNJAHdunpeg0NWezxCfWIQ9pN9W8JUArJxIxJpRWNRNcG/AMdNQtDT8RBRZ
	TYshQ0BaOSkTOjBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB1E6137E8;
	Tue, 13 May 2025 16:28:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GK1XMTdzI2jcGQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 13 May 2025 16:28:39 +0000
Date: Tue, 13 May 2025 18:28:38 +0200
From: David Sterba <dsterba@suse.cz>
To: Zhi Yang <Zhi.Yang@eng.windriver.com>
Cc: stable@vger.kernel.org, fdmanana@suse.com, xiangyu.chen@windriver.com,
	zhe.he@windriver.com, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, osandov@fb.com
Subject: Re: [PATCH 5.10.y] btrfs: get rid of warning on transaction commit
 when using flushoncommit
Message-ID: <20250513162838.GA9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250513024200.1811319-1-Zhi.Yang@eng.windriver.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250513024200.1811319-1-Zhi.Yang@eng.windriver.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,qemu.org:url,imap1.dmz-prg2.suse.org:helo,suse.com:email,fb.com:email,windriver.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]

On Tue, May 13, 2025 at 10:42:00AM +0800, Zhi Yang wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> commit a0f0cf8341e34e5d2265bfd3a7ad68342da1e2aa upstream.
> 
> When using the flushoncommit mount option, during almost every transaction
> commit we trigger a warning from __writeback_inodes_sb_nr():
> 
>   $ cat fs/fs-writeback.c:
>   (...)
>   static void __writeback_inodes_sb_nr(struct super_block *sb, ...
>   {
>         (...)
>         WARN_ON(!rwsem_is_locked(&sb->s_umount));
>         (...)
>   }
>   (...)
> 
> The trace produced in dmesg looks like the following:
> 
>   [947.473890] WARNING: CPU: 5 PID: 930 at fs/fs-writeback.c:2610 __writeback_inodes_sb_nr+0x7e/0xb3
>   [947.481623] Modules linked in: nfsd nls_cp437 cifs asn1_decoder cifs_arc4 fscache cifs_md4 ipmi_ssif
>   [947.489571] CPU: 5 PID: 930 Comm: btrfs-transacti Not tainted 95.16.3-srb-asrock-00001-g36437ad63879 #186
>   [947.497969] RIP: 0010:__writeback_inodes_sb_nr+0x7e/0xb3
>   [947.502097] Code: 24 10 4c 89 44 24 18 c6 (...)
>   [947.519760] RSP: 0018:ffffc90000777e10 EFLAGS: 00010246
>   [947.523818] RAX: 0000000000000000 RBX: 0000000000963300 RCX: 0000000000000000
>   [947.529765] RDX: 0000000000000000 RSI: 000000000000fa51 RDI: ffffc90000777e50
>   [947.535740] RBP: ffff888101628a90 R08: ffff888100955800 R09: ffff888100956000
>   [947.541701] R10: 0000000000000002 R11: 0000000000000001 R12: ffff888100963488
>   [947.547645] R13: ffff888100963000 R14: ffff888112fb7200 R15: ffff888100963460
>   [947.553621] FS:  0000000000000000(0000) GS:ffff88841fd40000(0000) knlGS:0000000000000000
>   [947.560537] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [947.565122] CR2: 0000000008be50c4 CR3: 000000000220c000 CR4: 00000000001006e0
>   [947.571072] Call Trace:
>   [947.572354]  <TASK>
>   [947.573266]  btrfs_commit_transaction+0x1f1/0x998
>   [947.576785]  ? start_transaction+0x3ab/0x44e
>   [947.579867]  ? schedule_timeout+0x8a/0xdd
>   [947.582716]  transaction_kthread+0xe9/0x156
>   [947.585721]  ? btrfs_cleanup_transaction.isra.0+0x407/0x407
>   [947.590104]  kthread+0x131/0x139
>   [947.592168]  ? set_kthread_struct+0x32/0x32
>   [947.595174]  ret_from_fork+0x22/0x30
>   [947.597561]  </TASK>
>   [947.598553] ---[ end trace 644721052755541c ]---
> 
> This is because we started using writeback_inodes_sb() to flush delalloc
> when committing a transaction (when using -o flushoncommit), in order to
> avoid deadlocks with filesystem freeze operations. This change was made
> by commit ce8ea7cc6eb313 ("btrfs: don't call btrfs_start_delalloc_roots
> in flushoncommit"). After that change we started producing that warning,
> and every now and then a user reports this since the warning happens too
> often, it spams dmesg/syslog, and a user is unsure if this reflects any
> problem that might compromise the filesystem's reliability.
> 
> We can not just lock the sb->s_umount semaphore before calling
> writeback_inodes_sb(), because that would at least deadlock with
> filesystem freezing, since at fs/super.c:freeze_super() sync_filesystem()
> is called while we are holding that semaphore in write mode, and that can
> trigger a transaction commit, resulting in a deadlock. It would also
> trigger the same type of deadlock in the unmount path. Possibly, it could
> also introduce some other locking dependencies that lockdep would report.
> 
> To fix this call try_to_writeback_inodes_sb() instead of
> writeback_inodes_sb(), because that will try to read lock sb->s_umount
> and then will only call writeback_inodes_sb() if it was able to lock it.
> This is fine because the cases where it can't read lock sb->s_umount
> are during a filesystem unmount or during a filesystem freeze - in those
> cases sb->s_umount is write locked and sync_filesystem() is called, which
> calls writeback_inodes_sb(). In other words, in all cases where we can't
> take a read lock on sb->s_umount, writeback is already being triggered
> elsewhere.
> 
> An alternative would be to call btrfs_start_delalloc_roots() with a
> number of pages different from LONG_MAX, for example matching the number
> of delalloc bytes we currently have, in which case we would end up
> starting all delalloc with filemap_fdatawrite_wbc() and not with an
> async flush via filemap_flush() - that is only possible after the rather
> recent commit e076ab2a2ca70a ("btrfs: shrink delalloc pages instead of
> full inodes"). However that creates a whole new can of worms due to new
> lock dependencies, which lockdep complains, like for example:
> 
> [ 8948.247280] ======================================================
> [ 8948.247823] WARNING: possible circular locking dependency detected
> [ 8948.248353] 5.17.0-rc1-btrfs-next-111 #1 Not tainted
> [ 8948.248786] ------------------------------------------------------
> [ 8948.249320] kworker/u16:18/933570 is trying to acquire lock:
> [ 8948.249812] ffff9b3de1591690 (sb_internal#2){.+.+}-{0:0}, at: find_free_extent+0x141e/0x1590 [btrfs]
> [ 8948.250638]
>                but task is already holding lock:
> [ 8948.251140] ffff9b3e09c717d8 (&root->delalloc_mutex){+.+.}-{3:3}, at: start_delalloc_inodes+0x78/0x400 [btrfs]
> [ 8948.252018]
>                which lock already depends on the new lock.
> 
> [ 8948.252710]
>                the existing dependency chain (in reverse order) is:
> [ 8948.253343]
>                -> #2 (&root->delalloc_mutex){+.+.}-{3:3}:
> [ 8948.253950]        __mutex_lock+0x90/0x900
> [ 8948.254354]        start_delalloc_inodes+0x78/0x400 [btrfs]
> [ 8948.254859]        btrfs_start_delalloc_roots+0x194/0x2a0 [btrfs]
> [ 8948.255408]        btrfs_commit_transaction+0x32f/0xc00 [btrfs]
> [ 8948.255942]        btrfs_mksubvol+0x380/0x570 [btrfs]
> [ 8948.256406]        btrfs_mksnapshot+0x81/0xb0 [btrfs]
> [ 8948.256870]        __btrfs_ioctl_snap_create+0x17f/0x190 [btrfs]
> [ 8948.257413]        btrfs_ioctl_snap_create_v2+0xbb/0x140 [btrfs]
> [ 8948.257961]        btrfs_ioctl+0x1196/0x3630 [btrfs]
> [ 8948.258418]        __x64_sys_ioctl+0x83/0xb0
> [ 8948.258793]        do_syscall_64+0x3b/0xc0
> [ 8948.259146]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 8948.259709]
>                -> #1 (&fs_info->delalloc_root_mutex){+.+.}-{3:3}:
> [ 8948.260330]        __mutex_lock+0x90/0x900
> [ 8948.260692]        btrfs_start_delalloc_roots+0x97/0x2a0 [btrfs]
> [ 8948.261234]        btrfs_commit_transaction+0x32f/0xc00 [btrfs]
> [ 8948.261766]        btrfs_set_free_space_cache_v1_active+0x38/0x60 [btrfs]
> [ 8948.262379]        btrfs_start_pre_rw_mount+0x119/0x180 [btrfs]
> [ 8948.262909]        open_ctree+0x1511/0x171e [btrfs]
> [ 8948.263359]        btrfs_mount_root.cold+0x12/0xde [btrfs]
> [ 8948.263863]        legacy_get_tree+0x30/0x50
> [ 8948.264242]        vfs_get_tree+0x28/0xc0
> [ 8948.264594]        vfs_kern_mount.part.0+0x71/0xb0
> [ 8948.265017]        btrfs_mount+0x11d/0x3a0 [btrfs]
> [ 8948.265462]        legacy_get_tree+0x30/0x50
> [ 8948.265851]        vfs_get_tree+0x28/0xc0
> [ 8948.266203]        path_mount+0x2d4/0xbe0
> [ 8948.266554]        __x64_sys_mount+0x103/0x140
> [ 8948.266940]        do_syscall_64+0x3b/0xc0
> [ 8948.267300]        entry_SYSCALL_64_after_hwframe+0x44/0xae
> [ 8948.267790]
>                -> #0 (sb_internal#2){.+.+}-{0:0}:
> [ 8948.268322]        __lock_acquire+0x12e8/0x2260
> [ 8948.268733]        lock_acquire+0xd7/0x310
> [ 8948.269092]        start_transaction+0x44c/0x6e0 [btrfs]
> [ 8948.269591]        find_free_extent+0x141e/0x1590 [btrfs]
> [ 8948.270087]        btrfs_reserve_extent+0x14b/0x280 [btrfs]
> [ 8948.270588]        cow_file_range+0x17e/0x490 [btrfs]
> [ 8948.271051]        btrfs_run_delalloc_range+0x345/0x7a0 [btrfs]
> [ 8948.271586]        writepage_delalloc+0xb5/0x170 [btrfs]
> [ 8948.272071]        __extent_writepage+0x156/0x3c0 [btrfs]
> [ 8948.272579]        extent_write_cache_pages+0x263/0x460 [btrfs]
> [ 8948.273113]        extent_writepages+0x76/0x130 [btrfs]
> [ 8948.273573]        do_writepages+0xd2/0x1c0
> [ 8948.273942]        filemap_fdatawrite_wbc+0x68/0x90
> [ 8948.274371]        start_delalloc_inodes+0x17f/0x400 [btrfs]
> [ 8948.274876]        btrfs_start_delalloc_roots+0x194/0x2a0 [btrfs]
> [ 8948.275417]        flush_space+0x1f2/0x630 [btrfs]
> [ 8948.275863]        btrfs_async_reclaim_data_space+0x108/0x1b0 [btrfs]
> [ 8948.276438]        process_one_work+0x252/0x5a0
> [ 8948.276829]        worker_thread+0x55/0x3b0
> [ 8948.277189]        kthread+0xf2/0x120
> [ 8948.277506]        ret_from_fork+0x22/0x30
> [ 8948.277868]
>                other info that might help us debug this:
> 
> [ 8948.278548] Chain exists of:
>                  sb_internal#2 --> &fs_info->delalloc_root_mutex --> &root->delalloc_mutex
> 
> [ 8948.279601]  Possible unsafe locking scenario:
> 
> [ 8948.280102]        CPU0                    CPU1
> [ 8948.280508]        ----                    ----
> [ 8948.280915]   lock(&root->delalloc_mutex);
> [ 8948.281271]                                lock(&fs_info->delalloc_root_mutex);
> [ 8948.281915]                                lock(&root->delalloc_mutex);
> [ 8948.282487]   lock(sb_internal#2);
> [ 8948.282800]
>                 *** DEADLOCK ***
> 
> [ 8948.283333] 4 locks held by kworker/u16:18/933570:
> [ 8948.283750]  #0: ffff9b3dc00a9d48 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1d2/0x5a0
> [ 8948.284609]  #1: ffffa90349dafe70 ((work_completion)(&fs_info->async_data_reclaim_work)){+.+.}-{0:0}, at: process_one_work+0x1d2/0x5a0
> [ 8948.285637]  #2: ffff9b3e14db5040 (&fs_info->delalloc_root_mutex){+.+.}-{3:3}, at: btrfs_start_delalloc_roots+0x97/0x2a0 [btrfs]
> [ 8948.286674]  #3: ffff9b3e09c717d8 (&root->delalloc_mutex){+.+.}-{3:3}, at: start_delalloc_inodes+0x78/0x400 [btrfs]
> [ 8948.287596]
>               stack backtrace:
> [ 8948.287975] CPU: 3 PID: 933570 Comm: kworker/u16:18 Not tainted 5.17.0-rc1-btrfs-next-111 #1
> [ 8948.288677] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [ 8948.289649] Workqueue: events_unbound btrfs_async_reclaim_data_space [btrfs]
> [ 8948.290298] Call Trace:
> [ 8948.290517]  <TASK>
> [ 8948.290700]  dump_stack_lvl+0x59/0x73
> [ 8948.291026]  check_noncircular+0xf3/0x110
> [ 8948.291375]  ? start_transaction+0x228/0x6e0 [btrfs]
> [ 8948.291826]  __lock_acquire+0x12e8/0x2260
> [ 8948.292241]  lock_acquire+0xd7/0x310
> [ 8948.292714]  ? find_free_extent+0x141e/0x1590 [btrfs]
> [ 8948.293241]  ? lock_is_held_type+0xea/0x140
> [ 8948.293601]  start_transaction+0x44c/0x6e0 [btrfs]
> [ 8948.294055]  ? find_free_extent+0x141e/0x1590 [btrfs]
> [ 8948.294518]  find_free_extent+0x141e/0x1590 [btrfs]
> [ 8948.294957]  ? _raw_spin_unlock+0x29/0x40
> [ 8948.295312]  ? btrfs_get_alloc_profile+0x124/0x290 [btrfs]
> [ 8948.295813]  btrfs_reserve_extent+0x14b/0x280 [btrfs]
> [ 8948.296270]  cow_file_range+0x17e/0x490 [btrfs]
> [ 8948.296691]  btrfs_run_delalloc_range+0x345/0x7a0 [btrfs]
> [ 8948.297175]  ? find_lock_delalloc_range+0x247/0x270 [btrfs]
> [ 8948.297678]  writepage_delalloc+0xb5/0x170 [btrfs]
> [ 8948.298123]  __extent_writepage+0x156/0x3c0 [btrfs]
> [ 8948.298570]  extent_write_cache_pages+0x263/0x460 [btrfs]
> [ 8948.299061]  extent_writepages+0x76/0x130 [btrfs]
> [ 8948.299495]  do_writepages+0xd2/0x1c0
> [ 8948.299817]  ? sched_clock_cpu+0xd/0x110
> [ 8948.300160]  ? lock_release+0x155/0x4a0
> [ 8948.300494]  filemap_fdatawrite_wbc+0x68/0x90
> [ 8948.300874]  ? do_raw_spin_unlock+0x4b/0xa0
> [ 8948.301243]  start_delalloc_inodes+0x17f/0x400 [btrfs]
> [ 8948.301706]  ? lock_release+0x155/0x4a0
> [ 8948.302055]  btrfs_start_delalloc_roots+0x194/0x2a0 [btrfs]
> [ 8948.302564]  flush_space+0x1f2/0x630 [btrfs]
> [ 8948.302970]  btrfs_async_reclaim_data_space+0x108/0x1b0 [btrfs]
> [ 8948.303510]  process_one_work+0x252/0x5a0
> [ 8948.303860]  ? process_one_work+0x5a0/0x5a0
> [ 8948.304221]  worker_thread+0x55/0x3b0
> [ 8948.304543]  ? process_one_work+0x5a0/0x5a0
> [ 8948.304904]  kthread+0xf2/0x120
> [ 8948.305184]  ? kthread_complete_and_exit+0x20/0x20
> [ 8948.305598]  ret_from_fork+0x22/0x30
> [ 8948.305921]  </TASK>
> 
> It all comes from the fact that btrfs_start_delalloc_roots() takes the
> delalloc_root_mutex, in the transaction commit path we are holding a
> read lock on one of the superblock's freeze semaphores (via
> sb_start_intwrite()), the async reclaim task can also do a call to
> btrfs_start_delalloc_roots(), which ends up triggering writeback with
> calls to filemap_fdatawrite_wbc(), resulting in extent allocation which
> in turn can call btrfs_start_transaction(), which will result in taking
> the freeze semaphore via sb_start_intwrite(), forming a nasty dependency
> on all those locks which can be taken in different orders by different
> code paths.
> 
> So just adopt the simple approach of calling try_to_writeback_inodes_sb()
> at btrfs_start_delalloc_flush().
> 
> Link: https://lore.kernel.org/linux-btrfs/20220130005258.GA7465@cuci.nl/
> Link: https://lore.kernel.org/linux-btrfs/43acc426-d683-d1b6-729d-c6bc4a2fff4d@gmail.com/
> Link: https://lore.kernel.org/linux-btrfs/6833930a-08d7-6fbc-0141-eb9cdfd6bb4d@gmail.com/
> Link: https://lore.kernel.org/linux-btrfs/20190322041731.GF16651@hungrycats.org/
> Reviewed-by: Omar Sandoval <osandov@fb.com>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> [ add more link reports ]
> Signed-off-by: David Sterba <dsterba@suse.com>
> [Minor context change fixed]
> Signed-off-by: Zhi Yang <Zhi.Yang@windriver.com>
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
> Build test passed.
  ^^^^^^^^^^^^^^^^^

This is insufficient for the backport. I remember some functional
changes that are not present in 5.10 and have to be either added as
dependencies or verified as not necessary. This is what stopped the
patch from stable trees in the past. At least one patch for reference is
88090ad36a64af1eb5b78d26 and there are probably like 1-2 more.

Stable team, please don't add this unless there are test results
with/without this patch + potential dependencies applied.

