Return-Path: <linux-btrfs+bounces-19868-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E310DCCD884
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 21:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A9F33021FBB
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Dec 2025 20:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1729922DFA4;
	Thu, 18 Dec 2025 20:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aQmTHyYo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PGeM23ZQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qrkBtUgX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wtYKwgSW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941F23C2F
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Dec 2025 20:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766089976; cv=none; b=NJ/h0DPmYgO2/3kCmPkfKhvuFx5CZv3212oESN3CSRpDw4k1ZZdPYw2YZUI/V6d7wN8wJhAEU6mKAjKbhSXhvvt6iZRtb4yTFQViU0US44KIgKJciDgyboiLXqT/TMDBkOzWu23PMpWQH11oM0kcAQwsY4e4u+wnos5RXBG4SJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766089976; c=relaxed/simple;
	bh=z6BPpAV2UQWJW5z7XdJJz2hcjn7v5TUhWKuPVl+BPRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHo1b4XzIMrferyWAmRCMWEp+H2yxcgE/8+8bObAd5EdYgXFzjfBRHCMNSKf6t5ldjJ9Rv5iin7vdbG+9ZA8N+RBj92y+p/j3sbzozj4gY3L5gDqkrTS/RX9KjTHaxhVHwsgw1Iw8G8td0apmDgdSW388edNXMJh5Tn6C4JTaHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aQmTHyYo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PGeM23ZQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qrkBtUgX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wtYKwgSW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 688A95BE46;
	Thu, 18 Dec 2025 20:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766089972;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1rYUR9wK0KE/9OIBpRm2ctR2BagnRG2h27AprVBp3H0=;
	b=aQmTHyYo7Bgn9m49ibQ3tTm6sVDzwwkD6D8crpEt/7lBbQzLwZsDRB5bwb6ZVQ9gBaRx9b
	XfR0764LzhvPehs1f/j+EJ2vmI/VbKVhPciUHPNpoCJxNAqvpcQtvlkYjfscaTuXjFztJR
	yHh/0REBF1BrZFmc8HTgL9tTxMNUb/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766089972;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1rYUR9wK0KE/9OIBpRm2ctR2BagnRG2h27AprVBp3H0=;
	b=PGeM23ZQ4KsmzRH6bZ/3HOyEsl0Y8pxPpBiGc4AdRAa7TlovMwUPEpW1cg+gsDbIawHOHV
	7hTkgRil4AtNlLBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qrkBtUgX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wtYKwgSW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1766089970;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1rYUR9wK0KE/9OIBpRm2ctR2BagnRG2h27AprVBp3H0=;
	b=qrkBtUgXjEdDFMd+BMMjjkcYbeacH5+PMjeFxmbK/6c3deucreT+Cflkoo8MEASXNrIbM1
	965jazBLTGSybb7nDqzpSqNAtPz/+vZdNuDt0aEbo+U3BLp4wZ4FRdZPkJK0OhWH6D9W9M
	ToebuDIb614pdfiFqO+EFHkqZQ3rYGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1766089970;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1rYUR9wK0KE/9OIBpRm2ctR2BagnRG2h27AprVBp3H0=;
	b=wtYKwgSWqE3Yrwq/xyO7CeCVANIPDGCxEOfe+K53mBccLWI8d19E7M9+sowe7GqPZMPmri
	5qmUT5/A8CiJeZCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B3F73EA63;
	Thu, 18 Dec 2025 20:32:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C4fOEfJkRGmQWwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 18 Dec 2025 20:32:50 +0000
Date: Thu, 18 Dec 2025 21:32:45 +0100
From: David Sterba <dsterba@suse.cz>
To: Zhen Ni <zhen.ni@easystack.cn>
Cc: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove unreachable return after
 btrfs_backref_panic
Message-ID: <20251218203244.GT3195@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251218033037.983058-1-zhen.ni@easystack.cn>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218033037.983058-1-zhen.ni@easystack.cn>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,twin.jikos.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 688A95BE46
X-Spam-Flag: NO
X-Spam-Score: -4.21

On Thu, Dec 18, 2025 at 11:30:37AM +0800, Zhen Ni wrote:
> The return statement after btrfs_backref_panic() is unreachable since
> btrfs_backref_panic() calls BUG() which never returns. Removes the
> dead code.
> 
> Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
> ---
>  fs/btrfs/backref.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index 78da47a3d00e..9bb406f7dd30 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -3609,10 +3609,8 @@ int btrfs_backref_finish_upper_links(struct btrfs_backref_cache *cache,
>  		}
>  
>  		rb_node = rb_simple_insert(&cache->rb_root, &upper->simple_node);
> -		if (unlikely(rb_node)) {
> +		if (unlikely(rb_node))
>  			btrfs_backref_panic(cache->fs_info, upper->bytenr, -EEXIST);
> -			return -EUCLEAN;
Ok for consistency with other calls to btrfs_backref_panic(). This would
ideally be proper error handling, transaction abort etc. This code is
old and the *_panic helpers were more verbose BUG(). There's a related
option BTRFS_MOUNT_PANIC_ON_FATAL_ERROR.

Added to for-next, thanks.

