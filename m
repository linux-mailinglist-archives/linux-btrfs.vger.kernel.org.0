Return-Path: <linux-btrfs+bounces-6887-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4767E9414D7
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 16:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF1C4281296
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 14:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720221A2548;
	Tue, 30 Jul 2024 14:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rYkn16wu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IqCY1chZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rYkn16wu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IqCY1chZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B54CCA6B;
	Tue, 30 Jul 2024 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722351135; cv=none; b=N9SQ/12EDGOC5EFOipOhYARfEyMHn/FhvjJYax3LsvLALA2QCj0w72S1JZZl19VDEwVY29uy3E9Kp0+s0wZ/jPxroCMt/7JS3qeC410oVPMnSZrdQFMg1dloCMLp1tBbLb8CWJWGGw4+DXcI/kXJ479VPlUOB+Oh/EB2loW42lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722351135; c=relaxed/simple;
	bh=pVhD9lHI+PMPziKDY6V86Kxk9fd2wQ8eYO86HxEpP6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hip3tfQPMPnbzkMr//6qcChYyUa/bfvETs1++JWdVTzME0cAf4od1m58vScYI0RUCayoQPluMeIb9VC0ntiNxwkE+Wvi18KlSFKYfNjcyhsMGEtgjwfBAGGCzpLLG81aNUHYow9eKueQYoxkl5GpLkrstnGNLlZX5Ljsqnlk3vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rYkn16wu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IqCY1chZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rYkn16wu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IqCY1chZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1FC2621AC7;
	Tue, 30 Jul 2024 14:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722351132;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9XWk+DjWVY6+tObiVQ98nVK9K9MnJJxHw485jli3bD4=;
	b=rYkn16wuhPlsk/15oET5W4Y4AN6wIqwr427aLJJy8lInZM0sQNFnOW20yMfcTslWyfJAr5
	VbXSCZnJ7WBavLE+fDB80YUDNdOaHWREAFC9gXPLQKEwaIeoBO8JPaonVj8rIgGST2yOyC
	NANozfLZS2UPy1UUJsvdHG0TfqGJ1Zk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722351132;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9XWk+DjWVY6+tObiVQ98nVK9K9MnJJxHw485jli3bD4=;
	b=IqCY1chZtmm2KcpJxb4NEhICg5k4KPXafP0J2iTfMpr4fjG53ykPSd5cqBStC9rw3inYig
	5jRaVzA2IqLdtOBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rYkn16wu;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IqCY1chZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722351132;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9XWk+DjWVY6+tObiVQ98nVK9K9MnJJxHw485jli3bD4=;
	b=rYkn16wuhPlsk/15oET5W4Y4AN6wIqwr427aLJJy8lInZM0sQNFnOW20yMfcTslWyfJAr5
	VbXSCZnJ7WBavLE+fDB80YUDNdOaHWREAFC9gXPLQKEwaIeoBO8JPaonVj8rIgGST2yOyC
	NANozfLZS2UPy1UUJsvdHG0TfqGJ1Zk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722351132;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9XWk+DjWVY6+tObiVQ98nVK9K9MnJJxHw485jli3bD4=;
	b=IqCY1chZtmm2KcpJxb4NEhICg5k4KPXafP0J2iTfMpr4fjG53ykPSd5cqBStC9rw3inYig
	5jRaVzA2IqLdtOBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04B1813297;
	Tue, 30 Jul 2024 14:52:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EiToABz+qGY1dAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 30 Jul 2024 14:52:12 +0000
Date: Tue, 30 Jul 2024 16:52:06 +0200
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+8cfa88c4efc731f03e7e@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] general protection fault in btrfs_simple_end_io
Message-ID: <20240730145206.GK17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <000000000000558cea061949a2d6@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000558cea061949a2d6@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=2b8d1faad9ceb620];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[8cfa88c4efc731f03e7e];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim,syzkaller.appspot.com:url];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -1.51
X-Rspamd-Queue-Id: 1FC2621AC7

On Sat, May 25, 2024 at 09:18:27AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    56fb6f92854f Merge tag 'drm-next-2024-05-25' of https://gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16bfdae8980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2b8d1faad9ceb620
> dashboard link: https://syzkaller.appspot.com/bug?extid=8cfa88c4efc731f03e7e
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.

> Oops: general protection fault, probably for non-canonical address 0xe01ffbf11002a963: 0000 [#1] PREEMPT SMP KASAN NOPTI
> KASAN: maybe wild-memory-access in range [0x00ffff8880154b18-0x00ffff8880154b1f]

Most likely this was a side effect of bug fixed by commit f3a5367c679d
("btrfs: protect folio::private when attaching extent buffer folios").
The timeframe corresponds with increased number of bogus errors caused by
use-after-free of a page.

The fix is best guess.

#syz fix: btrfs: protect folio::private when attaching extent buffer folios

