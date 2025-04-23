Return-Path: <linux-btrfs+bounces-13292-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2313FA9874F
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 12:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E32443B36
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 10:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFFD267F45;
	Wed, 23 Apr 2025 10:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="np10QHAt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0+a/QD5l";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="np10QHAt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0+a/QD5l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA3B1F2C45
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 10:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745404176; cv=none; b=LCWJvdFRPl9wFQvQj23RKNfxRozfqNU3zwo8K7CTHnARcc/bE380LvMTPcGSKQH7iVtJT0R05ncmaTOBfWCCwLU+dPHlD2XAxbd5tTJ003ID/m/rdxYj7kNIZPyQel7P5hGFwLAH67Td00NtCZlZhLLD8j0i03Q+vDD5h0j7IDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745404176; c=relaxed/simple;
	bh=4Rq/Gmlehpk/AKr8lWH+o1utdeFgmGjl3cShUrUXn5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+rugXqlRaC5aUGUg7Fty4Dre1dNkvsWfAz6tWNtKnW3DzAL/+A01o+QUJwbBiLsmGO0ctBX2wUdfToGzldjuFbuEP1Nl0c/V4caOOCtkPWT9RtdfGiAoMAqpqFTLRDP1h4iWrbVTlqKr9/DYpXvJ5GGqHzPrmlB2JSXusjGBDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=np10QHAt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0+a/QD5l; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=np10QHAt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0+a/QD5l; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BAEBE1F38E;
	Wed, 23 Apr 2025 10:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745404166;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eyPfh9WBuQEiVfWgDNclL0FrZScn/rQD0SlbJwshX10=;
	b=np10QHAtl1Ns6Y5rxp7bP0jK478S3x/34VkpICh4+WTyfDUkp6V8/ETIIikm7hGPFVx+Iu
	9PH5g0FJm2I5zgONsbitWla1QJt7fjfvfTMLI8VnN5CnHf6n4clEK048133xGSFbvjGBrm
	qTrD0Rw62qlyFQY1xEekiDDJdRsE7ZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745404166;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eyPfh9WBuQEiVfWgDNclL0FrZScn/rQD0SlbJwshX10=;
	b=0+a/QD5lcL10KxA6LS5/Eurx2PlVoYICV2z70Ow7ATB8ITAnRgKNIZ6+bUEhjQM9DgVx9w
	LE90xX9kCWnS8sDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745404166;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eyPfh9WBuQEiVfWgDNclL0FrZScn/rQD0SlbJwshX10=;
	b=np10QHAtl1Ns6Y5rxp7bP0jK478S3x/34VkpICh4+WTyfDUkp6V8/ETIIikm7hGPFVx+Iu
	9PH5g0FJm2I5zgONsbitWla1QJt7fjfvfTMLI8VnN5CnHf6n4clEK048133xGSFbvjGBrm
	qTrD0Rw62qlyFQY1xEekiDDJdRsE7ZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745404166;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eyPfh9WBuQEiVfWgDNclL0FrZScn/rQD0SlbJwshX10=;
	b=0+a/QD5lcL10KxA6LS5/Eurx2PlVoYICV2z70Ow7ATB8ITAnRgKNIZ6+bUEhjQM9DgVx9w
	LE90xX9kCWnS8sDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A726413691;
	Wed, 23 Apr 2025 10:29:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vDmTKAbBCGjDHwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 23 Apr 2025 10:29:26 +0000
Date: Wed, 23 Apr 2025 12:29:25 +0200
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Nick Terrell <terrelln@fb.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: harden parsing of compress mount option
Message-ID: <20250423102925.GG3659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250423073329.4021878-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423073329.4021878-1-neelx@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Apr 23, 2025 at 09:33:28AM +0200, Daniel Vacek wrote:
> Btrfs happily but incorrectly accepts the `-o compress=zlib+foo` and similar
> options with any random suffix. Let's handle that correctly.
> 
> Signed-off-by: Daniel Vacek <neelx@suse.com>
> ---
>  fs/btrfs/super.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 40709e2a44fce..f7e064b8c6d88 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -354,7 +354,10 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  			btrfs_set_opt(ctx->mount_opt, COMPRESS);
>  			btrfs_clear_opt(ctx->mount_opt, NODATACOW);
>  			btrfs_clear_opt(ctx->mount_opt, NODATASUM);
> -		} else if (strncmp(param->string, "zlib", 4) == 0) {
> +		} else if (strncmp(param->string, "zlib", 4) == 0 &&
> +				(param->string[4] == ':' ||
> +				 param->string[4] == ',' ||
> +				 param->string[4] == '\0')) {
>  			ctx->compress_type = BTRFS_COMPRESS_ZLIB;
>  			ctx->compress_level =
>  				btrfs_compress_str2level(BTRFS_COMPRESS_ZLIB,

With more checks the block under the Opt_compress* has grown beyond what
I'd consider reasonable. It would be good to factor it out to a helper,
pass the param->string and context.

Extending with more checks will be easier, we can also validate the
negative levels or other garbage in the string.

