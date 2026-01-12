Return-Path: <linux-btrfs+bounces-20394-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 13528D11E03
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 11:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 88B5230055B1
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jan 2026 10:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983582D2493;
	Mon, 12 Jan 2026 10:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AJu/N9VI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345D7248F57
	for <linux-btrfs@vger.kernel.org>; Mon, 12 Jan 2026 10:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768213873; cv=none; b=qy4qneIGayZynXV9zQM8Pt3fcNk+S4BXYE/c5XR9K/M707vnJAx6FbkK1jrTl2ycsaIsiqo2EHuTrnQINftae/xuu2qCOpZ1MsbiXE8wzjwLKL4lN95kWHytIyq/KxeZRM007Jh6PyGoNA8qMkYUTVynKHRZbGNY0Eg9RYZtvf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768213873; c=relaxed/simple;
	bh=APOGepYnxtuuspHBraAn52X8NcrZEqOa5VRl+h6jC5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gePSKVHty6eLc9u49Va9SgAkpOQENZz7yQsTBByBG+3sRokeoKJ4Sb0gtR8XI2MzcxyYueciQUq3akjJmIjXxBTply4Gpjuk0hH1doLo/kc0g7mZdC/FlsbRhQ8U5YpBiTbpM8evX+i8p3I9t3A0ih1Gl/JlJuqzd7v94grENCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AJu/N9VI; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-47d63594f7eso36959545e9.0
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jan 2026 02:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768213869; x=1768818669; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rpwmF3aOzHJT6GBUmmdINU0Mx8RHfbv8urqikQjeTl8=;
        b=AJu/N9VIqVnw/GOsOZqoO6Br0nQkCd+3q2ZxrJpTplrD8SWnBJs8U2SElvCfhKwQ1z
         pnkPM+U8vcKENAikBdvYnrGBz9YpfB5HU3y2haRrUglVDkjlAlhexECDzJoIBZk3Pmyf
         Tx1CEKxH3OYovW1XRQ9dkFXO6NEuAoUWSmU469n72OSDHixFwOLd5gQK2+9Nu9C3U9k+
         Z7gyrYRdlYRAIikmbvm1VlsxSq0bH5HdqK1mbAgPX8Gzi5NRRyQ3VQWyv6Ib3XAICaRC
         dTY5H4OpX01c/9gIKkvvp/zwH7+3FpJKNmf5Jy4/EA1/9IYmsHNoJesNn6c/ssyZbesK
         V+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768213869; x=1768818669;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rpwmF3aOzHJT6GBUmmdINU0Mx8RHfbv8urqikQjeTl8=;
        b=hDifq4T3CvOjsuSZpS2hq6BP60iuzszACnRWhIaPqex1qcXJIfNJdBilyJtWyMuayL
         UCQ4Iuct50vx8Oo8W3igExdAhnJb3e4q+aMAiLxzxmQ7KUXins5yNHxpTeVtYaIcmn0b
         UIryQ4Ov9ZM7sQ3HmGc1QXwTY1HyGvWPRrGBXIP6N+uqQiMwcaOuogKCYG7NIHA8Oekq
         eElBGNDmgLfsWFQERBV39AzvEey2iTC89UxETJOgsv3zWexB0I9HrWv12/xTGhXzWZyr
         hDKpmMPXWG1Depzz8aplomrEnun+44K9wADtDnDuQzG7Rt1SHrpP8KpaRUuim4GY5aQ8
         WSxg==
X-Gm-Message-State: AOJu0Yystd7V92ORVQHymXNKutvDtFw6dL9GFIJ1oV4dv+TAHJnoN+0J
	pGRgzckW1xcuv45a+NdibyuA9tB3tbcs6URjv6u/IRSgAEsq5YuXz5EilYUDqdtEz3g=
X-Gm-Gg: AY/fxX4uORPVWERGBpKinRaL+nvXjScGC/vNQwcxngd6QPVrJA/0BjzHMBj3rrMsikR
	6LWrOJ5dkoFcctJXpVPjBVTmtnP7pKzXoQ7k3LW/Rwu539Kj/vAvbnEPa6eLC3r9gx0pTZSOyJg
	0is62P/+AK4eQNhWVWKsiHYNFEv0NacWbp941UwFGE+I0Yy1mHA2HArDv38ZfXj/kovFaEdxVCC
	LvItuZCWjhpVTYXnsGFFmUad/h82VyUIv3wNgtFCZuqeKqtIaGjPobxbk5glzJ1mNT8Etk+i7mt
	rPjfK+iNetAyckz7SRiAxL628YBfkhSKA/l2H0wcsL2leG+TfCLvE0A57sHROzoGcyWpDinTWoW
	iGeerge4W5+uhlxQ3fryf4c4CzOU/y74vFWOQTCtKyrG45D+6wzrkU2aWoDb33vIoYdgAhAa1zg
	1sszsTqtZ5vUqhEYWRJ38K2nTVWo+Lly9HiMWmZTg=
X-Google-Smtp-Source: AGHT+IHRa48HvbVOBgheIXYw3r0ymaCeUcorwawdmNVvljoFry64/+7ab/6ek3+Dbk8hZRuS62g2kg==
X-Received: by 2002:a05:600c:8b2c:b0:477:76cb:4812 with SMTP id 5b1f17b1804b1-47d849bd639mr186172835e9.0.1768213869498;
        Mon, 12 Jan 2026 02:31:09 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5fb64d68sm4950699a91.12.2026.01.12.02.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 02:31:08 -0800 (PST)
