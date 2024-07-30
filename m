Return-Path: <linux-btrfs+bounces-6890-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5EE94152B
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 17:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FC541F247BC
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 15:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3817D1A2C1E;
	Tue, 30 Jul 2024 15:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rn4a+YM3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jtNOBqSf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rn4a+YM3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jtNOBqSf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B041A2540;
	Tue, 30 Jul 2024 15:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722352304; cv=none; b=hxxlhSYRCRzZ2NN96n6axiL83SWfOUJYW8K+N4qgT67fZ1281dTNPiLf0immoQZ5YXaBikm4kTLiBn3Xs6gPs1mrwea0D8G7VVRsW7v5i/uYkPWQKW1GnQ0/OS85FiEpw/Jtx1gQThNWu1w6fg0gHiUYJcpAxTQYCIAlyJ1jcg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722352304; c=relaxed/simple;
	bh=beL0yRdbjCogihbzdODxmTHRoDZSyhbgaIw1k7n5/AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDg3TRA4J4g8KPy+2AkCl4ui1HIlfk5/BfEXvHfc/ZtbCCHXs0cG+LkiwGtILuYjCsL1Bk1y6gnlVEqwMOpVeUgcI5Pf3Denhvrf6Pwu2xk2IUnj0+8QfWdlNJrVqpB+ARHHpFOTj4Xcnvo2/aOcXP1vAhLfyt1Uv/ojLGEIkK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rn4a+YM3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jtNOBqSf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rn4a+YM3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jtNOBqSf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9CCB721B70;
	Tue, 30 Jul 2024 15:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722352300;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x7kxMJXM9K4LjqCKWji6D34DkXKqKBCVhdQE5CYexK8=;
	b=Rn4a+YM3gjkZNfH2KlXm0Vwnxo64lwMDDjaPIMfPPxGL6hLwxE83s4krZZAnainpVzpC5C
	lxVEHFBmGyxzgxEH8UjqIqGwhIt19/HQieQ4rNGvHs7bl2g9W18uWBovIhrjP7aYLyTJ8o
	vJICo+h/btwnPyIicKKngzhB60nUhA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722352300;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x7kxMJXM9K4LjqCKWji6D34DkXKqKBCVhdQE5CYexK8=;
	b=jtNOBqSf/ytfCMVP1pC3nALOp7aWXVTOunQqxSVXOXKd1587HXBMgCbba5y+OM71ALmdbp
	PKAiG7Zz7q+Zz1BA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Rn4a+YM3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jtNOBqSf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722352300;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x7kxMJXM9K4LjqCKWji6D34DkXKqKBCVhdQE5CYexK8=;
	b=Rn4a+YM3gjkZNfH2KlXm0Vwnxo64lwMDDjaPIMfPPxGL6hLwxE83s4krZZAnainpVzpC5C
	lxVEHFBmGyxzgxEH8UjqIqGwhIt19/HQieQ4rNGvHs7bl2g9W18uWBovIhrjP7aYLyTJ8o
	vJICo+h/btwnPyIicKKngzhB60nUhA0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722352300;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x7kxMJXM9K4LjqCKWji6D34DkXKqKBCVhdQE5CYexK8=;
	b=jtNOBqSf/ytfCMVP1pC3nALOp7aWXVTOunQqxSVXOXKd1587HXBMgCbba5y+OM71ALmdbp
	PKAiG7Zz7q+Zz1BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6DEDC13983;
	Tue, 30 Jul 2024 15:11:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0xqZGqwCqWYcegAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 30 Jul 2024 15:11:40 +0000
Date: Tue, 30 Jul 2024 17:11:39 +0200
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+9bf5c83263a4d4387899@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] BUG: spinlock bad magic in
 btrfs_stop_all_workers
Message-ID: <20240730151139.GN17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <00000000000077990d061b30f83c@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000077990d061b30f83c@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.49 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=81c0d76ceef02b39];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[9bf5c83263a4d4387899];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spamd-Bar: +
X-Rspamd-Queue-Id: 9CCB721B70
X-Spam-Level: *
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: 1.49

On Tue, Jun 18, 2024 at 02:43:21PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    2ccbdf43d5e7 Merge tag 'for-linus' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10bf1a61980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=81c0d76ceef02b39
> dashboard link: https://syzkaller.appspot.com/bug?extid=9bf5c83263a4d4387899
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-2ccbdf43.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/13cdb5bfbafa/vmlinux-2ccbdf43.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7a14f5d07f81/bzImage-2ccbdf43.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9bf5c83263a4d4387899@syzkaller.appspotmail.com
> 
> BTRFS info (device loop3): last unmount of filesystem 3a492a15-ac49-4ce6-945e-cef7a687c6c9
> BUG: spinlock bad magic on CPU#0, syz-executor.3/7928
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in task_pid_nr include/linux/pid.h:232 [inline]
> BUG: KASAN: slab-out-of-bounds in spin_dump kernel/locking/spinlock_debug.c:64 [inline]
> BUG: KASAN: slab-out-of-bounds in spin_bug+0x17d/0x1d0 kernel/locking/spinlock_debug.c:78
> Read of size 4 at addr ffff888028b23dd8 by task syz-executor.3/7928

Most likely this was a side effect of bug fixed by commit f3a5367c679d
("btrfs: protect folio::private when attaching extent buffer folios").
The timeframe corresponds with increased number of bogus errors caused by
use-after-free of a page.

The fix is best guess.

#syz fix: btrfs: protect folio::private when attaching extent buffer folios

