Return-Path: <linux-btrfs+bounces-16777-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95677B50D17
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Sep 2025 07:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A7FC4E6130
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Sep 2025 05:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92412272E66;
	Wed, 10 Sep 2025 05:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VMcjUtcs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D077C31D39F
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Sep 2025 05:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757481762; cv=none; b=h5bMSI+BA6TGc+K7ORMz0wJrS2PKK1EITuxyL3Rap0XF0nT69U9E9ReCIjVJW/itNryTuuI8OT3uQme83DfZ6kmfDaN2x+Rdw663xPsL1hDlydMRRwz/RwTQkiYg9nNQ97qm7kt9S0+xnTCIr6kSq66tlZ4RVBtlApBiywXqAfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757481762; c=relaxed/simple;
	bh=wxTzl6eGcPzIT4UBvYP5pJX4E67nml6u87NFWzD/2Wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TEt+BvL5nnOqL4fuDhIgGtM0V7q6zfIlc/v7aJIYsqzdd4FxDOP1dwFR0RQeU3fU0CuO3pNMOB5VHv0dSl/Na3cPTgyLzL5RS+cQWBQtRF+ZdXMIMAwhhxknE9kw5HzITl3t+dIav8SzHISLy8vJspWa1fm3sCCxB5ZauuIFkyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VMcjUtcs; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45dda7d87faso33589495e9.2
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Sep 2025 22:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757481759; x=1758086559; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VYnKXK/NSNdkMOxpFovWSyEwDtSlAtwenaZtHCAYb9c=;
        b=VMcjUtcsCMOGOV6QL5ZjYyIPXUkTfk080uqBOI4gA64isgcqSOoB2Xz8i6CYvQSWiY
         lD5HRbrXDjcsy3E+hs7vCX4ghSvsHuRePZQT2f3JRGo3pADQD8Ru1OrSMPe8iZayRWrK
         Sbt8u9NSCMsWrDmg93WEyzhNl8Lo1nXpDtOjHjGRt6jsa0lgTMrs+xzBw/JYeHJWdp2a
         9Tknd5ToiaB3HgqqacvUxThlL4RQrT3zfka9HlVAnRPH0diJ8zXIIZlBojLQaMr6V4yl
         gAtWxIoiXMHzG3UBzQ7zoB9Gh+SSi/jGfNbq/P6lBdWlK0vfKLap5Mo7lab2+8SMaoEg
         V3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757481759; x=1758086559;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VYnKXK/NSNdkMOxpFovWSyEwDtSlAtwenaZtHCAYb9c=;
        b=vOlUb3qp8FvQc8myDmPJuh37vhs/rMHDmqYcwWcGBQV35b/gArSDP9K9muuATh/A+m
         mdQK7X99SfmWygUNny8CZIDc1Lxow1/80gTWguHHQ/nh7tJN35VFh9a0pgVV/WnQ2pR8
         /fHpW61Fy+os7jnJ98XzLAojCZltZMp8iLWxJE5Ft9YMG7IItWJSdbidkSQg8DRhbfdx
         gq3m+S/kbEUyQ3zxh0YWWi1SzKOzoa0z23ZNEvG7BCGcVlo7MgbXNzvgAPFPQlbQDiVr
         drbMQMq9CocR3+oLs322XUlgN/o6DTV5aGbQmw35Mzttrsv7Gg2aG7kbH+im3ARBe0sW
         oT+A==
X-Forwarded-Encrypted: i=1; AJvYcCW27DqFSbwk6wL7kb8k8TiPtRl7fcdWI1fFElDQOaB8okUg/0DyNw1JC5J3g9BvPqAiDAMEgPRkepAfMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzaCKgxuV6quKSY7TKZ3pXA3ZltN1ulvxIEC9gy6fQTT/vtIu3N
	7Sed7MiRDPTfqFHSpdz/LCK6pyWyBcQUE+YZbB5Z1sm6M9NgPR9e4LnUy7Ih7fp1Fgo=
X-Gm-Gg: ASbGncs0mC3vmLOH17Sbx1kFpfxPPGtP6vNfDlm5yS6LqTipVcMT8woqn+q/m3rcMbR
	9G+qRNhjZ2NttYVT954atEScZFRSfzGLuQYrB9gkGoV3AVMdIE+/y4H9R4+QPMj3+5BeOwiejo6
	lrgE+dITpI4K5QdLMa5x8W9PS6yyLW7g/pW79dIcYEzXaBX8daVEMdYOFLWNGMgivYjxKVf1SIr
	0DYw+JJNFkGueSXdaRfw46F4i76z3zCVKVpI9akXDATbKolkdDb0slCz1kd4/E7UK2NkAIlMF68
	FIgRhvwC/1G/KhDMmjygXRLy54ulkzd4+LlzNVxRUivnGerB/R5Js34o+h2baHfxG8iD/u0zOqD
	qSx484mYhCZu4NKTLQVCO55EyfrnEL6yi2jvfzE9rj1azSXUI5XE1n00FLFmSpg==
X-Google-Smtp-Source: AGHT+IFMQ/o5s/SdF7aXrtG9Jelw5lTu8H0Nedd+hmc5G+pJGf6jAxqfIFjlvPXJsUfAgx4ID5m7Fw==
X-Received: by 2002:a05:6000:288c:b0:3d4:2f8c:1d41 with SMTP id ffacd0b85a97d-3e6429ce523mr10867483f8f.20.1757481758994;
        Tue, 09 Sep 2025 22:22:38 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dbb60fc17sm1018104a91.24.2025.09.09.22.22.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 22:22:38 -0700 (PDT)
Message-ID: <c54170d0-d3c7-4753-96c2-3ed4b497ab36@suse.com>
Date: Wed, 10 Sep 2025 14:52:35 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] btrfs-progs: tests: check nullb index for the
 error case
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <20250910050412.2138579-1-naohiro.aota@wdc.com>
 <20250910050412.2138579-3-naohiro.aota@wdc.com>
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
In-Reply-To: <20250910050412.2138579-3-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/10 14:34, Naohiro Aota 写道:
> "_find_free_index" can return "" when an error occur. Check the return
> value for the case and fail the test.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   tests/nullb | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tests/nullb b/tests/nullb
> index f3cdf9c19e16..721da8f13f12 100755
> --- a/tests/nullb
> +++ b/tests/nullb
> @@ -146,6 +146,9 @@ fi
>   if [ "$CMD" = 'create' ]; then
>   	_check_setup
>   	index=$(_find_free_index)
> +	if [ -z "$index" ]; then
> +		exit 1
> +	fi
>   	name="nullb$index"
>   	# size in MB
>   	size=$(_parse_device_size "$@")


