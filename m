Return-Path: <linux-btrfs+bounces-11019-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D444A174F9
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2025 00:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3773A8D55
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Jan 2025 23:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889361BAED6;
	Mon, 20 Jan 2025 23:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mb+kWhAM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KP9ipkdR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mb+kWhAM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KP9ipkdR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CE1192D70
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Jan 2025 23:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737415146; cv=none; b=utCmvdgyWBd5mj0nMUtFVbmhfZ8qL6fo+qcsMdY2ueiBl9o+0jv77O3ArCata8vSgqMjKUVQ4EamfnqBtuoGh9pMX/yuTeQvNlYlUI1L3B0OffT6C60KOfLa1nrjx7hV42GoU9GobCqul1+mMxQqJNS78+DqHCP5d8WVehiAnUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737415146; c=relaxed/simple;
	bh=fLoizW2Ebq7IKSZNErv4YLcaSe+2jbx8KVlnCSpFyGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVLWxdTCw7UYuT1Lsf8hPyak4FAV+0XP25AeC+uUmS3mKQE5kbxecQh/0VEblJTSSDnUTuLVb9ukpRtcg8lgF2lLLpXQv/ErkkAz8CtV1CAhN83J5aEHQ+49VxSyNUL6/Xj3ubYB5ss6wXDQfLMD4FLOwyGHRpRfxc+q8y5nxqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mb+kWhAM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KP9ipkdR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mb+kWhAM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KP9ipkdR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3E5071F7D8;
	Mon, 20 Jan 2025 23:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737415142;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xAGjpc1NCvFI2p2TkVoOPDB5w/adTSJPEV++TvTJJqE=;
	b=Mb+kWhAMh8/DjkPA2+DxJEyaRNLRjjO01llTO5bbqo2s8MvGTjVocw36kahuhiaAD9+vf+
	+e+sXYUaIbNNiKovJU+HRqqJP9+FnUxolgK+RO84DQJUqsUTgZd29FxMmpXKpWslugjxbF
	RAbwu1Kl8qk5fz+tiZnXURCZiFatMG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737415142;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xAGjpc1NCvFI2p2TkVoOPDB5w/adTSJPEV++TvTJJqE=;
	b=KP9ipkdRcVe3TVYLE6YatoWaC4NX4uo4a7XOzUvAn+oY7F7y4hc90yVNHldjnf3glA4GIx
	ygJTDu96qFpPQzDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737415142;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xAGjpc1NCvFI2p2TkVoOPDB5w/adTSJPEV++TvTJJqE=;
	b=Mb+kWhAMh8/DjkPA2+DxJEyaRNLRjjO01llTO5bbqo2s8MvGTjVocw36kahuhiaAD9+vf+
	+e+sXYUaIbNNiKovJU+HRqqJP9+FnUxolgK+RO84DQJUqsUTgZd29FxMmpXKpWslugjxbF
	RAbwu1Kl8qk5fz+tiZnXURCZiFatMG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737415142;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xAGjpc1NCvFI2p2TkVoOPDB5w/adTSJPEV++TvTJJqE=;
	b=KP9ipkdRcVe3TVYLE6YatoWaC4NX4uo4a7XOzUvAn+oY7F7y4hc90yVNHldjnf3glA4GIx
	ygJTDu96qFpPQzDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C7AD1393E;
	Mon, 20 Jan 2025 23:19:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0+/IAubZjmcSJQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 20 Jan 2025 23:19:02 +0000
Date: Tue, 21 Jan 2025 00:18:56 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org, dvyukov@google.com
Subject: Re: [PATCH] btrfs: fix use-after-free when attempting to join an
 aborted transaction
