Return-Path: <linux-btrfs+bounces-12777-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EA9A7AFC4
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Apr 2025 23:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 811F57A76B8
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Apr 2025 20:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF11B268684;
	Thu,  3 Apr 2025 19:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t6e8Xe/B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IsN/UrDW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t6e8Xe/B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IsN/UrDW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D08267F6D
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Apr 2025 19:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743710220; cv=none; b=e0J+FSnRWaoRyRHISO5dic+v/Ay40irnD0jlbrQu6ZS5e8cpTizfjXqDBoTiDGaOy0HzozwEeVA+6meMX7bTMQfeQI0jI3RRAOuii2wU3gccKHhHa9WTQemmjcG4dDUk41Wlxl/NWLag5ydw7cfW55A76YxSxiAXo1b9gvNRizU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743710220; c=relaxed/simple;
	bh=qQGmRC6D+VoC2kcwgrY+dV8C7UvcqpZeaTFzU5O7w7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7Lsih98rK7DCO9x/D9tQe9SVIGrG2eQAmfktuL1ocMJPjBxl6+7Gio83TtpcJevrZ9P6Lu9fbhNq3R8riLg2mJ/UrFEdJvD3oKilyDBm45R7nR/krvQu54kbFhDbSBTS9xsSeyQBb1o7bKgIy0YGTljD+uQx9UoMRAHCBiuS2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t6e8Xe/B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IsN/UrDW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t6e8Xe/B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IsN/UrDW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7E9D221134;
	Thu,  3 Apr 2025 19:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743710216;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oCNEy7LgswGZCKPXBzjw/L6x2HhVxIPH6cdAg61kRvo=;
	b=t6e8Xe/BApI4G/ielYe9Dgq/WgeW/67SSA7SmtuxTtg99OiycuPhVkTRYfUodoZaI471g4
	BzJWIptnFxJzqH+vCed9uU7QkFfWPavcEK73u0bwWAQPB8zRy8IOOdHcaX2eXD/MAMo0ff
	slvkpGRj0Ef2AkldS4luBs0zO7ARxyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743710216;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oCNEy7LgswGZCKPXBzjw/L6x2HhVxIPH6cdAg61kRvo=;
	b=IsN/UrDWhCbPDNV2OqhMTyVIbdOoyhEiXk1M4Nugv1IMnhUprK88HeaMraZNprz/wzPkSA
	Ralj6eW/aqbgwgCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743710216;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oCNEy7LgswGZCKPXBzjw/L6x2HhVxIPH6cdAg61kRvo=;
	b=t6e8Xe/BApI4G/ielYe9Dgq/WgeW/67SSA7SmtuxTtg99OiycuPhVkTRYfUodoZaI471g4
	BzJWIptnFxJzqH+vCed9uU7QkFfWPavcEK73u0bwWAQPB8zRy8IOOdHcaX2eXD/MAMo0ff
	slvkpGRj0Ef2AkldS4luBs0zO7ARxyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743710216;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oCNEy7LgswGZCKPXBzjw/L6x2HhVxIPH6cdAg61kRvo=;
	b=IsN/UrDWhCbPDNV2OqhMTyVIbdOoyhEiXk1M4Nugv1IMnhUprK88HeaMraZNprz/wzPkSA
	Ralj6eW/aqbgwgCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 669B713A2C;
	Thu,  3 Apr 2025 19:56:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AG3TGAjo7meSNgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 03 Apr 2025 19:56:56 +0000
Date: Thu, 3 Apr 2025 21:56:51 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 8/9] btrfs: prepare btrfs_end_repair_bio() for larger
 data folios
Message-ID: <20250403195651.GU32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1742195085.git.wqu@suse.com>
 <8203647f525da730826857afe87cd673f1e42074.1742195085.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8203647f525da730826857afe87cd673f1e42074.1742195085.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Mon, Mar 17, 2025 at 05:40:53PM +1030, Qu Wenruo wrote:
> The function btrfs_end_repair_bio() has an ASSERT() making sure the
> folio is page sized.
> 
> The reason is mostly related to the fact that later we pass a folio and
> its offset into btrfs_repair_io_failure().
> If we have larger folios passed in, later calculation of the folio and
> its offset can go wrong, as we have extra offset to the bv_page.
> 
> Change the behavior by:
> 
> - Doing a proper folio grab
>   Instead of just page_folio(bv_page), we should get the real page (as the
>   bv_offset can be larger than page size), then call page_folio().
> 
> - Do extra folio offset calculation
>   We can have the following cases of a bio_vec (this bv is moved
>   forward by btrfs read verification):
> 
>   bv_page             bv_offset
>   |                   |
>   | | | | | | | | | | | | | | | | |
>   |<-  folio_a  ->|<-  folio_b  ->|
> 
>   | | = a page.
> 
> In above case, the real folio should be folio_b, and offset inside that
> folio should be:
> 
>   bv_offset - ((&folio_b->page - &folio_a->page) << PAGE_SHIFT).
> 
> With these changes, now btrfs_end_repair_bio() is able to handle larger
> folios properly.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/bio.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 8c2eee1f1878..292c79e0855f 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -156,6 +156,25 @@ static void btrfs_repair_done(struct btrfs_failed_bio *fbio)
>  	}
>  }
>  
> +static struct folio *bio_vec_get_folio(const struct bio_vec *bv)
> +{
> +	return page_folio(bv->bv_page + (bv->bv_offset >> PAGE_SHIFT));
> +}
> +
> +static unsigned long bio_vec_get_folio_offset(const struct bio_vec *bv)
> +{
> +	struct folio *folio = bio_vec_get_folio(bv);
> +
> +	/*
> +	 * There can be multiple physically contiguous folios queued
> +	 * into the bio_vec.
> +	 * Thus the first page of our folio should be at or beyond
> +	 * the first page of the bio_vec.
> +	 */
> +	ASSERT(&folio->page >= bv->bv_page);
> +	return bv->bv_offset - ((&folio->page - bv->bv_page) << PAGE_SHIFT);

This looks like it should be a generic helper, the expression looks
quite magic.

