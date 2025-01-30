Return-Path: <linux-btrfs+bounces-11168-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7879EA227DE
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2025 04:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4CA8188351E
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2025 03:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EAD54673;
	Thu, 30 Jan 2025 03:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTufAe1A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B4013AA2A
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Jan 2025 03:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738208966; cv=none; b=iWdf957LKOm3PwUrMqm5gqCLwkdtoWRNxLLxucnU/nw4kU40tYWr8GsM7EIowuhrHchxHx1Orp1M5jaYYiWLKynbS+S6nvZWLkWaBOdh6YfjHecmSlLhYiWEsvWMSk4Zaj5D6XWdfL1jBF1kotY6DePimb2f2PLtjPzCsvkL80Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738208966; c=relaxed/simple;
	bh=3pefsXpgssXpDgR77rWEG7m5WZpoVADdqJ5zKGJ6bpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HRNKztIDJqWlvmmsz+jaYi9PWoORK3iefU1uO7bAmTFqvOmbFPi7xQB0y+eVGhpfUDAcFVCmkWmWk9xSOGN8Gbr8BlEWBEUkwJDw6ExIpm0muoIM+CTQKS8h8R1IOek/WIv/LcMA8SyGCy0hu770DlhYC+NwOw7soRWtI7JYphE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTufAe1A; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6dd1962a75bso2793526d6.3
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 19:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738208963; x=1738813763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZdYG7WPWsoTjAQeGngPSwrcgp+lVFWbUzP3isac4pLU=;
        b=hTufAe1A1fVci6v6dRTqqZVJN0wt/7L6negoTilTfdlF0n81XvGEPLcVWkoYWD5oOP
         riu3cXTvELWSt6dlFfOrhaKkBNAt4Y2h5xVZQdOPSly+omlP3OeECwz3phxeNStTrFjC
         hGibqEuov3IdRP76JVoRGcs37uRWGWnRsheRsIuV1CaMm/PjEC1zn6d/DurL3hD5XVJb
         PGN1nXR2Bn1ra2lSQ7h0Usx/MQipmXrg1ly8Zvebf7o8fL5q8m0kdbGMMPTOd4qWLO6h
         9BQslDOgp66pFQzKHyxyi9Q4xYwHcY/nUvYdoeXPlHQPj9/jPw3GFap+rqrTlGferPyR
         eaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738208963; x=1738813763;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdYG7WPWsoTjAQeGngPSwrcgp+lVFWbUzP3isac4pLU=;
        b=uM2tuOIWMaNIHG2PUCvhgl8VoPQNaFuKCGWa+f7GQ0HbNpXY3/ndvF/EsH0+FcF1WL
         +PEmMpXwnWdJCnRHr4O4ydQO4lC0OgDsK5gbhAnV0YjzQJ5YLTOQJhrPu/OzL9WKK0iG
         E+kF5iM1kKP1iojpIvsGtD4LQtHfD5tn+I2rV5iwFBMjQBViSpbUmksrBGySnR/GznkX
         UYIeDxzD1KztRTexB8EBWRf4zh2pP1nMZin+JWwLb+cpHtxw50eQfPwwobKBMxovztGL
         hvpqXHMxHQcZMu8tAG/bAbH1RYZsGSt8HgTSZhXvJ2AeDRUJPISwb6Y8qQfuxDqWjd4m
         cI9Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4OGEJMaATkusLe8n0Linqo6p9xYTRi21lb/Zp4x6B/kv9dkfOXW3K2eZ0i0EuseJ7moDhJQtGD2VjLA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1uHhC9NFO3CwZijL4EQHGyuZiAtckt6hLs8/GfIFA/EWPs2f6
	BO3063XtTvWiqT85E1fkLlGMUWNOs0qwpLXWWLjFYNRVhO3Kf62f14bgtQ==
