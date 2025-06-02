Return-Path: <linux-btrfs+bounces-14389-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B58ACBA4D
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 19:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD7D3AE760
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 17:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEA1227EAF;
	Mon,  2 Jun 2025 17:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yya1Hb9+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cUwaIDg7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yya1Hb9+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cUwaIDg7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0191E225771
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 17:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748885311; cv=none; b=i1pT3lBtjfV0AdRMQ0v1JXlIO896xfydslZNMN/RWcL4C8eA8Z+lRLoGfMo6cYyEO8EIEx8DZg0hyfcB60LOBCXa/j9Ol2FjZmnWCf11ABt454FJq12DJBE6qMg9MhOTaDWf+S4/NKIQadpy0VgPuAD8Gr2rqt8RcuuIf+rtT8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748885311; c=relaxed/simple;
	bh=bQJ0msGNgnqDo/BlVtZlOJpEqyI501Hl/B35SDrDhb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWktxwxqb57a1mixVKqcAQw+hPx7DBPuh2e+IPvQPjzpXwW3HLIUvQfnsLC/+lVcoPszVgme5zb2CXzT4kva+kuoH4wdon5j1BnHSInrKE1NWuyyNfzK+w9hqZkTELoS/x8AaQrvc7T9+3Iy8wsnoCPBhOGjVlSTLd2oc4nEnkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yya1Hb9+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cUwaIDg7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yya1Hb9+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cUwaIDg7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 037AA1F7A1;
	Mon,  2 Jun 2025 17:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748885307;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m1oQwTTW6zDX8MqL6C0dST4QNqB3klozzJmt2BYi1tM=;
	b=yya1Hb9+BWaRDJMo3iqDWicPpvT6LmY1JdCJU7lCyxNXxfQfac5FHGndHfmwcWNE9HjX4j
	ONjkovNxosknGcUQJg+LcLW0T0b2rbGgR5g1Epr0tr/GGQTgidlQfNfhTklH/xvvI1QDu0
	Wh6bzBfAMOSEnryBX98MJ5Y1NJm3ibI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748885307;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m1oQwTTW6zDX8MqL6C0dST4QNqB3klozzJmt2BYi1tM=;
	b=cUwaIDg7DCHoIwlaMwmvZIqeMoj6pU6AypVchmuCSURSfgTMuFiI8nApNKG6bW8Mge9aK/
	G7EzuIaajBYag6BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748885307;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m1oQwTTW6zDX8MqL6C0dST4QNqB3klozzJmt2BYi1tM=;
	b=yya1Hb9+BWaRDJMo3iqDWicPpvT6LmY1JdCJU7lCyxNXxfQfac5FHGndHfmwcWNE9HjX4j
	ONjkovNxosknGcUQJg+LcLW0T0b2rbGgR5g1Epr0tr/GGQTgidlQfNfhTklH/xvvI1QDu0
	Wh6bzBfAMOSEnryBX98MJ5Y1NJm3ibI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748885307;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m1oQwTTW6zDX8MqL6C0dST4QNqB3klozzJmt2BYi1tM=;
	b=cUwaIDg7DCHoIwlaMwmvZIqeMoj6pU6AypVchmuCSURSfgTMuFiI8nApNKG6bW8Mge9aK/
	G7EzuIaajBYag6BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D177B13A63;
	Mon,  2 Jun 2025 17:28:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XIXgMjrfPWi+JAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 02 Jun 2025 17:28:26 +0000
Date: Mon, 2 Jun 2025 19:28:17 +0200
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Nick Terrell <terrelln@fb.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] btrfs: factor out compress mount options parsing
Message-ID: <20250602172817.GD4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250602155320.1854888-1-neelx@suse.com>
 <20250602155320.1854888-2-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602155320.1854888-2-neelx@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -8.00
