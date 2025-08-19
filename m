Return-Path: <linux-btrfs+bounces-16160-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D23C4B2CF02
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Aug 2025 00:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3CE2726698
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Aug 2025 22:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF3835334E;
	Tue, 19 Aug 2025 21:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GpkgCT5K"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91225353348
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Aug 2025 21:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755640758; cv=none; b=RCVVFy7wmP7j/KH8SG4GpRylP5jSjObXfnqgYRbtykDvAg6g7Z6AQZYBGdmsYHPV3gZKgNjSk6iVkqg5c0XdRSUSBKX17b9JESbymIwXV2MUgW2VS0lwBoChNd+GGVFwhx3B1L9SQR8xiHzCevmIS5lTcHVYcm24ul+2+GQpLCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755640758; c=relaxed/simple;
	bh=inmnY4PV/KOfPsxdHCJiK64MO9/qTvqbWgizOJ7kAFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EZ8fMGGPnUoiDpGgTSL7LxCNmg8p/vWGURG6A3uLjZwua2obT60GQdIwdh0WlrgNaptmprzqUPVaAZeP38W9RDE3OAIrGthcuTf2fM87GBlI/V1PZ9r7Ns4QoGE5qBFxym0tfZhiPXF+OeP7bWIpvJhfc7uPZpTOjCAdbB622QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GpkgCT5K; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b9ba300cb9so239176f8f.1
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Aug 2025 14:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755640754; x=1756245554; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rUlAuILfOze2r61y7KA7vRVQx03to8px5XRMKOD01HU=;
        b=GpkgCT5K2C8O/YlpU5zYqXF3UUcWD4lnKRy6DzFxIYqEztzeX34A/PpBdkTmSnaLpP
         XrQJc36vcKsRbKtGS45BBwlMsLeUYZeSVGGRjk8JiLBJom4UecKsqkJONE9wiygpCbzl
         nR/0MZ5oY8AuR5IMiES9aQfWw0O1TTEGMWPYFq3h7w0j8abaXRy9fNqMVArSoKFlMS5A
         muWVCKlTwWke5DqXWKxytrFgjr5RMTCiqG1xk5hiKJSDy08wOT/+XAeTirUqH99pHTYP
         f2zpO34H3BLPBcH9ypibLbuoMwVDrux02Aun762IWqt2z2G8kNV5byFE3aEOLPXA6VSa
         x9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755640754; x=1756245554;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUlAuILfOze2r61y7KA7vRVQx03to8px5XRMKOD01HU=;
        b=AooCCrt90gzVm8MQO1Al6wzQWQL1prNy13tJhWEzcOqwdYSIW9q1FKzrYdeHE1dhh+
         m3XNx1lB+xa7SKxqX6+mrxX4O7IvngjkQStjRSuIOqKGH0+8RAlNOoa4J+65DqcgNBnp
         XggECIIsYDUPdnFM/lTMk4ZWqGWkVjrqe0G75aFOec2Vuf89eGMs7TnS8Jsomjc5ux6N
         ezUENRoylkUWgrAQ5JhYCCj/1PgESmMRIOVmCalQ0x8RX4F5KvF7tehd56fC2gHLMr11
         dQHzgxqBRpF+vu0hgu4huudi93jbdt6kog5sI0uzSDQvPgnDPHzVTDhh8XN8T0UP+fBV
         xPNg==
X-Gm-Message-State: AOJu0YwEbszpesloqZ9VSrfpGwE1YuOTOZQRXXIMaM7repn1iGFaKPx5
	8jDNUBiz0Hz2Avd5NO+UZfseONT9UXVRUW8/xCIvgP+Lk1l0tVkDU69APAlKuj/O6Uo=
