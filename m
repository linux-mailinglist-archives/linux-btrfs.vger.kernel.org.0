Return-Path: <linux-btrfs+bounces-5046-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B548C7974
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 17:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EF2E28B2DB
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 May 2024 15:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B8614E2D7;
	Thu, 16 May 2024 15:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WSpuOrNp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b7mnujaO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WSpuOrNp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="b7mnujaO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6751414D708;
	Thu, 16 May 2024 15:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715873285; cv=none; b=WTrRdIL6pRm/9bcuSWnLoMcNoNxJTIfqB1Zzzgc77FK5rh71R1Z3nxKdp8z//KQ03F7vF0YRMlZ+USRml5KsWwcYe01usP3LLXwQWzo3eaVdZ9sr/IndyVtoLOWZU+oJaAYhRZRW9A1p37nngvaelO+tK9fAHMYdMyDyLHUNs5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715873285; c=relaxed/simple;
	bh=AmOTYXH8GdqujH3HrTd6mrl/hYKJ4jq8NRd8KsPzjLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0VkjeQSfpxmjH792gYBbNzwWpD7XuGT1sZIy1hb7wpsu89UgPNGnn/spGy2jjVwnoaDwm4z5tHwLzynnNw2c3Arn1c2A1Izxv7/TQ23DB037T/8xcH/43wn0/gnu6BUy8X2RiTyCw/OAAY+f+UEQqP7PdLneg0AAx39wGUpQ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WSpuOrNp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b7mnujaO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WSpuOrNp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=b7mnujaO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4FD0A34B65;
	Thu, 16 May 2024 15:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715873281;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v4gybi6HKECFJhxHO1fxxxa9tuCaWVox9JYYEGyzVGY=;
	b=WSpuOrNpxAL3SMGegO7rJw38EC6fbBLtSpgnNgQU01fKZNDxi4NA1KRwq978kqCxALf82D
	97flXmceO+sInMOcvwXNSo566rYcb1e2LMpimkbHh9aeDeD/UcXsCAWhspW1Rz7fIjUXxa
	y39zzW0WSkNKIcFxVasHu3qisq2GnO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715873281;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v4gybi6HKECFJhxHO1fxxxa9tuCaWVox9JYYEGyzVGY=;
	b=b7mnujaOJcSUnXsNHbR+ZCIMxm4wq7NAaC8CDa/SHujbLB/32viBk1iU02mV4UlHF+x66x
	eVVfIzFmsgMSZ7Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715873281;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v4gybi6HKECFJhxHO1fxxxa9tuCaWVox9JYYEGyzVGY=;
	b=WSpuOrNpxAL3SMGegO7rJw38EC6fbBLtSpgnNgQU01fKZNDxi4NA1KRwq978kqCxALf82D
	97flXmceO+sInMOcvwXNSo566rYcb1e2LMpimkbHh9aeDeD/UcXsCAWhspW1Rz7fIjUXxa
	y39zzW0WSkNKIcFxVasHu3qisq2GnO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715873281;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v4gybi6HKECFJhxHO1fxxxa9tuCaWVox9JYYEGyzVGY=;
	b=b7mnujaOJcSUnXsNHbR+ZCIMxm4wq7NAaC8CDa/SHujbLB/32viBk1iU02mV4UlHF+x66x
	eVVfIzFmsgMSZ7Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 277EC13991;
	Thu, 16 May 2024 15:28:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2snzCAEmRmblOAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 16 May 2024 15:28:01 +0000
Date: Thu, 16 May 2024 17:27:55 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: syzbot <syzbot+d6f9ff86c1d804ba2bc6@syzkaller.appspotmail.com>,
	clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in lookup_inline_extent_backref
Message-ID: <20240516152755.GC4449@suse.cz>
Reply-To: dsterba@suse.cz
References: <0000000000003d4a1a05ef104401@google.com>
 <2de85e6f-b1ad-69ae-1e60-cd47c91115a9@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2de85e6f-b1ad-69ae-1e60-cd47c91115a9@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-1.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[d6f9ff86c1d804ba2bc6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]
X-Spam-Score: -1.50
X-Spam-Flag: NO

