Return-Path: <linux-btrfs+bounces-18317-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5548C08296
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 23:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AE1E3A47B7
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 21:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7BB27A122;
	Fri, 24 Oct 2025 21:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WzDtGH11";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1XuAKZhD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WzDtGH11";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1XuAKZhD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDBA22AE65
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 21:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761340588; cv=none; b=JvasaMQ+GRS4DsYLqkHoiWM9UMMS5MHni+CDMLy0ei8PNG/fGpB0lQjI/AGxJJHn4bhHvgXi0iocO88fuGqZZaT/0jrfrEAnKEZqKmjjpWCzjnVLAeyR6Ou32mZLGs7Vz6kCTRxRWCfUKMOiqM1KuQsnmuDD1s87JOBbgUq/Xxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761340588; c=relaxed/simple;
	bh=TCRfZtRWlNNs8yLUgQ/gyPgvTBjm9IAAyrNwmTjmMZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IjTNX3Gd0PZnuzzg4uIBEFl7QArHpG7E6T71isal9P9MmpKFy5yl1IaG3f9wUY5K2EdeSULFpzXBv796tSwr7RF28o5pcPhpWkzM45Fy5ssk04F6ED6YtznKgpyopJZodGQgAwdC7iltZRYUaOjLTQJHBz8k+V+wyh0ydkvLQaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WzDtGH11; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1XuAKZhD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WzDtGH11; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1XuAKZhD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 83AD81F452;
	Fri, 24 Oct 2025 21:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761340584;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vsZIxglhQwdaSN9I/TBgDH6MIpY3auWlO5Zb7uIuSu4=;
	b=WzDtGH11vMuCb2ZQHNaYvaVkYD1MXWwQyJoM67WWh8OuRYCVi7OdSarY3swPrKEjDNGJtd
	aqV5hiRIFCOafhvZxUnorSWVn7c/OQg6eKluL8xT/iT8Kc4JGgB6FS87kz5e42jBlGrB0n
	04rxSrzSkTfsEIpsMlfhMnXNjf5ZRyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761340584;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vsZIxglhQwdaSN9I/TBgDH6MIpY3auWlO5Zb7uIuSu4=;
	b=1XuAKZhDAmOZNhm5U/K8+68h8hPs6Q7zv72qaa9FQblBaoy4Pl6ium0+V1fRLyZVR38siF
	0vMKHqnxATg/1+AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761340584;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vsZIxglhQwdaSN9I/TBgDH6MIpY3auWlO5Zb7uIuSu4=;
	b=WzDtGH11vMuCb2ZQHNaYvaVkYD1MXWwQyJoM67WWh8OuRYCVi7OdSarY3swPrKEjDNGJtd
	aqV5hiRIFCOafhvZxUnorSWVn7c/OQg6eKluL8xT/iT8Kc4JGgB6FS87kz5e42jBlGrB0n
	04rxSrzSkTfsEIpsMlfhMnXNjf5ZRyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761340584;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vsZIxglhQwdaSN9I/TBgDH6MIpY3auWlO5Zb7uIuSu4=;
	b=1XuAKZhDAmOZNhm5U/K8+68h8hPs6Q7zv72qaa9FQblBaoy4Pl6ium0+V1fRLyZVR38siF
	0vMKHqnxATg/1+AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E1F113A38;
	Fri, 24 Oct 2025 21:16:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xiW6Gqjs+2iiRQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 24 Oct 2025 21:16:24 +0000
Date: Fri, 24 Oct 2025 23:16:23 +0200
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: Re: [PATCH 2/8] btrfs-progs: add new FEATURE_INCOMPAT_ENCRYPT flag
Message-ID: <20251024211623.GD20913@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251015121157.1348124-1-neelx@suse.com>
 <20251015121157.1348124-3-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015121157.1348124-3-neelx@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.983];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Wed, Oct 15, 2025 at 02:11:50PM +0200, Daniel Vacek wrote:
> From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> 
> Matches kernel change by the same name.
> 
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> ---
>  kernel-shared/ctree.h      | 3 ++-
>  kernel-shared/uapi/btrfs.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
> index b08e078b..ccd39813 100644
> --- a/kernel-shared/ctree.h
> +++ b/kernel-shared/ctree.h
> @@ -102,7 +102,8 @@ static inline u32 __BTRFS_LEAF_DATA_SIZE(u32 nodesize)
>  	 BTRFS_FEATURE_INCOMPAT_ZONED |			\
>  	 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2 |	\
>  	 BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE |	\
> -	 BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA)
> +	 BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA |		\
> +	 BTRFS_FEATURE_INCOMPAT_ENCRYPT)
>  #else
>  #define BTRFS_FEATURE_INCOMPAT_SUPP			\
>  	(BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF |		\
> diff --git a/kernel-shared/uapi/btrfs.h b/kernel-shared/uapi/btrfs.h
> index d6eb4fb4..79963870 100644
> --- a/kernel-shared/uapi/btrfs.h
> +++ b/kernel-shared/uapi/btrfs.h
> @@ -359,6 +359,7 @@ _static_assert(sizeof(struct btrfs_ioctl_fs_info_args) == 1024);
>  #define BTRFS_FEATURE_INCOMPAT_ZONED		(1ULL << 12)
>  #define BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2	(1ULL << 13)
>  #define BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE (1ULL << 14)
> +#define BTRFS_FEATURE_INCOMPAT_ENCRYPT		(1ULL << 15)

This definition has to be added to libbtrfsutil/btrfs.h as well, all the
headers are independent. And this also needs version bump but there's
already anoter change in devel so it's covered.

>  #define BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA	(1ULL << 16)
>  
>  struct btrfs_ioctl_feature_flags {
> -- 
> 2.51.0
> 