X-Gm-Gg: ASbGnctVWKFcK4auESUCJrKm0te32Q4w/hIRua6oPZt1tURfzufIFdHxUlwxj4LStaq
	OGsvej/4MOSDUaibCxNUPvSPLGHgIfI6MjpP49uUz6a/dklkCUxRsJjB+crelcNBLUtLrS8u3M0
	En8CmDepTbCsG2JQW0d2RpQFxM5GcSxhA/9ONZ6csn/Q0sSUGEMVmy2qzjPJT+eJTD+T0nR2GiE
	euuuGt5I0aWiEzTaaL7nkGWGjZnPNN0i0R0RBBJiZYiBhmTcdU5azEZLtHgovdG0bbTxBbhFnFj
	huy/h0TtjEGgATChOy9HD2mACqcE9CSqYWtFd5IZXBBPFs9qFCzW51rHt5qG1dCd06b8wEgmqL8
	fgWI+8SycA9pzPj6FAGWJDQU37+60a6LX0nH7nzCWJtLxCJFy1cQ=
X-Google-Smtp-Source: AGHT+IHIaTOhTTCeWHRYbi1rPoijG80hFcco8UcQG8z7UoPrK2NZYoaX01K6loeSJiC/6BbDPbDKhA==
X-Received: by 2002:a05:6000:4313:b0:3c3:5406:12b6 with SMTP id ffacd0b85a97d-3c3540616bdmr97037f8f.30.1755640753772;
        Tue, 19 Aug 2025 14:59:13 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d5c09sm3491602b3a.22.2025.08.19.14.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 14:59:13 -0700 (PDT)
Message-ID: <f257edaa-b7aa-4076-bb7c-a2f3dc7549fa@suse.com>
Date: Wed, 20 Aug 2025 07:29:07 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] btrfs/301: Make the test compatible with all the
 supported block sizes
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, ritesh.list@gmail.com,
 ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
 fdmanana@kernel.org, quwenruo.btrfs@gmx.com
References: <cover.1755604735.git.nirjhar.roy.lists@gmail.com>
 <122da7535db9470515980b765ebbd05f6dd7d882.1755604735.git.nirjhar.roy.lists@gmail.com>
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
In-Reply-To: <122da7535db9470515980b765ebbd05f6dd7d882.1755604735.git.nirjhar.roy.lists@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/8/19 21:30, Nirjhar Roy (IBM) 写道:
> With large block sizes like 64k the test failed with the
> following logs:
> 
>       QA output created by 301
>       basic accounting
>      +subvol 256 mismatched usage 33947648 vs 4587520 (expected data 4194304 expected meta 393216 diff 29360128)
>      +subvol 256 mismatched usage 168165376 vs 138805248 (expected data 138412032 expected meta 393216 diff 29360128)
>      +subvol 256 mismatched usage 33947648 vs 4587520 (expected data 4194304 expected meta 393216 diff 29360128)
>      +subvol 256 mismatched usage 33947648 vs 4587520 (expected data 4194304 expected meta 393216 diff 29360128)
>       fallocate: Disk quota exceeded
> 
> The test creates nr_fill files each of size 8k. Now with 64k
> block size, 8k sized files occupy more than the expected sizes (i.e, 8k)
> due to internal fragmentation, since 1 file will occupy at least 1
> fsblock. Fix this by making the file size 64k, which is aligned
> with all the supported block sizes.
> 
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   tests/btrfs/301 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/301 b/tests/btrfs/301
> index 6b59749d..be346f52 100755
> --- a/tests/btrfs/301
> +++ b/tests/btrfs/301
> @@ -23,7 +23,7 @@ subv=$SCRATCH_MNT/subv
>   nested=$SCRATCH_MNT/subv/nested
>   snap=$SCRATCH_MNT/snap
>   nr_fill=512
> -fill_sz=$((8 * 1024))
> +fill_sz=$((64 * 1024))
>   total_fill=$(($nr_fill * $fill_sz))
>   nodesize=$($BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | \
>   					grep nodesize | $AWK_PROG '{print $2}')


