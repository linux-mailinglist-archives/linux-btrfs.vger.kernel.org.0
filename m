Return-Path: <linux-btrfs+bounces-14268-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFEFAC5E6C
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 May 2025 02:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 400711BA54CF
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 May 2025 00:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893A0136672;
	Wed, 28 May 2025 00:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ggsceIbC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FB4469D
	for <linux-btrfs@vger.kernel.org>; Wed, 28 May 2025 00:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748393189; cv=none; b=tqMljEpcdG1InlUK8mUM50ODauEM1wb6sn6w6LX1lsP2Y20fb/PZ3cCIoGKnCN8eKNxSV+7eylo8cNsHQlVAoQvZaDaopf+Lfaga1j5JnavWQ4PEjzP/jKsr6/UyJNVnRwV2v0ugQhisu/HYpSv8PLrwrLmRKT+IOXqGtQ+GAy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748393189; c=relaxed/simple;
	bh=axKme+ZKOp6Dr8FkKv43bVyd2xUznNqV23NayD5K2nM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BfUNsIigM+o6vA9FCIl4vzcv7D1X+Wx7sUtR9a7DXsdoaQE05pwl1bsaYPUBKoCYQE3Qb46p9Hfa28prcyJjHUG8dN/BM2DJX3i+8N/AMPo/JQ5aCtmuJdyWX4zyPmzFO5Pj6z6uWfYiG73S/PMm5Jj2bRJDJbX8uTdWB2YCcr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ggsceIbC; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-441ab63a415so46745805e9.3
        for <linux-btrfs@vger.kernel.org>; Tue, 27 May 2025 17:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748393185; x=1748997985; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AbxAg4Q90Z/PyTUUoO58xpMgcMfqkx8TfxSetNEVBYw=;
        b=ggsceIbC+xZp+QFZ77+dBg6/VhV6J36A/cTL3smRlLPgG04ZdJ5NFzI8waZ/AMcgAV
         ba7KDO6uOg88zGY5AggsGXFnLGT2WfqM5VcHtL/XOfTsz8PXUWA35qH8R5tfFFFq3BRV
         lFB4iPRKeVwMg9/GnVilAyuwjrv6xddg16UY1x/6RBSbN3uh91j/iqWwduSBqKfUW9Kr
         k66oLzX+2Kjc5w4ffFK8/Tjhio/i294IYnvfb6sIDB675nyguz/smwQU8Z50uoXoMXjL
         o0PjHGobCOWKdsLLffZechAWDr+FS7rIp4PBexNIFq2tZODJAQQTkZiq3sa/NdIszIO/
         NIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748393185; x=1748997985;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AbxAg4Q90Z/PyTUUoO58xpMgcMfqkx8TfxSetNEVBYw=;
        b=N6z8UKPGjaYOgtD/Oie80WpNsCKLw51qwPDwuqdXGMzIXFASh04feS0roOLqgmN52C
         1KgjuJbDfLQV/x35a7AyGTO7QajZ+ilRZpYj3uIrqC1tRYn/22mYBbbETNgYlokm90VS
         Y48ma615z9S/ieh4I13hj7u9jzUUDBuNhVnePzXBEvc3VGbsptm35RIKSRzpoul3ibgQ
         mheWt1QCFVp4Zt1wp7gXBF8h2YeG9+wcPeBu9bNbKkaDMTCXmJUtsaziQVeR5C8dCunC
         4iiH1LLV6R0fCfdiueEtU243gxs8eb0s0+nVqOmlt66ld4r5UEZB0kxYzZ0UBowGzI2M
         bI+g==
X-Forwarded-Encrypted: i=1; AJvYcCVQI8M3+Rw4jO3GAcafX3Sbg0mJrbFx/Saue100oc1KIh9034PoHkpUczaETYV7rK0QyHvbAj6PzTjfLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPX+q33CCS3sGrwO4Na47uJfIp6hSW/r1cjG2YQY5j2qxK9+Cp
	ezDHPnWUbPc972lfMiKW4LbztrfFeu3wPq82B/aj9vUj8mcfZg/0aXReaWhMP+v8BBI=
X-Gm-Gg: ASbGncuA8OvEt2zz7qc35jh9dkaL9KOvhXsRFWALKL9tX+N7IAXW51umaix3Sb3NR7q
	LJB0GGASImMNU8KZHMARWGVmmx+cOFrvFggY4USAMriJlpLljSOEcJ+bac+POjMG8ZoGaXMcxNQ
	+gToi3HtxfAcd2QUdkO3QBZfXVa7jaPvGbKOa33Jjd7Fj8dO7NjKWsbyu8PeH4NeclfUG1voZes
	p/ltNZPr/B73Ky3VytMnFBA2GlH0vUDd5ayt1pefVHV+E8CeGEmB9sqcotcCgz0MrFhZ+NAvPkE
	mHv2FRm7weUPVS9z5cu9tLKQTFYNJ0vWB3z/kJYOca3de8dT41h/Z+GADyJR7/EoMsJGHz03L5o
	Op4huZzB4/KRkNA==
X-Google-Smtp-Source: AGHT+IEsDulJ950Fq1kZloo5P4oD/dI729xJiTsxvqRBrvt4NVMuAkvwB+9QAQYNhRUjMyaCRdB2Zg==
X-Received: by 2002:a05:6000:4284:b0:3a0:7f9c:189a with SMTP id ffacd0b85a97d-3a4caebfe95mr11499760f8f.0.1748393185318;
        Tue, 27 May 2025 17:46:25 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::e9d? (2403-580d-fda1--e9d.ip6.aussiebb.net. [2403:580d:fda1::e9d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d2fd24a8sm393675ad.7.2025.05.27.17.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 17:46:24 -0700 (PDT)
Message-ID: <3b7dab07-c901-4a26-87eb-ee898f562849@suse.com>
Date: Wed, 28 May 2025 10:16:20 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] delayed_node leak bug
To: Leo Martins <loemra.dev@gmail.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
References: <cover.1748390110.git.loemra.dev@gmail.com>
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
In-Reply-To: <cover.1748390110.git.loemra.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/28 09:34, Leo Martins 写道:
> Currently investigating a bug I believe is caused by leaked
> delayed_nodes. The following patches fix a potential delayed_node leak
> in an assert function (I don't believe this is the cause of the bug) and
> add a warning if a root still contains delayed_nodes when it is freed.
> 
> A little more on the bug I'm investigating in case anyone has seen
> something similar...
> 
> Started seeing soft lockups in btrfs_kill_all_delayed_nodes due to an
> infinte loop. Further investigation showed that there was a
> delayed_node that was not being erased from the root->delayed_nodes xarray.
> The delayed_node had a reference count of one meaning that it is failing
> to be released somewhere.
> 
> V2 CHANGES:
> - combine warn and if statement

For the changelog, if you have one in the cover letter, there is no need 
to put changelog into every patch.

And even if you want to add a changelog to each patch, please add them 
after the "---" line, so git-am will discard the changelog.

No need to send the patches again, such a small problem will be 
corrected when I merge them into for-next branch.
Just a small reminder for future patches.

Thanks,
Qu


> 
> Leo Martins (2):
>    btrfs: fix refcount leak in debug assertion
>    btrfs: warn if leaking delayed_nodes
> 
>   fs/btrfs/delayed-inode.c | 5 ++++-
>   fs/btrfs/disk-io.c       | 2 ++
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 


