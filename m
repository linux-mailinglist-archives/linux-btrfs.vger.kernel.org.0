Return-Path: <linux-btrfs+bounces-17372-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F49FBB5897
	for <lists+linux-btrfs@lfdr.de>; Fri, 03 Oct 2025 00:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 20C05342A4E
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Oct 2025 22:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E481919DF5F;
	Thu,  2 Oct 2025 22:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XiA2MccN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3460129A2
	for <linux-btrfs@vger.kernel.org>; Thu,  2 Oct 2025 22:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759443373; cv=none; b=DV6/M6Q0zDV1zPg73hSDw0IeCpSjQvNDNuCXE6u1ica+Uc23IbVTlQgJm4rk7N39UtosDTfH7OXLbdACs8ZGZOeugHF3rtlmyUDcKYyvQI7996l0JLSk3jTpCvdkcMSEre4LE7jtsBvnN4BSpvrcQh9z7PUdFG/pjaL3iOk0jrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759443373; c=relaxed/simple;
	bh=qkgsSw/+GdW6zNAk94SCwJOm2Kk3VL+V0bt/x4L6dSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MxMCzQMFhxfX/Y0qe2sQxUjcRUGTeo3egJZAqCJZg4/Ii5ZQFAZc6EX/up6stTPmrLyHjYzmttKGMmqzYDHCXIbsm4WglKm6G7FM2jMcNExvS5EZTWySqarJdK92A4758WacKgWxzCpoK7nt66bCdpe4UgQmI53mIJAWycAsK1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XiA2MccN; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ee15505cdeso1221018f8f.0
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Oct 2025 15:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759443368; x=1760048168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yoSN0RIDL5wrRKaF4Mte9RqXTZIerwQiJyZwDxpsB38=;
        b=XiA2MccNmcTz9y+cp6figDTY4s+vH4ZNFzx4/jYmIKop+BG+RvcdnZ1kUcUtrfBAWd
         yw65xqiovFCpNGWlVDkm1ZrFgxoWpoE4u+Hk8I7nSfWEAKS5gnRpUPG5a1QrCR6h5muA
         p3eH0pFgPCdniv8zdLjJI3Mn6HnhcOvFpS6f/gDmPsX1nxepch5uOZbg+9PeYLPxaZmd
         py5dgpWYh26XYqA5+K+nL+R2eE16Yqq4uop6n94Z8J1XQZPZCZEULZW9+n+rrC8ImeCb
         9ZkkE4sX8XKK3T54dDXgape9bSx8vbfOhBloYhK3n62DyjHDtM3PHvxN1ZCHrCb8ZFSL
         uqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759443368; x=1760048168;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yoSN0RIDL5wrRKaF4Mte9RqXTZIerwQiJyZwDxpsB38=;
        b=BYCRdr5h7rUFYCaZK++z4xP+amhtOLRaQMz2ENLchg4kSFYjAHURSRxQRxv2wy1rzU
         mF3rLoDW7+6QBOLNEUZS9uJ+Y1k9mrN1r+sJ1C+IMFvotUm4HJuLPpm+6h2ujGziBR96
         Y5wttZDLAZBv4v+jRmGO9jDff0jFA7dYPQ0jzeXN9uCylWgN0rHQikkciAUI/WxQj7kh
         OYFvk8L/pDiuc89CLzMh8huDoDwjghGn/IxqBrVuensK7YrgSXVu7mpOy3R7cwlx4eNW
         K240Nz2s8gwtyor4LkqhPLQ5evoK9ZoOtozvFO4/yhpABB3R6Hs3VQ6nnRT73TLOoFXz
         /B0w==
X-Forwarded-Encrypted: i=1; AJvYcCVMM7HpNAzH+hAJcaX9vqIa1KaZGQf44PFXSOo8gxm2q8dSZSBl32B9sv05Jzuty8L4U6JylvUCAyl58A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+rsiWSJkDjze5IiScSdmhKtdjvi6BRysUGVJ49MUfycj1Gn4J
	36wu/ONMgdFAcdnU/oZI1/+13QY1wMU4n4WHEGULr4tYKa2FJGLMrGI/TiISXsgPFMw=
