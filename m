Return-Path: <linux-btrfs+bounces-12682-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B84A762BE
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 10:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 098317A2E17
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Mar 2025 08:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5171D516F;
	Mon, 31 Mar 2025 08:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Rm3IgMXA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A66D1CEEBB
	for <linux-btrfs@vger.kernel.org>; Mon, 31 Mar 2025 08:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743410951; cv=none; b=ImQWcTQxw+XGExQbaMwYbby8v5NtqxTJiHPI/EZuiRW4SERF0g9rR7BwWg3uzT3WKta7LrgDrcZZBJ9JpicP0nrk+WtLhurl20vjfMXw3z2rHV7a9JkUxcgALSXU870HHuQxvhwBn1EcPLI4EMDTZap5k8/AJjncwJaFPGotnBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743410951; c=relaxed/simple;
	bh=t/8faHLL83J137LJpJfZX7qm+i6iv0APIty3Cf7tof0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hxvtmrksENHOu3vnEJ7AzAdtrEmHbFuvxZ/M3qK4VD+wZiCmLJmTpsBLnOntIXSofU6CMBqORT/xo8xAflETUSnOy2Big5fvHU5y7I0vyGLrG/ZEiZHOTpELtwlhrkGBVP/hgJ11nPXUkU9N3uTDVkpK2qIck8SYBmfFLSb7hxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Rm3IgMXA; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso26493845e9.3
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Mar 2025 01:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743410948; x=1744015748; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Whl2WUPVc98vQM/m+qe6R3Gc9cHEk/GeWcmoXxjFvvk=;
        b=Rm3IgMXAmPDqh140rm5zrxLS/2Z1+oJJnRnO6tg8WWaaT3F+c8g0gEm1rs3w6TgoSG
         xDaAE08O0SyoYCIIqKzx8peRscw/v+eFw+SekOPcIyjMFnTqqlUkD+9s2z5PPOSSKiDT
         buz8MJnRRuth+jx6syEOmvxwoez37/RwLxYualKv1Fxp2Xw6/fgtXAYJwFU1DdUopk34
         XbC8vMlcpirDiwr580yD1Pm4kzlZ44fuWWk7m7iHeqxqQDOqhw04+jro1kENnKm8MYU1
         crIRIsRLx6JV2iWlutA+EGdMrGOgkGYZupMpiWwEjUAmequ43+lfBKAQUctsG/lXT16v
         j08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743410948; x=1744015748;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Whl2WUPVc98vQM/m+qe6R3Gc9cHEk/GeWcmoXxjFvvk=;
        b=fKxFdCQU6r/7fNdj/eqcqFifa67jWhcwZjfhzYPutJj98swNHh7JEQ4SP/R+WyNy/L
         8HLuwBWJxAhupqDSwrsWRBhYqlsoDmvK8irc8m/Mvg/S8q0bntD04rN8xgKHJELdsLws
         BgvQMvzL0rXMAdd9Zc3UXwZKg89/tVZIusVJM3G+x1B5BtP1vpiJqle3BCpQvs9RGSqA
         viEz20+5/AvO63MdeD3iiV76Szjci5RRSDFGVsRfgTe33FJy/U6zCYAlyjKlS+xC1Kuy
         XMLyWqKgXZPhvvkcHSumSrgTD0bONHDNiC5Yqd9q6OWxo9ilLNk3UiDX+h+ByoGIz5ry
         n60g==
X-Gm-Message-State: AOJu0Ywncv3jBVMEUJnc8ISSOvIlmHmDNqmKAt1um3WYKEYz/yilUdP/
	L4shCCnKT/J88aBpKRS8twX0KnL2Rmp9mK4zJOE9DG2H1fXWlCFeiapt72PcERSfU9lYRwDHyp6
	R
