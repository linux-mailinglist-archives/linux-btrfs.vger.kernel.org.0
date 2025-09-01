Return-Path: <linux-btrfs+bounces-16553-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 238D6B3D9E0
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Sep 2025 08:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8873B295B
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Sep 2025 06:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FB4253F3A;
	Mon,  1 Sep 2025 06:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RacUOLBb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DAA22156A
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Sep 2025 06:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756707949; cv=none; b=jMxZ07W9lDd8gJhOiAPq1iYVk/dneNb4m8KFGspQZ5CUqgb4qpymsY49w8vQpKRyXvGGTa5SfyGrTeEl6FYdlHjh4DD9V23fnOZCGPRQAMTn08OLuaKYvHmbbSZ8nKiO6e7rsm3g0WLaX9466kZSIkq4L8UQjnLPUPalnIugu90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756707949; c=relaxed/simple;
	bh=6GViDfa4CEeMpaxpwLMhDffW2B2AMtVpbySpgP01e88=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ezxpBMy6eskNMvYx7KGDdKts6jPDchzFroQidJ0Kfyr3hzqP0mURzK+2G0grVmgop1VJX8Iwmf/vehI6WOxI1huKDYIM2EjESvypQNYeYN7KNYNzQTbU9n2Ai7tEa4JjdR7vtZnMD+llUOEtOcOttmfMSl+QzoBBcyivjWdRdyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RacUOLBb; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso3192327f8f.3
        for <linux-btrfs@vger.kernel.org>; Sun, 31 Aug 2025 23:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756707944; x=1757312744; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qgqsZVp0HqxMfTHq3vd/rqMvc1ZdW/6wtTpw1PwGiEk=;
        b=RacUOLBbxbrJhFVTaVzH53VEdgqz5H7yatLNSAIf41Qe0VjHRSubdVKYhBdhFhksIw
         BvQj4ix+DlG7x4VLLEBMMMpQFeQncypfJMwgTx6xwaeIpktzgPQoTz91rUtqWbWD7f9B
         iUSTB2tUAD3lURaFCT6z6j3v6UzWLi1OH/xIs94GzDwyfKUDQekv9IdxiVgXEtbmNAez
         7NQDXZaWNFNkGcVLPjfdtLymO/VpmRss88I0zwL/dw+LV4z5Hc8ZSs8UBtBy8MFBA1Wj
         LFMWS8jQz87c+dIcriwR47hvVlOpMMA0QCfJt22Lo+f/lyiDCLKiLXRZ6HW7qXu6Y+6Z
         YZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756707944; x=1757312744;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qgqsZVp0HqxMfTHq3vd/rqMvc1ZdW/6wtTpw1PwGiEk=;
        b=mcJxkO9MqtlxE1vFyBlvkaVSzGAqkVdF8Ni03QM4n0M2/hHmNgzhH4YWsUODsMPCE/
         5HeJYi3ZlMKIepxpMJzGUudwKz3AbXCWp3MBxiuSyiIrKTC5YfO5Zt9+3zLc3aFxciEo
         nT1L2o21ugqj7JY6zZJ9PyEPiTMH1RXGZB1EeDHOZHax54S000dcktmRW2UKOSBXbRAa
         eYgJZIlejE0zEzdDT4PQ0rZrFdLveKfRJ8EW1NjkKTHxxZZaHWJQtaLZxyQzKgwTplzl
         dUrZ5w5FyqGFSGs5sDcuTRS5RAiEJc8cjk7ghKmGjiXwsOdw9AgVXDj2GRlz1XgEdAKc
         rbSQ==
X-Gm-Message-State: AOJu0YxUAouTN9k8Bgin5YgZg8yIRyowkZRd7J0fktiRS2ubceJeWx1b
	luESwdx722IioaNCiMqR7y87LwFd9KNWs7hNfeE58XflkmQKaMJhjQlOYC69Uat0CshNseOSzA3
	k9Vqn
X-Gm-Gg: ASbGncuCNTfXXfMHqYHV587ryAM/+/w+PRjXCnPoQlm6o0w8Q2fi8IL2+yu09BJy/6e
	s1587UJ89YsBCLtPK7e5NO+a3epgFrymO7Tv//efh6nrO4aQ9CpK+gW6FVdPsX4eIBKVL2iPKSA
	qXDoLZjlrv1Y6Iz5+Ufy9VqRD95BR7sTFaMkxoEzZsKUdVGKcZ56wcYhsIvdk9KXmdxM+1omR2i
	Z8zBCIxgOQI1PNGKeFpmSwpm7ZHFEwVIZw+Fs0csfG+JrY8dbN7wXfJ5fiKaILSrbnSuWTz+Ojj
	FwNdQnjR1z0W8MrhtkkhMptgzXRKRNe/BzGADiuPpYKb/HYdrcREKGpPRG/dqr8VFAxl4+pMlyX
	sez1kLEJCxdwlTaLISnm62JIE8mTwANdNvVHPdlyXEoyJgSVyle8=
