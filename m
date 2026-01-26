Return-Path: <linux-btrfs+bounces-21089-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uG+tOmf4d2mqmwEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21089-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 00:27:35 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 880038E325
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jan 2026 00:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A48C3011584
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 23:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377C430F52A;
	Mon, 26 Jan 2026 23:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="B/Gh9Ilj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238EE288535
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Jan 2026 23:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769470045; cv=none; b=qgDxHBwAw0UaRIyIFRoQhyQua/wdGt3Ca/mkn0L07nTWhUWBSmLor9VmwpOQvV7rLPjBXhjSlGApox1lRAOvl8zoEo2E/3arnB5e2TavYUZhjlsgDgVZLqjYuZlqPmZRUvO+LEl0AV8HwAgM21LvZube5F+zwSGJE/XH0HAQVUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769470045; c=relaxed/simple;
	bh=FX8/pabwNfJ8niXx5NtwewhYY/Zq5tQDSCMqRKYhbUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lMCT4oRjH9rToqSM/jS2mvxUTDjfRYKxcMRv5+1M6TumM38vUo4myjTmM0AJTvSt5qblXDjZ2A/nfaMQpQvLjrm57xUBdSgWwQSyW3ko9ckq57I/eLcPo5eEW7DJc8H1AVbbC2EtsN6v412o4KI/RgpKyQYNcFsghkDu2mCq58c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=B/Gh9Ilj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47f3b7ef761so36390855e9.0
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Jan 2026 15:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769470041; x=1770074841; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=J9WWi0oM2TM5aSyIeftYWxrweXFW0ceNyFpRfgd2Wko=;
        b=B/Gh9Iljn/N6JCfMU6aOV8u4ZEgJpNcoojnQNYQobHWwcF7pjCsXpMmEWLYpi+N+UA
         d/xS34Ciw23AOJEb0jAiiXGMDIIIfkmsWv0WM80efCNuHsgEnHjL/E9mFFv8y22UzGlY
         G5aVMG3K8cVpvlcH3nR7ZSR5l71Wx0Bd1/y4c7brLQscQ1Tfin9oRKmtiNK5vWKg8AMS
         X1FuFQC+ixFlPhjZgVmM2//OrxM9m8TmvIb420KN4grfhWoUNCbH9pn5SDk/2pivgBKN
         WVGSRsSuC0efQhnt2gEnymo1ec51nZ2EzHnsSF2KWgK2dd1Z8TYy4kedjzyiMRnggkwp
         9oVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769470041; x=1770074841;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9WWi0oM2TM5aSyIeftYWxrweXFW0ceNyFpRfgd2Wko=;
        b=rLRqedeosCPsJMpuyPD1jnj3ufP4kqWTEctx5X9BZ0BxcKRO7Lhtee9XTZK923v+Ph
         Mp/fDJt35eaLtLro9omhoxaUO2fdWGPP2d+WOcrbbTwNoFwDt1rUM2c/OWB7PTjNawwS
         y1esN+pqyyXsuIJ2/xndwprAeeMm3bV5ROLy7LRfuVcbKyCgWmNYdCsS0PZ+yHVwEe1M
         eKhXIoELKFW6GdIRh9lyTBG2/6Ve4tljR9jisxZVPbTMibb+g5mWZ2/AK3ActhNY1Sdm
         w3SRKszAWha5I4Q3bq/NggEBuckQpFxhl7UuGvuooRiCIVRgQSxiFWtiXvJEv5H/2Cht
         aqJQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7S/Fl58d/r21OpQNvT8NcSVU7Nj+KS3LCxjWBzDKtWDlM7h76TYM+SY8EDbPbctg0oPzpTGzqHY5Y9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGe6O/xJ+OA32PhjPNdFPbY3Fd+Uj9xWKt6o7ZBxzcch3uUfrc
	dUrr91+aaULg6WgP9AKpSPqP2wF9p148GlaeWD+W3IdAACNd0SSsMtl+J6AFPQ7L6R4=
