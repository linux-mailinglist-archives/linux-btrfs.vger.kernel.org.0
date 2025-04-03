Return-Path: <linux-btrfs+bounces-12779-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A03A7B03D
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Apr 2025 23:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1755188EFCC
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Apr 2025 21:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96EF1EEA5F;
	Thu,  3 Apr 2025 20:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fQjN/7Il";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MN7KrkR8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fQjN/7Il";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MN7KrkR8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394C3198E63
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Apr 2025 20:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743711755; cv=none; b=qnCxDesNStkOQxZnQLO6tdf7fyo+6dOTLRkEE3xHINI3ZSQ0q+s/faYs3MF7VSvIpSH8G3VkZ8e7MrypNXg9BmX7Ff+wU9ul1CPlt728g8j9pn461Ly2y5NwZcLdkoH5gBDoAZnNZxmlR317XsMhWd5Rdu/Ri/AhLglhZFA/g+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743711755; c=relaxed/simple;
	bh=Ai/W06qhLqD+CLsV96h+bphkMbzSxfpefdgLG6+AoCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBC2BF5mCwbHtjeOfD2qHrWUcfRFJ4wxpqZebwQ7VO9pPcT64oOrEgBClrXDillMZJ1xQcbkrHl3gyPaCZ/NTLbW1My4NuibzpiL1VYabeKHcTCzomv9tk9aT3m237V7o3dFrSt9rsySuE5w8jbp0YplvRpLdc5zLriEPZVGewI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fQjN/7Il; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MN7KrkR8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fQjN/7Il; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MN7KrkR8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F3F0821171;
	Thu,  3 Apr 2025 20:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743711751;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uTsCU4TzTAT25x0nNXfW9pD5IZ9GYxVOt8AHjhTiYRo=;
	b=fQjN/7IlQV6np/JStHCObU5ZQXWc93Ox1h7Yg9PRN8riJAhptOKmnkCzkmWTm+KE7BdTLx
	xCFLV8kGcJlobWfbFtRDR91LYScM5u8qCqsqlXxsw7FSAdnBPeI+SXxjI6Qb69ja92YVU8
	Tqek5hVdKO+6i3PjKLESGlbYXvYXrv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743711751;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uTsCU4TzTAT25x0nNXfW9pD5IZ9GYxVOt8AHjhTiYRo=;
	b=MN7KrkR8JPEr9sKZgElmZnZ60H3NoPHj/4FwQYbNNHqieUfOuJ/JePkRDiv1CxOdcs6D55
	R04Bm7Yj22Ksi3DQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="fQjN/7Il";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=MN7KrkR8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743711751;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uTsCU4TzTAT25x0nNXfW9pD5IZ9GYxVOt8AHjhTiYRo=;
	b=fQjN/7IlQV6np/JStHCObU5ZQXWc93Ox1h7Yg9PRN8riJAhptOKmnkCzkmWTm+KE7BdTLx
	xCFLV8kGcJlobWfbFtRDR91LYScM5u8qCqsqlXxsw7FSAdnBPeI+SXxjI6Qb69ja92YVU8
	Tqek5hVdKO+6i3PjKLESGlbYXvYXrv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743711751;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uTsCU4TzTAT25x0nNXfW9pD5IZ9GYxVOt8AHjhTiYRo=;
	b=MN7KrkR8JPEr9sKZgElmZnZ60H3NoPHj/4FwQYbNNHqieUfOuJ/JePkRDiv1CxOdcs6D55
	R04Bm7Yj22Ksi3DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C07BE1392A;
	Thu,  3 Apr 2025 20:22:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OYh/Lgbu7mcNPQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 03 Apr 2025 20:22:30 +0000
Date: Thu, 3 Apr 2025 22:22:29 +0200
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	=?utf-8?B?6KW/5pyo6YeO576w5Z+6?= <yanqiyu01@gmail.com>
Subject: Re: [PATCH] btrfs: zoned: return EIO on RAID1 block group write
 pointer mismatch
