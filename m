Return-Path: <linux-btrfs+bounces-15886-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F160B1BFC8
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 07:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0CD5189E86C
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 05:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9B21E766E;
	Wed,  6 Aug 2025 05:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QvFJvudO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6E7846C
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 05:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754456814; cv=none; b=JR5XZ8K/OMp8oiREZl3uoHu4zugfoT9BE11ceH9qcov2UxH0FURLqsAtwlk5+v9w2LsLT3i6R4eIe3nx3Q92XndmCAVwBtVpA3uqXyHlzQ/NmcPJ1KTA7pgUC07wbA6kaF3PHuf9bYo6W1njwXEaMNzUWAAK5M4xIKr4iydxtVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754456814; c=relaxed/simple;
	bh=ZLgX1N7gjUKCE3wCmsVhfG8ZsBEwBvEJNC+7826DZ78=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sPiueUGdNH05hyD0KQH7ABUVdargF/xfmeoVHkOurk2//smmwjYU60/BbuNrHemIUB1s6jegsLuic21QWU3lPMIHCRZoNFrfYdyKDv7b6Gft9MjtmksYY9zM3OgVX1Loui6EE5Z68cC3BgdZQTGFuxaw7xizwBB3CXjlYrGoCXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QvFJvudO; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b78294a233so5205604f8f.3
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Aug 2025 22:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754456810; x=1755061610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wfMi+vPdxEAsAK39otZJM+8zNxrgYZ5b0UbgOHbeK78=;
        b=QvFJvudOiZKSAyta2GorbmAxnAkIz7hfudfAgX+Qs8YZtOUIT/BjI3MPHKSCkFOBL1
         fizlDNyQz7PY5bRDXISTLPF72Ra3aHHEdo3ubabIdrUiexoxJv90hMXdjWnkOZsXNM6Z
         44EpW8GJnx8nGgruL+lM65/BXiRMdmFI6CkCaVKo2RCLrWmCZeK6nHP2JO92EpVEw9IB
         qyLmfILPJmK43zNgpPWzUBDS+gJ7/jsC4dgipJEF2KDZSZZXOhSQhzozyuXrujYh7YKh
         WeeugPjoc7Ckn2jVngbRmscO7Imhn6hFkJJzmkuMiiX9BEKSeowajbLuOew8GPf6ZcYD
         NxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754456810; x=1755061610;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wfMi+vPdxEAsAK39otZJM+8zNxrgYZ5b0UbgOHbeK78=;
        b=XNkGt3/fcxBIyAStpLzDZplHwPRw8J+reLsczQUjaImqg84H53/1dogtBsBHpotylh
         TmmJwkjmp9ZOxztOH3FfYMAh7cTJSCYpiuFqLkaqw+oMMT5H0+tnos3l6SAWHKRS4HIv
         7ys/nUtfPOrvckNTMpkVqekPnTyj57u2vePLnihJfMoKhHs6foZQx7aUEJJvb1UIoosZ
         hE7bYxMwaZNrblm7wW3DX8gNJUQlMPF18+5Q8U8HdVjKUdXAZgwBLMUFEZ+zaYLFPkM9
         2vQ0zI4NgQkuUg6eZl28JlkVKh+LdTcsPCBQpPXsYMfTX5dyTMdugVKcXdLMOHOemixD
         zltQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdgLtFZXXGHXQlLkb4Nfvwg+2bVVFh1wpF/Km56RJkqAhmrcc1+u4QyJ6g/exKcyQagiLCXNcdW5/THg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKpqZtV6qod0MDIZgI6Nw+BRl8Oe1Uz9YQqvmWrHmL2rrR8OaU
	cIPhGIldUV2ZvLdwIGmaVAoc7yhPci6HP041SYGr0a4weVHJacOG9wjf0UPjY1i/Ne4=