X-Gm-Gg: AZuq6aIktyCymm2ZHbuBtyqlhCV/9ji13+F1YhBSI7VF6YAT+vPWicj4Dy03KDLw0CU
	AAJKhXveAb3Tkd6FKOzPJN7UIRSb3UlETeZRarojZfiZZbjH27VWcAmdAcurSIJDo5ssrs/PnIu
	C2Dx4em1t1K1wMURozWdMvNU2R3Oe1/KOWCb/JVbpQoZljneA0WI9tGAKtLtiJjvtJx7Brv9s3I
	R0Siahz6vtqoGtqUtdkKtoeqpp1AlhP2CnXLh5ukUO7vAwUYwu8e9TtDCnMABcCXW41YFXnv7b9
	M+rsze7frbzR980WPWf1zuwBcYgYATnKRQ2Z/M2vyEa7aJaqGIdEjpLB4P+1zdO25zkOpGQKg+e
	GNdcReyH0hDGDJgvi8dgpWUGOMwm25hSV5t+Qhkmew0rLzo+SVKwAm9LifAUOZ8clSnKHYAnemu
	qThskE0QvsEB5g23oCkB+vBzHG8Hwps2x7Mhzf1wA=
X-Received: by 2002:a05:600c:6812:b0:480:32da:f33e with SMTP id 5b1f17b1804b1-4805cf668bfmr92176085e9.17.1769470041207;
        Mon, 26 Jan 2026 15:27:21 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3536f112f22sm4441295a91.5.2026.01.26.15.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 15:27:20 -0800 (PST)
Message-ID: <456744a8-71c7-4473-94c5-53a93864bf9f@suse.com>
Date: Tue, 27 Jan 2026 09:57:16 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: collect untracked allocation stats
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <e42e7c06710b0406ac548739945b386d8319b48e.1747095022.git.boris@bur.io>
 <95f5c89f52556f69decc7f18a6fd1f2c09d711c9.1747095560.git.boris@bur.io>
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
In-Reply-To: <95f5c89f52556f69decc7f18a6fd1f2c09d711c9.1747095560.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21089-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bur.io:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 880038E325
X-Rspamd-Action: no action



在 2025/5/13 09:52, Boris Burkov 写道:
> We allocate memory for extent_buffers and compressed io in a manner that
> isn't tracked by any memory statistic.

IIRC extent buffers are tracked in btree inode, as we only allocate a 
folio then attach it to the btree inode's page cache.

Thus only dummy extent buffers need real long term tracking.

It's still fine to keep tracking those eb folios even if they are 
attached to the filemap, it may make some curious guys wonder why it's 
larger than all the memory avaiable with all mm and btrfs numbers added.


For compressed folios, I see your solution is just to track the alloc 
and release, without bothering the per-module caching, that's a good 
idea but again it means we under calculate the number, not covering the 
full lifespan of compressed folios.

> It is, in principle, possible to
> sort of track this memory by subtracting all trackable allocations from
> the total memory and comparing to the amount free, but that is clumsy to
> do, breaks when new memory accounting is added in the mm subsystem and
> lacks any useful granularity.

And memory hot plug will also screw up the substracting method.

> 
> This RFC proposes explicitly tracking btrfs's untracked allocations and
> reporting them in /sys/fs/btrfs/<uuid>/memory_stats.
> 
> Open questions:
> 1. Is this useful?

To me, I believe it can be a cheaper version of kmemleak. Perfect for 
CONFIG_BTRFS_DEBUG builds.
Thus if some error/warning can be emitted at close_ctree() time, it will 
be awesome.


I would still recommend to get rid of the per-module compression folio 
pool as the first step to get a more correct accounting for compression 
folios.

Personally speaking I do not feel that comfortable to maintain an 
internal pool.
I always believe the MM is more clever than us regarding memory allocation.

And large bs support is already making the compr pool less useful anyway.

