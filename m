Return-Path: <linux-btrfs+bounces-13665-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB78AA9AED
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 19:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF7DA7A20BF
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 May 2025 17:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A241526D4C8;
	Mon,  5 May 2025 17:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ODEHEJ9H";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6effQBuR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ODEHEJ9H";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6effQBuR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4161B25D8FB
	for <linux-btrfs@vger.kernel.org>; Mon,  5 May 2025 17:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746466980; cv=none; b=fK9l/iUQof8ZraZVNh8QaLkXuYhPAVzrhbwINzwQCOjc7SCB9Kg0klMbkFokbPx+se6zmNvhr8fYd+zG8+yBhtmWu92hndB7x54/MBQhEptOd73P7qYDqqPiGG/rJDgYnC97atPH8zWUG9CyX76NpuLIzJQaCa/MYR+YLNHPue8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746466980; c=relaxed/simple;
	bh=g/8c0RVVTE8OipwYQRCotP0a360wpZ2DIxPYs27figo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kivwL+EpNqmwYj8sNeFjf7PydzwFv7nzLDjnNuUT4pyFEF5EQCI8y5LTCFJBbpPD9VCLyhZmGhWW1ydFJm+fQA8uvCKX2XBHMEZjYWw0VlMRPcriYhtHylGqkAC0NLYM+fSvXTzyqfkllldyPvfm6qSQhpKWZ2OZXVcAbFJe4YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ODEHEJ9H; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6effQBuR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ODEHEJ9H; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6effQBuR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4EDFA1F78F;
	Mon,  5 May 2025 17:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746466977;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ULS73cnEP6j+OpmY2EYJ/JHRI9bJwOZt19ZgRtI64L8=;
	b=ODEHEJ9HU4c0tqH62cVH+FDtbrsOS1Z1BXpSYizVJUglPv/ImRxfWVv+W+g2eebecjxgOw
	Ae0Yr3w1uaSwgoCqBtDSAAYKUdSq5aWFstCOM4KET6TPh0x6e/tXqYfVJihwedZbe+Sbig
	j7n5xeM0VO9H8Aa3n0Wsj4JvXPV3w7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746466977;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ULS73cnEP6j+OpmY2EYJ/JHRI9bJwOZt19ZgRtI64L8=;
	b=6effQBuRijCKUwTTldqFTL69cUpG+KkB0Kj3bFFY+KT/bA9ZniGh01+jVd4CofXVtqkGTs
	Dcemp2dAKisaeXDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746466977;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ULS73cnEP6j+OpmY2EYJ/JHRI9bJwOZt19ZgRtI64L8=;
	b=ODEHEJ9HU4c0tqH62cVH+FDtbrsOS1Z1BXpSYizVJUglPv/ImRxfWVv+W+g2eebecjxgOw
	Ae0Yr3w1uaSwgoCqBtDSAAYKUdSq5aWFstCOM4KET6TPh0x6e/tXqYfVJihwedZbe+Sbig
	j7n5xeM0VO9H8Aa3n0Wsj4JvXPV3w7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746466977;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ULS73cnEP6j+OpmY2EYJ/JHRI9bJwOZt19ZgRtI64L8=;
	b=6effQBuRijCKUwTTldqFTL69cUpG+KkB0Kj3bFFY+KT/bA9ZniGh01+jVd4CofXVtqkGTs
	Dcemp2dAKisaeXDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36C6713883;
	Mon,  5 May 2025 17:42:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 64cmDaH4GGg7BAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 05 May 2025 17:42:57 +0000
Date: Mon, 5 May 2025 19:42:56 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: scrub: aggregate small bitmaps into a larger
 one
Message-ID: <20250505174255.GZ9140@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1746442395.git.wqu@suse.com>
 <91cb3f7e3e3b59df0b7cb450021a33d2e5be71a9.1746442395.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91cb3f7e3e3b59df0b7cb450021a33d2e5be71a9.1746442395.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-8.00 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -8.00
X-Spam-Flag: NO

On Mon, May 05, 2025 at 08:31:04PM +0930, Qu Wenruo wrote:
> Currently we have several small bitmaps inside scrub_stripe:
> 
> - extent_sector_bitmap
> - error_bitmap
> - io_error_bitmap
> - csum_error_bitmap
> - meta_error_bitmap
> - meta_gen_error_bitmap
> 
> All those bitmaps are at most 16 bits long, but unsigned long is
> either 32 or 64 (more common) bits.
> 
> This means we're wasting 1/2 or 3/4 space for each bitmap.
> 
> And we can have 128 scrub_stripe for each device, such wasted space adds up
> quickly.
> 
> Instead of using a single unsigned long for each bitmap, aggregate them
> into a larger bitmap, just like what we're doing for subpage support.
> 
> This reduces 24 bytes from each scrub_stripe structure on x86_64
> systems.
> 
> This will need a lot of macros converting direct bitmap/bit operations into
> our scrub_stripe specific helpers, but all those helpers are very small
> and can be inlined.
> 
> So overall the overhead shouldn't be that huge, and we save quite some
> memory space.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

> +static inline unsigned int scrub_bitmap_empty_##name(struct scrub_stripe *stripe) \

The type should be bool so it matches bitmap_empty()

> +{									\
> +	unsigned long bitmap = scrub_bitmap_read_##name(stripe);	\
> +									\
> +	return bitmap_empty(&bitmap, stripe->nr_sectors);		\
> +}									\

> -					      stripe->nr_sectors);
> -	errors.nr_meta_errors = bitmap_weight(&stripe->meta_gen_error_bitmap,
> -					      stripe->nr_sectors);
> +	errors.init_error_bitmap = scrub_bitmap_read_error(stripe);
> +	errors.nr_io_errors = scrub_bitmap_weight_io_error(stripe);
> +	errors.nr_csum_errors = scrub_bitmap_weight_csum_error(stripe);
> +	errors.nr_meta_errors = scrub_bitmap_weight_meta_error(stripe);
> +	errors.nr_meta_gen_errors = scrub_bitmap_weight_meta_gen_error(stripe);

This silently fixes the error I noticed in the original code and it
conflicted in the updated version in for-next, otherwise OK.

