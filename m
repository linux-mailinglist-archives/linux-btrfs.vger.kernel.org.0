Return-Path: <linux-btrfs+bounces-13844-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B8CAB05A3
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 23:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6D14C3DCD
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 21:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5152248B5;
	Thu,  8 May 2025 21:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dUvZ4lBy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235F624B28
	for <linux-btrfs@vger.kernel.org>; Thu,  8 May 2025 21:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746741437; cv=none; b=lKarQ6ZpehtzjBoaayEtFBM9HxFnh27uyRZaOPQsr2xvE30/iQdnP9N4lxQNkKGTkUafNK7MZSR0RNdhYLR5ZGTwtMbDdCf/7e/SxABwRKG5XlpJhyi6SZwx3b8juon+/KGGPyXZCyA9ghMAmeI3Jp7cuSDci7twwPjpPgnPRQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746741437; c=relaxed/simple;
	bh=tJYvYC4GGi0VwzJW9G2k1r1ul3Lu7hfgAn20ZhNE3Ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cZLjWQp+q7eIVck1PuxsyhMPGYQkMGs2taAJCKjPmo5yM+NemTbUoEf2sPxeZ6jn5k1Kj2h6tebJuwjzQdhcLcgAyffFgHZ7Cg9eRwAsV4DkD+ErGteeeev3edPONen8OO5C0BuJLVEGjmbJLbHk6A+GcDe++xLNn902bk3Wvwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dUvZ4lBy; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a0adcc3e54so864684f8f.1
        for <linux-btrfs@vger.kernel.org>; Thu, 08 May 2025 14:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746741433; x=1747346233; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Qt1QM+ThvDl1A/p13YxZ4xuxqIEhM+mBTSFCQzClmmE=;
        b=dUvZ4lBymzA8E6PytHvAmkaLV14zjF8ln+dWU2u/p5QEcaZriL1GFkRyiS2tz0xMU7
         VPgAmcolohN5rPpedj5sD9SVY7B9Bh01deXyvmhaDMnxR1pd7wTpB52RiMwIZJN624o1
         7pU6vSpyAfteeO7KFGrnOPib5GPkwEJO96BCTlIf0sEoH/+R1l0isEFskgATh84bn4Cx
         L4FtfPsMV0w5tkjBKS4+7YIEJ9Hx00bqJKGAQxig53GkIkBHQlnDZyX7HDVFePtV/D71
         BhldFmKjIcQUwZIerarsLzbaRYA94BlJkZcP2hUIdBuBUzSuA0ELfL3zFu+q8uSr6qfx
         G4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746741433; x=1747346233;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qt1QM+ThvDl1A/p13YxZ4xuxqIEhM+mBTSFCQzClmmE=;
        b=UZK5wY6Z+InW4AWy8edK75E21KuaDmOnVPhiK4ZMz94dzJ+BQRem4EZdCrC8dl6Ojh
         oCZWSAf20Qf/2qEPTYKTRSP1aVs9l2SV6XHaTzP9WM3sunERA2xN2ot/mRMrsSdAJ5jZ
         vctp3hddKp1JdQ1p7HYffYtz4KrrLVnQZciCQW/6MwZH5jurdiKEQgTQTSIlO+x9+Ekf
         XNm0tPkiuTccbIKPm87cIKNuHqxJ7pYhHy2gP65QftjBjhTaqwRY8WGwtxkbEf5ZO0yv
         yVbB8qYTYXR31l3Ziad6h8KEY1gR+EGCmWqqtOrm2ark4rtGRbvgp4V9i8RrxnktBgig
         Trwg==
X-Forwarded-Encrypted: i=1; AJvYcCUii7Sq2rHmgIKyMr1gma0Iz9XAqSxp/t04GUgHMuUXx7icplih8f+CDuqWHANBCm5gOornnBj60Htg9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFLXkMSMTLLdWP9sPIzSBGqo0xCJ3rksAEnRclMln8eYh1FiIg
	41Wo8+ux85WAt9iVhikevrU/5YAAv0fxg0YEt0qeAWdK1/kYuL1Qd4sg8UMIlOFjUxnlM+ny1pY
	2
