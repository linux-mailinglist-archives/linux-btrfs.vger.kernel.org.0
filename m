Return-Path: <linux-btrfs+bounces-14109-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9833CABB479
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 May 2025 07:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 347BB3B7E5F
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 May 2025 05:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919771EDA1A;
	Mon, 19 May 2025 05:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IoePaPBa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934721DA21
	for <linux-btrfs@vger.kernel.org>; Mon, 19 May 2025 05:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747632649; cv=none; b=BgCoOOD9zAGdSy1i9VmN74w/TlUOB23eVr0EY2sMd4Z/C5Wja+0p96yrdNKgxGDd0kbVJRsFxmBHRTQhWIvJXbZVGfFkESNucS9eRuYbtabzswdExfG0+EcCzFdvADZiC1gUHzZ2mAhtUSBjtslRU2cyfepPCTSB59De8WaEOr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747632649; c=relaxed/simple;
	bh=kixAu9+Gh0XhQ9+mqEPgFyXmpl4Ttpg6puVVgOVuESw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BVI7/xxLs4Iocs5QMIpNkOjJwz1AM20fa5BZgdHvKLhZ5bbvZNCGS6U6q0U7EJZDj61kniNB32Jk/uv2onmCLC7knf5LLMjVwd4CLt4aMHvrBDW8Q+6yW+2DX/WnrF3qRBrtLdHIUTCFrLVsmsU8eyvAryujOwvpQHo1TrlB/bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IoePaPBa; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a0ac853894so3423763f8f.3
        for <linux-btrfs@vger.kernel.org>; Sun, 18 May 2025 22:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747632646; x=1748237446; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Biq3vvvupH1VYSOpwnxrk1re7KLEcSYqDTwLbIJJxUk=;
        b=IoePaPBaYW88krxbNfCv3xO7+nyqebfUN/efCdzatHrNX4upF1Dyw+vb/JpgiK1V4c
         WPs98lTiUa2baT2tIRhOnM8ot0fqxX5PNt/hLiFQJHHljsX8UnHzVBgNwgg4Z6qZvj27
         g2w3t8yzm8++EDmSejRPWtwOt7C2NngfA57HzvBVNw1eLaxapDbG3l2plnTgQC5BhOQr
         IF6y1v8+32iZfCOQSPzi2s9ZJhlvqQrysrxva2tDeo5XJDiQ90cg7FP94FJuENrhVqGe
         y4OE4jfVNK4lsbytF7/DQKWile6aPgRDdgaa/9PsliFkKRROrVUh71AwLsgSquQIdmBe
         9xxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747632646; x=1748237446;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Biq3vvvupH1VYSOpwnxrk1re7KLEcSYqDTwLbIJJxUk=;
        b=h0+9F4+khyGMLX9093LzXCPL/6jUB4297jR67Hn39HTxtbl31y5oTzodRzbvKy09AG
         WDYP2WWmBv9hqGE5OL7R1yVMq1YNzbBjxgmy9kBShyNhkSa/WPztwJFEXl6K1VdFybJN
         M1FQX+rK1ma1X9f7PK+ZkteDqE9v9LcnTNeCGC94Afj6Zfw3Nf7dnMkemA1gaeS+9bHs
         lfeUw8KecNBn+VuRcYJWDHAlFQLkwNVY7JEO3VmtYbmUkp3uVsTHtGJPQqnZwvBZru3l
         zmKAaFd0bBvpv8tfRJ8Yxle7RXXLqDSvAUPGy1+ts3tWiyWaA3YK/nboDkqCCQlBd3Xc
         YBIg==
X-Forwarded-Encrypted: i=1; AJvYcCVHSHwMBKklmACeDwQVR0XqoKMGBPxW5iWj4At1V3FdazGMSDSW+O0tTlSLghlb/hAFX+3olswWC41oPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4cO+QUqzTruA28vOvvj84e91KpKm6mY1Q1SI8e1JDkbY1hTfn
	vPinZOg15PsIiId734iXUJigqnUmX2ddGdLd3o/bxryV0Y6Ftr65EtZvaFVWCveAJZVz+oiqVAS
	EoJcu
