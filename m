Return-Path: <linux-btrfs+bounces-13046-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B44CA8A69F
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 20:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 206984402E0
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Apr 2025 18:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC66224896;
	Tue, 15 Apr 2025 18:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nMu0fbhu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TieEXzyi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EPq/TlH9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JKtXBm7B"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077071A5BAB
	for <linux-btrfs@vger.kernel.org>; Tue, 15 Apr 2025 18:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744741130; cv=none; b=Zg8G8Wh79/cY0D6ODhvmJDgPcGLPZNi8gFTm7Zaqd9wFncNBhVygOdXc1bC54WbkRloxUQpwf4R3znDKEyAW5Mr8X/OJxvtD3GsjSEyAreLjRb6uUzJ9cm/CXEOocO05usZDYxDqzv96WxjRdsctlRel8hdwNAr1H1MAF+gWQTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744741130; c=relaxed/simple;
	bh=u92B18zE4CH+SfdM0Xg091QfM+XEKzHheOd6Yv4Hi4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ytgl/rIBcQWhZIH/c93iSHa7lSoXdHI2rxfyRUsYmVkDHxWYMa+o2P/+DnHCChkCtViwLwOdTfZGxNxNLcofmUuItes7+2EY7+8CcG27/E9JRA3WGmZzE3Vv1XGS3mT4NcO8zU+7IF+9I+SMJq+iRQF/X0FDMQE2gwQ5JYqC9Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nMu0fbhu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TieEXzyi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EPq/TlH9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JKtXBm7B; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D12A1211A1;
	Tue, 15 Apr 2025 18:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744741127;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bXSCfDOb/2SjOyhGxVg1jOL5zbfMPmK7rmKThKLfOiI=;
	b=nMu0fbhuze+2Hy/AxAypnDbsQqyD/1Jz3+Qge34TeuCoQ++sIxUOfckjknnNVUwTi09yVa
	uXlh8yOnlG4RE9Kv6hI9YAEby+tz5uveBFru6edLoPSwe5nfgEFTP9JbJCAFVM7raG2SBP
	fJKiNKHNTsTdtruSPNa3scGG48+Z4Co=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744741127;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bXSCfDOb/2SjOyhGxVg1jOL5zbfMPmK7rmKThKLfOiI=;
	b=TieEXzyiCqOmyQoRJod0wXMOpc5H8flf4SmqlY8miDkeKqrZjmL34/VEvxwc7e7fVEeo9G
	V5uupHRzNalmSuBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="EPq/TlH9";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=JKtXBm7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744741126;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bXSCfDOb/2SjOyhGxVg1jOL5zbfMPmK7rmKThKLfOiI=;
	b=EPq/TlH9a6scUXRJ6/izswsxF0wRc4PfQ9JD+xqwUtPFhzRP2sfyxsg0s740I8R+6k+wlE
	LiaQXAlUcZU0oJ9FUvOiLeUApZzHuKVQTB9FxulHXv1ruFfB8xFm/93sx1juaQWHkng7al
	KEOTCp6bQUUHz9/s3rbHZCe8g69JXtE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744741126;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bXSCfDOb/2SjOyhGxVg1jOL5zbfMPmK7rmKThKLfOiI=;
	b=JKtXBm7B0fEdp6q9pmli7M8v3tuiMzqPR39VB8r354ZgZ+NiTJPCx89NhmrYQ5EI8K670l
	F9E4a7tsHzpEEfDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6132137A5;
	Tue, 15 Apr 2025 18:18:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MAv3Kwaj/meDAgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 15 Apr 2025 18:18:46 +0000
Date: Tue, 15 Apr 2025 20:18:41 +0200
From: David Sterba <dsterba@suse.cz>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: make btrfs_truncate_block() zero folio range
 for certain subpage corner cases
Message-ID: <20250415181841.GN16750@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1744344865.git.wqu@suse.com>
 <d66c922e591b3a57a230ca357b9085fe6ae53812.1744344865.git.wqu@suse.com>
 <Z_qycnlLXbCgd7uF@surfacebook.localdomain>
 <37e556c8-d7a4-4d65-81d7-44821d92603e@gmx.com>
 <CAHp75VdyLRQrnByZtPPL2sn9ucGWVkyZu-kBvZvvpr4P_tOTpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdyLRQrnByZtPPL2sn9ucGWVkyZu-kBvZvvpr4P_tOTpw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: D12A1211A1
X-Spam-Level: 
X-Spamd-Result: default: False [-2.71 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.com];
	FREEMAIL_CC(0.00)[gmx.com,suse.com,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,twin.jikos.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.71
X-Spam-Flag: NO

On Mon, Apr 14, 2025 at 01:40:11PM +0300, Andy Shevchenko wrote:
> On Mon, Apr 14, 2025 at 4:20 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > 在 2025/4/13 04:05, Andy Shevchenko 写道:
> > > Fri, Apr 11, 2025 at 02:44:01PM +0930, Qu Wenruo kirjoitti:
> 
> [...]
> 
> > >> +    block_start = round_down(clamp_start, block_size);
> > >> +    block_end = round_up(clamp_end + 1, block_size) - 1;
> > >
> > > LKP rightfully complains, I believe you want to use ALIGN*() macros instead.
> >
> > Personally speaking I really want to explicitly show whether it's
> > rounding up or down.
> >
> > And unfortunately the ALIGN() itself doesn't show that (meanwhile the
> > ALIGN_DOWN() is pretty fine).
> >
> > Can I just do a forced conversion on the @blocksize to fix the warning?
> 
> ALIGN*() are for pointers, the round_*() are for integers. So, please
> use ALIGN*().

clamp_start and blocksize are integers and there's a lot of use of ALIGN
with integers too. There's no documentation saying it should be used for
pointers, I can see PTR_ALIGN that does the explicit cast to unsigned
logn and then passes it to ALIGN (as integer).

Historically in the btrfs code the use of ALIGN and round_* is basically
50/50 so we don't have a consistent style, although we'd like to. As the
round_up and round_down are clear I'd rather keep using them in new
code.