X-Gm-Gg: ASbGncsbeNG0t1U59uUvdAYd6lc8huqd192fBDYLs76+t6bdFXc0gkduiXq/3FafqYi
	z7AuVJSVaGaiHSsljFLQkFO3gMzUd1aiqfrp27SRcMBWq07nGwy38jgEl4hYxCbNJgfY0iOvu9Y
	HQ/99XA0tG/1TX6rd2tC4Ym3cAZ0ciDTgBnBcu0MCQlnZBXT7VUpfzXxF/72GbNUUF4Z1ML5Zwy
	BjD86rsiXWB1CZkT9k8jLoXHGoCFM+K+I9at4KqZiXJDbHjedS96rAJOclG6zY0Dl0eclWlZ1pe
	AT4kL2cE+djM2MqZRSe5P+jMpyleZwcJp6aGh1PwJD6RyAq5HrX3dPowDjd9whteI3F7
X-Google-Smtp-Source: AGHT+IGZ8cmmKjCIUzzJhDwMpiFnowbPur1Z4ksZd6nfusmyvJJKaBqUDDPjynwsvawQzxVi3vWLWQ==
X-Received: by 2002:a5d:5f48:0:b0:3a0:8298:143d with SMTP id ffacd0b85a97d-3a1f647ae37mr903529f8f.13.1746741433031;
        Thu, 08 May 2025 14:57:13 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742377277fdsm514774b3a.47.2025.05.08.14.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 14:57:12 -0700 (PDT)
Message-ID: <5578dbe2-33b2-4cd8-a008-05e6f340ac59@suse.com>
Date: Fri, 9 May 2025 07:27:08 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] btrfs: fix qgroup reservation leak on failure to
 allocate ordered extent
