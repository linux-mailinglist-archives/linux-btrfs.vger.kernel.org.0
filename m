Return-Path: <linux-btrfs+bounces-16793-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98006B52FF1
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Sep 2025 13:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B81EB60DB1
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Sep 2025 11:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223663115BD;
	Thu, 11 Sep 2025 11:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D5UtMAOK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA72630C347
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Sep 2025 11:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589142; cv=none; b=sCrksr40qHZEX9TbPd1bs0WG+SjDHwax9IEXTAb/cTqQc+YSby6CpDT5CMfemZRKREbYO55Dh/hqiS3ECy2oOyLq3i3NCiBY7A8xR+JNLVT+IL1gRj00eLsgoqhl8iHB0omxmtCR6mxL3ZHjOJEMdmrZrw+v5K0Nf0pQyInzTSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589142; c=relaxed/simple;
	bh=/iK14FyQiWLM6ioXmn9hp4DT2g/xtwe6DPRxbflkqv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GU/ptmPxzwJch2IMg9rYG3AuGtN2qAQgPuMwYYOGuya9D30ZOO6L70Rj5tpieKHhw2mdVQ3qFdkaC+HySta4jvq9L/lk0vNm9GUfEqZfg9AtMSJVK+QnkxToXUmahkwNX24ZfDkkHSP2BFwhmBlrrOhOPLbO5zZ7UwZEBVmZc8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D5UtMAOK; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3e46fac8421so587445f8f.2
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Sep 2025 04:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757589137; x=1758193937; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wFaJSxPX0DPNCVXymeYOsGldSZ1f+qC3fyfNHrF1DwA=;
        b=D5UtMAOKEwVuILba+UHdPXNqANZGbdZ+1nC8vVxNuGIkqD3Z11XT6PPwVWY8ajH8rN
         VgiIQ+ugEMt0fcUla3vEFtVOJ0N1pJk++/mLPeV1wBvguTt06DPsvc6XsYaHcFvGDuZS
         bFQ1ATZS+PxvH/OHVn7JfgCodWO9siPsHoK0T0hlBWD4mxt2oeIMqSwDJjdjJaX1+V6g
         C3h6daNP7HSLuEjJWAEcYezEetDUNQ8WhkTez1Pb2cr2Na57v6Tz4H2VyRjUobwN1IQv
         NZzeydfsk0ogFo5yn5RA9+/jOMwAT+dn6ZuYpuPR+7enY1QTXq79DtxtWDSn4qRjNxqM
         BhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757589137; x=1758193937;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wFaJSxPX0DPNCVXymeYOsGldSZ1f+qC3fyfNHrF1DwA=;
        b=HBiHncqMBIDoH07hOXA6ohL+lIHHpbdEUlBQUUdIQk9MGw+I8Pf7IBUwqTS1QirsEZ
         8BA3N8YLoCyBpJO0fbCik/aBUhY3HnxWU16R9oYSPATbIVs02NN9rfiRI7Q+oqbL04Gv
         K/vxQDztjzCIk23ACl7kqSjIpdfXEwNwjf4hxTMj3Moq5Ypzd05gxJ3eK/WWiCYpfwXo
         pIK96x8w96fSJRH0Tm9pnBdjHkye2YTfYKjPubapkdwxTIcwS38eq7/yAPsYNl/Mrq9R
         iPa3OJCTLujHnXZLTFrLQPtl5bIleugHp9jJzHcN5Y8GRbeuKHGVOfWkVIPmvY2SzQ9T
         j/uw==
X-Forwarded-Encrypted: i=1; AJvYcCULYa3AiHUhuHlrwuDOQAYmeILH+Odqqa56HgxBKFcsO0HXryIOZnZSVb1Q0G7HFn8tbk4iGg0JEqc+gA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGj6Ryp3kC9q1DBrgh38EYU+yItu0DXkED3YKoNBFT8zticm+5
	usMw+GP8wNBd1o7cY1cROO0iggY9JTi63b0Iv06F/Mr5XMwkGmBKWyYGJ+fun14mKTQ=
X-Gm-Gg: ASbGnct96yHI2HirrMOKgSN8A8ltRy/qTNxmcXbu4kDF1feXfAZspURtFO6H53O8vyr
	20qtPVrg5rBn4F1GCRs/WkZpJrTatmcGhQA27oZIGVExD6QHgTB/j2bDQFJaH26s4+i1Xo9zwUr
	r0+P7PLFCRChlZTpYHYFkt1aDnpu0aaOsCVW+Tb9FTyNZ0KxggMj4VbiPvQ5lrGya9Bz/8+3po/
	Uvh4j/mXgIFBOHIkeDsqQhqAlsE67ZJOECj3wHwNb98OCm7LN9J2UhH+4GcNRWgMmbb/jrCDS4y
	sm9TLVaH2q+Kbq7kVOw/kxpcniq1VQ+WX0emskvbb5pFlxVgZlRvKnVip2pttbt7qNCTmGy5kNk
	ypG8jzusSuMyJpIP9RCRwrr06QzOAUAcFlo06/Rr+2nY8kh/07wQ=
X-Google-Smtp-Source: AGHT+IH3F2d7SB8U1NMpt0/7LCb5gRk+eYhT3v25+77NUNP71oxzVH6Te5NB4Tq+Y1jw7J0SRmgI7w==
X-Received: by 2002:a05:6000:1a8c:b0:3d1:bb77:911d with SMTP id ffacd0b85a97d-3e64cd57d4fmr15768218f8f.58.1757589137091;
        Thu, 11 Sep 2025 04:12:17 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c37293ee5sm15988985ad.36.2025.09.11.04.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 04:12:16 -0700 (PDT)
Message-ID: <4e254b82-b4de-4b16-a469-9c58c805938f@suse.com>
Date: Thu, 11 Sep 2025 20:42:12 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: annotate block group access with data_race() when
 sorting for reclaim
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <456b17e9620d5118fcca2674b365e0770b1d1fc1.1757332833.git.fdmanana@suse.com>
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
In-Reply-To: <456b17e9620d5118fcca2674b365e0770b1d1fc1.1757332833.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/8 21:35, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When sorting the block group list for reclaim we are using a block group's
> used bytes counter without taking the block group's spinlock, so we can
> race with a concurrent task updating it (at btrfs_update_block_group()),
> which makes tools like KCSAN unhappy and report a race.
> 
> Since the sorting is not strictly needed from a functional perspective
> and such races should rarely cause any ordering changes (only load/store
> tearing could cause them), not to mention that after the sorting the
> ordering may no longer be accurate due to concurrent allocations and
> deallocations of extents in a block group, annotate the accesses to the
> used counter with data_race() to silence KCSAN and similar tools.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/block-group.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 239cbb01f83f..548483a84466 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1795,7 +1795,14 @@ static int reclaim_bgs_cmp(void *unused, const struct list_head *a,
>   	bg1 = list_entry(a, struct btrfs_block_group, bg_list);
>   	bg2 = list_entry(b, struct btrfs_block_group, bg_list);
>   
> -	return bg1->used > bg2->used;
> +	/*
> +	 * Some other task may be updating the ->used field concurrently, but it
> +	 * is not serious if we get a stale value or load/store tearing issues,
> +	 * as sorting the list of block groups to reclaim is not critical and an
> +	 * occasional imperfect order is ok. So silence KCSAN and avoid the
> +	 * overhead of locking or any other synchronization.
> +	 */
> +	return data_race(bg1->used > bg2->used);
>   }
>   
>   static inline bool btrfs_should_reclaim(const struct btrfs_fs_info *fs_info)


