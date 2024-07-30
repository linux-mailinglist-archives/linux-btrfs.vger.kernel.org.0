Return-Path: <linux-btrfs+bounces-6876-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F19594137E
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 15:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B32111C234A3
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 13:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E16D1A08A6;
	Tue, 30 Jul 2024 13:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sUYGhLeC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CXByBGpU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hQFm1Qeo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="d5q4bom0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11181465A7
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2024 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722347253; cv=none; b=qWse7WbTa89X1CR85ELFRWhxpUIBKnA7i9eFcnbIJu5Tnpr204MXUdzkf3nrAVX8Es7r5ntFlvupXQMJRWvRUbfvFxdXmGJpftQCXO+YkHxapN0D+GtL7uLqiARNd88aHj9Q7ychdWhG/sCYQ+cqNaMw7EqrNsFHouocWYzXX/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722347253; c=relaxed/simple;
	bh=cFxXILOOru+LcY9xOYfSI/FD9P+oOsRCbKx77r7/+O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAESMUtuFrFWQIqaqrw0cPSpXV6XgMdXP2idEXmoFEUvJLyC0tj4G/CQ8WFng0FSQex36HKg5JOEyNSz6G6kDz5C/luj4lgNs89qMSO1T8hW+G93rlviSnz0XhH7B3GJEWPdraU9XZCGQHR7BBeJTZ46947vybDjImqirhv0u2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sUYGhLeC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CXByBGpU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hQFm1Qeo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=d5q4bom0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C490D1F7E2;
	Tue, 30 Jul 2024 13:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722347249;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W30TjIq9CtiDlue3Vyuvp47KtOgRj13n2UuFSzc4gSI=;
	b=sUYGhLeCCSAK1Cc8rNaVmP5meMHevgPx4fnEgbKDhoR1vWsRP5riX01WHBDUFOmxcwE2TR
	RRJCyOVdU/Yu7otNthTdMHDg/xvU5XFMIiwHtS9W2lFRHDqoQg1TYUqO82vgwSbpRyGsJt
	pUO60bbEIqGxHcKAF4Zn4Xr0scDCqNo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722347249;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W30TjIq9CtiDlue3Vyuvp47KtOgRj13n2UuFSzc4gSI=;
	b=CXByBGpU6HLpIcuKzTtvBhV/pFgDouHtMShCsoIVTGCOJgtvUkiWMd90+XpHca7fwH6Q6Y
	cCPzGrhldE4nz9Ag==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hQFm1Qeo;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=d5q4bom0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722347248;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W30TjIq9CtiDlue3Vyuvp47KtOgRj13n2UuFSzc4gSI=;
	b=hQFm1QeoKMeRRstmc8KexzIZF8gSiDU9dRhqP8B/F42vCwF400hMtrhHH/RkZmBoI+74/L
	lvLuMIZ21dSnd/my/zKLdO05ev6fDcIT6ol6DefkDPwn687J7azCIpA163+yZCOXWTBAN3
	NWcmxrZrsrVdjfNbu3Om9ANbOkiLS6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722347248;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W30TjIq9CtiDlue3Vyuvp47KtOgRj13n2UuFSzc4gSI=;
	b=d5q4bom0LxqPW75AvEjbi5BKCywe1nO3IOQKHtgcMFjKdOXN81Vx63cWeRV3Kt4mpUO9sx
	4dlvt9cwGYhcXuDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E74013983;
	Tue, 30 Jul 2024 13:47:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lPlvJvDuqGZqYAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 30 Jul 2024 13:47:28 +0000
Date: Tue, 30 Jul 2024 15:47:27 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH] btrfs: make cow_file_range_inline honor locked_page on
 error
