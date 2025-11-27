Return-Path: <linux-btrfs+bounces-19370-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6448BC8CE1D
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Nov 2025 06:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 148DE3AC8E1
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Nov 2025 05:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B310227A460;
	Thu, 27 Nov 2025 05:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="F+IWK4q7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804F1258EFB
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Nov 2025 05:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764222792; cv=none; b=tlggf54Cbq/VaEoPtVbA7pzsvm1WWk2oa6RyQ1Do20SUyzxMp8gydENE6Ew3M33uSjYxXK6Ksk6vKA966lgaOqRPRpGhgC+eb9ltE9lm/LJVuUmZniNQapNZHbJ0qoVXPQPpmxnXexS4aJFU9u406hLdKgzMorDto7BAn84eU9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764222792; c=relaxed/simple;
	bh=PCrkKs3Mgj5eolVaV80FR7LcOnxHCobIi2Njqhtpy20=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=j6D6WluY1ovBeEIRLS8yQUhZ4P9uNnnResXL5w63vvDFVv5DGsnDBmCNPvpEVyGDMwYHkVOgjnTCVAeoykmcCNGdazkmlesUHGi8GW3oNQ0f/db9284y774QRZGmFFrjkoOF6mlSRBaF8oGVoD50yulURD0vu2wjGuztjOvbkik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=F+IWK4q7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477b198f4bcso2273465e9.3
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Nov 2025 21:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764222785; x=1764827585; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1XYbz5ePq2A12aW34jPRVpWBdeEY1dFpB/ZcvzC3hn8=;
        b=F+IWK4q7kFBCnj0SoUvqVaSloDXWHGTagZPm/4XW+/X77U+NOcAigXRjTLYdCEsonJ
         U7bm4P93giS4BA8ZKbja6YXTP1wVlz2vWPYsuEXs9absjRMyGrLvDgdmy4Fzt3/vhDhE
         IayWg06GOhLmmwPtmjDMuhqWutEGceTj/audIsH38Y/aoeHiGnpBitMHQw08IJqxFn7P
         RltI1WdwjAnA7eNAnjKDGH1P74lODOzTt451tBmCOpZMtI57HFP87zy8ylI2CHpbh25p
         kR6oX/Z/G9hsm3cPyKNfXlMB5oVoJSj3pD1Sahtru0l7pHUopxQHt4We7b592wMMl8mu
         0t7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764222785; x=1764827585;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1XYbz5ePq2A12aW34jPRVpWBdeEY1dFpB/ZcvzC3hn8=;
        b=ivUdk5Qrd+cOF4YP2MrRwT+gxSPP1QY0cxCx4dLzfxi4kJl1cvqFnHHeMDzY0pbRXA
         1qxDBLYKHe+0xHMpUuyEiPYOWlNN6/W9H3XmeADdouSv3qh6rwC4GxEPB/eJwMscaHDs
         97qv+uqzj24dw5YiIsFVXMAxL8zTrpN8BFhaQQmsUCl7ALkmDgw2bTYKFjcm55/VFrR+
         NTF0rLDR0Lqk4YwYuAbsap7/HLwlCjCvGeIwmOulIvBxipEdQbA6mTcS1UYTJJ+K76pN
         ci3+vPSKyEN7iLec3AgCqCaZpHx1MQZnU1Dl/wI38lOiM0BHNibju/ZkDtNitvqDjIK3
         dW8A==
X-Gm-Message-State: AOJu0YzMlar/50ZdKBiWyxBR5503SBuOlNvtTsuQIQIj6MS50n3ezs9R
	4ZBKLTyW+mjmh/sKdz4mMLEk/4C2i7iCdXIgMMvqxYwYIN8DEt+wbBYwQ0lCmlQEc95QP8qzwM5
	vQk7q
