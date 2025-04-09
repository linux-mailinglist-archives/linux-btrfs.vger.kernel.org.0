Return-Path: <linux-btrfs+bounces-12934-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BA3A83424
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Apr 2025 00:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C608466EA2
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 22:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F403021ADC6;
	Wed,  9 Apr 2025 22:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cc8WengU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF62215F5F
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Apr 2025 22:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744238296; cv=none; b=qmESc0TvT4ECXgbu/yhHlQhXA41OVWVRSHl3PI8JJgDREboEhtymbXiWtPMnKX3zl3+7aYEuHBjQxixKsDugkEtqW0Yb0zpexxMQKezdpwHnSaO//0fshJRUu8yOdLjDVouQTFlXbvwRtHQD/qQzr4HgVFiC4LGUT2/R8c8Uy50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744238296; c=relaxed/simple;
	bh=dovFlK+1M8unReEDIQcvSP7KXG00R+K2kGWRwE959OM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L56jS3Z74U6iOgWViRjDV3aWOctKMclFW5p1ejaA7PRgtOQvwlVinJ1AXcrf0qPPvASJKn26yDk8hgOEQW69caTYyKGWgqceSfKAiUuEn3MEUi229J8Pv+p1H5KdrGgsS0aJVaGB4f+y0SO9SUWKdJe6Hnlfma8o7F1MRgup4pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cc8WengU; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso2153825e9.1
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Apr 2025 15:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744238292; x=1744843092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/U9NtquVlpziVYna75RzAL836Q7achkbPgAW6gyBNk8=;
        b=cc8WengU6p0DwZ+nxLas6BCL13tS4LF5TNXQ4DwRz2x61evIUpYN/kenKZTBOlQ7pK
         Pl9z9NFkdp8sgzYpPfC0hVvJGDFFFx2IZLbi//8APN1noP9OWg+jhqRF0W5pSNNpQIH8
         Gk1ed/dZ4CasAgo2OIYkWCzJqGQxsuOkUJhJa8OA9kTwMmnApGwRqqia5GDFD7WXR9st
         +8RvI3ngw/lSIIDHS9kDkCAwOy27kwxEfAOLmGNzoOgSlMRHkeSffMV8A7Ze/oMaa6XW
         daav4T3PZ0MsDXmBoSlIkCfgl6felo3Duqezak7a4TIf9sBJFHofvCfLitii9BPnTiB5
         4qPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744238292; x=1744843092;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/U9NtquVlpziVYna75RzAL836Q7achkbPgAW6gyBNk8=;
        b=CBknDlcqvK9Q4qWOAN2aa0zFFcuVhUVDhFvlEa+DvRUoI8AseEqOIaeU1szPtA7SYp
         kb/Vb+jr1jIspI/3bCCsSC8W0j2fGa1ypYfbI1uNyJBF+U9aBdNZRfG2S5QbKAihVtQY
         S2bHllz9+EW8UVNZzvfdp+uHYa/Vjf60UFEI7TcKLPq5ctSujPzmpqSp5vSfrrVPlp2U
         3CbpdLrQFyR1aOHQ08IgftiKAbMhUR//j9GwAu98BU5s4KXsOZ/ASnAj5yBV6Liku5Lv
         P0VsotsBLcyGdQWzwd65fGjyr7pn+aqQljjfHHydaX7upnt/XD6ktdikWuKblbtbqjIJ
         rwlw==
X-Gm-Message-State: AOJu0YxfimBChAZFJ0tgaj2nN5ZeJ0egTzxTmieFdau1vtNAs9XNSFgf
	jgqpEPdrfr5l9Q6F69WoDXMsyYReKzWuGcYV/aVuQEUxa5kH0OEeOKWdord3dtwIcXLzVsQZZTY
	t
X-Gm-Gg: ASbGncsSDoeUtH3wyCLfdsSOmpUn3Xlr6zsQm0WdV29l9I5FPors9xwxkdW5MocXGE8
	VtJFUQnogSMn1UPDJj3Dkch1NhyoSiFcdkd+VOd2ucVYTxTazAXcM3RLFROkH3P+lzhwiNG4tul
	BTcyr59EzkaVqmiRAfK6XS56bztO4G/sJwW8iy4MXWG57pD7zTZ1bLcaMtH21oIaKnSeOs+0zXZ
	GkuPjGJVCr5rX6PaBazqGX0e0iDxy1Dnpl/Q33WxaZldCHThHcqSPjbJKAtXeMWUtLZgHuGO23G
	RddzBoqhEfdQ1TO74UjBqBqddHkfJF+pgezqZmRdjPuaTF6592xsv8f/PHpA59Fnj5tA
