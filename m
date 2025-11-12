Return-Path: <linux-btrfs+bounces-18922-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FAAC5489C
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 22:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94FA64E0F02
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 21:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E5D2D77E6;
	Wed, 12 Nov 2025 21:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fSzHPXHh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF66628031D
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Nov 2025 21:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762981380; cv=none; b=dAOqv3AuiO96yVatGGkN3bFLN57wz5GtYgtMzb0zavcTlw+GGY5VZ36ob9WBcRM1HhdmJ2E84a70gw3kRyGGrbTAiXesNNmkhf/bFGJAD/XlpkakvwsICjIvUtmfJqtBuxB0dK7JuyGxF9pZ9T/bW0Y2ctCPrrj0JdFjv8Ukz+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762981380; c=relaxed/simple;
	bh=S008Lw4+tWKvCnFaAtOZwn+7R8lZIQdLThlgQTZ6uQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SmBpobdg2+gnpgRfdEmwBHFnj3HQ2uOj38Tcghy62IMHEtcfdBIRl27ZNHK2xCbuZN5GeLParw8GWUQv103cn5cck4gLzie6k8LVo8aq7sjSJOOd257WEEyZ1hAIB5oPkmKosqykwxkkNLmFdW+zbckWgYk8Kj5Q/4+p9Swewyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fSzHPXHh; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42b39d51dcfso55000f8f.2
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Nov 2025 13:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762981375; x=1763586175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aBIabz0Db6BveiYXDEg+cZSjgtIsKw5jRCZOR+iEsKI=;
        b=fSzHPXHh5Gi3ImVueSmI73rIH/7xmxsJdDUK2IosgGdaz7dxy3c0ZmTwGLFLPcLOK1
         4qPP0V3xWQBT4V3KTprWOpquWsim5jgglKN2LzAKRtaijYpb3GZMVbxfV4qq2MqgJTPd
         MPrxCxLO/dyFzG4zIQ9rxyON36wzNvUy3HhN4EodsnSWU6uuGqB8WpHUsFSGusDO3Jhs
         pb0/qUdmvjx+5MW6hJnz9LkDuZDK2+kbKW8Fi9U5FXs204oFh47gXvasZ2D4iesiloHO
         VjfwtwYE+8mdIFX87ySTH+EsHsxgi3rAjmizN4OSSoEmVKVFMKyVxop6rl9i45z6hVEw
         m/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762981375; x=1763586175;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBIabz0Db6BveiYXDEg+cZSjgtIsKw5jRCZOR+iEsKI=;
        b=XF/1LrjZCloMq2mAG65JbnRJ3LL9l+mquokzM85mTePh8sRyx5M8X7H6ZwqvWzu0M9
         2VfZeePg99FqYj4iqyXcHSzd5uP4sT2InDKIeQac+vLAQbNgtslac3u9+htQ28Q/H227
         ZnXtZ8Y/nWeYjnUGzUzwwgEUPynPeKgyISjwvIHtzGY4+PGrWFTKze2pkjlZLauff7ie
         GdRqeTzG8lcWitGhVL/VodOk7aawQYpD9lFovlTh2bqLCmCs+xUbv5RbbC3gXgDiZvdY
         Q3aBH9W7sdqWLHmDhK2/Uv/hFQwvyt+C0oEr6qGKPjlHDNWMfrCMW7g6tx83SUeIgl1/
         DiOQ==
X-Gm-Message-State: AOJu0YyIJm1ngGvqUxqz+hZfzgzgnxKZz5pfGwRkd8AJyOLNx0lbkYg/
	OdzwVjHhsPU8V0kkTHSagXt5YOJ71KcpNkIlNrMWkq+PHGeHIlKKq+aDaMIeXVc/ScQ=
