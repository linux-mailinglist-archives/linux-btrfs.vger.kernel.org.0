Return-Path: <linux-btrfs+bounces-2325-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C45851332
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 13:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D97D1C224C5
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Feb 2024 12:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3423C48A;
	Mon, 12 Feb 2024 12:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Wa0PTuX4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cNMdHOF7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0DFqRm0j";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="arxMi8qZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC573C47C
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Feb 2024 12:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707739666; cv=none; b=ZFtLmcEzNpqgpFKItStdNTlISSCsnCzQsg6/aR1wNcP8vyVArpxb2QL+p3AtQiAS9BdPdt64KTnH+x5TgdboHaTkOEVbGU4yclGZ5Ne3roEPk688J8ZbCHP1RojpDg2DR1sZhm4yeudDWaYcyPe5KnlmQQ2uBy/jPoU/qfcv4Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707739666; c=relaxed/simple;
	bh=AnrMrfqjiUmGbd9RNErYpS7phIf3cPVgUrnTmoMqZhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oT5OB6ZTa7MRaGqBR8Gj6X0qFqbdgVmAGFJJo3sOSyZ0SQwrkBXS9lS/M8t4WC8j+uYuVBvetCBbDQGeTAPdnDwxGfLcOx5pQv9B2qiS+nQ/Cmn8PG/6I6ln8zk2DxBkjHuIvL7V7ugRhaMW5JyafV5/tcHITg0BmBk30NVvizw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Wa0PTuX4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cNMdHOF7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0DFqRm0j; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=arxMi8qZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1E9B41F461;
	Mon, 12 Feb 2024 12:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707739662;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h8OTsIoLwSiruLQ8R02hU3YpibjvNf8qRKv/PDt7XF4=;
	b=Wa0PTuX4oppEXy5ALIIToTISAS0yg8NyZlmw8UH7MT6BETnQRFHC+Z8aIAfkazmKuvTucP
	tIOK8njNb00XxbC+Cjegl3+LVHmLickgvUzsIOingJ7tm2Z9sPXqouc1avg4rqhj+kowPe
	WhjNqQ02p+KvS2mp8GqmzMuKOZceaqI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707739662;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h8OTsIoLwSiruLQ8R02hU3YpibjvNf8qRKv/PDt7XF4=;
	b=cNMdHOF7PrrxsD1FdFlt6fritlTmm7xqxJZG65Ihd29dfOYBed6d4wScQ/ushsHOBYDGoN
	UoOjb82BOqnI11Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707739661;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h8OTsIoLwSiruLQ8R02hU3YpibjvNf8qRKv/PDt7XF4=;
	b=0DFqRm0jjoqLOFdXIL0vrGzvW2Ktw25hV9LVDEjqpjrskjfP2uuGQqslk3WlWAM4eus1wD
	5uv4zCGbZ4eaebUl4IFZHyY74aMk3S8hrBBoD6XM6H/ws3IaW7EbfZbeRwdMfj7XrHtBLs
	D3kzjMBBBBoOorZ2VjeChjXZTMUQTs4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707739661;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h8OTsIoLwSiruLQ8R02hU3YpibjvNf8qRKv/PDt7XF4=;
	b=arxMi8qZpZ/HrE3NrRdPvOWTeKN9h2ix+yMGyTeL/QETC/pAUpXVHfeeSmAnAY+UV51/zz
	23V+dAQltDxqAuDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id F248413A0E;
	Mon, 12 Feb 2024 12:07:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 0nT2OgwKymXjIAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 12 Feb 2024 12:07:40 +0000
Date: Mon, 12 Feb 2024 13:07:08 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: mkfs: do not default to 4K sectorsize if
 the fs is zoned
Message-ID: <20240212120708.GB355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <f679cbd1b09fff494b58f37520a9ab727c3ff313.1707716170.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f679cbd1b09fff494b58f37520a9ab727c3ff313.1707716170.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.20 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWO(0.00)[2];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[41.91%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.20

On Mon, Feb 12, 2024 at 04:06:30PM +1030, Qu Wenruo wrote:
> With some help from a reporter using loongson (with 16K page size), and
> a zoned device, it turns out that, zoned code is not compatible with
> subpage's requirement.
> 
> Mostly conflicts on the multiple re-entry into the same @locked_page
> using extent_write_locked_range().
> 
> The function is only utilized by compression for non-zoned btrfs, but
> would be the default entry for all writes for zoned btrfs.
> 
> So we can not default to 4K for subpage zoned combination.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  mkfs/main.c | 32 +++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/mkfs/main.c b/mkfs/main.c
> index b50b78b5665a..f54c1a055ae2 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -1383,15 +1383,6 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  		printf("See %s for more information.\n\n", PACKAGE_URL);
>  	}
>  
> -	if (!sectorsize)
> -		sectorsize = (u32)SZ_4K;
> -	if (btrfs_check_sectorsize(sectorsize))
> -		goto error;
> -
> -	if (!nodesize)
> -		nodesize = max_t(u32, sectorsize, BTRFS_MKFS_DEFAULT_NODE_SIZE);
> -
> -	stripesize = sectorsize;
>  	saved_optind = optind;
>  	device_count = argc - optind;
>  	if (device_count == 0)
> @@ -1470,6 +1461,29 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>  		features.incompat_flags |= BTRFS_FEATURE_INCOMPAT_ZONED;
>  	}
>  
> +	if (!sectorsize) {
> +		/*
> +		 * Zoned btrfs utilize extent_write_locked_range(), which can not
> +		 * handle multiple entries into the same locked page.
> +		 *
> +		 * For non-zoned btrfs, subpage workaround the problem by requiring
> +		 * full page alignment for compression (the only path utilizing
> +		 * that path).
> +		 * But since zoned btrfs always goes that path, kernel can not support
> +		 * writes into subpage zoned btrfs.
> +		 */
> +		if (!opt_zoned)
> +			sectorsize = (u32)SZ_4K;
> +		else
> +			sectorsize = (u32)getpagesize();
> +	}

6.7 did the change to 4k instead of the auto detection of sectorsize,
yet this adds the logic back. I'd rather not do that. We had
compatibility issues with zoned when some of the profiles were not
supported initially and collided with mkfs defaults, so I'd rather
exit mkfs with a message what works with subpage and zoned.