X-Google-Smtp-Source: AGHT+IGFCOdcGOqNtTM7Pc1WdTu0EmbfUQNmpCuKlZSqJoVobK2uxuni14AyPiWgtgrJGRza/606zw==
X-Received: by 2002:a5d:59a8:0:b0:39c:13f5:dba0 with SMTP id ffacd0b85a97d-39d8fd72691mr92428f8f.13.1744238291369;
        Wed, 09 Apr 2025 15:38:11 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a331b481sm1769140a12.75.2025.04.09.15.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 15:38:10 -0700 (PDT)
Message-ID: <eab9f278-2c9e-43b2-8039-8cd5158ace4c@suse.com>
Date: Thu, 10 Apr 2025 08:08:07 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] btrfs: refactor getting the address of a stripe
 sector
To: Christoph Hellwig <hch@lst.de>
Cc: linux-btrfs@vger.kernel.org
References: <20250409111055.3640328-1-hch@lst.de>
 <20250409111055.3640328-8-hch@lst.de>
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
In-Reply-To: <20250409111055.3640328-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/9 20:40, Christoph Hellwig 写道:
> Add a helper to get the actual kernel address of a stripe instead of
> just the page and offset into it to simplify the code, and add another
> helper to add the memory backing a sector to a bio using the above
> helper.
> 
> This nicely abstracts away the page + offset representation from almost
> all of the scrub code.

