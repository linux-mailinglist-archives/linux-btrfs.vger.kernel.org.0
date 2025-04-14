Return-Path: <linux-btrfs+bounces-13003-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6785FA88BE5
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 21:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C466D3B4ADB
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 19:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A6B28BAB5;
	Mon, 14 Apr 2025 19:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z46D+z74";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iyReO/R8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z46D+z74";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iyReO/R8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC232820BB
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 19:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744657412; cv=none; b=DebpyW2S2K7SiJINzpGdVF7j55yrOsIUXlUB/XVBcmWb7MX2kTUraqCp4jyYB+cg8Ljs1q//jAWd5BOdGxqMxDTO+QUAqmPlDPxISJmw6fHkJ1rMQs7qWl6o0nD6FMNIbBrgEJgr/Qfh9YLGlBvdW/H+exagStynPlWcEX/2eQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744657412; c=relaxed/simple;
	bh=zq+Ja4QSGlRpVAaQiNMkrU7ZKwvVSWJgWhPdSB222zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rphEsa2duHmeI+teOXUfivsl0wKdmeHFqCKXvi4YQcXKtEbguHCA4+POpm3wATjwlfFWeGvFEHy1mz+jxsEl9zgvHEofa9ttuLP+0Z6wjZVDaX/Mq4GBM2xWsmgW9EbMvMOpolMrirKcrnLC/qCn59jCOn+RRdJFg74gQ5JIJ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z46D+z74; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iyReO/R8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z46D+z74; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iyReO/R8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 52D7A1F74D;
	Mon, 14 Apr 2025 19:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744657403;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5WhyLp5Z/xL9J2ArNZxj+5ArhmYPFvUg0sB0dunk0Ck=;
	b=Z46D+z74SZP4jRLEaDQl73iIS/ter4DcrURR27rVowmB62lSTuAtkes50KFEi737qu+6nN
	0VaR6+HxOw4R4qMaXu8mXYeYMMm+ZxJ9yRBfEDMrf2+VxLeZV59DBbnyLym0lewrYV7yO6
	FRC9SHIPh/3usfzdY3N0r56lN25mNPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744657403;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5WhyLp5Z/xL9J2ArNZxj+5ArhmYPFvUg0sB0dunk0Ck=;
	b=iyReO/R8FvqA7jGMmxx9HRKUJYlZyPlLR1Z43owEq/4qt7+jfcfQRZXqJ3LTLprfzuyRDe
	j0sjA0ptHbf6PNDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744657403;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5WhyLp5Z/xL9J2ArNZxj+5ArhmYPFvUg0sB0dunk0Ck=;
	b=Z46D+z74SZP4jRLEaDQl73iIS/ter4DcrURR27rVowmB62lSTuAtkes50KFEi737qu+6nN
	0VaR6+HxOw4R4qMaXu8mXYeYMMm+ZxJ9yRBfEDMrf2+VxLeZV59DBbnyLym0lewrYV7yO6
	FRC9SHIPh/3usfzdY3N0r56lN25mNPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744657403;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5WhyLp5Z/xL9J2ArNZxj+5ArhmYPFvUg0sB0dunk0Ck=;
	b=iyReO/R8FvqA7jGMmxx9HRKUJYlZyPlLR1Z43owEq/4qt7+jfcfQRZXqJ3LTLprfzuyRDe
	j0sjA0ptHbf6PNDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2BBB71336F;
	Mon, 14 Apr 2025 19:03:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5zh6Cvtb/WetXQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 14 Apr 2025 19:03:23 +0000
Date: Mon, 14 Apr 2025 21:03:21 +0200
From: David Sterba <dsterba@suse.cz>
To: Yangtao Li <frank.li@vivo.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: reuse exit helper in btrfs_bioset_init()
Message-ID: <20250414190321.GF16750@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250414124401.739723-1-frank.li@vivo.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414124401.739723-1-frank.li@vivo.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Apr 14, 2025 at 06:44:01AM -0600, Yangtao Li wrote:
> As David Sterba said before:
> 
>   This is partially duplicating btrfs_delayed_ref_exit(), I'd rather reuse
>   the exit helper.
> 
>   I've checked if this can be done elsewhere, seems that there's only one
>   other case btrfs_bioset_init(), which is partially duplicating
>   btrfs_bioset_exit(). All other init/exit functions are trivial and
>   allocate one structure. So if you want to do that cleanup, please update
>   btrfs_bioset_init() to the preferred pattern. Thanks.

Please write the changelogs as standalone text without the references or
copied text from some suggestions.

Mentions, credits or Suggested-by make most sense if there's some
groundbreaking idea implemented and not mentioning the author would be
percieved as stealing it. Otherwise, suggestions are part of the
review process and should be transformed into useful text in the
changelog.

> So let's convert it.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/btrfs/bio.c | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 8c2eee1f1878..f6f84837d62b 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -892,6 +892,14 @@ void btrfs_submit_repair_write(struct btrfs_bio *bbio, int mirror_num, bool dev_
>  	btrfs_bio_end_io(bbio, errno_to_blk_status(ret));
>  }
>  
> +void __cold btrfs_bioset_exit(void)
> +{
> +	mempool_exit(&btrfs_failed_bio_pool);
> +	bioset_exit(&btrfs_repair_bioset);
> +	bioset_exit(&btrfs_clone_bioset);
> +	bioset_exit(&btrfs_bioset);
> +}

This function is public and you don't need to move it.

> +
>  int __init btrfs_bioset_init(void)
>  {
>  	if (bioset_init(&btrfs_bioset, BIO_POOL_SIZE,
> @@ -900,29 +908,17 @@ int __init btrfs_bioset_init(void)
>  		return -ENOMEM;
>  	if (bioset_init(&btrfs_clone_bioset, BIO_POOL_SIZE,
>  			offsetof(struct btrfs_bio, bio), 0))
> -		goto out_free_bioset;
> +		goto out;
>  	if (bioset_init(&btrfs_repair_bioset, BIO_POOL_SIZE,
>  			offsetof(struct btrfs_bio, bio),
>  			BIOSET_NEED_BVECS))
> -		goto out_free_clone_bioset;
> +		goto out;
>  	if (mempool_init_kmalloc_pool(&btrfs_failed_bio_pool, BIO_POOL_SIZE,
>  				      sizeof(struct btrfs_failed_bio)))
> -		goto out_free_repair_bioset;
> +		goto out;
>  	return 0;
>  
> -out_free_repair_bioset:
> -	bioset_exit(&btrfs_repair_bioset);
> -out_free_clone_bioset:
> -	bioset_exit(&btrfs_clone_bioset);
> -out_free_bioset:
> -	bioset_exit(&btrfs_bioset);
> +out:
> +	btrfs_bioset_exit();
>  	return -ENOMEM;
>  }
> -
> -void __cold btrfs_bioset_exit(void)
> -{
> -	mempool_exit(&btrfs_failed_bio_pool);
> -	bioset_exit(&btrfs_repair_bioset);
> -	bioset_exit(&btrfs_clone_bioset);
> -	bioset_exit(&btrfs_bioset);
> -}
> -- 
> 2.39.0
> 

