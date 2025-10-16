Return-Path: <linux-btrfs+bounces-17897-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAE8BE4A77
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 18:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C1854EF7A5
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 16:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD6832AAC6;
	Thu, 16 Oct 2025 16:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uiSO7lbw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UIF0TOdN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uiSO7lbw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UIF0TOdN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2CD2E62D0
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Oct 2025 16:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760632957; cv=none; b=XLku8HapuwHXHd6mweotOBi6Fk5wUKFcHNmmxXVeY/+sZMcJdLzbUCvelS/Tc0rPej/sCXwueSZpQ7dGDPEhX/m3eSyqVGMHqPC4Gt+i5TseqTJLR268lchJtkotcGagOFqmo3s72fvre1HXcrXrkVjm1YA+Wdq+OnMkqrZiRpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760632957; c=relaxed/simple;
	bh=GHiLAX06lGnABTJLapLmJZk3xEa3SrwYGW+s773r1Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Km7QqjvJFXtgr/mEbaeE8awT1XWPPmF4e2suclxPQQDgJzVyj8mkRkMKIAS+RYJhJum+Oip6jFC710/IKIxWsP4HbIt1SQTBkwYWnhrke4/vavH3TwQNqYWzW/WChNvoGPGL4CSPvVD+KTq/pJPaXhJv1nsvrva2RTInh/OLRtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uiSO7lbw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UIF0TOdN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uiSO7lbw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UIF0TOdN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1A74A21747;
	Thu, 16 Oct 2025 16:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760632954;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M8s4v27AcjZCIqsBB7/4FGLVHIR1HkNZrdTF0DHidDI=;
	b=uiSO7lbw8X8ets9EoFwawoFIaIi48eT5GeLmO0AmOstrFzaRTdThjlth1xD6URZuRFf4Z3
	6b9OikSb9dd0VQSZhpq1wUpn8Csqns+lCHdlOHaNXPc5ua1QnjxroGVuJ0eVXtJ7a80bBz
	1WWzOFNgYOS7iMyTcz1ENgaRKfcS+G8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760632954;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M8s4v27AcjZCIqsBB7/4FGLVHIR1HkNZrdTF0DHidDI=;
	b=UIF0TOdNrZB5KFFUxa559TN9UworWV6CQcTtr6xWtIdxW6Kw+ANGmDb8aDXircHGOcTw0T
	B/PFZwP1r91z0ADw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uiSO7lbw;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UIF0TOdN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760632954;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M8s4v27AcjZCIqsBB7/4FGLVHIR1HkNZrdTF0DHidDI=;
	b=uiSO7lbw8X8ets9EoFwawoFIaIi48eT5GeLmO0AmOstrFzaRTdThjlth1xD6URZuRFf4Z3
	6b9OikSb9dd0VQSZhpq1wUpn8Csqns+lCHdlOHaNXPc5ua1QnjxroGVuJ0eVXtJ7a80bBz
	1WWzOFNgYOS7iMyTcz1ENgaRKfcS+G8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760632954;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M8s4v27AcjZCIqsBB7/4FGLVHIR1HkNZrdTF0DHidDI=;
	b=UIF0TOdNrZB5KFFUxa559TN9UworWV6CQcTtr6xWtIdxW6Kw+ANGmDb8aDXircHGOcTw0T
	B/PFZwP1r91z0ADw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F13B51376E;
	Thu, 16 Oct 2025 16:42:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bqhxOnkg8Wi1BQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 16 Oct 2025 16:42:33 +0000
Date: Thu, 16 Oct 2025 18:42:24 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: scrub: cancel the run if the process or fs is
 being frozen
Message-ID: <20251016164224.GH13776@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1760588662.git.wqu@suse.com>
 <36aa07502d2edd17d21e28b97d71cab182c12bdf.1760588662.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36aa07502d2edd17d21e28b97d71cab182c12bdf.1760588662.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 1A74A21747
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 

On Thu, Oct 16, 2025 at 03:02:30PM +1030, Qu Wenruo wrote:
> It's a known bug that btrfs scrub/dev-replace can prevent the system
> from suspending.
> 
> There are at least two factors involved:
> 
> - Holding super_block::s_writers for the whole scrub/dev-replace
>   duration
>   We hold that mutex through mnt_want_write_file() for the whole
>   scrub/dev-replace duration.
> 
>   That will prevent the fs being frozen.
>   It's tunable for the kernel to suspend all fses before suspending, if
>   that's the case, a running scrub will refuse to be frozen and prevent
>   suspension.
> 
> - Stuck in kernel space for a long time
>   During suspension all user processes (and some kernel threads) will
>   be frozen.
>   But if a user space progress has fallen into kernel (scrub ioctl) and
>   do not return for a long time, it will make suspension time out.
> 
>   Unfortunately scrub/dev-replace is a long running ioctl, and it will
>   prevent the btrfs process from returning to user space.
> 
> Address them in one go:
> 
> - Introduce a new helper should_cancel_scrub()
>   Which checks both fs and process freezing.
> 
> - Cancel the run if should_cancel_scrub() is true
>   The check is done at scrub_simple_mirror() and
>   scrub_raid56_parity_stripe().
> 
>   Unfortunately canceling is the only feasible solution here, pausing is
>   not possible as we will still stay in the kernel state thus will still
>   prevent the process from being frozen.

I don't recall the details but the solution I was working on allowed
waiting in kernel and not cancelling the whole scrub, which I think is
the wrong solution and bad usability. That way scrub may never finish
going over the whole filesystem.

