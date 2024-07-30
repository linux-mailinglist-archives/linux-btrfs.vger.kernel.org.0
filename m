Return-Path: <linux-btrfs+bounces-6888-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C883C9414DA
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 16:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8AF51C23012
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 14:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81B21A2548;
	Tue, 30 Jul 2024 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="k4nikfp7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EoHZh95N";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="No34d1P/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bHm5F9Yb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B43522F;
	Tue, 30 Jul 2024 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722351275; cv=none; b=CJaRkELKw6kDRgagv0PgJDw++lbHyBbAv11HongJi+uhXEyrbdfacfxqQGNJ32+0J8lzUYFWTlSc2Lo3O9831fWunpYAurwBy9+7AYtpMV19/8YghsmZx7TWzOBgGoE311dq2zMpknO8/X4GM363Mw4H3V+rFoxUYg84tMs43IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722351275; c=relaxed/simple;
	bh=eoBz7DZXyGnakFnT9s80tl6gZOZ7j45QZlDaKSDg+Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXvLNSBS88fEvcwE7lVhyOebrOvrjDf5CEXjF3Bvqb1alYumHcSvds5+r3zVoGjqmPiOJcPpnMNxJG+TNymW90stzfPDv6qU3JtiJPjyZa1BsJfta+Hvd94oK/4bmELLtF3i/quFOt0/a4JaaxANPED6skcxoj4nS78VrJj5jI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=k4nikfp7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EoHZh95N; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=No34d1P/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bHm5F9Yb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4AD6021B37;
	Tue, 30 Jul 2024 14:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722351272;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t5+nDvUmATTyO1yOKHtzCdpzQMbc17d7hC+xU2dcTbs=;
	b=k4nikfp77iQM4hpJMCohxjkc/4SvOYBZYsYZScL8KgG6R8qfNZ8u0wD96gzMqsU96gVHqe
	pTVVewy5XjPdJoj0OOMtIL17DpSWc8R1zDW1An7aNI7RxoOoclT/uGV86J3aHTu07v8Bqn
	EN9YHf70/1J0PT3gg+HWJwGvGAO5eso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722351272;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t5+nDvUmATTyO1yOKHtzCdpzQMbc17d7hC+xU2dcTbs=;
	b=EoHZh95NGAc25JK3GlxdjgsPT2eA840/kX8c9OIeFJoNmzxENH9Qvrvcw/weWudCOvVOTZ
	V8Z6YrT+eonMPcBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="No34d1P/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bHm5F9Yb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722351271;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t5+nDvUmATTyO1yOKHtzCdpzQMbc17d7hC+xU2dcTbs=;
	b=No34d1P/GCSPE3baETZQwNLGZq5hs7jwddjvZoffUGj60hU7lx5scH9u+pGNhsi0sUmSDS
	/cYVswFXzwP9qXiuPxR7dA1S7VkzogWtu5KLH+ceyWyQZz5AM3u0XltOQT2Hnvn4LdefpP
	Hw0btBA19O9EIgzu4u8hHzV8TqlfYJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722351271;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t5+nDvUmATTyO1yOKHtzCdpzQMbc17d7hC+xU2dcTbs=;
	b=bHm5F9YbWFAekKwXCaB9BzGW+eDA4MnniW3pTUvaNo2VJUnKYHE86u5qv6sna9zQiILm2k
	nTYYeK60osdQibDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3236A13297;
	Tue, 30 Jul 2024 14:54:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8K69C6f+qGbhdAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 30 Jul 2024 14:54:31 +0000
Date: Tue, 30 Jul 2024 16:54:25 +0200
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+bce6ef1d850c98d6d157@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] general protection fault in put_pwq_unlocked
Message-ID: <20240730145425.GL17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0000000000009a4d470618f599f2@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000009a4d470618f599f2@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.49 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=6be91306a8917025];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[bce6ef1d850c98d6d157];
	DKIM_TRACE(0.00)[suse.cz:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,syzkaller.appspot.com:url,appspotmail.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spamd-Bar: +
X-Rspamd-Queue-Id: 4AD6021B37
X-Spam-Level: *
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: 1.49

On Tue, May 21, 2024 at 05:03:03AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8f6a15f095a6 Merge tag 'cocci-for-6.10' of git://git.kerne..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1736b784980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6be91306a8917025
> dashboard link: https://syzkaller.appspot.com/bug?extid=bce6ef1d850c98d6d157
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f30c87f89d17/disk-8f6a15f0.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3d73f0e35e13/vmlinux-8f6a15f0.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/3d524f6fb25b/bzImage-8f6a15f0.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+bce6ef1d850c98d6d157@syzkaller.appspotmail.com
> 
> BTRFS info (device loop3): last unmount of filesystem c9fe44da-de57-406a-8241-57ec7d4412cf
> Oops: general protection fault, probably for non-canonical address 0xe01ffbf11002a143: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: maybe wild-memory-access in range [0x00ffff8880150a18-0x00ffff8880150a1f]

Most likely this was a side effect of bug fixed by commit f3a5367c679d
("btrfs: protect folio::private when attaching extent buffer folios").
The timeframe corresponds with increased number of bogus errors caused by
use-after-free of a page.

The fix is best guess.

#syz fix: btrfs: protect folio::private when attaching extent buffer folios

