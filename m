Return-Path: <linux-btrfs+bounces-10961-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6BCA10058
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2025 06:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C87AC167109
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jan 2025 05:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DEE323355D;
	Tue, 14 Jan 2025 05:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ao8ev7PU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B40D23099D
	for <linux-btrfs@vger.kernel.org>; Tue, 14 Jan 2025 05:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736832609; cv=none; b=DFTCNob3aaer8whAq30SaUEkszgS9ZNtgFp0+dOa5jGraN2KC3mSuzVBg5ceSG+MHvajimrETpnMtvBYx9N688SFP/1LNL3hkpfCEAk31hxHcYWMGx93bRVMkMQLMKpt5C0Mv4ADzhEWv4LwVJWhaG6d2vbbKVyT0VqMA3lywI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736832609; c=relaxed/simple;
	bh=eGS5G6AxdeLIAH1vdEdalOiILaZ0Gxw48MLjCgWjv2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tJSE1ZkR1QngkEzSDhJyymBIa/bGd7bAod3REipehy0i9wDAMcgbRLvrE57q/jvZKJ9AHYfY87gTT6r8ndbyZUQY4MOTnU3/7faswHfbRCeiV+uiJKUg3XSoU9T4/+8iBoBUWsXVqycRwi3qLGeMc1FkPTSj/99hT2KcOCX0/bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ao8ev7PU; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa6c0d1833eso267257066b.1
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jan 2025 21:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736832605; x=1737437405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GVnYR4kCQACEZuBzzXlgrv7kh3HkDdyBq9r/hyb0I3A=;
        b=Ao8ev7PUwENP4sfMsJ7LjODm/aiPYcqzkgDqu0EIxvZjJ9k44pMUcruPaOw1LR7m/s
         Za4EC+h4jAylEplGRzoohrVId26v0zIw32p/tjvPiNJvF2VatXVs5GusOSasUUMgEqfH
         tfLVwfN93BNM10YgE2hxXeOhP8TxIEiqInIZgQJIt30gzOc0scEREQnfbPbMRB9t2YmW
         naaytH+vhjeH/4wfHAE7eht8JANuDJzMicALqvH4F3o8bhSZkAwEOZuRYgWdWBvXJRp8
         ww9OkD8Qmt0dlRZH2X1FZT8AR3FuvcXR+3WR/BcECMs43mc0b3I3LJWUtSpvR8Z2XxWr
         lKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736832605; x=1737437405;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVnYR4kCQACEZuBzzXlgrv7kh3HkDdyBq9r/hyb0I3A=;
        b=bDRSxS5/gkDIcdca7Gns/C5onZ1ahZym3x943ryNTMGaSIZI2Xp1mVGS+NYaAK/lzt
         48HbM3s+8Y7JBlNXI47lQ2ya5iKYBJ2Zxn4RnFpxYCemJeJRK8UY9LBU5Jm1UUOdIIKX
         ZPtryeL+MNFVCMcW9xTH53ZE4J4UgDquexN0kebfgOQjjc+4o690Vm317rBKQ0mb6+2u
         p0LMY+7dd9E/r1RCfBf3wuKcCgqjaOr2VwVvgUvCbnwJCYpX+r8RGtgzUL810cp0mqGc
         ybfuL/z6NEE8xZewMPTJiLfNGZCMGwcJp20tcUmRN3rilQoEm5ak6D5g0fxqC1zsAYW1
         cVkA==
X-Gm-Message-State: AOJu0YxCRTQk0ZGrlofG4zJaS9QXdPW5oLEGc3UPq0EsmekeN7jH3xCe
	3+dLKL7RtJy6ebI9HXCP8j5HRC0qmz77iy0m1jjtx6Dl020g/vwnVuYRAPzhlaV9jhUPrgYkpCz
	w
X-Gm-Gg: ASbGncsUsFKkBpy3O3NO8lhuN3c+DGFBIEkz9qteAqrakEYLfNHq8RpaE5msVR5EPVO
	QQKz9pZX+iZ1dbUmkLRRk4UL5bPB17akcyUd44CgD4EyjvBGxOOVY0qa7fyFcBtO4tJcKeOY/EU
	3LtKpekdPn5ZNwCEMh20+eyPtv7ltStm8KV9FDOYRReqAQG03HwMwHMLIOZn/NmqOH8aMQ7QlwN
	oHCIZ10E+5gHKlue2NYfwjU+sCxKUJ23C1IP3uxLEyjWq7fJaZCWOeMugZB3lEeJEoPbwKz2kfN
	UUch46WM
