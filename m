Return-Path: <linux-btrfs+bounces-10973-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8F7A12588
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2025 15:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A64B167E65
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2025 14:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57B44D599;
	Wed, 15 Jan 2025 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uy/cU5n6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="68zow2T7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uy/cU5n6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="68zow2T7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DD524A7E6
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Jan 2025 14:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736949765; cv=none; b=bgDRruCddUK0KyFfhhONCCQmWGvvf/eleCdYDtAU/1gsfH7AnvGZyjwdvXhdA3SXkox3e2oxOADIkc+wplzBB5c6pB9yV7Szaa9vsDcUcuASMuKO/qQmmOrfuUA2u8eMUtEu4WB63MWvU6+Wroi3fBPFxVcq8FLpfzQI1TCN6PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736949765; c=relaxed/simple;
	bh=2mlyCUNP/dWgRXAY2vCpPi1qmYe46zNeUXMYvywfwYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EhML9we73dWBEvsoITgW8P3yQC2Q2v8i43f3yGD9CbA925ZG4DA0qNaclg63whSkAGYn18m15PnD+gpXFfvHe4CL/P9Pq+eH8iWWnLuvOUehYlQ0F6k3jStK1SIh1059HQ05t7g9Bf4Q81pqNgJIW8ORWujPxDqICt/Lgt+DT7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uy/cU5n6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=68zow2T7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uy/cU5n6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=68zow2T7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 690EF2121B;
	Wed, 15 Jan 2025 14:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736949760;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j3Kko3dE0jEzrWztuvUmFH+GAkTA1Z7StizDsma+l4o=;
	b=uy/cU5n65jLoYYUretdr8XAEgKoQyTVGPIQRMTe+ba6Vt5Wobn0/MiquLyX+0eUWwcgzLL
	Pw1/4fDY2d3niIqPiNSKdH7O9w1R1vdcq6HfmmfuXbIHa9/VtpSMIT8wVwdPZXz6jSewQI
	ZBx9AZd9fSbW2MhGS9FL7LqcFFEreiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736949760;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j3Kko3dE0jEzrWztuvUmFH+GAkTA1Z7StizDsma+l4o=;
	b=68zow2T76egb4kGnJEbvTP8plioNMEbuePo//zJmFNP43x1QEqv+hvTMM/NoxKXxCXnikw
	RfG9hzNbMm0p9zAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="uy/cU5n6";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=68zow2T7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736949760;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j3Kko3dE0jEzrWztuvUmFH+GAkTA1Z7StizDsma+l4o=;
	b=uy/cU5n65jLoYYUretdr8XAEgKoQyTVGPIQRMTe+ba6Vt5Wobn0/MiquLyX+0eUWwcgzLL
	Pw1/4fDY2d3niIqPiNSKdH7O9w1R1vdcq6HfmmfuXbIHa9/VtpSMIT8wVwdPZXz6jSewQI
	ZBx9AZd9fSbW2MhGS9FL7LqcFFEreiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736949760;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j3Kko3dE0jEzrWztuvUmFH+GAkTA1Z7StizDsma+l4o=;
	b=68zow2T76egb4kGnJEbvTP8plioNMEbuePo//zJmFNP43x1QEqv+hvTMM/NoxKXxCXnikw
	RfG9hzNbMm0p9zAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 412C9139CB;
	Wed, 15 Jan 2025 14:02:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xhhpDwDAh2frawAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 15 Jan 2025 14:02:40 +0000
