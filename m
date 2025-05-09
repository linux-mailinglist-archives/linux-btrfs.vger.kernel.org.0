Return-Path: <linux-btrfs+bounces-13858-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F16DAB1EB0
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 May 2025 23:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1499717BB0C
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 May 2025 21:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B644225F7B3;
	Fri,  9 May 2025 21:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cgP9NBzP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F84A25394A
	for <linux-btrfs@vger.kernel.org>; Fri,  9 May 2025 21:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746824865; cv=none; b=q5PG8G3SEnZpg+w5+CUoaU36I5UW5BeXWjLoo6r6GSx8ZLcd6ufQ+NGILSk+ze5XFLpBbLYRYudObo4o8PLX+0Uds1HcYM48X/OCxMfi/zcdOV33iznmMSzeN+NuL2PKRqY7RGDbVGBmi+FArzS84S/VzSy4KEF+57C+MdqQxeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746824865; c=relaxed/simple;
	bh=eDL6KoVz6HI9GtNy8IYJpIyJwxoIz/BDSroikyD6d7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tycQin1FZ151YJtP5ANGVIBQMmsaAleU34XdZXjm5SkoBOk166Qn8q4dFAxz+Gt0JCheX6Vstyk6u2J6JN3FHOfMu4ZucNgdE34q0BbhsQkoWnKvbO+YlfDrUHpdGT3sKVGFfrS9/+3GYAvi2+jMQ6ftyEtv4DMPZCEM/m1KEv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cgP9NBzP; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a0b9c371d8so2043096f8f.0
        for <linux-btrfs@vger.kernel.org>; Fri, 09 May 2025 14:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746824861; x=1747429661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=knq3OW5G0zsemWq+HPTHovRd0gq1xwD/tvhBncNS0fk=;
        b=cgP9NBzPq5+SXq13XRq+HvWCPneGQsRqoy6R550hkKdPGjLDWjekUB9P76qmuo090K
         AdvFl7pJlc2NdAJk3eE8cGgIrm+yMmLftZHs/wQpF3wGzzKNBLNyOjGWR5RUDHftkVVh
         NQmd/Q9IiLZUFcRC3vYNic/iuXJczLuDJtKHk3D+dg7IxUa+iN33+ppxFxeYIIDWkc2P
         ab0UIwRBnXKUFX8MzORgViYhAhgnmyFGlAei9fM5FiZPrBzZ3GCiHtepIH6oU4F0Qcix
         uuLHNH9Z0MTR0NtswCE/bu0JzEEF5bLD1qV4/71bzHAeW8wcryDX0gL6VNhLCRXADVgz
         5eEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746824861; x=1747429661;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=knq3OW5G0zsemWq+HPTHovRd0gq1xwD/tvhBncNS0fk=;
        b=AiVgJLyXFlRHIB49JWkBkPOlXp34ZYs36FTWQttlfMHin9JLhAghUUyf06FVpFoO2I
         78heXqPjhYk1t1HGpc315wU3KVgTJiKogMlyG0kahNTqE63N55HK84CAxpIsP6ezOPHs
         MrEHh7tFH+1WsMLs82wqeYJTbItYxRJ0ImPnHfvzje3JchD834zV029r3iwRqMh4+EwE
         YjxhHm1ZvSK07wWTYOQK/gCs0ZOakCJdTsAFvlug2n2orrSAsF3ZQpJVObwagE9ADPPV
         hdGBj4G+VLNLu85uDJWBx//KGqFPutfE1ySTvV+WHJ9TmjcEOv8n6askL8eNZyDBi77R
         Cmqg==
X-Forwarded-Encrypted: i=1; AJvYcCV6Cz7ex8qJYOK4Q9DgbhcL3K7BwCsyPoQNDHT9w38JerxclMALTrCzybopYCzVGvUYOMhNwF0hjNVYqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtwgZexxBediRbB23+l/lj1XAZ0sVyIhSkeEv3gsAoEsoWXVAF
	nPCxe9mxtp5aI3PNx8bxv4pE6Hac1T+li4eNyYrhjiNiuFTfDjwjVE7N3G6xvTg=
