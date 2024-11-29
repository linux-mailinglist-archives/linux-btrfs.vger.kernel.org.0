Return-Path: <linux-btrfs+bounces-9972-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 372409DEB21
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Nov 2024 17:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FD84164DCC
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Nov 2024 16:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157961A00D6;
	Fri, 29 Nov 2024 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1D6bgAxx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bbTHKE/2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oxjWKcSZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WvbYMCEv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F84919CC02
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Nov 2024 16:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732898064; cv=none; b=ImtmndyVDC6sTIs+KA93yVA0/ZYOvt9XtpB2BRKyxs4tMzBOSUDyxrgYMb3mRipj4J3B4UiHEKuipMT4yGd8HonDOd+TBDx12Oejdvdiatnn1AzBaU7i/4wdA4/Kx6CoWp0lW8GVLpMkNlT2izCxlgdQ3wCNzcfBzpShMpGFb0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732898064; c=relaxed/simple;
	bh=acZmx1SqI042satHpOLLd9A6KJbnGM+Jh1cVWmW5FmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4fufF7eu/FdeQzezkVU0z8YTuI5MGKj5rAQWCr5GybH1vQOrkaAICUKRRkpjOctbHF/mvBO9iAHeFzl7tsPUNW07HT4NKq8zycwtGKM7Y7fSCw2l/qWjlAsbrnleZ8tYPvkac1/gQufDM4iz4Egh1A4qrbc37VVtVaTp0st770=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1D6bgAxx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bbTHKE/2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oxjWKcSZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WvbYMCEv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7BE1F1F390;
	Fri, 29 Nov 2024 16:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732898060;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JQUmz6+JC7LHFkbB0ekKGkdcpJhE1mpQPbZ58dQ9dI0=;
	b=1D6bgAxxfMg3fQt3eRh3U76ud6ojvHuhGnw7BqzCT9CIlIPCogX1MI1pkdgcIIC9nN+TSI
	5Yr//Ng6A0UuYISlo7YlX+7+B+4mh9tgAo8Dnr26e35dxwouuHNUe219qmHyKLmp4GiAAk
	t3t+VgOoPKx51pdVgwI2O/fNaRN6XbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732898060;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JQUmz6+JC7LHFkbB0ekKGkdcpJhE1mpQPbZ58dQ9dI0=;
	b=bbTHKE/2jy5TvFzHmWOSkCBxSWTKLMOGPfMplh7il3UVOqTqGE6e8es0Aluj27RmT9DV1v
	2X5ptMLAD8T/D6Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oxjWKcSZ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WvbYMCEv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732898058;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JQUmz6+JC7LHFkbB0ekKGkdcpJhE1mpQPbZ58dQ9dI0=;
	b=oxjWKcSZOk3lkHRgk9IwyWJMFhOlrnCwZkzxZ9GDbJ9byK3QGu3Z3ZZPQ2NeaeBWOvRRtz
	cGGIefvvaXthGEewSaegiCOlAqu+m1/+Aa6gpbb7Vga2+kR7Rg5tCZZIbFupinryGjLtWS
	0+97HryAaQBdjExbB+HU3tn14TYvzR0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732898058;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JQUmz6+JC7LHFkbB0ekKGkdcpJhE1mpQPbZ58dQ9dI0=;
	b=WvbYMCEvHigczZ/Y6vm+WJfhXPobKhP5EHUL7ZtuApiRsrlM3zDzGA2B7SvMv7/a99zErh
	K1E7S/MPVPgTkWCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A9C8133F3;
	Fri, 29 Nov 2024 16:34:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9/nmFQrtSWdYXAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 29 Nov 2024 16:34:18 +0000
Date: Fri, 29 Nov 2024 17:34:17 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v4] btrfs: handle bio_split() error
Message-ID: <20241129163417.GY31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <3b491cb4fcb7c34bd8cd5265871ff115395fca79.1732786874.git.jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b491cb4fcb7c34bd8cd5265871ff115395fca79.1732786874.git.jth@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 7BE1F1F390
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,twin.jikos.cz:mid,suse.cz:dkim,suse.cz:replyto]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Thu, Nov 28, 2024 at 10:42:01AM +0100, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Commit bfebde92bd31 ("block: Rework bio_split() return value") changed
> bio_split() so that it can return errors.
> 
> Add error handling for it in btrfs_split_bio() and ultimately
> btrfs_submit_chunk().
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
> 
> Changes to v3:
> - decrement bio counter

Is it possible to have some sanity checks for the bio counter? The
missing decrement could be hard to spot, but as it's a global counter
and possibly spanning unbounded time we'd have to add some checkpoints
like do per transaction accounting.

Otherwise,
Reviewed-by: David Sterba <dsterba@suse.com>

> Changes to v2:
> - assign the split bbio to a new variable, so we can keep the old error
>   paths and end the original bbio
> 
> Changes to v1:
> - convert ERR_PTR to blk_status_t
> - correctly fail already split bbios
> ---
>  fs/btrfs/bio.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 1f216d07eff6..af3db0a7ae4d 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -81,6 +81,9 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
>  
>  	bio = bio_split(&orig_bbio->bio, map_length >> SECTOR_SHIFT, GFP_NOFS,
>  			&btrfs_clone_bioset);
> +	if (IS_ERR(bio))
> +		return ERR_CAST(bio);

The cast is not strictly needed here as the pointer matches the return
type.

> +
>  	bbio = btrfs_bio(bio);
>  	btrfs_bio_init(bbio, fs_info, NULL, orig_bbio);
>  	bbio->inode = orig_bbio->inode;
> @@ -678,7 +681,8 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
>  				&bioc, &smap, &mirror_num);
>  	if (error) {
>  		ret = errno_to_blk_status(error);
> -		goto fail;
> +		btrfs_bio_counter_dec(fs_info);
> +		goto end_bbio;
>  	}
>  
>  	map_length = min(map_length, length);

