Return-Path: <linux-btrfs+bounces-12205-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FF1A5D16D
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 22:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F643A9D80
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Mar 2025 21:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5617264627;
	Tue, 11 Mar 2025 21:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KNjysnci"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8459F1C6FFD
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 21:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741727418; cv=none; b=SJK/cCH5hepWEn04OziR/jUookGVDQl1ULyDgZckW6fWWN6PDeR5LL+KbQCx64rV18CJFcNOz6LEjSTOp+YFevFbOu+zsFECNpYn3UQTs29LW0U5pI3R5wOoUC8azoH3ZQo01yHyP16KXYRlOGfCDtNvo1mcgcG/M6rmPHC9kzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741727418; c=relaxed/simple;
	bh=p3IxjYCTWsemV2UzeibwwafRLthU3bNKzXfaRx1moqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=POGhK+mf2Yan8aqdXLT+f5MkmM9fym19M6ydb14SogL3AartLPSpYLXn8xq6idhoEgE+G0ojwsg1EhggDZY1uKAp/dfEMT4YHYTTvtdWWWGaMDmc6Hh5xs1WcqMY5HquaY70pAIBjGg3Flk0UWgQcT+Ha1E8egezWYvebPSGZi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KNjysnci; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38a25d4b9d4so3264495f8f.0
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Mar 2025 14:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741727414; x=1742332214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4unZ7cc9dRHteWF8hVw7Q+oARm/zby+T58yQYyRsTdk=;
        b=KNjysncitBJEcvz439GNYIGStJK65b01AkXjvWnn6hO0NFkHQ3jlVxyYrQ7ChhAQyw
         gSQ5h85LmtQY9PHy3D69JygEzp28uu4Yl3kjE9fsXT2TJgFl4M3rSACr6eZgZ/Fqzmqq
         AnpgrgugctgkS5JpNC4OIroAf4sV2VXU9vzL7MbpjPTVJl/O+Vt/4gNtgDZ+Tf6L1/hs
         MNWQ7Yp9GLmDjP5JSu7v/QiMQpxxbSzxfhkbVgEBl/P5iAZlw0nXAFS8Ey8KW8I0fSYz
         KFdU9FT3CN3p+VP2QG+ZjHjHhM7mLB4+DSLGtUiKKuMhQrVbracYOSG4DDcE0Kkxe6NQ
         Hlzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741727414; x=1742332214;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4unZ7cc9dRHteWF8hVw7Q+oARm/zby+T58yQYyRsTdk=;
        b=rSNHpVlbj4RFyYpubAEUeCG4Y59oyAC4ap4zK5ZQy5HwidcZeam1JqbkyApZnNWijU
         whgGbl5Sr5rW5VlBKDGEEiMrWU3QRjeo4JIll0kj3h7W0UjrDKUtK4/fpJviRIDbub7T
         IjSRcpUmGlpyGPYiHyGhyxAt1bOKn6eqbiMNPRzU0S5GMJvsxmg8/8dJ76/2jdJXC4NT
         P/M3GRCsLCGFqS280W1m3broNiALgs7mvGvAG2pTfoUaWnQuUGfqZ3Kc3+nbr5V2nnl0
         llJYvFiPOdK7huVqAKul9uP4ra6ThZ3YphA5AzQUP776/mHMk7IX4A3vmSYOKqSvHssJ
         5txw==
X-Forwarded-Encrypted: i=1; AJvYcCUUntMjfRBiMSTiygFTDBBvVxzSRAqTCYOBixF3cKWckwd/sFP6jHkUzUrJ6+xm7B9zZVtbfLW4AvP8rA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwitkTvR+1nLgLVHQps4Fs7tfbWrcldYGo1wKIe425gWXZ/508J
	jNSGVPsVIgci0YdDzmRt3+El6WS16SJpI2QKG6gc9nMzmEoRjhdk+xbUJLxq2pU=
X-Gm-Gg: ASbGncu19hvJKLpedre2rM20o2yMwaN1dCsQNFzlMTwg2y6ClZ91TIjVoVMvGUnGiVt
	YDNhaa+yUHByao44QUBVjJnfgCZvYl/+EFB7DvJ4f2b2MgpxYUtiA7U7MbFVGs8DcJCr2IXpOlE
	nfPiDesB6DrNTXxA07HBBk4gChYBpyeRNVPUHcHr0pkD0wkv+ODV+YyO7/90YJU2Y22A4u1W29I
	u7MjjblKVRG5PBK+foMIlmnALYzVS3SNYufFFU1t7n3usDAFUtGIekVByX1RyCmMIqZvKbuPEji
	aGbJZsyrrnmqrsSiZ+2ojGVyzOaIvpDixUVlg9C6uUcgTyUJ9qwjma/UZubu3of/wVeNjfTy
X-Google-Smtp-Source: AGHT+IFXhG8YKHRoKqHbgQXfvkMDgWgod1Z1EbJkgzex29dYJBcpgJmHWXROFVPeFMqJV63YVIm6fA==
X-Received: by 2002:a5d:47c1:0:b0:390:fe8b:f442 with SMTP id ffacd0b85a97d-39132dc35b2mr15074901f8f.54.1741727413451;
        Tue, 11 Mar 2025 14:10:13 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736cedc3c0fsm5545173b3a.47.2025.03.11.14.10.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 14:10:12 -0700 (PDT)
Message-ID: <92a9f026-d195-43fd-aade-029f12f4fca8@suse.com>
Date: Wed, 12 Mar 2025 07:40:09 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: don't clobber ret in btrfs_validate_super()
To: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org
References: <20250311163931.1021554-1-maharmstone@fb.com>
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
In-Reply-To: <20250311163931.1021554-1-maharmstone@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/12 03:09, Mark Harmstone 写道:
> Commit 2a9bb78cfd36 introduces a call to validate_sys_chunk_array() in
> btrfs_validate_super(), which clobbers the value of ret set earlier.
> This has the effect of negating the validity checks done earlier, making
> it so btrfs could potentially try to mount invalid filesystems.
> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> Cc: Qu Wenruo <wqu@suse.com>
> Fixes: 2a9bb78cfd36 ("btrfs: validate system chunk array at btrfs_validate_super()")

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks for catching this.

Although I agree with Filipe that it's better to return the error 
immediately in the future.

Yes, currently it will report all the errors, but if the first check 
against magic number fails, the super block can just be garbage and all 
the remaining checks will be triggered.

Other than a single "no valid fs found" message, we got all kinds of 
errors, which is not that easy for end users to understand.

Thanks,
Qu

> ---
>   fs/btrfs/disk-io.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 0afd3c0f2fab..4421c946a53c 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2562,6 +2562,9 @@ int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
>   		ret = -EINVAL;
>   	}
>   
> +	if (ret)
> +		return ret;
> +
>   	ret = validate_sys_chunk_array(fs_info, sb);
>   
>   	/*


