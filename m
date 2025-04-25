Return-Path: <linux-btrfs+bounces-13434-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 632FFA9D5AA
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Apr 2025 00:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2930B1BA7773
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 22:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9EE2957D0;
	Fri, 25 Apr 2025 22:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SuOvWvoS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2602951DD
	for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 22:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745620653; cv=none; b=U0ab6PMe2VCp6j0reZ2nCNqEkv3tfB70w0xoBQsilVjNzg1J5ua/5vQcUpg8bphI6jK71wu7FkuO6RQ+JmcQaTu+alcQH6CVoqZ75jEwkOrLenEw6ur2F/FZCCWbg2WD/hUVkmu3lIlP2jLC4/WJO/KbTCyMGkX6NR4Cu2cQQDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745620653; c=relaxed/simple;
	bh=lK5LvqP/U+WViVIucTLS7Wip6FCSfuMknMSIpgrFNFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=irCLzTsxuhX0nztZkVoL3iTloFarCB6ePbiaKZbk2NuJcGSUh/QoYSETNN7XyPtJEjUMJn4R3xfVXnDvXvCwOMSmDHQWP1A5+YSdov+L65EhnsHnS7vnGwR7Sf/21FEkYqSMnlSGSlgjJeD/Y8AYI7FjTqOySJIfwYvxlGpG2y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SuOvWvoS; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a07a7b517dso223365f8f.3
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Apr 2025 15:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745620648; x=1746225448; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QQ5T6pEoII4ZkddhDbhFjhHtDGKMBz+GRhsrG5TV7ak=;
        b=SuOvWvoSnSlFmXEEp4VJJ5AHxwgk4fqDX7l+QDTSOV99aor0WDwareNiEVYUncQXVa
         oEg1cKvKVxzzyw16nHbs4ShhrmDsOydLwNprGDUlUJPIsnG7arIFps/L0dCgyi5lhIu3
         LmczZETZ0GP1bxkZOpruT6MISCNcidN14h9PEC0jlOPSJpneY3qXtFi3y9i5QRmYWnxz
         d2WXXs9VQIinCVwT9nLksGAPv02IPNuqrszzHp4gQ1njQCIgfdD9gB7KWdOUFU+q/8FJ
         /3uM7OFEqrAJwdtBJJMHQmkFoM7oPDTlFHdxentIWNl7ESd+mCTwvCoyKOpfHyZT7Yp7
         wTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745620648; x=1746225448;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQ5T6pEoII4ZkddhDbhFjhHtDGKMBz+GRhsrG5TV7ak=;
        b=SJqnp/LUknh1f5SVHCrCX1+WHBpTbrvUq3osZIL2Hdw423R8cw+JriSRz+xVikY/af
         gAD5JNKUAuaLsGGHtCUydAnnhAX75BuyZHHeoJOLHS0vywklXfFmaGXHl6e3Fcj9NzAT
         1j1QO+sIUMHAq8SDz4oxfvja8N1GtVKw5zEFa/e83uOYg607lDcOMlgvVJHjEdPFIbD1
         fmr6bm1S5wwHci8yhFzlfPhu4QOmOFLBWoAAJ85N1+pHmfRBOcW+mlMuy/qkCFRDLv1Z
         IOHZjqZmYM8A+SynP+EgW0WCL8x2NT93dxmfawShZMOomONz+BNipy8QUIv4AOYJ517p
         b5Yw==
X-Forwarded-Encrypted: i=1; AJvYcCVjKrbaQc0WNkLW0D0bCUPww1bitAHNNyL/0L3znJT/hnlzmEoCyveOD23V3frUyk71Tp1UXTQ7UgTksA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEIcpexaobikLJ5CV+iELkEfXHXSyLXMdfUNxLP98eYwwDkprm
	aMEy1t2yYBh2mHUlGy/W2ihmLUad0t+T0+5nugGRELiKhZxW3C894c5VoARuZ7pqBnA7WiN4O+c
	F
X-Gm-Gg: ASbGncuT142CNioLfBIJQLKXJzP/X6iGbtQJWzOKJZx9S8quHOBZOusQcJzhYTt0UM6
	5CDqU8KYAVgzRjpMDOqqxutqliRwgSUUMyMDxigp0DTtI9+50YbPnpQEjzRdzLi/JpNEWsCGnHR
	itl3X9zE1R6YcjmanLmCQg8yDgN2dpvJTdyXIYBEnfS6ldHKSFOhlGBDFI8Do8WXjPkqEPym1rF
	JwhGZZXrBD+wr+INKhXBv2Nj3VEC6WKgSU2z1oYGmh1/jSbkjYtOqw3cZ56ZdW4TmNFHu8xSVWi
	juas2HlEZFgeozOIao9mPV39g8AzOn8lwbShABeePyMlOULsvcWFcgvtr8JTTpQLOMFA
X-Google-Smtp-Source: AGHT+IHDlOeRC2+6Gi9947WGFGSJijc/N8RWxl5jbhfvxf99J5MYoF+5iD7fONKPEgp7RpSVtfhVtg==
X-Received: by 2002:a05:6000:2509:b0:39f:28de:468 with SMTP id ffacd0b85a97d-3a074e3772emr2945300f8f.28.1745620648195;
        Fri, 25 Apr 2025 15:37:28 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db521b0c2sm37944285ad.247.2025.04.25.15.37.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 15:37:27 -0700 (PDT)
Message-ID: <e50b42c7-71a2-41b1-9923-d8599e545247@suse.com>
Date: Sat, 26 Apr 2025 08:07:23 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: handle empty eb->folios in num_extent_folios()
To: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <a17705cfccb9cb49d48c393fd0f46bdb4281b556.1745618308.git.boris@bur.io>
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
In-Reply-To: <a17705cfccb9cb49d48c393fd0f46bdb4281b556.1745618308.git.boris@bur.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/26 07:28, Boris Burkov 写道:
> num_extent_folios() unconditionally calls folio_order() on
> eb->folios[0]. If that is NULL this will be a segfault. It is reasonable
> for it to return 0 as the number of folios in the eb when the first
> entry is NULL, so do that instead.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu> ---
>   fs/btrfs/extent_io.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 9915fcb5db02..e8b92340b65a 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -292,6 +292,8 @@ static inline int __pure num_extent_pages(const struct extent_buffer *eb)
>    */
>   static inline int __pure num_extent_folios(const struct extent_buffer *eb)
>   {
> +	if (!eb->folios[0])
> +		return 0;
>   	if (folio_order(eb->folios[0]))
>   		return 1;
>   	return num_extent_pages(eb);


