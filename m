Return-Path: <linux-btrfs+bounces-18098-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A32CBF5336
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 10:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A39543A5FC5
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Oct 2025 08:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258253019BB;
	Tue, 21 Oct 2025 08:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WdMA9tFm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCE52ECD15
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 08:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761034550; cv=none; b=hYIk/YtvkIntC/gp3qcUDYfExCq+A3sVf7jcoEvAvGDZOqQNhj1Ni5Pf4VgXtY87Y2Aw62KIOiIJW3NDOg1LYY+eqmFyzHsJD3MxyfHs6TKu2Inu650NsbIow/vLMRdbv86v1yogJ7JLo7fj80wtvpm/hgvFeLnMXM+YC9tbKIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761034550; c=relaxed/simple;
	bh=zVftnVBzK8rt+bdggo8IGbxD/AJcc2cHbCdfPnYtwWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nz4Xk4nyF+HWfYwatjJiAq/wgch9dzZwUyv365scEvuuuF/ycrDoY9DOJOu8cPG4M+x6yOGF4e7jBgl0torPHYjh2p5jrbpOUXbRHJyTH8pE0Eonc9H1uy9dvBT3gvEN6G+/3lYQzB1V7IgpsaEibG274cm10FzokKClO7Py1B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WdMA9tFm; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42701aa714aso3194763f8f.3
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Oct 2025 01:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761034546; x=1761639346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kHcZuzFp72N7RUBqQIuIU6WTtqLSl7qFxgRoCA9ftI4=;
        b=WdMA9tFm7VuQZIcV3jB3wZS31vjAkMWLYPFvm8ruZAE2sB0XIHJDzrHvzzuc5xiI7U
         ddo1uRSWKe9V5ENjaQE4NlMo/oSabyhGtEDGBoD52/VWkBQIVwe5oIFTPbZD/fh/dtzp
         Il8zFnpqYBCTZM2ZRyCtJpJg2Cupkj54towPZpFz5+HcVRVsWdWWkXZAhOuF/0p8zxsB
         8q8lhHhaK/NkCiyOjflAdO9T89AphH/wLVZsDudzoorTIiguJsf8XkLYZrJrsQgfj3hK
         eW52cWXWiF6ZjHKvtyWFAzzLcqRsmfeC1SQHVdW7N7Qnu+l8AwJXDriCtAii5t0Y+0cc
         anDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761034546; x=1761639346;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHcZuzFp72N7RUBqQIuIU6WTtqLSl7qFxgRoCA9ftI4=;
        b=Qo/iZSlIvlkwTj++o7Uc53jr8IVI2rwmbGFWJlhcGNhBN7+tKEX/NSsFMv2Ri4380u
         ImakF+EIbVMYELEO24LopYTMjszGsKoab/V1v4hqNkputMIbAmzDsjVg3QvpXzGNBBUX
         GtE3LB54TnhB4Gt1D3JWXH+dN2W9YSm1O26C6ium9pzt4aZAkuxl2gBudvSOdnaSdUqE
         K7OjqCd4I7FNM1Zbqchvy6H/+S8FZa/1fMim3Mxb2uQZpSpzvMbsAcPRC7dnszTXrVHy
         786y6kd1W7Dfkt/WhzbytBj3W/hfdw01MHQbp49wWF0oKMWi9MPuLqfEjNWHsc/sY1WN
         AZug==
X-Gm-Message-State: AOJu0Yw/a/SB3VHN72d9ftlzkHR1rJmwbxIpX+BQVWUAAWemMfY39Nni
	U1MMp8kLdo+eNABDkvABlaTq1lY3ekEtDQ/cYhNs3SdHkuABFjqhe5x6UKdE3QYskh0=
X-Gm-Gg: ASbGncsmCAI2IsCDiwuGdBDWeFB56Ccy5L0kKRWN5rhc7c/Td7VZQh///syzIJbnFNq
	xvo1g8Fi7+TZJiZL9k+YiQY/K9yNVtH1sAwWac9zdfMTCyzCYC6ltg4yiSoE0/RR6wWlQRwxASV
	tLacDQ8cyNfxkaukXu23e8XvY1Q4Y7RLyG5wsaxeSUNNpY12usBBSjzUMLYTWBpBKUtEzMejo4P
	UyP7qkx5/2Yn9o/kCsQckxe7hM3QM+e0XB/E2I82mouzHXFdiKkAZqoollTv2Rzeb9VDLSKXNYI
	M9xcI6Wa10NDzXdUfeN7TlQiJBrCj+mVcyKPiKmyeNF0OVs4rtMZaskOxfBw9d5MKWl6Q2GjZT2
	J1dyQRktsMdzqmNMwxXjCk9lA7Q3jsakEj4Vxd+zUwW7ZjYCUuhtbTHGFWDDAc+qNA5seTF1jUd
	zj15wGPW3JAjG3TLmNj0UrWXEdnUEMI9k/3joGVOk=
X-Google-Smtp-Source: AGHT+IFaWIBoJi3XK2l2Na+ZDX2sj+oZzA5h4ZX6OeFEPtXSgG1fCm9Tbf7ohSg/qKEJQ1ymWULiPw==
X-Received: by 2002:a5d:5d08:0:b0:427:a34:648c with SMTP id ffacd0b85a97d-4270a34652cmr9043168f8f.58.1761034546186;
        Tue, 21 Oct 2025 01:15:46 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff4f779sm10584512b3a.32.2025.10.21.01.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 01:15:45 -0700 (PDT)
Message-ID: <4f4c468a-ac87-4f54-bc5a-d35058e42dd2@suse.com>
Date: Tue, 21 Oct 2025 18:45:37 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: O_DIRECT vs BLK_FEAT_STABLE_WRITES, was Re: [PATCH] btrfs: never
 trust the bio from direct IO
To: Christoph Hellwig <hch@infradead.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org, djwong@kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org, martin.petersen@oracle.com,
 jack@suse.com
References: <aPYIS5rDfXhNNDHP@infradead.org>
 <b91eb17a-71ce-422c-99a1-c2970a015666@gmx.com>
 <aPc6uLKJkavZ_SkM@infradead.org>
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
In-Reply-To: <aPc6uLKJkavZ_SkM@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/21 18:18, Christoph Hellwig 写道:
> On Tue, Oct 21, 2025 at 01:47:03PM +1030, Qu Wenruo wrote:
>> Off-topic a little, mind to share the performance drop with PI enabled on
>> XFS?
> 
> If the bandwith of the SSDs get close or exceeds the DRAM bandwith
> buffered I/O can be 50% or less of the direct I/O performance.

In my case, the DRAM is way faster than the SSD (tens of GiB/s vs less 
than 5GiB/s).

> 
>> With this patch I'm able to enable direct IO for inodes with checksums.
>> I thought it would easily improve the performance, but the truth is, it's
>> not that different from buffered IO fall back.
> 
> That's because you still copy data.

Enabling the extra copy for direct IO only drops around 15~20% 
performance, but that's on no csum case.

So far the calculation matches your estimation, but...

> 
>> So I start wondering if it's the checksum itself causing the miserable
>> performance numbers.
> 
> Only indirectly by touching all the cachelines.  But once you copy you
> touch them again.  Especially if not done in small chunks.

As long as I enable checksum verification, even with the bouncing page 
direct IO, the result is not any better than buffered IO fallback, all 
around 10% (not by 10%, at 10%) of the direct IO speed (no matter 
bouncing or not).

Maybe I need to check if the proper hardware accelerated CRC32 is 
utilized...

Thanks,
Qu


