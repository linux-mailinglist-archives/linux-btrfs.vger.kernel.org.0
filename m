Return-Path: <linux-btrfs+bounces-16776-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9465EB50D16
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Sep 2025 07:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D6401B2767B
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Sep 2025 05:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2063272E66;
	Wed, 10 Sep 2025 05:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FB8nuZ+P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C2F31D39F
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Sep 2025 05:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757481748; cv=none; b=Byv89eUjaEJqiJPXH5D93lEy+U/xnfIoZKIWHkylpFytZbXh2pUBh57WIMoSq9czKuMEmXlB/meTfZdQe0tySbzBzgsHnP+ydb5pvsCD/ICGrmn6rahAYdeyuojIg77Ud3pZduqXW6z+nJMleYVyCvO7oHomVxE68aBO81E9PlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757481748; c=relaxed/simple;
	bh=XlGcg+EG57n+WF6l0CTb+diyunU8Lsn4DqtSb0bb7XE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uScQdq92P+byVdnGwl5W64th17CC7AblGPlB9SfX+8gmvqfF8EtsN4iSgnXf/Mkf+rAWS45k5qCJEvltP3Yo/jjfetotDpWQUgkgV8TXVB03bjNKW3NLHMT+AgIIMobuwUCcUzxaTHaoQEMwkg5uZ2NBuLwU5yvl+NF9CArA8vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FB8nuZ+P; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3e537dc30f7so2314392f8f.2
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Sep 2025 22:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757481745; x=1758086545; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qJn/oFsRrXfAStUR1SwGFKMUmem55dEjn6Z85CMzkXU=;
        b=FB8nuZ+PBSKVyEgzTddwiGDMnTQ3syVS4VcEZxaP4ePMxLaHSy2m0Rvj2EtG4mvCBk
         DVHMZlTj5nk1kO4v4cJjWDexbnUAI90PElelh09Q/LEQxlfgv2kqW0U6z0Si8jo6T/Pe
         Xt4ZpnZGynp7oU9M2PxuJJTA6Y2PPgJD4y0HHllWpMjXRsFk1oXB9eDbuU+/gCDWyv4m
         xMrg8Pc5SMwaH2c20jN6w0PxyfdQV9yFC7voD8fKb0MRbUHB4+xuumYPzMoPJIRnnSvN
         cPqcE/Q6fYlFrMIcmGDTkhm0HciYWyBmeWpyRpBWsYhnJbD/Xf4ctcKOP7//OkvsyQgj
         ePdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757481745; x=1758086545;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qJn/oFsRrXfAStUR1SwGFKMUmem55dEjn6Z85CMzkXU=;
        b=X1YQXvTnQRWlmamOf6X1dTvHMMniel/qIz5W2NpUuJD+5tm/UY6/0OuJAe3B/f1B3d
         t5QqWo1AuFqRD8eEX7njMj/p8cvL3XDSfN+PkeNnJ+poTh2wr+uuslwYN2pl5+FP/4UO
         YdX5fXQ++kMPW3nGFT5g9U0ShFXv2xxeQ1nxl7VsBaA1Av4I2dV2p8UugZJ7A1yQWht8
         LEtBsNyhMv8qk2ZPhtu5gee5Ewgil2V4AOkzCSsTUyiC6EgMKASYMQDYw9sekJ9cyE7y
         gzIcK4nX5s1VxGMMz/oWoIgLDKQwJjCr6aFvSRhLBHcY/s3cqU0xCZK4Sn4NimeIgmiQ
         MeAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1c0eCHi2MVFQ7gPXRoHXmosmbmBvVf0xAqUOxpYm/dHA9uZP77M3KoSiEbfbaNdzLAmj74Kv7Hu+Utw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyBXQoRwctFBhah55JFl/tKE47+IN0iU5s+KbAG057I3JwZFGw
	FfWFxvD+PP/k4lA3dYw+3u7oOHU3cDv99EYqqoysF7w23Ojg47BlxZ0hwBNPH6tux6I=
X-Gm-Gg: ASbGncudzJJncze1ns1xtyz1qYgVRy/thxKK/Xa1HTWYrBAynRnscAFNanrHAkdnTBz
	nho0AgXxe0VS20HR6YfOD4NSYLRLkamHMgcrDxhBFcd2gOdaGGXBT0SENqOwM1yVVfhOFjCf80g
	IsSlKHK86ycrA9LfQldvCMEqRi8AC2HpbYB4wFflKxsMisU5EIAx4e7knKOk5OYdPUmUuj03YJ9
	cMOK5EPR8itopEUU+lH3KvSYG+tnhUHeysO1I5FFAHj8+eMvbH02TTA0yn/yA/9GAS0NU85D0el
	fONXkYKpI+mfMdM6tkxYkB6krozGkO02mNivpFNrNNkGm2JQr9KuvKvawWn+kFx3LlQdCgIYJE5
	QyuizfAzZOVRlWL7BEtCzcYp8iEfsPsEhwayGdquF0oPr7f5aaoMIeyegBiFwqg==
X-Google-Smtp-Source: AGHT+IG0X2FGkcO4R53Tfj+l/pyZ56E7TSVQm7ef9aqRkz3RKNKEIctmWGApG3+aLsKMrlsyy/v3Pg==
X-Received: by 2002:a05:6000:230c:b0:3e3:3d84:9761 with SMTP id ffacd0b85a97d-3e62c284c68mr10724474f8f.0.1757481744945;
        Tue, 09 Sep 2025 22:22:24 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-775f77a6a6esm762184b3a.94.2025.09.09.22.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 22:22:24 -0700 (PDT)
Message-ID: <595f3fb8-6fbc-4e22-8eea-0e6248be73bc@suse.com>
Date: Wed, 10 Sep 2025 14:52:20 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] btrfs-progs: tests: output error/warn message to
 stderr
To: Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
References: <20250910050412.2138579-1-naohiro.aota@wdc.com>
 <20250910050412.2138579-2-naohiro.aota@wdc.com>
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
In-Reply-To: <20250910050412.2138579-2-naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/10 14:34, Naohiro Aota 写道:
> Outputting these messages to stdout can compromise the functions' output.
> Instead, output them to stderr to keep the results clean.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   tests/nullb | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/nullb b/tests/nullb
> index 457ae0d8354a..f3cdf9c19e16 100755
> --- a/tests/nullb
> +++ b/tests/nullb
> @@ -34,12 +34,12 @@ SYSFS='/sys/kernel/config/nullb'
>   # setup
>   
>   function _error() {
> -	echo "ERROR: $@"
> +	echo "ERROR: $@" 1>&2
>   	exit 1
>   }
>   
>   function _warn() {
> -	echo "WARNING: $@"
> +	echo "WARNING: $@" 1>&2
>   }
>   
>   function _msg() {


