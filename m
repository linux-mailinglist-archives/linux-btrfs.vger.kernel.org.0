Return-Path: <linux-btrfs+bounces-11170-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01618A2287D
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2025 06:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BDC33A31F9
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2025 05:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECE71714AC;
	Thu, 30 Jan 2025 05:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsPWI3E6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DDD2CAB
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Jan 2025 05:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738214500; cv=none; b=QVVk92NoRBJWlwJugS4aSi7ApYA8Sszf6HxVMUKbx6vS1KbAE1WhVjZ6a66iT8AD5nphhsfqWxJUF76Bkv+uK83ebts18DRJbfx9FanbqT2ApwP1J+bWSQeEh9A97mgG8tL3/BhmEywbh0q18T/voDbigBSIaFbSmYjUnlloky0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738214500; c=relaxed/simple;
	bh=Fd5al5SEjS4GlzkU5iwSIzG9GqHXuO49OYMXIFZyMYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kyEvRC7rz4YAShIlj31iB/3epih2OauF5OYW1qDD17CuaAY5XZlLcg7AktyOc/clApnmp4gFk26DUm4WFZOzw4P8pZBURKMXWVRXV8vjVNupyhwSCOCN1ghc/fMsdPvfo2XJuKpO3P61gzwe8KNK+R27z7WyScrKAXfagfAZv7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsPWI3E6; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b6ed9ed5b9so77321185a.2
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 21:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738214498; x=1738819298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EzZ4eS5BZJvra4VJ/eeyiD9qxFOgnBNbqQosCqunqs4=;
        b=jsPWI3E6vC7NEPSYKTlY9Q+XKRjRVSg9btmRxS73vliFeen09A0PKzP1Q4+LSurOPT
         YbjPDvnqGtFbLr27gywHRQp7OA4hb8jqa9TdaepDWI6TOuIF0vfWrD+gHhGZXqdYIeEF
         o86jC10xIhQz7/N0NhgTC/psKECq1vux6qKG+13o86rnJqtdFmbP4lOdBEQwjngt7u5w
         4M2D0+fi7BMqqwa3KS9/G6xvkRMrTrmhSGa8T9k2P+STiN4qiUbdCguj2RFuWviy8ULR
         OAD8kXvKUx0GJi+j0MzNYK6f+Y1w6laD8t6InEKmIzmbg9m6hQbrtahV1v+84rQUw6Kh
         Cgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738214498; x=1738819298;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EzZ4eS5BZJvra4VJ/eeyiD9qxFOgnBNbqQosCqunqs4=;
        b=LGOMYRGGZvGjTZNkUzotESSZwurddnesaEvfCsJHoi8N6BrUm22uL8mOXVS8DGg+rk
         4uhsheX1lTp2oGv51c7H/BzIf3foZ984cSFXqEmL7KvqU+vPX62kjI/ZAmnGMTCIwvey
         xmIMyDScEOYO6+NmoSwOBGToAzY1hG38wVEIMJjz5WM6EzRsgdms84crFwjoBfZsZW36
         mwe4plqRoyLkHZoOV+2o/3J2ySF9Sp/rFRbKn6MsLEQ/vTiYNRWJuDBkIepcB/vzxCin
         MP4/7IAVEV6ySwqqcKJ+ZulQCB/G77DsfZkO2+U6SCAiH64mwrd+8YctWHrBsRuI2F8f
         BSCg==
X-Forwarded-Encrypted: i=1; AJvYcCVX2HqPkE3YLQj7a5Wp2U1DBk7prY1o4GzozYmp3rerIkyMSyb7u4SJkkY2/Gl2rzOjAavztk/a5hUAbg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVJPLK66r3dAZSDTsQ//Y5cBxFripyt0znOgI13s2pfQzJ1zj4
	ltwQsPmh6gzlZyBDxnW7fcIHRm/BEWGKLJtGXatp7q34Fy8GaaBHm0fF4w1i
X-Gm-Gg: ASbGnctWVhy0cT2RbDUQ3b7kxsZr7uvL8pB/moC4G6GIseUZRO6erf1AmtAXWd1gJHp
	U9LujzGHU0WfvfFyTgZzlZfWfPNAXyUH/EhsPTpWilXDVRhL/etRuNiq0PM4QUpPpKFFU+O6Orn
	yhQB0oqsif63ajjgus9tS6XLKA0CKr2nho2CtMmDvCK9ZdViMf+yodVpHkUm+2YiG7jg9mQZS3h
	SgaMuUCqBWZFDFOIaqS7uJnohy8EHPzDEQL39OY1dtntyIygKO0Vgxa55KFJm15KjWxVauXsMNI
	DQz8JMRAzsBRytYgvlfgLiTj1g2KtubBrowUpb+ebjb+aStX8FYUa2G25J4ngNt8Ve15J2z8RSa
	GpA==
