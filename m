Return-Path: <linux-btrfs+bounces-6882-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E66941462
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 16:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2906B277A1
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 14:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B0D1A2562;
	Tue, 30 Jul 2024 14:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lPRmNix3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="prPUmBZc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lPRmNix3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="prPUmBZc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499FA1A2542;
	Tue, 30 Jul 2024 14:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722349746; cv=none; b=YOaUTMF6xtwDKrrpa6LgX1vqiuCmgadc7p6FGS9wxLEEpGWEDganYx9ZNBLNRgW/4KhY13UYFqUlWF9vkLnZ6bUVrUblKKX2fO/o7ko9OpqcPpogWeZsf9FooH+AaGuJTJEEyqDpCz+yUJOyBK6MpZey83bptMFuPkzb4d50ozY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722349746; c=relaxed/simple;
	bh=zVFqjIcSC24t3cQoOBUUphoHlw9VpenKgLWiWbbaCOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAq6NUwvt7hB+cr9awzyL/kdSDKyFUFXiR5flpKeq2J2ZTxXPq1zdBbUcc8DdWLNIF6vYOh8KmwnEtxYi3Cl4Qt9mFm52S1vgrlvHk03/anbeKGUYbydddaRrRvOg9S7R1+G8fx19sJ4EEklA5ULRDYh0+Qsrgq4f/Zk7nYjAsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lPRmNix3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=prPUmBZc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lPRmNix3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=prPUmBZc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2F7AE21B58;
	Tue, 30 Jul 2024 14:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722349742;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t4QbICu75iotzMNKAZjA2FIKW9tUy1bLDgCgXCB20LE=;
	b=lPRmNix3xg4s7lmeLMUkEMl0efFS8BnM1R1EfKy1XyoDdrblPaBqYuwSIDIWl7ecWFMnOR
	Lvx9hhOl2bfMWkf6m+rkAgklco7ns8h0wEerPuYkweRvXKe5/Dac7YWf58GElW4llzudid
	FFJquEjDAKZSXC3/hXatQdYUpy2A2KU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722349742;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t4QbICu75iotzMNKAZjA2FIKW9tUy1bLDgCgXCB20LE=;
	b=prPUmBZcLxvFGKoEs8BBlX6SW6NreDRbuZwdTzu1j3pC1A9ajF6j0ztfHEkQoQ1GecaW6F
	PZoSAXqwii89c3AA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lPRmNix3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=prPUmBZc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722349742;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t4QbICu75iotzMNKAZjA2FIKW9tUy1bLDgCgXCB20LE=;
	b=lPRmNix3xg4s7lmeLMUkEMl0efFS8BnM1R1EfKy1XyoDdrblPaBqYuwSIDIWl7ecWFMnOR
	Lvx9hhOl2bfMWkf6m+rkAgklco7ns8h0wEerPuYkweRvXKe5/Dac7YWf58GElW4llzudid
	FFJquEjDAKZSXC3/hXatQdYUpy2A2KU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722349742;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t4QbICu75iotzMNKAZjA2FIKW9tUy1bLDgCgXCB20LE=;
	b=prPUmBZcLxvFGKoEs8BBlX6SW6NreDRbuZwdTzu1j3pC1A9ajF6j0ztfHEkQoQ1GecaW6F
	PZoSAXqwii89c3AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 15C3E13297;
	Tue, 30 Jul 2024 14:29:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7IQUBa74qGZMbQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 30 Jul 2024 14:29:02 +0000
Date: Tue, 30 Jul 2024 16:29:00 +0200
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+c86c7974966b98aab23d@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, terrelln@fb.com
Subject: Re: [syzbot] [btrfs?] KMSAN: uninit-value in
 ZSTD_compressBlock_doubleFast
Message-ID: <20240730142900.GF17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <000000000000794dc0061a448fc0@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000794dc0061a448fc0@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.49 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,appspotmail.com:email,suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,syzkaller.appspot.com:url];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[c86c7974966b98aab23d];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spamd-Bar: +
X-Rspamd-Queue-Id: 2F7AE21B58
X-Spam-Level: *
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: 1.49

On Thu, Jun 06, 2024 at 08:40:27PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    614da38e2f7a Merge tag 'hid-for-linus-2024051401' of git:/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=164aa5f2980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507
> dashboard link: https://syzkaller.appspot.com/bug?extid=c86c7974966b98aab23d
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/89eafb874b71/disk-614da38e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/356000512ad9/vmlinux-614da38e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/839c73939115/bzImage-614da38e.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c86c7974966b98aab23d@syzkaller.appspotmail.com

Most likely this was a side effect of bug fixed by commit f3a5367c679d
("btrfs: protect folio::private when attaching extent buffer folios").
There are 3 reports by syzbot, timeframe corresponds with increased
number of bogus errors caused by use-after-free of a page, compression
is reuses pages quite often.

The fix is best guess.

#syz fix: btrfs: protect folio::private when attaching extent buffer folios

