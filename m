Return-Path: <linux-btrfs+bounces-17857-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A86CBE0CB8
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 23:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 024B1487768
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 21:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CBE2F5A11;
	Wed, 15 Oct 2025 21:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NHY5Xt74"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A262EB867
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 21:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760563250; cv=none; b=qdibMa/okTz3KOvg0Jpqlh8ryBT2Y8rHNq+KpGmFQNU+bVxfRL97UdAK6TY+EA/lOhQrBOaZ2OPcYvyAjXuwdvXi//41UJr0OS7xsqTA7XhdU9qglsCbQE1CVkjKH2E0CC7uUlZWKr09fr3s+77RNnIDxDfOpjFgXYoOU1ZoIIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760563250; c=relaxed/simple;
	bh=se/4lWZZqGvAhxShDdGV3iJyb3ZlgTl6iFF1B5pMcS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lopR8MvLCY6k8go8gzHsvz7sEVC1hanNqpqj6nkqmZvy5M0ccZbIpHK9M0GVl/cbZAqpICWLL34O2XCnDvzQ5t9PjG5GhaIQvQT97/4krY4sJQ1Wg1q7uzJ5rg9wEQv7yYsvomynW0GE9IXGNfqW+lbyyTQGgScxyv58YDDvZ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NHY5Xt74; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3f0134ccc0cso33292f8f.1
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 14:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760563246; x=1761168046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5XeWtFJdBnzpqcI1CSQiqp5YZou9FyA2SvMNmjG1T4A=;
        b=NHY5Xt74I72gCJAqMiNovQ5mHk4w6WbLeqBHj/2ljipAzzVDGNQ59pGB9XKIybnJJD
         Bmrm37UezWndh8JNZjM9Lrb/y4xr/N61DSul/+8ReBnsJCNV4OzwfNXiAWv3HeHQXcWL
         2R0zjkz98pTwXW0NLCP3NSqLVTBwpaGymLNxKCrpcqSVC9dGarUdgoA40n0i/nTVCZ1G
         UgnhogBY3KwtJD2pPHBzw4SjTssaofIS4tGpcXa6mzaoMT8vvN4K90advTgcFPp3Ir+H
         kBgtaWzUGn7Q9vDaCsQNo7Nyd4mbDrPOKYfMUNsZ4KdMoUUICiRHKYrlGyh1hNFYsclf
         iDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760563246; x=1761168046;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XeWtFJdBnzpqcI1CSQiqp5YZou9FyA2SvMNmjG1T4A=;
        b=cDiNDZReXCzDIcvo7J5M6GpiFRDKzxVXdwksh7JJ0bXcQQ/rfRtrDgPlterOyua2uI
         GiKer6zpcNCk8Rs94rwi1Hpt5h4Znhx1Ok2+d3KucpinueChkfaKRtzy+2OSiCEDUJ7W
         dEdbAZ1c72S6/9u0a3WsTDp8955i5OL4INnPjJacV0saPB0KbIVJnrIWqu6T1IdNi15m
         z201VuEvO4hUKIPUDGbA5ysPWaYnuOf2hZxwXTfmK/4fzGmSUUjbpmOWKZ3mf3uEnOOL
         CoO9Lt02deR2g0z25eVelc+5D/NsNy2n9jYBueUQOkysc6E/+nqAEaCPsO6/IPdJIHCW
         Z6Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXxiwNUVozFEFOiJqBINsxO1kvA9vABbkQAvXUrdzQtGWHAIZaI6srgflkCQgQOVHEyAkkpVeXsK6sd6w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5KKE8LA8KrNjBke8izboAs62FnpLsv46ZXG+o/OsKqU4/TkcL
	u1zwMb4nKBTfhtYyLU1vL2oj439Zum821RTfleo8Evh8TueymLkZSpHJUcwJFkbAYAQ=
X-Gm-Gg: ASbGncvd1KWfb4N4dKLsy5tMBlHwQzEAvNyX6N/DOu7K46JguuXWu1Zx0CXLATpk4mN
	OirygMud4uEBXxBp2x5fAkWMCI8IgKo/yrRkQJkjwJ6jHfrCnAJ6kYmU8SuHdv4IrXN4LeU9p6N
	LEH79RU1hGc09TQIhC7hKDYdMt07Ofy81WxFgomh5anzJeNTv+kJsb8yN5pSCIjvHX9Eigy5vUY
	IkfTy7t12Vfy8j6uWyPRdblSF1HxeNq8wN8jkP2gm9v4MzPGhXpYJ98UMN7+S14DnCcVUtOMv0w
	bGqDEEgdKqKltOBFtLywBdlURNpAug6KI4hxqvKVEEjjPLOmjzikQaKinTEVuhtA37SY9BRcdeD
	Cd468lXBlADLAWpS/z66V6aQPZJaGs+2NJzCyTQjRu+qM7bjAo9Eh1RaXGgA+ul1GOhJViROrVL
	8dzrd9R1j7bU7RUOj1jFe1nfaAR6RRBJEfkFW0ies=