> 2. What is the best concurrency model? I experimented with percpu
>     variables which I don't think allow us to split it by fs_info in a
>     reasonable way (short of dynamically growing a pointed-to percpu
>     array as we add fs-es). I haven't thought too hard between spinlock,
>     atomic, etc..

I guess spinlock would be good enough? Memory allocation will take 
longer time than our tiny spinlock duration anyway.

And the overhead will never be as large as kmemleak.

> 3. Am I missing any classes of untracked allocations?

Scrub is also a user of such folio allocation.

Thanks,
Qu

> 
> If this does sound like a good idea to people, I will work harder on
> validating the correctness of the data and picking an optimal
> concurrency model. So far, I've just run fstests with this patch.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
> Note: Resent with a completely dumb work-in-progress commit on the
> sysfs.c code squashed in. This one should actually apply/compile..
> 
>   fs/btrfs/compression.c | 31 +++++++++++++++++++++++++++----
>   fs/btrfs/compression.h |  6 ++++--
>   fs/btrfs/extent_io.c   | 23 ++++++++++++++++++++++-
>   fs/btrfs/fs.h          | 10 ++++++++++
>   fs/btrfs/inode.c       | 16 ++++++++++------
>   fs/btrfs/lzo.c         | 10 ++++++----
>   fs/btrfs/sysfs.c       | 15 +++++++++++++++
>   fs/btrfs/zlib.c        | 16 +++++++---------
>   fs/btrfs/zstd.c        | 16 +++++++---------
>   9 files changed, 108 insertions(+), 35 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 48d07939fee4..988887cc79ff 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -160,8 +160,10 @@ static int compression_decompress(int type, struct list_head *ws,
>   
>   static void btrfs_free_compressed_folios(struct compressed_bio *cb)
>   {
> +	struct btrfs_fs_info *fs_info = cb->bbio.inode->root->fs_info;
> +
>   	for (unsigned int i = 0; i < cb->nr_folios; i++)
> -		btrfs_free_compr_folio(cb->compressed_folios[i]);
> +		btrfs_free_compr_folio(fs_info, cb->compressed_folios[i]);
>   	kfree(cb->compressed_folios);
>   }
>   
> @@ -223,7 +225,7 @@ static unsigned long btrfs_compr_pool_scan(struct shrinker *sh, struct shrink_co
>   /*
>    * Common wrappers for page allocation from compression wrappers
>    */
> -struct folio *btrfs_alloc_compr_folio(void)
> +struct folio *btrfs_alloc_compr_folio(struct btrfs_fs_info *fs_info)
>   {
>   	struct folio *folio = NULL;
>   
> @@ -238,10 +240,13 @@ struct folio *btrfs_alloc_compr_folio(void)
>   	if (folio)
>   		return folio;
>   
> -	return folio_alloc(GFP_NOFS, 0);
> +	folio = folio_alloc(GFP_NOFS, 0);
> +	if (folio)
> +		btrfs_inc_compressed_io_folios(fs_info);
> +	return folio;
>   }
>   
> -void btrfs_free_compr_folio(struct folio *folio)
> +void btrfs_free_compr_folio(struct btrfs_fs_info *fs_info, struct folio *folio)
>   {
>   	bool do_free = false;
>   
> @@ -259,6 +264,22 @@ void btrfs_free_compr_folio(struct folio *folio)
>   
>   	ASSERT(folio_ref_count(folio) == 1);
>   	folio_put(folio);
> +	btrfs_dec_compressed_io_folios(fs_info);
> +}
> +
> +void btrfs_inc_compressed_io_folios(struct btrfs_fs_info *fs_info) {
> +	spin_lock(&fs_info->memory_stats_lock);
> +	fs_info->memory_stats.nr_compressed_io_folios++;
> +	spin_unlock(&fs_info->memory_stats_lock);
> +}
> +
> +void btrfs_dec_compressed_io_folios(struct btrfs_fs_info *fs_info)
> +{
> +	spin_lock(&fs_info->memory_stats_lock);
> +	ASSERT(fs_info->memory_stats.nr_compressed_io_folios > 0,
> +	       "%lu", fs_info->memory_stats.nr_compressed_io_folios);
> +	fs_info->memory_stats.nr_compressed_io_folios--;
> +	spin_unlock(&fs_info->memory_stats_lock);
>   }
>   
>   static void end_bbio_compressed_read(struct btrfs_bio *bbio)
> @@ -617,6 +638,8 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
>   		status = BLK_STS_RESOURCE;
>   		goto out_free_compressed_pages;
>   	}
> +	for (int i = 0; i < cb->nr_folios; i++)
> +		btrfs_inc_compressed_io_folios(fs_info);
>   
>   	add_ra_bio_pages(&inode->vfs_inode, em_start + em_len, cb, &memstall,
>   			 &pflags);
> diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
> index d34c4341eaf4..a72a58337c76 100644
> --- a/fs/btrfs/compression.h
> +++ b/fs/btrfs/compression.h
> @@ -105,8 +105,8 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio);
>   
>   int btrfs_compress_str2level(unsigned int type, const char *str);
>   
> -struct folio *btrfs_alloc_compr_folio(void);
> -void btrfs_free_compr_folio(struct folio *folio);
> +struct folio *btrfs_alloc_compr_folio(struct btrfs_fs_info *fs_info);
> +void btrfs_free_compr_folio(struct btrfs_fs_info *fs_info, struct folio *folio);
>   
>   enum btrfs_compression_type {
>   	BTRFS_COMPRESS_NONE  = 0,
> @@ -188,5 +188,7 @@ struct list_head *zstd_alloc_workspace(int level);
>   void zstd_free_workspace(struct list_head *ws);
>   struct list_head *zstd_get_workspace(int level);
>   void zstd_put_workspace(struct list_head *ws);
> +void btrfs_inc_compressed_io_folios(struct btrfs_fs_info *fs_info);
> +void btrfs_dec_compressed_io_folios(struct btrfs_fs_info *fs_info);
>   
>   #endif
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 281bb036fcb8..56e036ee3c87 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -611,6 +611,22 @@ int btrfs_alloc_page_array(unsigned int nr_pages, struct page **page_array,
>   	return 0;
>   }
>   
> +static void inc_extent_buffer_folios(struct btrfs_fs_info *fs_info)
> +{
> +	spin_lock(&fs_info->memory_stats_lock);
> +	fs_info->memory_stats.nr_extent_buffer_folios++;
> +	spin_unlock(&fs_info->memory_stats_lock);
> +}
> +
> +static void dec_extent_buffer_folios(struct btrfs_fs_info *fs_info)
> +{
> +	spin_lock(&fs_info->memory_stats_lock);
> +	ASSERT(fs_info->memory_stats.nr_extent_buffer_folios > 0,
> +	       "%lu", fs_info->memory_stats.nr_extent_buffer_folios);
> +	fs_info->memory_stats.nr_extent_buffer_folios--;
> +	spin_unlock(&fs_info->memory_stats_lock);
> +}
> +
>   /*
>    * Populate needed folios for the extent buffer.
>    *
> @@ -626,8 +642,10 @@ static int alloc_eb_folio_array(struct extent_buffer *eb, bool nofail)
>   	if (ret < 0)
>   		return ret;
>   
> -	for (int i = 0; i < num_pages; i++)
> +	for (int i = 0; i < num_pages; i++) {
>   		eb->folios[i] = page_folio(page_array[i]);
> +		inc_extent_buffer_folios(eb->fs_info);
> +	}
>   	eb->folio_size = PAGE_SIZE;
>   	eb->folio_shift = PAGE_SHIFT;
>   	return 0;
> @@ -2816,6 +2834,7 @@ static void btrfs_release_extent_buffer_folios(const struct extent_buffer *eb)
>   			continue;
>   
>   		detach_extent_buffer_folio(eb, folio);
> +		dec_extent_buffer_folios(eb->fs_info);
>   	}
>   }
>   
> @@ -2865,6 +2884,7 @@ static void cleanup_extent_buffer_folios(struct extent_buffer *eb)
>   		detach_extent_buffer_folio(eb, eb->folios[i]);
>   		folio_put(eb->folios[i]);
>   		eb->folios[i] = NULL;
> +		dec_extent_buffer_folios(eb->fs_info);
>   	}
>   }
>   
> @@ -3418,6 +3438,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
>   		ASSERT(!folio_test_private(folio));
>   		folio_put(folio);
>   		eb->folios[i] = NULL;
> +		dec_extent_buffer_folios(eb->fs_info);
>   	}
>   	btrfs_release_extent_buffer(eb);
>   	if (ret < 0)
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 4394de12a767..47a66251ed1f 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -3,6 +3,7 @@
>   #ifndef BTRFS_FS_H
>   #define BTRFS_FS_H
>   
> +#include "compression.h"
>   #include <linux/blkdev.h>
>   #include <linux/sizes.h>
>   #include <linux/time64.h>
> @@ -422,6 +423,11 @@ struct btrfs_commit_stats {
>   	u64 total_commit_dur;
>   };
>   
> +struct btrfs_memory_stats {
> +	unsigned long nr_compressed_io_folios;
> +	unsigned long nr_extent_buffer_folios;
> +};
> +
>   struct btrfs_fs_info {
>   	u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
>   	unsigned long flags;
> @@ -866,6 +872,9 @@ struct btrfs_fs_info {
>   	/* Updates are not protected by any lock */
>   	struct btrfs_commit_stats commit_stats;
>   
> +	spinlock_t memory_stats_lock;
> +	struct btrfs_memory_stats memory_stats;
> +
>   	/*
>   	 * Last generation where we dropped a non-relocation root.
>   	 * Use btrfs_set_last_root_drop_gen() and btrfs_get_last_root_drop_gen()
> @@ -897,6 +906,7 @@ struct btrfs_fs_info {
>   #endif
>   };
>   
> +
>   #define folio_to_inode(_folio)	(BTRFS_I(_Generic((_folio),			\
>   					  struct folio *: (_folio))->mapping->host))
>   
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 964088d3f3f7..6a19f13d2eb6 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1026,13 +1026,14 @@ static void compress_file_range(struct btrfs_work *work)
>   	if (folios) {
>   		for (i = 0; i < nr_folios; i++) {
>   			WARN_ON(folios[i]->mapping);
> -			btrfs_free_compr_folio(folios[i]);
> +			btrfs_free_compr_folio(fs_info, folios[i]);
>   		}
>   		kfree(folios);
>   	}
>   }
>   
> -static void free_async_extent_pages(struct async_extent *async_extent)
> +static void free_async_extent_pages(struct btrfs_fs_info *fs_info,
> +				    struct async_extent *async_extent)
>   {
>   	int i;
>   
> @@ -1041,7 +1042,7 @@ static void free_async_extent_pages(struct async_extent *async_extent)
>   
>   	for (i = 0; i < async_extent->nr_folios; i++) {
>   		WARN_ON(async_extent->folios[i]->mapping);
> -		btrfs_free_compr_folio(async_extent->folios[i]);
> +		btrfs_free_compr_folio(fs_info, async_extent->folios[i]);
>   	}
>   	kfree(async_extent->folios);
>   	async_extent->nr_folios = 0;
> @@ -1175,7 +1176,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
>   	if (async_chunk->blkcg_css)
>   		kthread_associate_blkcg(NULL);
>   	if (free_pages)
> -		free_async_extent_pages(async_extent);
> +		free_async_extent_pages(fs_info, async_extent);
>   	kfree(async_extent);
>   	return;
>   
> @@ -1190,7 +1191,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
>   				     EXTENT_DEFRAG | EXTENT_DO_ACCOUNTING,
>   				     PAGE_UNLOCK | PAGE_START_WRITEBACK |
>   				     PAGE_END_WRITEBACK);
> -	free_async_extent_pages(async_extent);
> +	free_async_extent_pages(fs_info, async_extent);
>   	if (async_chunk->blkcg_css)
>   		kthread_associate_blkcg(NULL);
>   	btrfs_debug(fs_info,
> @@ -9723,6 +9724,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
>   			ret = -ENOMEM;
>   			goto out_folios;
>   		}
> +		btrfs_inc_compressed_io_folios(fs_info);
>   		kaddr = kmap_local_folio(folios[i], 0);
>   		if (copy_from_iter(kaddr, bytes, from) != bytes) {
>   			kunmap_local(kaddr);
> @@ -9845,8 +9847,10 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
>   	btrfs_unlock_extent(io_tree, start, end, &cached_state);
>   out_folios:
>   	for (i = 0; i < nr_folios; i++) {
> -		if (folios[i])
> +		if (folios[i]) {
>   			folio_put(folios[i]);
> +			btrfs_dec_compressed_io_folios(fs_info);
> +		}
>   	}
>   	kvfree(folios);
>   out:
> diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
> index d403641889ca..741cf70375a9 100644
> --- a/fs/btrfs/lzo.c
> +++ b/fs/btrfs/lzo.c
> @@ -128,7 +128,8 @@ static inline size_t read_compress_length(const char *buf)
>    *
>    * Will allocate new pages when needed.
>    */
> -static int copy_compressed_data_to_page(char *compressed_data,
> +static int copy_compressed_data_to_page(struct btrfs_fs_info *fs_info,
> +					char *compressed_data,
>   					size_t compressed_size,
>   					struct folio **out_folios,
>   					unsigned long max_nr_folio,
> @@ -152,7 +153,7 @@ static int copy_compressed_data_to_page(char *compressed_data,
>   	cur_folio = out_folios[*cur_out / PAGE_SIZE];
>   	/* Allocate a new page */
>   	if (!cur_folio) {
> -		cur_folio = btrfs_alloc_compr_folio();
> +		cur_folio = btrfs_alloc_compr_folio(fs_info);
>   		if (!cur_folio)
>   			return -ENOMEM;
>   		out_folios[*cur_out / PAGE_SIZE] = cur_folio;
> @@ -178,7 +179,7 @@ static int copy_compressed_data_to_page(char *compressed_data,
>   		cur_folio = out_folios[*cur_out / PAGE_SIZE];
>   		/* Allocate a new page */
>   		if (!cur_folio) {
> -			cur_folio = btrfs_alloc_compr_folio();
> +			cur_folio = btrfs_alloc_compr_folio(fs_info);
>   			if (!cur_folio)
>   				return -ENOMEM;
>   			out_folios[*cur_out / PAGE_SIZE] = cur_folio;
> @@ -213,6 +214,7 @@ int lzo_compress_folios(struct list_head *ws, struct address_space *mapping,
>   			u64 start, struct folio **folios, unsigned long *out_folios,
>   			unsigned long *total_in, unsigned long *total_out)
>   {
> +	struct btrfs_fs_info *fs_info = BTRFS_I(mapping->host)->root->fs_info;
>   	struct workspace *workspace = list_entry(ws, struct workspace, list);
>   	const u32 sectorsize = inode_to_fs_info(mapping->host)->sectorsize;
>   	struct folio *folio_in = NULL;
> @@ -263,7 +265,7 @@ int lzo_compress_folios(struct list_head *ws, struct address_space *mapping,
>   			goto out;
>   		}
>   
> -		ret = copy_compressed_data_to_page(workspace->cbuf, out_len,
> +		ret = copy_compressed_data_to_page(fs_info, workspace->cbuf, out_len,
>   						   folios, max_nr_folio,
>   						   &cur_out, sectorsize);
>   		if (ret < 0)
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 5d93d9dd2c12..ff4ae6dd9e5c 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1132,6 +1132,20 @@ static ssize_t btrfs_sectorsize_show(struct kobject *kobj,
>   	return sysfs_emit(buf, "%u\n", fs_info->sectorsize);
>   }
>   
> +static ssize_t btrfs_memory_stats_show(struct kobject *kobj,
> +                                        struct kobj_attribute *a, char *buf)
> +{
> +	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
> +	struct btrfs_memory_stats *memory_stats = &fs_info->memory_stats;
> +
> +	return sysfs_emit(buf,
> +			  "compressed_io_folios %lu\n"
> +			  "extent_buffer_folios %lu\n",
> +			  memory_stats->nr_compressed_io_folios,
> +			  memory_stats->nr_extent_buffer_folios);
> +}
> +
> +BTRFS_ATTR(, memory_stats, btrfs_memory_stats_show);
>   BTRFS_ATTR(, sectorsize, btrfs_sectorsize_show);
>   
>   static ssize_t btrfs_commit_stats_show(struct kobject *kobj,
> @@ -1588,6 +1602,7 @@ static const struct attribute *btrfs_attrs[] = {
>   	BTRFS_ATTR_PTR(, bg_reclaim_threshold),
>   	BTRFS_ATTR_PTR(, commit_stats),
>   	BTRFS_ATTR_PTR(, temp_fsid),
> +	BTRFS_ATTR_PTR(, memory_stats),
>   #ifdef CONFIG_BTRFS_EXPERIMENTAL
>   	BTRFS_ATTR_PTR(, offload_csum),
>   #endif
> diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
> index 5292cd341f70..56dd7acaa50b 100644
> --- a/fs/btrfs/zlib.c
> +++ b/fs/btrfs/zlib.c
> @@ -137,6 +137,8 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
>   			 u64 start, struct folio **folios, unsigned long *out_folios,
>   			 unsigned long *total_in, unsigned long *total_out)
>   {
> +	struct btrfs_inode *inode = BTRFS_I(mapping->host);
> +	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>   	struct workspace *workspace = list_entry(ws, struct workspace, list);
>   	int ret;
>   	char *data_in = NULL;
> @@ -155,9 +157,7 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
>   
>   	ret = zlib_deflateInit(&workspace->strm, workspace->level);
>   	if (unlikely(ret != Z_OK)) {
> -		struct btrfs_inode *inode = BTRFS_I(mapping->host);
> -
> -		btrfs_err(inode->root->fs_info,
> +		btrfs_err(fs_info,
>   	"zlib compression init failed, error %d root %llu inode %llu offset %llu",
>   			  ret, btrfs_root_id(inode->root), btrfs_ino(inode), start);
>   		ret = -EIO;
> @@ -167,7 +167,7 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
>   	workspace->strm.total_in = 0;
>   	workspace->strm.total_out = 0;
>   
> -	out_folio = btrfs_alloc_compr_folio();
> +	out_folio = btrfs_alloc_compr_folio(fs_info);
>   	if (out_folio == NULL) {
>   		ret = -ENOMEM;
>   		goto out;
> @@ -225,9 +225,7 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
>   
>   		ret = zlib_deflate(&workspace->strm, Z_SYNC_FLUSH);
>   		if (unlikely(ret != Z_OK)) {
> -			struct btrfs_inode *inode = BTRFS_I(mapping->host);
> -
> -			btrfs_warn(inode->root->fs_info,
> +			btrfs_warn(fs_info,
>   		"zlib compression failed, error %d root %llu inode %llu offset %llu",
>   				   ret, btrfs_root_id(inode->root), btrfs_ino(inode),
>   				   start);
> @@ -252,7 +250,7 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
>   				ret = -E2BIG;
>   				goto out;
>   			}
> -			out_folio = btrfs_alloc_compr_folio();
> +			out_folio = btrfs_alloc_compr_folio(fs_info);
>   			if (out_folio == NULL) {
>   				ret = -ENOMEM;
>   				goto out;
> @@ -288,7 +286,7 @@ int zlib_compress_folios(struct list_head *ws, struct address_space *mapping,
>   				ret = -E2BIG;
>   				goto out;
>   			}
> -			out_folio = btrfs_alloc_compr_folio();
> +			out_folio = btrfs_alloc_compr_folio(fs_info);
>   			if (out_folio == NULL) {
>   				ret = -ENOMEM;
>   				goto out;
> diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
> index 4a796a049b5a..77cf8a605532 100644
> --- a/fs/btrfs/zstd.c
> +++ b/fs/btrfs/zstd.c
> @@ -389,6 +389,8 @@ int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
>   			 u64 start, struct folio **folios, unsigned long *out_folios,
>   			 unsigned long *total_in, unsigned long *total_out)
>   {
> +	struct btrfs_inode *inode = BTRFS_I(mapping->host);
> +	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>   	struct workspace *workspace = list_entry(ws, struct workspace, list);
>   	zstd_cstream *stream;
>   	int ret = 0;
> @@ -412,8 +414,6 @@ int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
>   	stream = zstd_init_cstream(&workspace->params, len, workspace->mem,
>   			workspace->size);
>   	if (unlikely(!stream)) {
> -		struct btrfs_inode *inode = BTRFS_I(mapping->host);
> -
>   		btrfs_err(inode->root->fs_info,
>   	"zstd compression init level %d failed, root %llu inode %llu offset %llu",
>   			  workspace->req_level, btrfs_root_id(inode->root),
> @@ -432,7 +432,7 @@ int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
>   	workspace->in_buf.size = cur_len;
>   
>   	/* Allocate and map in the output buffer */
> -	out_folio = btrfs_alloc_compr_folio();
> +	out_folio = btrfs_alloc_compr_folio(fs_info);
>   	if (out_folio == NULL) {
>   		ret = -ENOMEM;
>   		goto out;
> @@ -448,9 +448,7 @@ int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
>   		ret2 = zstd_compress_stream(stream, &workspace->out_buf,
>   				&workspace->in_buf);
>   		if (unlikely(zstd_is_error(ret2))) {
> -			struct btrfs_inode *inode = BTRFS_I(mapping->host);
> -
> -			btrfs_warn(inode->root->fs_info,
> +			btrfs_warn(fs_info,
>   "zstd compression level %d failed, error %d root %llu inode %llu offset %llu",
>   				   workspace->req_level, zstd_get_error_code(ret2),
>   				   btrfs_root_id(inode->root), btrfs_ino(inode),
> @@ -482,7 +480,7 @@ int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
>   				ret = -E2BIG;
>   				goto out;
>   			}
> -			out_folio = btrfs_alloc_compr_folio();
> +			out_folio = btrfs_alloc_compr_folio(fs_info);
>   			if (out_folio == NULL) {
>   				ret = -ENOMEM;
>   				goto out;
> @@ -525,7 +523,7 @@ int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
>   		if (unlikely(zstd_is_error(ret2))) {
>   			struct btrfs_inode *inode = BTRFS_I(mapping->host);
>   
> -			btrfs_err(inode->root->fs_info,
> +			btrfs_err(fs_info,
>   "zstd compression end level %d failed, error %d root %llu inode %llu offset %llu",
>   				  workspace->req_level, zstd_get_error_code(ret2),
>   				  btrfs_root_id(inode->root), btrfs_ino(inode),
> @@ -549,7 +547,7 @@ int zstd_compress_folios(struct list_head *ws, struct address_space *mapping,
>   			ret = -E2BIG;
>   			goto out;
>   		}
> -		out_folio = btrfs_alloc_compr_folio();
> +		out_folio = btrfs_alloc_compr_folio(fs_info);
>   		if (out_folio == NULL) {
>   			ret = -ENOMEM;
>   			goto out;


