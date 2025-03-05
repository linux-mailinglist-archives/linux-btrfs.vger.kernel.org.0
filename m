Return-Path: <linux-btrfs+bounces-12015-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1D9A4F836
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 08:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E83116CDF9
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 07:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B0F1EF0B4;
	Wed,  5 Mar 2025 07:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Sa1WIR/p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8C11547E2
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 07:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741160787; cv=none; b=WyW5wAozXAkJh5P9/7FNAqyMZGRpI6ZT4wFAx3o4MvxtRlyTuvYrYCSDEqQ8j4YNBJrPGPTJ42ss1sSBB5JClo1yZTXin+iwYNfyNlJj+f4UwW7Z5v2smIL3DcsebcIi75kf2U1hVJsaHmG26hc0OEr3Au130T/TSW8+3+S7jf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741160787; c=relaxed/simple;
	bh=khBG+AeifILMkBtvboVr0jvPB/RdLfBG8xMh35hrSvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m/GLpzH7x/diWBWkGXxXZSdVg/7Nsxo4rGjOFs9ud1rO5IYUNEZjueWy+SAvf0hdxg1qYvergL7jCPYZLu4YVuhg3Ba0nJ6ORohhQygAq75q+LW5sxkl+vJV2/l/CPZsydPBCZRA2/daLh0LW9SjftNsvNgwg5JsG9FZXSeqAm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Sa1WIR/p; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e4ebc78da5so9755957a12.2
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Mar 2025 23:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741160784; x=1741765584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LbM9WQ56bl7juFOI0D5Pz2RAOKNPPQeP5DiJgUsTL/o=;
        b=Sa1WIR/pvnRQgDDGQVeKc5slM/MSxy+YCEqXEDWZ9915QtusW+xoGvR8PxfXSqQ+dN
         IMYLo+ckz/CqnRaZvgQLGjL67jXff0p7fD5OjjLF5sTOfDddSqw/Mbta+En/wecIyplC
         vZRV5yRe7ytlXtnT9fygCJwgGRrjPppI3+65n8INVkrYtzlDfF1Ge63EtaIWzUyaUT5Y
         XTX5kbGf98mjFrmWbpSMeaYUBlr5pKkNHr1ZhPQH/8Atd0IlVcJnMWDBP6akJYkBt+mf
         EqvPecSpy9C5f/OOBJCvu2GJOQkt+5dG6Q8bmpgrz0ibjsj1wNNP3kQttKdbvlTgCss4
         eWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741160784; x=1741765584;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbM9WQ56bl7juFOI0D5Pz2RAOKNPPQeP5DiJgUsTL/o=;
        b=fN1XCx0GYDaUwpP5dnEIWg+NbMaH1yX7r/vcJe8xAQSG2n+9SbLPkUPQ9uUP6lUn8Y
         qMbfnMAGCwfrsnxjcrZzZmrYTLut7fA4mxJjAIQmgIewRHGW6fBkneYt+/eNI28SMV0U
         aGImJUEhZBo40pd1RTPZUcqEO7Kh94SrKN2n2bVuesfEE3USSnyefjVAWdk4N9tOhT8I
         KpMKQhn5JoAnFQjCKdgFDiLpxM7Kn6HsoElIOd/WaZlXgDiIIR0rAMAEFG2LqBm6w2my
         jmFch/PNZz0UTzddlyKuj43kXvOU2UdnK9Tu6QuQy+7GKwqVW8QJF8o64UxOhjlZLj1s
         7hsg==
X-Gm-Message-State: AOJu0YzFyP5qZYGRHBnhv/GNxQeTGlrycfWFwVaad6c185D9Be4ZLJQB
	EZ8dcj/dPA99jxdLgNZnEuRYCG1NlDFxdHiJ2+a+g2I5FahbvvrB+LE+yHEUI3A=
X-Gm-Gg: ASbGncvHbSajp32/Uhct5Yjt+zD0EBpOGsqDXE7dMfb84XwsqQ2CIM7/5wkgSWArqm9
	9gzSdeiq0Vqr9MGNrZ4/TQVNN+EAYqQXXB8fqcaDaEJtM6e4cBdb7W0Je3QRS0f+MO+onavYUpV
	Ylg4Y+6wEtAVwjbNBowaZcqlh0lD1fw6SB3bpwbYxZTm44yfhB4JadyRDo6IBR2gyMrO+DM87ef
	JcF6+sQU/REsAfOAn3ak617NXHd/yTc1Dm4QF+7oe3c9+hFpW21vndzh4X54b922r+BpgapygrB
	xlROIarNs7VamuirqM5VTGjYQNazCBdGm5nyedk6stwF9dQmRprCozb0pB/EZZtSNDQD7Nr+
X-Google-Smtp-Source: AGHT+IHbc7Ba6RybAV6EpwSoba0mVXOb9hdiRneT0qv/haPlwfzDJefSmt6yywU3mOymqkH5UcUh1g==
X-Received: by 2002:a17:906:f596:b0:ab7:e47c:b54a with SMTP id a640c23a62f3a-ac20dae037fmr213713466b.37.1741160783767;
        Tue, 04 Mar 2025 23:46:23 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7363c9966b9sm7797152b3a.107.2025.03.04.23.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 23:46:23 -0800 (PST)
