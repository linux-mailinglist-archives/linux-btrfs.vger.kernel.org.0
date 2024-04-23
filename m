Return-Path: <linux-btrfs+bounces-4497-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE4B8AE8FC
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 16:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15197289942
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Apr 2024 14:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95DB13B59F;
	Tue, 23 Apr 2024 14:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zfGlqRqR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WyXOalha";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BEtgJ3Dn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fgxFqzet"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F803138499
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Apr 2024 14:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880881; cv=none; b=hFLHI6uzlW1LBkMorgAUaG0poE2VvSOX40lUWMAbjLFock4uOgxJPutUufcI+MvhT2FNCnDGf7dijnG5ceGMASB/ZelTIeMY7gdBgJx2kxxg8bRU6oBZR/CtCxF1Vsaka1yIS5bKQXJvSZvSLDhtt3I2O//VSACrl9QAzZvCb6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880881; c=relaxed/simple;
	bh=iy8EGWbLQjRBunYoD2SNfUb6YaH69X3mNyr6fFgB/G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ojhqs5XyaQOfGVNRDJwllJ1SCFb29GQj6sFk/bVPl9et8gHP/DPhnkcJ8LckJSpG0KTIbLr64EYLtPkSDxz8ufVR5xkv1fWraDLoFMauS0wONozV/RMKqhGWs303KlKG285vsCF8bM1JPIjKcu0ZL/X2XKqVg7tWUP3wyq5CgKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zfGlqRqR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WyXOalha; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BEtgJ3Dn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fgxFqzet; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 700833806C;
	Tue, 23 Apr 2024 14:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713880874;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VygskM6dhVYCT181JnvaOMaDO5ZAxPE1M+AI58+KU0E=;
	b=zfGlqRqRpLZCLYyyMUJl2vB9OAuZVfjJPuN/IRsENZVrB529Vpn5W12LyhhP3Cy4PJxmtZ
	f8/24h55qJT7Q/rHfoZqx+2Xb++D8c5W7fuZ2YzJ7V5uTGjaQZNSFRoP48NY7LlJmk3O/v
	6p495gKMydxtvgjUMyqpqijeK8RWBmk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713880874;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VygskM6dhVYCT181JnvaOMaDO5ZAxPE1M+AI58+KU0E=;
	b=WyXOalhaKpA97XRDXaNUhfMHATxunB52pxeU4aQ5JlCE3HN7H6NCMC9ULtLw7AWRleqlVB
	8RWqGNv2T5nR2jBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BEtgJ3Dn;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fgxFqzet
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713880873;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VygskM6dhVYCT181JnvaOMaDO5ZAxPE1M+AI58+KU0E=;
	b=BEtgJ3DnY5uy71fjLGIiC5TEu7zG90bH0kmUB5ivcoyLS8qinOX0WAMdwSEVLrFUkI3i6/
	22hpPdxacsNMh8x4YdkvoI+UT+9tfJ3RVl36vGsl0bqmhEjKfiPHYZy9mFKRJgG0a5CMtD
	0majoYJN62CaVDi2WVoqE5Toay1yD3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713880873;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VygskM6dhVYCT181JnvaOMaDO5ZAxPE1M+AI58+KU0E=;
	b=fgxFqzetq9Bwx7A+8CaUwD8dimK9L8fwmtyV+zbSms1P8eyCMuq6c9GRiFhd3gNWJYv/LN
	51SoUl7/hAk9AqBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E9D513929;
	Tue, 23 Apr 2024 14:01:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5BcLEym/J2Z+dAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 23 Apr 2024 14:01:13 +0000
Date: Tue, 23 Apr 2024 15:53:40 +0200
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: take the cleaner_mutex earlier in qgroup disable
Message-ID: <20240423135340.GF3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <a78874868a1d3d8d78e6b0fdbb97debc88923734.1713573156.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a78874868a1d3d8d78e6b0fdbb97debc88923734.1713573156.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto,toxicpanda.com:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 700833806C
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.21

