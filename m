Return-Path: <linux-btrfs+bounces-16582-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E047B3F9E8
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 11:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7741A823D6
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 09:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1612EAD0B;
	Tue,  2 Sep 2025 09:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cRWadraE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FF92E9EC2
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Sep 2025 09:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756804293; cv=none; b=QtcGIAupo9focAxU/1Hm0N4ntZxXcMvGbvV6yeo7EBx5fxG6NYzMP+02nKSs1QHXLWNFmNPymoIo4Ytr9zxBEziDpvOJu5cmI1mqcEZmtXi+88hAxRqambSCHWkvISvvNnH34IBFHD1saDySuItrKy8HlDfeYGhbP3PXATzutyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756804293; c=relaxed/simple;
	bh=dJMPQ/btDwhLkRjTOS2+EK+QU2eHSCuZvXsBDjhySxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Jm46Uq4pcmV6AOXj2zZQHhoW9cVfki8hFzaaSA63eObEUQpRMAipjWNIENG97NiHZP+GQkesgnHQKSfMH6elLdx2tf+3nSBNTnw45GFDSLcuYIzKlVJ2/NueLi3nPCTL4dFrOUauKDg9KOv1Z3+df1F7dZCEQ1LnHkxAN+uEwWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cRWadraE; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45b8e28b3c5so10202995e9.1
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Sep 2025 02:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756804290; x=1757409090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iTITLUVwW4pLkIR4XfdabjVC7S9fKoKTHa/gB4o2Y/0=;
        b=cRWadraEfiq88XaFpIZvMsWnmJLsQUzbEk4dnAoApvtT6DRzSaETvDc0u9neyNgHSF
         jzKC+YuXwyJ1VOGDT+yTw9OC84G6LZV6Pfy9upNp8QawobW9i9Pwa2o1LBUaN53/jg1A
         RZvpu0yoRWGur99UiJBP7digb/F444dUXmT9ZtEpc6qiOQFwq7mDjhDxm1tsjJKbwxHY
         4jULhBDmB8szkLeFrl5nm9geML0PoRtpMZVhSnLFzGn3hW/tJ2T/pdyUBXPHBgoMAb6h
         6ThCCx1mn5o9qd5SVjU5aosdqPBaA2nDyXEShmCn0tEn7wi5X5eClxcXeHrW4OZmcPEG
         kJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756804290; x=1757409090;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iTITLUVwW4pLkIR4XfdabjVC7S9fKoKTHa/gB4o2Y/0=;
        b=LO1ltukR0BKYNlpmVkr1Kci8aZdnLhcWoBWTlMGRWci4oKNKIxEAV3pJ9oQpAtXzbC
         tWcCGMfVpY1UdAoyZBWgXJxydPoajvHZKThjWd1HweILy00pQPp9UOSt9lKxegvY3qk5
         li3E1NUDLdZGRFD/+7+cW+ngBn0Ba5AtgMOTPwLPgUKNQPleDBdxpczI7OQTAOKomyQ9
         77aCSAWnK2OUi93HL3MknV63avnmLi6eQRMv3YOvZRevBLckEpGAQOeV7vT76X4qGhis
         Cy2XbtsQSANeiPlaE5kqWhSQ/EUUqEsu0BxNhgfCo8wuyuFsDAIosECRpiqyCa6D7HeT
         FVug==
X-Forwarded-Encrypted: i=1; AJvYcCVL9iuLQIxrQJ2Qa3Vkf/gimTC4BEyxunS1gV8zjuv/5MPT3dKnpgfcgilPXAvdGbWpjuMEYlvXC5HMUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhJDW8SyLszPANh2al2FtcEMuiaT17IQ0l94WLlZHOpPOgPCa2
	/YEuCTjNzHJzBZICtAmlorMDE3EXawf1WSPnBSqvdYtTECsjGWIaMWa5nOi+ro76Wk5p63UO3bY
	j7UEJ
X-Gm-Gg: ASbGncsXtm3XvcNLFrV7Hz+9dnCod3qDALTjE7HcNKeB6/w3KonbINDwWopN/M64DEN
	D96cMA7e1f/DdXqgKjInh2Omckpf0KB1gToO+TB0+9fG6V3IpqXKaZ/vRNVa0JgSRd1UEIjnFVP
	8HskEXviNdCaxRJBB5oFkwmLJPsVgGD7fR9D+g5yQiM7WCBQleQ8vilSuDTRbGvrqsEa/44AvzJ
	4HPoUrD7Pqr4T8FXOlmhZa5eqo14eKzi08PRf0ohJG81Ne6kYmj0OpxK3DG64UHkLtIxny7iqo4
	EvAreBRGwSLjgIb7pwbRlPDaOEa8s4Xw5DuNIrjy1Bg0MLrGrODx4RmR1nSLul1vaieO3TOWllR
	LJ0+ueig9X21kDoO8ac5zVYO3oXp0mmzE850G5sJcFImNiSu5okN5MBC4jQWXwg==
X-Google-Smtp-Source: AGHT+IHcYnLA+pv6hvDKa1Nh+PKMk+Ttw51ndm9oof6GqEHb65u+kibcdq3GYLY45+rqK48D6FL9Cg==
X-Received: by 2002:a05:6000:2407:b0:3d8:3560:59f4 with SMTP id ffacd0b85a97d-3d835605e2dmr2886725f8f.15.1756804289565;
        Tue, 02 Sep 2025 02:11:29 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490f755ebdsm122336465ad.26.2025.09.02.02.11.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 02:11:29 -0700 (PDT)
Message-ID: <ace116f9-3395-4d40-a8a0-d22ad6756191@suse.com>
Date: Tue, 2 Sep 2025 18:41:25 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] btrfs-progs: tests: check nullb index for the error
 case
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <20250902042920.4039355-1-naohiro.aota@wdc.com>
 <20250902042920.4039355-2-naohiro.aota@wdc.com>
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
In-Reply-To: <20250902042920.4039355-2-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/2 13:59, Naohiro Aota 写道:
> "_find_free_index" can return "ERROR: ...". Check the return value for the
> case and fail the test.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   tests/nullb | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tests/nullb b/tests/nullb
> index 457ae0d8354a..bfc5640c4470 100755
> --- a/tests/nullb
> +++ b/tests/nullb
> @@ -146,6 +146,9 @@ fi
>   if [ "$CMD" = 'create' ]; then
>   	_check_setup
>   	index=$(_find_free_index)
> +	if [[ "$index" = ERROR* ]]; then
> +		_error "$index"
> +	fi

I think the bigger problem is that:

- _error() output into stdout instead of stderr

- the "exit 1" doesn't help in this case
   It will only kill the child bash, not the calling one.

So I'd prefer to make _error() to output the warning to stderr, so that 
index will be empty on error.

Thanks,
Qu

>   	name="nullb$index"
>   	# size in MB
>   	size=$(_parse_device_size "$@")


