Return-Path: <linux-btrfs+bounces-12933-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBA8A8341F
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Apr 2025 00:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02C333A3727
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 22:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728DC21ADA4;
	Wed,  9 Apr 2025 22:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BH+NGNJf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53B1219312
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Apr 2025 22:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744238075; cv=none; b=sUYDAdSfDE04j3TGGQWGIfw2wZkW97opcceRGPuGzDSSVlghiDir3L8CQZ2kvIRw/G56/spb2FvTvDFXg682RpuXTLjrGMdeeOzdvauVrKAbjYCP+bmuZJJzlo7C8poELAl4flzLQb6BQeYQEpgW+M4eT0TIN3HUmlNwJQ9Hyzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744238075; c=relaxed/simple;
	bh=9z6YJ1VFZ+QxmVgisrY+6dSd3ZOJV0E0RH1TbzfpaOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gXSXX3neETJzjm5xxIwg20kCq6cQbx5hi7P4Ast8lHINUPgK92xmn6vPMSHlvnONOSoQrnSdWnneOP7d98FL+xHyfX+ZYk0l45r11u+FG36quryHsbA8b8wE1hVKg1F0f420twqO1dKzBgr+gvIvM4ON3pm1w4imF0BKMFFIhvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BH+NGNJf; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39c0dfad22aso52304f8f.2
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Apr 2025 15:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744238070; x=1744842870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Pct87jNSfn5sg9Pub79CetAc11dH27caNo1xVT1v8M8=;
        b=BH+NGNJf8SsKI/ZYKPb3cmFgSQzCGhu0Bv3zTozZzNKaiCJxIeAA/u6IJMam55BXsB
         z3igxvUEUxdf+eeesRJByE4UiZT7I/iETKx9tIpAbfBBpmvnesaekdLg8CSuHugweYlK
         13TR7GlKw3IpbQnD3TtpvhTS78a7aPtHGAooI9FR63PmyCCK+dBU5WZKdf3b4Yv2aYiv
         qfxoW+dpzWwwXUg6ImFf2VRgs7z+e+K9adWPin2GNZJQQrQRFTJkUSbhIzc1Buy30day
         rLfUWxTAa64JFLNF/9RmT1JY2oYJdC2EM8h6KNRiYJck9R3FweHAJQVrXNKhxOGuzBsm
         81Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744238070; x=1744842870;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pct87jNSfn5sg9Pub79CetAc11dH27caNo1xVT1v8M8=;
        b=cLP5dm6kJGbldtMBLR2tRl9RGwBNxm2g2uHJvRSKiDeJ/jd9P/coVYAJlQSK/wGK1+
         0MEgg32Joad66c230afC8J0Wu/LhJujQUQ3XMvFS5GFQZsWJxC9nnWHtPcK3ifig/tih
         hzSTw3JEdQkCDyvbs/TYmz3dq/d+ghI+Q9+xLpRUx5WGO5ZZKFDmOdVEg9M4vTZuNcD2
         1XgUfcO6Xf6OpaTcxX3Ie4bXVTHrKPHxtxjZGg87TXswO5BCb52gz+djXgxOeYn4XUEV
         mrBuawas7Jr/7UYonNKZOnZaco9NvQ9caGePE/5vIM/4paQ4cs81ig0KLMt+1DTQoFRe
         ceqQ==
X-Gm-Message-State: AOJu0YzaOrya2f9SqqbaSAOVoYA06XnMoHDSFu1e1b01WJBbBgrYNnmp
	nJX2e9FPt34Rzj4NDgxZbUEhOw/K0n9cThi9O74l8JPGG6fipT9g+8RLIQFz2zM=
X-Gm-Gg: ASbGncuEjNJa99bTSQ6+up9z9A+5jn4yidYLycEeIxtMbtLyeywaBjqtSG/H5rQfrGm
	Jash0bngR+I2a+Ao3JXL8g21S13N56XmgfxnSdmZSAL9f0aNv+4dGetMa/1M4v8lFJdIb9ag7QA
	E+IOub8nkvtgVB9mHUY1x2+NUtOmnnLJn+747XIJUX6zsuhrZys9E4Du7za2HMdH1kcD49cXgo6
	t5D2tpj2AMlcPY00jF4USSZ3tjKNY5ubSJB1G1ijwSG1GFhVrrdIDg4bUbIIEoXCXRg+QzjauFd
	k3cDlt9BgL/ZVfKGTCJQsIGsMgVUD8FL5lCPzv9iiNOnGfR5r7TINHIa1KbFwUZCnuA7
