Return-Path: <linux-btrfs+bounces-18651-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB89DC30E6B
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 13:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A1FE18C1A51
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 12:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF51E2ED87F;
	Tue,  4 Nov 2025 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MqvL8ie3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3eSYI+vx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MqvL8ie3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3eSYI+vx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8B92222A9
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Nov 2025 12:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258244; cv=none; b=qludUzTX2uUH1dj8iBfRhRHSXUQFAMHWTqk3w1EaTnrLnXqpRzOefKumR9TWmBj2mctGGXJoOpdP77vyxzpGZ0V480cOWo5AnzzI9yYoaFx4sH5pFnuK8kQnPGIe6aOFGlF7dWpL9BCHjkb7DN2z9Wt9eETfSCT5IuQdSO6JXhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258244; c=relaxed/simple;
	bh=eGel8KiBuFDjo4pPMieMo1yjjgAaXxQ+cw+aICaOscE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=knzvZPSMQXwKAfqXSGiz+aj52KunegW/jzJ4sl8qGtgn/NIhnTj35RfcplKNoxsvMQU9mJZKcAs+izACqT8Wmgi5Vr+N9iaEK3JsgsVEBEA0Oq162yRDr9pDI8kRRJwNBD2od9bXUWZAOWgDw6wHS25CbL2eJDkYEW7jF34yA1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MqvL8ie3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3eSYI+vx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MqvL8ie3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3eSYI+vx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3B36E211A9;
	Tue,  4 Nov 2025 12:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762258235;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZXHSVsnrd5TeAVl7VxqvV3F2lMc2ZR7mLog+oT3Wdg4=;
	b=MqvL8ie3U4bOb+IJ7mBpak9YmIF7mGWwGKwjMxDj08EFKMEwD+gE6Y5VcBfSu57nj6HZ/W
	lvRNpib+eHv4I4eUdhY1j7M3lhbnW/cjokqdr3Sz93lRxE9K/T1EQKekk5KP6yj/DQM3u8
	c7uya71crq/Ie6lLqPPiLnyS2s8n+Xc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762258235;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZXHSVsnrd5TeAVl7VxqvV3F2lMc2ZR7mLog+oT3Wdg4=;
	b=3eSYI+vxLU8NAR1ZwrAAPkkY13pY8EG0UF+D8Nnf9wuWqYTJ4a8PjWFFf2yAVbigbMRWOy
	XXNRK/ZYE3IGSsDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MqvL8ie3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3eSYI+vx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762258235;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZXHSVsnrd5TeAVl7VxqvV3F2lMc2ZR7mLog+oT3Wdg4=;
	b=MqvL8ie3U4bOb+IJ7mBpak9YmIF7mGWwGKwjMxDj08EFKMEwD+gE6Y5VcBfSu57nj6HZ/W
	lvRNpib+eHv4I4eUdhY1j7M3lhbnW/cjokqdr3Sz93lRxE9K/T1EQKekk5KP6yj/DQM3u8
	c7uya71crq/Ie6lLqPPiLnyS2s8n+Xc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762258235;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZXHSVsnrd5TeAVl7VxqvV3F2lMc2ZR7mLog+oT3Wdg4=;
	b=3eSYI+vxLU8NAR1ZwrAAPkkY13pY8EG0UF+D8Nnf9wuWqYTJ4a8PjWFFf2yAVbigbMRWOy
	XXNRK/ZYE3IGSsDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 17B02136D1;
	Tue,  4 Nov 2025 12:10:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eruQBTvtCWnlPwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 04 Nov 2025 12:10:35 +0000
Date: Tue, 4 Nov 2025 13:10:29 +0100
From: David Sterba <dsterba@suse.cz>
To: Gladyshev Ilya <foxido@foxido.dev>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: make ASSERT no-op in release builds
Message-ID: <20251104121029.GO13846@suse.cz>
Reply-To: dsterba@suse.cz
References: <20251102073904.2149103-1-foxido@foxido.dev>
 <20251104001800.GM13846@suse.cz>
 <98e33c86-f5f3-46c5-8dba-c28a459b4a45@foxido.dev>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98e33c86-f5f3-46c5-8dba-c28a459b4a45@foxido.dev>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 3B36E211A9
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[foxido.dev:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim,suse.cz:replyto]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 

On Tue, Nov 04, 2025 at 02:37:30PM +0300, Gladyshev Ilya wrote:
> On 11/4/25 03:18, David Sterba wrote:
> > On Sun, Nov 02, 2025 at 10:38:52AM +0300, Gladyshev Ilya wrote:
> >> The current definition of `ASSERT(cond)` as `(void)(cond)` is redundant,
> >> since these checks have no side effects and don't affect code logic.
> > 
> > Have you checked that none of the assert expressions really don't have
> > side effects other than touching the memory?
> 
> Yes, but visually only. Most checks are plain C comparisons, and some 
> call folio/btrfs/refcount _check/test_ functions where I didn't find 
> side effects.
> 
> However, fs/btrfs/ has ~880 asserts, so if you know more robust 
> verification methods, I'd be glad to try them.

Good, thanks. I tried the same, with some random grep filters for
possible function calls but nothing out of scope found so I guess this
is sufficient.

> >> However, some checks contain READ_ONCE or other compiler-unfriendly
> >> constructs. For example, ASSERT(list_empty) in btrfs_add_dealloc_inode
> >> was compiled to a redundant mov instruction due to this issue.
> >>
> >> This patch defines ASSERT as BUILD_BUG_ON_INVALID for !CONFIG_BTRFS_ASSERT
> >> builds. It also marks `full_page_sectors_uptodate` as __maybe_unused to
> >> suppress "unneeded declaration" warning (it's needed in compile time)
> >>
> >> Signed-off-by: Gladyshev Ilya <foxido@foxido.dev>
> >> ---
> >> Changes from v1:
> >> - Annotate full_page_sectors_uptodate as __maybe_unused to avoid
> >>    compiler warning
> >>
> >> Link to v1: https://lore.kernel.org/linux-btrfs/20251030182322.4085697-1-foxido@foxido.dev/
> >> ---
> >>   fs/btrfs/messages.h | 2 +-
> >>   fs/btrfs/raid56.c   | 4 ++--
> >>   2 files changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
> >> index 4416c165644f..f80fe40a2c2b 100644
> >> --- a/fs/btrfs/messages.h
> >> +++ b/fs/btrfs/messages.h
> >> @@ -168,7 +168,7 @@ do {										\
> >>   #endif
> >>   
> >>   #else
> >> -#define ASSERT(cond, args...)			(void)(cond)
> >> +#define ASSERT(cond, args...)			BUILD_BUG_ON_INVALID(cond)
> > 
> > I'd rather have the expression open coded rather than using
> > BUILD_BUG_ON_INVALID, the name is confusing as it's not checking build
> > time condtitons.
> 
> The name kinda indicates that it triggers on invalid conditions, not 
> false ones, but I understand that it can be confusing. While we could 
> use direct sizeof() magic here, I prefer reusing the same infrastructure 
> as VM_BUG_ON(), VFS_*_ON() and others.
> 
> Maybe adding a comment about its semantics above ASSERT definition will 
> help clarify the usage? But if you prefer the sizeof() approach, I can 
> change it - it's not a big deal.

A comment for ASSERT works too. The BUILD_BUG_ON_INVALID is indeed
widely used so I don't expect any sudden change in semantics. As adding
the comment is simple I'll do that, no need to resend the patch. Thanks.

