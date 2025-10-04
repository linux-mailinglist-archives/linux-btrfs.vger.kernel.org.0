Return-Path: <linux-btrfs+bounces-17435-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A575BB923A
	for <lists+linux-btrfs@lfdr.de>; Sun, 05 Oct 2025 00:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A6784E70F6
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Oct 2025 22:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C22A23BD17;
	Sat,  4 Oct 2025 22:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T0h9xKIH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1DC18A6A5
	for <linux-btrfs@vger.kernel.org>; Sat,  4 Oct 2025 22:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759615688; cv=none; b=MdCC99Osu/q8GupsoLz+xREBBOxSWORy6KjdhTy2qH23gbOVQ5xBpBRlYThZ0iM6UO+Llo+buoDmh6VPyJ0yig1o8OkeJBq30M7OJFt7S/rbr5H7XrvrRUY56v75+wPyB11clXXHpLqJNheREpPhUtYhgXHu00HfuQhaAtBjCOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759615688; c=relaxed/simple;
	bh=SjodOtfpZP7rjasFgaGRoH04K1jNbkvligOvWcZbafQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=D0DiI9oCEX14TdbFM8frT6+M4oozXgjG+GAgYbnRmpYqs95Mb7RbUoSHXwBhhSrrNDktEPccYmFM8ybygQSmgps3tKYtHUyZU3ngrvaVoDrXPhMsKvC7ZGJC7EAK3DQFDpzlvMQxqRPTHJCQE5gccZilWcCyOVITpKwPkzXWxxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T0h9xKIH; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-41174604d88so1863930f8f.2
        for <linux-btrfs@vger.kernel.org>; Sat, 04 Oct 2025 15:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759615682; x=1760220482; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T82TGH7k7i/o/p8IC1L3NzNw2oWqA87ib8vZrsrzFmU=;
        b=T0h9xKIHfTLrxVfaDXKdGRgOgXm1/sMMgl3SdnrX50Cjg656aK8j/V7IyMYQVlL1hS
         iXA+zvm00xr/91wd/7IHlbOY6tNyCMzy55vCBz6zJiG1yTtBdVRcRO3g5SY9AJfsOyHE
         P1fOwFapvjbohZqQxY410NnW2AKZb4hU2/bU61LrZY20YJ3lgTqiJvV/qIIjKFpCaJ9f
         FxhyECobaIDS8UjiInzHzwPwsqbaPBKe5og05TyvL1l5D2ijpODnmNpZTsYlCeJOQb3A
         cR1d/1J6F3wlY9DrFG6VG1ihgV+rdbWqens/UyO0BBgT4eOB+rb/WQkG4HRQ1PkJsbrC
         LmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759615682; x=1760220482;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T82TGH7k7i/o/p8IC1L3NzNw2oWqA87ib8vZrsrzFmU=;
        b=fkpGRTETMwb5n/X8sjPuftWQEwzGddCPfl8UgAf4iQN70dTRpxy6DloMldPXiQDbYu
         Ai82e3yMdWH6pqOmDXSnKk9F/V7VaY0LA901NxDZ/s/5eoZX3CWqvO/aB3diK0zOlrz4
         eUcvlBGx98ZrAdR+gPDU8NHIPhumo5o5tf41B26GPcl5sZV23NjUbqjhaO1PEdVRUXEy
         1n63N5uMuMkjZMSApdz28b6jt6vdhFoIxe04UW9OJA8KSyxgZf+3Q0AKdsLVUMOxPa39
         Oc0a5oNdDVlflhfw4lr80HaftszdFxOEJujkvTbLViH3bSgR0R6YpENNKv2PjbKF4VC9
         5+dQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSZ5d1fLv++jGmEok1d0W5dqNtJhEtpD5WfSdlTERKJG78afZHERIJ6IriqKVVGClJkWSt09JhTxLGFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPQ8xJ3UEzHf0bs74Um6cnr45y8xhWYd7AmEYj7h9ecaObW8x8
	scuMf3y2dY9cPCX8CGENge+15IN1GklaWyrmHDsOr6ToYkxZWHekyFgo0sQCHZaTMGYQ9xYkjc0
	w/1kW