X-Gm-Gg: ASbGncvkwm7pRsidyyiGnCQr+/xAoqCs38WzDY13XrUt0u8qNfp2LJAxXhcL2Y6DyMm
	0ohaXusOFhAQmxee+cP+k0jkV0QWhymxVI3eHq4/7r6Ez3StcnezeHf2P8LrH2mA6n7I5jjUJcA
	n9+zaqi30DcZ3mxh4jEsvULsyn2pi2H2+2IpVaPKif83v+IYpH6NmNexTCiw7AKfKBmMM/+HAj+
	FD/E6ccIxisHBkbyasSGtkxmoOZTj9ZDeIkB9D73l6PN5bzsMUH+KM9yGSsD+0aA0H4E/7PvOat
	0Wib+WVHFL59tgonw6vw9Refc8OiWK11rqN3w7w8ZccR3egbGEZBw0s9+hN2v2HPrCX7ak0pdlL
	3obHuYsEttGJfnJmG+GgFyQszX5NJDhiiql70z07wBcKSX1rKsMguUHBj6bQGLcHLA40VvY4sQY
	KR1apqkPYWhTuE2vj/Q1qxFH6trXol
X-Google-Smtp-Source: AGHT+IHm22Yvc2GqP11XLe1NvY4BraBr9btTJwcbhvLq4uR8Z7mY89xMnx39BVD4TNkfmZc1R4drnA==
X-Received: by 2002:a05:6000:4008:b0:42b:4219:269 with SMTP id ffacd0b85a97d-42b4bdb0029mr4394852f8f.41.1762981375052;
        Wed, 12 Nov 2025 13:02:55 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b10c8sm733025ad.64.2025.11.12.13.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 13:02:54 -0800 (PST)
Message-ID: <7de34b24-f189-402a-98f9-83e595b53244@suse.com>
Date: Thu, 13 Nov 2025 07:32:48 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/8] btrfs: add a bio argument to btrfs_csum_one_bio
To: Daniel Vacek <neelx@suse.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251112193611.2536093-1-neelx@suse.com>
 <20251112193611.2536093-4-neelx@suse.com>
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
In-Reply-To: <20251112193611.2536093-4-neelx@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/13 06:06, Daniel Vacek 写道:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> We only ever needed the bbio in btrfs_csum_one_bio, since that has the
> bio embedded in it.  However with encryption we'll have a different bio
> with the encrypted data in it, and the original bbio.  Update
> btrfs_csum_one_bio to take the bio we're going to csum as an argument,
> which will allow us to csum the encrypted bio and stuff the csums into
> the corresponding bbio to be used later when the IO completes.

I'm wondering why we can not do it in a layered bio way.

E.g. on device-mapper based solutions, the upper layer send out the bio 
containing the plaintext data.
Then the dm-crypto send out a new bio, containing the encrypted data.

The storage layer doesn't need to bother the plaintext bio at all, they 
just write the encrypted one to disk.

And it's the dm-crypto tracking the plaintext bio <-> encrypted bio mapping.


So why we can not just create a new bio for the final csum caculation, 
just like compression?

Thanks,
Qu

> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Daniel Vacek <neelx@suse.com>
> ---
> Compared to v5 this needed to adapt to recent async csum changes.
> ---
>   fs/btrfs/bio.c       |  4 ++--
>   fs/btrfs/bio.h       |  1 +
>   fs/btrfs/file-item.c | 17 ++++++++---------
>   fs/btrfs/file-item.h |  2 +-
>   4 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index a73652b8724a..a69174b2b6b6 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -542,9 +542,9 @@ static int btrfs_bio_csum(struct btrfs_bio *bbio)
>   	if (bbio->bio.bi_opf & REQ_META)
>   		return btree_csum_one_bio(bbio);
>   #ifdef CONFIG_BTRFS_EXPERIMENTAL
> -	return btrfs_csum_one_bio(bbio, true);
> +	return btrfs_csum_one_bio(bbio, &bbio->bio, true);
>   #else
> -	return btrfs_csum_one_bio(bbio, false);
> +	return btrfs_csum_one_bio(bbio, &bbio->bio, false);
>   #endif
>   }
>   
> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> index deaeea3becf4..c5a6c66d51a0 100644
> --- a/fs/btrfs/bio.h
> +++ b/fs/btrfs/bio.h
> @@ -58,6 +58,7 @@ struct btrfs_bio {
>   			struct btrfs_ordered_sum *sums;
>   			struct work_struct csum_work;
>   			struct completion csum_done;
> +			struct bio *csum_bio;
>   			struct bvec_iter csum_saved_iter;
>   			u64 orig_physical;
>   		};
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index 72be3ede0edf..474949074da8 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -765,21 +765,19 @@ int btrfs_lookup_csums_bitmap(struct btrfs_root *root, struct btrfs_path *path,
>   	return ret;
>   }
>   
> -static void csum_one_bio(struct btrfs_bio *bbio, struct bvec_iter *src)
> +static void csum_one_bio(struct btrfs_bio *bbio, struct bio *bio, struct bvec_iter *iter)
>   {
>   	struct btrfs_inode *inode = bbio->inode;
>   	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>   	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
> -	struct bio *bio = &bbio->bio;
>   	struct btrfs_ordered_sum *sums = bbio->sums;
> -	struct bvec_iter iter = *src;
>   	phys_addr_t paddr;
>   	const u32 blocksize = fs_info->sectorsize;
>   	int index = 0;
>   
>   	shash->tfm = fs_info->csum_shash;
>   
> -	btrfs_bio_for_each_block(paddr, bio, &iter, blocksize) {
> +	btrfs_bio_for_each_block(paddr, bio, iter, blocksize) {
>   		btrfs_calculate_block_csum(fs_info, paddr, sums->sums + index);
>   		index += fs_info->csum_size;
>   	}
> @@ -791,19 +789,18 @@ static void csum_one_bio_work(struct work_struct *work)
>   
>   	ASSERT(btrfs_op(&bbio->bio) == BTRFS_MAP_WRITE);
>   	ASSERT(bbio->async_csum == true);
> -	csum_one_bio(bbio, &bbio->csum_saved_iter);
> +	csum_one_bio(bbio, bbio->csum_bio, &bbio->csum_saved_iter);
>   	complete(&bbio->csum_done);
>   }
>   
>   /*
>    * Calculate checksums of the data contained inside a bio.
>    */
> -int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool async)
> +int btrfs_csum_one_bio(struct btrfs_bio *bbio, struct bio *bio, bool async)
>   {
>   	struct btrfs_ordered_extent *ordered = bbio->ordered;
>   	struct btrfs_inode *inode = bbio->inode;
>   	struct btrfs_fs_info *fs_info = inode->root->fs_info;
> -	struct bio *bio = &bbio->bio;
>   	struct btrfs_ordered_sum *sums;
>   	unsigned nofs_flag;
>   
> @@ -822,12 +819,14 @@ int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool async)
>   	btrfs_add_ordered_sum(ordered, sums);
>   
>   	if (!async) {
> -		csum_one_bio(bbio, &bbio->bio.bi_iter);
> +		struct bvec_iter iter = bio->bi_iter;
> +		csum_one_bio(bbio, bio, &iter);
>   		return 0;
>   	}
>   	init_completion(&bbio->csum_done);
>   	bbio->async_csum = true;
> -	bbio->csum_saved_iter = bbio->bio.bi_iter;
> +	bbio->csum_bio = bio;
> +	bbio->csum_saved_iter = bio->bi_iter;
>   	INIT_WORK(&bbio->csum_work, csum_one_bio_work);
>   	schedule_work(&bbio->csum_work);
>   	return 0;
> diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
> index 5645c5e3abdb..d16fd2144552 100644
> --- a/fs/btrfs/file-item.h
> +++ b/fs/btrfs/file-item.h
> @@ -64,7 +64,7 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
>   int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
>   			   struct btrfs_root *root,
>   			   struct btrfs_ordered_sum *sums);
> -int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool async);
> +int btrfs_csum_one_bio(struct btrfs_bio *bbio, struct bio *bio, bool async);
>   int btrfs_alloc_dummy_sum(struct btrfs_bio *bbio);
>   int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
>   			     struct list_head *list, int search_commit,