X-Spamd-Result: default: False [-8.00 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 

On Mon, Jun 02, 2025 at 05:53:18PM +0200, Daniel Vacek wrote:
> There are many options making the parsing a bit lenghty.
> Factor the compress options out into a helper function.
> The next patch is going to harden this function.
> 
> Signed-off-by: Daniel Vacek <neelx@suse.com>
> ---
> v3 changes: Split into two patches to ease backporting,
>             no functional changes.
> 
>  fs/btrfs/super.c | 100 +++++++++++++++++++++++++----------------------
>  1 file changed, 54 insertions(+), 46 deletions(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 40709e2a44fce..6291ab45ab2a5 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -270,6 +270,59 @@ static inline blk_mode_t btrfs_open_mode(struct fs_context *fc)
>  	return sb_open_mode(fc->sb_flags) & ~BLK_OPEN_RESTRICT_WRITES;
>  }
>  
> +static int btrfs_parse_compress(struct btrfs_fs_context *ctx,
> +				struct fs_parameter *param, int opt)

parame can be const

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
> +	} else if (strncmp(param->string, "zlib", 4) == 0) {
> +		ctx->compress_type = BTRFS_COMPRESS_ZLIB;
> +		ctx->compress_level =
> +			btrfs_compress_str2level(BTRFS_COMPRESS_ZLIB,
> +						 param->string + 4);
> +		btrfs_set_opt(ctx->mount_opt, COMPRESS);
> +		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
> +		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
> +	} else if (strncmp(param->string, "lzo", 3) == 0) {
> +		ctx->compress_type = BTRFS_COMPRESS_LZO;
> +		ctx->compress_level = 0;
> +		btrfs_set_opt(ctx->mount_opt, COMPRESS);
> +		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
> +		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
> +	} else if (strncmp(param->string, "zstd", 4) == 0) {
> +		ctx->compress_type = BTRFS_COMPRESS_ZSTD;
> +		ctx->compress_level =
> +			btrfs_compress_str2level(BTRFS_COMPRESS_ZSTD,
> +						 param->string + 4);
> +		btrfs_set_opt(ctx->mount_opt, COMPRESS);
> +		btrfs_clear_opt(ctx->mount_opt, NODATACOW);
> +		btrfs_clear_opt(ctx->mount_opt, NODATASUM);
> +	} else if (strncmp(param->string, "no", 2) == 0) {
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
> +
>  static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  {
>  	struct btrfs_fs_context *ctx = fc->fs_private;
> @@ -339,53 +392,8 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  		fallthrough;
>  	case Opt_compress:
>  	case Opt_compress_type:
> -		/*
> -		 * Provide the same semantics as older kernels that don't use fs
> -		 * context, specifying the "compress" option clears
> -		 * "force-compress" without the need to pass
> -		 * "compress-force=[no|none]" before specifying "compress".
> -		 */
> -		if (opt != Opt_compress_force && opt != Opt_compress_force_type)
> -			btrfs_clear_opt(ctx->mount_opt, FORCE_COMPRESS);
> -
> -		if (opt == Opt_compress || opt == Opt_compress_force) {
> -			ctx->compress_type = BTRFS_COMPRESS_ZLIB;
> -			ctx->compress_level = BTRFS_ZLIB_DEFAULT_LEVEL;
> -			btrfs_set_opt(ctx->mount_opt, COMPRESS);
> -			btrfs_clear_opt(ctx->mount_opt, NODATACOW);
> -			btrfs_clear_opt(ctx->mount_opt, NODATASUM);
> -		} else if (strncmp(param->string, "zlib", 4) == 0) {
> -			ctx->compress_type = BTRFS_COMPRESS_ZLIB;
> -			ctx->compress_level =
> -				btrfs_compress_str2level(BTRFS_COMPRESS_ZLIB,
> -							 param->string + 4);
> -			btrfs_set_opt(ctx->mount_opt, COMPRESS);
> -			btrfs_clear_opt(ctx->mount_opt, NODATACOW);
> -			btrfs_clear_opt(ctx->mount_opt, NODATASUM);
> -		} else if (strncmp(param->string, "lzo", 3) == 0) {
> -			ctx->compress_type = BTRFS_COMPRESS_LZO;
> -			ctx->compress_level = 0;
> -			btrfs_set_opt(ctx->mount_opt, COMPRESS);
> -			btrfs_clear_opt(ctx->mount_opt, NODATACOW);
> -			btrfs_clear_opt(ctx->mount_opt, NODATASUM);
> -		} else if (strncmp(param->string, "zstd", 4) == 0) {
> -			ctx->compress_type = BTRFS_COMPRESS_ZSTD;
> -			ctx->compress_level =
> -				btrfs_compress_str2level(BTRFS_COMPRESS_ZSTD,
> -							 param->string + 4);
> -			btrfs_set_opt(ctx->mount_opt, COMPRESS);
> -			btrfs_clear_opt(ctx->mount_opt, NODATACOW);
> -			btrfs_clear_opt(ctx->mount_opt, NODATASUM);
> -		} else if (strncmp(param->string, "no", 2) == 0) {
> -			ctx->compress_level = 0;
> -			ctx->compress_type = 0;
> -			btrfs_clear_opt(ctx->mount_opt, COMPRESS);
> -			btrfs_clear_opt(ctx->mount_opt, FORCE_COMPRESS);
> -		} else {
> -			btrfs_err(NULL, "unrecognized compression value %s",
> -				  param->string);
> +		if (btrfs_parse_compress(ctx, param, opt))
>  			return -EINVAL;
> -		}
>  		break;
>  	case Opt_ssd:
>  		if (result.negated) {
> -- 
> 2.47.2
> 