X-Google-Smtp-Source: AGHT+IELcK5K2/QMD30mDQ3yEcd4FhRr7Wcl0ZJ5/cPgr3fIFAkQv8+C0Gx8I6oJ9HRFPN2wiSyzeA==
X-Received: by 2002:a17:906:4788:b0:aab:9842:71fe with SMTP id a640c23a62f3a-ab2ab6fd650mr2221170466b.13.1736832604288;
        Mon, 13 Jan 2025 21:30:04 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::e9d? (2403-580d-fda1--e9d.ip6.aussiebb.net. [2403:580d:fda1::e9d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a31902b17d5sm7694378a12.37.2025.01.13.21.30.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 21:30:03 -0800 (PST)
Message-ID: <c5c9bce6-070a-4138-8a13-2618a75b3477@suse.com>
Date: Tue, 14 Jan 2025 15:59:59 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: write time tree block corruption detected, forced readonly
To: Jared Van Bortel <jared.e.vb@gmail.com>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
References: <fcc9c66cac45aee144755ee35714d2d358199d25.camel@gmail.com>
 <cd42beff-741d-4b9c-b78d-4244df06d0c3@gmx.com>
 <41deb494a3e661d78cc5f2427356457fa5ab36c8.camel@gmail.com>
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
In-Reply-To: <41deb494a3e661d78cc5f2427356457fa5ab36c8.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/1/14 12:22, Jared Van Bortel 写道:
> On Tue, 2025-01-14 at 07:24 +1030, Qu Wenruo wrote:
>> 在 2025/1/14 07:00, Jared Van Bortel 写道:
>>> Hi all,
>>>
>>> I am using Arch Linux with the latest linux-zen kernel (6.12.9-zen1-
>>> 1-
>>> zen). I saw the below error in dmesg today, and my filesystem went
>>> read-
>>> only. I haven't rebooted the computer yet. This is my root
>>> filesystem.
>>> What should by next steps be in order to get this computer up and
>>> running again?
>>
>> In your particular case, it's a very strong indicator of bad hardware
>> RAM (bitflip).
>>
>> Thankfully the corrupted metadata is rejected before writing to the
>> disk, so your fs should still be fine.
>>
>> So your next step should be run memtest, either memtest86+ as UEFI
>> payload (preferred), or memtester inside Linux (with minimal other
>> program running).
>>
>> After fixing the bad hardware RAM, then I'd recommend to run a "btrfs
>> check --readonly" to verify there is no other problem in the fs.
>> Although tree-checker is doing a very good job, it's impossible to
>> catch
>> all bitflips.
> 
> Thanks for the suggestion. I ran memtest86+ and it found an error fairly
> quickly. I switched to some known good RAM for the time being, and btrfs
> check --readonly reported no errors.

Forgot one thing, you should also try scrub or "btrfs check 
--check-data-csum", as if the bitflip happens in the csum tree/data, it 
will cause csum mismatch and unable to read the data.

But it's a great news that all your metadata is totally fine.

> 
>>> Would it be OK to just reboot and attempt to use it again? Should I
>>> run
>>> any particular commands to further check the integrity of the fs? Or
>>> would it be best to attempt to rebuild the whole fs from backups?
>>>
>>> Not sure if it's relevant, but IIRC this filesystem was created by
>>> doing
>>> a btrfs-send of each subvolume from my previous btrfs disaster
>>> (subject:
>>> "system drive corruption, btrfs check failure") to a new set of
>>> SSDs.
>>> Could that have caused an issue? Is it better to use rsync and lose
>>> reflinks, birth times, etc. than to use btrfs-send to recover from a
>>> corrupted fs?
>>>
>>> Also, I have the usual question of whether this is most likely to be
>>> a
>>> kernel bug, faulty hardware, or user error. And how I might be able
>>> to
>>> identify which file(s) is/are corrupted based on the output.
>>
>> It looks more like hardware problem (unless there is some other kernel
>> bug randomly flipping memory bits).
>>
>> No file is corrupted (at least for this incident). The bad metadata
>> write is rejected by the kernel so no damage is done (by this
>> incident).
> 
> Yep, looks like BTRFS saved me from faulty hardware in this case. I
> wasn't even aware that it could protect against this sort of thing.
> Nice!

Yep, tree-checker is the second best memory tester, the best in the 
Linux kernel. :)

Although originally it's not designed to detect hardware problems but 
only to rule out corrupted metadata.
I'm also surprised by how frequent hardware RAM can/have caused problems 
in the real world.

Thanks,
Qu

> 
>>> Thanks,
>>> Jared
>> [...]
>>> [  +0.000001] 	item 66 key (3148007481344 168 8192) itemoff 13022
>>> itemsize 53
>>> [  +0.000001] 		extent refs 1 gen 380990 flags 1
>>> [  +0.000001] 		ref#0: extent data backref root 260
>>> objectid 68965 offset 407224320 count 513
>>
>> This is the offending bad extent item.
>>
>> Firstly it shows the extent item should have only 1 ref ("extent refs
>> 1").
>> But the inlined one has ref count 513, completely beyond the expected
>> 1 ref.
>>
>> hex(513) = 0x201
>> hex(1)   = 0x001
>>
>> Very obvious bitflip.
>>
>> Thanks,
>> Qu
>>
>> [...]
>>>
>>
> 
> Thanks,
> Jared
> 


