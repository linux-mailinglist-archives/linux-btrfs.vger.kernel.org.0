Return-Path: <linux-btrfs+bounces-22239-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLvsOtXwqGkwzAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22239-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 03:56:21 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E7320A5D9
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 03:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 75A32302D19B
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2026 02:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9384B26F296;
	Thu,  5 Mar 2026 02:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tkoOlfWe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JHsG66WN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tkoOlfWe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JHsG66WN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9255257459
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Mar 2026 02:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772679376; cv=none; b=NFsgd6K4rF9hmsBbxtTwVxJMyIpCvYDv13OPJRPhms0RBYHO3bcCcLdDHSZ/f3x0faCUTPlRvUmtq31JlKFgr4ocqJoGZKdlsxgfYsvItbBSVoP3BN3xn/nD8FfWnAQi11TtHgz3u1qGQq1pxdH79Wf/G37kkVN5SsboyTROoKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772679376; c=relaxed/simple;
	bh=1X/PQYFZe/sXyu9o0I221a8aVKQQbFOGof1NEFb9HKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1LxJsqx+35dx2E+yS+MdmfbkANPM9VMlKMWXk3CjOgHgzTHA544zBrrjXRz1S8msjClwN/DHoEiGSMTkOwpwWC6h/zUwkIB6KFhlhXHtyiyRpG5hEBftmygFASvpZfyaFAhLm2p1swnwfODmvEahWWNq4Ci7Pb58uCrw53o064=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tkoOlfWe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JHsG66WN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tkoOlfWe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JHsG66WN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 090565BCF1;
	Thu,  5 Mar 2026 02:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772679373;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o+dSyP6SQRguw7P+M01Sy3vYBcEuHnS65Cl9Bh50d6E=;
	b=tkoOlfWeOOHw8OWElSXeX3Ogu09pEx3aP38cqbevm6Bvq3gHpdATFGGl7eqwCxR5uaC/JK
	CZUkKYDKWE+rR/Zf/nNW6QLIgsNXl51bNELJzFJRRQO3WtmfkqQ64kk6Ky1dQWWjYnQzNz
	bfwM1wBPaoAVjmTD4u7tIO5/stNnpAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772679373;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o+dSyP6SQRguw7P+M01Sy3vYBcEuHnS65Cl9Bh50d6E=;
	b=JHsG66WNFxTn9BszIgbtAklOhh/imOA2wA0BybkNGNqTiHRkA+JzBPvYyMgLKSSQbAKzHU
	zXdJHehD34xl10BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772679373;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o+dSyP6SQRguw7P+M01Sy3vYBcEuHnS65Cl9Bh50d6E=;
	b=tkoOlfWeOOHw8OWElSXeX3Ogu09pEx3aP38cqbevm6Bvq3gHpdATFGGl7eqwCxR5uaC/JK
	CZUkKYDKWE+rR/Zf/nNW6QLIgsNXl51bNELJzFJRRQO3WtmfkqQ64kk6Ky1dQWWjYnQzNz
	bfwM1wBPaoAVjmTD4u7tIO5/stNnpAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772679373;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o+dSyP6SQRguw7P+M01Sy3vYBcEuHnS65Cl9Bh50d6E=;
	b=JHsG66WNFxTn9BszIgbtAklOhh/imOA2wA0BybkNGNqTiHRkA+JzBPvYyMgLKSSQbAKzHU
	zXdJHehD34xl10BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAD753EA76;
	Thu,  5 Mar 2026 02:56:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UjU9NczwqGluFwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 05 Mar 2026 02:56:12 +0000
Date: Thu, 5 Mar 2026 03:56:11 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: get rid of btrfs_(alloc|free)_compr_folio()
Message-ID: <20260305025611.GC5735@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <ddcbb67a60d1bc87bc2f45cbd6f830880a5076ae.1772438228.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddcbb67a60d1bc87bc2f45cbd6f830880a5076ae.1772438228.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Queue-Id: 92E7320A5D9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22239-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,twin.jikos.cz:mid]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 06:30:30PM +1030, Qu Wenruo wrote:
> [GLOBAL POOL]
> Btrfs has maintained a global (per-module) pool of folios for compressed
> read/writes.
> 
> That pool is maintained by a LRU list of cached folios, with a shrinker
> to free all cached folios when needed.
> 
> The function btrfs_alloc_compr_folio() will try to grab any existing
> folio from that LRU list first, and go regular folio allocation if that
> list is empty.
> 
> And btrfs_free_compr_folio() will try to put the folio into the LRU list
> if the current cache level is below the threshold (256 pages).
> 
> [EXISTING LIMITS]
> Since the global pool is per-module, we have no way to support different
> folio sizes. This limit is already affecting bs > ps support, so that bs
> > ps cases just by-pass that global pool completely.
> 
> Another limit is for bs < ps cases, which is more common.
> In that case we always allocate a full page (can be as large as 64K) for
> the compressed bio, this can be very wasteful if the on-disk extent is
> pretty small.
> 
> [POTENTIAL BUGS]
> Recently David is reporting bugs related to compression:
> 
> - List corruption on that LRU list
> 
> - Folio ref count reaching zero at btrfs_free_compr_folio
> 
> Although I haven't yet found a concrete chain of how this happened, I'm
> suspecting the usage of folio->lru is different from page->lru.
> Under most cases a lot of folio members are 1:1 mapped to page members,
> but I have not seen any driver/fs using folio->lru for their internal
> usage. (There are users of page->lru though)

The pool worked well for pages and it is possible that the ->lru has
different semantics that do not apply the same for folios. With the
support for large folios and bs < ps the pool lost its appeal.

> [REMOVAL]
> Personally I'm not a huge fan of maintaining a local folio list just for
> compression.
> 
> I believe MM has seen much more pressure and can still properly give us
> folios/pages.
> I do not think we are doing it better than MM, so let's just use regular
> folio allocation instead.

While in principle we should not try to be smarter than the allocator
there's a still a difference when we don't have to use it at all when
there's memory pressure that wants to write out data. The allocation is
a place where it can stall or increase the pressure on the rest of the
system.

When we cycle through a few pages in the pool we can write lots of data.
Returning pages to allocator does not guarantee we'll get them back.
Placing that just to the compression path was an exception because there
should ideally be no allocation required on the writeout path. As
there's no generic layer that would do that transparently it's btrfs
being nice at a small cost of a few pages.

So I stand by the reason of the pool but with the evolution of folios
and bs < ps the cost could be too high. I can still see the pool for a
subset of the combinations for some common scenario like 4K block size
on 64K page host (e.g. ARM).

> And hopefully this will address David's recent crash (as usual I'm not
> able to reproduce locally).

I'll run the test with this patch.

