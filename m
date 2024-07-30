Return-Path: <linux-btrfs+bounces-6885-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFB49414AD
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 16:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6652A2844E5
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 14:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76791A3BDE;
	Tue, 30 Jul 2024 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tIsbXp81";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NZKj9YTw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tIsbXp81";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NZKj9YTw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149541A257E;
	Tue, 30 Jul 2024 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722350699; cv=none; b=LpNmr7AzmYA0918FeFquyd/gJnlk3/938BGYf6cpzL/Z01gAwGLFFCQjLEoRWM/bGbuUVi+TOxLL8kTuUzADT0ien6cZuxXpLDwE/5mR05prdpV+nprdiz/7DnRxn2fqpUSBylvHuk0F84x14gq1vcKXh7YQpEblvNza461VWHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722350699; c=relaxed/simple;
	bh=gSx/7lHE/PMLy5Y8F0EJAp52+7h2a/VarY4YUcAPLDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5QIRpTOp4le0AyJSXaTLkdo9GnsszSvkTBxEfw8f2kgT5W63xxlV9ubvj/mtzHNXN0gcC6i/HGWGLSOWaFSOQLs1K7GXfktFdHQUJZNo7mVurOhWaqud8JLahm+y+4Y1f62wXfG4XNKbhZdAI02BabI9/TWY1ymm/4Kpf9DNpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tIsbXp81; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NZKj9YTw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tIsbXp81; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NZKj9YTw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 25DF421A5B;
	Tue, 30 Jul 2024 14:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722350696;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QUsMKtPBcMux5juoA7RFd6oW5fn/anZ8vNoPsKM4bYU=;
	b=tIsbXp81Nj+S2JtqAAh01D45atHp728i+MLSd6e9DYJbw5p1adBclSdBXmHMQksAubJWVA
	kOWPjJJzm4lGoPkRR/QUVhaXfCQJcO8nJTxrdbtIRl8HCu+9Dsbgcrj8mIOiqGiYYsbjbr
	SBCjyY46n7z8bf1OmxmxN93DfKg/0sQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722350696;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QUsMKtPBcMux5juoA7RFd6oW5fn/anZ8vNoPsKM4bYU=;
	b=NZKj9YTw5gKqZksOrMEIEkrFyZEfPhgcLw3GxwhjX5TRzquOxMOCpsmUiFXNeZ30qdVx7P
	KxD9VW0RhHMBTlAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tIsbXp81;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NZKj9YTw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722350696;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QUsMKtPBcMux5juoA7RFd6oW5fn/anZ8vNoPsKM4bYU=;
	b=tIsbXp81Nj+S2JtqAAh01D45atHp728i+MLSd6e9DYJbw5p1adBclSdBXmHMQksAubJWVA
	kOWPjJJzm4lGoPkRR/QUVhaXfCQJcO8nJTxrdbtIRl8HCu+9Dsbgcrj8mIOiqGiYYsbjbr
	SBCjyY46n7z8bf1OmxmxN93DfKg/0sQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722350696;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QUsMKtPBcMux5juoA7RFd6oW5fn/anZ8vNoPsKM4bYU=;
	b=NZKj9YTw5gKqZksOrMEIEkrFyZEfPhgcLw3GxwhjX5TRzquOxMOCpsmUiFXNeZ30qdVx7P
	KxD9VW0RhHMBTlAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0AEC913297;
	Tue, 30 Jul 2024 14:44:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Cr55Amj8qGbncQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 30 Jul 2024 14:44:56 +0000
Date: Tue, 30 Jul 2024 16:44:54 +0200
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+ca895d3f00092ebf1408@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] KMSAN: uninit-value in btrfs_compress_heuristic
Message-ID: <20240730144454.GI17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0000000000005c792d0619962ca1@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000005c792d0619962ca1@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 25DF421A5B
X-Spam-Score: -1.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[ca895d3f00092ebf1408];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,syzkaller.appspot.com:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]

On Wed, May 29, 2024 at 04:37:20AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    614da38e2f7a Merge tag 'hid-for-linus-2024051401' of git:/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14573014980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f5d2cbf33633f507
> dashboard link: https://syzkaller.appspot.com/bug?extid=ca895d3f00092ebf1408
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.

Most likely this was a side effect of bug fixed by commit f3a5367c679d
("btrfs: protect folio::private when attaching extent buffer folios").
The timeframe corresponds with increased number of bogus errors caused
by use-after-free of a page.

The fix is best guess.

#syz fix: btrfs: protect folio::private when attaching extent buffer folios

