Return-Path: <linux-btrfs+bounces-16778-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A51B50D18
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Sep 2025 07:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EB844E2FD5
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Sep 2025 05:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7658E272E66;
	Wed, 10 Sep 2025 05:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RDH28Gct"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE54D31D39F
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Sep 2025 05:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757481778; cv=none; b=jti9xPMIxWrC8av4M7rrrLxL7DOOXWo7z2Tcq5Zg8TQFShdE2dk4EEMGrWaMVneTfK+i8cMP3i2606QyIT65htRwyx60hh+emX5alDPhdnBCk9ocdrzNFNPEDqF34efTYhwEU9D2o9+bnk3D8RYh+TJdINFYTBL1NcNmdr4lS5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757481778; c=relaxed/simple;
	bh=ibrWQvLzG9NEjZiy3WtX2yXFn0aZc3MRpxlQZuHT3NY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nxXIvbn/f4rsPamF3xMOTAp3ZGi7SZVhCctI2hI1iEMrtQiaRyrc1/eZQrn4hMvNkVp9P80Ia+cQCxIq+Oyjukf1Lva/VADCj1oXLTudaVUn691psJOe4+Z+cxihofhrGpCgyA8X8kKq6EYzXt7N0hQRYaISQiw/jWqjBANdzwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RDH28Gct; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3dce6eed889so4864226f8f.0
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Sep 2025 22:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757481775; x=1758086575; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6YvCqwssfuSYji0VFQTSU/UflgX2czXuUkBnHwiu8r0=;
        b=RDH28Gct/QRB53vPgt8IF9j4xwusuDKKHPzZnIjJdifoyFXTv6STdyvfgHdS9G0G/6
         hGAAyQ0KvQpQBhlzjZYLAJD9XF0ZuNIbtOfZH1Hxt8Yx2r9a5k7cj8UmLCjE7PJJaOt9
         H85grPuzLWGLCZczjQvOUhXrvbi/EU7ByvxWtIR/0IzIr1qQNPDfqguzrnH9mpW6G7Jq
         1mFV9qSqg4Sxib/HeHPQ0CgSHhPja+bwa6bJ720Enjhy5GwQNhtAmsVdJkZuUx3+LdeZ
         lViAfDKHPJ1neGRA8qjvTIttMTsNAYiXy/Ces5IiB7jWihDlojYv8ZMb2Yl07FHqF5Cn
         3FIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757481775; x=1758086575;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6YvCqwssfuSYji0VFQTSU/UflgX2czXuUkBnHwiu8r0=;
        b=w+5ZuUgzqVVdL/EbsAE1whrt706ZLI4za8sQlpIDTpYaXqu5w00ezN07mr8cozJG/f
         RqkTp2pj94hUaB2dRqDWTh8W/1wkQItv5YkPk8ulRoh1FxPE/kZbsrF65yn69vwbl/qm
         0+38H7HmCpOEU8SZy9+8aq+aLWnnyqpo9D4PgAnkfENZBq2FBzwzfUfltlkMWtHawRg3
         nYDIOVtzkkHiPaIeSRuV/d5i09ZcMXvvshmlgjQQ6sdBbWFHkPjaDdFJNWUA3yeu5WvY
         1JC/jN8uJa/UCPMAS4etAfHe4Q5RWtC1pWMZs7rq4H3x1DdTogjuGEIsWlgl29B/i1tu
         poOw==
X-Forwarded-Encrypted: i=1; AJvYcCUi98deKdOpzO9ks4yslys6uuYR85ODGao/7h85pRy5P5ZQXFhPpM7D+KoNGLT4tfJhkrR1eoY4G70dgA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc+E1BK/psbq4Ftvbr+9HlY9vv+Xr8GxB6iAIVjc+PXSECxpz7
	ScsQ9O2rLciUBVUdpqoEXypZd+uc/k0r1N9k7HfJ8LsCFgsTqnRN9P64IwV9g6g8v6A=
X-Gm-Gg: ASbGncvKDV+jmytVSMvWwVit/dKbSfz0ADiFIDdReJ6CJN3J6WTyIe0yHPT32sC7/0f
	tubnMz+V5yfUGbZuAg478u6rblpxXrQ4fBuAKdxjO2DuL6kZHBwJt3BXTbyQcMP4erNjV1UHzMb
	xyrEGgu8W/3JPMYRoHb4aWN/B93764IweGzERig+alnVL/riZeRgkM0+1nQzXWvCZmdVH52ZaSc
	3yZO/xRiyMfo3nqPJJnFG6hf4l9eTadey5nM/hwIq7BljlfbHJi5otEdKWpJvzzTlvGHebf2Ya8
	TVeHphKK8RhzlwrqDL/8pRmzkKAmiTZQdjAF3spk/U5F5qBwC2UVTRNbM7hj7/JG7gs/e6Diqqv
	o0EhmFWQlLi7Is0SqPU0jAhKRQjumZlp8tQLppGWa6eYYzX7C2uh0gUg/PRa12A==
X-Google-Smtp-Source: AGHT+IE7dE+OZSxSyB6CoixYMrsTA5ORO9dT+HfN/ndSHkTFf9B8fgLQc9GZI6LaInR3vZps0tqKrg==
X-Received: by 2002:a05:6000:2c0c:b0:3e7:46bf:f89d with SMTP id ffacd0b85a97d-3e746bffe2dmr9555144f8f.44.1757481775147;
        Tue, 09 Sep 2025 22:22:55 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dbb00f880sm1046391a91.0.2025.09.09.22.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 22:22:54 -0700 (PDT)
Message-ID: <5ca0a200-8a17-49ce-8864-e28959ed308e@suse.com>
Date: Wed, 10 Sep 2025 14:52:51 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] btrfs-progs: tests: add wait_for_nullbdevs
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <20250910050412.2138579-1-naohiro.aota@wdc.com>
 <20250910050412.2138579-4-naohiro.aota@wdc.com>
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
In-Reply-To: <20250910050412.2138579-4-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/10 14:34, Naohiro Aota 写道:
> It is a nullb version of wait_for_loopdevs. It waits for all the nullb
> devices are ready to use.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu


> ---
>   tests/common | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/tests/common b/tests/common
> index 2c90acb90cfc..42733c215f96 100644
> --- a/tests/common
> +++ b/tests/common
> @@ -984,6 +984,14 @@ cleanup_nullbdevs()
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
>   }
>   
>   init_env()