X-Gm-Gg: ASbGncsx5hw7cjk/aB7k5TnT+kBMCfoB4rl6F1vAgcjVX1UT2QC+9Usdz59pNLYezOl
	+aOSocqlzWoD9pSRExbwF6vdyw+qHJP/DipoldWu8OlZ2tdfJQZbfykZ3eRCyrlFZ2dCKkTbqBQ
	VQNJzGsibTIYi0I2ZCLiMN6/AqwS+z4YyKTq4S4XXeSu1wZZ4+5ZmHOPQiMmlIhztx5QSQGpLPi
	6/Arn25q0RU/fho4/320ohfZ1/lkCaRv1ViXEHZAY6e8f6149xSgPiScC8O5kdPLvterlrmPbHp
	V035JCAyCkCRziVJFC0ORosd1Yze+CfNO/jn9SEN0DUQJjLXEXHJH/mpmV2LMhbdJNVd/XQ9UVL
	gztg=
X-Google-Smtp-Source: AGHT+IEsp0CDK7DW+jhO2Pfpr4XmxAHao9l0FxJ8kq0AmwU2K2/LvzlKr13VybCxozksK6P5Schrwg==
X-Received: by 2002:a05:6000:250f:b0:3a3:64d2:ced0 with SMTP id ffacd0b85a97d-3a364d2d229mr6234030f8f.53.1747632645717;
        Sun, 18 May 2025 22:30:45 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a97375e9sm5378392b3a.73.2025.05.18.22.30.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 May 2025 22:30:44 -0700 (PDT)
Message-ID: <cb99de5d-5800-45d7-a6b2-d58f364799e1@suse.com>
Date: Mon, 19 May 2025 15:00:23 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] btrfs: remove nonzero lowest level handling in
 btrfs_search_forward()
To: Sun YangKai <sunk67188@gmail.com>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
References: <2803405.mvXUDI8C0e@saltykitkat> <12674804.O9o76ZdvQC@saltykitkat>
 <4d02fad5-07b2-47b6-9e18-30f45bc67163@suse.com>
 <5890818.DvuYhMxLoT@saltykitkat>
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
In-Reply-To: <5890818.DvuYhMxLoT@saltykitkat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/19 10:01, Sun YangKai 写道:
>> 在 2025/5/19 09:07, Sun YangKai 写道:
>> [...]
>>
>>> Thank you for your reply. I'll fix it and split this into smaller patches.
>>
>> I don't think you need to split, unless you really have a strong reason
>> to do extra refactor.
>>
>> Something like this will be enough (not yet tested):
>>
>> ```
>> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
>> index a2e7979372cc..ca63e0dad499 100644
>> --- a/fs/btrfs/ctree.c
>> +++ b/fs/btrfs/ctree.c
>> @@ -4615,6 +4615,7 @@ int btrfs_search_forward(struct btrfs_root *root,
>> struct btrfs_key *min_key,
>>           int keep_locks = path->keep_locks;
>>
>>           ASSERT(!path->nowait);
>> +       ASSERT(path->lowest_level == 0);
>>           path->keep_locks = 1;
>>    again:
>>           cur = btrfs_read_lock_root_node(root);
>> @@ -4637,7 +4638,7 @@ int btrfs_search_forward(struct btrfs_root *root,
>> struct btrfs_key *min_key,
>>                   }
>>
>>                   /* at the lowest level, we're done, setup the path and
>> exit */
>> -               if (level == path->lowest_level) {
>> +               if (level == 0) {
>>                           if (slot >= nritems)
>>                                   goto find_next_key;
>>                           ret = 0;
>> @@ -4678,12 +4679,6 @@ int btrfs_search_forward(struct btrfs_root *root,
>> struct btrfs_key *min_key,
>>                                   goto out;
>>                           }
>>                   }
>> -               if (level == path->lowest_level) {
>> -                       ret = 0;
>> -                       /* Save our key for returning back. */
>> -                       btrfs_node_key_to_cpu(cur, min_key, slot);
>> -                       goto out;
>> -               }
>>                   cur = btrfs_read_node_slot(cur, slot);
>>                   if (IS_ERR(cur)) {
>>                           ret = PTR_ERR(cur);
>> ```
> 
> Yep! This is exactly what I want. Actually I was doing changes with different
> purposes so that make things totally messed up :(
And this one is now properly tested too.

Thanks,
Qu