X-Google-Smtp-Source: AGHT+IGYJlqbgQXKgsrg8bELKv+pJWp2FBReSwC0cflFntMkHRendWykz6GFXlyZHfdK62+9BTUbqQ==
X-Received: by 2002:a05:620a:4611:b0:7b7:106a:19a8 with SMTP id af79cd13be357-7bffccdfbe0mr822604985a.22.1738214497649;
        Wed, 29 Jan 2025 21:21:37 -0800 (PST)
Received: from ?IPV6:2607:fea8:c1df:ffe5:8dbc:1f88:6c7d:4e88? ([2607:fea8:c1df:ffe5:8dbc:1f88:6c7d:4e88])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a8bbe3asm39032785a.15.2025.01.29.21.21.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 21:21:36 -0800 (PST)
Message-ID: <c1bc1160-22ac-4104-bbb6-b976dc4e26ed@gmail.com>
Date: Thu, 30 Jan 2025 00:21:36 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Errors found in extent allocation tree or chunk allocation
To: Qu Wenruo <wqu@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
 linux-btrfs@vger.kernel.org
References: <207033eb-6e59-45f1-9ec5-09e63eaa4c70@gmail.com>
 <f404a687-cd6b-4014-b2fc-0f070f551820@gmx.com>
 <ed415d61-fbb2-4a24-850f-db40052111ff@gmail.com>
 <89fb6391-a2e2-411d-abc2-864f563d680e@gmx.com>
 <4303fcdd-b417-41dc-a0a7-1e2f7e9788e6@gmail.com>
 <3f0d8fe5-e631-4c20-a62f-31c22f169324@suse.com>
