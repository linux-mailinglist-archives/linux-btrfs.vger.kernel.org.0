Return-Path: <linux-btrfs+bounces-16732-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5B2B4977E
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 19:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0792E340A42
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Sep 2025 17:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8BF31329D;
	Mon,  8 Sep 2025 17:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RvfQjF0D";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PFICxg7C";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RvfQjF0D";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PFICxg7C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927AB21D3E4
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Sep 2025 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757353486; cv=none; b=lV7NeFqC8iEWrzww9i+bdR2UBBdhf4G8Jow3hQkRUSYBgVr2iGSaouuXYMkAzz3u9trfDA7pjXgahJ9qTgpM5LmcnbjqS2pkbkaDxIV+vSBynjs2IFtZYiiZV1G9ji7uL6aal9FhJAoEDmvzVADorE0nfLXcPmPj82FLmAYBVa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757353486; c=relaxed/simple;
	bh=V6lSAp8L15PITGAGv5n/Vmnw5F61ohOQ9weJ++39jEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIKMUq2xnJb16pPZrT+AurJ/ew1/K8r5zDZhx4V8vPSFm5w40fBytcU9rAslUTOwtGo6IY49KzqILb01RH/FqHSHFw3FR1WyY+T/N5IpZvzmk23jSz//pbwC0jPuQyJ3bQmKprPTGF4GHu2EITMI1GiVdKYZ/ETbQcFN/T8EWq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RvfQjF0D; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PFICxg7C; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RvfQjF0D; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PFICxg7C; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2536A17AD3;
	Mon,  8 Sep 2025 17:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757353481;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0wi0SzaL3Ub7HNF2KnIuePxvFiUFLQkf+eodPwABO8c=;
	b=RvfQjF0DYbVootIABqIXhJhOWLzpHgAeUFdFHkvaJfPowdvfTi6Tj2dhe6WKUtiHrdBoVB
	+BHuba18o1bZEpqOQqj5SE8LdV+6dW4mSZGEG36mfhn5RAwHIqeT89YLV+Gk4GfGwgBx+v
	9apNKhAukKfKaIbev8KfjQsgoAdvwVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757353481;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0wi0SzaL3Ub7HNF2KnIuePxvFiUFLQkf+eodPwABO8c=;
	b=PFICxg7CzsmLyIprP7YMcsIFtIxk+V3E5eZbZJl7BfZaqho4ErmyA+d5KonizL4WBDfrjo
	tI79boz9kKeV5+AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RvfQjF0D;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PFICxg7C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757353481;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0wi0SzaL3Ub7HNF2KnIuePxvFiUFLQkf+eodPwABO8c=;
	b=RvfQjF0DYbVootIABqIXhJhOWLzpHgAeUFdFHkvaJfPowdvfTi6Tj2dhe6WKUtiHrdBoVB
	+BHuba18o1bZEpqOQqj5SE8LdV+6dW4mSZGEG36mfhn5RAwHIqeT89YLV+Gk4GfGwgBx+v
	9apNKhAukKfKaIbev8KfjQsgoAdvwVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757353481;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0wi0SzaL3Ub7HNF2KnIuePxvFiUFLQkf+eodPwABO8c=;
	b=PFICxg7CzsmLyIprP7YMcsIFtIxk+V3E5eZbZJl7BfZaqho4ErmyA+d5KonizL4WBDfrjo
	tI79boz9kKeV5+AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1596113869;
	Mon,  8 Sep 2025 17:44:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9MXQBAkWv2hGCAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 08 Sep 2025 17:44:41 +0000
Date: Mon, 8 Sep 2025 19:44:38 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 4/5] btrfs: introduce btrfs_bio_for_each_block_all()
 helper
Message-ID: <20250908174438.GS5333@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1756803640.git.wqu@suse.com>
 <85543e15b7440b4d7b8f88d1e5384a0b2dafa693.1756803640.git.wqu@suse.com>
 <20250905173319.GP5333@twin.jikos.cz>
 <87f75733-f6a6-46cb-b5af-f574314342bd@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87f75733-f6a6-46cb-b5af-f574314342bd@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 2536A17AD3
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:mid,suse.cz:replyto]
X-Spam-Score: -4.21

On Sat, Sep 06, 2025 at 07:38:27AM +0930, Qu Wenruo wrote:
> >> +static inline struct bvec_iter init_bvec_iter_for_bio(struct bio *bio)
> >> +{
> >> +	struct bio_vec *bvec;
> >> +	u32 bio_size = 0;
> >> +	int i;
> >> +
> >> +	bio_for_each_bvec_all(bvec, bio, i)
> >> +		bio_size += bvec->bv_len;
> >> +
> >> +	return (struct bvec_iter) {
> >> +		.bi_sector = 0,
> >> +		.bi_size = bio_size,
> >> +		.bi_idx = 0,
> >> +		.bi_bvec_done = 0,
> >> +	};
> > 
> > We don't use this kind of initializers, usually the structure is passed
> > as parameter, but I can see how it makes it convenient in the for()
> > initialization. The parameter way would work but would also look strange
> > so I think it's acceptable.
> 
> I'd say this really makes a lot of things easier, and avoid pointer 
> usage (in this particular case it allows us to use local @iter without 
> the need of a caller provided pointer), it should get more usage.

If the patterns are an improvement (and this means for the people who
work on the code) then we can do it, also because the minimum version of
compilers is increasing over time which means newer C features are
available. This one in particular is not new and looks readable, so ok
for me.