X-Gm-Gg: ASbGnctaHGNIR1DaNkCKR5mGIIzMQ6wo5BSti9M+RLJo18vFNW2TXdfBgBn1nyjELek
	RrdYhuo52bmyTHy5XokOEdQgYJKcgFKRdCkvHpGytGXqJhiuWP6eEHfWwAEy+rN5dxbpVEMazIP
	zoRuJdN79imGpYwKj7KVBoJwXi7XkWTqD9bky1s8LRoJYE4k/bae4zja6035lKJA0bdKSMPqCcd
	ZcTqZZfj5b6tyXHHIjQA0O7EKsqL3sR6r5pofiWa4ZL7y3Fu9aawomq6wfbx53/d1KXjVg8YBjD
	4T5QNgxvOTb4i7aoOjdVrzxi20tT0uDSX9JNu/5T7ywEzNJkimhCC/XWOuO6BWbl1D5mrOT5tKa
	PIg==
X-Google-Smtp-Source: AGHT+IEmWHZcbjRSweizvurlHrv/Bkk35xwwNG8lCMCfNVGO7jyNdroYsd2aVImgdvOGXGi0wjUNGg==
X-Received: by 2002:a05:6214:412:b0:6d4:211c:dff0 with SMTP id 6a1803df08f44-6e243c9ccdfmr84940056d6.29.1738208963427;
        Wed, 29 Jan 2025 19:49:23 -0800 (PST)
Received: from ?IPV6:2607:fea8:c1df:ffe5:8dbc:1f88:6c7d:4e88? ([2607:fea8:c1df:ffe5:8dbc:1f88:6c7d:4e88])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e254940baesm1984626d6.97.2025.01.29.19.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 19:49:23 -0800 (PST)
Message-ID: <4303fcdd-b417-41dc-a0a7-1e2f7e9788e6@gmail.com>
Date: Wed, 29 Jan 2025 22:49:22 -0500
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Errors found in extent allocation tree or chunk allocation
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <207033eb-6e59-45f1-9ec5-09e63eaa4c70@gmail.com>
 <f404a687-cd6b-4014-b2fc-0f070f551820@gmx.com>
 <ed415d61-fbb2-4a24-850f-db40052111ff@gmail.com>
 <89fb6391-a2e2-411d-abc2-864f563d680e@gmx.com>
