Return-Path: <linux-btrfs+bounces-13400-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC7EA9B853
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 21:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E60BA4A7DAE
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 19:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A49E28BAB6;
	Thu, 24 Apr 2025 19:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f+2PG31r";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iiLiPi44";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f+2PG31r";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iiLiPi44"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AB72918FD
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 19:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745523009; cv=none; b=i5kRpAxhHCL3cVOk4j7RPwPxfDQ2KCQHFYq/xyFSwFoEUabq+fUGuNfnitrAjVRwUpTDR1nRuEB+HuI7RopgCYaAuOAuzAXBG9KmTbKUkRCu54EF0k+DjAONcFeypKIDXkSUcnfRBOQbusovzx8s5VBF/g6xxCVdwhAWnD6MU4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745523009; c=relaxed/simple;
	bh=Dx8rXHcIFnAV5GHt1xK1iFMohpgge0WY7p6W3v/P0Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWFaSVVso5hVENUkagBNkhb7W78Je/PSjy9Y9KHnKosHWeNrQ5zFjqi9D9Dp0eOHP2HXfBu0h3V6Xvb04k7/1liTLZZOP8W2TqTMwOW8mjfH6fG6Se4DdI25HduxaOXutf/EM2RgmN6VJCH3kzThCckBMt8TOo/dChTpMQfbBaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f+2PG31r; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iiLiPi44; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f+2PG31r; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iiLiPi44; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2C76B1F451;
	Thu, 24 Apr 2025 19:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745523006;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RXJ+Kj6ILtNwog63yw38CKNPkZmGrH3j4C0R+FFTZoE=;
	b=f+2PG31r8xCqsEXqQIbCHVO3NPTMTCHBCQqeha4+/r3rTGq1V+T4puKqN+985F8GYZXnxy
	jUWaU7UZJE7hCKFJ/LQtOrzA8rNc5LhtSBIhPClJGiI2V2DuU76kQwhitgG+nMoLtcCsJY
	HBHMJTMS+9l6wKKa6daLyMvuCix2dKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745523006;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RXJ+Kj6ILtNwog63yw38CKNPkZmGrH3j4C0R+FFTZoE=;
	b=iiLiPi4452VyngSeeOJGclQCttq69zqOssMEktRuISNR3xw1NRr8TwnXIQJtYZ9fjtOd/j
	1Sl1f08Q28qbf6Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745523006;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RXJ+Kj6ILtNwog63yw38CKNPkZmGrH3j4C0R+FFTZoE=;
	b=f+2PG31r8xCqsEXqQIbCHVO3NPTMTCHBCQqeha4+/r3rTGq1V+T4puKqN+985F8GYZXnxy
	jUWaU7UZJE7hCKFJ/LQtOrzA8rNc5LhtSBIhPClJGiI2V2DuU76kQwhitgG+nMoLtcCsJY
	HBHMJTMS+9l6wKKa6daLyMvuCix2dKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745523006;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RXJ+Kj6ILtNwog63yw38CKNPkZmGrH3j4C0R+FFTZoE=;
	b=iiLiPi4452VyngSeeOJGclQCttq69zqOssMEktRuISNR3xw1NRr8TwnXIQJtYZ9fjtOd/j
	1Sl1f08Q28qbf6Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CA941393C;
	Thu, 24 Apr 2025 19:30:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ObqZAj6RCmiLRwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 24 Apr 2025 19:30:06 +0000
Date: Thu, 24 Apr 2025 21:29:56 +0200
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Nick Terrell <terrelln@fb.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: harden parsing of compress mount option
Message-ID: <20250424192956.GO3659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250423073329.4021878-1-neelx@suse.com>
 <20250423132220.4052042-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423132220.4052042-1-neelx@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Wed, Apr 23, 2025 at 03:22:19PM +0200, Daniel Vacek wrote:
> Btrfs happily but incorrectly accepts the `-o compress=zlib+foo` and similar
> options with any random suffix. Let's handle that correctly.

