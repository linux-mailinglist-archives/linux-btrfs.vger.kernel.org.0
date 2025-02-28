Return-Path: <linux-btrfs+bounces-11922-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E17A7A48F03
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 04:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13E767A6E90
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Feb 2025 03:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7187B186E20;
	Fri, 28 Feb 2025 03:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NpleTaP6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B47717A2F4
	for <linux-btrfs@vger.kernel.org>; Fri, 28 Feb 2025 03:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740712452; cv=none; b=gra3ZaBqz6kxROOmGkPf2J8Z6yT3CW+UjRVNhZ+WZ1CUDsl1N4K1iBB1ZLNfT9T/pDKxgODkUwYoelGSp9n+PewW3eVMnh4UH1ygYkNME4I1t7KA6l/Teln++GiyVsGSpFgsoalOkiVXbFHP4JvcBV4054eidBQwb3rLoFQnWgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740712452; c=relaxed/simple;
	bh=eD470XKbeh7KNkOcNoRBKiQQagTdCOmKgeVFB993z0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AT5SPF3BuYlhBC+4otnm/ecFcWMYM0tk4zXYPO8EY8J+2bMxnbUQ3BToe4I9KKVyK3BDiPlt1iQHMK3/MdwjWtfvp0ALPQoqoH1CfanGvWC4gCh3VqqCAvinU+0GP/TOaj3J873IQsPKyn8WFHi65xk8aPRd2V1UG7mK2YdUYSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NpleTaP6; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e0813bd105so2634964a12.1
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Feb 2025 19:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740712449; x=1741317249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tR2g3guQwpCRvu1AaEaFllIlS67y2E/ubnMQcHpihPw=;
        b=NpleTaP6nlI/nG/K9Sq6XmmNfK2pOkJXiltU8hIs4HaqcSiexjwsWWkqZrJ8cMhkb8
         yJ+Xh8OUVVP2LPa+hosSHul2hjAw0nM/DItlz3yZzMfN0KdM4Y4EXvoTaOp2fDx8HRA9
         mleA7OqFwHYgKVNEImuI1toqh31eq0BRbctADseyGeCuGYsFfgmRuVs7jF9SpMzUOW2o
         DkZVN7x8KAzVZnLRRYIJZcjf+rWyxUhQlI1CVFUY7DGkhcohqlriIKnSWvGkj3UXXjVT
         OseuhN9kG6alaQcQMlnvodp76FLFPigvtKtlC9MorvTauqGb9tUU/SC2h8JeJR8YbRPN
         GwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740712449; x=1741317249;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tR2g3guQwpCRvu1AaEaFllIlS67y2E/ubnMQcHpihPw=;
        b=ZPdO2S6A6rl5DKHz+5KQvQdp9pWspDIOGOy8k0b1aES4VkzfxGxYLl5q9DgaR5bnDf
         5Ru3gEW0d8FGJkzC2cMDAlaK1vMW1Y6fn++MiZ02usP7jIhP28bzITFl7FUFV3/FtxJU
         OguV6Dt6lybcsPAfxFAwM3mUQdJIGI05ANiF7iecIDJGdBBgYHy79HWz5KxHBFhvoqbQ
         ScHMnRNj7zor9p3H6lpFZV0ynEsPWKp5GP8WXwHC8Z51o2c6MnbbLzTYQNVSa+zIMPch
         dd9CHarqKg3xZlnKxotL7RF2PnfExKiKrMc0sAlODcy1WYVicJ+WG6lLjJQUDNJk4lLO
         hUUQ==
X-Gm-Message-State: AOJu0Yz8rz8qDDNoloyU9JxS/qvaUHCeTjGZcahLu9GXJJxmUhvuIdbR
	5kajzXx5aEU/hXnJx1dvxbPMgPWQCVpdIYSqZof9lG95Qd0s1M9tyhhAZ28F0TY=
X-Gm-Gg: ASbGncu1dtX2CPY+A8NBPhDJSh8IcaLOuvE2oM843BTKTSVYTvRRc6LHOkAL6l8na4F
	xdn19KdakfoMh881uYPnHOdYgaAumnthYOhFh22kWdERDqGpWbjOO8hFp7sPCKW6e92nR6+VvRt
	S7nzok0F0LH+TTh/GmyhCbJtlzRR9+qsEf64d+m0jb3/shCcuNt74r4YJyXbNCkvbuVYKhcF5Bb
	C+fq0QVwQSVZryb5o7B9MNiU/VMATjl/brL4YnvnakQYGBR/R4lo8u92/a0L3uJgMJEHfO/u1QV
	nsO5GtHlWWPQ4FYu5cbV/kQZo0ZV8dIS+kdWztYD68vVfFukFTlXbA==
X-Google-Smtp-Source: AGHT+IE2CGKolcx/FW0LwaAPbdHe4OOBwcI/beoE8cctktng+gm9JJPhQzjvltfIw5Y6FIXuxi1EsA==
X-Received: by 2002:a05:6402:42cb:b0:5e4:bf03:e907 with SMTP id 4fb4d7f45d1cf-5e4d6afa36emr1059728a12.19.1740712448459;
        Thu, 27 Feb 2025 19:14:08 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a00249c3sm2570461b3a.85.2025.02.27.19.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 19:14:07 -0800 (PST)
Message-ID: <ffd5ebe0-541c-4d21-b7dd-f0bbe29c8200@suse.com>
Date: Fri, 28 Feb 2025 13:44:04 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] btrfs: make subpage handling be feature full
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <cover.1740635497.git.wqu@suse.com>
 <20250227111603.GB5777@twin.jikos.cz>
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
In-Reply-To: <20250227111603.GB5777@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/27 21:46, David Sterba 写道:
> On Thu, Feb 27, 2025 at 04:24:38PM +1030, Qu Wenruo wrote:
>> [CHANGLOG]
>> v2:
>> - Add a new bug fix which is exposed by recent 2K block size tests on
>>    x86_64
>>    It's a self deadlock where the folio_end_writeback() is called with
>>    subpage lock hold, and folio_end_writeback() will eventually call
>>    btrfs_release_folio() and try to lock the same spin lock.
>>
>> Since the introduction of btrfs subapge support in v5.15, there are
>> quite some limitations:
>>
>> - No RAID56 support
>>    Added in v5.19.
>>
>> - No memory efficient scrub support
>>    Added in v6.4.
>>
>> - No block perfect compressed write support
>>    Previously btrfs requires the dirty range to be fully page aligned, or
>>    it will skip compression completely.
>>
>>    Added in v6.13.
>>
>> - Various subpage related error handling fixes
>>    Added in v6.14.
>>
>> - No support to create inline data extent
>> - No partial uptodate page support
>>    This is a long existing optimization supported by EXT4/XFS and
>>    is required to pass generic/563 with subpage block size.
>>
>> The last two are addressed in this patchset.
> 
> That's great, thank you very much. I think not all patches have a
> reviewed-by tag but I'd like to get it to for-next very soon.  The next
> is rc5 and we should have all features in. This also means the 2K
> nodesize block so we can give it more testing.

Now pushed to for-next, with all patches reviewed (or acked) by Filipe.

Great thanks to Filipe for the review!

For the 2K one, since it's just two small patches I'm also fine pushing 
them now.
Just do not forget that we need progs patches, and a dozen of known 
failures from fstests, and I'm not yet able to address them all any time 
soon.

Thanks,
Qu

