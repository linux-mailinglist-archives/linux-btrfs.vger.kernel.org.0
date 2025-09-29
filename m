Return-Path: <linux-btrfs+bounces-17248-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A5DBA86F7
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 10:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9376A3B4C8C
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 08:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0731B2749ED;
	Mon, 29 Sep 2025 08:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A1pWTYr0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E4F72608
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 08:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759135418; cv=none; b=CEU/X81JQd4r7JpkEdNDID7JDzlfXuAh1Kk6Zm1SeYmZ41Vtyd4nLDi4jWbHZ0wnqAk21c33ZMK6Gl4V3SsunlEhMOSRnq+5pUb7Er8Gik7WxFpyts3LiMwNyB+zfJuA7ly8zMm7A50Sz8F9RXYOp4Wo7Gq01b8YnQIrqdvCTjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759135418; c=relaxed/simple;
	bh=4IR9/uzT/dWuMWaLSoV9gEJaB/S2AeF9RSPaZWU8Gaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lsHDDEhuqCId+s8TveBOs4ixoHRfnZ5vGqoM00O2yNA4HR0D4UkQ2B0Also9v5gqF/UM3rMSTNLP6rxItQj0Osjq58tLsX1QOnTkWzfwOlpz3kpw+zmUQ8OWoXfaICTP/b19V+Dp5cqqRjM8UCsFZ4U11pOWDWsfvVimw2TSoG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A1pWTYr0; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3f1aff41e7eso3465771f8f.0
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 01:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759135414; x=1759740214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fy1M5UT7dQJt5IOSRfzALCzcuZUUpS0AhGi+d8g7B7Q=;
        b=A1pWTYr0yhcoaicvBzu4nUoG1MFkqG25+/R8NL5lzmWbGENAJQGz9BlCDwH6YfXa1D
         4DaA97SC/YPI6BpaBH7SXnhz8jnFITFjl7EWlJhexxLjuf7Ch/QCdjTIKmcyaAFDazsz
         5oeDUPZEaa4mQoLJ8/g+UZonfyWY6run666LvQPsKMzQVYhlE3BhU3Vkw8pbu89an8xn
         90ljLP/iTPjXBnY/HHEKEf4/ZiCuJt2Lb2Q6WW2GVutlDMsPqqvv0bCi6vuMaI/Z8xpp
         cGbgoD5QDzPGKvTbt24Ulj/t4V/8IhauQ23RN9jjZYew3wYxDBOWzeWYg2bCSDqHZ/ob
         q/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759135414; x=1759740214;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fy1M5UT7dQJt5IOSRfzALCzcuZUUpS0AhGi+d8g7B7Q=;
        b=XPC/4rqMYEIwbXebyLjerG5C6W382aonW0+bb0ELTYMcGQQuhvUXolIN83EIbEaCkN
         xkGu+yVdibpHwp7VXSGln06OpPcu+m5eICs09+h1YxQnhtYQKXM5vVAEh/ZsWRjojR5R
         /cCOU/LxeEmC8eQk2ClDqnx+p9mXuA320b40d6YUUyzu94nU3nJarHR/g0nQlnapFMyN
         ekxRWoOn/S7tK6UiaPx+gyZu+bcIchdkc4x/jjwPbxdFa/Upb5L+3HlgGLQMoIUkgSuG
         2+UvDs7OmUMIcIAxTBBZ6P5a9643BU0N+usm2F1XgisBXp589g/mkHw2d4AK3mPgVmhI
         2hBg==
X-Gm-Message-State: AOJu0YwcwDj7iddnbFzgjKC77Aughq7L/CyPxmajxg9dB4tDsuuCKdCx
	VuJFsxDOUM8VFkKvQvNih/38qAfB/amZVRIR9al8aMeTYZTo1hyzuJ/rfi3/CjGh8/WXPK5gzSQ
	oopf/
X-Gm-Gg: ASbGnct9J7/Z9DMXlA539BFrqGAFjbEfrrHRRvc3zUFsWumn7VvcNz+ALmkEmYTF9Pt
	VDx1hEEAcQI4auqz28uKrHKRGDoHmHXNj+HikPGLVbvnGfS3ai4yc4t2kbmT7kHCz9omVVG71yM
	zhu5ceP5C8tHMxl0DHTtlF9OWTXwu4s+V7MM+x9JLIKSMoWOBKj/GmTu5/0d9bVqIUUcyBlblOm
	vHDmd4Gb3nEAhonXrT1taltOPudZIqfwJaTOhT0ExZXw4O4XMgIReE798QarVS7y2Oiljr/Fnz5
	2zYq8mGqQJeHkl/O9ybtSA0Un/o/+lsftqdKjHv+lbvVMX7P5ftGjGkV+r646s3psBc3qmUq79c
	FIkFBRaYmkCl7AKziCfc1NOnbH8xaobbW8UHFWD/3aLojS0njnos=
X-Google-Smtp-Source: AGHT+IHk4NB0pngfnTZygrBrvT1Y8uxlYtwKZd/A4qeIAt49M3qlG7ctEmhm1YoL98O9m4M+OjBmaA==
X-Received: by 2002:a05:6000:401e:b0:3fa:ff5d:c34a with SMTP id ffacd0b85a97d-40e480ca405mr13615764f8f.39.1759135414188;
        Mon, 29 Sep 2025 01:43:34 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6882160sm121466225ad.71.2025.09.29.01.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 01:43:33 -0700 (PDT)
Message-ID: <90a2a601-8ea8-46f0-94f6-36db13f69c01@suse.com>
Date: Mon, 29 Sep 2025 18:13:30 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: reorganize error handling in
 btrfs_tree_mod_log_insert_key
To: Filipe Manana <fdmanana@kernel.org>, Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
References: <eb37da47-2a32-4ff1-9c63-b97a69cc019d@suse.com>
 <2394265.ElGaqSPkdT@saltykitkat>
 <CAL3q7H5aYJPeUtBJtmsA_TSSqR8BTaHifbabBCjn_jWS5An8og@mail.gmail.com>
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
In-Reply-To: <CAL3q7H5aYJPeUtBJtmsA_TSSqR8BTaHifbabBCjn_jWS5An8og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/29 18:02, Filipe Manana 写道:
> On Mon, Sep 29, 2025 at 9:29 AM Sun YangKai <sunk67188@gmail.com> wrote:
>>
>>>> -   ret = tree_mod_log_insert(eb->fs_info, tm);
>>>> -out_unlock:
>>>> +   /* Deal with allocation error. */
>>>> +   if (tm)
>>>> +           ret = tree_mod_log_insert(eb->fs_info, tm);
>>>
>>> Sorry, I don't think this is really that better.
>>>
>>> In fact I'm wondering why we don't delay the allocation after
>>> tree_mod_dont_log()?
>>
>> That's what I want to do at first. However, after looking further into
>> tree_mod_dont_log(), I found that it trys to get the tree_mod_log_lock. I'm
>> not sure if it's better or worse to do the allocation things after getting the
>> lock.
> 
> You can't do a GFP_NOFS allocation after acquiring a rw lock... The
> only allocation that can be done is a GFP_ATOMIC in that context, and
> we want to avoid them.

You're both right. Forgot it's a rwlock.

There is no better solution, I guess it's the best solution for now.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> 
>>
>>>
>>> That would be way more straightforward.
>>>
>>> Thanks,
>>> Qu
>>>
>>>> +   else
>>>> +           ret = -ENOMEM;
>>>> +
>>>>
>>
>> Thanks,
>> Sun YangKai
>>
>>
>>
>>
>>


