Return-Path: <linux-btrfs+bounces-9899-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DB59D8BFA
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2024 19:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89C3D284727
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2024 18:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FD31B86F6;
	Mon, 25 Nov 2024 18:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RadMfOcV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x9oJOupz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RadMfOcV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x9oJOupz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0171B4146;
	Mon, 25 Nov 2024 18:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732558142; cv=none; b=WTWdfz8VvajBHggmc49c6BC5TX5rPRRiAOdzf42ZSgH/3iaC0mf5RECs8jzAQk6jMhtmm6NeW7gcdi70aJWZRayodqED7gKEwZogOi3OfP9/Y+FydS4gk5lmrToF8XZoSNbNql/dCf7FzV7UEuiUeuJ6edyKEJdg+DOnAaA/4mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732558142; c=relaxed/simple;
	bh=w7kxJO28hJuvu7d/idb2o+h8f2jsfvZ9tNM+W19lsww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPXa4OXKdPIWqM4KhTfE3WjBRxrh+9aJ/NwyXW7GT4yAvvYM1vfVnREAAxZ37FlBaqtfrCm2GxX/aAeU4Znz+aKj8Ck+Mtq4nWsj/hfYgwsrGxpM5GCAjQ+uN5roM2s66xZUkd1H1Pu0Xh6b24Au38XqtRr+VJwuKKvl7UXaPGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RadMfOcV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x9oJOupz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RadMfOcV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x9oJOupz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 571811F453;
	Mon, 25 Nov 2024 18:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732558138;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c5nBz9JB+d6ohi06eJrf2yvhifSibzaMzqiLfFX/JRA=;
	b=RadMfOcVRxFTxBUjRKYF2Cr9+6xqNCrqQEOd0ceWi0kKzyieoVEpvB9xj2bmvSuOD2ocwE
	jIkgVFOopCdQCCZMaUvG+L+Whr6g+qN+5w5NaMzZgjuSgxa9rOJcZEZhKtt2CXCfFhENGs
	UWeSS6iPycLDHwLtnX5tWRnQoHbg+DM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732558138;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c5nBz9JB+d6ohi06eJrf2yvhifSibzaMzqiLfFX/JRA=;
	b=x9oJOupzZNTdYjYUit+y+C1PmTOtVKVNR8KMZo7dEiPKJUXqIt+xWI+mU6MruCvCJ/1s0y
	A+ar97NYr1vinQDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RadMfOcV;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=x9oJOupz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732558138;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c5nBz9JB+d6ohi06eJrf2yvhifSibzaMzqiLfFX/JRA=;
	b=RadMfOcVRxFTxBUjRKYF2Cr9+6xqNCrqQEOd0ceWi0kKzyieoVEpvB9xj2bmvSuOD2ocwE
	jIkgVFOopCdQCCZMaUvG+L+Whr6g+qN+5w5NaMzZgjuSgxa9rOJcZEZhKtt2CXCfFhENGs
	UWeSS6iPycLDHwLtnX5tWRnQoHbg+DM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732558138;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c5nBz9JB+d6ohi06eJrf2yvhifSibzaMzqiLfFX/JRA=;
	b=x9oJOupzZNTdYjYUit+y+C1PmTOtVKVNR8KMZo7dEiPKJUXqIt+xWI+mU6MruCvCJ/1s0y
	A+ar97NYr1vinQDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E59413890;
	Mon, 25 Nov 2024 18:08:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NpADDzq9RGcwEwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 25 Nov 2024 18:08:58 +0000
Date: Mon, 25 Nov 2024 19:08:57 +0100
From: David Sterba <dsterba@suse.cz>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Atemu <git@atemu.net>, Luca Stefani <luca.stefani.ge1@gmail.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] btrfs: Don't block system suspend during fstrim
Message-ID: <20241125180856.GE31418@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240917203346.9670-1-luca.stefani.ge1@gmail.com>
 <20240917203346.9670-3-luca.stefani.ge1@gmail.com>
 <SICOALIt6xFGz_7VCBwGpUxENKZz_3Em604Vvgvh8Pi79wpvimQFBQNkDxa1kE5lwfkOU0ZSYRaiIugTDLAfM1j3HMUgM25s1rgpmmRQ9TI=@atemu.net>
 <2024111923-capsize-resonant-eed6@gregkh>
 <wnPVOgJfpl_-T0Kmx_rLagKGYDUVPe2v9-dL75Pn8evLxtS0h1PY3OGUSihwcMAJ4Q5A3heeKnYQZcPaX81_ieEwyKirOcV2ZdutRF8JgrI=@atemu.net>
 <2024112033-booted-kinswoman-6cb5@gregkh>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024112033-booted-kinswoman-6cb5@gregkh>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 571811F453
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[atemu.net,gmail.com,fb.com,toxicpanda.com,suse.com,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.71
X-Spam-Flag: NO

On Wed, Nov 20, 2024 at 01:17:14PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Nov 20, 2024 at 07:41:32AM +0000, Atemu wrote:
> > Hi, 
> > 
> > 
> > > What is the git commit id in LInus's tree you are referring to here?
> > 
> > It's 69313850dce33ce8c24b38576a279421f4c60996. Apparently marked for backport to 5.15+.
> 
> Please see the FAILED emails about why this was not applied, here is
> one:
> 	https://lore.kernel.org/r/2024101412-diaphragm-sly-ea40@gregkh
> 
> Have you tested and tried this commit out in these older kernels?  If
> so, can you please send a working version so that we can apply them?

The conflict was trivial, only adding the linux/freezer.h include. I've
sent an updated version that applies to 6.6.

