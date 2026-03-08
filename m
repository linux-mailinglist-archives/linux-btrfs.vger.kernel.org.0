Return-Path: <linux-btrfs+bounces-22278-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id U6B0JtLnrWlL9QEAu9opvQ
	(envelope-from <linux-btrfs+bounces-22278-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Mar 2026 22:19:14 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E4A2324BB
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Mar 2026 22:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8EA5C300F124
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Mar 2026 21:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4703563E8;
	Sun,  8 Mar 2026 21:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I5Q+sO+t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBA93290D5
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Mar 2026 21:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773004747; cv=none; b=aCK6QMceD+u+FVooOm34yZ4SLmsbmepYqQwtPsGTtkS8JoMAT+k3bfB6pWMTFvsrE4nC87mfS4lym7afwk9XUWMwHg1fwNi/9HrLkjaMkUV+iyWULxzCrTJRIGJ0y+a0BTub9hjsmgz+uLjEY3VoTqM5Xp+WXEo1Z+yQkxEw9vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773004747; c=relaxed/simple;
	bh=hJZwWH3dKh30jrXu06PNPZiH2Rh0RzlXVIiHGznX3so=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YLJQebQK8q/hIROBvr53Ja5Vpn8tysErdEpO4gnB7fFYyBSIpB0C7UBP1sVdX+ttGlruIm+Qhwra8GlyOcFVB2YIG6JMG4e/vUzsp/bWSyztfV3pHKaC1ro+/Y+1VKu/pezBGlHf2I+ML9L3hiB+/5mUSxozM2UGz4DHEBsysdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I5Q+sO+t; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4806cc07ce7so127445615e9.1
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Mar 2026 14:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773004743; x=1773609543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3+z4CqEO/7VS22glAthUPXJPXHmHHuhnxWXDV7aa870=;
        b=I5Q+sO+tzowKZlxEklJp7Jbsv9jjHKkU7PS/feE930Ie5i8xVmXJ9Ct3ljz0xv+zAO
         ygugOnGxJFoY16fk8fZSwHuWuBJOCSUgG8MuPmcHKCb+zw/k9JwvlGkeuSKKRAq9Zxte
         T2hPkeWc0IsiJYhjcfzAGAusG8hJwrJ9kPo02CWRmWbC/9FntTUwoH4ZlOrj2FOEUn5J
         2FLf22JNsTqA6lwEZHxX/o+GmYKAQrHrcsTRm32uKbENtYAGoKuEibKOxMUzsYErxIiQ
         63jOKGJ44PFw7Xd5LfrQL7ufCggB+jLyVOWA54hYv8Efwzdtud63d862Ou7Yp+BxE8Q3
         tN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773004743; x=1773609543;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+z4CqEO/7VS22glAthUPXJPXHmHHuhnxWXDV7aa870=;
        b=bjJ7G3HGUnNUoVMOkkPw7ahtkSbEICgyJVXIChPSCQojjmvHoksRrD2wdodqaoGqPT
         1yvahIwN2CFeQCNxReu7h6XUVeL8Tg2/nJ6PAGupI9Rma/F5KJKkyammLSS9sQ9AMaUl
         cjo74gn5oQm2xPrzlWDHtewWkYeyMiUtnoqlmGF4B0fwD9MfhMQtYBFzfZWd1SjpAaU3
         Z5wkLUvJr3NAMAIbeirV8b7Jd1XQR1LM3eFTSnlh1GpKY/xKR24KLg3SeX12wi+H/Xig
         WZ5r1hCTOV+i3S6uPr9CG+Vuot1TnQQsYkGxM8ZpDNj0+ax+FgpwaE+Wef+sTJPIMbNV
         Lb3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1fOo6KWH1I4WubBRW7CESHI58I+ThsOJKGD/6iHODKvWER0j0u2xI0vGKXpkNG9aN4XD3pRncrJZd1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm8UH+UKsHGTnE/1vUd2DYFYhbmk9lWXc1zjvbAQv775eUXMnh
	dMgMxWvH81JFidf0Ar2T5LncwJwU8oN1oiElb0AcuRl17c1DlQ6b+sVnEs3Ez6zWMEA=
X-Gm-Gg: ATEYQzxccC5ylK89uWbHN5n0hb2CRSz7uFAwSYLyTEfo24gSIOl+ciyZz1Ofh9vFgPh
	PhnAAXBB8KjdmdkePnd1o96CuIhLcEKnuHqbpPObR4nulKDBjMBUCWlu3BxqQx+lE/HhiF9Tuyu
	2NnALTGpXIO3kineLbW9N8DaHwf48meKSWNplAHM5eqp9VzbzJEch9d/LhJMBf+taPbiVeo2Zit
	0ftr3IvL6QJH7qAcqzkoGwQTjtFTHGZAcJrH95vn/6DqXD1aT4Go+5HT6+DzcdXZtHGnd/ZC4Te
	wlcZpyuq9TO370Uy9dGj387alpKky+d3jbSV/dUKM+Sdv32D6Nlkli8iNlhQbXlNXVtSjh2pCP8
	xu9VDx+BGCsREJeGAA/ErAcwR4X+pKxlt8cn0Dl7BvsNM2T3FG4piDlpgffFIOT+5rgQ2JKP7rN
	3MEsVJA2rQ9t/zgeCoSxxZjmtSNJ4uxoo+48yLAZKR5hrJymZ8o1I=
X-Received: by 2002:a05:600c:45d1:b0:483:a361:41a5 with SMTP id 5b1f17b1804b1-4852697866fmr159410045e9.30.1773004743052;
        Sun, 08 Mar 2026 14:19:03 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae840b6639sm123685335ad.86.2026.03.08.14.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Mar 2026 14:19:01 -0700 (PDT)
Message-ID: <ae4da77a-5ccb-4fcd-89d0-db452ad5a152@suse.com>
Date: Mon, 9 Mar 2026 07:48:56 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: raid56: use kzalloc_flex for rbio
To: Rosen Penev <rosenp@gmail.com>, linux-btrfs@vger.kernel.org
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260308205340.24208-1-rosenp@gmail.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <20260308205340.24208-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 36E4A2324BB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-22278-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.934];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action