On Fri, Apr 19, 2024 at 08:32:48PM -0400, Josef Bacik wrote:
> One of my CI runs popped the following lockdep splat
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 6.9.0-rc4+ #1 Not tainted
> ------------------------------------------------------
> btrfs/471533 is trying to acquire lock:
> ffff92ba46980850 (&fs_info->cleaner_mutex){+.+.}-{3:3}, at: btrfs_quota_disable+0x54/0x4c0
> 
> but task is already holding lock:
> ffff92ba46980bd0 (&fs_info->subvol_sem){++++}-{3:3}, at: btrfs_ioctl+0x1c8f/0x2600
> 
> which lock already depends on the new lock.
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #2 (&fs_info->subvol_sem){++++}-{3:3}:
>        down_read+0x42/0x170
>        btrfs_rename+0x607/0xb00
>        btrfs_rename2+0x2e/0x70
>        vfs_rename+0xaf8/0xfc0
>        do_renameat2+0x586/0x600
>        __x64_sys_rename+0x43/0x50
>        do_syscall_64+0x95/0x180
>        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> -> #1 (&sb->s_type->i_mutex_key#16){++++}-{3:3}:
>        down_write+0x3f/0xc0
>        btrfs_inode_lock+0x40/0x70
>        prealloc_file_extent_cluster+0x1b0/0x370
>        relocate_file_extent_cluster+0xb2/0x720
>        relocate_data_extent+0x107/0x160
>        relocate_block_group+0x442/0x550
>        btrfs_relocate_block_group+0x2cb/0x4b0
>        btrfs_relocate_chunk+0x50/0x1b0
>        btrfs_balance+0x92f/0x13d0
>        btrfs_ioctl+0x1abf/0x2600
>        __x64_sys_ioctl+0x97/0xd0
>        do_syscall_64+0x95/0x180
>        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> -> #0 (&fs_info->cleaner_mutex){+.+.}-{3:3}:
>        __lock_acquire+0x13e7/0x2180
>        lock_acquire+0xcb/0x2e0
>        __mutex_lock+0xbe/0xc00
>        btrfs_quota_disable+0x54/0x4c0
>        btrfs_ioctl+0x206b/0x2600
>        __x64_sys_ioctl+0x97/0xd0
>        do_syscall_64+0x95/0x180
>        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> other info that might help us debug this:
> 
> Chain exists of:
>   &fs_info->cleaner_mutex --> &sb->s_type->i_mutex_key#16 --> &fs_info->subvol_sem
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(&fs_info->subvol_sem);
>                                lock(&sb->s_type->i_mutex_key#16);
>                                lock(&fs_info->subvol_sem);
>   lock(&fs_info->cleaner_mutex);
> 
>  *** DEADLOCK ***
> 
> 2 locks held by btrfs/471533:
>  #0: ffff92ba4319e420 (sb_writers#14){.+.+}-{0:0}, at: btrfs_ioctl+0x3b5/0x2600
>  #1: ffff92ba46980bd0 (&fs_info->subvol_sem){++++}-{3:3}, at: btrfs_ioctl+0x1c8f/0x2600
> 
> stack backtrace:
> CPU: 1 PID: 471533 Comm: btrfs Kdump: loaded Not tainted 6.9.0-rc4+ #1
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x77/0xb0
>  check_noncircular+0x148/0x160
>  ? lock_acquire+0xcb/0x2e0
>  __lock_acquire+0x13e7/0x2180
>  lock_acquire+0xcb/0x2e0
>  ? btrfs_quota_disable+0x54/0x4c0
>  ? lock_is_held_type+0x9a/0x110
>  __mutex_lock+0xbe/0xc00
>  ? btrfs_quota_disable+0x54/0x4c0
>  ? srso_return_thunk+0x5/0x5f
>  ? lock_acquire+0xcb/0x2e0
>  ? btrfs_quota_disable+0x54/0x4c0
>  ? btrfs_quota_disable+0x54/0x4c0
>  btrfs_quota_disable+0x54/0x4c0
>  btrfs_ioctl+0x206b/0x2600
>  ? srso_return_thunk+0x5/0x5f
>  ? __do_sys_statfs+0x61/0x70
>  __x64_sys_ioctl+0x97/0xd0
>  do_syscall_64+0x95/0x180
>  ? srso_return_thunk+0x5/0x5f
>  ? reacquire_held_locks+0xd1/0x1f0
>  ? do_user_addr_fault+0x307/0x8a0
>  ? srso_return_thunk+0x5/0x5f
>  ? lock_acquire+0xcb/0x2e0
>  ? srso_return_thunk+0x5/0x5f
>  ? srso_return_thunk+0x5/0x5f
>  ? find_held_lock+0x2b/0x80
>  ? srso_return_thunk+0x5/0x5f
>  ? lock_release+0xca/0x2a0
>  ? srso_return_thunk+0x5/0x5f
>  ? do_user_addr_fault+0x35c/0x8a0
>  ? srso_return_thunk+0x5/0x5f
>  ? trace_hardirqs_off+0x4b/0xc0
>  ? srso_return_thunk+0x5/0x5f
>  ? lockdep_hardirqs_on_prepare+0xde/0x190
>  ? srso_return_thunk+0x5/0x5f
> 
> This happens because when we call rename we already have the inode mutex
> held, and then we acquire the subvol_sem if we are a subvolume.  This
> makes the dependency
> 
> inode lock -> subvol sem
> 
> When we're running data relocation we will preallocate space for the
> data relocation inode, and we always run the relocation under the
> ->cleaner_mutex.  This now creates the dependency of
> 
> cleaner_mutex -> inode lock (from the prealloc) -> subvol_sem
> 
> Qgroup delete is doing this in the opposite order, it is acquiring the
> subvol_sem and then it is acquiring the cleaner_mutex, which results in
> this lockdep splat.  This deadlock can't happen in reality, because we
> won't ever rename the data reloc inode, nor is the data reloc inode a
> subvolume.
> 
> However this is fairly easy to fix, simply take the cleaner mutex in the
> case where we are disabling qgroups before we take the subvol_sem.  This
> resolves the lockdep splat.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: David Sterba <dsterba@suse.com>