X-Gm-Gg: ASbGncsJKtiluZOAwoJyyMwKaeXZmUyF7vhx5sNWXN++Dgxn7fIvvdtz3GCv/eGuo+y
	YBcW8zwvKPnGgd/9UPLCDaAgu5qJ0tzHGjj8X/HwVRZ7QzxwSfb1jRN/D5SgPNBRfRa/XL3QJDB
	qDX9+anwejTF5RI6WJLamIyiUSM21k34v1xURgEQ8D4H/l0u358pPqQwb+SRVoXSE6EHDdidv2Q
	eM0gChhUv0nVDtmpNCgRzeU7WhjRROxp//q0p+UYYp+xR3Jc3aHYznheU9ot6FPhtfRFiB9F48Z
	6YeiJkc9Dt7F3ivnY3O/yPa2/sHcGXKLBYNDOd89UHmCo8eExImP6YNhXg8ahviwHHRV1uJ2z35
	MSospKjwDoAqNSUIuex7MujYl3OuqL9OmJIHm+2ro0bCthu+YCXXbfhL7W8P54jt+XYXg2ldCBX
	I=
X-Google-Smtp-Source: AGHT+IGgSg3ROVCEWdutb2Pu+yaGCKNELQPm9u9L3L1jZ1UK60BF424LoNN71CYQvS85oSJIJ0kGow==
X-Received: by 2002:a05:6000:40d9:b0:404:2fe4:3a80 with SMTP id ffacd0b85a97d-4255d2cafc9mr3276622f8f.25.1759443368216;
        Thu, 02 Oct 2025 15:16:08 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b62ce55205csm441657a12.18.2025.10.02.15.16.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 15:16:07 -0700 (PDT)