Content-Language: fr
From: Nicolas Gnyra <nicolas.gnyra@gmail.com>
In-Reply-To: <89fb6391-a2e2-411d-abc2-864f563d680e@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 2025-01-29 à 18:35, Qu Wenruo a écrit :
> 
> 
> 在 2025/1/30 06:03, Nicolas Gnyra 写道:
>> Le 2024-12-03 à 21:50, Qu Wenruo a écrit :
>>>
>>>
>>> 在 2024/12/4 10:32, Nicolas Gnyra 写道:
>>>> Hi all,
>>>>
>>>> I seem to have messed up my btrfs filesystem after adding a new (3rd)
>>>> drive and running `btrfs balance start -dconvert=raid5 -
>>>> mconvert=raid1c3 /path/to/mount`. It ran for a while and I thought it
>>>> had finished successfully but after a reboot it's stuck mounting as
>>>> read-only. I seemingly am able to mount it as read/write if I add `-o
>>>> skip_balance` but if I try to write to it, it locks up again. I managed
>>>> to run a scrub in this state but it found no errors.
>>>>
>>>> Kernel logs: https://pastebin.com/Cs06sNnr (drives sdb, sdc, and sdd,
>>>> UUID dfa2779b-b7d1-4658-89f7-dabe494e67c8)
>>>
>>> The dmesg shows the problem very straightforward:
>>>
>>>    item 166 key (25870311358464 168 2113536) itemoff 10091 itemsize 50
>>>      extent refs 1 gen 84178 flags 1
>>>      ref#0: shared data backref parent 32399126528000 count 0 <<<
>>>      ref#1: shared data backref parent 31808973717504 count 1
>>>
>>> Notice the count number, it should never be 0, as if one ref goes zero
>>> it should be removed from the extent item.
>>>
>>> I believe the correct value should just be 1, and 0 -> 1 is also
>>> possibly an indicator of hardware runtime bitflip.
>>>
>>> This is a new corner case we have never seen, thus I'll send a new patch
>>> to handle such case in tree-checker.
>>>
>>>> `btrfs check`: https://pastebin.com/7SJZS3Yv
>>>> `btrfs check --repair` (ran after a discussion in Libera Chat, failed):
>>>> https://pastebin.com/BGLSx6GM
>>>
>>> In theory, btrfs should be able to repair this particular error,
>>> but the error message seems to indicate ENOSPC, meaning there is not
>>> enough space for metadata at least.
>>
>> I finally had some time to try out a version of the kernel with your fix
>> (built locally from commit 0afd22092df4d3473569c197e317f91face7e51b) and
>> I can now see the modified error message (see new dmesg contents:
>> https://pastebin.com/t7J5TJ0Z). Unfortunately, apart from that,
>> behaviour seems to be identical to before. `btrfs check --repair` still
>> fails in the exact same way. Is this expected? For some reason I had
>> assumed your change would fix it, but I had forgotten this mention of
>> ENOSPC so is there any chance of getting back into a writable state or
>> should I just reformat the drives?
> 
> For the ENOSPC problem, please provide `btrfs fi usage` output for the
> mount fs.
> 
> I believe with the ENOSPC problem resolved, we can let btrfs check
> --repair to fix the problem.
> 
> Thanks,
> Qu

Thanks for the quick reply! Here's the output of `btrfs fi usage`:

    Overall:
       Device size:                  21.83TiB
       Device allocated:             12.50TiB
       Device unallocated:            9.33TiB
       Device missing:                  0.00B
       Device slack:                    0.00B
       Used:                         11.35TiB
       Free (estimated):              6.89TiB      (min: 3.85TiB)
       Free (statfs, df):             6.78TiB
       Data ratio:                       1.52
       Metadata ratio:                   2.88
       Global reserve:              512.00MiB      (used: 0.00B)
       Multiple profiles:                 yes      (data, metadata, system)

    Data,RAID1: Size:324.00GiB, Used:299.59GiB (92.47%)
       /dev/sdd      324.00GiB
       /dev/sde      324.00GiB

    Data,RAID5: Size:7.88TiB, Used:7.16TiB (90.84%)
       /dev/sdd        3.94TiB
       /dev/sde        3.94TiB
       /dev/sdf        3.94TiB

    Metadata,RAID1: Size:2.00GiB, Used:73.25MiB (3.58%)
       /dev/sdd        2.00GiB
       /dev/sde        2.00GiB

    Metadata,RAID1C3: Size:14.00GiB, Used:8.69GiB (62.08%)
       /dev/sdd       14.00GiB
       /dev/sde       14.00GiB
       /dev/sdf       14.00GiB

    System,RAID1: Size:32.00MiB, Used:48.00KiB (0.15%)
       /dev/sdd       32.00MiB
       /dev/sde       32.00MiB

    System,RAID1C3: Size:32.00MiB, Used:736.00KiB (2.25%)
       /dev/sdd       32.00MiB
       /dev/sde       32.00MiB
       /dev/sdf       32.00MiB

    Unallocated:
       /dev/sdd        3.00TiB
       /dev/sde        3.00TiB
       /dev/sdf        3.32TiB

Thanks,
Nicolas

>>>> I'm currently running btrfs-progs v6.12 but the balance was originally
>>>> run on v5.10.1. Is there any way to recover from this or should I just
>>>> nuke the filesystem and restart from scratch? There's nothing super
>>>> important on there, it's just going to be annoying to restore from a
>>>> backup, and I thought it'd be interesting to try to figure out what
>>>> happened here.
>>>
>>> Recommended to run a full memtest before doing anything, just to verify
>>> if it's really a hardware bitflip.
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> Thanks!
>>>>
>>>
>>
> 


