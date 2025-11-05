Return-Path: <linux-btrfs+bounces-18726-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E06FC34C09
	for <lists+linux-btrfs@lfdr.de>; Wed, 05 Nov 2025 10:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 50EE44F8798
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Nov 2025 09:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957F82FB97B;
	Wed,  5 Nov 2025 09:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Tk5fXqtT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920572F90EA
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Nov 2025 09:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334074; cv=none; b=cg4PwYA/i5RHaczSNlMZfPf3QtqRApqxCfWpPYavru0SGYBE3UXq0DiCDnl6hrvk8CkhNYoU+TQPw/2DGAh1Lzxo37CyJ0j03NT+UE3KL/I7KHb26O6+wCzIVaMCZRhvwMj9/oNQuQAjqWMQPlWlR3oF4F9+FtYfKAJz+M4pNjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334074; c=relaxed/simple;
	bh=jKr1rGV4rgIjUCb1jumVH+bKGuwyxjg5hXXi6aiGi88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pSGGYqZTik8YtypIIKapmdRJoGsF8Vz6XeRH03aC7rvI8/1Xmx/CsHmpIq/APuz3HuXK/o68dSLWggl8dAkVHqBdGa3g6jqDJdpEYqib3FHKHV57KeJl9WQZmZ0sr/8WbT/3a1pT5Xte8VkSnriXTHVM6YDY215/tR0sUR0UKUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Tk5fXqtT; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-640a503fbe8so3806685a12.1
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Nov 2025 01:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762334071; x=1762938871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jeoEzzS+NATU1AiVy+MYjoyYjfzwHEiduVCED9EMil8=;
        b=Tk5fXqtTMfvhqo6PMaVXmzdMSqF4YQRRAUm3HCATCdyJIquDWkyil5KYq40TutFErv
         L/SV51Nb5XQn2zgoe7HViweLJAp8Hj7gwUvK5GFYwKwb18pdX+vLPHik4flcJTbOiRqr
         Jpc733kNLVF1JTD2MnqA3dXbHfILnkCUvX+6sm8WJ128PV0D6r4wTC2i2vkz4NUGEc4d
         56S7Y1DbWhAGdJaFlmMDi3ibsLmjECuZtwX2RpkmjG5oI6gWYQsNgTPVUH2JyNZR+He5
         fopJVsTn5CA5sMNuttu42VH5RDMOdcOhUyda7SMIhczgHto9oO54MCOR/mkdvwT8Jo/p
         ko0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762334071; x=1762938871;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeoEzzS+NATU1AiVy+MYjoyYjfzwHEiduVCED9EMil8=;
        b=iuHgxu9VoxBJNLucLf1sMoOrEJB/oIwmLUcqkRbu/zzaIolkrlWD6ecECy7+szmuCZ
         NaLetrEXnE3uHlAqFqBK6V9LQM50xfj6ohxRNK34Guq8o0ccmjrPKH6PHS1TmVoiJlls
         1Kj1puU1x8E9HA9OOwof1inioNbiJO9GlQSneLn82yr8MH3cYZXampJ8dUL87C0xDkDF
         /sjnskTpTe+t6julpww7I9fMI3/JfjJfIQ4C2tht2wS/kyxg9w2l53m/d/QlhTeJHsD4
         OBZgUQ3E2xVKZnNkB7MCwxyNT1CEwYQ1uBI2+9BGpEauQHvh+HQcemC7TKrpuco/Iroe
         vn+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZ94VdehiJPzGxFrQ4pC2bmxHqxM0mUDwN7ht5x5dZa4A8D4JEbIsC96ftrlQGHNuKfcVNygNBsz0Ygg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQpRDAgM16IUWH/HGbDk7zvoAg+3L0zPuDVTwW2YHiJWksyzeI
	kDAy4g6WSvp2xyLEjwcSzZV+tLS+Aggv2/Y93c9p56K0pg37gKdyOntL2xhs8Mt0u8I=
X-Gm-Gg: ASbGnctBL2B1K9MNxe3dqSPSPhhiMviiMhMWqlvWP1VY1/c2b6oeWjaINKzrGum/RjP
	ArPZZ21pNgZIFnxrS5l9QJXDO+X+1EGvnNHMi/PCxOt233joLq8d/E9qxTVydq7yhItFhVt6vOi
	gGGu8wiefFBWVGyraSeU3lhE4pN8wMDcx/VEZcZMVVyScHNjwkz7JK8xEXPKishV9BUU9Yzgh+j
	Q8Lk5TpbnZ5E8Tbxv6Fi7qV0xQoApPGa3dp/RKaCG/HVTfAeM4E2zripXN0ltaP8on11yokqYAv
	6oPgs/m8yA0Emzxc+Ual0gMQx7tx6YegPlR+HRloFGJ/mVd6+XKe7UjXRxs5QNHPocVVY5zVeZC
	eoiy1mGLVrlIEsYm+WcwQ6hIKzu0eJAesToCXUByQWnFiDqhlGn/5kHirtw6HScBRZ2cFm+iIPV
	m5P6DsaalJp2d9ZsMdiEUP7Yagpt/K
X-Google-Smtp-Source: AGHT+IGPSpGbGi5CTwXbJ9njpmQ6nj0G/4Pf35m44cY/AqKJokN1oC23P9uAmuDjc7gnyRJnKlHQug==
X-Received: by 2002:a17:907:720e:b0:b65:dafc:cd0a with SMTP id a640c23a62f3a-b72655cde5amr209742766b.52.1762334070811;
        Wed, 05 Nov 2025 01:14:30 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::e9d? (2403-580d-fda1--e9d.ip6.aussiebb.net. [2403:580d:fda1::e9d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a69d91sm53105955ad.95.2025.11.05.01.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 01:14:30 -0800 (PST)
Message-ID: <a794be48-90a3-4a6b-8cf5-d063f52fdd2f@suse.com>
Date: Wed, 5 Nov 2025 19:44:25 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix memory leak in
 data_reloc_print_warning_inode()
To: Zilin Guan <zilin@seu.edu.cn>, clm@fb.com
Cc: dsterba@suse.com, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
References: <20251105023722.1820102-1-zilin@seu.edu.cn>
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
In-Reply-To: <20251105023722.1820102-1-zilin@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/5 13:07, Zilin Guan 写道:
> data_reloc_print_warning_inode() calls btrfs_get_fs_root() to obtain
> local_root, but fails to release its reference when paths_from_inode()
> returns an error. This causes a potential memory leak.
> 
> Add a missing btrfs_put_root() call in the error path to properly
> decrease the reference count of local_root.
> 
> Fixes: b9a9a85059cde ("btrfs: output affected files when relocation fails")
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Now merged into for-next branch.

Thanks,
Qu

> ---
>   fs/btrfs/inode.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 3df5f36185a0..6282911e536f 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -177,8 +177,10 @@ static int data_reloc_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
>   		return ret;
>   	}
>   	ret = paths_from_inode(inum, ipath);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		btrfs_put_root(local_root);
>   		goto err;
> +	}
>   
>   	/*
>   	 * We deliberately ignore the bit ipath might have been too small to