Message-ID: <c885e50a-8076-4517-a0c0-b2dd85d5581a@suse.com>
Date: Fri, 3 Oct 2025 07:46:03 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: fix racy bitfield write in
 btrfs_clear_space_info_full()
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <22e8b64df3d4984000713433a89cfc14309b75fc.1759430967.git.boris@bur.io>
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
In-Reply-To: <22e8b64df3d4984000713433a89cfc14309b75fc.1759430967.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/3 04:20, Boris Burkov 写道:
>  From the memory-barriers.txt document regarding memory barrier ordering
> guarantees:
> 
>   (*) These guarantees do not apply to bitfields, because compilers often
>       generate code to modify these using non-atomic read-modify-write
>       sequences.  Do not attempt to use bitfields to synchronize parallel
>       algorithms.
> 
>   (*) Even in cases where bitfields are protected by locks, all fields
>       in a given bitfield must be protected by one lock.  If two fields
>       in a given bitfield are protected by different locks, the compiler's
>       non-atomic read-modify-write sequences can cause an update to one
>       field to corrupt the value of an adjacent field.
> 
> btrfs_space_info has a bitfield sharing an underlying word consisting of
> the fields full, chunk_alloc, and flush:
> 
> struct btrfs_space_info {
>          struct btrfs_fs_info *     fs_info;              /*     0     8 */
>          struct btrfs_space_info *  parent;               /*     8     8 */
>          ...
>          int                        clamp;                /*   172     4 */
>          unsigned int               full:1;               /*   176: 0  4 */
>          unsigned int               chunk_alloc:1;        /*   176: 1  4 */
>          unsigned int               flush:1;              /*   176: 2  4 */
>          ...
> 
> Therefore, to be safe from parallel read-modify-writes losing a write to one of the bitfield members protected by a lock, all writes to all the
> bitfields must use the lock. They almost universally do, except for
> btrfs_clear_space_info_full() which iterates over the space_infos and
> writes out found->full = 0 without a lock.
> 
> Imagine that we have one thread completing a transaction in which we
> finished deleting a block_group and are thus calling
> btrfs_clear_space_info_full() while simultaneously the data reclaim
> ticket infrastructure is running do_async_reclaim_data_space():
> 
>            T1                                             T2
> btrfs_commit_transaction
>    btrfs_clear_space_info_full
>    data_sinfo->full = 0
>    READ: full:0, chunk_alloc:0, flush:1
>                                                do_async_reclaim_data_space(data_sinfo)
>                                                spin_lock(&space_info->lock);
>                                                if(list_empty(tickets))
>                                                  space_info->flush = 0;
>                                                  READ: full: 0, chunk_alloc:0, flush:1
>                                                  MOD/WRITE: full: 0, chunk_alloc:0, flush:0
>                                                  spin_unlock(&space_info->lock);
>                                                  return;
>    MOD/WRITE: full:0, chunk_alloc:0, flush:1
> 
> and now data_sinfo->flush is 1 but the reclaim worker has exited. This
> breaks the invariant that flush is 0 iff there is no work queued or
> running. Once this invariant is violated, future allocations that go
> into __reserve_bytes() will add tickets to space_info->tickets but will
> see space_info->flush is set to 1 and not queue the work. After this,
> they will block forever on the resulting ticket, as it is now impossible
> to kick the worker again.
> 
> I also confirmed by looking at the assembly of the affected kernel that
> it is doing RMW operations. For example, to set the flush (3rd) bit to 0,
> the assembly is:
>    andb    $0xfb,0x60(%rbx)
> and similarly for setting the full (1st) bit to 0:
>    andb    $0xfe,-0x20(%rax)
> 
> So I think this is really a bug on practical systems.  I have observed
> a number of systems in this exact state, but am currently unable to
> reproduce it.
> 
> Rather than leaving this footgun lying around for the future, take
> advantage of the fact that there is room in the struct anyway, and that
> it is already quite large and simply change the three bitfield members to
> bools. This avoids writes to space_info->full having any effect on
> writes to space_info->flush, regardless of locking.
> 
> Fixes: 957780eb2788 ("Btrfs: introduce ticketed enospc infrastructure")
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Indeed it's much more straightfoward than asymmetric locking, and still 
less changes than a full bitmap implementation.

Thanks,
Qu
> ---
> Changelog:
> v2:
> - migrate the three bitfield members to bools to step around the whole
>    atomic RMW issue in the most straightforward way.
> 
> ---
>   fs/btrfs/block-group.c |  6 +++---
>   fs/btrfs/space-info.c  | 22 +++++++++++-----------
>   fs/btrfs/space-info.h  |  6 +++---
>   3 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 4330f5ba02dd..cd51f50a7c8b 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -4215,7 +4215,7 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans,
>   			mutex_unlock(&fs_info->chunk_mutex);
>   		} else {
>   			/* Proceed with allocation */
> -			space_info->chunk_alloc = 1;
> +			space_info->chunk_alloc = true;
>   			wait_for_alloc = false;
>   			spin_unlock(&space_info->lock);
>   		}
> @@ -4264,7 +4264,7 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans,
>   	spin_lock(&space_info->lock);
>   	if (ret < 0) {
>   		if (ret == -ENOSPC)
> -			space_info->full = 1;
> +			space_info->full = true;
>   		else
>   			goto out;
>   	} else {
> @@ -4274,7 +4274,7 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans,
>   
>   	space_info->force_alloc = CHUNK_ALLOC_NO_FORCE;
>   out:
> -	space_info->chunk_alloc = 0;
> +	space_info->chunk_alloc = false;
>   	spin_unlock(&space_info->lock);
>   	mutex_unlock(&fs_info->chunk_mutex);
>   
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 0e5c0c80e0fe..04a07d6f8537 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -192,7 +192,7 @@ void btrfs_clear_space_info_full(struct btrfs_fs_info *info)
>   	struct btrfs_space_info *found;
>   
>   	list_for_each_entry(found, head, list)
> -		found->full = 0;
> +		found->full = false;
>   }
>   
>   /*
> @@ -372,7 +372,7 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
>   	space_info->bytes_readonly += block_group->bytes_super;
>   	btrfs_space_info_update_bytes_zone_unusable(space_info, block_group->zone_unusable);
>   	if (block_group->length > 0)
> -		space_info->full = 0;
> +		space_info->full = false;
>   	btrfs_try_granting_tickets(info, space_info);
>   	spin_unlock(&space_info->lock);
>   
> @@ -1146,7 +1146,7 @@ static void do_async_reclaim_metadata_space(struct btrfs_space_info *space_info)
>   	spin_lock(&space_info->lock);
>   	to_reclaim = btrfs_calc_reclaim_metadata_size(fs_info, space_info);
>   	if (!to_reclaim) {
> -		space_info->flush = 0;
> +		space_info->flush = false;
>   		spin_unlock(&space_info->lock);
>   		return;
>   	}
> @@ -1158,7 +1158,7 @@ static void do_async_reclaim_metadata_space(struct btrfs_space_info *space_info)
>   		flush_space(fs_info, space_info, to_reclaim, flush_state, false);
>   		spin_lock(&space_info->lock);
>   		if (list_empty(&space_info->tickets)) {
> -			space_info->flush = 0;
> +			space_info->flush = false;
>   			spin_unlock(&space_info->lock);
>   			return;
>   		}
> @@ -1201,7 +1201,7 @@ static void do_async_reclaim_metadata_space(struct btrfs_space_info *space_info)
>   					flush_state = FLUSH_DELAYED_ITEMS_NR;
>   					commit_cycles--;
>   				} else {
> -					space_info->flush = 0;
> +					space_info->flush = false;
>   				}
>   			} else {
>   				flush_state = FLUSH_DELAYED_ITEMS_NR;
> @@ -1383,7 +1383,7 @@ static void do_async_reclaim_data_space(struct btrfs_space_info *space_info)
>   
>   	spin_lock(&space_info->lock);
>   	if (list_empty(&space_info->tickets)) {
> -		space_info->flush = 0;
> +		space_info->flush = false;
>   		spin_unlock(&space_info->lock);
>   		return;
>   	}
> @@ -1394,7 +1394,7 @@ static void do_async_reclaim_data_space(struct btrfs_space_info *space_info)
>   		flush_space(fs_info, space_info, U64_MAX, ALLOC_CHUNK_FORCE, false);
>   		spin_lock(&space_info->lock);
>   		if (list_empty(&space_info->tickets)) {
> -			space_info->flush = 0;
> +			space_info->flush = false;
>   			spin_unlock(&space_info->lock);
>   			return;
>   		}
> @@ -1411,7 +1411,7 @@ static void do_async_reclaim_data_space(struct btrfs_space_info *space_info)
>   			    data_flush_states[flush_state], false);
>   		spin_lock(&space_info->lock);
>   		if (list_empty(&space_info->tickets)) {
> -			space_info->flush = 0;
> +			space_info->flush = false;
>   			spin_unlock(&space_info->lock);
>   			return;
>   		}
> @@ -1428,7 +1428,7 @@ static void do_async_reclaim_data_space(struct btrfs_space_info *space_info)
>   				if (maybe_fail_all_tickets(fs_info, space_info))
>   					flush_state = 0;
>   				else
> -					space_info->flush = 0;
> +					space_info->flush = false;
>   			} else {
>   				flush_state = 0;
>   			}
> @@ -1444,7 +1444,7 @@ static void do_async_reclaim_data_space(struct btrfs_space_info *space_info)
>   
>   aborted_fs:
>   	maybe_fail_all_tickets(fs_info, space_info);
> -	space_info->flush = 0;
> +	space_info->flush = false;
>   	spin_unlock(&space_info->lock);
>   }
>   
> @@ -1825,7 +1825,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
>   				 */
>   				maybe_clamp_preempt(fs_info, space_info);
>   
> -				space_info->flush = 1;
> +				space_info->flush = true;
>   				trace_btrfs_trigger_flush(fs_info,
>   							  space_info->flags,
>   							  orig_bytes, flush,
> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
> index 679f22efb407..a846f63585c9 100644
> --- a/fs/btrfs/space-info.h
> +++ b/fs/btrfs/space-info.h
> @@ -142,11 +142,11 @@ struct btrfs_space_info {
>   				   flushing. The value is >> clamp, so turns
>   				   out to be a 2^clamp divisor. */
>   
> -	unsigned int full:1;	/* indicates that we cannot allocate any more
> +	bool full;		/* indicates that we cannot allocate any more
>   				   chunks for this space */
> -	unsigned int chunk_alloc:1;	/* set if we are allocating a chunk */
> +	bool chunk_alloc;	/* set if we are allocating a chunk */
>   
> -	unsigned int flush:1;		/* set if we are trying to make space */
> +	bool flush;		/* set if we are trying to make space */
>   
>   	unsigned int force_alloc;	/* set if we need to force a chunk
>   					   alloc for this space */


