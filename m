Return-Path: <linux-btrfs+bounces-17734-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC0CBD6388
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 22:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DCDA19A081A
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Oct 2025 20:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CB3309DDB;
	Mon, 13 Oct 2025 20:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A050GTO/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A322EA743
	for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 20:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760387962; cv=none; b=CsCaRdhcVgO3lvsETSReQhL1Q10+bL9G5ANyPcaCJlNb12xDMRF3jP21O0wofwHBYIzodTfUipLgfGjVhRyiBgFAJ598qkG5c84yF2RF3K+dtjkc/iLcEE0V7ZzRPE9PdxNJLnQuDOY7npGPNo3GJJ0K6Wou5DJskqSRd6ipBiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760387962; c=relaxed/simple;
	bh=DxBfGhh2/+HUO/+PM3P0ICetsG5JgKa7Tc70QypA8nA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LgW5gl3vhoJd7P0J6b9Gfx4coXR7dOsXxO88fGF3j9qncxAFKDd08ckJA9GFVavVuSH/eLHSbEYku/82UYq8Mhuxoo5feUoqj06ScqMmLcKsMlQkotRoT0YHhJPhy77cXhBT4d0N+zJ6G1W2LwreTzSAswoOmuXTYtCPs9Nocs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A050GTO/; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso4066224f8f.2
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Oct 2025 13:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760387958; x=1760992758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k/5lJurlyuxJdcFqWY2oR5aDpcqghsFG3DOY1t5I0NM=;
        b=A050GTO/G48qQSzFrZR1uA1zzcKq+yAMFmiDPpEfrUhfr9PlJHDx4DLJ1Nv30uB/5s
         0CJA1MYxQRTz4PT7INjrObPH9QJFK3vuRK5/s4pLDYom1nIF3IpGzoAuovcvInG+YGJH
         3hOcQuECju1MRko7UhD7DfdnrvRRJHF5ubrIBe9fukdMSJ0dY6YODPCr3GACckk3/3zL
         QspMseMqqOQrPEzC8Ts5PUyPSmr4ya9ZCCar5zDb5CA1geCkruYQor8rjOdU1spx9TAI
         qX6ySIoVwaWX5egIwsqcydm5B1DkqO7fOR/7fQ0tL0hNyaw1Dx58lc0AC7Fb8vQFA0Ge
         jNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760387958; x=1760992758;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/5lJurlyuxJdcFqWY2oR5aDpcqghsFG3DOY1t5I0NM=;
        b=YqsfHACvD85hLR0SGTmlubUwGjcY1axgyR2Kea7Lxq7TJIAh46lBJkhRWyPoPPuD7k
         UoPfcvEaReZnQRcyF5XPuI9eulhtgoY+2O7K762ttE4avWHwrd3TJ4ZjkwIsj2QONBJp
         ZAcS1MuV+6xJzNe7xK1E8qWT3f6lbnX0xn5KjkrbA6BHJ+GzWZfRn+02PHlXznbM3b4t
         ++3rkCqyD6YOwlusdEE+F7bwXaorcD62JpvTQ0UzlMwLS7OmYAEh5tfLgZI3dh8+KH4I
         hk3MizwV4znN+VsfxRbc31hgcdnOtbTEnJCZMVeB/TMcXIy75CAssda75XSaH8OoYYkR
         baGw==
X-Forwarded-Encrypted: i=1; AJvYcCV1PpD0YsIGG3nnldblDITNDwZJDYlBXWt5V+9d77jS2PaB9EuGN9aAou4GTh+mUkJmXZ7CCCoYCRDtQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfiDAYAO3cyuqP5J8aN0A46zS/Xp686zJXoRxDXl7hQKYQ5STS
	cP4lDxbfrpovqOCWD2AWzWRvhfy9jOiNCfdsuSWYG7EJ6fBOHv1KDq4NNJYT0Ah6LeQ=
X-Gm-Gg: ASbGncuy5LzsF2rX4/7H3FOvyCrMhQbOMKDmgmuSRCzTHLz8oV8ODjPYIwsYKxoD205
	gUGp9FUp3lPsFyz+rIzHZ7uTlkxM6l0MSGlkJmlPH2wo87BOtGR1zfZVrR3QZ0YmYtwiK73mVQq
	w6HRhVMUUB0PcJTJ2+l+ytvZJQyXWUZJ0v82hczGz6i7uFVjxqH4LPoYuY4jEZRIRn/nagxoyfO
	OJAsDVvahEjgjhx0mwpWLzwLJzZQ48zwW8l1z+bSvCjaG9UmWa23h3/KYaXia2ylaHhc1Cd1vBp
	1Ebs5enD7chZozB4QoHQk8dOscon0zkvLMi00rVddOHNmzIFKgoXciBnxDNEehRZYvBA2WDLLms
	LFsfxeNdrm6/yKTZDKT9ozzhrhSGSHBM1LfKVvsNTYzDGrHLyTRP5aX/XAek3FCfPORohlEDL3u
	msjoqh
X-Google-Smtp-Source: AGHT+IGMdD+E2aO2EwT0qAEpmLi1UhygjOb3pvX5IYujCEBYFY1rakmFjq7tZyH5ePG8KKlWBZFcHQ==
X-Received: by 2002:a05:6000:186f:b0:426:d734:1378 with SMTP id ffacd0b85a97d-426d734141bmr5265784f8f.4.1760387958076;
        Mon, 13 Oct 2025 13:39:18 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992dd83dcbsm12522237b3a.83.2025.10.13.13.39.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 13:39:16 -0700 (PDT)
Message-ID: <737baeb0-93cd-4018-9013-c86c662a608e@suse.com>
Date: Tue, 14 Oct 2025 07:09:10 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iomap: add IOMAP_DIO_FSBLOCK_ALIGNED flag
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Cc: "brauner@kernel.org" <brauner@kernel.org>,
 "djwong@kernel.org" <djwong@kernel.org>,
 "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <c78d08f4e709158f30e1e88e62ab98db45dd7883.1760345826.git.wqu@suse.com>
 <cda26765-066d-4e4f-bd8e-83263f1aee82@wdc.com>
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
In-Reply-To: <cda26765-066d-4e4f-bd8e-83263f1aee82@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/13 21:44, Johannes Thumshirn 写道:
> On 10/13/25 11:05 AM, Qu Wenruo wrote:
>> - Remove the btrfs part that utilize the new flag
>>     Now it's in the enablement patch of btrfs' bs > ps direct IO support.
> 
> But then we potentially have code merged without a user. I think it is
> better to have the btrfs patch in the same series and merged via the
> same tree.
> 

It's fine, and in fact that already happened, for the remove_bdev() 
callback.

So I'm more or less fine with that, as long as we have a proper plan to 
add the initial user.

Thanks,
Qu