Please split the patch. Moving code and adding a fix obscures the fix.
As we'll want to backport more than just the validation of ':' it
makes more sense to do the full move first and then add the individual
fixes on top of that. Thanks.

> Signed-off-by: Daniel Vacek <neelx@suse.com>
> ---
> v2: Drop useless check for comma and split compress options
>     into a separate helper function
> 
>  fs/btrfs/super.c | 108 +++++++++++++++++++++++++++--------------------
>  1 file changed, 62 insertions(+), 46 deletions(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 40709e2a44fce..422fb82279877 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -270,6 +270,67 @@ static inline blk_mode_t btrfs_open_mode(struct fs_context *fc)
>  	return sb_open_mode(fc->sb_flags) & ~BLK_OPEN_RESTRICT_WRITES;
>  }
>  
> +static int btrfs_parse_compress(struct btrfs_fs_context *ctx,
> +				struct fs_parameter *param, int opt)
> +{
> +	/*
> +	 * Provide the same semantics as older kernels that don't use fs
> +	 * context, specifying the "compress" option clears
> +	 * "force-compress" without the need to pass
> +	 * "compress-force=[no|none]" before specifying "compress".
> +	 */
> +	if (opt != Opt_compress_force && opt != Opt_compress_force_type)
> +		btrfs_clear_opt(ctx->mount_opt, FORCE_COMPRESS);
> +
> +	if (opt == Opt_compress || opt == Opt_compress_force) {
> +		ctx->compress_type = BTRFS_COMPRESS_ZLIB;
> +		ctx->compress_level = BTRFS_ZLIB_DEFAULT_LEVEL;
> +		btrfs_set_opt(ctx->mount_opt, COMPRESS);
> +		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
> +		btrfs_clear_opt(ctx->mount_opt, NODATASUM);

Additional cleanups can reorganize the checks so the option clearing
is done once (and not repeated for each compression algorithm).

> +	} else if (strncmp(param->string, "zlib", 4) == 0 &&
> +			(param->string[4] == ':' ||
> +			 param->string[4] == '\0')) {

Matching the name also looks like it can be done by a helper like

	match_compresssion(param, "zlib")

and implemented like

	int len = strlen(compression);

	if (strncmp(param->string, compression, len) == 0 &&
		(param->string[len] ... etc

> +		ctx->compress_type = BTRFS_COMPRESS_ZLIB;
> +		ctx->compress_level =
> +			btrfs_compress_str2level(BTRFS_COMPRESS_ZLIB,
> +						 param->string + 4);
> +		btrfs_set_opt(ctx->mount_opt, COMPRESS);
> +		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
> +		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
> +	} else if (strncmp(param->string, "lzo", 3) == 0 &&
> +			param->string[3] == '\0') {
> +		ctx->compress_type = BTRFS_COMPRESS_LZO;
> +		ctx->compress_level = 0;
> +		btrfs_set_opt(ctx->mount_opt, COMPRESS);
> +		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
> +		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
> +	} else if (strncmp(param->string, "zstd", 4) == 0 &&
> +			(param->string[4] == ':' ||
> +			 param->string[4] == '\0')) {
> +		ctx->compress_type = BTRFS_COMPRESS_ZSTD;
> +		ctx->compress_level =
> +			btrfs_compress_str2level(BTRFS_COMPRESS_ZSTD,
> +						 param->string + 4);
> +		btrfs_set_opt(ctx->mount_opt, COMPRESS);
> +		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
> +		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
> +	} else if ((strncmp(param->string, "no", 2) == 0 &&
> +			param->string[2] == '\0') ||
> +		   (strncmp(param->string, "none", 4) == 0 &&
> +			param->string[4] == '\0')) {
> +		ctx->compress_level = 0;
> +		ctx->compress_type = 0;
> +		btrfs_clear_opt(ctx->mount_opt, COMPRESS);
> +		btrfs_clear_opt(ctx->mount_opt, FORCE_COMPRESS);
> +	} else {
> +		btrfs_err(NULL, "unrecognized compression value %s",
> +			  param->string);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}

