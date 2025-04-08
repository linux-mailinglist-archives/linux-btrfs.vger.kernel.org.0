Return-Path: <linux-btrfs+bounces-12896-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2785DA81933
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 01:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AED61BA1F49
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 23:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB6725486E;
	Tue,  8 Apr 2025 23:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G6PW4Tdt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8D21DC075
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Apr 2025 23:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744154199; cv=none; b=D8C9RYzhYnx52WwfueeDu+LQbu0r1YVP6jGSTUdZg7Ak2I6Fd+Eae8VW5X2ql4WwdYFcZ9IISAH8pu1xne9b9cqa7BSz9cLxA6TBtUasRqx89qb4WDMN6tDUqTnTocfgxxMdZx5fdzSRkYe5LHYWeNC6vfkZGA/FRqc2xyOaVYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744154199; c=relaxed/simple;
	bh=PgQbTp0JWFZ2wL7qADX8g2pVKVNT4HVhXMmjoYHMNfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S8pZWVz1PFD6q5PRIIyx+zN377SgozjY/Ag3csK0RdK+0OxhBl5r/usi7qykXaw8PF+PZT/BJyivxPOnTuYlwAhlD05h8ilfOcWxrxn+fJBtWCbnLtzD+t8v0tr9JoI4GTZkhvzVbVXNIb370uVvD4wt5Ihv2CJtLesSSDSk/7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=G6PW4Tdt; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39c266c2dd5so5305098f8f.3
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Apr 2025 16:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744154194; x=1744758994; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O5u3prq7wRcjJPbTVbIzOFpbdGvcCOh4olPTwfcj3b0=;
        b=G6PW4TdtvBZxMzvFYLicc0643ozemw7ZNVWpl2eAdm+DG7hjt9DGkSzpsYX2MDTxny
         YweP5ew6lzkB9mshyAqnYlDTjOfrWA+ilgLUYPa5Pc88YIqcKH7FSvdCY7FzIVXWtTEr
         owFdcA/PA46VOqFMCvi/fkmrsAAtcrQThfMOHC9l5JENT9avvvdfWdji4g6dkgHzOB17
         qWeuSnWTZjMI0rppPYJt+0rvHUGmxX5IIwfRfaznOv+JjlCbnCzjcgO9RACeS83oFap5
         tZmBT4ZDy7ZBziM0dn6j5soqeVwai1k+0egvEiFubmz5Vk1kbJ2XIqaxy49ZrJf99DaL
         LO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744154194; x=1744758994;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5u3prq7wRcjJPbTVbIzOFpbdGvcCOh4olPTwfcj3b0=;
        b=lmYtrMhN9MSUrrjiXSTSMXednMTKDjHmDFGunxI5IdTX8H6HIUXpn9Nno50widyxYX
         8tZrv4uLp3350VWbHah5vJhF0/7M7gSKSOJQc1D6htWkPgRjJRDDv3FKpLlWpWbhvWhY
         buzvvgl5zCPN1azE71aM2NvxKULpX4MPiOhMJI2hqQ0GkeZnueQt3K0WTrUudvw1pAlH
         TePylQuMLadxWB1P17k9jYkfYfnUg4xAJVbPdcHiE4QlNKUhO2Vs3nszyTdaMWXRAvvY
         BGIf7FSGc7JPnkbi1Vux42ISBjrhx0x4xvJnWIXiM1SFIKKpXnaeClviiiNtp0XZiCeB
         Ixfw==
X-Gm-Message-State: AOJu0YzGYa9c8MEzujJ6R9Nvt/YSZnan5N1V7nwEtTSMon2Yl/IpP9XM
	Yj5T/GuM4VdWj1ZWedKNXTHAtY8MEEI/hw7dZJDfFDrsWJCTUia3jHfECJKoS1s=
X-Gm-Gg: ASbGncvoW0bBKHuT8XYwdabVh3g9xuGv4QRlYrou9JeggHVsKJ+ol2V6GWeb+tb/JQB
	Zv7briiIFxfXPGnlsQ7VFgE9BARZotcvTCXaBUUaCtwbwRp/d2Eg7XrNihako1wWvGdSoBGGOZe
	hoNmqLwnmMqvyiugJmSJUfBoo1xb2f2chofBgYn0Im5mylN5HUhqWbQ8MPuGv+npIx9zwwYk97K
	XtDUzN/0Df9zNcxrLQh+WROvKlYo25HeJ50ikSt+vV+4nUNOe6M79Y/hTlZkeQuRmngLjuRUcSd
	ciqTMb8PcKtNpEXN0G0+XYGTBJJalyhHztR+K1dhqCagIyPrvrE+KYstHehC7nFKkT8ptD37