X-Google-Smtp-Source: AGHT+IHz/3VzkIy7AlwJu+v4zHmx126LvBK8DKga+sKV21D/3T5b4XuNXXI9Ulmw8zaiavna1YFn6g==
X-Received: by 2002:a05:6000:186f:b0:38f:2b77:a9f3 with SMTP id ffacd0b85a97d-39d8f4dd095mr340928f8f.43.1744238069606;
        Wed, 09 Apr 2025 15:34:29 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd10c41fsm2471504a91.8.2025.04.09.15.34.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 15:34:28 -0700 (PDT)
Message-ID: <0b3a6b18-ab19-4997-86dc-fd269b7b61da@suse.com>
Date: Thu, 10 Apr 2025 08:04:25 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] btrfs: store a kernel virtual address in struct
 sector_ptr
To: Christoph Hellwig <hch@lst.de>
Cc: linux-btrfs@vger.kernel.org
References: <20250409111055.3640328-1-hch@lst.de>
 <20250409111055.3640328-7-hch@lst.de>
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
In-Reply-To: <20250409111055.3640328-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/9 20:40, Christoph Hellwig 写道:
> All data pointed to by struct sector_ptr is non-highmem kernel memory.
> Simplify the code by using a void pointer instead of a page + offset
> pair and dropping all the kmap calls.

But the higher level bio from btrfs filemaps can have highmem pages.

That's why we keep the kmap/kunmap.

Or is there a way to set the filemap to no use any highmem pages?