X-Gm-Gg: ASbGncuz3z/OKEGrdvY6QuGcgSwBR+enYKJpcpCSMaw+Bnda2qBRstjmH3BeYJb273T
	DdtlAbiL+b+UHv6Hjo7cZGvTunuJsT76p7n7FCwkpXLFIfo2/Sy9xzz/Cj5zursLfOvZBiSaorP
	lA9bmPvy1TEg8OrNQXjTfH/7hFAetOFeJYZajSDy3+BYcdvpdbhdpUeLbFbHz4OhOjaG5pzJ0On
	tde8jh+5YN9By0S+A12xer/WiXu2ieuxJTXnZ3znPITk0FIVoH8exGx+GepMCpTXcBrgsNn86XE
	kBSlbz4Up9aFx0nZHwHC0+AHG+Yrf1/9XCe2cslcTflNksP4qcNndyuWcX05gSOXhLEL7EC7kaf
	IX4aSR9ljyYuoFV6nAu2OzSZiYaY1zB8WJSRi8Q4I6C04Fx59z+djyW+M8n6vK1CDyBNUr3ga2L
	kqdArXdfbLdj9NcrXNny13zxvmLdKl7ofpe8xCKtk=
X-Google-Smtp-Source: AGHT+IHcpSKb8qgBskeXJldHdnjMEKP9crYBAOK7ID2x3HzWyO8U7hFiFe/YpysQSDwrCuMbQiqDfA==
X-Received: by 2002:a05:600c:5491:b0:46e:32d4:46a1 with SMTP id 5b1f17b1804b1-477c01c36d7mr199822895e9.22.1764222784705;
        Wed, 26 Nov 2025 21:53:04 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb450cfsm4394915ad.74.2025.11.26.21.53.03
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Nov 2025 21:53:04 -0800 (PST)
Message-ID: <0e809709-32f0-4dc7-88d2-b80b8cabfb85@suse.com>
Date: Thu, 27 Nov 2025 16:23:01 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] btrfs-progs: add block-group-tree to the default
 mkfs/convert features
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <cover.1764220734.git.wqu@suse.com>
Content-Language: en-US
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
In-Reply-To: <cover.1764220734.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/27 15:55, Qu Wenruo 写道:
> I was planning to do this during v6.12 but forgot it and now the next
> LTS kernel release is not that far away, it's finally time to make the
> switch.
> 
> The first patch is to update the existing test cases related to
> disabling no-holes/free-space-tree, which will lead to mkfs/convert
> failure as block-group-tree requires those two features.
> 
> The second patch is a large page-size specific fix, where on 64K page
> size systems misc/057 will fail due to subpage mount always enables v2
> free space cache, resulting later conversion failure to fst.
> 
> The final patch is the one enabling new default block-group-tree feature
> for mkfs and convert.
> 
> Qu Wenruo (3):
>    btrfs-progs: tests: disable bgt feature for ^no-holes and ^fst runs

Although we can fix the test case for progs selftests, it will be a much 
more complex work to address all fstests test cases.

I do not think we will really deprecate explicit holes any time soon, 
thus those fstests will stay.

I'll update the series to automatically disable bgt feature instead. So 
that mkfs.btrfs -O ^no-holes can still work as expected (no no-holes nor 
bgt).

Thanks,
Qu

>    btrfs-progs: misc-tests: check if free space tree is enabled after
>      mount
>    btrfs-progs: add block-group-tree to the default mkfs features
> 
>   Documentation/mkfs.btrfs.rst                           |  2 +-
>   common/fsfeatures.c                                    |  2 +-
>   common/fsfeatures.h                                    |  3 ++-
>   tests/cli-tests/009-btrfstune/test.sh                  |  2 +-
>   tests/misc-tests/001-btrfstune-features/test.sh        |  9 +++++----
>   tests/misc-tests/057-btrfstune-free-space-tree/test.sh | 10 +++++++++-
>   6 files changed, 19 insertions(+), 9 deletions(-)
> 
> --
> 2.52.0
> 
> 