Message-ID: <20240730134727.GB17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <4830592782d102b8f15cb753824caee669e5d8a9.1721774105.git.boris@bur.io>
 <c62d48f9-55d2-4f4a-af7e-31ad08dbdd29@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c62d48f9-55d2-4f4a-af7e-31ad08dbdd29@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.01 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	FREEMAIL_TO(0.00)[gmx.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -1.01
X-Rspamd-Queue-Id: C490D1F7E2

On Wed, Jul 24, 2024 at 08:35:02AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/7/24 08:05, Boris Burkov 写道:
> > The btrfs buffered write path runs through __extent_writepage which has
> > some tricky return value handling for writepage_delalloc. Specifically,
> > when that returns 1, we exit, but for other return values we continue
> > and end up calling btrfs_folio_end_all_writers. If the folio has been
> > unlocked (note that we check the PageLocked bit at the start of
> > __extent_writepage), this results in an assert panic like this one from
> > syzbot:
> >
> > BTRFS: error (device loop0 state EAL) in free_log_tree:3267: errno=-5 IO
> > failure
> > BTRFS warning (device loop0 state EAL): Skipping commit of aborted
> > transaction.
> > BTRFS: error (device loop0 state EAL) in cleanup_transaction:2018:
> > errno=-5 IO failure
> > assertion failed: folio_test_locked(folio), in fs/btrfs/subpage.c:871
> > ------------[ cut here ]------------
> > kernel BUG at fs/btrfs/subpage.c:871!
> > Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> > CPU: 1 PID: 5090 Comm: syz-executor225 Not tainted
> > 6.10.0-syzkaller-05505-gb1bc554e009e #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > Google 06/27/2024
> > RIP: 0010:btrfs_folio_end_all_writers+0x55b/0x610 fs/btrfs/subpage.c:871
> > Code: e9 d3 fb ff ff e8 25 22 c2 fd 48 c7 c7 c0 3c 0e 8c 48 c7 c6 80 3d
> > 0e 8c 48 c7 c2 60 3c 0e 8c b9 67 03 00 00 e8 66 47 ad 07 90 <0f> 0b e8
> > 6e 45 b0 07 4c 89 ff be 08 00 00 00 e8 21 12 25 fe 4c 89
> > RSP: 0018:ffffc900033d72e0 EFLAGS: 00010246
> > RAX: 0000000000000045 RBX: 00fff0000000402c RCX: 663b7a08c50a0a00
> > RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
> > RBP: ffffc900033d73b0 R08: ffffffff8176b98c R09: 1ffff9200067adfc
> > R10: dffffc0000000000 R11: fffff5200067adfd R12: 0000000000000001
> > R13: dffffc0000000000 R14: 0000000000000000 R15: ffffea0001cbee80
> > FS:  0000000000000000(0000) GS:ffff8880b9500000(0000)
> > knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f5f076012f8 CR3: 000000000e134000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> > <TASK>
> > __extent_writepage fs/btrfs/extent_io.c:1597 [inline]
> > extent_write_cache_pages fs/btrfs/extent_io.c:2251 [inline]
> > btrfs_writepages+0x14d7/0x2760 fs/btrfs/extent_io.c:2373
> > do_writepages+0x359/0x870 mm/page-writeback.c:2656
> > filemap_fdatawrite_wbc+0x125/0x180 mm/filemap.c:397
> > __filemap_fdatawrite_range mm/filemap.c:430 [inline]
> > __filemap_fdatawrite mm/filemap.c:436 [inline]
> > filemap_flush+0xdf/0x130 mm/filemap.c:463
> > btrfs_release_file+0x117/0x130 fs/btrfs/file.c:1547
> > __fput+0x24a/0x8a0 fs/file_table.c:422
> > task_work_run+0x24f/0x310 kernel/task_work.c:222
> > exit_task_work include/linux/task_work.h:40 [inline]
> > do_exit+0xa2f/0x27f0 kernel/exit.c:877
> > do_group_exit+0x207/0x2c0 kernel/exit.c:1026
> > __do_sys_exit_group kernel/exit.c:1037 [inline]
> > __se_sys_exit_group kernel/exit.c:1035 [inline]
> > __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1035
> > x64_sys_call+0x2634/0x2640
> > arch/x86/include/generated/asm/syscalls_64.h:232
> > do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> > entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f5f075b70c9
> > Code: Unable to access opcode bytes at
> > 0x7f5f075b709f.
> > RSP: 002b:00007ffd1c3f9a58 EFLAGS: 00000246
> > ORIG_RAX: 00000000000000e7
> > RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
> > 00007f5f075b70c9
> > RDX: 000000000000003c RSI: 00000000000000e7 RDI:
> > 0000000000000000
> > RBP: 00007f5f07638390 R08: ffffffffffffffb8 R09:
> > 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12:
> > 00007f5f07638390
> > R13: 0000000000000000 R14: 00007f5f07639100 R15:
> > 00007f5f07585050
> > </TASK>
> > Modules linked in:
> > ---[ end trace 0000000000000000 ]---
> >
> > I was hitting the same issue by doing hundreds of accelerated runs of
> > generic/475, which also hits IO errors by design.
> >
> > I instrumented that reproducer with bpftrace and found that the
> > undesirable folio_unlock was coming from the following callstack:
> >
> > folio_unlock+5
> > __process_pages_contig+475
> > cow_file_range_inline.constprop.0+230
> > cow_file_range+803
> > btrfs_run_delalloc_range+566
> > writepage_delalloc+332
> > __extent_writepage # inlined in my stacktrace, but I added it here
> > extent_write_cache_pages+622
> >
> > Looking at the bisected-to patch in the syzbot report, Josef realized
> > that the logic of the cow_file_range_inline error path subtly changing.
> > In the past, on error, it jumped to out_unlock in cow_file_range, which
> > honors the locked_page, so when we ultimately call
> > folio_end_all_writers, the folio of interest is still locked. After the
> > change, we always unlocked ignoring the locked_page, on both success and
> > error. On the success path, this all results in returning 1 to
> > __extent_writepage, which skips the folio_end_all_writers call, which
> > makes it OK to have unlocked.
> >
> > Fix the bug by wiring the locked_page into cow_file_range_inline and
> > only setting locked_page to NULL on success.
> >
> > Reported-by: syzbot+a14d8ac9af3a2a4fd0c8@syzkaller.appspotmail.com
> > Fixes: 0586d0a89e77 ("btrfs: move extent bit and page cleanup into cow_file_range_inline")
> > Signed-off-by: Boris Burkov <boris@bur.io>
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> > ---
> >   fs/btrfs/inode.c | 16 ++++++++++------
> >   1 file changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 8f38eefc8acd..8ca3878348ff 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -714,8 +714,9 @@ static noinline int __cow_file_range_inline(struct btrfs_inode *inode, u64 offse
> >   	return ret;
> >   }
> >
> > -static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 offset,
> > -					  u64 end,
> > +static noinline int cow_file_range_inline(struct btrfs_inode *inode,
> > +					  struct page *locked_page,
> > +					  u64 offset, u64 end,
> >   					  size_t compressed_size,
> >   					  int compress_type,
> >   					  struct folio *compressed_folio,
> > @@ -739,7 +740,10 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 offset,
> >   		return ret;
> >   	}
> >
> > -	extent_clear_unlock_delalloc(inode, offset, end, NULL, &cached,
> 
> Better adding one comment explaining that the locked page will be
> unlocked by the caller on error.

Agreed, the patch is in for-next but I don't see any comment added.