在 2026/3/9 07:23, Rosen Penev 写道:
> Simplifies allocation slightly. Now stripe_pages does not need to be
> freed separately.
> 
> Added __counted_by for extra runtime analysis.

If that's the only variable sized member this will be a good change.

Unfortunately there are too many pointers for variable sized members, 
all around the old @stripe_pages pointer.

Treating @stripe_pages differently from other doesn't seem good to 
expandability nor readability.

Thanks,
Qu

> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   fs/btrfs/raid56.c |  9 ++++-----
>   fs/btrfs/raid56.h | 12 ++++++------
>   2 files changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index baebd9f733e9..d74ae380265e 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -151,7 +151,6 @@ static void free_raid_bio_pointers(struct btrfs_raid_bio *rbio)
>   {
>   	bitmap_free(rbio->error_bitmap);
>   	bitmap_free(rbio->stripe_uptodate_bitmap);
> -	kfree(rbio->stripe_pages);
>   	kfree(rbio->bio_paddrs);
>   	kfree(rbio->stripe_paddrs);
>   	kfree(rbio->finish_pointers);
> @@ -1070,10 +1069,11 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
>   	ASSERT(real_stripes >= 2);
>   	ASSERT(real_stripes <= U8_MAX);
>   
> -	rbio = kzalloc_obj(*rbio, GFP_NOFS);
> +	rbio = kzalloc_flex(*rbio, stripe_pages, num_pages, GFP_NOFS);
>   	if (!rbio)
>   		return ERR_PTR(-ENOMEM);
> -	rbio->stripe_pages = kzalloc_objs(struct page *, num_pages, GFP_NOFS);
> +
> +	rbio->nr_pages = num_pages;
>   	rbio->bio_paddrs = kzalloc_objs(phys_addr_t,
>   					num_sectors * sector_nsteps, GFP_NOFS);
>   	rbio->stripe_paddrs = kzalloc_objs(phys_addr_t,
> @@ -1083,7 +1083,7 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
>   	rbio->error_bitmap = bitmap_zalloc(num_sectors, GFP_NOFS);
>   	rbio->stripe_uptodate_bitmap = bitmap_zalloc(num_sectors, GFP_NOFS);
>   
> -	if (!rbio->stripe_pages || !rbio->bio_paddrs || !rbio->stripe_paddrs ||
> +	if (!rbio->bio_paddrs || !rbio->stripe_paddrs ||
>   	    !rbio->finish_pointers || !rbio->error_bitmap || !rbio->stripe_uptodate_bitmap) {
>   		free_raid_bio_pointers(rbio);
>   		kfree(rbio);
> @@ -1102,7 +1102,6 @@ static struct btrfs_raid_bio *alloc_rbio(struct btrfs_fs_info *fs_info,
>   	INIT_LIST_HEAD(&rbio->hash_list);
>   	btrfs_get_bioc(bioc);
>   	rbio->bioc = bioc;
> -	rbio->nr_pages = num_pages;
>   	rbio->nr_sectors = num_sectors;
>   	rbio->real_stripes = real_stripes;
>   	rbio->stripe_npages = stripe_npages;
> diff --git a/fs/btrfs/raid56.h b/fs/btrfs/raid56.h
> index 1f463ecf7e41..dbe6b7a2e194 100644
> --- a/fs/btrfs/raid56.h
> +++ b/fs/btrfs/raid56.h
> @@ -194,12 +194,6 @@ struct btrfs_raid_bio {
>   	 * allocated.
>   	 */
>   
> -	/*
> -	 * Pointers to pages that we allocated for reading/writing stripes
> -	 * directly from the disk (including P/Q).
> -	 */
> -	struct page **stripe_pages;
> -
>   	/* Pointers to the sectors in the bio_list, for faster lookup */
>   	phys_addr_t *bio_paddrs;
>   
> @@ -230,6 +224,12 @@ struct btrfs_raid_bio {
>   	 * Should only cover data sectors (excluding P/Q sectors).
>   	 */
>   	unsigned long *csum_bitmap;
> +
> +	/*
> +	 * Pointers to pages that we allocated for reading/writing stripes
> +	 * directly from the disk (including P/Q).
> +	 */
> +	struct page *stripe_pages[] __counted_by(nr_pages);
>   };
>   
>   /*


