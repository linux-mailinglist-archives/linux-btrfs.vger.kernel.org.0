Return-Path: <linux-btrfs+bounces-7318-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF67A956D66
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Aug 2024 16:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A62E5286ABD
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Aug 2024 14:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2358516D4C4;
	Mon, 19 Aug 2024 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zOOjbMVn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o7ETYuFL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zOOjbMVn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o7ETYuFL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C50716BE1D
	for <linux-btrfs@vger.kernel.org>; Mon, 19 Aug 2024 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724078070; cv=none; b=Q/9xUI/N8+WCOZ4jKm/LSZrBUgITvIgmZDuoZYxdnj5YNoB4kuITyH9IuOST6K6HC5mjfjDS4v7J4lSwS9P3JWAF3uVZbdQv8eyTnDSKfYKKyuJvlBuhYaCBP6hFy+V22o+KmIWDrV1hDLvRaSH/5LfdIi0MzoDhO6hxokVgxIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724078070; c=relaxed/simple;
	bh=R/ZVYK4w3CjMY7wlYFbgfsdXY0emduJdtNM2jFUzf6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZ0arhw5Qc9YixSsW1R3jo97QVwUyfoXfg0Y+wdcLQAZQCmCfSvUb6/GKzC/cVSev9laH04WxKDm0AU3dT/srCg4XUkMHA2N3HIfCURnVzX/oc63k6Ot8F5Du4AKBMTFmEy45BrxR0+/LnIkScp8+kS1s2xrSBf2lEATdRbqHEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zOOjbMVn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o7ETYuFL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zOOjbMVn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o7ETYuFL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9F0F722713;
	Mon, 19 Aug 2024 14:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724078066;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TyksDQQdXo0fbssu9v+rgh95Xa65iPiStVTa/Q/ixbI=;
	b=zOOjbMVnpusa5zTIlmTzzqpIGhN+4j0yCK56BUbzRwSPZvm6iElXmwLDthauS708Xq2h5h
	kgKGiShfn3qJkpLgXc9O9HvxX6rsBRQympj9rZh9dK/3jP/CFbw57p83Qq3MahPIPC42SX
	RQsNWdnCOvBFM0qs3t18SdHMs8NCPUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724078066;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TyksDQQdXo0fbssu9v+rgh95Xa65iPiStVTa/Q/ixbI=;
	b=o7ETYuFLouOJhA/Kadnd8NrmqgcAD71/GOIL9Pi3DwZGbkBJWwQbLVY5jkV8S8R3KQxXEm
	IU+ESQDrPdYRcpCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724078066;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TyksDQQdXo0fbssu9v+rgh95Xa65iPiStVTa/Q/ixbI=;
	b=zOOjbMVnpusa5zTIlmTzzqpIGhN+4j0yCK56BUbzRwSPZvm6iElXmwLDthauS708Xq2h5h
	kgKGiShfn3qJkpLgXc9O9HvxX6rsBRQympj9rZh9dK/3jP/CFbw57p83Qq3MahPIPC42SX
	RQsNWdnCOvBFM0qs3t18SdHMs8NCPUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724078066;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TyksDQQdXo0fbssu9v+rgh95Xa65iPiStVTa/Q/ixbI=;
	b=o7ETYuFLouOJhA/Kadnd8NrmqgcAD71/GOIL9Pi3DwZGbkBJWwQbLVY5jkV8S8R3KQxXEm
	IU+ESQDrPdYRcpCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 860F91397F;
	Mon, 19 Aug 2024 14:34:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BJqBH/JXw2bgCwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 19 Aug 2024 14:34:26 +0000
Date: Mon, 19 Aug 2024 16:34:21 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: merge btrfs_orig_bbio_end_io() into
 btrfs_bio_end_io()
Message-ID: <20240819143421.GK25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <2107a0e72fa6eac67583deb421ac1247b02b7723.1724057484.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2107a0e72fa6eac67583deb421ac1247b02b7723.1724057484.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -8.00
X-Spamd-Result: default: False [-8.00 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Aug 19, 2024 at 06:21:59PM +0930, Qu Wenruo wrote:
> There is only two differences between the two functions:
> 
> - btrfs_orig_bbio_end_io() do extra error propagation
>   This is mostly to allow tolerance for write errors.
> 
> - btrfs_orig_bbio_end_io() do extra pending_ios check
>   This check can handle both the original bio, or the cloned one.
>   (All accounting happens in the original one).
> 
> This makes btrfs_orig_bbio_end_io() a much safer call.
> In fact we already had a double freeing error due to usage of
> btrfs_bio_end_io() in the error path of btrfs_submit_chunk().
> 
> This patch will move the whole content of btrfs_orig_bbio_end_io() into

"Move the ..."

> btrfs_bio_end_io().
> 
> For normal paths this brings no change, because they are already calling
> btrfs_orig_bbio_end_io() in the first place.
> 
> For error paths (not only inside bio.c but also external callers), this
> change will introduce extra checks, especially for external callers, as
> they will error out without submitting the btrfs bio.
> 
> But considering it's already in the error path, such slower but much
> safer checks are still an overall win.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

Please fix the grammar in the changelog when you commit the patch.

> ---
>  fs/btrfs/bio.c | 26 ++++++++++----------------
>  1 file changed, 10 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index 088ceaca6ab0..0e4de33515fe 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -120,12 +120,6 @@ static void __btrfs_bio_end_io(struct btrfs_bio *bbio)
>  	}
>  }
>  
> -void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
> -{
> -	bbio->bio.bi_status = status;
> -	__btrfs_bio_end_io(bbio);

This leaves one last call to __btrfs_bio_end_io() so it can be moved to
it's caller btrfs_orig_bbio_end_io().

