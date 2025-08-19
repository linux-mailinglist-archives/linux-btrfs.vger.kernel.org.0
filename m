Return-Path: <linux-btrfs+bounces-16163-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CC6B2CF5E
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Aug 2025 00:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2B42565535
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Aug 2025 22:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945D52C11CF;
	Tue, 19 Aug 2025 22:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LZZKFwqh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0963054D7
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Aug 2025 22:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755642602; cv=none; b=ff+WLhefKpoWff837zlGh02M3xL4QZOgwmATmEb4EKrmlbn149F4rUkpp17aN8jYsEnI5GbUmLPAPUAvUXYaghIr0nYgyjKpg+z5hHUo1USS4tITeSEPtArgdxccBwdySIaWHDiOJ4Z8CEqqCd159zkCe5AiNq8K16TxeEV2u84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755642602; c=relaxed/simple;
	bh=HZksAYQ4kHU1lDM12o32HhtqzCvx7LHxTmMQn52UwxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LvFb8R7PXtORSolAmxcLetcY4S5XXRszgA80IvVDW+uo7o4X4k0qMyEXdhnfn51OZynJsN65t9NpOXk5MTvbONHaJMWWN87Mfq2/xKNJ3e9PIZR1Ezk9Dv5eNU8xv4uZXxewdnrfZg3Q0bl4VZxV1y6en8IG3SbUpwpnRnlSawM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LZZKFwqh; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b916fda762so158042f8f.0
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Aug 2025 15:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755642599; x=1756247399; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L3LyUExt2tysrsAgQ6Hn1/JoNy0ONRwUrROZs392ODI=;
        b=LZZKFwqhglp/2SPkGKIiJKLsn4zyUa3KEqDY2S5gQoW+LrGavp/FAcXq5E9HyW8Tgg
         SO3ig/DvekoVRryiyNKNdTU27y8lcRCWqcPTzUg9gtkxzwPGfRrWhyPLsarLXEwvIAMF
         AnR7uUF8H+lXKV5TLYjgF+H/ADe9E7bgk3ZhrLi6DcI33vclHX4TF7eKLjnJNKnSWf4S
         7BhjZVx91r0fDQa+h826bxVL5Lb7ZZggUxbDqmavUME2S8otkMyi9ADmHsvmUk93rVJK
         iJtLTG2vMaV+QBNCyTd9DPxYLgTB49BlAmgZiLHQXuSShAaajuzN3VMhOCAo3zsAGUar
         WAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755642599; x=1756247399;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3LyUExt2tysrsAgQ6Hn1/JoNy0ONRwUrROZs392ODI=;
        b=IsALNPYnNnJC6UGaDuFFKvYZRkEmsWd7CHYtgJoq0+MNf3iU07S12h31HhcRwShOl4
         jIBq1IYt/Sb2LUbhcv8NoQdlzfRiuobeXe1aF3NrdYfFDtqqYW3xHmeYakynPtE5eJMe
         dMBsTL4U9fYZQNtxfNdksUlG8Ei0gifIwuMHJTR+U4ZMAl1Hjcp5Z2vKJn4Ygh5OpTwM
         YTWbgvuA5yyjcerbnM5ptfd4ABAimhpPmd66sdgr+eGLS3eVDRccZwm9OEXD0sFsEiVf
         X0ujWc3FF4rgmdqBXoElc774B/RUO7p7Ci5k0ZqBRzAZ01HEgFouuA1lQ0+9N21HWdmU
         Tp5w==
X-Gm-Message-State: AOJu0YzSoXoNde8BzYTUFy3vzXB8qtxxJR3Nv/YEdbXNiKH86KPq3kQh
	UyZ/ypdsJEyk7ASbFhYZu8i1o4BUZ+1lP32FfDyhYXMvNec/KOISwPjw7uglfLJmYUc=