Message-ID: <b6b13f8d-a15c-4b96-9aa0-71f156fa41bd@suse.com>
Date: Wed, 5 Mar 2025 18:16:19 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: fi defrag: allow passing compression levels
To: Daniel Vacek <neelx@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
References: <20250304172712.573328-1-neelx@suse.com>
 <e8cd2383-1466-4f4f-bc88-cf0ba8f04e60@gmx.com>
 <CAPjX3FfSBC121JU1ccNad-8bNcg9JBk+kcRvV3z5ij8zY5GZxg@mail.gmail.com>
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
In-Reply-To: <CAPjX3FfSBC121JU1ccNad-8bNcg9JBk+kcRvV3z5ij8zY5GZxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/5 17:46, Daniel Vacek 写道:
> On Tue, 4 Mar 2025 at 22:40, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
[...]
>>>                defrag_global_range.flags |= BTRFS_DEFRAG_RANGE_COMPRESS;
>>> -             defrag_global_range.compress_type = compress_type;
>>> +             if (compress_level) {
>>> +                     defrag_global_range.flags |= BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL;
>>
>> Since it's a newer flag, the ioctl() may fail with -EOPNOTSUPP on older
>> kernels, in that case it's better to fall back to flags without the new
>> COMPRESS_LEVEL one, and try it again. (With some warning showing that
>> the kernel doesn't support the new flag).
> 
> Well, we don't know if the user really wants to proceed without the
> specified level. This way the defrag fails and the user can rerun
> without that option if he's fine using the default level.
> 
> Ie. Do we really want to do something different than what was asked on
> the command line? Let me know and I'll change that but this looks
> rigorous to me.

Right, since the level can only be enabled by explicitly specifying the 
--level option, we should not fallback.

With the doc update split out:

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> 
>> Thanks,
>> Qu
>>
>>> +                     defrag_global_range.compress.type = compress_type;
>>> +                     defrag_global_range.compress.level= compress_level;
>>> +             } else
>>> +                     defrag_global_range.compress_type = compress_type;
>>>        }
>>>        if (flush)
>>>                defrag_global_range.flags |= BTRFS_DEFRAG_RANGE_START_IO;
>>> diff --git a/kernel-shared/uapi/btrfs.h b/kernel-shared/uapi/btrfs.h
>>> index 6649436c..d2609777 100644
>>> --- a/kernel-shared/uapi/btrfs.h
>>> +++ b/kernel-shared/uapi/btrfs.h
>>> @@ -645,7 +645,9 @@ _static_assert(sizeof(struct btrfs_ioctl_clone_range_args) == 32);
>>>     */
>>>    #define BTRFS_DEFRAG_RANGE_COMPRESS 1
>>>    #define BTRFS_DEFRAG_RANGE_START_IO 2
>>> +#define BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL 4
>>>    #define BTRFS_DEFRAG_RANGE_FLAGS_SUPP       (BTRFS_DEFRAG_RANGE_COMPRESS |          \
>>> +                                      BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL |    \
>>>                                         BTRFS_DEFRAG_RANGE_START_IO)
>>>
>>>    struct btrfs_ioctl_defrag_range_args {
>>> @@ -673,7 +675,13 @@ struct btrfs_ioctl_defrag_range_args {
>>>         * for this defrag operation.  If unspecified, zlib will
>>>         * be used
>>>         */
>>> -     __u32 compress_type;
>>> +     union {
>>> +             __u32 compress_type;
>>> +             struct {
>>> +                     __u8 type;
>>> +                     __s8 level;
>>> +             } compress;
>>> +     };
>>>
>>>        /* spare for later */
>>>        __u32 unused[4];
>>> diff --git a/libbtrfs/ioctl.h b/libbtrfs/ioctl.h
>>> index 7b53a531..08681f2e 100644
>>> --- a/libbtrfs/ioctl.h
>>> +++ b/libbtrfs/ioctl.h
>>> @@ -398,6 +398,7 @@ struct btrfs_ioctl_clone_range_args {
>>>    /* flags for the defrag range ioctl */
>>>    #define BTRFS_DEFRAG_RANGE_COMPRESS 1
>>>    #define BTRFS_DEFRAG_RANGE_START_IO 2
>>> +#define BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL 4
>>>
>>>    #define BTRFS_SAME_DATA_DIFFERS     1
>>>    /* For extent-same ioctl */
>>> diff --git a/libbtrfsutil/btrfs.h b/libbtrfsutil/btrfs.h
>>> index 8e5681c7..ebc9fc2a 100644
>>> --- a/libbtrfsutil/btrfs.h
>>> +++ b/libbtrfsutil/btrfs.h
>>> @@ -608,7 +608,9 @@ struct btrfs_ioctl_clone_range_args {
>>>     */
>>>    #define BTRFS_DEFRAG_RANGE_COMPRESS 1
>>>    #define BTRFS_DEFRAG_RANGE_START_IO 2
>>> +#define BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL 4
>>>    #define BTRFS_DEFRAG_RANGE_FLAGS_SUPP       (BTRFS_DEFRAG_RANGE_COMPRESS |          \
>>> +                                      BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL |    \
>>>                                         BTRFS_DEFRAG_RANGE_START_IO)
>>>
>>>    struct btrfs_ioctl_defrag_range_args {
>>> @@ -636,7 +638,13 @@ struct btrfs_ioctl_defrag_range_args {
>>>         * for this defrag operation.  If unspecified, zlib will
>>>         * be used
>>>         */
>>> -     __u32 compress_type;
>>> +     union {
>>> +             __u32 compress_type;
>>> +             struct {
>>> +                     __u8 type;
>>> +                     __s8 level;
>>> +             } compress;
>>> +     };
>>>
>>>        /* spare for later */
>>>        __u32 unused[4];
>>
> 