X-Google-Smtp-Source: AGHT+IENWyP7ki64SwwOS+6FrpqhI91ggPl35hUae7R801TeprHq9j5MwZdouJtNONGgUV8RoIl5LA==
X-Received: by 2002:a05:6000:1acd:b0:39c:1257:ccae with SMTP id ffacd0b85a97d-39d87cde0d1mr613674f8f.57.1744154193573;
        Tue, 08 Apr 2025 16:16:33 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3057daada7asm11602082a91.0.2025.04.08.16.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 16:16:32 -0700 (PDT)
Message-ID: <7c07030d-d203-490b-95fb-4f40555e0964@suse.com>
Date: Wed, 9 Apr 2025 08:46:29 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] btrfs: use folio_contains() for EOF detection
To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1743731232.git.wqu@suse.com>
 <6a71b4597a65114b646032648129558fe6bef38d.1743731232.git.wqu@suse.com>
 <20250407183912.GB32661@twin.jikos.cz>
 <313da654-15aa-437a-847d-e125e83df977@gmx.com>
 <20250408231226.GF13292@twin.jikos.cz>
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
In-Reply-To: <20250408231226.GF13292@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/9 08:42, David Sterba 写道:
> On Tue, Apr 08, 2025 at 07:28:58AM +0930, Qu Wenruo wrote:
>> 在 2025/4/8 04:09, David Sterba 写道:
>>> On Fri, Apr 04, 2025 at 12:17:41PM +1030, Qu Wenruo wrote:
>>>> Currently we use the following pattern to detect if the folio contains
>>>> the end of a file:
>>>>
>>>> 	if (folio->index == end_index)
>>>> 		folio_zero_range();
>>>>
>>>> But that only works if the folio is page sized.
>>>>
>>>> For the following case, it will not work and leave the range beyond EOF
>>>> uninitialized:
>>>>
>>>>     The page size is 4K, and the fs block size is also 4K.
>>>>
>>>> 	16K        20K       24K
>>>>           |          |     |   |
>>>> 	                 |
>>>>                            EOF at 22K
>>>>
>>>> And we have a large folio sized 8K at file offset 16K.
>>>>
>>>> In that case, the old "folio->index == end_index" will not work, thus
>>>> we the range [22K, 24K) will not be zeroed out.
>>>>
>>>> Fix the following call sites which use the above pattern:
>>>>
>>>> - add_ra_bio_pages()
>>>>
>>>> - extent_writepage()
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>    fs/btrfs/compression.c | 2 +-
>>>>    fs/btrfs/extent_io.c   | 6 +++---
>>>>    2 files changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
>>>> index cb954f9bc332..7aa63681f92a 100644
>>>> --- a/fs/btrfs/compression.c
>>>> +++ b/fs/btrfs/compression.c
>>>> @@ -523,7 +523,7 @@ static noinline int add_ra_bio_pages(struct inode *inode,
>>>>    		free_extent_map(em);
>>>>    		unlock_extent(tree, cur, page_end, NULL);
>>>>
>>>> -		if (folio->index == end_index) {
>>>> +		if (folio_contains(folio, end_index)) {
>>>>    			size_t zero_offset = offset_in_folio(folio, isize);
>>>>
>>>>    			if (zero_offset) {
>>>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>>>> index 013268f70621..f0d51f6ed951 100644
>>>> --- a/fs/btrfs/extent_io.c
>>>> +++ b/fs/btrfs/extent_io.c
>>>> @@ -221,7 +221,7 @@ static void __process_folios_contig(struct address_space *mapping,
>>>>    }
>>>>
>>>>    static noinline void unlock_delalloc_folio(const struct inode *inode,
>>>> -					   const struct folio *locked_folio,
>>>> +					   struct folio *locked_folio,
>>>
>>> I'm not happy to see removing const from the parameters as it's quite
>>> tedious to find them. Here it's not necessary as it's still not changing
>>> the folio, only required because folio API is not const-clean,
>>> folio_contains() in particular.
>>>
>>
>> Yes, I'm not happy with that either, and I'm planning to constify the
>> parameters for those helpers in a dedicated series.
> 
> Thanks, but don't let it distract you from the more important folio
> changes. I noticed there are missing consts in the page API too, like
> page_offset() or the folio/page boundary like folio_pos() or
> folio_pgoff(). This is can wait, my comment was more like a note to self
> to have a look later.

No worry, as the large folios work is done (at least on x86_64, no new 
regression for the whole fstests run).

Now I only need to wait for the remaining 4 patches before the final 
enablement.

Sure there are still something left for large folios, e.g. data reloc 
inode is still using page sized folios, but that is not urgent either.

So the constification of the MM interfaces can be a good low hanging 
fruit here.

Thanks,
Qu

