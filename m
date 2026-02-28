Return-Path: <linux-btrfs+bounces-22113-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPzWMbJio2myBQUAu9opvQ
	(envelope-from <linux-btrfs+bounces-22113-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 22:48:34 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 375821C9433
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 22:48:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C635930BF297
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 20:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F8521FF2E;
	Sat, 28 Feb 2026 20:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GKdte/HR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4921239E80
	for <linux-btrfs@vger.kernel.org>; Sat, 28 Feb 2026 20:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772311019; cv=none; b=PX+ufAbgUqilZim4mCRmRMKzkFRssC6syKaGXv3kJQmbRl11iXMugQex+4r8oT6uMxabcCdlHv6sV+rwfgmNHgZxFjWSgce7Vx9k/gdgU11c/os0/tEAycjHMdN8xtbeEGCB7f+4jhJxula/DgyLiGTczGz3FbjIwBcxAGdIDfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772311019; c=relaxed/simple;
	bh=vc9k3OXnxCTHMvIfEKzRYr8xannNlsoWmBjFWKl2K0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iIREqXy/12MwqWAwjpolWf2v5RODaQ5Q9QyTLj/1Cgag83XJxrqhbeuws39n6roE3f8jn3AFl2HTkr0gkvmlY+CWmiz4XCrUgvaKDz16kdPU/UQttGL8RKH5BgFiV7sUAfKjMu86ZgzZ4M5AeGhiaKM1tgT05bhtOXyd33aTl4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GKdte/HR; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-483a2338616so19598785e9.0
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Feb 2026 12:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772311015; x=1772915815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pnCeaY0qXKtE1UeIEfUhh4DNvlbGHafMAe7iB1g0TL0=;
        b=GKdte/HR2V+Vxr9nGiZjIso87LOKrC2DFrqneMIXocWYbmJh8OwWbnR39W/JAmNHkf
         TuUHobjpX4YtgHN3/AGBWI9TRPvIttjSZwN3V9DNbmLWzNnBmY9Dl34rChXY6IJrYKSj
         3Xx7NLayu57gvaymtrwzerOBGUJD//A4Cb7yBQ0tzcwf1jjJFb2PrlCLdCt2lZf678P4
         ccGrgTkQaM3oL0v8Vkp8d9dV05L69hwDuaGQgzwXT1WwnJfB6AE+JptrDtWbuvKcCqlf
         hot6JhS+38EGDe+CIfBavA4v8QS9oy3rrbpwealjtCm28i5EELGPX4Gxe54US+7SP33Q
         VlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772311015; x=1772915815;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnCeaY0qXKtE1UeIEfUhh4DNvlbGHafMAe7iB1g0TL0=;
        b=ZFW1toqvE+FImaQBiPl9qJw/fch0vPtf4SUGSxlIx/4NNEelACBbioVRRLH418EUML
         A+be129AAbMpaLcITjHigduwhFL7uKY6H9ebywGHv221JmSHqux+x4heHnaCImntfqaT
         JSHPIMDK7uBlmzhxvt/V7UEljTHZeE8KAyl5Q3uSJngysYMj0TIEGo4msQ3E8hGel4ej
         8/q1GqyWKIbfHAVcAOwiQXVY01zGWHegNZOZyW0f9jfVu1seGwpucWw6TsoqUKtaO1LX
         byWSyLFSKCwkhFLWQUskTO8vKlOKgHlYBE32iNYJawsjsFJRQGo/GqnaoWx31QUBmsS8
         wpxg==
X-Forwarded-Encrypted: i=1; AJvYcCVmAr/JPu2tSXpm6p9i60cUGJihjFFOAzUnZB1z2J5qVL5KtYuWO/KXtpKCawEgsg3H/7pkd9Cg5ic9aQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8cirYrJoy2meAGT8Svd3E6uqnDnyfBfN+t8LstsNYPVjIzB4P
	z09bTpI2y+NSZyWNgo9vY/rXn57dejJMgh6L5+mAW15bIeDS0Pl2IFob5+YM4pibgb8=
X-Gm-Gg: ATEYQzwubcu+guk9uYz+kB6cMbxvzJKtPFxOReZU07DvrHSqgieaJgPPWrUZ3u8Fl3U
	6E2NK9woBVry6t2wRMsiDYKsiI4YcjQ+EgKqQlOE2/dLUKtrYbQ0bqxisu6x8WejoqeO4LLiqG0
	U3WhQE3UBgJuysZBSsQTC+L+FTg/snnLZfff0Pf0Zdrh337xmtYroDJGpOtZsVVUWQHiMTVTJvv
	tBoi2YfgC9adMc6QYmNNDxn9ROSRqWFvia2atOmqOILJJQuFdsUE8oTfT4cVDh6z9rLYDH8OTIC
	lIIdfKP0q/n7wyfd5/FMccqtACSqPNrM25zQSXMLinC3KunWXsH2LhEXN6JRn/M/kVz3vEp0fhx
	YehdrEb2VS9qcnkYyX7JeLGHtsQHIvA8vqvj8BBDGWsIwF+1SGwpsuLG87Zceq1b0HJ085icX1x
	U9RVH+34W3G0rpfEPcK96JDE75+0i23cSMtp8jSyYdqGCgsSoAUF0=
X-Received: by 2002:a05:600c:4591:b0:482:eec4:74c with SMTP id 5b1f17b1804b1-483c9bf0b3cmr112486405e9.22.1772311015053;
        Sat, 28 Feb 2026 12:36:55 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6b4177sm94307705ad.62.2026.02.28.12.36.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 12:36:54 -0800 (PST)
Message-ID: <631ecd7a-e02a-47c8-8833-7d1a012a1901@suse.com>
Date: Sun, 1 Mar 2026 07:06:41 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] btrfs: replace BUG() with error handling in
 compression.c