X-Gm-Gg: ASbGncvAK63eb4Q/IIWBOLDZrjPk4l0DNipPxBiYZbpqaGk8aFbNBPIOxj4iVnRcrA2
	wk6C2eIhbzLCJLEb+GR/l+amv0fC+dyjw1VOGQkIYDqPdpZRMVZvY8ZhsbUQvzoyZ6ACRP9i/IE
	ucPz/O410QUQRZK8ITTpNx9zLG4hmbBTJ35ejon4ZPpM6Kqdfey9r+R1iXKSZUN8KNDZG7Ukn8E
	9mlXxE4wGjVAPvZ+J83Dbr3qF1YdBa1feEjaXITmZlhBT7ArZy1E8uOPI+MD++E41ZBiQYIYWlH
	hcXRjnYk6C+CMQCb2pNYDe49OYxuZOmVZmFmHo+5In23fjWjaUOuFQqbkWhFMLulN7gKDvg+j5F
	f4Hs=
X-Google-Smtp-Source: AGHT+IF8Qr+FTUAHVCBO47FpGf7RVTtjn3ROCfdsvVOnZ1bulIPyJralhDGveiuL0chC1TREh7utNA==
X-Received: by 2002:a05:6000:430d:b0:3a0:8712:5391 with SMTP id ffacd0b85a97d-3a1f643abf0mr3534448f8f.12.1746824860641;
        Fri, 09 May 2025 14:07:40 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc828f97asm21706045ad.193.2025.05.09.14.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 14:07:40 -0700 (PDT)
Message-ID: <27cb98b6-44a0-46ee-a44d-7affc0b5a2d7@suse.com>
Date: Sat, 10 May 2025 06:37:36 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix invalid data space release when truncating
 block in NOCOW mode
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <4cddde52bf9d965d7735f204d1403855dd9b8f74.1746808787.git.fdmanana@suse.com>
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
In-Reply-To: <4cddde52bf9d965d7735f204d1403855dd9b8f74.1746808787.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/10 02:35, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If when truncating a block we fail to reserve data space and then we
> proceed anyway because we can do a NOCOW write, if we later get an error
> when trying to get the folio from the inode's mapping, we end up releasing
> data space that we haven't reserved, screwing up the bytes_may_use counter
> from the data space_info, eventually resulting in an underflow when all
> other reservations done by other tasks are released, if any, or right away
> if there are no other reservations at the moment.
> 
> This is because when we get an error when trying to grab the block's folio
> we call btrfs_delalloc_release_space(), which releases metadata (which we
> have reserved) and data (which we haven't reserved).
> 
> Fix this by calling btrfs_delalloc_release_space() only if we did reserve
> data space, that is, if we aren't falling back to NOCOW, meaning the local
> variable @only_release_metadata has a false value, otherwise release only
> metadata by calling btrfs_delalloc_release_metadata().
> 
> Fixes: 6d4572a9d71d ("btrfs: allow btrfs_truncate_block() to fallback to nocow for data space reservation")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/inode.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index d518acb7b01d..8c1f7196636a 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4932,8 +4932,11 @@ int btrfs_truncate_block(struct btrfs_inode *inode, u64 offset, u64 start, u64 e
>   	folio = __filemap_get_folio(mapping, index,
>   				    FGP_LOCK | FGP_ACCESSED | FGP_CREAT, mask);
>   	if (IS_ERR(folio)) {
> -		btrfs_delalloc_release_space(inode, data_reserved, block_start,
> -					     blocksize, true);
> +		if (only_release_metadata)
> +			btrfs_delalloc_release_metadata(inode, blocksize, true);
> +		else
> +			btrfs_delalloc_release_space(inode, data_reserved,
> +						     block_start, blocksize, true);
>   		btrfs_delalloc_release_extents(inode, blocksize);
>   		ret = -ENOMEM;
>   		goto out;


