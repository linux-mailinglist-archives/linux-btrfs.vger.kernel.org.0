Return-Path: <linux-btrfs+bounces-14210-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 887FBAC2D40
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 05:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C673F1BA71BE
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 03:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028F31A00FA;
	Sat, 24 May 2025 03:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E/CWtrX1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB28D38DD1
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 03:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748058549; cv=none; b=b/XT++nDn6Ybm+uqeBRxm76NHqWR7zvqRhKNMsApjJusWecJHGUcGTYtvP/R/7Nzq/0oXnd6PychtDszYNzFpK2sCaLC1wtJqNY8VG7n5JP+u39AaRC0dJTlgI5ogdDKWVBmT1ugCXcafw10NnTc50n5fRSrX/tWLffyxO7WxnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748058549; c=relaxed/simple;
	bh=xzB8hm1gSjJCE5oStwlcFSEg6mHgEIxim6C+yfS1R0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pkTH7Kz8TUMO3fwuGYtYJvwQEwZWTdVg7gcHOXu3llprUgKEoBWHIto68BsWEPEsa+4c8CRDxiMjgafyawskOShJQU8/YwAN8nsMl+H05DkZZ1Y/cb8mYFuXtzju6qhP2Fy2cjZH9efstHH7YxOh/xhscZ+dy0QpX8QUWhyvjLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E/CWtrX1; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a3673e12c4so265029f8f.2
        for <linux-btrfs@vger.kernel.org>; Fri, 23 May 2025 20:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748058545; x=1748663345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YDQ/xUnya+Sj3JVbKfL0DG4qzaO/jT2Wf117Qg3PMdc=;
        b=E/CWtrX1EDrwSDtHX+4BtDBmwjwbn4doMywCCYvP/6sx4QVgRlgzYUVj8EH4r2ImGY
         iJDi+yiXWj0Gbz53ibeaUWZ6AKNudx0LCUDyXImolm13GtOpMswETG+6h/h5+R8DTDaA
         yEd10+ACVIezVschpHCKeqbDy41YAmfQ8mJfIYy3TFx78rKC8knSWDZ3GyjbQlMkkp/u
         xpXZeveB9vCHpFCJSoKHPZ4Ov40aMnAgQiInVhgUQyA1XuSR1V/bijr7tJTgq66p8meG
         z5cRIH7P1tLR/dPJMapIPuRUcxUiee83vv5hdF/501PkNmMiiTMj348i5n9+2qjLSQfr
         oi0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748058545; x=1748663345;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDQ/xUnya+Sj3JVbKfL0DG4qzaO/jT2Wf117Qg3PMdc=;
        b=XsJHC0AgSA6VMpQg2WIVAfGj0VnHD7lljFKAwS8/5OZH+BGLSr2hbUNyYr7Hupwn9I
         2F//Jo0kVaTcy9zT2fXGeKJvAOgZqEuv6piCha83WfJnXyz8+0ElqeKOSSYICVBPaJXo
         OBmQy0GfQy5BB2sBNF3T6cohphtOEJqgoF1g2aG1KeadEbYubUBeoY+gT8lBQQLk0i0y
         WbPpVJnf7Lj0VBk8IEx8U/JgmJIBynYSvJQL972B9qY+UTYkTEnxjrIjaVXp+oFK2s9m
         4+N/hAaxQPQ6wFmXqdGU4wn+omZkMSCirWfyOlJtKT2zDjoD4wTJuH4DeCCddWta9zFB
         gTbg==
X-Forwarded-Encrypted: i=1; AJvYcCXKxoZjTJpKdWn1QL+27tflj5LsDNNeBlagDLCCYBSeaIAidfjT5MaNOT63kxzLoH+Ab098VXgQcJFhlw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7CK0xDxUCYG6jJSc0y8aetPuz88YzNiWzUC1HEV4aPWcm0wL4
	TX0U8p5PBJW2di8DlPu6KHt4dV8pAxx5q0pEWBT69zfOx7l0JSKKoXkkP5XUPCG7BAA=
X-Gm-Gg: ASbGncvmWtJAsurNovHhkKgMuiG0Nfk2Ed4HEZJpG2GGgtV06hqiEhMznw4v1uMRs7G
	Q9uTRSYqSLEKiF8LW1nUwJhcxyj4+7OeBAlXEty8/Lvt01EN00uwUNLqZRS51/s2SuwwHR4oXnh
	dc88FVoIyHJtaoBlkbjNa30p+4GKAMNZKVa+HZHiVxPp58AlaKl2HYMuJqsN9Z9oiRlt+Ikg+wI
	SLcbokje70KxM//12qY+Vphx42nrzkBxENlwCm1Tll6oGK/DrZqlV3YUiqvsjSqW62h6g9Guqkx
	YDX0PW0vHu4xiS6jGJqD8RyvhFNFJs+s6u8CNfelDxoUOL3M9Cq+kKdUXHrmQjfCY/wG+Q6zwEY
	zd4eptx82PeHjKQ==