Message-ID: <c075c9c8-0c0a-41f0-958c-c80fda826c05@suse.com>
Date: Mon, 12 Jan 2026 21:01:03 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] btrfs-progs 6.17.1: btrfs check --repair aborts with ASSERT
 in delete_duplicate_records() due to overlapping metadata extent
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CABXGCsN7SjNjnn9BRPXr6OK_aZUxs89RVWyX5HFi=S+Ri3tadA@mail.gmail.com>
 <CABXGCsP1dXnutvM9pUNyZavJTTRpEeJsVNzzyVJqbVasz0=dXg@mail.gmail.com>
 <f6bb03fa-ed85-41ff-b8d9-f89013469e3a@gmx.com>
 <CABXGCsOTTGrMFo08H6xQ5EU0WzbJyOnEqNq46mUPRd5K6KYcjw@mail.gmail.com>
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
In-Reply-To: <CABXGCsOTTGrMFo08H6xQ5EU0WzbJyOnEqNq46mUPRd5K6KYcjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/1/12 20:47, Mikhail Gavrilov 写道:
> On Mon, Jan 12, 2026 at 6:10 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>> This is already a very critical error.
>>
>> Normally I won't recommend to do any write operation (including repair)
>> on it already.
>>
>>>> - hundreds of duplicate extent backrefs in the 17101544xxxxx range
>>>> - multiple inodes in root 5 report "some csum missing"
>>
>> If that's the only problem reported from the subvolume trees, at least
>> you can grab most (if not all) of your data by a "ro,rescue=all" mount.
>>
>>>> - extent tree contains conflicting metadata backrefs
>>>>
>>>> Request
>>>> -------
>>>> Please relax or remove the fatal ASSERT and add a repair path that can
>>>> safely handle/delete overlapping metadata extent records.
>>
>> I'd say it's not that easy, or it will already have been done.
>>
>> The biggest problem of repair is, we have too many factors all combined
>> together so that any seemingly simple operation can even further corrupt
>> the fs.
>>
>> E.g. if extent/free space tree is corrupted, a simple metadata COW may
>> overwrite some existing metadata, further corrupting the fs, even
>> causing more corruptions.
>>
>> That's why current btrfs check --repair is only designed to handle a
>> single error at a time, not really several different ones combined.
>>
>> And unfortunately for your case, it's multiple ones combined.
>>
>>
>> Furthermore, if your system doesn't have ECC memories, it's strongly
>> recommended to run a memtest first to rule out bad memories.
>>
>> Hardware memories has its life limit, especially for DDR4 ones that
>> lacks any kind of ECC, and due to their ages some are already causing
>> problems.
>>
>> My estimation is around one bitflip related report per month on the
>> mailing list, thus it's always recommended to do such check especially
>> when your fs is hitting very bad corruptions.
>>
>> Thanks,
>> Qu
> 
> Hi Qu, hi all,
> 
> Thanks a lot for your reply and the explanation.
> I re-tested the issue with the latest btrfs-progs from git (devel
> HEAD) and the behavior is unchanged: btrfs check --repair still aborts
> with SIGABRT in delete_duplicate_records() after reporting an
> overlapping metadata extent record.
> Reproducer (filesystem unmounted):
> - btrfs check --repair /dev/sda
> It reaches the extents phase, then prints:
> - well this shouldn't happen, extent record overlaps but is metadata?
> [17101544210432, 16384]
> and aborts. Under gdb the abort is in delete_duplicate_records()
> (check/main.c), same as in my original report.
> 
> I fully understand (and agree) with the general recommendation that
> --repair should avoid risky write operations, because a wrong repair
> can make things worse.
> 
> However, I’d like to describe my specific use case, because it’s
> somewhat different:
> - This filesystem is basically a large Steam library / cache. The data
> is not “unique” (can be re-downloaded), but internet bandwidth is the
> bottleneck and re-downloading everything would take a very long time.
> - My practical goal is not perfect data preservation. The goal is to
> get the filesystem back to a writable state even if that implies
> losing (or deleting) a significant amount of corrupted files/metadata.
> Steam can re-fetch missing/corrupted data afterwards.
> 
> So I wanted to ask:
> 1. Is there any existing “best-effort to become writable” path you
> would recommend for a case where data loss is acceptable (e.g. any
> rescue/repair sequence other than btrfs restore / ro,rescue=all)?

Unfortunately no.

I believe the transid mismatch is in the extent tree, which is a very 
critical tree, affecting free space allocation.

If there is anything wrong there, no reliable read-write mount can be 
ensured.

For a fs to work reliably, especially for something as complex as btrfs, 
you need 10^100 things to work, but only one thing (extent tree) to 
break the whole read-write mount.


But as I explained, extent tree is important for RW, but not at all for 
read-only operations.
Thus the recommended "ro,rescue=all" mount should still salvage most of 
your data.
I know this will not be a good situation, because you still need a huge 
disk to back them up.

But I will not even be surprised that 100% of your data can still be 
properly extracted.


> 2. Would it make sense to consider an explicit “I accept data loss”
> mode for btrfs check --repair (e.g. --force / --repair --force), that
> would try to continue past cases like overlapping/conflicting metadata
> extent records by dropping the problematic records/inodes, with very
> loud warnings and an explicit confirmation prompt?

That's back the extent tree corruption problem. We can not handle such 
situation reliably enough unfortunately.

It's not about data loss (and I believe there may even be no data loss), 
it's just we can not repair heavily corrupted extent tree reliable, thus 
can not bring it back to RW mount state.

Thanks,
Qu

> 
> I realize this is dangerous and absolutely not suitable as a default.
> I’m only suggesting it as an explicitly opt-in mode for situations
> like mine where formatting is already an acceptable outcome, and the
> only reason to try is to save time/bandwidth by keeping whatever
> remains readable.
> 
> The btrfs-image and logs/backtrace are still available at the same
> location referenced in the original email, and I can provide any
> additional debugging output if needed.
> 
> Thanks again for your time and for maintaining btrfs.
> 


