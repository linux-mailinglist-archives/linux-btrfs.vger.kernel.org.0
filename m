Return-Path: <linux-btrfs+bounces-5508-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA7E8FF542
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 21:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B47282151
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2024 19:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9046761FE6;
	Thu,  6 Jun 2024 19:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JqegeA+I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hlxu7w4h";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JqegeA+I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hlxu7w4h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5D1446DB
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Jun 2024 19:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717702052; cv=none; b=KymF1zU4ezNaTHwMuXy5rkahw/YFZLvEgfbPQNo5Qwf9nPQ8XX1JHlIrAiA+GlOATtkaBPWR4MM98AzvdEKpyJujR7SbZR4C7KR9S4bbAu0v4oBLxiPx/pcKkIJRL4wsCQa2BWzx+9vYKOECTAbb9h9aFebl6oa+64KoMD30+1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717702052; c=relaxed/simple;
	bh=XnEtJw4NamTfKrMGA1kB2CXxpPFNxYUTQFbbA8iDkHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtB5NADV1nrseFpgRkhNFSj1OkIGBuf3ud4V/pZ3aBafl2lOggB3DaftHY+QqEk9CRpiaC3Ve+6MF4RNou2rdgNpPVtZuq1HK+UUGqJPT4+SaKOetym1F9MntTUECfHuDaJHV1CyPJdcsOHsdGaEvNZ0DuJv6MoIdmLsTTf+BAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JqegeA+I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hlxu7w4h; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JqegeA+I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hlxu7w4h; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8D36D1FB50;
	Thu,  6 Jun 2024 19:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717702048;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J9M9HmeSMn6Z9aAzsQuvZjFMFTvamzbWeg81p1QDmNE=;
	b=JqegeA+IVoBLc7kL8XBJNPLPWC5v2nTlxkMVtEIs92bWgki8OlE5jVLoZ7Lq0xJ+f4Fb0L
	ITgzKKy5FReBnR19xF6QOY917GEeaLe5u0NPhYrQ92QJI020zlStngezmAg7qfpgWYmW/V
	o6TxgTKO1MCM9NB7h+1xsWsdy00EuQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717702048;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J9M9HmeSMn6Z9aAzsQuvZjFMFTvamzbWeg81p1QDmNE=;
	b=hlxu7w4hU5X7kfW0mwCsbUjE8IJiig5s+i76YjYOrYwbAf/yZLxsNnM/cafM72mLJl0OjU
	4Mie2jsU1+hr2tBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717702048;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J9M9HmeSMn6Z9aAzsQuvZjFMFTvamzbWeg81p1QDmNE=;
	b=JqegeA+IVoBLc7kL8XBJNPLPWC5v2nTlxkMVtEIs92bWgki8OlE5jVLoZ7Lq0xJ+f4Fb0L
	ITgzKKy5FReBnR19xF6QOY917GEeaLe5u0NPhYrQ92QJI020zlStngezmAg7qfpgWYmW/V
	o6TxgTKO1MCM9NB7h+1xsWsdy00EuQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717702048;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J9M9HmeSMn6Z9aAzsQuvZjFMFTvamzbWeg81p1QDmNE=;
	b=hlxu7w4hU5X7kfW0mwCsbUjE8IJiig5s+i76YjYOrYwbAf/yZLxsNnM/cafM72mLJl0OjU
	4Mie2jsU1+hr2tBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6353413A79;
	Thu,  6 Jun 2024 19:27:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CpISGKANYmY5NwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 06 Jun 2024 19:27:28 +0000
Date: Thu, 6 Jun 2024 21:27:22 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Chris Mason <clm@fb.com>
Subject: Re: [PATCH v2] btrfs: fix a possible race window when allocating new
 extent buffers
Message-ID: <20240606192722.GF18508@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0f003d96bcb54c9c1afd5512739645bbdddb701b.1717637062.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f003d96bcb54c9c1afd5512739645bbdddb701b.1717637062.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -2.50
X-Spam-Level: 
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux-foundation.org,gmail.com,fb.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[5]