X-Google-Smtp-Source: AGHT+IGSVVmLezx5jmIDcXSzhxBRXte5GIId7KTA52ABp0kr08IHxjXW/cmmhCGEVCcT7pROBcTcdA==
X-Received: by 2002:a5d:64ee:0:b0:3a3:6e44:eb5f with SMTP id ffacd0b85a97d-3a4cb49b40amr1200815f8f.46.1748058544847;
        Fri, 23 May 2025 20:49:04 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9876788sm13457881b3a.126.2025.05.23.20.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 20:49:04 -0700 (PDT)
Message-ID: <af00227c-c301-4311-b570-47f4d404c499@suse.com>
Date: Sat, 24 May 2025 13:18:58 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs: Raise nobarrier log level to warn
To: Kyoji Ogasawara <sawara04.o@gmail.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
 linux-btrfs@vger.kernel.org
References: <20250521032713.7552-1-sawara04.o@gmail.com>
 <20250521032713.7552-2-sawara04.o@gmail.com>
 <68a7d14b-913b-48e0-be12-5bba0d17ea2b@gmx.com>
 <CAKNDObChsMqFAYK-QT8DmFEitFX+Pmi7ifGDbYe2GfnPnUr1FQ@mail.gmail.com>
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
In-Reply-To: <CAKNDObChsMqFAYK-QT8DmFEitFX+Pmi7ifGDbYe2GfnPnUr1FQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/24 11:51, Kyoji Ogasawara 写道:
> Thanks for the explanation. I understand the issue with btrfs_parse_param()
> being triggered multiple times.
> 
> If I move the log into btrfs_parse_param(), it would currently use
> btrfs_info_if_set(),
> resulting in an info level log.
> 
> Is an info level acceptable for this warning, or would you prefer a
> warn level log?

I think info level is good enough.

As the main purpose of that message line is still just to show we're 
using barrier or not, the extra "use with care" is just something good 
to have.

Thus no need to go warning IMHO.

Thanks,
Qu


> 
> If so, should I create a new helper function like btrfs_warn_if_set()?
> 
> 2025年5月21日(水) 13:13 Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>
>>
>>
>> 在 2025/5/21 12:57, sawara04.o@gmail.com 写道:
>>> From: Kyoji Ogasawara <sawara04.o@gmail.com>
>>>
>>> The nobarrier option disables barriers, improving performance at the cost
>>> of potential data loss during crashes or power failures especially on devices
>>> without reliable write-back caching.
>>> To better reflect this risk, the log level has been raised to warn.
>>>
>>> Signed-off-by: Kyoji Ogasawara <sawara04.o@gmail.com>
>>> ---
>>>    fs/btrfs/super.c | 7 ++++---
>>>    1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>>> index 7310e2fa8526..012b63a07ab1 100644
>>> --- a/fs/btrfs/super.c
>>> +++ b/fs/btrfs/super.c
>>> @@ -407,10 +407,12 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>>>                }
>>>                break;
>>>        case Opt_barrier:
>>> -             if (result.negated)
>>> +             if (result.negated) {
>>>                        btrfs_set_opt(ctx->mount_opt, NOBARRIER);
>>> -             else
>>> +                     btrfs_warn(NULL, "turning off barriers, use with care");
>>> +             } else {
>>>                        btrfs_clear_opt(ctx->mount_opt, NOBARRIER);
>>> +             }
>>>                break;
>>>        case Opt_thread_pool:
>>>                if (result.uint_32 == 0) {
>>> @@ -1439,7 +1441,6 @@ static void btrfs_emit_options(struct btrfs_fs_info *info,
>>>        btrfs_info_if_set(info, old, NODATASUM, "setting nodatasum");
>>>        btrfs_info_if_set(info, old, SSD, "enabling ssd optimizations");
>>>        btrfs_info_if_set(info, old, SSD_SPREAD, "using spread ssd allocation scheme");
>>> -     btrfs_info_if_set(info, old, NOBARRIER, "turning off barriers");
>>
>> I know you want to avoid duplicated messages about the nobarrier.
>>
>> But it is better to use btrfs_emit_options() to add the warning.
>>
>> The problem of showing the error in btrfs_parse_param() is, it can be
>> triggered multiple times.
>>
>> E.g. mount -o nobarrier,nobarrier,nobarrier $dev $mnt
>>
>> Then there will be 3 lines of "turning of barrier, use with care".
>> But inside btrfs_emit_options() it will be only once.
>>
>> In fact this also affect the warning for excessive commit mount option,
>> but there is no better solution for that option, but we can do better here.
>>
>> Thanks,
>> Qu
> 


