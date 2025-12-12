Return-Path: <linux-btrfs+bounces-19685-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF419CB7C29
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 04:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8064A301E21E
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 03:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818CD301480;
	Fri, 12 Dec 2025 03:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fvqRwNsJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="d07SqLMM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fvqRwNsJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="d07SqLMM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8343002DE
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Dec 2025 03:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765509981; cv=none; b=SXpYed/GqYCXuV8cAex9WoF93SP6eePHEdXujCBEX2ZL/eKfxgceub7olqsYXwjMYzydJ8ndNfLrcktAYH6hHvzpVI4UK0OGgpMIAvI0JO+K6TpXRtQ+EZUaPtWjMUW7ULjYf7bmcRglxl4weAXf6bEZUqa5QWlt8TZ/UQS6900=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765509981; c=relaxed/simple;
	bh=hzfYKcYEYoiTUQoLLlwNnBvLqhiH+IiuiTwLSDUJCkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFyKSddqQhahk9CLfMgCEtZxqk46HKDvbs2aG2T7T9qqsh4n5GMsMOHiCzYkd6jFH1+/YXxeqASBdLgU7TsOuIz+dA+oWc3+xHtJ8HzKbwT8BhWfNc7aAtYEnt/QHpJCplxgXuB0UV9JarCOwBq18/FiQXUzo3URKK149cLU9PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fvqRwNsJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=d07SqLMM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fvqRwNsJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=d07SqLMM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5E0D85BE52;
	Fri, 12 Dec 2025 03:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765509972;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MYnfc/OVbIwedZp091CgDfprO1QVNtWUZqWQctDzCpw=;
	b=fvqRwNsJe4WpjLZhsZAoN8Jo4Ngg1VLVp/meoNP9ZkN9vpIln3BOZHL86xK7Txne2pzHZx
	J7IfJCGn/qreY3aN67j8+IDt4f6Eyn0Mpc3E1ELgN6WzPyfJqpJrsnIP7Lsv+Zm6k4+w/p
	FodHjUX5EgkpG/3oTouQbqAur7vp0BU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765509972;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MYnfc/OVbIwedZp091CgDfprO1QVNtWUZqWQctDzCpw=;
	b=d07SqLMM3SKBONix851ksh8xabVaF10Lpcem5kK5LtHK9MJQf3Q+jwEstRZ8wNhzotXjxA
	efz5T0A9voBTq8BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765509972;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MYnfc/OVbIwedZp091CgDfprO1QVNtWUZqWQctDzCpw=;
	b=fvqRwNsJe4WpjLZhsZAoN8Jo4Ngg1VLVp/meoNP9ZkN9vpIln3BOZHL86xK7Txne2pzHZx
	J7IfJCGn/qreY3aN67j8+IDt4f6Eyn0Mpc3E1ELgN6WzPyfJqpJrsnIP7Lsv+Zm6k4+w/p
	FodHjUX5EgkpG/3oTouQbqAur7vp0BU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765509972;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MYnfc/OVbIwedZp091CgDfprO1QVNtWUZqWQctDzCpw=;
	b=d07SqLMM3SKBONix851ksh8xabVaF10Lpcem5kK5LtHK9MJQf3Q+jwEstRZ8wNhzotXjxA
	efz5T0A9voBTq8BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B75D3EA63;
	Fri, 12 Dec 2025 03:26:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JRI8ElSLO2mCcQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 12 Dec 2025 03:26:12 +0000
Date: Fri, 12 Dec 2025 04:26:03 +0100
From: David Sterba <dsterba@suse.cz>
To: Massimiliano Pellizzer <mpellizzer.dev@gmail.com>
Cc: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: remove dead assignment in prepare_one_folio()
Message-ID: <20251212032603.GQ4859@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251204210959.9672-1-mpellizzer.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204210959.9672-1-mpellizzer.dev@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -2.50
X-Spam-Level: 
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid,suse.com:email,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]

On Thu, Dec 04, 2025 at 10:09:59PM +0100, Massimiliano Pellizzer wrote:
> In prepare_one_folio(), ret is initialized to 0 at declaration,
> and in an error path we assign ret = 0 before jumping to the
> again label to retry the operation. However, ret is immediately
> overwritten by ret = set_folio_extent_mapped(folio) after the
> again label.
> 
> Both assignments are never observed by any code path,
> therefore they can be safely removed.

Right, if 'ret' was the loop invariant such explicit settings are good
for readability but this is not the case.

> No functional change.
> 
> Signed-off-by: Massimiliano Pellizzer <mpellizzer.dev@gmail.com>

Reviewed-by: David Sterba <dsterba@suse.com>

Added to for-next, thanks.

> ---
> v2: Remove also the initial ret = 0 assignment for consistency
> 
>  fs/btrfs/file.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 7a501e73d880..9e2c2f2cd03f 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -859,7 +859,7 @@ static noinline int prepare_one_folio(struct inode *inode, struct folio **folio_
>  	fgf_t fgp_flags = (nowait ? FGP_WRITEBEGIN | FGP_NOWAIT : FGP_WRITEBEGIN) |
>  			  fgf_set_order(write_bytes);
>  	struct folio *folio;
> -	int ret = 0;
> +	int ret;
>  
>  again:
>  	folio = __filemap_get_folio(inode->i_mapping, index, fgp_flags, mask);
> @@ -877,7 +877,6 @@ static noinline int prepare_one_folio(struct inode *inode, struct folio **folio_
>  		/* The folio is already unlocked. */
>  		folio_put(folio);
>  		if (!nowait && ret == -EAGAIN) {
> -			ret = 0;
>  			goto again;
>  		}

Minor thing fixed here, a single statement 'if' should not have the { }.