On Mon, Jul 31, 2023 at 01:55:56PM +0800, Qu Wenruo wrote:
> On 2022/12/5 16:13, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    a4412fdd49dc error-injection: Add prompt for function erro..
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=1469bdbd880000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
> > dashboard link: https://syzkaller.appspot.com/bug?extid=d6f9ff86c1d804ba2bc6
> > compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d89247880000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b1ca83880000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/3bbe66b25958/disk-a4412fdd.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/6851483ca667/vmlinux-a4412fdd.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/2d5b23cb4616/bzImage-a4412fdd.xz
> > mounted in repro: https://storage.googleapis.com/syzbot-assets/1f178223dd56/mount_0.gz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+d6f9ff86c1d804ba2bc6@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 6559 at fs/btrfs/extent-tree.c:865 lookup_inline_extent_backref+0x8c1/0x13f0
> > Modules linked in:
> > CPU: 0 PID: 6559 Comm: syz-executor311 Not tainted 6.1.0-rc7-syzkaller-00123-ga4412fdd49dc #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
> > RIP: 0010:lookup_inline_extent_backref+0x8c1/0x13f0 fs/btrfs/extent-tree.c:865
> > Code: 98 00 00 00 0f 87 42 0b 00 00 e8 5a 9c 07 fe 4c 8b 6c 24 28 eb 3d 83 7d 28 00 4c 8b 6c 24 28 0f 84 b0 04 00 00 e8 3f 9c 07 fe <0f> 0b 41 bc fb ff ff ff e9 f3 05 00 00 e8 2d 9c 07 fe e9 ca 05 00
> > RSP: 0018:ffffc90006296e40 EFLAGS: 00010293
> > RAX: ffffffff8382fbb1 RBX: 0000000000000000 RCX: ffff88801eab1d40
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > RBP: ffffc90006296ff0 R08: ffffffff8382f700 R09: ffffed100faf1008
> > R10: ffffed100faf1008 R11: 1ffff1100faf1007 R12: dffffc0000000000
> > R13: ffff888075edcd10 R14: ffffc90006296f60 R15: ffff88807d788000
> > FS:  00007fdb617d5700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 000055912e028900 CR3: 000000001954b000 CR4: 00000000003506e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >   <TASK>
> >   insert_inline_extent_backref+0xcc/0x260 fs/btrfs/extent-tree.c:1152
> >   __btrfs_inc_extent_ref+0x108/0x5e0 fs/btrfs/extent-tree.c:1455
> >   btrfs_run_delayed_refs_for_head+0xf00/0x1df0 fs/btrfs/extent-tree.c:1943
> >   __btrfs_run_delayed_refs+0x25f/0x490 fs/btrfs/extent-tree.c:2008
> >   btrfs_run_delayed_refs+0x312/0x490 fs/btrfs/extent-tree.c:2139
> >   qgroup_account_snapshot+0xce/0x340 fs/btrfs/transaction.c:1538
> >   create_pending_snapshot+0xf35/0x2560 fs/btrfs/transaction.c:1800
> >   create_pending_snapshots+0x1a8/0x1e0 fs/btrfs/transaction.c:1868
> >   btrfs_commit_transaction+0x13f0/0x3760 fs/btrfs/transaction.c:2323
> >   create_snapshot+0x4aa/0x7e0 fs/btrfs/ioctl.c:833
> >   btrfs_mksubvol+0x62e/0x760 fs/btrfs/ioctl.c:983
> >   btrfs_mksnapshot+0xb5/0xf0 fs/btrfs/ioctl.c:1029
> >   __btrfs_ioctl_snap_create+0x339/0x450 fs/btrfs/ioctl.c:2184
> >   btrfs_ioctl_snap_create+0x134/0x190 fs/btrfs/ioctl.c:2211
> >   btrfs_ioctl+0x15c/0xc10
> >   vfs_ioctl fs/ioctl.c:51 [inline]
> >   __do_sys_ioctl fs/ioctl.c:870 [inline]
> >   __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
> >   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> >   do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
> >   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > RIP: 0033:0x7fdb6184aa69
> > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007fdb617d52f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 00007fdb618d57f0 RCX: 00007fdb6184aa69
> > RDX: 00000000200000c0 RSI: 0000000050009401 RDI: 0000000000000004
> > RBP: 00007fdb618a226c R08: 00007fdb617d5700 R09: 0000000000000000
> > R10: 00007fdb617d5700 R11: 0000000000000246 R12: 8000000000000000
> > R13: 00007fdb618a1270 R14: 0000000100000000 R15: 00007fdb618d57f8
> >   </TASK>
> 
> # syz test: git://github.com/adam900710/linux.git inline_lookup_debug

There's one new repor from syzbot from 01/2024, the patch 7f72f50547b7af
("btrfs: output extra debug info if we failed to find an inline
backref") is there and adds some debugging. However, due to ordering of

WARN_ON, print_leaf, error message

the machine reboots at the end of WARN_ON, so there's no useful
debugging in the logs. I don't see a syzbot reproducer but you could ask
it to do a test with updated debugging patch or eventually send an
update to the one we have in tree.

