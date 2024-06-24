Return-Path: <linux-btrfs+bounces-5938-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C9F9154F9
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 19:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77608285C8C
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2024 17:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3D219EEB6;
	Mon, 24 Jun 2024 17:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fbsSxh2w";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/W0RwIvi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fbsSxh2w";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/W0RwIvi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D100F13E024
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2024 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719248596; cv=none; b=elrYrA78sOG0eNQ9qr8rsln06ProggXR2f4GhiUYq5CYa6dWgt3qu28Anez3d2o8P1/3GeB+4/p/ZzU4NVi9dDX1X9Im80fr/lwjrbPSyk1Fr393WwhA0wCXOsYHmw6NkF9Rk3zCfo8GPO0fSzFc6ldVskDaulX4cPOgwX0HXBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719248596; c=relaxed/simple;
	bh=dPwM8SwnKjHAg+3sORa1JssRzkOxEjR/RO5ciBusOq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCOUY+iY2i+x0l0nJpeBYiKLoGD2XqdiujLU2tAkm6yiBTw2XFiZqCL9Gg8yWJmtKAdz5E/4QWxhxGr1uzAQmn6tzcobyAmNAqlXAKr8d9vDdRVXn6Hpa2+VMR0jCL8DZZhvmExGfbGVyoxcryhNXCsRIyT7201jhNtANSLXhAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fbsSxh2w; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/W0RwIvi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fbsSxh2w; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/W0RwIvi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0253D1F7A4;
	Mon, 24 Jun 2024 17:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719248593;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PP810uWZ7383bfBBSmVVM2zmvAj09cNlhFYR5J8vEEU=;
	b=fbsSxh2wLCrwidHiVm0g3BTxELXFNBtKnQFIH4umo3cMrNBbfRjiEriE6ZFx14afZrZb6c
	9lpYeKR/mCfHxPLFEzSNOKOthvQCNiWb/hxaD0qoTp0OvUmDxd6Z3Wk0ktqAQ+RBVVDIQL
	O1tbASBgs5aqnls6cUsG6duWgjnl3iA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719248593;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PP810uWZ7383bfBBSmVVM2zmvAj09cNlhFYR5J8vEEU=;
	b=/W0RwIvikLedQhMTdxr0Gfqxv1LUeMZUIaFYxAujhjoj+uW15CRoaMAWN8TC9GQh+qVQTL
	koFo6NCFmTsmSFBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719248593;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PP810uWZ7383bfBBSmVVM2zmvAj09cNlhFYR5J8vEEU=;
	b=fbsSxh2wLCrwidHiVm0g3BTxELXFNBtKnQFIH4umo3cMrNBbfRjiEriE6ZFx14afZrZb6c
	9lpYeKR/mCfHxPLFEzSNOKOthvQCNiWb/hxaD0qoTp0OvUmDxd6Z3Wk0ktqAQ+RBVVDIQL
	O1tbASBgs5aqnls6cUsG6duWgjnl3iA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719248593;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PP810uWZ7383bfBBSmVVM2zmvAj09cNlhFYR5J8vEEU=;
	b=/W0RwIvikLedQhMTdxr0Gfqxv1LUeMZUIaFYxAujhjoj+uW15CRoaMAWN8TC9GQh+qVQTL
	koFo6NCFmTsmSFBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC06F13AA4;
	Mon, 24 Jun 2024 17:03:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 72kXMdCmeWZMOQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 24 Jun 2024 17:03:12 +0000
Date: Mon, 24 Jun 2024 19:03:11 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	syzbot+a0d1f7e26910be4dc171@syzkaller.appspotmail.com
Subject: Re: [PATCH] btrfs: always do the basic checks for
 btrfs_qgroup_inherit structure
Message-ID: <20240624170311.GR25756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <47d3dd33f637b70f230fa31f98dbf9ff066b58bb.1719207446.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47d3dd33f637b70f230fa31f98dbf9ff066b58bb.1719207446.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[a0d1f7e26910be4dc171];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,appspotmail.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3]