X-Gm-Gg: ASbGnct9skVtMmWf3F5Qlp6yvqb1ZtjcBpua8oDQwusTK3/vUKkn+mPAWIpJ8e6rfcC
	K5nAo+8M8HaKcNP3LxBKlf31/tyXA6AbhUwBSo71wLPVsmfvyuq60FSlf1nuFq0B8mwkXlx8+X7
	meo1ibWruKCLi24/n8QXQdnpV9bdh6HdtTNmpnXWmDQF4N1+car9Iw1egUcW4R+HR66wuS9S6IN
	+jDUuQIp4kNCmktHRLKOc0G4kV0dXsYz/H6EZnvimhcFdgehJwv3s03+4Ff05Bvj2A/bBYrdsQr
	nUOCaU5E3XFVdxI29OrfqoLs7rEJw5BYbuBzER+ORNgUEi1A7Ra/1vysjk/OObDq9iF0ut22
X-Google-Smtp-Source: AGHT+IGGwyZuZkogO2wb6LoJ32i7LaAkPiT9c+v6fSm+b2JTEK7/NawdZ3l9f6xwibJk26NytyxDrg==
X-Received: by 2002:a5d:584e:0:b0:391:231b:8e0d with SMTP id ffacd0b85a97d-39c12117ca7mr5915249f8f.39.1743410947649;
        Mon, 31 Mar 2025 01:49:07 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1dee06sm64292535ad.179.2025.03.31.01.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 01:49:07 -0700 (PDT)
Message-ID: <2a759601-aebf-4d28-8649-ca4b1b3e755c@suse.com>
Date: Mon, 31 Mar 2025 19:19:02 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: zstd: add `zstd-fast` alias mount option for fast
 modes
To: Daniel Vacek <neelx@suse.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Nick Terrell <terrelln@fb.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250331082347.1407151-1-neelx@suse.com>
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
In-Reply-To: <20250331082347.1407151-1-neelx@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/31 18:53, Daniel Vacek 写道:
> Now that zstd fast compression levels are allowed with `compress=zstd:-N`
> mount option, allow also specifying the same using the `compress=zstd-fast:N`
> alias.
> 
> Upstream zstd deprecated the negative levels in favor of the `zstd-fast`
> label anyways so this is actually the preferred way now. And indeed it also
> looks more human friendly.
> 
> Signed-off-by: Daniel Vacek <neelx@suse.com>
> ---
>   fs/btrfs/super.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 40709e2a44fce..c1bc8d4db440a 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -368,6 +368,16 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>   			btrfs_set_opt(ctx->mount_opt, COMPRESS);
>   			btrfs_clear_opt(ctx->mount_opt, NODATACOW);
>   			btrfs_clear_opt(ctx->mount_opt, NODATASUM);
> +		} else if (strncmp(param->string, "zstd-fast", 9) == 0) {
> +			ctx->compress_type = BTRFS_COMPRESS_ZSTD;
> +			ctx->compress_level =
> +				-btrfs_compress_str2level(BTRFS_COMPRESS_ZSTD,
> +							  param->string + 9

Can we just use some temporary variable to save the return value of 
btrfs_compress_str2level()?

);
> +			if (ctx->compress_level > 0)
> +				ctx->compress_level = -ctx->compress_level;

This also means, if we pass something like "compress=zstd-fast:-9", it 
will still set the level to the correct -9.

Not some weird double negative, which is good.

But I'm also wondering, should we even allow minus value for "zstd-fast".

> +			btrfs_set_opt(ctx->mount_opt, COMPRESS);
> +			btrfs_clear_opt(ctx->mount_opt, NODATACOW);
> +			btrfs_clear_opt(ctx->mount_opt, NODATASUM);
>   		} else if (strncmp(param->string, "zstd", 4) == 0) {
>   			ctx->compress_type = BTRFS_COMPRESS_ZSTD;
>   			ctx->compress_level =

Another thing is, if we want to prefer using zstd-fast:9 other than 
zstd:-9, should we also change our compress handling in 
btrfs_show_options() to show zstd-fast:9 instead?

Thanks,
Qu