Message-ID: <20250403202229.GW32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <f6c1c74599f51626bd2b804705425f68e5544bfe.1742223756.git.jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6c1c74599f51626bd2b804705425f68e5544bfe.1742223756.git.jth@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: F3F0821171
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,wdc.com,toxicpanda.com,fb.com,suse.com,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Mon, Mar 17, 2025 at 04:04:01PM +0100, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> There was a bug report about a NULL pointer dereference in
> __btrfs_add_free_space_zoned() that ultimately happens because a
> conversion from the default metadata profile DUP to a RAID1 profile on two
> disks.
> 
> The stacktrace has the following signature:
> 
>    BTRFS error (device sdc): zoned: write pointer offset mismatch of zones in raid1 profile
>    BUG: kernel NULL pointer dereference, address: 0000000000000058
>    #PF: supervisor read access in kernel mode
>    #PF: error_code(0x0000) - not-present page
>    PGD 0 P4D 0
>    Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
>    RIP: 0010:__btrfs_add_free_space_zoned.isra.0+0x61/0x1a0
>    RSP: 0018:ffffa236b6f3f6d0 EFLAGS: 00010246
>    RAX: 0000000000000000 RBX: ffff96c8132f3400 RCX: 0000000000000001
>    RDX: 0000000010000000 RSI: 0000000000000000 RDI: ffff96c8132f3410
>    RBP: 0000000010000000 R08: 0000000000000003 R09: 0000000000000000
>    R10: 0000000000000000 R11: 00000000ffffffff R12: 0000000000000000
>    R13: ffff96c758f65a40 R14: 0000000000000001 R15: 000011aac0000000
>    FS: 00007fdab1cb2900(0000) GS:ffff96e60ca00000(0000) knlGS:0000000000000000
>    CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    CR2: 0000000000000058 CR3: 00000001a05ae000 CR4: 0000000000350ef0
>    Call Trace:
>    <TASK>
>    ? __die_body.cold+0x19/0x27
>    ? page_fault_oops+0x15c/0x2f0
>    ? exc_page_fault+0x7e/0x180
>    ? asm_exc_page_fault+0x26/0x30
>    ? __btrfs_add_free_space_zoned.isra.0+0x61/0x1a0
>    btrfs_add_free_space_async_trimmed+0x34/0x40
>    btrfs_add_new_free_space+0x107/0x120
>    btrfs_make_block_group+0x104/0x2b0
>    btrfs_create_chunk+0x977/0xf20
>    btrfs_chunk_alloc+0x174/0x510
>    ? srso_return_thunk+0x5/0x5f
>    btrfs_inc_block_group_ro+0x1b1/0x230
>    btrfs_relocate_block_group+0x9e/0x410
>    btrfs_relocate_chunk+0x3f/0x130
>    btrfs_balance+0x8ac/0x12b0
>    ? srso_return_thunk+0x5/0x5f
>    ? srso_return_thunk+0x5/0x5f
>    ? __kmalloc_cache_noprof+0x14c/0x3e0
>    btrfs_ioctl+0x2686/0x2a80
>    ? srso_return_thunk+0x5/0x5f
>    ? ioctl_has_perm.constprop.0.isra.0+0xd2/0x120
>    __x64_sys_ioctl+0x97/0xc0
>    do_syscall_64+0x82/0x160
>    ? srso_return_thunk+0x5/0x5f
>    ? __memcg_slab_free_hook+0x11a/0x170
>    ? srso_return_thunk+0x5/0x5f
>    ? kmem_cache_free+0x3f0/0x450
>    ? srso_return_thunk+0x5/0x5f
>    ? srso_return_thunk+0x5/0x5f
>    ? syscall_exit_to_user_mode+0x10/0x210
>    ? srso_return_thunk+0x5/0x5f
>    ? do_syscall_64+0x8e/0x160
>    ? sysfs_emit+0xaf/0xc0
>    ? srso_return_thunk+0x5/0x5f
>    ? srso_return_thunk+0x5/0x5f
>    ? seq_read_iter+0x207/0x460
>    ? srso_return_thunk+0x5/0x5f
>    ? vfs_read+0x29c/0x370
>    ? srso_return_thunk+0x5/0x5f
>    ? srso_return_thunk+0x5/0x5f
>    ? syscall_exit_to_user_mode+0x10/0x210
>    ? srso_return_thunk+0x5/0x5f
>    ? do_syscall_64+0x8e/0x160
>    ? srso_return_thunk+0x5/0x5f
>    ? exc_page_fault+0x7e/0x180
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
>    RIP: 0033:0x7fdab1e0ca6d
>    RSP: 002b:00007ffeb2b60c80 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>    RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fdab1e0ca6d
>    RDX: 00007ffeb2b60d80 RSI: 00000000c4009420 RDI: 0000000000000003
>    RBP: 00007ffeb2b60cd0 R08: 0000000000000000 R09: 0000000000000013
>    R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>    R13: 00007ffeb2b6343b R14: 00007ffeb2b60d80 R15: 0000000000000001
>    </TASK>
>    CR2: 0000000000000058
>    ---[ end trace 0000000000000000 ]---
> 
> The 1st line is the most interesting here:
> 
>  BTRFS error (device sdc): zoned: write pointer offset mismatch of zones in raid1 profile
> 
> When a RAID1 block-group is created and a write pointer mismatch between
> the disks in the RAID set is detected, btrfs sets the alloc_offset to the
> length of the block group marking it as full. Afterwards the code expects
> that a balance operation will evacuate the data in this block-group and
> repair the problems.
> 
> But before this is possible, the new space of this block-group will be
> accounted in the free space cache. But in __btrfs_add_free_space_zoned()
> it is being checked if it is a initial creation of a block group and if
> not a reclaim decision will be made. But the decision if a block-group's
> free space accounting is done for an initial creation depends on if the
> size of the added free space is the whole length of the block-group and
> the allocation offset is 0.
> 
> But as btrfs_load_block_group_zone_info() sets the allocation offset to
> the zone capacity (i.e. marking the block-group as full) this initial
> decision is not met, and the space_info pointer in the 'struct
> btrfs_block_group' has not yet been assigned.
> 
> Fail creation of the block group and rely on manual user intervention to
> re-balance the filesystem.
> 
> Afterwards the filesystem can be unmounted, mounted in degraded mode and
> the missing device can be removed after a full balance of the filesystem.
> 
> Fixes: b1934cd60695 ("btrfs: zoned: handle broken write pointer on zones")
> Link: https://lore.kernel.org/linux-btrfs/CAB_b4sBhDe3tscz=duVyhc9hNE+gu=B8CrgLO152uMyanR8BEA@mail.gmail.com/
> Reported-by: 西木野羰基 <yanqiyu01@gmail.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Please add it to for-next.