I love this change, and it should also be safe because all scrub pages 
are allocated by ourselves, and are ensured not to be high mem.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/scrub.c | 81 +++++++++++++++---------------------------------
>   1 file changed, 25 insertions(+), 56 deletions(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 49021765c17b..d014b728eb0d 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -579,20 +579,13 @@ static int fill_writer_pointer_gap(struct scrub_ctx *sctx, u64 physical)
>   	return ret;
>   }
>   
> -static struct page *scrub_stripe_get_page(struct scrub_stripe *stripe, int sector_nr)
> +static void *scrub_stripe_get_kaddr(struct scrub_stripe *stripe, int sector_nr)
>   {
>   	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
> -	int page_index = (sector_nr << fs_info->sectorsize_bits) >> PAGE_SHIFT;
> +	u32 offset = sector_nr << fs_info->sectorsize_bits;
>   
> -	return stripe->pages[page_index];
> -}
> -
> -static unsigned int scrub_stripe_get_page_offset(struct scrub_stripe *stripe,
> -						 int sector_nr)
> -{
> -	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
> -
> -	return offset_in_page(sector_nr << fs_info->sectorsize_bits);
> +	return page_address(stripe->pages[offset >> PAGE_SHIFT]) +
> +			offset_in_page(offset);
>   }
>   
>   static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr)
> @@ -600,19 +593,17 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
>   	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
>   	const u32 sectors_per_tree = fs_info->nodesize >> fs_info->sectorsize_bits;
>   	const u64 logical = stripe->logical + (sector_nr << fs_info->sectorsize_bits);
> -	const struct page *first_page = scrub_stripe_get_page(stripe, sector_nr);
> -	const unsigned int first_off = scrub_stripe_get_page_offset(stripe, sector_nr);
> +	void *first_kaddr = scrub_stripe_get_kaddr(stripe, sector_nr);
>   	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
>   	u8 on_disk_csum[BTRFS_CSUM_SIZE];
>   	u8 calculated_csum[BTRFS_CSUM_SIZE];
> -	struct btrfs_header *header;
> +	struct btrfs_header *header = first_kaddr;
>   
>   	/*
>   	 * Here we don't have a good way to attach the pages (and subpages)
>   	 * to a dummy extent buffer, thus we have to directly grab the members
>   	 * from pages.
>   	 */
> -	header = (struct btrfs_header *)(page_address(first_page) + first_off);
>   	memcpy(on_disk_csum, header->csum, fs_info->csum_size);
>   
>   	if (logical != btrfs_stack_header_bytenr(header)) {
> @@ -648,14 +639,11 @@ static void scrub_verify_one_metadata(struct scrub_stripe *stripe, int sector_nr
>   	/* Now check tree block csum. */
>   	shash->tfm = fs_info->csum_shash;
>   	crypto_shash_init(shash);
> -	crypto_shash_update(shash, page_address(first_page) + first_off +
> -			    BTRFS_CSUM_SIZE, fs_info->sectorsize - BTRFS_CSUM_SIZE);
> +	crypto_shash_update(shash, first_kaddr + BTRFS_CSUM_SIZE,
> +			fs_info->sectorsize - BTRFS_CSUM_SIZE);
>   
>   	for (int i = sector_nr + 1; i < sector_nr + sectors_per_tree; i++) {
> -		struct page *page = scrub_stripe_get_page(stripe, i);
> -		unsigned int page_off = scrub_stripe_get_page_offset(stripe, i);
> -
> -		crypto_shash_update(shash, page_address(page) + page_off,
> +		crypto_shash_update(shash, scrub_stripe_get_kaddr(stripe, i),
>   				    fs_info->sectorsize);
>   	}
>   
> @@ -691,10 +679,8 @@ static void scrub_verify_one_sector(struct scrub_stripe *stripe, int sector_nr)
>   	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
>   	struct scrub_sector_verification *sector = &stripe->sectors[sector_nr];
>   	const u32 sectors_per_tree = fs_info->nodesize >> fs_info->sectorsize_bits;
> -	struct page *page = scrub_stripe_get_page(stripe, sector_nr);
> -	unsigned int pgoff = scrub_stripe_get_page_offset(stripe, sector_nr);
> +	void *kaddr = scrub_stripe_get_kaddr(stripe, sector_nr);
>   	u8 csum_buf[BTRFS_CSUM_SIZE];
> -	void *kaddr;
>   	int ret;
>   
>   	ASSERT(sector_nr >= 0 && sector_nr < stripe->nr_sectors);
> @@ -738,9 +724,7 @@ static void scrub_verify_one_sector(struct scrub_stripe *stripe, int sector_nr)
>   		return;
>   	}
>   
> -	kaddr = kmap_local_page(page) + pgoff;
>   	ret = btrfs_check_sector_csum(fs_info, kaddr, csum_buf, sector->csum);
> -	kunmap_local(kaddr);
>   	if (ret < 0) {
>   		set_bit(sector_nr, &stripe->csum_error_bitmap);
>   		set_bit(sector_nr, &stripe->error_bitmap);
> @@ -769,8 +753,7 @@ static int calc_sector_number(struct scrub_stripe *stripe, struct bio_vec *first
>   	int i;
>   
>   	for (i = 0; i < stripe->nr_sectors; i++) {
> -		if (scrub_stripe_get_page(stripe, i) == first_bvec->bv_page &&
> -		    scrub_stripe_get_page_offset(stripe, i) == first_bvec->bv_offset)
> +		if (scrub_stripe_get_kaddr(stripe, i) == bvec_virt(first_bvec))
>   			break;
>   	}
>   	ASSERT(i < stripe->nr_sectors);
> @@ -817,6 +800,15 @@ static int calc_next_mirror(int mirror, int num_copies)
>   	return (mirror + 1 > num_copies) ? 1 : mirror + 1;
>   }
>   
> +static void scrub_bio_add_sector(struct btrfs_bio *bbio,
> +		struct scrub_stripe *stripe, int sector_nr)
> +{
> +	void *kaddr = scrub_stripe_get_kaddr(stripe, sector_nr);
> +
> +	__bio_add_page(&bbio->bio, virt_to_page(kaddr),
> +			bbio->fs_info->sectorsize, offset_in_page(kaddr));
> +}
> +
>   static void scrub_stripe_submit_repair_read(struct scrub_stripe *stripe,
>   					    int mirror, int blocksize, bool wait)
>   {
> @@ -829,13 +821,6 @@ static void scrub_stripe_submit_repair_read(struct scrub_stripe *stripe,
>   	ASSERT(atomic_read(&stripe->pending_io) == 0);
>   
>   	for_each_set_bit(i, &old_error_bitmap, stripe->nr_sectors) {
> -		struct page *page;
> -		int pgoff;
> -		int ret;
> -
> -		page = scrub_stripe_get_page(stripe, i);
> -		pgoff = scrub_stripe_get_page_offset(stripe, i);
> -
>   		/* The current sector cannot be merged, submit the bio. */
>   		if (bbio && ((i > 0 && !test_bit(i - 1, &stripe->error_bitmap)) ||
>   			     bbio->bio.bi_iter.bi_size >= blocksize)) {
> @@ -854,8 +839,7 @@ static void scrub_stripe_submit_repair_read(struct scrub_stripe *stripe,
>   				(i << fs_info->sectorsize_bits)) >> SECTOR_SHIFT;
>   		}
>   
> -		ret = bio_add_page(&bbio->bio, page, fs_info->sectorsize, pgoff);
> -		ASSERT(ret == fs_info->sectorsize);
> +		scrub_bio_add_sector(bbio, stripe, i);
>   	}
>   	if (bbio) {
>   		ASSERT(bbio->bio.bi_iter.bi_size);
> @@ -1202,10 +1186,6 @@ static void scrub_write_sectors(struct scrub_ctx *sctx, struct scrub_stripe *str
>   	int sector_nr;
>   
>   	for_each_set_bit(sector_nr, &write_bitmap, stripe->nr_sectors) {
> -		struct page *page = scrub_stripe_get_page(stripe, sector_nr);
> -		unsigned int pgoff = scrub_stripe_get_page_offset(stripe, sector_nr);
> -		int ret;
> -
>   		/* We should only writeback sectors covered by an extent. */
>   		ASSERT(test_bit(sector_nr, &stripe->extent_sector_bitmap));
>   
> @@ -1221,8 +1201,7 @@ static void scrub_write_sectors(struct scrub_ctx *sctx, struct scrub_stripe *str
>   				(sector_nr << fs_info->sectorsize_bits)) >>
>   				SECTOR_SHIFT;
>   		}
> -		ret = bio_add_page(&bbio->bio, page, fs_info->sectorsize, pgoff);
> -		ASSERT(ret == fs_info->sectorsize);
> +		scrub_bio_add_sector(bbio, stripe, sector_nr);
>   	}
>   	if (bbio)
>   		scrub_submit_write_bio(sctx, stripe, bbio, dev_replace);
> @@ -1675,9 +1654,6 @@ static void scrub_submit_extent_sector_read(struct scrub_stripe *stripe)
>   	atomic_inc(&stripe->pending_io);
>   
>   	for_each_set_bit(i, &stripe->extent_sector_bitmap, stripe->nr_sectors) {
> -		struct page *page = scrub_stripe_get_page(stripe, i);
> -		unsigned int pgoff = scrub_stripe_get_page_offset(stripe, i);
> -
>   		/* We're beyond the chunk boundary, no need to read anymore. */
>   		if (i >= nr_sectors)
>   			break;
> @@ -1730,7 +1706,7 @@ static void scrub_submit_extent_sector_read(struct scrub_stripe *stripe)
>   			bbio->bio.bi_iter.bi_sector = logical >> SECTOR_SHIFT;
>   		}
>   
> -		__bio_add_page(&bbio->bio, page, fs_info->sectorsize, pgoff);
> +		scrub_bio_add_sector(bbio, stripe, i);
>   	}
>   
>   	if (bbio) {
> @@ -1768,15 +1744,8 @@ static void scrub_submit_initial_read(struct scrub_ctx *sctx,
>   
>   	bbio->bio.bi_iter.bi_sector = stripe->logical >> SECTOR_SHIFT;
>   	/* Read the whole range inside the chunk boundary. */
> -	for (unsigned int cur = 0; cur < nr_sectors; cur++) {
> -		struct page *page = scrub_stripe_get_page(stripe, cur);
> -		unsigned int pgoff = scrub_stripe_get_page_offset(stripe, cur);
> -		int ret;
> -
> -		ret = bio_add_page(&bbio->bio, page, fs_info->sectorsize, pgoff);
> -		/* We should have allocated enough bio vectors. */
> -		ASSERT(ret == fs_info->sectorsize);
> -	}
> +	for (unsigned int cur = 0; cur < nr_sectors; cur++)
> +		scrub_bio_add_sector(bbio, stripe, cur);
>   	atomic_inc(&stripe->pending_io);
>   
>   	/*