X-Gm-Gg: ASbGncsWA4yuyWBffmdkwzsiCN0ZF/pVZPrcDJshrD2CBvg2U2qmTcRwwdtlHRg5Xs5
	3ctsvA9A89SiPuNtU4cgWg1sv8ldOVupmADoikcqWLpVKfJtf2u56MOE5I3l3pnrYivFVtgEMeR
	hAGJr+aB7e14IGUzttNLOz+Oxkg4Mo6bytMx6y20Yyi5gRzrSgOhe74w5CWv1RE2vackWccicWj
	zWt9EQTqTomBvCbDDF8CObjCkvUAhe+rcm2NgwhaH2hFFdd5SB8mGpQhRzYcnUVnt5NwuoyKT5w
	zuyA0qPZb8iizlOf1Yeub3ty96COpfb+Yh/uY2EkqRfDjhAU6BR7Dj8kzeRasHXHwv7lCmmdvvy
	u75XS4/jwBOPZyPKiL/RP/v3g8Eue5RpDJnTHqiLk96c+n4Jd2IA=
X-Google-Smtp-Source: AGHT+IFU6nVs7UDjGjLCtY7cw2ELDqChPOw8cByYfJ8OpXaugzrRfYvBRlHz+wNCv4KEP0WqxF0OtA==
X-Received: by 2002:a05:6000:2508:b0:3b7:9d87:9808 with SMTP id ffacd0b85a97d-3c1333b5f1dmr3206192f8f.15.1755642598887;
        Tue, 19 Aug 2025 15:29:58 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3242433f986sm1703572a91.0.2025.08.19.15.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 15:29:57 -0700 (PDT)
Message-ID: <26059372-f900-4348-997e-d6c379c685f8@suse.com>
Date: Wed, 20 Aug 2025 07:59:51 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] generic/563: Increase the iosize to to cover for
 btrfs
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, ritesh.list@gmail.com,
 ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
 fdmanana@kernel.org, quwenruo.btrfs@gmx.com
References: <cover.1755604735.git.nirjhar.roy.lists@gmail.com>
 <ecdd04bce98bb0d1393289e84cf8913ae10cb222.1755604735.git.nirjhar.roy.lists@gmail.com>
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
In-Reply-To: <ecdd04bce98bb0d1393289e84cf8913ae10cb222.1755604735.git.nirjhar.roy.lists@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/8/19 21:30, Nirjhar Roy (IBM) 写道:
> When tested with block size/node size 64K on btrfs, then the test fails
> with the folllowing error:
>       QA output created by 563
>       read/write
>       read is in range
>      -write is in range
>      +write has value of 8855552
>      +write is NOT in range 7969177.6 .. 8808038.4
>       write -> read/write
>      ...
> The slight increase in the amount of bytes that are written is because
> of the increase in the the nodesize(metadata) and hence it exceeds
> the tolerance limit slightly. Fix this by increasing the iosize.
> Increasing the iosize increases the tolerance range and covers the
> tolerance for btrfs higher node sizes.
> 
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>

Looks good to me.

Just want to add some more analyze for the failure case.

For the test it writes 8M data with 5% tolerance (around 408K) with the 
total writes.

With 64K block size (and it implies 64K metadata size) for btrfs, it 
mean we can have at most 7 tree blocks of writes plus two super blocks 
updated.

Considering the default metadata profile is DUP, doubling the metadata 
writes, the real limit is only 3 tree blocks.

And when doing fsync, btrfs will create at least 2 new tree blocks, one 
for the log tree root, and one for the log tree of the subvolume.

This is still inside the tolerance, thus the test case can still pass 
for a lot of cases.

But if a full transaction commit is triggered, btrfs will need to create 
at least 3 new tree blocks for root, extent and subvolume tree.
Depending on the mkfs config, it will increase to 7 tree blocks (free 
space tree, block group tree, csum tree and uuid tree created at mount).

All are exceeding the tolerance limit.

Doubling the io size will make the tolerance to be 8 tree blocks, 
covering the worst case of 64K metadata sized btrfs, at least for now.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   tests/generic/563 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/563 b/tests/generic/563
> index 89a71aa4..6cb9ddb0 100755
> --- a/tests/generic/563
> +++ b/tests/generic/563
> @@ -43,7 +43,7 @@ _require_block_device $SCRATCH_DEV
>   _require_non_zoned_device ${SCRATCH_DEV}
>   
>   cgdir=$CGROUP2_PATH
> -iosize=$((1024 * 1024 * 8))
> +iosize=$((1024 * 1024 * 16))
>   
>   # Check cgroup read/write charges against expected values. Allow for some
>   # tolerance as different filesystems seem to account slightly differently.


