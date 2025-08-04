Return-Path: <linux-btrfs+bounces-15838-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A87B1A308
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 15:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06B218843DC
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Aug 2025 13:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AE92609FD;
	Mon,  4 Aug 2025 13:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GYgBLVYD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UWHVGBc+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GYgBLVYD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UWHVGBc+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B745325F998
	for <linux-btrfs@vger.kernel.org>; Mon,  4 Aug 2025 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754313305; cv=none; b=MUxL+eaqk0jSMYL4g2MoFYKDbSIAUReq53mX0PXScGno/4rVQFaE4fM44xrsfsz0p2T/+kYsZfmT9E/8ECACcaWRW03DUTqY+yuFOhvjtiojO2OMthYpOM15Y21KM1sRKRGhqnA/wPa/duI/z3E6sWLDbM3yc++dRSGoXc5C8Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754313305; c=relaxed/simple;
	bh=SjxtD1JZ7HgXAnQFFUdttQ5fwGsPG4mbYZyNZc87Gx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpAzEshNsSdkuv7khcc/+09GT7W+eUGmrGpTSva+2kqN1yGgV5mVGnEBURvlDhTChZotX0+Ocnt3z2597Rd0WescrcCaFFhagmOQAclcjSSG6wjt4xIjrvaOl4ybwBIZscJWNQXjNS3MW1c1fvTflF0MMXRMorSKQDs+3FhH70k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GYgBLVYD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UWHVGBc+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GYgBLVYD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UWHVGBc+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6CD5F21A7E;
	Mon,  4 Aug 2025 13:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754313301;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=97+ImFfV71G60U3909PhKvPAWfTQng3xmKfqpJCrPLI=;
	b=GYgBLVYD2J1CxW4V7PvpE26HttnyvBoTef6GK7UQ9Tu8TbMw7P/hadMRgEjGwVkKAZp9lg
	+xyewufuL7l/rYe8FesMMQc+ycCvaEbwcfwyQZNh0/ibHHuRZUI0gydlvwG+7wNc1uFjJV
	G1DNlmF/QC8EsKpPRO+oUAFbd85KBkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754313301;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=97+ImFfV71G60U3909PhKvPAWfTQng3xmKfqpJCrPLI=;
	b=UWHVGBc+tFmAO1Sjjp8UYfovtwBaHWT/pi/zsvzQeIYh45cp5WBsxwq+ceHH4BmsfEs3xZ
	yRrWoemqMHMaq5AA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GYgBLVYD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UWHVGBc+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754313301;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=97+ImFfV71G60U3909PhKvPAWfTQng3xmKfqpJCrPLI=;
	b=GYgBLVYD2J1CxW4V7PvpE26HttnyvBoTef6GK7UQ9Tu8TbMw7P/hadMRgEjGwVkKAZp9lg
	+xyewufuL7l/rYe8FesMMQc+ycCvaEbwcfwyQZNh0/ibHHuRZUI0gydlvwG+7wNc1uFjJV
	G1DNlmF/QC8EsKpPRO+oUAFbd85KBkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754313301;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=97+ImFfV71G60U3909PhKvPAWfTQng3xmKfqpJCrPLI=;
	b=UWHVGBc+tFmAO1Sjjp8UYfovtwBaHWT/pi/zsvzQeIYh45cp5WBsxwq+ceHH4BmsfEs3xZ
	yRrWoemqMHMaq5AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56B2C13695;
	Mon,  4 Aug 2025 13:15:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oECyFFWykGgTSwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 04 Aug 2025 13:15:01 +0000
Date: Mon, 4 Aug 2025 15:14:55 +0200
From: David Sterba <dsterba@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 3/4] btrfs: add helper folio_end()
Message-ID: <20250804131455.GK6704@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1749557686.git.dsterba@suse.com>
 <3b3190a56dfabfeb0632fc131648567b84fcb04f.1749557686.git.dsterba@suse.com>
 <CAHc6FU4gyR-mqBbzuxm4cWzmGqwMtD68KeD66YRtMMwZMvfBOQ@mail.gmail.com>
 <aIqVcqXIjc41C1BD@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aIqVcqXIjc41C1BD@casper.infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 6CD5F21A7E
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -4.21

On Wed, Jul 30, 2025 at 10:58:10PM +0100, Matthew Wilcox wrote:
> On Tue, Jul 29, 2025 at 11:59:12AM +0200, Andreas Gruenbacher wrote:
> > On Tue, Jul 29, 2025 at 11:44 AM David Sterba <dsterba@suse.com> wrote:
> > > There are several cases of folio_pos + folio_size, add a convenience
> > > helper for that. This is a local helper and not proposed as folio API
> > > because it does not seem to be heavily used elsewhere:
> > >
> > > A quick grep (folio_size + folio_end) in fs/ shows
> > >
> > >      24 btrfs
> > >       4 iomap
> > >       4 ext4
> > >       2 xfs
> > >       2 netfs
> > >       1 gfs2
> > >       1 f2fs
> > >       1 bcachefs
> > >       1 buffer.c
> > 
> > we now have a folio_end() helper in btrfs and a folio_end_pos() helper
> > in bcachefs, so people obviously keep reinventing the same thing.
> > Could this please be turned into a proper common helper?
> > 
> > I guess Willy will have a preferred function name.
> 
> Yes, and even implementation ;-)
> 
> folio_end() is too generic -- folios have a lot of "ends" (virtual,
> physical, logical) in various different units (bytes, sectors,
> PAGE_SIZE).  And then the question becomes whether this is an inclusive
> or exclusive 'end'.
> 
> Fortunately, we already have a great function which almost does what you
> want -- folio_next_index().  The only reason you don't want to use that
> is that it returns the answer in the wrong units (PAGE_SIZE) instead of
> bytes.  So:
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 8eb4b73b6884..a6d32d4a77c3 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -899,11 +899,22 @@ static inline struct page *grab_cache_page_nowait(struct address_space *mapping,
>   *
>   * Return: The index of the folio which follows this folio in the file.
>   */
> -static inline pgoff_t folio_next_index(struct folio *folio)
> +static inline pgoff_t folio_next_index(const struct folio *folio)
>  {
>  	return folio->index + folio_nr_pages(folio);
>  }
>  
> +/**
> + * folio_next_pos - Get the file position of the next folio.
> + * @folio: The current folio.
> + *
> + * Return: The position of the folio which follows this folio in the file.
> + */
> +static inline loff_t folio_next_pos(const struct folio *folio)
> +{
> +	return (loff_t)folio_next_index(folio) << PAGE_SHIFT;
> +}

Works for me. The change in semantics from "end" to "start of the next
one" is still understandable, it's used in bounds checks or when moving
to the next folio.

