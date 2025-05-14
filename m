Return-Path: <linux-btrfs+bounces-14021-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC92AB777D
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 23:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5875817AD7F
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 21:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD9722156A;
	Wed, 14 May 2025 21:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VEEGKy7L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCE04315E
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 21:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747256498; cv=none; b=PHVehVBD6VwJqg/XnNqYHMXvBl2qgMGZFdDBKubPJBpIGkG4tJzlqlgQjy8xD7gV91ZvUVjuIFMxJLGx+3cO1R3o0BaLjeyfF/jjHROrR5vmmerehOinDILmpVVf+bWctogwEwuFKGNQB0qyBtCs+OEL4/xviPr9UNH6i4qEXO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747256498; c=relaxed/simple;
	bh=MNR5k7WwgZRlT1lEemHnon/7qMwUqQZc6T4B/hoaUDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=j5tNJKTxvVU9xoln3PI5KjGBaA8sRZFRp2FLp4+xRN2VSSCZLcWceQ5pWrN7FL87bcGdR3xxJLNG+FJXRLuByxvYPaYftckwEKjWvd69CzBmgl/cN9mAvjmkx35pgrm/uraUOzk80gEQgqPVapcLOzEHzmUtAIcMYqgX9OLAbFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VEEGKy7L; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a0be321968so111200f8f.2
        for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 14:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747256495; x=1747861295; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BQjfUFfLguXWUL0Lbgi2gmV1vBJyDPFKlIUnAaLDRTk=;
        b=VEEGKy7LEH8qGTbXTXZlkcYzX3dtYNiDJziObVjLKVvp7O++emS18sSypbpnIZMj+4
         dtRhNc0jKBJGhWuJqN0iKpgPBvq7HB8K3+oNRW5TyNbiPWxtkytzbwIJN5zXNSc0aldn
         L5iLR7uqU7Vrxpq2w5tqOYxXK3pru5uE/PNqJNXFaDvxI0Z7y8XZqM8b1sDwqh5/MIRE
         WjCrDfEbBlOqkJHsp0W3bkuwuuNdcVZixHGLEgGlILqN12isoRLY5NUw92A60Wr1Fol6
         A7pC/2gpO4XccNe34C1b4DySFQczkklIsX5kn5QcUqLBWdhozceeFl9MHUCs/YPR/CIY
         7nOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747256495; x=1747861295;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BQjfUFfLguXWUL0Lbgi2gmV1vBJyDPFKlIUnAaLDRTk=;
        b=lYb7KTlUPvq1uVM/PPlA9lFPO0J4VJR13zfelxYbU2bV84CYCl+KORwkZnYQZjBAFf
         qH4Kl4sweVT6f69V4CiJcklGZdC00YY3h4RCpGUJ2aJgBFORYqYiwXnbUa94Eb1YA5ip
         q9GrJtLyKWbSChXW8KWAMlCuAcr5uaujnm4LbFBgU9DY/NnWHKQivhh/YdVM/+Ap/uhO
         jMCRkre2yo9gjGYKmAizpXKjFaOyslisZTePJ/K0LJm2WyBV0N/fzX9jxaudZHEWZlXm
         7zVyTTW9C6iSoKelOJ6NeSRtpiqXn7k//7enDzXv7J3Xd2+tJDngWWIKEbqWxGVw8chg
         gYBg==
X-Forwarded-Encrypted: i=1; AJvYcCXwG4oeds0bpGsTv+VTcu1L2BZGnqDq4DDKl4SykB+sJgsfWLnGdRdHGFL1M/vAAKb7b8GzOR2jZmRgzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKSpXqBEO4Cqdph4jK1aVL+CpQgm0q8x8SlBzn9y0fVTXRBfOx
	G/SS9SQlX4VeFoOqC6R52GPQOVCpzQKhclW8FwkBJtFu8Sh33TGaq2ccgHUSaiigbdGIZ42Wd3S
	l
X-Gm-Gg: ASbGncs1B3oysVlkZ6pWL/n4QxOxo0P2SSsxnNluhieTULKS1jvIHjlZmhzDzHYfpz+
	gczXEM18CkPs3SNCIerwE7U2pV/o+1U5fZrP8vHmSJlqpF/WBkqDDdXLDNZMWUZ8D75MMuM36Vw
	v+3kj0f6lLpyP8JjDG2bKyY700QErO6qaouKaEYgWBnuv9/WIRaaoDD6NjoLgYTJ5JpOPvMu1Sw
	R258nDRfXIfnqq2VIM+l4hD4lB5bWymZHXkWAm6Qun6Xo10chvfhRCshGCAfl5bpPJrUJ3oUCom
	TNO9IGVlGOzr7GIJSepDUxvmM32weztWJ5BZfqJNaBJm+U5CZPiQDPXwIzp3rP7oONSOEEiuOCU
	UOBrHLQPiT0Aiuw==
X-Google-Smtp-Source: AGHT+IGVXq5HWpqQ3vXkSja0kZsH5irQmie1XJFKG8i6xitL2MqVVBYSOiNAVBgg9CWFZAlr3mPW7Q==
X-Received: by 2002:a05:6000:430d:b0:3a0:b9a8:b94c with SMTP id ffacd0b85a97d-3a34994c044mr3898748f8f.50.1747256494682;
        Wed, 14 May 2025 14:01:34 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a40589sm10298453b3a.145.2025.05.14.14.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 14:01:33 -0700 (PDT)
Message-ID: <0eca5d5d-0c41-434a-9784-c53ba10d7fbc@suse.com>
Date: Thu, 15 May 2025 06:31:29 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] btrfs: don't return VM_FAULT_SIGBUS on failure to
 set delalloc for mmap write
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1747222631.git.fdmanana@suse.com>
 <1d26d64ba145f0bd53608c40c0fcd90d0f92b41d.1747222631.git.fdmanana@suse.com>
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
In-Reply-To: <1d26d64ba145f0bd53608c40c0fcd90d0f92b41d.1747222631.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/14 21:08, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If the call to btrfs_set_extent_delalloc() fails we are always returning
> VM_FAULT_SIGBUS, which is odd since the error means "bad access" and the
> most likely cause for btrfs_set_extent_delalloc() is -ENOMEM, which should
> be translated to VM_FAULT_OOM.
> 
> Instead of returning VM_FAULT_SIGBUS return vmf_error(ret2), which gives
> us a more appropriate return value, and we use that everywhere else too.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/file.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 9ecb9f3bd057..f6b32f24185c 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1937,7 +1937,7 @@ static vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf)
>   					&cached_state);
>   	if (ret2) {
>   		btrfs_unlock_extent(io_tree, page_start, page_end, &cached_state);
> -		ret = VM_FAULT_SIGBUS;
> +		ret = vmf_error(ret2);
>   		goto out_unlock;
>   	}
>   