X-Google-Smtp-Source: AGHT+IF3SYIFjeTD4ulVsqwa511BRzUD5PVE3uNm7GpBpOH1EoqFiXBiDtvUFI4PpK5B4r7iWYqvfA==
X-Received: by 2002:a05:6000:4308:b0:3e7:ff32:1ab with SMTP id ffacd0b85a97d-4266e8dd2bcmr18472879f8f.50.1760563246385;
        Wed, 15 Oct 2025 14:20:46 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b97879fc7sm3696832a91.17.2025.10.15.14.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 14:20:45 -0700 (PDT)
Message-ID: <f7eae184-9b20-4384-a569-bede2e274bfa@suse.com>
Date: Thu, 16 Oct 2025 07:50:41 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] btrfs-progs: fscrypt updates
To: Daniel Vacek <neelx@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 Josef Bacik <josef@toxicpanda.com>,
 Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
References: <20251015121157.1348124-1-neelx@suse.com>
 <84dabbbd-1b7b-4d51-b585-d3dcad3fd88f@gmx.com>
 <CAPjX3FeuNDtzGRH8EGw3WLsTpOiszDdAVJ6Yv=rkkpjv8qSyzQ@mail.gmail.com>
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
In-Reply-To: <CAPjX3FeuNDtzGRH8EGw3WLsTpOiszDdAVJ6Yv=rkkpjv8qSyzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/16 07:49, Daniel Vacek 写道:
> On Wed, 15 Oct 2025 at 23:10, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> 在 2025/10/15 22:41, Daniel Vacek 写道:
>>> This series is a rebase of an older set of fscrypt related changes from
>>> Sweet Tea Dorminy and Josef Bacik found here:
>>> https://github.com/josefbacik/btrfs-progs/tree/fscrypt
>>
>> I'm wondering if encryption (fscrypt) for btrfs is still being pushed.
>> IIRC meta has given up the effort to push for this feature.
> 
> Yeah, I'm trying to finish it. This is part of the effort.

Oh, that's awesome and great to know.

Thanks,
Qu
> 
> --nX
> 
>> Thanks,
>> Qu
>>
>>>
>>> The only difference is dropping of commit 56b7131 ("btrfs-progs: escape
>>> unprintable characters in names") and a bit of code style changes.
>>>
>>> The mentioned commit is no longer needed as a similar change was already
>>> merged with commit ef7319362 ("btrfs-progs: dump-tree: escape special
>>> characters in paths or xattrs").
>>>
>>> I just had to add one trivial fixup so that the fstests could parse the
>>> output correctly.
>>>
>>> Daniel Vacek (1):
>>>     btrfs-progs: string-utils: do not escape space while printing
>>>
>>> Josef Bacik (1):
>>>     btrfs-progs: check: fix max inline extent size
>>>
>>> Sweet Tea Dorminy (6):
>>>     btrfs-progs: add new FEATURE_INCOMPAT_ENCRYPT flag
>>>     btrfs-progs: start tracking extent encryption context info
>>>     btrfs-progs: add inode encryption contexts
>>>     btrfs-progs: interpret encrypted file extents.
>>>     btrfs-progs: handle fscrypt context items
>>>     btrfs-progs: check: update inline extent length checking
>>>
>>>    check/main.c                    | 36 ++++++++++--------
>>>    common/string-utils.c           |  1 -
>>>    kernel-shared/accessors.h       | 43 ++++++++++++++++++++++
>>>    kernel-shared/ctree.h           |  3 +-
>>>    kernel-shared/print-tree.c      | 41 +++++++++++++++++++++
>>>    kernel-shared/tree-checker.c    | 65 +++++++++++++++++++++++++++------
>>>    kernel-shared/uapi/btrfs.h      |  1 +
>>>    kernel-shared/uapi/btrfs_tree.h | 27 +++++++++++++-
>>>    8 files changed, 186 insertions(+), 31 deletions(-)
>>>
>>
> 


