Return-Path: <linux-btrfs+bounces-8653-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFBF9955A2
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 19:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE060286703
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 17:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AAD1FA27E;
	Tue,  8 Oct 2024 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N4aImclo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rDtuvCsn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WdhnIYDz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3Q9XEn3S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC6D1F9A9F
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2024 17:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728408590; cv=none; b=WXnPYLacxNVJs+ZH01Q58YASEEIMABxvqBo7DXZSD+Luu14uGCvkutfgUgaHk8LNKiOyHoHXEMmYOHTKQDyzU8WWlskkBlmnDoeJ3P7zkArNYoI7A38jwex1vZZD3mDlMdq88AhLNT+F/Mgju3nqLpor4BkC7+hWpVe7ZD3UTNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728408590; c=relaxed/simple;
	bh=voAIN3swvbIlF6O0Z3bNQ/eLwwM+n/MwOikd6ULRtLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9Y/8EWBld9DDhCiCz6ehFj9FaGgMawisO2Y8lY+tX0w5wV0qqKCUekV55bUzh90oDPeaq1aEIcD4lVbso3d+Gc2B8zR/h2b6aRahkBittJtWoq1T/zhUTC15fdY1euJspIa0IGxdkTwzYVNUffkUIB7CbZF2AzOjC2/1QKdhQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N4aImclo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rDtuvCsn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WdhnIYDz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3Q9XEn3S; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2B9C921CDF;
	Tue,  8 Oct 2024 17:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728408587;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ea1VJoiO3DiBT05z8YV8916KFTrO54KXjKb6rfRHL7E=;
	b=N4aImclozdmSHmG5HSC1FV5rdvGJ7zM7zNPxBT6IWbTnC2mQ1NMPJfRFGTMnf3IRFo1B4o
	d6cDcXpOOgisW7tGLCvVRmFo4ljx7dQ9GAt5s2c9br4wT6peIVqSXy0mzG4gkoUmNW9Q9T
	xnVeDNpvzJ1+hu0VNXM9TKbGew1lGB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728408587;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ea1VJoiO3DiBT05z8YV8916KFTrO54KXjKb6rfRHL7E=;
	b=rDtuvCsnC1TaY+X105cPFc8+ByybJEpZ9ZmB3gfA4aL+1kvrfw2LdX8KVKI+jX+bTsWpBb
	y1n096Fu0SrywJDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WdhnIYDz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3Q9XEn3S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728408586;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ea1VJoiO3DiBT05z8YV8916KFTrO54KXjKb6rfRHL7E=;
	b=WdhnIYDzd/pfZxk4GBDE49KOhpQTjvheWzPQsdYTjatvSkt8rcb7aPL80af7i+kkonzSuz
	o/SzHwpaVs7nDypByfc2WJZthpGp5sVUUOg/fGyCrXr9t0rk5O1pJmSMKdzZBkLZ3VGJkG
	mlW9dzeI8iwuNRSloR+Q5VC1T5mqUAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728408586;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ea1VJoiO3DiBT05z8YV8916KFTrO54KXjKb6rfRHL7E=;
	b=3Q9XEn3SfiGUNJNIyGzD0pIhSjrLsXHnpuesfyWzqBClvzI9u4SVP5jyNTX9joVkZDenOT
	+lp7wUFbq0IkdWCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11EAF137CF;
	Tue,  8 Oct 2024 17:29:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1orjAwpsBWcPWwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 08 Oct 2024 17:29:46 +0000
Date: Tue, 8 Oct 2024 19:29:44 +0200
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 01/10] btrfs: convert BUG_ON in btrfs_reloc_cow_block to
 proper error handling
Message-ID: <20241008172944.GH1609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1727970062.git.josef@toxicpanda.com>
 <8f6d53a745813c8267a20b1dc1caa4fb722423bb.1727970062.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f6d53a745813c8267a20b1dc1caa4fb722423bb.1727970062.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 2B9C921CDF
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
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
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Thu, Oct 03, 2024 at 11:43:03AM -0400, Josef Bacik wrote:
> This BUG_ON is meant to catch backref cache problems, but these can
> arise from either bugs in the backref cache or corruption in the extent
> tree.  Fix it to be a proper error and change it to an ASSERT() so that
> developers notice problems.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/relocation.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index f3834f8d26b4..3c89e79d0259 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -4399,8 +4399,20 @@ int btrfs_reloc_cow_block(struct btrfs_trans_handle *trans,
>  		WARN_ON(!first_cow && level == 0);
>  
>  		node = rc->backref_cache.path[level];
> -		BUG_ON(node->bytenr != buf->start &&
> -		       node->new_bytenr != buf->start);
> +
> +		/*
> +		 * If node->bytenr != buf->start and node->new_bytenr !=
> +		 * buf->start then we've got the wrong backref node for what we
> +		 * expected to see here and the cache is incorrect.
> +		 */
> +		if (node->bytenr != buf->start &&
> +		    node->new_bytenr != buf->start) {
> +			btrfs_err(fs_info,
> +"bytenr %llu was found but our backref cache was expecting %llu or %llu",
> +				  buf->start, node->bytenr, node->new_bytenr);
> +			ASSERT(0);

Please don't add the assert(0), the error message and EUCLEAN should be
sufficient. The caller btrfs_force_cow_block() aborts if it fails so
this will be noticealbe. Syzbot is good at hitting strange assertions so
we'll eventually get a report and have to fix it by removing the
assert(0) again.