X-Google-Smtp-Source: AGHT+IGodwu9Ema/F++6khP3sxOtYe8Lk6ihd7fqGmrdKlMbGSFhWcIPzkjxkJ0Q2GP0zCI8j0/49Q==
X-Received: by 2002:a05:6000:290f:b0:3cd:d577:daa6 with SMTP id ffacd0b85a97d-3d1de5b098cmr3913001f8f.30.1756707944040;
        Sun, 31 Aug 2025 23:25:44 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2f0ac8sm9499527b3a.45.2025.08.31.23.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Aug 2025 23:25:43 -0700 (PDT)
Message-ID: <f7e848dc-7dd5-4c8b-9053-c38eb6c7739c@suse.com>
Date: Mon, 1 Sep 2025 15:55:40 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] btrfs: replace single page bio_iter_iovec() usage
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
References: <cover.1756703958.git.wqu@suse.com>
 <e1467a67f550f4d54afeac87051621fe58733ca5.1756703958.git.wqu@suse.com>
Content-Language: en-US
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
In-Reply-To: <e1467a67f550f4d54afeac87051621fe58733ca5.1756703958.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/1 14:54, Qu Wenruo 写道:
> There are several functions inside btrfs calling bio_iter_iovec(),
> mostly to do a block-by-block iteration on a bio.
> 
> - btrfs_check_read_bio()
> - btrfs_decompress_buf2page()
> - index_one_bio() from raid56
> 
> However that helper is single page based, meaning it will never return a
> bv_len larger than PAGE_SIZE. For now it's fine as we only support bs <=
> ps at most.
> 
> But for the incoming bs > ps support, we want to get bv_len larger than
> PAGE_SIZE so that the bio_vec will cover a full block, not just part of
> the large folio of the block.
> 
> In fact the call site inside btrfs_check_read_bio() will trigger
> ASSERT() inside btrfs_data_csum_ok() when bs > ps support is enabled.
> As bio_iter_iovec() will return a bv_len == 4K, meanwhile the bs is
> larger than 4K, triggering the ASSERT().
> 
> Replace those call sites with mp_bvec_iter_bvec(), which will return the
> full length of from the bi_io_vec array.
> Currently all call sites are already doing extra loop inside the bvec
> range for bs < ps support, so they will be fine.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/bio.c         | 3 ++-
>   fs/btrfs/compression.c | 3 +--
>   fs/btrfs/raid56.c      | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index ea7f7a17a3d5..f7aea4310dd6 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -277,8 +277,9 @@ static void btrfs_check_read_bio(struct btrfs_bio *bbio, struct btrfs_device *de
>   	bbio->bio.bi_status = BLK_STS_OK;
>   
>   	while (iter->bi_size) {
> -		struct bio_vec bv = bio_iter_iovec(&bbio->bio, *iter);
> +		struct bio_vec bv = mp_bvec_iter_bvec(bbio->bio.bi_io_vec, *iter);

This multi-page conversion is going to hit VM_BUG_ON() when 
btrfs_data_csum_ok() got a csum mismatch and has to call memzero_bvec(), 
which is a single page only helper.

I'm wondering what is the proper handling for mp bvec.


Since we're inside one mp vec, all the pages in the bvec should be 
physically contiguous. But will highmem sneak into a bvec?

If not, the memzero_page()'s check looks a little overkilled.

And if highmem page can sneak in, it means we will need a loop to 
map/zero/unmap...

Thanks,
Qu
>   
> +		ASSERT(bv.bv_len >= sectorsize && IS_ALIGNED(bv.bv_len, sectorsize));
>   		bv.bv_len = min(bv.bv_len, sectorsize);
>   		if (status || !btrfs_data_csum_ok(bbio, dev, offset, &bv))
>   			fbio = repair_one_sector(bbio, offset, &bv, fbio);
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 068339e86123..8b415c780ba8 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -1227,14 +1227,13 @@ int btrfs_decompress_buf2page(const char *buf, u32 buf_len,
>   	cur_offset = decompressed;
>   	/* The main loop to do the copy */
>   	while (cur_offset < decompressed + buf_len) {
> -		struct bio_vec bvec;
> +		struct bio_vec bvec = mp_bvec_iter_bvec(orig_bio->bi_io_vec, orig_bio->bi_iter);
>   		size_t copy_len;
>   		u32 copy_start;
>   		/* Offset inside the full decompressed extent */
>   		u32 bvec_offset;
>   		void *kaddr;
>   
> -		bvec = bio_iter_iovec(orig_bio, orig_bio->bi_iter);
>   		/*
>   		 * cb->start may underflow, but subtracting that value can still
>   		 * give us correct offset inside the full decompressed extent.
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index 3ff2bedfb3a4..df48dd6c3f54 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -1214,7 +1214,7 @@ static void index_one_bio(struct btrfs_raid_bio *rbio, struct bio *bio)
>   	while (iter.bi_size) {
>   		unsigned int index = (offset >> sectorsize_bits);
>   		struct sector_ptr *sector = &rbio->bio_sectors[index];
> -		struct bio_vec bv = bio_iter_iovec(bio, iter);
> +		struct bio_vec bv = mp_bvec_iter_bvec(bio->bi_io_vec, iter);
>   
>   		sector->has_paddr = true;
>   		sector->paddr = bvec_phys(&bv);