Content-Language: fr
From: Nicolas Gnyra <nicolas.gnyra@gmail.com>
In-Reply-To: <3f0d8fe5-e631-4c20-a62f-31c22f169324@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 2025-01-29 à 23:19, Qu Wenruo a écrit :
> 
> 
> 在 2025/1/30 14:19, Nicolas Gnyra 写道:
>> Le 2025-01-29 à 18:35, Qu Wenruo a écrit :
>>>
>>>
>>> 在 2025/1/30 06:03, Nicolas Gnyra 写道:
>>>> Le 2024-12-03 à 21:50, Qu Wenruo a écrit :
>>>>>
>>>>>
>>>>> 在 2024/12/4 10:32, Nicolas Gnyra 写道:
>>>>>> Hi all,
>>>>>>
>>>>>> I seem to have messed up my btrfs filesystem after adding a new (3rd)
>>>>>> drive and running `btrfs balance start -dconvert=raid5 -
>>>>>> mconvert=raid1c3 /path/to/mount`. It ran for a while and I thought it
>>>>>> had finished successfully but after a reboot it's stuck mounting as
>>>>>> read-only. I seemingly am able to mount it as read/write if I add `-o
>>>>>> skip_balance` but if I try to write to it, it locks up again. I 
>>>>>> managed
>>>>>> to run a scrub in this state but it found no errors.
>>>>>>
>>>>>> Kernel logs: https://pastebin.com/Cs06sNnr (drives sdb, sdc, and sdd,
>>>>>> UUID dfa2779b-b7d1-4658-89f7-dabe494e67c8)
>>>>>
>>>>> The dmesg shows the problem very straightforward:
>>>>>
>>>>>    item 166 key (25870311358464 168 2113536) itemoff 10091 itemsize 50
>>>>>      extent refs 1 gen 84178 flags 1
>>>>>      ref#0: shared data backref parent 32399126528000 count 0 <<<
>>>>>      ref#1: shared data backref parent 31808973717504 count 1
>>>>>
>>>>> Notice the count number, it should never be 0, as if one ref goes zero
>>>>> it should be removed from the extent item.
>>>>>
>>>>> I believe the correct value should just be 1, and 0 -> 1 is also
>>>>> possibly an indicator of hardware runtime bitflip.
>>>>>
>>>>> This is a new corner case we have never seen, thus I'll send a new 
>>>>> patch
>>>>> to handle such case in tree-checker.
>>>>>
>>>>>> `btrfs check`: https://pastebin.com/7SJZS3Yv
>>>>>> `btrfs check --repair` (ran after a discussion in Libera Chat, 
>>>>>> failed):
>>>>>> https://pastebin.com/BGLSx6GM
>>>>>
>>>>> In theory, btrfs should be able to repair this particular error,
>>>>> but the error message seems to indicate ENOSPC, meaning there is not
>>>>> enough space for metadata at least.
>>>>
>>>> I finally had some time to try out a version of the kernel with your 
>>>> fix
>>>> (built locally from commit 0afd22092df4d3473569c197e317f91face7e51b) 
>>>> and
>>>> I can now see the modified error message (see new dmesg contents:
>>>> https://pastebin.com/t7J5TJ0Z). Unfortunately, apart from that,
>>>> behaviour seems to be identical to before. `btrfs check --repair` still
>>>> fails in the exact same way. Is this expected? For some reason I had
>>>> assumed your change would fix it, but I had forgotten this mention of
>>>> ENOSPC so is there any chance of getting back into a writable state or
>>>> should I just reformat the drives?
>>>
>>> For the ENOSPC problem, please provide `btrfs fi usage` output for the
>>> mount fs.
>>>
>>> I believe with the ENOSPC problem resolved, we can let btrfs check
>>> --repair to fix the problem.
>>>
>>> Thanks,
>>> Qu
>>
>> Thanks for the quick reply! Here's the output of `btrfs fi usage`:
>>
>>     Overall:
>>        Device size:                  21.83TiB
>>        Device allocated:             12.50TiB
>>        Device unallocated:            9.33TiB
>>        Device missing:                  0.00B
>>        Device slack:                    0.00B
>>        Used:                         11.35TiB
>>        Free (estimated):              6.89TiB      (min: 3.85TiB)
>>        Free (statfs, df):             6.78TiB
>>        Data ratio:                       1.52
>>        Metadata ratio:                   2.88
>>        Global reserve:              512.00MiB      (used: 0.00B)
>>        Multiple profiles:                 yes      (data, metadata, 
>> system)
>>
>>     Data,RAID1: Size:324.00GiB, Used:299.59GiB (92.47%)
>>        /dev/sdd      324.00GiB
>>        /dev/sde      324.00GiB
>>
>>     Data,RAID5: Size:7.88TiB, Used:7.16TiB (90.84%)
>>        /dev/sdd        3.94TiB
>>        /dev/sde        3.94TiB
>>        /dev/sdf        3.94TiB
>>
>>     Metadata,RAID1: Size:2.00GiB, Used:73.25MiB (3.58%)
>>        /dev/sdd        2.00GiB
>>        /dev/sde        2.00GiB
> 
> The mixed metadata profile may be the problem.
> 
> Have you tried to convert the remaining 2GiB RAID1 metadata into RAID1C3?
> 
> Or is the problem you're hitting preventing the full conversion to RAID1C3?
> 
> 
> Anyway, it also looks like a bug in btrfs-progs, I'll need to dig deeper 
> to fix it.
> 
> Thanks,
> Qu

Just to make sure, you mean running `btrfs balance start 
-mconvert=raid1c3,soft` right? If so, unfortunately it just triggers 
those same "invalid shared data ref count, should have non-zero value" 
errors then forces the filesystem into read-only mode so I can't get it 
to run.

>>
>>     Metadata,RAID1C3: Size:14.00GiB, Used:8.69GiB (62.08%)
>>        /dev/sdd       14.00GiB
>>        /dev/sde       14.00GiB
>>        /dev/sdf       14.00GiB
>>
>>     System,RAID1: Size:32.00MiB, Used:48.00KiB (0.15%)
>>        /dev/sdd       32.00MiB
>>        /dev/sde       32.00MiB
>>
>>     System,RAID1C3: Size:32.00MiB, Used:736.00KiB (2.25%)
>>        /dev/sdd       32.00MiB
>>        /dev/sde       32.00MiB
>>        /dev/sdf       32.00MiB
>>
>>     Unallocated:
>>        /dev/sdd        3.00TiB
>>        /dev/sde        3.00TiB
>>        /dev/sdf        3.32TiB
>>
>> Thanks,
>> Nicolas
>>
>>>>>> I'm currently running btrfs-progs v6.12 but the balance was 
>>>>>> originally
>>>>>> run on v5.10.1. Is there any way to recover from this or should I 
>>>>>> just
>>>>>> nuke the filesystem and restart from scratch? There's nothing super
>>>>>> important on there, it's just going to be annoying to restore from a
>>>>>> backup, and I thought it'd be interesting to try to figure out what
>>>>>> happened here.
>>>>>
>>>>> Recommended to run a full memtest before doing anything, just to 
>>>>> verify
>>>>> if it's really a hardware bitflip.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>>>
>>>>>> Thanks!
>>>>>>
>>>>>
>>>>
>>>
>>
>>
> 


