Return-Path: <linux-btrfs+bounces-11364-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4ADA2F533
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2025 18:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E37A188A6A6
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2025 17:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8911024FC17;
	Mon, 10 Feb 2025 17:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xUTaB5oz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fq3usCmP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xUTaB5oz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fq3usCmP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35A3256C6B
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Feb 2025 17:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739208398; cv=none; b=FmKuYGX5y4nX5J9tVpP8m4GnSCPow8fH+1k4gdELLX7c2cwGoX0HZ/Bi0r59KOiTV2ky/lTJyIeFMQ/L0SB3alRmYvgK+ygqJnd22ZlXaiR+CkP7+Tt+fnLyocNh2Dr7IYgCNYtaqdrk1EcZ0u+TyQuVQu36DbQYxKuVwSBtEXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739208398; c=relaxed/simple;
	bh=350iI+IYnJZWDns8zZN10iMuFHMZxcbCamyun5a64SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMMMf/bsvDMPr85m7aOT7sZ1xQ4hRbPnLG5eBNxNoyVKkQTHvOns9lEQT7VePrn+HTB//i3qf08JIYsBTaszygXbJ+0Ae/WH3xRbDLffsmWbGGs2V2BkCrB11tIHcUAb1WziuCeK51j7nTdObv30JuignVTqj1ZsxZGM5y8Answ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xUTaB5oz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fq3usCmP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xUTaB5oz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fq3usCmP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1774021137;
	Mon, 10 Feb 2025 17:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739208395;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y5IpVyi9/S8BCXwisnk3hjb/xgIpmbAcj5LDDGZjVUM=;
	b=xUTaB5oz0rG6XihwfZo54MFA52q89w+pg7yD9iW/1ZIHXH4IJGkoRPt741WomDwE6uM3bz
	JDDRpQBrRCLxYRK0WNIXWL1WULGRsSGIBiLCevongXHLgslqgAzR4v9SEqfkiCpnahrItU
	p/A4J1i+2p0zjoZEl7W0G88OeNUWXBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739208395;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y5IpVyi9/S8BCXwisnk3hjb/xgIpmbAcj5LDDGZjVUM=;
	b=fq3usCmPh6zfSJnz2lBhr7+76H1O7n5Ju0YZQXOHb0NHKZNr3Pbhm9y1OG9bUcwHwZbjl4
	xOvYntPbYQ5frADw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739208395;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y5IpVyi9/S8BCXwisnk3hjb/xgIpmbAcj5LDDGZjVUM=;
	b=xUTaB5oz0rG6XihwfZo54MFA52q89w+pg7yD9iW/1ZIHXH4IJGkoRPt741WomDwE6uM3bz
	JDDRpQBrRCLxYRK0WNIXWL1WULGRsSGIBiLCevongXHLgslqgAzR4v9SEqfkiCpnahrItU
	p/A4J1i+2p0zjoZEl7W0G88OeNUWXBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739208395;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y5IpVyi9/S8BCXwisnk3hjb/xgIpmbAcj5LDDGZjVUM=;
	b=fq3usCmPh6zfSJnz2lBhr7+76H1O7n5Ju0YZQXOHb0NHKZNr3Pbhm9y1OG9bUcwHwZbjl4
	xOvYntPbYQ5frADw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED90F13A62;
	Mon, 10 Feb 2025 17:26:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wiyHOco2qmetXwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 10 Feb 2025 17:26:34 +0000
Date: Mon, 10 Feb 2025 18:26:33 +0100
From: David Sterba <dsterba@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: add support for uncached writes
Message-ID: <20250210172633.GR5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <00cb89e6-225a-491f-b7f1-8a9465a7aabb@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00cb89e6-225a-491f-b7f1-8a9465a7aabb@kernel.dk>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	URIBL_BLOCKED(0.00)[kernel.dk:email,twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Mon, Feb 03, 2025 at 09:35:42AM -0700, Jens Axboe wrote:
> The read side is already covered as btrfs uses the generic filemap
> helpers. For writes, just pass in FGP_DONTCACHE if uncached IO is being
> done, then the folios created should be marked appropriately.
> 
> For IO completion, ensure that writing back folios that are uncached
> gets punted to one of the btrfs workers, as task context is needed for
> that. Add an 'uncached_io' member to struct btrfs_bio to manage that.
> 
> With that, add FOP_DONTCACHE to the btrfs file_operations fop_flags
> structure, enabling use of RWF_DONTCACHE.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index bc2555c44a12..fd51dbc16176 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -337,7 +337,7 @@ static void btrfs_end_bio_work(struct work_struct *work)
>  	struct btrfs_bio *bbio = container_of(work, struct btrfs_bio, end_io_work);
>  
>  	/* Metadata reads are checked and repaired by the submitter. */
> -	if (is_data_bbio(bbio))
> +	if (bio_op(&bbio->bio) == REQ_OP_READ && is_data_bbio(bbio))
>  		btrfs_check_read_bio(bbio, bbio->bio.bi_private);
>  	else
>  		btrfs_bio_end_io(bbio, bbio->bio.bi_status);
> @@ -354,7 +354,7 @@ static void btrfs_simple_end_io(struct bio *bio)
>  	if (bio->bi_status)
>  		btrfs_log_dev_io_error(bio, dev);
>  
> -	if (bio_op(bio) == REQ_OP_READ) {
> +	if (bio_op(bio) == REQ_OP_READ || bbio->dropbehind_io) {
>  		INIT_WORK(&bbio->end_io_work, btrfs_end_bio_work);
>  		queue_work(btrfs_end_io_wq(fs_info, bio), &bbio->end_io_work);
>  	} else {
> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> index e2fe16074ad6..b41c5236c93d 100644
> --- a/fs/btrfs/bio.h
> +++ b/fs/btrfs/bio.h
> @@ -82,6 +82,8 @@ struct btrfs_bio {
>  	/* Save the first error status of split bio. */
>  	blk_status_t status;
>  
> +	bool dropbehind_io;

Changelog says this should be 'uncached_io', which is more
understandable than 'dropbehind_io' (as in the folio helper)
As it's just a rename I will fix it but would like to know if this is ok
for you.

Otherwise the patch looks ok, thanks.