Thanks,
Qu

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/raid56.c | 167 +++++++++++++++++-----------------------------
>   1 file changed, 62 insertions(+), 105 deletions(-)
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index 703e713bac03..3ccbf133b455 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -134,14 +134,12 @@ struct btrfs_stripe_hash_table {
>   };
>   
>   /*
> - * A bvec like structure to present a sector inside a page.
> - *
> - * Unlike bvec we don't need bvlen, as it's fixed to sectorsize.
> + * A structure to present a sector inside a page, the length is fixed to
> + * sectorsize;
>    */
>   struct sector_ptr {
> -	struct page *page;
> -	unsigned int pgoff:24;
> -	unsigned int uptodate:8;
> +	void *kaddr;
> +	u8 uptodate;
>   };
>   
>   static void rmw_rbio_work(struct work_struct *work);
> @@ -253,7 +251,7 @@ static void cache_rbio_pages(struct btrfs_raid_bio *rbio)
>   
>   	for (i = 0; i < rbio->nr_sectors; i++) {
>   		/* Some range not covered by bio (partial write), skip it */
> -		if (!rbio->bio_sectors[i].page) {
> +		if (!rbio->bio_sectors[i].kaddr) {
>   			/*
>   			 * Even if the sector is not covered by bio, if it is
>   			 * a data sector it should still be uptodate as it is
> @@ -264,11 +262,9 @@ static void cache_rbio_pages(struct btrfs_raid_bio *rbio)
>   			continue;
>   		}
>   
> -		ASSERT(rbio->stripe_sectors[i].page);
> -		memcpy_page(rbio->stripe_sectors[i].page,
> -			    rbio->stripe_sectors[i].pgoff,
> -			    rbio->bio_sectors[i].page,
> -			    rbio->bio_sectors[i].pgoff,
> +		ASSERT(rbio->stripe_sectors[i].kaddr);
> +		memcpy(rbio->stripe_sectors[i].kaddr,
> +			    rbio->bio_sectors[i].kaddr,
>   			    rbio->bioc->fs_info->sectorsize);
>   		rbio->stripe_sectors[i].uptodate = 1;
>   	}
> @@ -326,8 +322,9 @@ static void index_stripe_sectors(struct btrfs_raid_bio *rbio)
>   		int page_index = offset >> PAGE_SHIFT;
>   
>   		ASSERT(page_index < rbio->nr_pages);
> -		rbio->stripe_sectors[i].page = rbio->stripe_pages[page_index];
> -		rbio->stripe_sectors[i].pgoff = offset_in_page(offset);
> +		rbio->stripe_sectors[i].kaddr =
> +			page_address(rbio->stripe_pages[page_index]) +
> +					offset_in_page(offset);
>   	}
>   }
>   
> @@ -962,9 +959,9 @@ static struct sector_ptr *sector_in_rbio(struct btrfs_raid_bio *rbio,
>   
>   	spin_lock(&rbio->bio_list_lock);
>   	sector = &rbio->bio_sectors[index];
> -	if (sector->page || bio_list_only) {
> +	if (sector->kaddr || bio_list_only) {
>   		/* Don't return sector without a valid page pointer */
> -		if (!sector->page)
> +		if (!sector->kaddr)
>   			sector = NULL;
>   		spin_unlock(&rbio->bio_list_lock);
>   		return sector;
> @@ -1142,7 +1139,7 @@ static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
>   			   rbio, stripe_nr);
>   	ASSERT_RBIO_SECTOR(sector_nr >= 0 && sector_nr < rbio->stripe_nsectors,
>   			   rbio, sector_nr);
> -	ASSERT(sector->page);
> +	ASSERT(sector->kaddr);
>   
>   	stripe = &rbio->bioc->stripes[stripe_nr];
>   	disk_start = stripe->physical + sector_nr * sectorsize;
> @@ -1173,8 +1170,9 @@ static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
>   		 */
>   		if (last_end == disk_start && !last->bi_status &&
>   		    last->bi_bdev == stripe->dev->bdev) {
> -			ret = bio_add_page(last, sector->page, sectorsize,
> -					   sector->pgoff);
> +			ret = bio_add_page(last, virt_to_page(sector->kaddr),
> +					sectorsize,
> +					offset_in_page(sector->kaddr));
>   			if (ret == sectorsize)
>   				return 0;
>   		}
> @@ -1187,7 +1185,8 @@ static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
>   	bio->bi_iter.bi_sector = disk_start >> SECTOR_SHIFT;
>   	bio->bi_private = rbio;
>   
> -	__bio_add_page(bio, sector->page, sectorsize, sector->pgoff);
> +	__bio_add_page(bio, virt_to_page(sector->kaddr), sectorsize,
> +			offset_in_page(sector->kaddr));
>   	bio_list_add(bio_list, bio);
>   	return 0;
>   }
> @@ -1204,10 +1203,7 @@ static void index_one_bio(struct btrfs_raid_bio *rbio, struct bio *bio)
>   		struct sector_ptr *sector = &rbio->bio_sectors[index];
>   		struct bio_vec bv = bio_iter_iovec(bio, iter);
>   
> -		sector->page = bv.bv_page;
> -		sector->pgoff = bv.bv_offset;
> -		ASSERT(sector->pgoff < PAGE_SIZE);
> -
> +		sector->kaddr = bvec_virt(&bv);
>   		bio_advance_iter_single(bio, &iter, sectorsize);
>   	}
>   }
> @@ -1298,14 +1294,13 @@ static void generate_pq_vertical(struct btrfs_raid_bio *rbio, int sectornr)
>   	/* First collect one sector from each data stripe */
>   	for (stripe = 0; stripe < rbio->nr_data; stripe++) {
>   		sector = sector_in_rbio(rbio, stripe, sectornr, 0);
> -		pointers[stripe] = kmap_local_page(sector->page) +
> -				   sector->pgoff;
> +		pointers[stripe] = sector->kaddr;
>   	}
>   
>   	/* Then add the parity stripe */
>   	sector = rbio_pstripe_sector(rbio, sectornr);
>   	sector->uptodate = 1;
> -	pointers[stripe++] = kmap_local_page(sector->page) + sector->pgoff;
> +	pointers[stripe++] = sector->kaddr;
>   
>   	if (has_qstripe) {
>   		/*
> @@ -1314,8 +1309,7 @@ static void generate_pq_vertical(struct btrfs_raid_bio *rbio, int sectornr)
>   		 */
>   		sector = rbio_qstripe_sector(rbio, sectornr);
>   		sector->uptodate = 1;
> -		pointers[stripe++] = kmap_local_page(sector->page) +
> -				     sector->pgoff;
> +		pointers[stripe++] = sector->kaddr;
>   
>   		assert_rbio(rbio);
>   		raid6_call.gen_syndrome(rbio->real_stripes, sectorsize,
> @@ -1325,8 +1319,6 @@ static void generate_pq_vertical(struct btrfs_raid_bio *rbio, int sectornr)
>   		memcpy(pointers[rbio->nr_data], pointers[0], sectorsize);
>   		run_xor(pointers + 1, rbio->nr_data - 1, sectorsize);
>   	}
> -	for (stripe = stripe - 1; stripe >= 0; stripe--)
> -		kunmap_local(pointers[stripe]);
>   }
>   
>   static int rmw_assemble_write_bios(struct btrfs_raid_bio *rbio,
> @@ -1474,15 +1466,14 @@ static void set_rbio_range_error(struct btrfs_raid_bio *rbio, struct bio *bio)
>    * stripe_pages[], thus we need to locate the sector.
>    */
>   static struct sector_ptr *find_stripe_sector(struct btrfs_raid_bio *rbio,
> -					     struct page *page,
> -					     unsigned int pgoff)
> +					     void *kaddr)
>   {
>   	int i;
>   
>   	for (i = 0; i < rbio->nr_sectors; i++) {
>   		struct sector_ptr *sector = &rbio->stripe_sectors[i];
>   
> -		if (sector->page == page && sector->pgoff == pgoff)
> +		if (sector->kaddr == kaddr)
>   			return sector;
>   	}
>   	return NULL;
> @@ -1502,11 +1493,11 @@ static void set_bio_pages_uptodate(struct btrfs_raid_bio *rbio, struct bio *bio)
>   
>   	bio_for_each_segment_all(bvec, bio, iter_all) {
>   		struct sector_ptr *sector;
> -		int pgoff;
> +		void *kaddr = bvec_virt(bvec);
> +		int off;
>   
> -		for (pgoff = bvec->bv_offset; pgoff - bvec->bv_offset < bvec->bv_len;
> -		     pgoff += sectorsize) {
> -			sector = find_stripe_sector(rbio, bvec->bv_page, pgoff);
> +		for (off = 0; off < bvec->bv_len; off += sectorsize) {
> +			sector = find_stripe_sector(rbio, kaddr + off);
>   			ASSERT(sector);
>   			if (sector)
>   				sector->uptodate = 1;
> @@ -1516,17 +1507,13 @@ static void set_bio_pages_uptodate(struct btrfs_raid_bio *rbio, struct bio *bio)
>   
>   static int get_bio_sector_nr(struct btrfs_raid_bio *rbio, struct bio *bio)
>   {
> -	struct bio_vec *bv = bio_first_bvec_all(bio);
> +	void *bvec_kaddr = bvec_virt(bio_first_bvec_all(bio));
>   	int i;
>   
>   	for (i = 0; i < rbio->nr_sectors; i++) {
> -		struct sector_ptr *sector;
> -
> -		sector = &rbio->stripe_sectors[i];
> -		if (sector->page == bv->bv_page && sector->pgoff == bv->bv_offset)
> +		if (rbio->stripe_sectors[i].kaddr == bvec_kaddr)
>   			break;
> -		sector = &rbio->bio_sectors[i];
> -		if (sector->page == bv->bv_page && sector->pgoff == bv->bv_offset)
> +		if (rbio->bio_sectors[i].kaddr == bvec_kaddr)
>   			break;
>   	}
>   	ASSERT(i < rbio->nr_sectors);
> @@ -1789,8 +1776,6 @@ static int verify_one_sector(struct btrfs_raid_bio *rbio,
>   	struct sector_ptr *sector;
>   	u8 csum_buf[BTRFS_CSUM_SIZE];
>   	u8 *csum_expected;
> -	void *kaddr;
> -	int ret;
>   
>   	if (!rbio->csum_bitmap || !rbio->csum_buf)
>   		return 0;
> @@ -1808,15 +1793,13 @@ static int verify_one_sector(struct btrfs_raid_bio *rbio,
>   		sector = rbio_stripe_sector(rbio, stripe_nr, sector_nr);
>   	}
>   
> -	ASSERT(sector->page);
> +	ASSERT(sector->kaddr);
>   
> -	kaddr = kmap_local_page(sector->page) + sector->pgoff;
>   	csum_expected = rbio->csum_buf +
>   			(stripe_nr * rbio->stripe_nsectors + sector_nr) *
>   			fs_info->csum_size;
> -	ret = btrfs_check_sector_csum(fs_info, kaddr, csum_buf, csum_expected);
> -	kunmap_local(kaddr);
> -	return ret;
> +	return btrfs_check_sector_csum(fs_info, sector->kaddr, csum_buf,
> +			csum_expected);
>   }
>   
>   /*
> @@ -1825,7 +1808,7 @@ static int verify_one_sector(struct btrfs_raid_bio *rbio,
>    * need to allocate/free the pointers again and again.
>    */
>   static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
> -			    void **pointers, void **unmap_array)
> +			    void **pointers)
>   {
>   	struct btrfs_fs_info *fs_info = rbio->bioc->fs_info;
>   	struct sector_ptr *sector;
> @@ -1872,10 +1855,8 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
>   		} else {
>   			sector = rbio_stripe_sector(rbio, stripe_nr, sector_nr);
>   		}
> -		ASSERT(sector->page);
> -		pointers[stripe_nr] = kmap_local_page(sector->page) +
> -				   sector->pgoff;
> -		unmap_array[stripe_nr] = pointers[stripe_nr];
> +		ASSERT(sector->kaddr);
> +		pointers[stripe_nr] = sector->kaddr;
>   	}
>   
>   	/* All raid6 handling here */
> @@ -1889,7 +1870,7 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
>   				 * We have nothing to do, just skip the
>   				 * recovery for this stripe.
>   				 */
> -				goto cleanup;
> +				return ret;
>   			/*
>   			 * a single failure in raid6 is rebuilt
>   			 * in the pstripe code below
> @@ -1911,7 +1892,7 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
>   				 * We only care about data stripes recovery,
>   				 * can skip this vertical stripe.
>   				 */
> -				goto cleanup;
> +				return ret;
>   			/*
>   			 * Otherwise we have one bad data stripe and
>   			 * a good P stripe.  raid5!
> @@ -1960,7 +1941,7 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
>   	if (faila >= 0) {
>   		ret = verify_one_sector(rbio, faila, sector_nr);
>   		if (ret < 0)
> -			goto cleanup;
> +			return ret;
>   
>   		sector = rbio_stripe_sector(rbio, faila, sector_nr);
>   		sector->uptodate = 1;
> @@ -1968,34 +1949,26 @@ static int recover_vertical(struct btrfs_raid_bio *rbio, int sector_nr,
>   	if (failb >= 0) {
>   		ret = verify_one_sector(rbio, failb, sector_nr);
>   		if (ret < 0)
> -			goto cleanup;
> +			return ret;
>   
>   		sector = rbio_stripe_sector(rbio, failb, sector_nr);
>   		sector->uptodate = 1;
>   	}
>   
> -cleanup:
> -	for (stripe_nr = rbio->real_stripes - 1; stripe_nr >= 0; stripe_nr--)
> -		kunmap_local(unmap_array[stripe_nr]);
>   	return ret;
>   }
>   
>   static int recover_sectors(struct btrfs_raid_bio *rbio)
>   {
>   	void **pointers = NULL;
> -	void **unmap_array = NULL;
>   	int sectornr;
>   	int ret = 0;
>   
>   	/*
>   	 * @pointers array stores the pointer for each sector.
> -	 *
> -	 * @unmap_array stores copy of pointers that does not get reordered
> -	 * during reconstruction so that kunmap_local works.
>   	 */
>   	pointers = kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
> -	unmap_array = kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
> -	if (!pointers || !unmap_array) {
> +	if (!pointers) {
>   		ret = -ENOMEM;
>   		goto out;
>   	}
> @@ -2009,14 +1982,13 @@ static int recover_sectors(struct btrfs_raid_bio *rbio)
>   	index_rbio_pages(rbio);
>   
>   	for (sectornr = 0; sectornr < rbio->stripe_nsectors; sectornr++) {
> -		ret = recover_vertical(rbio, sectornr, pointers, unmap_array);
> +		ret = recover_vertical(rbio, sectornr, pointers);
>   		if (ret < 0)
>   			break;
>   	}
>   
>   out:
>   	kfree(pointers);
> -	kfree(unmap_array);
>   	return ret;
>   }
>   
> @@ -2326,7 +2298,7 @@ static bool need_read_stripe_sectors(struct btrfs_raid_bio *rbio)
>   		 * thus this rbio can not be cached one, as cached one must
>   		 * have all its data sectors present and uptodate.
>   		 */
> -		if (!sector->page || !sector->uptodate)
> +		if (!sector->kaddr || !sector->uptodate)
>   			return true;
>   	}
>   	return false;
> @@ -2547,29 +2519,27 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
>   	 */
>   	clear_bit(RBIO_CACHE_READY_BIT, &rbio->flags);
>   
> -	p_sector.page = alloc_page(GFP_NOFS);
> -	if (!p_sector.page)
> +	p_sector.kaddr = (void *)__get_free_page(GFP_NOFS);
> +	if (!p_sector.kaddr)
>   		return -ENOMEM;
> -	p_sector.pgoff = 0;
>   	p_sector.uptodate = 1;
>   
>   	if (has_qstripe) {
>   		/* RAID6, allocate and map temp space for the Q stripe */
> -		q_sector.page = alloc_page(GFP_NOFS);
> -		if (!q_sector.page) {
> -			__free_page(p_sector.page);
> -			p_sector.page = NULL;
> +		q_sector.kaddr = (void *)__get_free_page(GFP_NOFS);
> +		if (!q_sector.kaddr) {
> +			free_page((unsigned long)p_sector.kaddr);
> +			p_sector.kaddr = NULL;
>   			return -ENOMEM;
>   		}
> -		q_sector.pgoff = 0;
>   		q_sector.uptodate = 1;
> -		pointers[rbio->real_stripes - 1] = kmap_local_page(q_sector.page);
> +		pointers[rbio->real_stripes - 1] = q_sector.kaddr;
>   	}
>   
>   	bitmap_clear(rbio->error_bitmap, 0, rbio->nr_sectors);
>   
>   	/* Map the parity stripe just once */
> -	pointers[nr_data] = kmap_local_page(p_sector.page);
> +	pointers[nr_data] = p_sector.kaddr;
>   
>   	for_each_set_bit(sectornr, &rbio->dbitmap, rbio->stripe_nsectors) {
>   		struct sector_ptr *sector;
> @@ -2578,8 +2548,7 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
>   		/* first collect one page from each data stripe */
>   		for (stripe = 0; stripe < nr_data; stripe++) {
>   			sector = sector_in_rbio(rbio, stripe, sectornr, 0);
> -			pointers[stripe] = kmap_local_page(sector->page) +
> -					   sector->pgoff;
> +			pointers[stripe] = sector->kaddr;
>   		}
>   
>   		if (has_qstripe) {
> @@ -2595,25 +2564,19 @@ static int finish_parity_scrub(struct btrfs_raid_bio *rbio)
>   
>   		/* Check scrubbing parity and repair it */
>   		sector = rbio_stripe_sector(rbio, rbio->scrubp, sectornr);
> -		parity = kmap_local_page(sector->page) + sector->pgoff;
> +		parity = sector->kaddr;
>   		if (memcmp(parity, pointers[rbio->scrubp], sectorsize) != 0)
>   			memcpy(parity, pointers[rbio->scrubp], sectorsize);
>   		else
>   			/* Parity is right, needn't writeback */
>   			bitmap_clear(&rbio->dbitmap, sectornr, 1);
> -		kunmap_local(parity);
> -
> -		for (stripe = nr_data - 1; stripe >= 0; stripe--)
> -			kunmap_local(pointers[stripe]);
>   	}
>   
> -	kunmap_local(pointers[nr_data]);
> -	__free_page(p_sector.page);
> -	p_sector.page = NULL;
> -	if (q_sector.page) {
> -		kunmap_local(pointers[rbio->real_stripes - 1]);
> -		__free_page(q_sector.page);
> -		q_sector.page = NULL;
> +	free_page((unsigned long)p_sector.kaddr);
> +	p_sector.kaddr = NULL;
> +	if (q_sector.kaddr) {
> +		free_page((unsigned long)q_sector.kaddr);
> +		q_sector.kaddr = NULL;
>   	}
>   
>   	/*
> @@ -2669,19 +2632,14 @@ static inline int is_data_stripe(struct btrfs_raid_bio *rbio, int stripe)
>   static int recover_scrub_rbio(struct btrfs_raid_bio *rbio)
>   {
>   	void **pointers = NULL;
> -	void **unmap_array = NULL;
>   	int sector_nr;
>   	int ret = 0;
>   
>   	/*
>   	 * @pointers array stores the pointer for each sector.
> -	 *
> -	 * @unmap_array stores copy of pointers that does not get reordered
> -	 * during reconstruction so that kunmap_local works.
>   	 */
>   	pointers = kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
> -	unmap_array = kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
> -	if (!pointers || !unmap_array) {
> +	if (!pointers) {
>   		ret = -ENOMEM;
>   		goto out;
>   	}
> @@ -2740,13 +2698,12 @@ static int recover_scrub_rbio(struct btrfs_raid_bio *rbio)
>   			goto out;
>   		}
>   
> -		ret = recover_vertical(rbio, sector_nr, pointers, unmap_array);
> +		ret = recover_vertical(rbio, sector_nr, pointers);
>   		if (ret < 0)
>   			goto out;
>   	}
>   out:
>   	kfree(pointers);
> -	kfree(unmap_array);
>   	return ret;
>   }
>

