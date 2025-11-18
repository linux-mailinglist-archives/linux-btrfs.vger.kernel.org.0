Return-Path: <linux-btrfs+bounces-19086-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (unknown [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EE6C6A495
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 16:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 408714F646A
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 15:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C95035C196;
	Tue, 18 Nov 2025 15:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NMj3QcOg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="624xN6rQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NMj3QcOg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="624xN6rQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C2A324B26
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Nov 2025 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763478943; cv=none; b=lUPskOWFpdVh1RDqdruRMErCVPSejE9x2krhBVyX6WisbvtQqewpW2u3TTNpTg8FCfqyY8zy8V9vY0iICJYnSrlLYWyZoT4LeEstKcavnjGifBmYoqQnxv58ACjKp8+CR516NjKP1wKklS8rnBUOZjkBxErP8OctkfHC9TZavZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763478943; c=relaxed/simple;
	bh=nxOPQDH1zBbqAJw1m9WkxIbgR514SK71m8wIW2+tYtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/D1kDLgp6Si9/kpwRvx1FQtvzWmpRTzCSHCPBZrVBo8UxOUs30LQyIPQ6dyD0JJS7h6+BwF+E0XFooOPYtlqdMR0UXYGtxP0R0Nv2Lj5aIfadOkUprgx6OpySCP50qLSl/qGv6JxM/s2DBlJ3SGOxQQAYhrUPvb/L7C9Gqked0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NMj3QcOg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=624xN6rQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NMj3QcOg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=624xN6rQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 512E021172;
	Tue, 18 Nov 2025 15:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763478939;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f1DeqlplL02d8xqsrhUEtQNcbhxPn8dPZSK35t5W7Qs=;
	b=NMj3QcOgySGCwJZw1cgjEP1IuC1gG4a26lX++Qu9s9thLVtXSkUCGaZysOA9nPY84BNdvA
	X2fhjmJMk44jFsWqK3NTmCOAvRgtnXgSAik0P9kEYY73u6UiM48Aijqwv4YiQeQwfx8B/t
	wTv9fO9TJbQj+gZ/at5PUFasoQ82J6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763478939;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f1DeqlplL02d8xqsrhUEtQNcbhxPn8dPZSK35t5W7Qs=;
	b=624xN6rQxbqXB3gNobHL7YcYdTZOUeJKaZSKversFkv5ONnIxXW785O+t3nOY28pC560XC
	0GGFAoEsD3xtxpDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=NMj3QcOg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=624xN6rQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763478939;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f1DeqlplL02d8xqsrhUEtQNcbhxPn8dPZSK35t5W7Qs=;
	b=NMj3QcOgySGCwJZw1cgjEP1IuC1gG4a26lX++Qu9s9thLVtXSkUCGaZysOA9nPY84BNdvA
	X2fhjmJMk44jFsWqK3NTmCOAvRgtnXgSAik0P9kEYY73u6UiM48Aijqwv4YiQeQwfx8B/t
	wTv9fO9TJbQj+gZ/at5PUFasoQ82J6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763478939;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f1DeqlplL02d8xqsrhUEtQNcbhxPn8dPZSK35t5W7Qs=;
	b=624xN6rQxbqXB3gNobHL7YcYdTZOUeJKaZSKversFkv5ONnIxXW785O+t3nOY28pC560XC
	0GGFAoEsD3xtxpDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 251893EA61;
	Tue, 18 Nov 2025 15:15:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id m7DfCJuNHGkbLgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 18 Nov 2025 15:15:39 +0000
Date: Tue, 18 Nov 2025 16:15:33 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 00/12] btrfs: add raid56 support for bs > ps cases
Message-ID: <20251118151533.GX13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1763361991.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1763361991.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 512E021172
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,twin.jikos.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 

On Mon, Nov 17, 2025 at 06:00:40PM +1030, Qu Wenruo wrote:
> [OVERVIEW]
> This series add the missing raid56 support for the experimental bs > ps
> support.

Please add it to for-next, it's coveredby experimental config is any
eventual bugs can be dealt with safely. Thanks.

> The main challenge here is the conflicts between RAID56 RMW/recovery and
> data checksum.
> 
> For RAID56 RMW/recovery, the vertical stripe can only be mapped one page
> one time, as the upper layer can pass bios that are not backed by large
> folios (direct IO, encoded read/write/send).
> 
> On the other hand, data checksum requires multiple pages at the same
> time, e.g. btrfs_calculate_block_csum_pages().
> 
> To meet both requirements, introduce a new unit, step, which is
> min(PAGE_SIZE, sectorsize), and make the paddrs[] arrays in RAID56 to be
> in step sizes.
> 
> So for vertical stripe related works, reduce the map size from
> one sector to one step. For data checksum verification grab the pointer
> from involved paddrs[] array and pass the sub-array into
> btrfs_calculate_block_csum_pages().
> 
> So before the patchset, the btrfs_raid_bio paddr pointers looks like
> this:
> 
>   16K page size, 4K fs block size (aka, subpage case)
> 
>                        0                   16K  ...
>   stripe_pages[]:      |                   |    ...
>   stripe_paddrs[]:     0    1    2    3    4    ...
>   fs blocks            |<-->|<-->|<-->|<-->|    ...
> 
>   There are at least one fs block (sector) inside a page, and each
>   paddrs[] entry represents an fs block 1:1.
> 
> To the new structure for bs > ps support:
> 
>   4K page size, 8K fs block size
> 
>                        0    4k   8K   12K   16K  ...
>   stripe_pages[]:      |    |    |    |    |     ...
>   stripe_paddrs[]:     0    1    2    3    4     ...
>   fs blocks            |<------->|<------->|     ...
> 
>   Now paddrs[] entry is no longer 1:1 mapped to an fs block, but
>   multiple paddrs mapped to one fs block.
> 
> The glue unit between paddrs[] and fs blocks is a step.
> 
> One fs blocks can one or more steps, and one step maps to a paddr[]
> entry 1:1.
> 
> For bs <= ps cases, one step is the same as an fs block.
> For bs > ps case, one step is just a page.
> 
> For RAID56, now we need one extra step iteration loop when handling an
> fs block.
> 
> [TESTING]
> I have tested the following combinations:
> 
> - bs=4k ps=4k x86_64
> - bs=4k ps=64k arm64
>   The base line to ensure no regression caused by this patchset for bs
>   == ps and bs < ps cases.
> 
> - bs=8k ps=4k x86_64
>   The new run for this series.
> 
>   The only new failure is related to direct IO read verification, which
>   is a known one caused by no direct IO support for bs > ps cases.
> 
> I'm afraid in the long run, the combination matrix will be larger than
> larger, and I'm not sure if my environment can handle all the extra bs/ps
> combinations.
> 
> The long term plan is to test bs=4k ps=4k, bs=4k ps=64k, bs=8k ps=4k
> cases only.

Yes the number of combinations increases, I'd recommend to test those
that make sense. The idea is to match what could on one side exist as a
native combination and could be used on another host where it would have
to be emulated by the bs>ps code. E.g. 16K page and sectorsize on ARM
and then used on x86_64. The other size to consider is 64K, e.g. on
powerpc.

In your list the bs=8K and ps=4K exercises the code but the only harware
taht may still be in use (I know of) and has 8K pages is SPARC. I'd
rather pick numbers that still have some contemporary hardware relevance.

> [PATCHSET LAYOUT]
> Patch 1 introduces an overview of how btrfs_raid_bio structure
> works.
> Patch 2~10 starts converting t he existing infrastructures to use the
> new step based paddr pointers.
> Patch 11 enables RAID56 for bs > ps cases, which is still an
> experimental feature.
> The last patch removes the "_step" infix which is used as a temporary
> naming during the work.
> 
> [ROADMAP FOR BS > PS SUPPORT]
> The remaining feature not yet implemented for bs > ps cases is direct
> IO. The needed patch in iomap is submitted through VFS/iomap tree, and
> the btrfs part is a very tiny patch, will be submitted during v6.19
> cycle.

Sounds good.

