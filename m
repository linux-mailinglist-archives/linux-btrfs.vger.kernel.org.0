Return-Path: <linux-btrfs+bounces-13494-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E0EAA05B3
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 10:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35F2F16532A
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 08:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842B3280A52;
	Tue, 29 Apr 2025 08:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HvAvZq0O";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fOc64Uoh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HvAvZq0O";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fOc64Uoh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DEA276026
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Apr 2025 08:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745915242; cv=none; b=YAYvQ94FhHhcHh3bcrczd95TgJnmbCt8NrIGQqgoo6WcgRbUGrU7G0iriMCFM7f7If83PAU7xDcp0j0TKpd4AemA1GsOfUwxa0eL/HvW61bjojbC2+U6JO8WOJVkDAfUtzrkAY9q7r5klW2TpRwbKGfAmNQWutL1iWltJLPsExA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745915242; c=relaxed/simple;
	bh=+Kd+jc7REpTQYyACq2vi8Lf5OD5ORjqOLw5cJuPhcJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJ1tfrdM49FWWlr9BwxBIcGbnbyqUIl6pUWUeSEwH2VXu/pyKBrpHIRPnYg7ld0yLqhhH/KRlY6aXAybmPOFwOdkCBk0ogK1G+K3l/XVUmaOaeGteWAp8C4PPNJAmN34Ii2A1Acc/3Wt2mNM3L2I+DLIlI/Zp0JJXeoPBrh5I58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HvAvZq0O; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fOc64Uoh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HvAvZq0O; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fOc64Uoh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 335141F390;
	Tue, 29 Apr 2025 08:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745915233;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LBAm3belvjDgor3krh/nfCJdNVQiTgdVcs6wVi6GhAw=;
	b=HvAvZq0O1y9Xg6V6qheZJi7C8bAX2eVLYx5A5MmHNl+8pwhlG93eiq45DVu0nppEaB8+pE
	X1xP0jUNsp55yY1CKXyJASHQBFsBYCypRdSIgHTwm+arJ7f1ea7xRpD3epaWzegiyNq2w6
	9Hh4eIFEwwI8peR0+vmepyb9+Cr8SAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745915233;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LBAm3belvjDgor3krh/nfCJdNVQiTgdVcs6wVi6GhAw=;
	b=fOc64Uohfw4bQX07mceTt1HdADhgXnnWlVe6AsWLpSFRXlUpy5VAJbE2r07h01NsURFYzS
	qo+Q+bQLH+SnovDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745915233;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LBAm3belvjDgor3krh/nfCJdNVQiTgdVcs6wVi6GhAw=;
	b=HvAvZq0O1y9Xg6V6qheZJi7C8bAX2eVLYx5A5MmHNl+8pwhlG93eiq45DVu0nppEaB8+pE
	X1xP0jUNsp55yY1CKXyJASHQBFsBYCypRdSIgHTwm+arJ7f1ea7xRpD3epaWzegiyNq2w6
	9Hh4eIFEwwI8peR0+vmepyb9+Cr8SAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745915233;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LBAm3belvjDgor3krh/nfCJdNVQiTgdVcs6wVi6GhAw=;
	b=fOc64Uohfw4bQX07mceTt1HdADhgXnnWlVe6AsWLpSFRXlUpy5VAJbE2r07h01NsURFYzS
	qo+Q+bQLH+SnovDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1247F13931;
	Tue, 29 Apr 2025 08:27:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LupGBGGNEGiQBQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 29 Apr 2025 08:27:13 +0000