To: Filipe Manana <fdmanana@kernel.org>
Cc: Boris Burkov <boris@bur.io>, linux-btrfs@vger.kernel.org
References: <cover.1746638347.git.fdmanana@suse.com>
 <b2b4a73fb7ef395f131884cd5c903cbf92517e6f.1746638347.git.fdmanana@suse.com>
 <20250507223347.GB332956@zen.localdomain>
 <ccacb32f-e345-49c7-9c6b-8bdc72c69a7f@suse.com>
 <CAL3q7H4YWzsCTsSC=oup6_typt_PdNVAdAuK1RVhuH1nEto-eQ@mail.gmail.com>
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
In-Reply-To: <CAL3q7H4YWzsCTsSC=oup6_typt_PdNVAdAuK1RVhuH1nEto-eQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/8 23:13, Filipe Manana 写道:
> On Thu, May 8, 2025 at 12:12 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>>
>>
>> 在 2025/5/8 08:03, Boris Burkov 写道:
>>> On Wed, May 07, 2025 at 06:23:13PM +0100, fdmanana@kernel.org wrote:
>>>> From: Filipe Manana <fdmanana@suse.com>
>>>>
>>>> If we fail to allocate an ordered extent for a COW write we end up leaking
>>>> a qgroup data reservation since we called btrfs_qgroup_release_data() but
>>>> we didn't call btrfs_qgroup_free_refroot() (which would happen when
>>>> running the respective data delayed ref created by ordered extent
>>>> completion or when finishing the ordered extent in case an error happened).
>>>>
>>>> So make sure we call btrfs_qgroup_free_refroot() if we fail to allocate an
>>>> ordered extent for a COW write.
>>>
>>> I haven't tried it myself yet, but I believe that this patch will double
>>> free reservation from the qgroup when this case occurs.
>>>
>>> Can you share the context where you saw this bug? Have you run fstests
>>> with qgroups or squotas enabled? I think this should show pretty quickly
>>> in generic/475 with qgroups on.
>>>
>>> Consider, for example, the following execution of the dio case:
>>>
>>> btrfs_dio_iomap_begin
>>>     btrfs_check_data_free_space // reserves the data into `reserved`, sets dio_data->data_space_reserved
>>>     btrfs_get_blocks_direct_write
>>>       btrfs_create_dio_extent
>>>         btrfs_alloc_ordered_extent
>>>           alloc_ordered_extent // fails and frees refroot, reserved is "wrong" now.
>>>         // error propagates up
>>>       // error propagates up via PTR_ERR
>>>
>>> which brings us to the code:
>>> if (ret < 0)
>>>           goto unlock_err;
>>> ...
>>> unlock_err:
>>> ...
>>> if (dio_data->data_space_reserved) {
>>>           btrfs_free_reserved_data_space()
>>> }
>>>
>>> so the execution continues...
>>>
>>> btrfs_free_reserved_data_space
>>>     btrfs_qgroup_free_data
>>>       __btrfs_qgroup_release_data
>>>         qgroup_free_reserved_data
>>>           btrfs_qgroup_free_refroot
>>>
>>> This will result in a underflow of the reservation once everything
>>> outstanding gets released.
>>
>> That should still be safe.
>>
>> Firstly at alloc_ordered_extent() we released the qgroup space already,
>> thus there will be no EXTENT_QGROUP_RESERVED range in extent-io tree
>> anymore.
>>
>> Then at the final cleanup, qgroup_free_reserved_data_space() will
>> release/free nothing, because the extent-io tree no longer has the
>> corresponding range with EXTENT_QGROUP_RESERVED.
>>
>> This is the core design of qgroup data reserved space, which allows us
>> to call btrfs_release/free_data() twice without double accounting.
>>
>>>
>>> Furthermore, raw calls to free_refroot in cases where we have a reserved
>>> changeset make me worried, because they will run afoul of races with
>>> multiple threads touching the various bits. I don't see the bugs here,
>>> but the reservation lifetime is really tricky so I wouldn't be surprised
>>> if something like that was wrong too.
>>
>> This free_refroot() is the common practice here. The extent-io tree
>> based accounting can only cover the reserved space before ordered extent
>> is allocated.
>>
>> Then the reserved space is "transferred" to ordered extent, and
>> eventually go to the new data extent, and finally freed at
>> btrfs_qgroup_account_extents(), which also goes the free_refroot() way.
>>
>>>
>>> As of the last time I looked at this, I think cow_file_range handles
>>> this correctly as well. Looking really quickly now, it looks like maybe
>>> submit_one_async_extent() might not do a qgroup free, but I'm not sure
>>> where the corresponding reservation is coming from.
>>>
>>> I think if you have indeed found a different codepath that makes a data
>>> reservation but doesn't release the qgroup part when allocating the
>>> ordered extent fails, then the fastest path to a fix is to do that at
>>> the same level as where it calls btrfs_check_data_free_space or (however
>>> it gets the reservation), as is currently done by the main
>>> ordered_extent allocation paths. With async_extent, we might need to
>>> plumb through the reserved extent changeset through the async chunk to
>>> do it perfectly...
>>
>> I agree with you that, the extent io tree based double freeing
>> prevention should only be the last safe net, not something we should
>> abuse when possible.
>>
>> But I can't find a better solution, mostly due to the fact that after
>> the btrfs_qgroup_release_data() call, the qgroup reserved space is
>> already released, and we have no way to undo that...
>>
>> Maybe we can delayed the qgroup release/free calls until the ordered
>> extent @entry is allocated?
> 
> At some point I considered allocating first the ordered extent and
> then doing the qgroup free/release calls, and that would fix the leak
> too.
> At the moment it seemed more clear to me the way I did, but if
> everyone prefers that other way I'm fine with it and will change it.

I'm fine either way for the fix.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> 
> Thanks.