On Thu, Jun 06, 2024 at 11:01:51AM +0930, Qu Wenruo wrote:
> [BUG]
> Since v6.8 there are rare kernel crashes hitting by different reporters,
> and most of them share the same bad page status error messages like
> this:
> 
>  BUG: Bad page state in process kswapd0  pfn:d6e840
>  page: refcount:0 mapcount:0 mapping:000000007512f4f2 index:0x2796c2c7c
>  pfn:0xd6e840
>  aops:btree_aops ino:1
>  flags: 0x17ffffe0000008(uptodate|node=0|zone=2|lastcpupid=0x3fffff)
>  page_type: 0xffffffff()
>  raw: 0017ffffe0000008 dead000000000100 dead000000000122 ffff88826d0be4c0
>  raw: 00000002796c2c7c 0000000000000000 00000000ffffffff 0000000000000000
>  page dumped because: non-NULL mapping
> 
> [CAUSE]
> Commit 09e6cef19c9f ("btrfs: refactor alloc_extent_buffer() to
> allocate-then-attach method") changes the sequence when allocating a new
> extent buffer.
> 
> Previously we always call grab_extent_buffer() under
> mapping->i_private_lock, to ensure the safety on modification on
> folio::private (which is a pointer to extent buffer for regular
> sectorsize)
> 
> This can lead to the following race:
> 
> Thread A is trying to allocate an extent buffer at bytenr X, with 4
> 4K pages, meanwhile thread B is trying to release the page at X + 4K
> (the second page of the extent buffer at X).
> 
>            Thread A                |                 Thread B
> -----------------------------------+-------------------------------------
>                                    | btree_release_folio()
> 				   | | This is for the page at X + 4K,
> 				   | | Not page X.
> 				   | |
> alloc_extent_buffer()              | |- release_extent_buffer()
> |- filemap_add_folio() for the     | |  |- atomic_dec_and_test(eb->refs)
> |  page at bytenr X (the first     | |  |
> |  page).                          | |  |
> |  Which returned -EEXIST.         | |  |
> |                                  | |  |
> |- filemap_lock_folio()            | |  |
> |  Returned the first page locked. | |  |
> |                                  | |  |
> |- grab_extent_buffer()            | |  |
> |  |- atomic_inc_not_zero()        | |  |
> |  |  Returned false               | |  |
> |  |- folio_detach_private()       | |  |- folio_detach_private() for X
> |     |- folio_test_private()      | |     |- folio_test_private()
>       |  Returned true             | |     |  Returned true
>       |- folio_put()               |       |- folio_put()
> 
> Now this double puts on the same folio at folio X, leads to the
> refcount underflow of the folio X, and eventually causing the BUG_ON()
> on the page->mapping.
> 
> The condition is not that easy to hit:
> 
> - The release must be triggered for the middle page of an eb
>   If the release is on the same first page of an eb, page lock would kick
>   in and prevent the race.
> 
> - folio_detach_private() has a very small race window
>   It's only between folio_test_private() and folio_clear_private().
> 
> That's exactly what mapping->i_private_lock is used to prevent such race,
> and commit 09e6cef19c9f ("btrfs: refactor alloc_extent_buffer() to
> allocate-then-attach method") totally screwed this up.
> 
> At that time, I thought the page lock would kick in as
> filemap_release_folio() also requires the page to be locked, but forgot
> the filemap_release_folio() only locks one page, not all pages of an
> extent buffer.
> 
> [FIX]
> Move all the code requiring i_private_lock into
> attach_eb_folio_to_filemap(), so that everything is done with proper
> lock protection.
> 
> Furthermore to prevent future problems, add an extra
> lockdep_assert_locked() to ensure we're holding the proper lock.
> 
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Link: https://lore.kernel.org/linux-btrfs/CAHk-=wgt362nGfScVOOii8cgKn2LVVHeOvOA7OBwg1OwbuJQcw@mail.gmail.com/
> Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Link: https://lore.kernel.org/lkml/CABXGCsPktcHQOvKTbPaTwegMExije=Gpgci5NW=hqORo-s7diA@mail.gmail.com/
> Fixes: 09e6cef19c9f ("btrfs: refactor alloc_extent_buffer() to allocate-then-attach method")
> Cc: Chris Mason <clm@fb.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Thanks. I'll pick the patch to branch for the next pull request, the fix has
survived enough testing and we should get it to stable without further delays.
I've edited the subject and changelog a bit, the problem is really the folio
private protection, it is a race window fix but that does not tell much what is
the cause. I've also added the reproducer script from Chris.