To: Adarsh Das <adarshdas950@gmail.com>, clm@fb.com, dsterba@suse.com
Cc: terrelln@fb.com, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260228090621.100841-1-adarshdas950@gmail.com>
 <20260228090621.100841-2-adarshdas950@gmail.com>
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
In-Reply-To: <20260228090621.100841-2-adarshdas950@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22113-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,fb.com,suse.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 375821C9433
X-Rspamd-Action: no action



在 2026/2/28 19:36, Adarsh Das 写道:
> v2:
> - use ASSERT() instead of btrfs_err() + -EUCLEAN
> - remove default: branches and add upfront ASSERT() for type validation
> - fold coding style fixes into this patch

Please put proper commit message other than change log here.

Especially if you have put a changelog in the cover letter, there is no 
need to re-mention it again in each patch.

> 
> Signed-off-by: Adarsh Das <adarshdas950@gmail.com>
> ---
>   fs/btrfs/compression.c | 74 ++++++++++++++----------------------------
>   1 file changed, 25 insertions(+), 49 deletions(-)
> 
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 790518a8c803..0d8da8ce5fd3 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -36,9 +36,9 @@
>   
>   static struct bio_set btrfs_compressed_bioset;
>   
> -static const char* const btrfs_compress_types[] = { "", "zlib", "lzo", "zstd" };
> +static const char * const btrfs_compress_types[] = { "", "zlib", "lzo", "zstd" };
>   
> -const char* btrfs_compress_type2str(enum btrfs_compression_type type)
> +const char *btrfs_compress_type2str(enum btrfs_compression_type type)
>   {
>   	switch (type) {
>   	case BTRFS_COMPRESS_ZLIB:
> @@ -89,24 +89,21 @@ bool btrfs_compress_is_valid_type(const char *str, size_t len)
>   static int compression_decompress_bio(struct list_head *ws,
>   				      struct compressed_bio *cb)
>   {
> +	ASSERT(cb->compress_type > BTRFS_COMPRESS_NONE &&
> +	       cb->compress_type < BTRFS_NR_COMPRESS_TYPES);
>   	switch (cb->compress_type) {
>   	case BTRFS_COMPRESS_ZLIB: return zlib_decompress_bio(ws, cb);
>   	case BTRFS_COMPRESS_LZO:  return lzo_decompress_bio(ws, cb);
>   	case BTRFS_COMPRESS_ZSTD: return zstd_decompress_bio(ws, cb);
> -	case BTRFS_COMPRESS_NONE:
> -	default:
> -		/*
> -		 * This can't happen, the type is validated several times
> -		 * before we get here.
> -		 */
> -		BUG();
>   	}
> +	return -EUCLEAN;
>   }
>   
>   static int compression_decompress(int type, struct list_head *ws,
>   		const u8 *data_in, struct folio *dest_folio,
>   		unsigned long dest_pgoff, size_t srclen, size_t destlen)
>   {
> +	ASSERT(type > BTRFS_COMPRESS_NONE && type < BTRFS_NR_COMPRESS_TYPES);
>   	switch (type) {
>   	case BTRFS_COMPRESS_ZLIB: return zlib_decompress(ws, data_in, dest_folio,
>   						dest_pgoff, srclen, destlen);
> @@ -114,14 +111,8 @@ static int compression_decompress(int type, struct list_head *ws,
>   						dest_pgoff, srclen, destlen);
>   	case BTRFS_COMPRESS_ZSTD: return zstd_decompress(ws, data_in, dest_folio,
>   						dest_pgoff, srclen, destlen);
> -	case BTRFS_COMPRESS_NONE:
> -	default:
> -		/*
> -		 * This can't happen, the type is validated several times
> -		 * before we get here.
> -		 */
> -		BUG();
>   	}
> +	return -EUCLEAN;
>   }
>   
>   static int btrfs_decompress_bio(struct compressed_bio *cb);
> @@ -484,6 +475,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
>   
>   			if (zero_offset) {
>   				int zeros;
> +
>   				zeros = folio_size(folio) - zero_offset;
>   				folio_zero_range(folio, zero_offset, zeros);
>   			}
> @@ -697,33 +689,25 @@ static const struct btrfs_compress_levels * const btrfs_compress_levels[] = {
>   
>   static struct list_head *alloc_workspace(struct btrfs_fs_info *fs_info, int type, int level)
>   {
> +
> +	ASSERT(type >= BTRFS_COMPRESS_NONE && type < BTRFS_NR_COMPRESS_TYPES);
>   	switch (type) {
>   	case BTRFS_COMPRESS_NONE: return alloc_heuristic_ws(fs_info);
>   	case BTRFS_COMPRESS_ZLIB: return zlib_alloc_workspace(fs_info, level);
>   	case BTRFS_COMPRESS_LZO:  return lzo_alloc_workspace(fs_info);
>   	case BTRFS_COMPRESS_ZSTD: return zstd_alloc_workspace(fs_info, level);
> -	default:
> -		/*
> -		 * This can't happen, the type is validated several times
> -		 * before we get here.
> -		 */
> -		BUG();
>   	}
> +	return ERR_PTR(-EUCLEAN);
>   }
>   
>   static void free_workspace(int type, struct list_head *ws)
>   {
> +	ASSERT(type >= BTRFS_COMPRESS_NONE && type < BTRFS_NR_COMPRESS_TYPES);
>   	switch (type) {
>   	case BTRFS_COMPRESS_NONE: return free_heuristic_ws(ws);
>   	case BTRFS_COMPRESS_ZLIB: return zlib_free_workspace(ws);
>   	case BTRFS_COMPRESS_LZO:  return lzo_free_workspace(ws);
>   	case BTRFS_COMPRESS_ZSTD: return zstd_free_workspace(ws);
> -	default:
> -		/*
> -		 * This can't happen, the type is validated several times
> -		 * before we get here.
> -		 */
> -		BUG();
>   	}
>   }
>   
> @@ -792,7 +776,7 @@ struct list_head *btrfs_get_workspace(struct btrfs_fs_info *fs_info, int type, i
>   	struct workspace_manager *wsm = fs_info->compr_wsm[type];
>   	struct list_head *workspace;
>   	int cpus = num_online_cpus();
> -	unsigned nofs_flag;
> +	unsigned int nofs_flag;
>   	struct list_head *idle_ws;
>   	spinlock_t *ws_lock;
>   	atomic_t *total_ws;
> @@ -868,18 +852,14 @@ struct list_head *btrfs_get_workspace(struct btrfs_fs_info *fs_info, int type, i
>   
>   static struct list_head *get_workspace(struct btrfs_fs_info *fs_info, int type, int level)
>   {
> +	ASSERT(type >= BTRFS_COMPRESS_NONE && type < BTRFS_NR_COMPRESS_TYPES);
>   	switch (type) {
>   	case BTRFS_COMPRESS_NONE: return btrfs_get_workspace(fs_info, type, level);
>   	case BTRFS_COMPRESS_ZLIB: return zlib_get_workspace(fs_info, level);
>   	case BTRFS_COMPRESS_LZO:  return btrfs_get_workspace(fs_info, type, level);
>   	case BTRFS_COMPRESS_ZSTD: return zstd_get_workspace(fs_info, level);
> -	default:
> -		/*
> -		 * This can't happen, the type is validated several times
> -		 * before we get here.
> -		 */
> -		BUG();
>   	}
> +	return ERR_PTR(-EUCLEAN);
>   }
>   
>   /*
> @@ -919,17 +899,12 @@ void btrfs_put_workspace(struct btrfs_fs_info *fs_info, int type, struct list_he
>   
>   static void put_workspace(struct btrfs_fs_info *fs_info, int type, struct list_head *ws)
>   {
> +	ASSERT(type >= BTRFS_COMPRESS_NONE && type < BTRFS_NR_COMPRESS_TYPES);
>   	switch (type) {
>   	case BTRFS_COMPRESS_NONE: return btrfs_put_workspace(fs_info, type, ws);
>   	case BTRFS_COMPRESS_ZLIB: return btrfs_put_workspace(fs_info, type, ws);
>   	case BTRFS_COMPRESS_LZO:  return btrfs_put_workspace(fs_info, type, ws);
>   	case BTRFS_COMPRESS_ZSTD: return zstd_put_workspace(fs_info, ws);
> -	default:
> -		/*
> -		 * This can't happen, the type is validated several times
> -		 * before we get here.
> -		 */
> -		BUG();
>   	}
>   }
>   
> @@ -1181,17 +1156,17 @@ static u64 file_offset_from_bvec(const struct bio_vec *bvec)
>    * @buf:		The decompressed data buffer
>    * @buf_len:		The decompressed data length
>    * @decompressed:	Number of bytes that are already decompressed inside the
> - * 			compressed extent
> + *			compressed extent
>    * @cb:			The compressed extent descriptor
>    * @orig_bio:		The original bio that the caller wants to read for
>    *
>    * An easier to understand graph is like below:
>    *
> - * 		|<- orig_bio ->|     |<- orig_bio->|
> - * 	|<-------      full decompressed extent      ----->|
> - * 	|<-----------    @cb range   ---->|
> - * 	|			|<-- @buf_len -->|
> - * 	|<--- @decompressed --->|
> + *		|<- orig_bio ->|     |<- orig_bio->|
> + *	|<-------      full decompressed extent      ----->|
> + *	|<-----------    @cb range   ---->|
> + *	|			|<-- @buf_len -->|
> + *	|<--- @decompressed --->|
>    *
>    * Note that, @cb can be a subpage of the full decompressed extent, but
>    * @cb->start always has the same as the orig_file_offset value of the full
> @@ -1313,7 +1288,8 @@ static u32 shannon_entropy(struct heuristic_ws *ws)
>   #define RADIX_BASE		4U
>   #define COUNTERS_SIZE		(1U << RADIX_BASE)
>   
> -static u8 get4bits(u64 num, int shift) {
> +static u8 get4bits(u64 num, int shift)
> +{
>   	u8 low4bits;
>   
>   	num >>= shift;
> @@ -1388,7 +1364,7 @@ static void radix_sort(struct bucket_item *array, struct bucket_item *array_buf,
>   		 */
>   		memset(counters, 0, sizeof(counters));
>   
> -		for (i = 0; i < num; i ++) {
> +		for (i = 0; i < num; i++) {
>   			buf_num = array_buf[i].count;
>   			addr = get4bits(buf_num, shift);
>   			counters[addr]++;