Date: Tue, 29 Apr 2025 10:27:11 +0200
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: track current commit duration in commit_stats
Message-ID: <20250429082711.GA9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <6cb65fc2544863eb6b3ca48b094cf7004e06af69.1745538939.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cb65fc2544863eb6b3ca48b094cf7004e06af69.1745538939.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,opensuse.org:url,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Thu, Apr 24, 2025 at 04:56:34PM -0700, Boris Burkov wrote:
> When debugging/detecting outlier commit stalls, having an indicator that
> we are currently in a long commit critical section can be very useful.
> Extend the commit_stats sysfs file to also include the current commit
> critical section duration.
> 
> Since this requires storing the last commit start time, use that rather
> than a separate stack variable for storing the finished commit durations
> as well.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/fs.h          |  2 ++
>  fs/btrfs/sysfs.c       |  8 ++++++++
>  fs/btrfs/transaction.c | 17 +++++++++--------
>  3 files changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index bcca43046064..1f375170cdcb 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -419,6 +419,8 @@ struct btrfs_commit_stats {
>  	u64 last_commit_dur;
>  	/* The total commit duration in ns */
>  	u64 total_commit_dur;
> +	/* Start of the last critical section in ns. */
> +	u64 start_time;
>  };
>  
>  struct btrfs_fs_info {
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index b9af74498b0c..4e35b4bfffaa 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1138,13 +1138,21 @@ static ssize_t btrfs_commit_stats_show(struct kobject *kobj,
>  				       struct kobj_attribute *a, char *buf)
>  {
>  	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
> +	u64 now = ktime_get_ns();
> +	u64 start_time = fs_info->commit_stats.start_time;
> +	u64 pending = 0;
> +
> +	if (start_time)
> +		pending = now - start_time;
>  
>  	return sysfs_emit(buf,
>  		"commits %llu\n"
> +		"cur_commit_ms %llu\n"
>  		"last_commit_ms %llu\n"
>  		"max_commit_ms %llu\n"
>  		"total_commit_ms %llu\n",
>  		fs_info->commit_stats.commit_count,
> +		div_u64(pending, NSEC_PER_MSEC),
>  		div_u64(fs_info->commit_stats.last_commit_dur, NSEC_PER_MSEC),
>  		div_u64(fs_info->commit_stats.max_commit_dur, NSEC_PER_MSEC),
>  		div_u64(fs_info->commit_stats.total_commit_dur, NSEC_PER_MSEC));
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 39e48bf610a1..02e6926d53bd 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -2164,13 +2164,19 @@ static void add_pending_snapshot(struct btrfs_trans_handle *trans)
>  	list_add(&trans->pending_snapshot->list, &cur_trans->pending_snapshots);
>  }
>  
> -static void update_commit_stats(struct btrfs_fs_info *fs_info, ktime_t interval)
> +static void update_commit_stats(struct btrfs_fs_info *fs_info)
>  {
> +	ktime_t now = ktime_get_ns();
> +	ktime_t interval = now - fs_info->commit_stats.start_time;
> +
> +	ASSERT(fs_info->commit_stats.start_time);

[ 2469.533069] assertion failed: fs_info->commit_stats.start_time :: 0, in fs/btrfs/transaction.c:2172
[ 2469.536071] ------------[ cut here ]------------
[ 2469.537543] kernel BUG at fs/btrfs/transaction.c:2172!
[ 2469.539158] Oops: invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN
[ 2469.541112] CPU: 11 UID: 0 PID: 4140 Comm: fsstress Not tainted 6.15.0-rc4-default+ #109 PREEMPT(full) 
[ 2469.543907] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
[ 2469.547238] RIP: 0010:btrfs_commit_transaction.cold+0x126/0x1dd [btrfs]
[ 2469.554618] RSP: 0018:ffff8880059dfc58 EFLAGS: 00010282
[ 2469.556210] RAX: 0000000000000057 RBX: ffff888006414000 RCX: 0000000000000000
[ 2469.558319] RDX: 0000000000000057 RSI: 0000000000000004 RDI: ffffed1000b3bf7e
[ 2469.560427] RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff54e5f34
[ 2469.562575] R10: 0000000000000003 R11: 0000000000000001 R12: ffff88800374e800
[ 2469.564682] R13: 0000023eedb59554 R14: ffff88800374e8f8 R15: ffff88800b01a948
[ 2469.566788] FS:  00007f590f740180(0000) GS:ffff8880bab98000(0000) knlGS:0000000000000000
[ 2469.569219] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2469.570971] CR2: 00007f416fd9e038 CR3: 000000001f3ee000 CR4: 00000000000006b0
[ 2469.573076] Call Trace:
[ 2469.573954]  <TASK>
[ 2469.574737]  ? cleanup_transaction+0x1a0/0x1a0 [btrfs]
[ 2469.576421]  ? __lock_release.isra.0+0xc1/0x2e0
[ 2469.577847]  ? preempt_count_add+0x79/0x150
[ 2469.579171]  ? __up_write+0x1b3/0x520
[ 2469.580377]  ? btrfs_sync_file+0xb4b/0xd30 [btrfs]
[ 2469.581961]  btrfs_sync_file+0x740/0xd30 [btrfs]
[ 2469.583507]  ? start_ordered_ops.constprop.0+0x100/0x100 [btrfs]
[ 2469.585406]  do_fsync+0x39/0x70
[ 2469.586475]  __x64_sys_fsync+0x2e/0x40
[ 2469.587693]  do_syscall_64+0x6d/0x140
[ 2469.588894]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[ 2469.590461] RIP: 0033:0x7f590f853874
[ 2469.591626] Code: 00 e9 a0 5b f1 ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 90 90 80 3d 35 81 0f 00 00 74 13 b8 4a 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 44 c3 0f 1f 00 48 83 ec 18 89 7c 24 0c e8 b1
[ 2469.596956] RSP: 002b:00007fffe09524d8 EFLAGS: 00000202 ORIG_RAX: 000000000000004a
[ 2469.599242] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f590f853874
[ 2469.601341] RDX: 0000000000000103 RSI: 0000000000411059 RDI: 0000000000000004
[ 2469.603429] RBP: 0000000000001049 R08: fefefefefefefeff R09: 00007fffe09524ec
[ 2469.605525] R10: 0000000000000000 R11: 0000000000000202 R12: 00007fffe09524f0
[ 2469.607631] R13: 0000000000000000 R14: 00007fffe0952590 R15: 000000000040cdc0
[ 2469.609742]  </TASK>
[ 2469.610552] Modules linked in: btrfs blake2b_generic xor lzo_compress lzo_decompress raid6_pq zstd_decompress zstd_compress zstd_common xxhash loop
[ 2469.614356] ---[ end trace 0000000000000000 ]---
[ 2469.615800] RIP: 0010:btrfs_commit_transaction.cold+0x126/0x1dd [btrfs]
[ 2469.623202] RSP: 0018:ffff8880059dfc58 EFLAGS: 00010282
[ 2469.624798] RAX: 0000000000000057 RBX: ffff888006414000 RCX: 0000000000000000
[ 2469.626912] RDX: 0000000000000057 RSI: 0000000000000004 RDI: ffffed1000b3bf7e
[ 2469.629000] RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff54e5f34
[ 2469.631125] R10: 0000000000000003 R11: 0000000000000001 R12: ffff88800374e800
[ 2469.633231] R13: 0000023eedb59554 R14: ffff88800374e8f8 R15: ffff88800b01a948
[ 2469.635350] FS:  00007f590f740180(0000) GS:ffff8880bab98000(0000) knlGS:0000000000000000
[ 2469.637818] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2469.639568] CR2: 00007f416fd9e038 CR3: 000000001f3ee000 CR4: 00000000000006b0

