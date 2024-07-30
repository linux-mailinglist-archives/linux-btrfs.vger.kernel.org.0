Return-Path: <linux-btrfs+bounces-6889-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B72B9414E4
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 16:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FCFD1C22E4C
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 14:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F7C1A2C16;
	Tue, 30 Jul 2024 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mkYn7Zkj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cOPZoCnN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mkYn7Zkj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cOPZoCnN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27C61A0B00;
	Tue, 30 Jul 2024 14:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722351336; cv=none; b=u9KaAy8D1A5I4NVfV5EZT7mOpGzWWSmUlI6OfWjkwxx8FHWwP8enB0UaJIFeh6uzt3jfGbYlKAVzQE8X4KDLPraGjQ0XHYekIJXBk7HZXSmpCIBhn/6DLDiCqiEq0UMJ/nXEPeUtumXP0B9+8otf1N5iEd6BG63W9aDwBRMZ9Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722351336; c=relaxed/simple;
	bh=Rj118SMS7mHyC9fTXygo6X4w1TOan3CniNMvys/OtQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SnlAj/dR/Fa0xaefnJDIsADvnclyqS0kghAhivs1s9XeM0p+qv5iK2x9aC02OgFXLPEBHja/NROmJxDbKrSyNW1BIi8iN3lZ8ffnR0ZTZWUSC1pqA53CWakY6Fhm6AqlKRePT+XTqGE776HlWOKUmBqHqYc/QgSqT2dN6zZASrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mkYn7Zkj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cOPZoCnN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mkYn7Zkj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cOPZoCnN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 068EA1F80B;
	Tue, 30 Jul 2024 14:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722351333;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BdT8JZg3DKfuwfUEfQlxvR1YOrlQZRc3CKq5j//fq6g=;
	b=mkYn7ZkjFXh+fKHvGddJA3gDM4FtF94uw8TwTLcBBe7hEibl1d0/QHvtjsuzAEk6+wH1sp
	xEK9kVmf+4P5tB1v4soIPjRqFDYBztYbS4EwBnKbQMwRnx/7WoFhlQX7elNxTarEUqQVfn
	U3NB2NbI1sJlfchuiG5e7hjw+yADX7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722351333;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BdT8JZg3DKfuwfUEfQlxvR1YOrlQZRc3CKq5j//fq6g=;
	b=cOPZoCnNb6NzOjMLgxoyoZttDu5pGoP5kZQhKQM3kYWL6T6ZPNY7nW8DSHmbsq3xg35bEP
	6ncwJ8X3tU2Gi0Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mkYn7Zkj;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cOPZoCnN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722351333;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BdT8JZg3DKfuwfUEfQlxvR1YOrlQZRc3CKq5j//fq6g=;
	b=mkYn7ZkjFXh+fKHvGddJA3gDM4FtF94uw8TwTLcBBe7hEibl1d0/QHvtjsuzAEk6+wH1sp
	xEK9kVmf+4P5tB1v4soIPjRqFDYBztYbS4EwBnKbQMwRnx/7WoFhlQX7elNxTarEUqQVfn
	U3NB2NbI1sJlfchuiG5e7hjw+yADX7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722351333;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BdT8JZg3DKfuwfUEfQlxvR1YOrlQZRc3CKq5j//fq6g=;
	b=cOPZoCnNb6NzOjMLgxoyoZttDu5pGoP5kZQhKQM3kYWL6T6ZPNY7nW8DSHmbsq3xg35bEP
	6ncwJ8X3tU2Gi0Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D931113297;
	Tue, 30 Jul 2024 14:55:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p53GNOT+qGY9dQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 30 Jul 2024 14:55:32 +0000
Date: Tue, 30 Jul 2024 16:55:27 +0200
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+05fd41caa517e957851d@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] general protection fault in
 btrfs_stop_all_workers (2)
Message-ID: <20240730145527.GM17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <00000000000096049806186fc6f9@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000096049806186fc6f9@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 068EA1F80B
X-Spam-Score: -1.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=3310e643b6ef5d69];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,syzkaller.appspot.com:url,storage.googleapis.com:url,appspotmail.com:email];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[05fd41caa517e957851d];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]

On Tue, May 14, 2024 at 01:23:32PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f03359bca01b Merge tag 'for-6.9-rc6-tag' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17a0fbc4980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3310e643b6ef5d69
> dashboard link: https://syzkaller.appspot.com/bug?extid=05fd41caa517e957851d
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/1b4deeb2639b/disk-f03359bc.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f3c3d98db8ef/vmlinux-f03359bc.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6f79ee1ae20f/bzImage-f03359bc.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+05fd41caa517e957851d@syzkaller.appspotmail.com
> 
> BTRFS info (device loop2): last unmount of filesystem c9fe44da-de57-406a-8241-57ec7d4412cf
> general protection fault, probably for non-canonical address 0xe01ffbf11002a143: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: maybe wild-memory-access in range [0x00ffff8880150a18-0x00ffff8880150a1f]

Most likely this was a side effect of bug fixed by commit f3a5367c679d
("btrfs: protect folio::private when attaching extent buffer folios").
The timeframe corresponds with increased number of bogus errors caused by
use-after-free of a page.

The fix is best guess.

#syz fix: btrfs: protect folio::private when attaching extent buffer folios