Date: Wed, 15 Jan 2025 15:02:30 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix lockdep splat while merging a relocation root
Message-ID: <20250115140230.GB5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <79e35a242bceafc9cb6d88e336ddfee5115a3ba5.1736524334.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79e35a242bceafc9cb6d88e336ddfee5115a3ba5.1736524334.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 690EF2121B
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:replyto,suse.cz:dkim];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Jan 10, 2025 at 04:52:24PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When COWing a relocation tree path, at relocation.c:replace_path(), we
> can trigger a lockdep splat while we are in the btrfs_search_slot() call
> against the relocation root. This happens in that callchain at
> ctree.c:read_block_for_search() when we happen to find a child extent
> buffer already loaded through the fs tree with a lockdep class set to
> the fs tree. So when we attempt to lock that extent buffer through a
> relocation tree we have to reset the lockdep class to the class for a
> relocation tree, since a relocation tree has extent buffers that used
> to belong to a fs tree and may currently be already loaded (we swap
> extent buffers between the two trees at the end of replace_path()).
> 
> However we are missing calls to btrfs_maybe_reset_lockdep_class() to reset
> the lockdep class at ctree.c:read_block_for_search() before we read lock
> an extent buffer, just like we did for btrfs_search_slot() in commit
> b40130b23ca4 ("btrfs: fix lockdep splat with reloc root extent buffers").
> 
> So add the missing btrfs_maybe_reset_lockdep_class() calls before the
> attempts to read lock an extent buffer at ctree.c:read_block_for_search().
> 
> The lockdep splat was reported by syzbot and it looks like this:
> 
>    ======================================================
>    WARNING: possible circular locking dependency detected
>    6.13.0-rc5-syzkaller-00163-gab75170520d4 #0 Not tainted
>    ------------------------------------------------------
>    syz.0.0/5335 is trying to acquire lock:
>    ffff8880545dbc38 (btrfs-tree-01){++++}-{4:4}, at: btrfs_tree_read_lock_nested+0x2f/0x250 fs/btrfs/locking.c:146
> 
>    but task is already holding lock:
>    ffff8880545dba58 (btrfs-treloc-02/1){+.+.}-{4:4}, at: btrfs_tree_lock_nested+0x2f/0x250 fs/btrfs/locking.c:189
> 
>    which lock already depends on the new lock.
> 
>    the existing dependency chain (in reverse order) is:
> 
>    -> #2 (btrfs-treloc-02/1){+.+.}-{4:4}:
>           reacquire_held_locks+0x3eb/0x690 kernel/locking/lockdep.c:5374
>           __lock_release kernel/locking/lockdep.c:5563 [inline]
>           lock_release+0x396/0xa30 kernel/locking/lockdep.c:5870
>           up_write+0x79/0x590 kernel/locking/rwsem.c:1629
>           btrfs_force_cow_block+0x14b3/0x1fd0 fs/btrfs/ctree.c:660
>           btrfs_cow_block+0x371/0x830 fs/btrfs/ctree.c:755
>           btrfs_search_slot+0xc01/0x3180 fs/btrfs/ctree.c:2153
>           replace_path+0x1243/0x2740 fs/btrfs/relocation.c:1224
>           merge_reloc_root+0xc46/0x1ad0 fs/btrfs/relocation.c:1692
>           merge_reloc_roots+0x3b3/0x980 fs/btrfs/relocation.c:1942
>           relocate_block_group+0xb0a/0xd40 fs/btrfs/relocation.c:3754
>           btrfs_relocate_block_group+0x77d/0xd90 fs/btrfs/relocation.c:4087
>           btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3494
>           __btrfs_balance+0x1b0f/0x26b0 fs/btrfs/volumes.c:4278
>           btrfs_balance+0xbdc/0x10c0 fs/btrfs/volumes.c:4655
>           btrfs_ioctl_balance+0x493/0x7c0 fs/btrfs/ioctl.c:3670
>           vfs_ioctl fs/ioctl.c:51 [inline]
>           __do_sys_ioctl fs/ioctl.c:906 [inline]
>           __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
>           do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>           do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>           entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
>    -> #1 (btrfs-tree-01/1){+.+.}-{4:4}:
>           lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
>           down_write_nested+0xa2/0x220 kernel/locking/rwsem.c:1693
>           btrfs_tree_lock_nested+0x2f/0x250 fs/btrfs/locking.c:189
>           btrfs_init_new_buffer fs/btrfs/extent-tree.c:5052 [inline]
>           btrfs_alloc_tree_block+0x41c/0x1440 fs/btrfs/extent-tree.c:5132
>           btrfs_force_cow_block+0x526/0x1fd0 fs/btrfs/ctree.c:573
>           btrfs_cow_block+0x371/0x830 fs/btrfs/ctree.c:755
>           btrfs_search_slot+0xc01/0x3180 fs/btrfs/ctree.c:2153
>           btrfs_insert_empty_items+0x9c/0x1a0 fs/btrfs/ctree.c:4351
>           btrfs_insert_empty_item fs/btrfs/ctree.h:688 [inline]
>           btrfs_insert_inode_ref+0x2bb/0xf80 fs/btrfs/inode-item.c:330
>           btrfs_rename_exchange fs/btrfs/inode.c:7990 [inline]
>           btrfs_rename2+0xcb7/0x2b90 fs/btrfs/inode.c:8374
>           vfs_rename+0xbdb/0xf00 fs/namei.c:5067
>           do_renameat2+0xd94/0x13f0 fs/namei.c:5224
>           __do_sys_renameat2 fs/namei.c:5258 [inline]
>           __se_sys_renameat2 fs/namei.c:5255 [inline]
>           __x64_sys_renameat2+0xce/0xe0 fs/namei.c:5255
>           do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>           do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>           entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
>    -> #0 (btrfs-tree-01){++++}-{4:4}:
>           check_prev_add kernel/locking/lockdep.c:3161 [inline]
>           check_prevs_add kernel/locking/lockdep.c:3280 [inline]
>           validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
>           __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
>           lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
>           down_read_nested+0xb5/0xa50 kernel/locking/rwsem.c:1649
>           btrfs_tree_read_lock_nested+0x2f/0x250 fs/btrfs/locking.c:146
>           btrfs_tree_read_lock fs/btrfs/locking.h:188 [inline]
>           read_block_for_search+0x718/0xbb0 fs/btrfs/ctree.c:1610
>           btrfs_search_slot+0x1274/0x3180 fs/btrfs/ctree.c:2237
>           replace_path+0x1243/0x2740 fs/btrfs/relocation.c:1224
>           merge_reloc_root+0xc46/0x1ad0 fs/btrfs/relocation.c:1692
>           merge_reloc_roots+0x3b3/0x980 fs/btrfs/relocation.c:1942
>           relocate_block_group+0xb0a/0xd40 fs/btrfs/relocation.c:3754
>           btrfs_relocate_block_group+0x77d/0xd90 fs/btrfs/relocation.c:4087
>           btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3494
>           __btrfs_balance+0x1b0f/0x26b0 fs/btrfs/volumes.c:4278
>           btrfs_balance+0xbdc/0x10c0 fs/btrfs/volumes.c:4655
>           btrfs_ioctl_balance+0x493/0x7c0 fs/btrfs/ioctl.c:3670
>           vfs_ioctl fs/ioctl.c:51 [inline]
>           __do_sys_ioctl fs/ioctl.c:906 [inline]
>           __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
>           do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>           do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>           entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
>    other info that might help us debug this:
> 
>    Chain exists of:
>      btrfs-tree-01 --> btrfs-tree-01/1 --> btrfs-treloc-02/1
> 
>     Possible unsafe locking scenario:
> 
>           CPU0                    CPU1
>           ----                    ----
>      lock(btrfs-treloc-02/1);
>                                   lock(btrfs-tree-01/1);
>                                   lock(btrfs-treloc-02/1);
>      rlock(btrfs-tree-01);
> 
>     *** DEADLOCK ***
> 
>    8 locks held by syz.0.0/5335:
>     #0: ffff88801e3ae420 (sb_writers#13){.+.+}-{0:0}, at: mnt_want_write_file+0x5e/0x200 fs/namespace.c:559
>     #1: ffff888052c760d0 (&fs_info->reclaim_bgs_lock){+.+.}-{4:4}, at: __btrfs_balance+0x4c2/0x26b0 fs/btrfs/volumes.c:4183
>     #2: ffff888052c74850 (&fs_info->cleaner_mutex){+.+.}-{4:4}, at: btrfs_relocate_block_group+0x775/0xd90 fs/btrfs/relocation.c:4086
>     #3: ffff88801e3ae610 (sb_internal#2){.+.+}-{0:0}, at: merge_reloc_root+0xf11/0x1ad0 fs/btrfs/relocation.c:1659
>     #4: ffff888052c76470 (btrfs_trans_num_writers){++++}-{0:0}, at: join_transaction+0x405/0xda0 fs/btrfs/transaction.c:288
>     #5: ffff888052c76498 (btrfs_trans_num_extwriters){++++}-{0:0}, at: join_transaction+0x405/0xda0 fs/btrfs/transaction.c:288
>     #6: ffff8880545db878 (btrfs-tree-01/1){+.+.}-{4:4}, at: btrfs_tree_lock_nested+0x2f/0x250 fs/btrfs/locking.c:189
>     #7: ffff8880545dba58 (btrfs-treloc-02/1){+.+.}-{4:4}, at: btrfs_tree_lock_nested+0x2f/0x250 fs/btrfs/locking.c:189
> 
>    stack backtrace:
>    CPU: 0 UID: 0 PID: 5335 Comm: syz.0.0 Not tainted 6.13.0-rc5-syzkaller-00163-gab75170520d4 #0
>    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
>    Call Trace:
>     <TASK>
>     __dump_stack lib/dump_stack.c:94 [inline]
>     dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>     print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
>     check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
>     check_prev_add kernel/locking/lockdep.c:3161 [inline]
>     check_prevs_add kernel/locking/lockdep.c:3280 [inline]
>     validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
>     __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
>     lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
>     down_read_nested+0xb5/0xa50 kernel/locking/rwsem.c:1649
>     btrfs_tree_read_lock_nested+0x2f/0x250 fs/btrfs/locking.c:146
>     btrfs_tree_read_lock fs/btrfs/locking.h:188 [inline]
>     read_block_for_search+0x718/0xbb0 fs/btrfs/ctree.c:1610
>     btrfs_search_slot+0x1274/0x3180 fs/btrfs/ctree.c:2237
>     replace_path+0x1243/0x2740 fs/btrfs/relocation.c:1224
>     merge_reloc_root+0xc46/0x1ad0 fs/btrfs/relocation.c:1692
>     merge_reloc_roots+0x3b3/0x980 fs/btrfs/relocation.c:1942
>     relocate_block_group+0xb0a/0xd40 fs/btrfs/relocation.c:3754
>     btrfs_relocate_block_group+0x77d/0xd90 fs/btrfs/relocation.c:4087
>     btrfs_relocate_chunk+0x12c/0x3b0 fs/btrfs/volumes.c:3494
>     __btrfs_balance+0x1b0f/0x26b0 fs/btrfs/volumes.c:4278
>     btrfs_balance+0xbdc/0x10c0 fs/btrfs/volumes.c:4655
>     btrfs_ioctl_balance+0x493/0x7c0 fs/btrfs/ioctl.c:3670
>     vfs_ioctl fs/ioctl.c:51 [inline]
>     __do_sys_ioctl fs/ioctl.c:906 [inline]
>     __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
>     do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>     do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    RIP: 0033:0x7f1ac6985d29
>    Code: ff ff c3 (...)
>    RSP: 002b:00007f1ac63fe038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>    RAX: ffffffffffffffda RBX: 00007f1ac6b76160 RCX: 00007f1ac6985d29
>    RDX: 0000000020000180 RSI: 00000000c4009420 RDI: 0000000000000007
>    RBP: 00007f1ac6a01b08 R08: 0000000000000000 R09: 0000000000000000
>    R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>    R13: 0000000000000001 R14: 00007f1ac6b76160 R15: 00007fffda145a88
>     </TASK>
> 
> Reported-by: syzbot+63913e558c084f7f8fdc@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/677b3014.050a0220.3b53b0.0064.GAE@google.com/
> Fixes: 99785998ed1c ("btrfs: reduce lock contention when eb cache miss for btree search")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

