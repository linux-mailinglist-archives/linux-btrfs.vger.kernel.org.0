Return-Path: <linux-btrfs+bounces-15929-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5E2B1E59F
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 11:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04D66189FF8D
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Aug 2025 09:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9E023F417;
	Fri,  8 Aug 2025 09:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BzYcLzrr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAED11C01
	for <linux-btrfs@vger.kernel.org>; Fri,  8 Aug 2025 09:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754645516; cv=none; b=gFZ8B+EyVoODJBqQS59UCjYkfVEpct4fSSBvukQEhZ+s6fndRgdAbYL/GKu9SAfs2myS2kkkruJ1mmEm0UIszjWx4QDeT6keo2Y5Sc9ZBjAv8AQR+UsKRmUi8j+FkRzDnGgmpLQoYCV2d0MyphGWLNbaTghkkL8qu3uN1UF/jdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754645516; c=relaxed/simple;
	bh=4fAHylpxzqWl0xmc++RRi3fIet3SZ4911prvgoSzUNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fINtFJEw18/fs9sMx1atJDQ8V+BgSIUcPUGyG62jM4oYsznFuwOCEajMnt8I+ieJ3tCEzN7AbbxBxnMvnsK3KqPfXGa/iigSdvHBrIx6+qGl3d9+D5TZcZ+MlRS2s33rJ4s+b1m2LBA0F2m6+MiChJ3lP5tXSaahd4PQ1f/GfA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BzYcLzrr; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-458b885d6eeso11863545e9.3
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Aug 2025 02:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754645512; x=1755250312; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hZ8qT0NICeHImxU8QaE3TusIOWt+LmOeTxKNaf3n53o=;
        b=BzYcLzrranco9I24uzgl2rlHr6O/tA5jzDP55gTIniS1u5ppnajgMtNp4OEwnVabYz
         CCfVC4KdCCiy7ug82385CLbiQSGDUdiLE3t+4/ksgVN8Z8sj0zCWFgeele7xXVG5XU4t
         QwT7tulBxivqMsITOWkN+KTsdogkLFOUnOijPmVy2Xt8R8YCmFaC2/r87tw35LaNyJCL
         t0/0dwfw7HRRhYB3p7CJSEsjOMDS1GZY4Lxa2YSl+OUp+bBtx0+Vid83cOKNP9ZeIDgV
         g8871gm/x1waDl+eduZDYmGRg/Ski+Q83kHC/dFw5eb79ONDIzE6wWo7fF5Pj4VVSgUD
         YTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754645512; x=1755250312;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hZ8qT0NICeHImxU8QaE3TusIOWt+LmOeTxKNaf3n53o=;
        b=R4voNU1BZacUlaalBCC60FhJjhCEHGz0Js07J44jRmb0cYUMhX/wfgKlr4N5gmA0Vt
         Qi/JRfus+odA04ePJxpdMaac4RFrJREbHH4u0FRQlWA39rx5gBSrYr4gd2Ozo+NURIUj
         7Wx6hVdxPYXRMA2AslPdyfiNrc+ip9joRDlB3rtXIG2hGGMGQv6NSgpWpSlyIfd96u8G
         bepuGyAirrrMV68UMKD9nlvdfC5z6und0pLVr8PgJjaVId5c+WmTVxFOJO3p4THJzg/W
         roAU8SmKYQ6ZygcSt8Mu0rtiYsmOOcSgAAHwBduC+WXNB70ixFy4uV5ELBeEnVOXeTXP
         QL2g==
X-Forwarded-Encrypted: i=1; AJvYcCVMH4+c0xGMdbP8acOyYzl876sVd1w6pdhUvjVhzKTC2/0kB8O/+Pb8gLsir3O6GToMBE6528Tt+Ju9GQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsAzKvu6iwIQNLL+6HXsf0Ea7YYIEqJ6yUhsVhzxD3Q/j092rN
	OZzSlovgBsnTMDpsrZo+r5QkSQi2SszEV0WqTO2e26gJArcxNHJr7uyUivbktt4qL9E=
X-Gm-Gg: ASbGncsKHnC4Mqip2MoY3JhyuncMsWy/j5xCvExSGKdIDCQeXFEVeJbtLKBidyReFsa
	Vmcvjv2CXuvpY2Vy26H525AVgGb6TafVH4XnWEXa/hfgyOQxHEpstB2E+JvDjEA32j0U8jadkyx
	wxiI1HN1SU/8IgWULaHm9j5aKqzEFBW4napkR+yAbpAUaXr9w4qs218nxRBjyCSgOQJJpZKpl/e
	iZDItDDpxqNbT9G5VjCYfdBv9u48LTZkhFz0M9LK7pTzgc3gQUBJ7b+HZ/xLEnuuqS3j3OelWG+
	/cjZO/vbhr3Qs8qyHfAVOG+XmaMXtrlRgvpiQjYzQzfwjVezTyS8KOxGcbPhwsI7Ckzs42+PFht
	1ET+hnW4vOm/VbB8kK/knLzSlBhlCo85DVCwNwfcka8T1Y33vcR1VXbi93bxR
X-Google-Smtp-Source: AGHT+IGHMyAsOaS0IyGu+SeYItF5BJM+Y6lTPWe7UODDmtm2tfByJ0eNlK44cl/C78+fCHaJ0IB45g==
X-Received: by 2002:a05:6000:228a:b0:3b7:99cb:16f6 with SMTP id ffacd0b85a97d-3b900b572f7mr1861607f8f.53.1754645512045;
        Fri, 08 Aug 2025 02:31:52 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8975c03sm205736915ad.97.2025.08.08.02.31.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 02:31:51 -0700 (PDT)
Message-ID: <c709e1b3-f57a-4c34-bf28-d00694c01cc8@suse.com>
Date: Fri, 8 Aug 2025 19:01:47 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] btrfs-progs: add error handling for
 device_get_partition_size()
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
 Boris Burkov <boris@bur.io>
References: <cover.1754455239.git.wqu@suse.com>
 <aaefe04f784bc601f355d13b3b0ecbde1aa44dee.1754455239.git.wqu@suse.com>
 <4c815239-7b65-4460-a27f-4b48b7244c71@oracle.com>
 <531a7c76-0b6e-454a-bb7a-3fc3ee0d95ee@oracle.com>
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
In-Reply-To: <531a7c76-0b6e-454a-bb7a-3fc3ee0d95ee@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/8/8 18:56, Anand Jain 写道:
> On 8/8/25 15:23, Anand Jain wrote:
>> On 6/8/25 12:48, Qu Wenruo wrote:
>>> The function device_get_partition_size() has all kinds of error paths,
>>> but it has no way to return error other than returning 0.
>>>
>>> This is not helpful for end users to know what's going wrong.
>>>
>>
>>
>>> Change that function to return s64, as even the kernel won't return a
>>> block size larger than LLONG_MAX.
>>> Thus we're safe to use the minus range of s64 to indicate an error.
>>
> 
>> Returning s64 is almost unused in btrfs-progs; Either PTR_ERR() or
>> int return + arg parameter * u64; Rest looks good.
> 
> correction: almost unused -> mostly avoided

@Boris, mind me to revert back to the old int + u64 *ret solution?

Despite the fact that s64 is seldomly used in progs, I also feel a 
little uneasy with the s64->u64 (all the extra ASSERT() I added) or the 
s64->int error code conversion.

Thanks,
Qu

