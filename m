Return-Path: <linux-btrfs+bounces-13549-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFE2AA4D81
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 15:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D81421BC363F
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Apr 2025 13:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C14F25C700;
	Wed, 30 Apr 2025 13:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="03fP3bXo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1FRLYm99";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rNR7rmLp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5uD+7E60"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C541EB5B
	for <linux-btrfs@vger.kernel.org>; Wed, 30 Apr 2025 13:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746019835; cv=none; b=HzRWx7GP5ZdCKmsFEJESkxYUclBTJvfDhlyvyi9Yk9eRUcCmBHzfNvU1GEzG3is7PVUGg9oaLCNtxlFrHURp4w0UfqPirWE9vWGKVzgNrE6CQ3CMgcmKFpTvN3BNTNZzb4BdALGk5WCKafz4Ac9eCBzByYH1z8Um18ckYvrBm3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746019835; c=relaxed/simple;
	bh=FUK72UCcAbgqKhkyAwVsKfsjNUq08EAAjoWV0V95JWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eq2UPN7ig+O+bl6faU8qX1UYWuR1zcqheTXrFUl3VggsCS6d84SmQH4Lg6FcCUQpNsVgt7AoWxbsyXpTu4CrMCFu5QfbIwikOuV4m6wpAX21elzD8wN4V3raJ6Y0hz6JS9FA/OcABv9IrrslRMc7QaSAuWx+LMKfq8bnKSW84no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=03fP3bXo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1FRLYm99; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rNR7rmLp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5uD+7E60; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C3F1721168;
	Wed, 30 Apr 2025 13:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746019832;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aXrm8L0PtcuZKV245THat/pGgNrx58PVEfekeZA2cds=;
	b=03fP3bXocKg5GYzogIaSuz5p/blXeVI4vCFR4AYqctruosBz0CZ8QUk7IPtXHnWPKBkIB4
	/eccHHUFNEYFLxiAbdNoZv9lajLqQ52DWqFJNk7Ke9nKQQchL4jwpKS+R6vuDEBPI/OZsJ
	JmNdjSB+9UShgwPrgqScTs6ZcO1vFLs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746019832;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aXrm8L0PtcuZKV245THat/pGgNrx58PVEfekeZA2cds=;
	b=1FRLYm99/j17CAEeR6VSsBVLosD38qdwKPNqylNmoS6jPrWJJdyjl/wMdHkoMvejRdCUqe
	Ok6komxvkyoxPlBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rNR7rmLp;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5uD+7E60
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746019831;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aXrm8L0PtcuZKV245THat/pGgNrx58PVEfekeZA2cds=;
	b=rNR7rmLp716tkFxAtFt43WmMJYu6Xut6ksC9zZWKxfZcnSJnGHgat7ynwPCBPZ7mxKBKja
	3e355u89HQIAXiQ3WycbV33gBdHUsqHn+3AkvjOWbkXwQfkjEuRTDzZbEJfQekLA4uyO/m
	MhFbTotpazMqYXAJxBCrfovHqRWAkYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746019831;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aXrm8L0PtcuZKV245THat/pGgNrx58PVEfekeZA2cds=;
	b=5uD+7E60DpXNAA/6/tyNv6Bc7oLxzGy7atAGTct8piTOjpTQwuAsGqlQzLF2Kq05WermJH
	UeHzJ2EENutAXgDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0CE113A25;
	Wed, 30 Apr 2025 13:30:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OfkHJ/clEmjPdAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 30 Apr 2025 13:30:31 +0000
Date: Wed, 30 Apr 2025 15:30:26 +0200
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove extent buffer's redundant `len` member
 field
Message-ID: <20250430133026.GH9140@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250429151800.649010-1-neelx@suse.com>
 <20250430080317.GF9140@twin.jikos.cz>
 <CAPjX3FfBoU9-wYP-JC63K6y8Pzocu0z8cKvXEbjD_NjdxWO+Og@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPjX3FfBoU9-wYP-JC63K6y8Pzocu0z8cKvXEbjD_NjdxWO+Og@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: C3F1721168
X-Spam-Level: 
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim,suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Wed, Apr 30, 2025 at 10:21:18AM +0200, Daniel Vacek wrote:
> > The benefit of duplicating the length in each eb is that it's in the
> > same cacheline as the other members that are used for offset
> > calculations or bit manipulations.
> >
> > Going to the fs_info->nodesize may or may not hit a cache, also because
> > it needs to do 2 pointer dereferences, so from that perspective I think
> > it's making it worse.
> 
> I was considering that. Since fs_info is shared for all ebs and other
> stuff like transactions, etc. I think the cache is hot most of the
> time and there will be hardly any performance difference observable.
> Though without benchmarks this is just a speculation (on both sides).

The comparison is between "always access 1 cacheline" and "hope that the
other cacheline is hot", yeah we don't have benchmarks for that but the
first access pattern is not conditional.

> > I don't think we need to do the optimization right now, but maybe in the
> > future if there's a need to add something to eb. Still we can use the
> > remaining 16 bytes up to 256 without making things worse.
> 
> This really depends on configuration. On my laptop (Debian -rt kernel)
> the eb struct is actually 272 bytes as the rt_mutex is significantly
> heavier than raw spin lock. And -rt is a first class citizen nowadays,
> often used in Kubernetes deployments like 5G RAN telco, dpdk and such.
> I think it would be nice to slim the struct below 256 bytes even there
> if that's your aim.

I configured and built RT kernel to see if it's possible to go to 256
bytes on RT and it seems yes with a big sacrifice of removing several
struct members that cache values like folio_size or folio_shift and
generating worse code.

As 272 is a multiple of 16 it's a reasonable size and we don't need to
optimize further. The number of ebs in one slab is 30, with the non-rt
build it's 34, which sounds OK.