X-Gm-Gg: ASbGnctI4aR8J0Fkx2FT2VTZeZ8Pb7ZGoieOA+cWRsVS4BNgYrMALI8UwhY/wbgPRhU
	95K8wTolezuJiAd5FpLN4F/2P1Y5QqmNuFpRxzNIvFaWN9xOWUArlx+1j5rd32sMrwANS+J/UQr
	+NcGx+ZO6tEkeRC7KCFpFzKgCE0UV9iGSPDCkEHLkV40myny+NvTOJJGYVMa93Z2Kd/Jxp7BHg+
	0o1M/CbgN9b61Lmr8q9xmzWsvAXHDqn+vBJa4pn4zVwosxcH35Lap0z5FosYpxvws3yIPJSEPOK
	eICkMLV/ymmzTkDwrAxoq4mUdatoeZdXz6P4Av224IvjZeMgp392iL9SlhjHGeCBPtmcsGsY6hx
	2e7csJ7msQ4p6OLL1Q4hWmLdmvFNDLVlAmeIJHdHixKJQb8p6/DqNybnL7U/lGZHADS+4xQA1jt
	E=
X-Google-Smtp-Source: AGHT+IHYiI8Q41Hd5FDqTF30uHByx8W+Ly2HhvPdNrq+9MWjZ0PnuHpPuPszqEOBkdBqeK9/WcmG1w==
X-Received: by 2002:a05:6000:616:b0:3ec:ea73:a94d with SMTP id ffacd0b85a97d-425671c0be5mr4489758f8f.37.1759615681542;
        Sat, 04 Oct 2025 15:08:01 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6e9d00csm12057928a91.6.2025.10.04.15.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Oct 2025 15:08:00 -0700 (PDT)
Message-ID: <4cda86a1-6012-4200-91a0-9087eb9472da@suse.com>
Date: Sun, 5 Oct 2025 08:37:55 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to remove an unremovable file and directory?
To: =?UTF-8?Q?Henri_Hyyryl=C3=A4inen?= <henri.hyyrylainen@gmail.com>,
 linux-btrfs@vger.kernel.org
References: <33570321-604e-4830-843a-4ed839dfbe83@gmail.com>
 <e7aefcaf-ecb5-492d-9ced-a9b846813bd6@suse.com>
 <5d0cde2f-441e-4007-a6b6-e2aa951befa2@gmail.com>
 <b6273125-86fb-443b-9b2d-3430594f0152@suse.com>
 <f2b72e44-9134-4cc5-99b0-fb51c2673cde@suse.com>
 <afea5a6c-96a6-4928-aa63-275a6c8f8030@gmail.com>
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
In-Reply-To: <afea5a6c-96a6-4928-aa63-275a6c8f8030@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/5 08:23, Henri Hyyryläinen 写道:
>> One extra thing, at the time of the initial "btrfs check --repair", 
>> there is no running dev-replace/balance or whatever running?
>>
>> Although those operations will be automatically paused by unmount,
>> btrfs check is not going to be able to handle some of those paused 
>> operations. 
> 
> Is there a way for me to check that without mounting the filesystem? As 
> far as I could find, none of the balance / scrub commands allow working 
> on an unmounted filesystem. So I couldn't find out if I had any in 
> canceled state.

