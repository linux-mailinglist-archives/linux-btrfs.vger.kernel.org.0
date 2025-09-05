Return-Path: <linux-btrfs+bounces-16679-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E687B46034
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 19:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D77A60E71
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Sep 2025 17:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D7B34F482;
	Fri,  5 Sep 2025 17:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HiWMCiPh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ynefy9NU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HiWMCiPh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ynefy9NU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0559D306B1C
	for <linux-btrfs@vger.kernel.org>; Fri,  5 Sep 2025 17:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757093604; cv=none; b=jIPw7GrAfGIFO/yGlENU+P+KqVit7zblAuGc3xf773S+I7x+LzJVU6IYBXxcTUQ3EYXRJSs6DLCgHRhSxgleCWGWg5ZGiXg+MHAX5ZoW7tPJbSzSJpBAaUjBJJTZPtNaseh5VGlFxVso7l4E9cEJ3rqMScQ0HSGUxnKh7i1+o5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757093604; c=relaxed/simple;
	bh=vGAwwWs8lcW13LYr7V+w6gP7qD8LXv/bLpc+xsg53c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTdSPNlroOaZs9RC/tMjwrgxOS7upNe1M4ODPrcU3yEmPnbWziaH7kz8PfJWYlN+/PCq0QcoYABtSyJJ9pDykbt/Cjli1DqN+8ymx6G3ZEpErgwjiQPkngU5WUxjgbt5VdUjfrk25K1P8jK17g48f06WX+8zJUmAn5WR5TBhZBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HiWMCiPh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ynefy9NU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HiWMCiPh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ynefy9NU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6F9705CACD;
	Fri,  5 Sep 2025 17:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757093600;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zjaTPK3734zpWDtyywYbI5KbTqckZMAwyyDVDcQpsOA=;
	b=HiWMCiPhJPRSr9bS+PmRn7tenxk64FQ7g/LrToSlylLhFiwDv21TTZ9JVvjUN1n5zRxAbv
	vftCl7OP7H6WzMXWp6rKhq1pTO8TynRfJLerDBODiys9cPrYfqlQuW5S6QremZEPTxMu+z
	FGERiUBh3T0Bo26EhGKPRaNpIEg+PEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757093600;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zjaTPK3734zpWDtyywYbI5KbTqckZMAwyyDVDcQpsOA=;
	b=ynefy9NUJ2BQX9UNHvWR1NQNjNjWqydk1pb+Ek38F+FglzunPgpX4BmaRwiZFCIVh3aT6L
	5DKZdcMUnXPBTXBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757093600;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zjaTPK3734zpWDtyywYbI5KbTqckZMAwyyDVDcQpsOA=;
	b=HiWMCiPhJPRSr9bS+PmRn7tenxk64FQ7g/LrToSlylLhFiwDv21TTZ9JVvjUN1n5zRxAbv
	vftCl7OP7H6WzMXWp6rKhq1pTO8TynRfJLerDBODiys9cPrYfqlQuW5S6QremZEPTxMu+z
	FGERiUBh3T0Bo26EhGKPRaNpIEg+PEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757093600;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zjaTPK3734zpWDtyywYbI5KbTqckZMAwyyDVDcQpsOA=;
	b=ynefy9NUJ2BQX9UNHvWR1NQNjNjWqydk1pb+Ek38F+FglzunPgpX4BmaRwiZFCIVh3aT6L
	5DKZdcMUnXPBTXBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 587FC13306;
	Fri,  5 Sep 2025 17:33:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fd5rFeAeu2hcPAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 05 Sep 2025 17:33:20 +0000
Date: Fri, 5 Sep 2025 19:33:19 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 4/5] btrfs: introduce btrfs_bio_for_each_block_all()
 helper
Message-ID: <20250905173319.GP5333@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1756803640.git.wqu@suse.com>
 <85543e15b7440b4d7b8f88d1e5384a0b2dafa693.1756803640.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85543e15b7440b4d7b8f88d1e5384a0b2dafa693.1756803640.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.00

On Tue, Sep 02, 2025 at 06:32:15PM +0930, Qu Wenruo wrote:
> Currently if we want to iterate all blocks inside a bio, we do something
> like this:
> 
> 	bio_for_each_segment_all(bvec, bio, iter_all) {
> 		for (off = 0; off < bvec->bv_len; off += sectorsize) {
> 			/* Iterate blocks using bv + off */
> 		}
> 	}
> 
> That's fine for now, but it will not handle future bs > ps, as
> bio_for_each_segment_all() is a single-page iterator, it will always
> return a bvec that's no larger than a page.
> 
> But for bs > ps cases, we need a full folio (which covers at least one
> block) so that we can work on the block.
> 
> To address this problem and handle future bs > ps cases better:
> 
> - Introduce a helper btrfs_bio_for_each_block_all()
>   This helper will create a local bvec_iter, which has the size of the
>   target bio. Then grab the current physical address of the current
>   location, then advance the iterator by block size.
> 
> - Use btrfs_bio_for_each_block_all() to replace existing call sites
>   Including:
> 
>   * set_bio_pages_uptodate() in raid56
>   * verify_bio_data_sectors() in raid56
> 
>   Both will result much easier to read code.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/misc.h   | 24 +++++++++++++++++++++++
>  fs/btrfs/raid56.c | 49 +++++++++++++++++++----------------------------
>  2 files changed, 44 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
> index f210f808311f..2352ab56dbb3 100644
> --- a/fs/btrfs/misc.h
> +++ b/fs/btrfs/misc.h
> @@ -45,6 +45,30 @@ static inline phys_addr_t bio_iter_phys(struct bio *bio, struct bvec_iter *iter)
>  	     (paddr = bio_iter_phys((bio), (iter)), 1);			\
>  	     bio_advance_iter_single((bio), (iter), (blocksize)))
>  
> +/* Helper to initialize a bvec_iter to the size of the specified bio. */

Please drop 'Helper to ...'

> +static inline struct bvec_iter init_bvec_iter_for_bio(struct bio *bio)
> +{
> +	struct bio_vec *bvec;
> +	u32 bio_size = 0;
> +	int i;
> +
> +	bio_for_each_bvec_all(bvec, bio, i)
> +		bio_size += bvec->bv_len;
> +
> +	return (struct bvec_iter) {
> +		.bi_sector = 0,
> +		.bi_size = bio_size,
> +		.bi_idx = 0,
> +		.bi_bvec_done = 0,
> +	};

We don't use this kind of initializers, usually the structure is passed
as parameter, but I can see how it makes it convenient in the for()
initialization. The parameter way would work but would also look strange
so I think it's acceptable.

> +}
> +
> +#define btrfs_bio_for_each_block_all(paddr, bio, blocksize)		\
> +	for (struct bvec_iter iter = init_bvec_iter_for_bio(bio);	\
> +	     (iter).bi_size &&						\
> +	     (paddr = bio_iter_phys((bio), &(iter)), 1);		\
> +	     bio_advance_iter_single((bio), &(iter), (blocksize)))
> +
>  static inline void cond_wake_up(struct wait_queue_head *wq)
>  {
>  	/*