Message-ID: <20250120231856.GF5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <f81151ae971c956f9b7e496a92bb67222452aee0.1737395071.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f81151ae971c956f9b7e496a92bb67222452aee0.1737395071.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.990];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Mon, Jan 20, 2025 at 05:46:21PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When we are trying to join the current transaction and if it's aborted,
> we read its 'aborted' field after unlocking fs_info->trans_lock and
> without holding any extra reference count on it. This means that a
> concurrent task that is aborting the transaction may free the transaction
> before we read its 'aborted' field, leading to a use-after-free.
> 
> Fix this by reading the 'aborted' field while holding fs_info->trans_lock
> since any freeing task must first acquire that lock and set
> fs_info->running_transaction to NULL before freeing the transaction.
> 
> This was reported by syzbot and Dmitry with the following stack traces
> from KASAN:
> 
>    ==================================================================
>    BUG: KASAN: slab-use-after-free in join_transaction+0xd9b/0xda0 fs/btrfs/transaction.c:278
>    Read of size 4 at addr ffff888011839024 by task kworker/u4:9/1128
> 
>    CPU: 0 UID: 0 PID: 1128 Comm: kworker/u4:9 Not tainted 6.13.0-rc7-syzkaller-00019-gc45323b7560e #0
>    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
>    Workqueue: events_unbound btrfs_async_reclaim_data_space
>    Call Trace:
>     <TASK>
>     __dump_stack lib/dump_stack.c:94 [inline]
>     dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>     print_address_description mm/kasan/report.c:378 [inline]
>     print_report+0x169/0x550 mm/kasan/report.c:489
>     kasan_report+0x143/0x180 mm/kasan/report.c:602
>     join_transaction+0xd9b/0xda0 fs/btrfs/transaction.c:278
>     start_transaction+0xaf8/0x1670 fs/btrfs/transaction.c:697
>     flush_space+0x448/0xcf0 fs/btrfs/space-info.c:803
>     btrfs_async_reclaim_data_space+0x159/0x510 fs/btrfs/space-info.c:1321
>     process_one_work kernel/workqueue.c:3236 [inline]
>     process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3317
>     worker_thread+0x870/0xd30 kernel/workqueue.c:3398
>     kthread+0x2f0/0x390 kernel/kthread.c:389
>     ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>     ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>     </TASK>
> 
>    Allocated by task 5315:
>     kasan_save_stack mm/kasan/common.c:47 [inline]
>     kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>     poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
>     __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
>     kasan_kmalloc include/linux/kasan.h:260 [inline]
>     __kmalloc_cache_noprof+0x243/0x390 mm/slub.c:4329
>     kmalloc_noprof include/linux/slab.h:901 [inline]
>     join_transaction+0x144/0xda0 fs/btrfs/transaction.c:308
>     start_transaction+0xaf8/0x1670 fs/btrfs/transaction.c:697
>     btrfs_create_common+0x1b2/0x2e0 fs/btrfs/inode.c:6572
>     lookup_open fs/namei.c:3649 [inline]
>     open_last_lookups fs/namei.c:3748 [inline]
>     path_openat+0x1c03/0x3590 fs/namei.c:3984
>     do_filp_open+0x27f/0x4e0 fs/namei.c:4014
>     do_sys_openat2+0x13e/0x1d0 fs/open.c:1402
>     do_sys_open fs/open.c:1417 [inline]
>     __do_sys_creat fs/open.c:1495 [inline]
>     __se_sys_creat fs/open.c:1489 [inline]
>     __x64_sys_creat+0x123/0x170 fs/open.c:1489
>     do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>     do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
>    Freed by task 5336:
>     kasan_save_stack mm/kasan/common.c:47 [inline]
>     kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>     kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
>     poison_slab_object mm/kasan/common.c:247 [inline]
>     __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
>     kasan_slab_free include/linux/kasan.h:233 [inline]
>     slab_free_hook mm/slub.c:2353 [inline]
>     slab_free mm/slub.c:4613 [inline]
>     kfree+0x196/0x430 mm/slub.c:4761
>     cleanup_transaction fs/btrfs/transaction.c:2063 [inline]
>     btrfs_commit_transaction+0x2c97/0x3720 fs/btrfs/transaction.c:2598
>     insert_balance_item+0x1284/0x20b0 fs/btrfs/volumes.c:3757
>     btrfs_balance+0x992/0x10c0 fs/btrfs/volumes.c:4633
>     btrfs_ioctl_balance+0x493/0x7c0 fs/btrfs/ioctl.c:3670
>     vfs_ioctl fs/ioctl.c:51 [inline]
>     __do_sys_ioctl fs/ioctl.c:906 [inline]
>     __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
>     do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>     do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
>    The buggy address belongs to the object at ffff888011839000
>     which belongs to the cache kmalloc-2k of size 2048
>    The buggy address is located 36 bytes inside of
>     freed 2048-byte region [ffff888011839000, ffff888011839800)
> 
>    The buggy address belongs to the physical page:
>    page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11838
>    head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
>    flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
>    page_type: f5(slab)
>    raw: 00fff00000000040 ffff88801ac42000 ffffea0000493400 dead000000000002
>    raw: 0000000000000000 0000000000080008 00000001f5000000 0000000000000000
>    head: 00fff00000000040 ffff88801ac42000 ffffea0000493400 dead000000000002
>    head: 0000000000000000 0000000000080008 00000001f5000000 0000000000000000
>    head: 00fff00000000003 ffffea0000460e01 ffffffffffffffff 0000000000000000
>    head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
>    page dumped because: kasan: bad access detected
>    page_owner tracks the page as allocated
>    page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 57, tgid 57 (kworker/0:2), ts 67248182943, free_ts 67229742023
>     set_page_owner include/linux/page_owner.h:32 [inline]
>     post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1558
>     prep_new_page mm/page_alloc.c:1566 [inline]
>     get_page_from_freelist+0x365c/0x37a0 mm/page_alloc.c:3476
>     __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4753
>     alloc_pages_mpol_noprof+0x3e1/0x780 mm/mempolicy.c:2269
>     alloc_slab_page+0x6a/0x110 mm/slub.c:2423
>     allocate_slab+0x5a/0x2b0 mm/slub.c:2589
>     new_slab mm/slub.c:2642 [inline]
>     ___slab_alloc+0xc27/0x14a0 mm/slub.c:3830
>     __slab_alloc+0x58/0xa0 mm/slub.c:3920
>     __slab_alloc_node mm/slub.c:3995 [inline]
>     slab_alloc_node mm/slub.c:4156 [inline]
>     __do_kmalloc_node mm/slub.c:4297 [inline]
>     __kmalloc_node_track_caller_noprof+0x2e9/0x4c0 mm/slub.c:4317
>     kmalloc_reserve+0x111/0x2a0 net/core/skbuff.c:609
>     __alloc_skb+0x1f3/0x440 net/core/skbuff.c:678
>     alloc_skb include/linux/skbuff.h:1323 [inline]
>     alloc_skb_with_frags+0xc3/0x820 net/core/skbuff.c:6612
>     sock_alloc_send_pskb+0x91a/0xa60 net/core/sock.c:2884
>     sock_alloc_send_skb include/net/sock.h:1803 [inline]
>     mld_newpack+0x1c3/0xaf0 net/ipv6/mcast.c:1747
>     add_grhead net/ipv6/mcast.c:1850 [inline]
>     add_grec+0x1492/0x19a0 net/ipv6/mcast.c:1988
>     mld_send_cr net/ipv6/mcast.c:2114 [inline]
>     mld_ifc_work+0x691/0xd90 net/ipv6/mcast.c:2651
>    page last free pid 5300 tgid 5300 stack trace:
>     reset_page_owner include/linux/page_owner.h:25 [inline]
>     free_pages_prepare mm/page_alloc.c:1127 [inline]
>     free_unref_page+0xd3f/0x1010 mm/page_alloc.c:2659
>     __slab_free+0x2c2/0x380 mm/slub.c:4524
>     qlink_free mm/kasan/quarantine.c:163 [inline]
>     qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
>     kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
>     __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
>     kasan_slab_alloc include/linux/kasan.h:250 [inline]
>     slab_post_alloc_hook mm/slub.c:4119 [inline]
>     slab_alloc_node mm/slub.c:4168 [inline]
>     __do_kmalloc_node mm/slub.c:4297 [inline]
>     __kmalloc_noprof+0x236/0x4c0 mm/slub.c:4310
>     kmalloc_noprof include/linux/slab.h:905 [inline]
>     kzalloc_noprof include/linux/slab.h:1037 [inline]
>     fib_create_info+0xc14/0x25b0 net/ipv4/fib_semantics.c:1435
>     fib_table_insert+0x1f6/0x1f20 net/ipv4/fib_trie.c:1231
>     fib_magic+0x3d8/0x620 net/ipv4/fib_frontend.c:1112
>     fib_add_ifaddr+0x40c/0x5e0 net/ipv4/fib_frontend.c:1156
>     fib_netdev_event+0x375/0x490 net/ipv4/fib_frontend.c:1494
>     notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
>     __dev_notify_flags+0x207/0x400
>     dev_change_flags+0xf0/0x1a0 net/core/dev.c:9045
>     do_setlink+0xc90/0x4210 net/core/rtnetlink.c:3109
>     rtnl_changelink net/core/rtnetlink.c:3723 [inline]
>     __rtnl_newlink net/core/rtnetlink.c:3875 [inline]
>     rtnl_newlink+0x1bb6/0x2210 net/core/rtnetlink.c:4012
> 
>    Memory state around the buggy address:
>     ffff888011838f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>     ffff888011838f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>    >ffff888011839000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                   ^
>     ffff888011839080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>     ffff888011839100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>    ==================================================================
> 
> Reported-by: syzbot+45212e9d87a98c3f5b42@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/678e7da5.050a0220.303755.007c.GAE@google.com/
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Link: https://lore.kernel.org/linux-btrfs/CACT4Y+ZFBdo7pT8L2AzM=vegZwjp-wNkVJZQf0Ta3vZqtExaSw@mail.gmail.com/
> Fixes: 871383be592b ("btrfs: add missing unlocks to transaction abort paths")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

