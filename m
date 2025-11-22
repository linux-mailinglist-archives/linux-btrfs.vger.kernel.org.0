Return-Path: <linux-btrfs+bounces-19264-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C34CEC7C131
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Nov 2025 02:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B17244E1BEB
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Nov 2025 01:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADC119067C;
	Sat, 22 Nov 2025 01:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dm5xrF2H"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE98B287516
	for <linux-btrfs@vger.kernel.org>; Sat, 22 Nov 2025 01:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763774097; cv=none; b=mFXoML4QUPau1xjeE9U9dg9KLr9MNfmsQ4iA30P/TpTFgjI6eRt8sptqWEorCz0Ymxxq8+r8/v4FxYsrK/ISx7eqUAma98LJED+IOYf5B8vMDuC8+WpTXqZbbOQ2gAFoL9YRIBg83JC8W0ppE+M0IyJkzzV5tN/it6vdEclZaog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763774097; c=relaxed/simple;
	bh=AsY2yjOTYavQEjoVaWTMTZWxuVwkm8GTKQ2dFcxFJMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gjiN0SehAjnUkWMScxncewmAE/5XNXuhv605xGhyGS0je/QuNNJmz9LideZts9WEwMZ/3cLWZAr68/mJC4s5tUhw0wNhhi5FKLgvSCsfr3xLdxdQQEdmaKZ19FPI3Sd5BYz8MuGmStATLfbvlS5HkfN808nMtYmSqQelGKv1X1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dm5xrF2H; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477770019e4so23934165e9.3
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 17:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763774091; x=1764378891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=A8pPRP+7qmVEqLUup6BD0kzPKEArQY2lbWrUADgwb8E=;
        b=dm5xrF2HoWXF7UXEDdU7hg/U3pJUHe8ymNJwrWcMBYzHUUT07dFW0kExvYdmoxUUOo
         jcq7J2becoKDM82EqrdTG/8y/aBKiYePUAZ8ZGFOnvOCAiHiDLOdsPc0rcq+9/45GNgg
         mtvhBcZL++Yh7zXmZUgzOpqz1KN4VQZII5fE7L3bDfeApKh26DOuNgQeLh8AsA+bTiFn
         VpzzApeWLLoeedGQzKrpXnE4163dHp0Iv+FEd4MNLSQhYifFWHabuwXXNxeADs0W/fod
         uBtoowdG+TXoIo15VfPg+9HMQxd/DJGzzwfVeyyqhbGOroDE5GzaOti91rnSt/DRJiTd
         gQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763774091; x=1764378891;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8pPRP+7qmVEqLUup6BD0kzPKEArQY2lbWrUADgwb8E=;
        b=UO8jQ/SWc2lI5qKaAb6tHo/2EWwVfTyjBKs09FdiAtSqKF7sT7ue6TUv9UEaiAjcRf
         tphyb54Of0HXsmK17at1Ylgi7nZTYFVyq+R9M5l1qCOQrUohkiF2WOU1jbhAhWozTXR3
         ghaw1URpp7NdE8e4S9bsK2FmPqQLVTF1FjOOPxjiG+AeVPQanOW3OepwjSLB+/icci9A
         7dB8w342kErhH/L7IaO6+aY/VkHFbETnQukFevU0kJD4JgmIOql1Vpt3HlfplUPLcU0J
         hMrNc1Sz3KRBj6YCbCffK7KyPT5uvQqgcjiGVhaU2G7NR0fM5RgRh58IynGxCeMIjkhM
         ntWQ==
X-Gm-Message-State: AOJu0YxvU4fz/59yDxanGBhG900qByheZVCzNwvlCDuItkxeGpeOKdb/
	a207ZAg87LoUbBQf/EeM9cZbeiBG4SkebA7Wm85Hgk6i+n+OMu82GQOkMoyobT7VVCoupUJDM9S
	4AMWM
X-Gm-Gg: ASbGncunuhyF7rYtRpPH05FRjFod1/Jq7vXNn+XsWQTGuT3nNxWoAcfEl1gm23kUdYd
	Qu+ikP5GlUSDWfnCDcvlTVzW/IHYq4+eJh7NymP1ZrbrFcMu8G8TAzSGezpaVUnEwaD8aPLZ9KJ
	0h6d5TZcaQ3rbatKblQFhtsy2BhJijKE38akD4tLRkLKB8g41CCsd5anrM78u6r/oaEOFv/wTdz
	gUbc4TAUwMlS8Pp7B076BhH58itwxRKOnqhJekQqMrj7qETgnc6t5NsDBiFRLiKgQptBW/yN3Cz
	m5dlxub/g5tT8IiUm9lLxZEKx/grwVcHI+IWseojSnFQYfd+UrDc0cbucExkGgZt3p0cKC+94lK
	6kQqehgMDCSsVYpHcgkuZgbEVnNg4IiKT2QQs0PnxhJHHH8DnOWWZRvLHug3KjyqgdjijwMZiba
	CqsRTHUrApxgdyMkCDkJlrkDwUB+KhC/4vxQVT5xg=
X-Google-Smtp-Source: AGHT+IHoeSP6eAWJLiF2Mh+uzVBprtTgYooxQm98f+itE3x7M0xJXbjHVn00TfZxv2tlwdlNP4eGkw==
X-Received: by 2002:a05:600c:3110:b0:475:e09c:960e with SMTP id 5b1f17b1804b1-477c01f67d5mr45741795e9.32.1763774091498;
        Fri, 21 Nov 2025 17:14:51 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a7995a14esm20623237b3.52.2025.11.21.17.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 17:14:50 -0800 (PST)
Message-ID: <21484358-d1dc-4c03-837a-28bc57c80fe6@suse.com>
Date: Sat, 22 Nov 2025 11:44:46 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] btrfs: make sure all ordered extents beyond EOF is
 properly truncated
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1763629982.git.wqu@suse.com>
 <5960f3429b90311423a57beff157494698ab1395.1763629982.git.wqu@suse.com>
 <CAL3q7H6pV-pb6T70aOATXc2VBvA0PJZJcoo+B-SzK48qxzyqbg@mail.gmail.com>
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
In-Reply-To: <CAL3q7H6pV-pb6T70aOATXc2VBvA0PJZJcoo+B-SzK48qxzyqbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/21 22:25, Filipe Manana 写道:
[...]
>> Fixes: f0a0f5bfe04e ("btrfs: truncate ordered extent when skipping writeback past i_size")
> 
> The commit ID is not stable yet, as that change is not in Linus' tree yet.

Thanks for pointing this out. Now it's removed from for-next and will 
resend the series with proper upstream commit during the next merge window.

[...]

>> +               u32 cur_len = file_offset + len - cur;
> 
> Please avoid repeating "file_offset + len" so many times. Use a const
> variable at the top like:
> 
> const u64 end = file_offset + len;
> 
> Then use 'end' instead.

I intentionally avoided using @end as we have pretty confusing 
inclusive/exclusive behaviors on all @end usages.

A lot of them are inclusive, but also quite some are exclusive.

In fact even inside ordered-data.c, we have different 
inclusive/exclusive usages.

E.g. @end inside btrfs_start_ordered_extent_nowriteback() is inclusive, 
but @range_end inside btrfs_wait_ordered_extents() is exclusive.

It's almost half-half in that file.

Although I can definitely add an @end, I'm not sure if it's improving 
anything, considering it's only utilized twice per loop.

Thanks,
Qu


