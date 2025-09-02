Return-Path: <linux-btrfs+bounces-16583-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6058B3F9FE
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 11:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B22A3BC33B
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Sep 2025 09:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A88226CF1;
	Tue,  2 Sep 2025 09:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g1axaa0a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34C81FC7C5
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Sep 2025 09:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756804562; cv=none; b=tA9aUzeTZgt6LDQcVEul/BnZxwrV0Bv3i2Z/9DYZb0vClua2F4tiTysxGvyi3RyUh9ISrQw8oE2rgW4hP5wuxkQqlt6jxyhQDrJEyaX0BVygxs81wAygQ0RsSAT+zusHmuxdi/Vs4fMAC8JJjnqC6rKPWQ7ykPG7TbwVrMMl55k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756804562; c=relaxed/simple;
	bh=Hh4sPL8pK+hEGfK/jSzYqQiqIql0WN6Tqa+Lwn6S4Cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JpBZdrK1IQCZrIe4Se1D8nE5Ym7VbKTrnE58JQiN2fWEh/OHMOoNamZkjrCGFObNQ70LedJL77kz9zPsO82Fi79ERdOshe8GpGWlMYRMXl9edgBXcGZI9SnnwYwz4lyn6Z3KPqtrUwaqeQVNzQwiEJg6eIevk6xzf2pZ1ibQ6t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=g1axaa0a; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3d2564399a5so946450f8f.1
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Sep 2025 02:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756804559; x=1757409359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Az4CqKPm3/N2yeOurfxgmPPW3TRV7OPlwm34iC5nAcw=;
        b=g1axaa0aWJGFI2w7XWZsTReA7IYhmHiCZ0WOomsMci27Vx84tL5Z1C2nJM10TbTkRI
         zUt5GqUPAHF/yHr/L+Ja8242jklLimt48tFGn/jUGO4wm0j0smESW9l8xhd1syurEiTg
         KzrblQ36YoIdzzsaHDr1hhZbZl6pOcvSapf53y/LmX8saAkHyHdd4uqmocKEorzUxTP9
         20fkXvaaEbYR1X/5SBxhtVI42HACn0Ze5jHztJjymaSHBpfkLANjY4hqCf2ZaYDnN6F2
         55o9rgKa3U30u9+Oeziz8BF7p6gWrW+pG8hdbAwWmDKTPbrQRcBBw6YrGXy6sC2fV4xK
         FMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756804559; x=1757409359;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Az4CqKPm3/N2yeOurfxgmPPW3TRV7OPlwm34iC5nAcw=;
        b=SwDGIs8mm6Roojcy8sJDjFRXUF/l8Zw8EcBb3YkRNI/eqw6veK3l3/Bw6yIP/Twtup
         FcBhUhHrV0VJec4fMSqMuduRopMBXQhfVt4R5ou900oLZUioNWcbB2apyd8s3LUO3am8
         FrzIoYXpR+rG59MQUTIlqCFJ7MqzrTMsKwrtv6ZiYHTT79A6sr7o8lZ18dh85AgvdfQP
         XtUBKx47iBQzAnu3QNDq1huJj8dafTI5zfhtHrEdWTRsjBy1Uq9toab7HNIcXJj4xELk
         IY7hHoi3MDyi6g6MTvZA98J7c8OMVb2uwW64diB0ZuSeYYfN5/oTzNW8XadsVFhbnk87
         UpWw==
X-Forwarded-Encrypted: i=1; AJvYcCW5ZrM6wCMdVIMNVB65ar1UaGMtQ095anJZge/xEB/9yuR7MBwYQndelO6tyLMRnjzZlknnMZVzODytAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIEPc+EC8c5SGgxtw2oSgz4rbEY4SInEVLbC9vzyc28gvSWKw+
	97DqWauhXNj+Gye/QU/7V+0vPTvvWtNEI4890bCBdhgHtXhYia3kyuFtdvMcA7Wcy4Z87ybnz9z
	BgCks
X-Gm-Gg: ASbGncvOn7iaTAR1wyHptAUp1cATRQkWpfYaf5eu+obOHvMDI1d8VnC0VUAdLSlU1KB
	2TDKfiTypToW9c6tMBj/Rhz9zowpF06570abZYjaAs5Qfaa7krkVBxQAql2rBVepMx7sQmb3xBI
	FTYGX5cdNn1vyJ28iR7GbnYNjq/S7viFDqUrVSntxmhoFKuQT9eTcTT/0YAeYG9t0JsPGlancZ7
	SF2lAn5T57f8v9dACb+FZCHur8Z/GxVcRTeRK88wzJqYMZYFHSt5fwqTZdXRU4R1iVpqUWc34qe
	PAkQybFWYEG3yzrEbvn3RwGjZ/NzB61hdvSnF8Uzwm3xedVzof9ZXNDYKKOrv5Qv6u9GJuszfmR
	WYcbSblu7RGMIEG0oZafDv802J0LhqUurHZBrDJCYXdEHOjsKu1VrOmLVwTANz4pv3s8Sb97h
X-Google-Smtp-Source: AGHT+IHi6yzkJXs04l2eXD5LxoR/Nj0s81gd/JcvL+olLtFG0JRinwD/cOvCI92FmBvmZbzClnNrTA==
X-Received: by 2002:a05:6000:2c07:b0:3da:bc9a:fa88 with SMTP id ffacd0b85a97d-3dabc9aff8bmr857021f8f.15.1756804559013;
        Tue, 02 Sep 2025 02:15:59 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77241f08a73sm9080982b3a.29.2025.09.02.02.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 02:15:58 -0700 (PDT)
Message-ID: <99046aa7-0737-4131-8790-2112d33a384f@suse.com>
Date: Tue, 2 Sep 2025 18:45:55 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] btrfs-progs: tests: add {,cond_}wait_for_nullbdevs
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <20250902042920.4039355-1-naohiro.aota@wdc.com>
 <20250902042920.4039355-3-naohiro.aota@wdc.com>
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
In-Reply-To: <20250902042920.4039355-3-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/2 13:59, Naohiro Aota 写道:
> It is a nullb version of {,cond_}wait_for_loopdevs. It waits for all the
> nullb devices are ready to use.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>   tests/common | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/tests/common b/tests/common
> index 2c90acb90cfc..1df37c390bf6 100644
> --- a/tests/common
> +++ b/tests/common
> @@ -984,6 +984,20 @@ cleanup_nullbdevs()
>   		name=$(basename "$dev")
>   		run_check $SUDO_HELPER "$nullb" rm "$name"
>   	done
> +	unset nullb_devs
> +}
> +
> +wait_for_nullbdevs()
> +{
> +	for dev in ${nullb_devs[@]}; do
> +		run_mayfail $SUDO_HELPER "$TOP/btrfs" device ready "$dev"
> +	done
> +}
> +
> +cond_wait_for_nullbdevs() {
> +	if [ -n "${nullb_devs[1]}" ]; then
> +		wait_for_nullbdevs
> +	fi

I guess we don't need cond_wait_for_nummbdevs()?

As if nullb_devs array is not defined/empty, the for loop inside 
wait_for_nullbdevs() will do nothing anyway.

Thanks,
Qu

>   }
>   
>   init_env()