On Mon, Jun 24, 2024 at 03:10:53PM +0930, Qu Wenruo wrote:
> [BUG]
> Syzbot reports the following regression detected by KASAN:
> 
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in btrfs_qgroup_inherit+0x42e/0x2e20 fs/btrfs/qgroup.c:3277
> Read of size 8 at addr ffff88814628ca50 by task syz-executor318/5171
> 
> CPU: 0 PID: 5171 Comm: syz-executor318 Not tainted 6.10.0-rc2-syzkaller-00010-g2ab795141095 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:488
>  kasan_report+0x143/0x180 mm/kasan/report.c:601
>  btrfs_qgroup_inherit+0x42e/0x2e20 fs/btrfs/qgroup.c:3277
>  create_pending_snapshot+0x1359/0x29b0 fs/btrfs/transaction.c:1854
>  create_pending_snapshots+0x195/0x1d0 fs/btrfs/transaction.c:1922
>  btrfs_commit_transaction+0xf20/0x3740 fs/btrfs/transaction.c:2382
>  create_snapshot+0x6a1/0x9e0 fs/btrfs/ioctl.c:875
>  btrfs_mksubvol+0x58f/0x710 fs/btrfs/ioctl.c:1029
>  btrfs_mksnapshot+0xb5/0xf0 fs/btrfs/ioctl.c:1075
>  __btrfs_ioctl_snap_create+0x387/0x4b0 fs/btrfs/ioctl.c:1340
>  btrfs_ioctl_snap_create_v2+0x1f2/0x3a0 fs/btrfs/ioctl.c:1422
>  btrfs_ioctl+0x99e/0xc60
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:907 [inline]
>  __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fcbf1992509
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fcbf1928218 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007fcbf1a1f618 RCX: 00007fcbf1992509
> RDX: 0000000020000280 RSI: 0000000050009417 RDI: 0000000000000003
> RBP: 00007fcbf1a1f610 R08: 00007ffea1298e97 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fcbf19eb660
> R13: 00000000200002b8 R14: 00007fcbf19e60c0 R15: 0030656c69662f2e
>  </TASK>
> 
> And it also pinned it down to this commit:
> 
> commit b5357cb268c41b4e2b7383d2759fc562f5b58c33
> Author: Qu Wenruo <wqu@suse.com>
> Date:   Sat Apr 20 07:50:27 2024 +0000
> 
>     btrfs: qgroup: do not check qgroup inherit if qgroup is disabled

For commit reference please use the COMMIT ("subject") without the mail
headers.

> 
> [CAUSE]
> That offending commit skips the whole qgroup inherit check if qgroup is
> not enabled.
> 
> But that also skips the very basic checks like
> num_ref_copies/num_excl_copies and the structure size checks.
> 
> Meaning if a qgroup enable/disable race is happening at the background,
> and we pass a btrfs_qgroup_inherit structure when the qgroup is
> disabled, the check would be completely skipped.
> 
> Then at the time of transaction commitment, qgroup is re-enabled and
> btrfs_qgroup_inherit() is going to use the incorrect structure and
> causing the above KASAN error.
> 
> [FIX]
> Make btrfs_qgroup_check_inherit() only skip the source qgroup checks.
> So that even if invalid btrfs_qgroup_inherit structure is passed in, we
> can still reject invalid ones no matter if qgroup is enabled or not.
> 
> Furthermore we do already have an extra safenet inside
> btrfs_qgroup_inherit(), which would just ignore invalid qgroup sources,
> so even if we only skip the qgroup source check we're still safe.
> 
> Reported-by: syzbot+a0d1f7e26910be4dc171@syzkaller.appspotmail.com
> Fixes: b5357cb268c4 ("btrfs: qgroup: do not check qgroup inherit if qgroup is disabled")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

