Return-Path: <linux-btrfs+bounces-16681-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD47B460B3
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 19:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 534AE7AF6CF
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 17:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9939835CEA9;
	Fri,  5 Sep 2025 17:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AWMkZ+7G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TeS9NP7h";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AWMkZ+7G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TeS9NP7h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537F43191DB
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 17:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757094446; cv=none; b=D2YhBsrxgDSzhj1LYtfpV6kKpy74aGNMHO+tybrdKHpTWBW/dAULR35ICfpabWsJ0cJ4ayY/1eMEoIcNQs9L33FVVWmpaPCzpHp4IzT0i+VyKmm+pAtqhWgbngebLV6PcCPd/QnpKhhmfz34U6YdEKvy+RehgwSAd1HDGxy63hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757094446; c=relaxed/simple;
	bh=LlcNxukIwsbsfUmlbQ5n4oFxhNYP8Kxcuk4QCCQ0exU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0wamyZ983QSOiHv62jNngBpDR934ypGWgcCI3A5Evf0coDDUHxAEDZJrw/sYgfiFXdQt+DEJ2IR+3rhvWME6x19vMuumrheM8qSQvyn7ENEwrOvf5Gq/ieDZ/6BskIz9ktR108EPgOV2NQgtuS5negrXbElw7FLafw0x+ubYdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AWMkZ+7G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TeS9NP7h; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AWMkZ+7G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TeS9NP7h; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 197856ACAC;
	Fri,  5 Sep 2025 17:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757094442;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5on1CP6J8UtXk9LsWORXW2xFjq8wOd17rNd4metcv4A=;
	b=AWMkZ+7Gi3RvV1l+aFcbf+G/U/oRHl4SS95THNZ06HkKqwYcOxr5X80uS35jS0B/ELzViu
	X+nVm9MzYHWtVRkK3NKeu0p/NiOs4jLg4S894hzfLajzUx2aiOX1W8OxJCVbylpxuyn47I
	+SGDeKrotmyskoXYt93TA7S2EGekSeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757094442;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5on1CP6J8UtXk9LsWORXW2xFjq8wOd17rNd4metcv4A=;
	b=TeS9NP7hRn7aWI2dUE4l85LGAJx4ESUmT2v3eH9AWKGK51nwK5ObRwQjJw5QgdOzotisQF
	2FefgTWQPUKCoZBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AWMkZ+7G;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=TeS9NP7h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757094442;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5on1CP6J8UtXk9LsWORXW2xFjq8wOd17rNd4metcv4A=;
	b=AWMkZ+7Gi3RvV1l+aFcbf+G/U/oRHl4SS95THNZ06HkKqwYcOxr5X80uS35jS0B/ELzViu
	X+nVm9MzYHWtVRkK3NKeu0p/NiOs4jLg4S894hzfLajzUx2aiOX1W8OxJCVbylpxuyn47I
	+SGDeKrotmyskoXYt93TA7S2EGekSeM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757094442;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5on1CP6J8UtXk9LsWORXW2xFjq8wOd17rNd4metcv4A=;
	b=TeS9NP7hRn7aWI2dUE4l85LGAJx4ESUmT2v3eH9AWKGK51nwK5ObRwQjJw5QgdOzotisQF
	2FefgTWQPUKCoZBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB58E13306;
	Fri,  5 Sep 2025 17:47:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rNSpOCkiu2gQQAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 05 Sep 2025 17:47:21 +0000
Date: Fri, 5 Sep 2025 19:47:16 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/5] btrfs: bs > ps support preparation
Message-ID: <20250905174716.GR5333@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1756803640.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756803640.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	URIBL_BLOCKED(0.00)[suse.cz:replyto,suse.cz:dkim,twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 197856ACAC
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21

On Tue, Sep 02, 2025 at 06:32:11PM +0930, Qu Wenruo wrote:
> One of the blockage for bs > ps support is the conflicts between all the
> single-page bvec iterator/helpers (like memzero_bvec(),
> bio_for_each_segment() etc) and large folios (with highmem support).
> 
> For bs > ps support, all the folios will have a minimal order, so that
> each folio will cover at least one block. This saves the hassle of the
> fs to handle sub-block contents.
> 
> However for all those single-page bvec iterator/helpers, they can only
> handle a bvec that is no larger than a page.
> 
> To address the conflicting features, go a completely different way to
> handle a fs block:
> 
> - Use phys_addr_t to represent a block inside a bio
>   So we won't need to bother the sp bvec helpers, just pass a single
>   paddr around.
> 
> - Do proper highmem handling for checksum generation/verification
>   Now we will grab the folio from using the paddr, and make sure the
>   folio will cover at least one block starting at the paddr.
> 
>   If the folio is highmem, do proper per-page kmap_local_folio()/kunmap()
>   to handle highmem.
>   Otherwise do a full block csum calculation in one go.
> 
>   This should brings no extra overhead except the paddr->folio
>   conversion (which should be really tiny), as for systems without
>   HIGHMEM, folio_test_partial_kmap() will always return false, and the
>   HIGHMEM path will be optimized out by the compiler completely.
> 
>   Unfortunately I don't have a 32bit VM at hand to test.
> 
> - Introduce extra marcos to iterate blocks inside a bio
>   Two macros, btrfs_bio_for_each_block() which starts at the specified
>   bio_iter.
>   The other one, btrfs_bio_for_each_block_all() will go through all
>   blocks in the bio.
> 
>   Both returns a @paddr representing a block. Callers are either using
>   paddr based helper like
>   btrfs_calculate_block_csum()/btrfs_check_block_csum(), or RAID56 which
>   is already using paddr.
> 
>   For now it's only utilized by btrfs, bcachefs has a similar helper and
>   that's my inspiration.
> 
>   I hope one day it can be escalated to bio.h.
> 
> With all those preparation done, btrfs now can support basic file
> opeartions with bs > ps support, but still with quite some limits:
> 
> - No compression support
>   The compressed folios must be allocated using the minimal folio order.
>   As btrfs_calculate_block_csum() requires the minimal folio size.
> 
> - No RAID56 support
> - No scrub support
>   The same as compression, currently we're allocating the folios in page
>   size.
>   Although raid56 codes are now using the btrfs_bio_for_each_block*()
>   helpers, the underlying folio sizes still needs update.

Even with the limitations this is a good start. The changes look
reasonable, there are some minor things to consider but otherwise please
add it to for-next as you see fit. Regarding testing on 32bit it's
getting harder as the support in distros is fading out.