X-Gm-Gg: ASbGncs4xSez9tywcXIUWWqZsZ8wa0CnuBPh4j0dT+r0PiZ7XLrKwb3ma2W9Aba/2Ed
	efBN6BhlLjb2/BowQg3NGbLm6zhPXqmEHNgggMSRjO+4tv9+8E34qW1CzLbtt6UuTOyVFJ+LSuS
	pOmKhtMIJhjKjjTBDXfACUeJFhXi9WYLpZEFhVscQzVUEq8Y1xXopFWl6toe1rBskNJQCt8ND35
	fdtFric+fqrM72k2pdGa0MzcACtBHcWLILmIcV0/XBC6P/rZsf06McmQGN0UxikM7YmubcZZtbU
	GVpTjVUux0cS0iG+5fEkwET6IkuOMMPcBORcNxO8P80IocQfH8jHl0V9UE+1Toq2MdJBdBYsobD
	xRdpWTPLpmiuEToQP+f8eAkBd+0ljV2jnmHi24eKlkx1A4RXzJA==
X-Google-Smtp-Source: AGHT+IFr5jgKjikWrS/hLy7KH34t0Sapi8qoAPN8OVHrTpm5FGiNTpfp2lIJZaiOMunqPv4rbIm2jA==
X-Received: by 2002:adf:a2c7:0:b0:3b5:e714:9770 with SMTP id ffacd0b85a97d-3b8f41620ccmr796079f8f.14.1754456810095;
        Tue, 05 Aug 2025 22:06:50 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7e4fc1sm12557314a12.28.2025.08.05.22.06.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 22:06:49 -0700 (PDT)
Message-ID: <4222f30c-8bd5-42a9-ab0a-f8c39d402256@suse.com>
Date: Wed, 6 Aug 2025 14:36:45 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs-progs: check discard_max_bytes in
 discard_supported()
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <614684a6dfeafb1e4d2fe721b2b89f564449d223.1754413755.git.anand.jain@oracle.com>
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
In-Reply-To: <614684a6dfeafb1e4d2fe721b2b89f564449d223.1754413755.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/8/6 02:44, Anand Jain 写道:
> Some devices may advertise discard support but have discard_max_bytes=0,
> effectively disabling it. Add a check to read discard_max_bytes and
> treat zero as no discard support.
> 
> Example:
> $ cat /sys/block/sda/queue/discard_granularity
> 512
> 
> $ ./mkfs.btrfs -vvv -f /dev/sda
> ...
> Performing full device TRIM /dev/sda (3.00GiB) ...
> discard_range ret -1 errno Operation not supported

Where does the error come from?

In device_discard_blocks() it just calls discard_range() in steps, nor 
discard_range() itself would output error message.

> ...
> 
> Fix is to also check discard_max_bytes for a non-zero value.
> 
> $ cat /sys/block/sda/queue/discard_max_bytes
> 0
> 
> Helps avoid false positives in discard capability detection.

Since there is no error message and the error code is either ignored (in 
btrfs_prepare_device()) or properly handled (in btrfs_reset_zones).

So I didn't see how the false positives are even possible.

Thanks,
Qu

> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v1: https://lore.kernel.org/linux-btrfs/2f9687740a9f9d60bdea8d24f215c6c0e2a9657b.1753713395.git.anand.jain@oracle.com/
> 
> v2: Checks for discard_max_bytes().
> 
>   common/device-utils.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/common/device-utils.c b/common/device-utils.c
> index 783d79555446..d110292fe718 100644
> --- a/common/device-utils.c
> +++ b/common/device-utils.c
> @@ -76,6 +76,17 @@ static int discard_supported(const char *device)
>   		}
>   	}
>   
> +	ret = device_get_queue_param(device, "discard_max_bytes", buf, sizeof(buf));
> +	if (ret == 0) {
> +		pr_verbose(3, "cannot read discard_max_bytes for %s\n", device);
> +		return 0;
> +	} else {
> +		if (atoi(buf) == 0) {
> +			pr_verbose(3, "%s: discard_max_bytes %s", device, buf);
> +			return 0;
> +		}
> +	}
> +
>   	return 1;
>   }
>   