# btrfs ins dump-tree -t root <device>
> 
> Though, I'm pretty sure I let the last scrub and balance operation I 
> tried to fully complete before starting using the check and repair 
> commands. But I'm not absolutely certain that I didn't try one of those 
> a last time and didn't let it fully complete.
> 
> I'll start that "btrfs check --readonly" command now. And I'll report 
> back once it is done (hopefully by the morning in my timezone).
> 
> - Henri Hyyryläinen
> 
> Qu Wenruo kirjoitti 4.10.2025 klo 23.55:
>>
>>
>> 在 2025/10/5 07:14, Qu Wenruo 写道:
>>>
>>>
>>> 在 2025/10/5 04:13, Henri Hyyryläinen 写道:
>>>> Hello again.
>>>>
>>>> It took over 3 days, but the btrfs check --repair has now completed 
>>>> seemingly successfully. I mostly saw output about the file being 
>>>> placed in lost+found and and directory size being corrected. 
>>>> However, there were some messages about mismatch of used bytes.
>>>>
>>>> Unfortunately it seems like the situation has gotten worse since the 
>>>> repair, because now I cannot mount the filesystem at all. Instead I 
>>>> get an error like this:
>>>>
>>>>> BTRFS error (device sdc): dev extent physical offset 19977638903808 
>>>>> on devid 4 doesn't have corresponding chunk
>>>>> BTRFS error (device sdc): failed to verify dev extents against 
>>>>> chunks: -117
>>>>> BTRFS error (device sdc): open_ctree failed: -117
>>>> Even if I remove that one problematic device physically from my 
>>>> computer, the filesystem still refuses to mount with the same error. 
>>>> Maybe the problems with the device replace are again showing up with 
>>>> the actual size of the hard drive not being used correctly? I cannot 
>>>> try to remove the device slack as I cannot mount the filesystem.
>>>
>>> Nope, this is a different problem, and not related to dev replace.
>>>
>>> Unfortunately btrfs check has not implemented any repair for that.
>>>
>>> Overall if the dev extent is found but not corresponding chunk, it 
>>> should still be fine but some space unavailable.
>>>
>>> But the kernel is overly cautious on chunk tree, as it's a very 
>>> important and basic functionality.
>>>
>>> Please provide the full "btrfs check --readonly" output so that we 
>>> can evaluate and add the missing repair functionality.
>>
>> One extra thing, at the time of the initial "btrfs check --repair", 
>> there is no running dev-replace/balance or whatever running?
>>
>> Although those operations will be automatically paused by unmount,
>> btrfs check is not going to be able to handle some of those paused 
>> operations.
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> I did try to run a repair again, and this time I got a bunch of 
>>>> messages like:
>>>>
>>>>> repair deleting extent record: key [65795546775552,169,0]
>>>>> adding new tree backref on start 65795546775552 len 16384 parent 
>>>>> 65811674234880 root 65811674234880
>>>>> adding new tree backref on start 65795546775552 len 16384 parent 0 
>>>>> root 14499
>>>>> adding new tree backref on start 65795546775552 len 16384 parent 
>>>>> 65791012274176 root 65791012274176
>>>>> adding new tree backref on start 65795546775552 len 16384 parent 
>>>>> 65806385807360 root 65806385807360
>>>>> Repaired extent references for 65795546775552
>>>>> ref mismatch on [65795548233728 16384] extent item 5, found 4
>>>
>>> That's fixing some backref mismatch, which you can ignore unless 
>>> "btrfs check --reaonly" later reports new problems.
>>>
>>>> But the filesystem still refuses to mount with the exact same error. 
>>>> I did not let the repair run entirely as it would have likely taken 
>>>> another 3 days. What should I do? This time I'm not finding any good 
>>>> information on what to do. For now, I've started the repair again, 
>>>> but it doesn't exactly sound like it is even fixing anything now. 
>>>> Still, I'll let it continue. The output so far is:
>>>>
>>>>> [1/8] checking log skipped (none written)
>>>>> [2/8] checking root items
>>>>> Fixed 0 roots.
>>>>> [3/8] checking extents
>>>>> Device extent[4, 19977638903808, 1073741824] didn't find the 
>>>>> relative chunk.
>>>>> super bytes used 49454738989056 mismatches actual used 49454738923520
>>>>> Device extent[4, 19977638903808, 1073741824] didn't find the 
>>>>> relative chunk.
>>>>> super bytes used 49454739005440 mismatches actual used 49454738956288
>>>>> Device extent[4, 19977638903808, 1073741824] didn't find the 
>>>>> relative chunk.
>>>>> super bytes used 49454739021824 mismatches actual used 49454738972672
>>>>> Device extent[4, 19977638903808, 1073741824] didn't find the 
>>>>> relative chunk.
>>>>> super bytes used 49454739005440 mismatches actual used 49454738972672
>>>>
>>>>
>>>> If I was able to somehow remove that one logically corrupt devid 
>>>> from the filesystem, or somehow correct the size, that would 
>>>> hopefully allow me to rebuild from the raid10 data then, but I can't 
>>>> do those with the unmountable filesystem.
>>>>
>>>>
>>>> - Henri Hyyryläinen
>>>>
>>>> Qu Wenruo kirjoitti 30.9.2025 klo 0.52:
>>>>>
>>>>>
>>>>> 在 2025/9/30 02:41, Henri Hyyryläinen 写道:
>>>>>> Hello,
>>>>>>
>>>>>> I hope this is the right place to ask about a filesystem problem. 
>>>>>> Really shortly put, I have a file that both exists and doesn't and 
>>>>>> prevents the containing directory from being deleted. No matter 
>>>>>> what variant of rm and inode based deletion I try I get an error 
>>>>>> about the file not existing, and I also cannot try to read the 
>>>>>> file, but if I try to delete the directory I get an error that it 
>>>>>> is not empty (so the file kind of exists). Trying to ls the 
>>>>>> directory also gives a file doesn't exist error.
>>>>>>
>>>>>> Here's what btrfs check found, which I hope does better in 
>>>>>> illustrating the problem:
>>>>>>
>>>>>>> root 5 inode 25953213 errors 200, dir isize wrong
>>>>>>> root 5 inode 27166085 errors 2000, link count wrong
>>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>>
>>>>>> I've tried everything I've found suggested including a full scrub, 
>>>>>> balance with -dusage=75 -musage=75, resetting file attributes, 
>>>>>> deleting through the find command, and even some repair mount 
>>>>>> flags that don't seem to exist for btrfs.
>>>>>
>>>>> The fs is corrupted, thus none of those will help.
>>>>> I'm more interested in how the corruption happened.
>>>>>
>>>>> Did you use some tools other than btrfs kernel module and btrfs-progs?
>>>>> Like ntfs2btrfs or winbtrfs?
>>>>>
>>>>> IIRC certain versions have some bugs related to extent tree, but 
>>>>> should not cause this problem.
>>>>>
>>>>>
>>>>> The other possibility is hardware memory bitflip, which is more 
>>>>> common than you thought (almostly one report per month)
>>>>>
>>>>> In that case, a full memtest is always recommended, or you will hit 
>>>>> all kinds of weird corruptions in the future anyway.
>>>>>
>>>>>
>>>>> With a full memtest proving the memory hardware is fine, then 
>>>>> "btrfs check --repair" should be able to fix it.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>>
>>>>>> What I haven't tried is a full rebalance with no filters, but I 
>>>>>> did not try that yet as it would take quite a long time and if it 
>>>>>> only moves data blocks around without recomputing directory items, 
>>>>>> it doesn't seem like the right tool to fix my problem. So I'm 
>>>>>> pretty much stuck and to me it seems like my only option is to run 
>>>>>> btrfs check with the repair flag, but as that has big warnings on 
>>>>>> it I thought I would try asking here first (sorry if this is not 
>>>>>> the right experts group to ask). So is there still something I can 
>>>>>> try or am I finally "allowed" to use the repair command? Here's 
>>>>>> the full output I got from btrfs check:
>>>>>>
>>>>>>> Opening filesystem to check...
>>>>>>> Checking filesystem on /dev/sdc
>>>>>>> UUID: 2b4ad16d-e456-4adf-960b-dca43560b98b
>>>>>>> [1/8] checking log skipped (none written)
>>>>>>> [2/8] checking root items
>>>>>>> [3/8] checking extents
>>>>>>> [4/8] checking free space tree
>>>>>>> We have a space info key for a block group that doesn't exist
>>>>>>> [5/8] checking fs roots
>>>>>>> root 5 inode 25953213 errors 200, dir isize wrong
>>>>>>> root 5 inode 27166085 errors 2000, link count wrong
>>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>>> root 14428 inode 25953213 errors 200, dir isize wrong
>>>>>>> root 14428 inode 27166085 errors 2000, link count wrong
>>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>>> root 14451 inode 25953213 errors 200, dir isize wrong
>>>>>>> root 14451 inode 27166085 errors 2000, link count wrong
>>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>>> root 14475 inode 25953213 errors 200, dir isize wrong
>>>>>>> root 14475 inode 27166085 errors 2000, link count wrong
>>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>>> root 14499 inode 25953213 errors 200, dir isize wrong
>>>>>>> root 14499 inode 27166085 errors 2000, link count wrong
>>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>>> root 14523 inode 25953213 errors 200, dir isize wrong
>>>>>>> root 14523 inode 27166085 errors 2000, link count wrong
>>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>>> root 14544 inode 25953213 errors 200, dir isize wrong
>>>>>>> root 14544 inode 27166085 errors 2000, link count wrong
>>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>>> root 14545 inode 25953213 errors 200, dir isize wrong
>>>>>>> root 14545 inode 27166085 errors 2000, link count wrong
>>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>>> root 14546 inode 25953213 errors 200, dir isize wrong
>>>>>>> root 14546 inode 27166085 errors 2000, link count wrong
>>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>>> root 14547 inode 25953213 errors 200, dir isize wrong
>>>>>>> root 14547 inode 27166085 errors 2000, link count wrong
>>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>>> root 14548 inode 25953213 errors 200, dir isize wrong
>>>>>>> root 14548 inode 27166085 errors 2000, link count wrong
>>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>>> root 14549 inode 25953213 errors 200, dir isize wrong
>>>>>>> root 14549 inode 27166085 errors 2000, link count wrong
>>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>>> root 14550 inode 25953213 errors 200, dir isize wrong
>>>>>>> root 14550 inode 27166085 errors 2000, link count wrong
>>>>>>>         unresolved ref dir 25953213 index 7 namelen 33 name 
>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir item
>>>>>>> ERROR: errors found in fs roots
>>>>>>> found 49400296812544 bytes used, error(s) found
>>>>>>> total csum bytes: 48179330432
>>>>>>> total tree bytes: 65067483136
>>>>>>> total fs tree bytes: 12107431936
>>>>>>> total extent tree bytes: 3194437632
>>>>>>> btree space waste bytes: 4558984171
>>>>>>> file data blocks allocated: 76487982252032
>>>>>>>  referenced 60030799097856
>>>>>>
>>>>>> So hopefully if I'm reading things right, running a repair would 
>>>>>> delete just that one file and directory (which itself is a backup 
>>>>>> so I will not miss that file at all)?
>>>>>>
>>>>>> I do not have enough disk space to copy off the entire filesystem 
>>>>>> and rebuild from scratch, without doing something like rebalancing 
>>>>>> all data from raid10 to single and then removing half the disks, 
>>>>>> but I assume that would take at least 4 weeks to process (as I 
>>>>>> just replaced a disk which took like a week).
>>>>>>
>>>>>> As to what originally caused the corruption, I think it was 
>>>>>> probably faulty RAM, because up to to like 3 weeks ago I had one 
>>>>>> really bad RAM stick in my computer where a certain memory region 
>>>>>> always had incorrectly reading bytes. I had seen intermittent 
>>>>>> quite high csum errors in monthly scrubs pretty randomly, which 
>>>>>> thankfully could almost always be corrected so I didn't have any 
>>>>>> major problems even though I had like totally broken RAM in my 
>>>>>> computer for who knows how long. So btrfs was able to protect my 
>>>>>> data quite impressively from bad RAM.
>>>>>>
>>>>>> Sorry for getting a bit sidetracked there, but what should I do in 
>>>>>> this situation?
>>>>>>
>>>>>> - Henri Hyyryläinen
>>>>>>
>>>>>>
>>>>>
>>>
>>>
>>


