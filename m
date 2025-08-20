Return-Path: <linux-btrfs+bounces-16170-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDC0B2D598
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Aug 2025 10:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 956171B632E1
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Aug 2025 08:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06602D8DCF;
	Wed, 20 Aug 2025 08:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCHTwN9e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985852AE84;
	Wed, 20 Aug 2025 08:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755676849; cv=none; b=eCaQr9CiVx8ssicchXRXkGzQWMsjHMr3SAHJWSsQGLUpoYXPP/rDp7ohI/OH5fWoQXvQ06oGL6TzNnf4dFkgVcrNbtbHwj3ZiAsqTZnwoYcrelM7PMXRFhXgeb3d8D/FUafHF839rucJNMyBtPV8VIsxkbWymBB/zvEBi2bCiLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755676849; c=relaxed/simple;
	bh=O5nYnIW1RhZMo3UrajK2TFXyvxHyh/iv8zSp+XSEJFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r6BDnbYxS58DccQcTOaCovhLFfJZvJWoRC1xR8Dd+BdUZ71XIr2bL15EWGJ6z7o1gyfn7QqJMg43jcuF/CNFVnZw9Ctw/ylQ1pqnbEHynE5hjo6e1BaFeMMmT8eTqnrBZW6QoVw7YDy/Tgd3D4bdCrof06HxtVBi/2uqJ+Prh/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCHTwN9e; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b471aaa085aso328571a12.0;
        Wed, 20 Aug 2025 01:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755676847; x=1756281647; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QsqOccgviqOt0oK6lAIrsuf2IAuGX8CrAgQAggNkO5Y=;
        b=TCHTwN9ek8F/ErrM4Aj2iRZ20oM8nQLVpz2N57DaogUuMiuvN65eg37QUFp05IoA9Q
         wLdUCZ4u7ch+NO4EJr1lREtHDtCqBZ54fkPo67ohkGpF2IasRmvTDmVXUQPfv+Hj/l/y
         Cgs8CjXzkn8sE1mRcoOlfeuYpywgBwYCAXUIY5WxtKmUPsTrNZReKue816HnW7kQ7wPg
         dizE46vAFPt7RQHwwt0y5yn1diN4lKbtjTdaqXbJ+Ld+87CfJJWkDk3ttXGo0C9kqRmO
         0VXbd2e1d7s+W/x0ywsYWSNzeagD9S2eitwmVcOfdtgljF+E5sh3pPFJ2zAwh8igVGWM
         pvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755676847; x=1756281647;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QsqOccgviqOt0oK6lAIrsuf2IAuGX8CrAgQAggNkO5Y=;
        b=kDVQ+uHQFh56+5/mWCd/YJNSzvn3aQhA7NfPnONnpPqCo4Nzxt/3Vl2HrlXb/DMrpF
         /TAOXmu8FekXgq77yXIUZNXIGTmihlgkM6EKUFH7C/+gERpHkuntJiZn49zYftMjSe1+
         JqKHQ3fyQwdqctSEdcsEyxAiMyO88LGBzgwZGClq88R4hCvg79PV+AoSm7GL3yutQxgG
         L4GKAxqF55xKPTcMPa8vqz7pdjnqOFvXkj5o/s5a5Ntb1/1FdSxj96BG2YQ69s56kr/6
         OS6LRgyNPx/cDDV2alqCarp9TaAumHe6ETbnCv3QBXoBv/+rGOGg248wSxOYSJpm8e0c
         38Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWmHZhXmWdi4+S1mqh96xf2DEi9AgMm1uD85o8tmxn7vo1ud84piqeU6FM4qKRywJ5dCxwgVaTH@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7KQmEBf09cqqnukh/iqeugxQ0DQXO1ft19HzxBLHb2J+z5T1Q
	UwqgG9OghxCq0EpGwwJC62BE5WSWzMEwC0Musalx18rMnUM7D45zSrUj
X-Gm-Gg: ASbGncuAe22Kl387nM5ualKN6BDKQ/qdpdlgnPsSv0xZcbbLTTaROZiwMEPt3k9Ieya
	5vqaVfoKNxpohdLfgq9cBaxSAQ3+mIlvh2M0hMJmTNh4oDK6xy20sDWcb0YW8wVNCVPCSGTNx0D
	nwp3J9iU8f4UeL4jaURnYDV/zFPAsvjwaE3za1MzSU2UaqBRHE7u95flP5rr6RRqmecjSKjRaa0
	NrgBF2PqB6567fiEWTt5pEIrm9j0jzwpsElR2W31seOww51AV3HQPF4CyzTD7CMxRd1plZfZPN4
	ml7DzbLnU4fndBjxvQCRxWVzzAIFq9i+F5cLdFrn38BH/Z1KyBW+wCN47V9gu811MYudh/LIhoO
	a1jy3Kd0AlpjbRdG9mtkZcup5yRKwXv8J
X-Google-Smtp-Source: AGHT+IEV+8V4SNJ34jId797d6LuX/Ph7INMFL67yXO9MHBjH1zgOeYtHsQ1GmSrdO3Jv2/BfSajsxQ==
X-Received: by 2002:a17:902:cecb:b0:240:8381:45b9 with SMTP id d9443c01a7336-245ee00fb33mr34241415ad.8.1755676846784;
        Wed, 20 Aug 2025 01:00:46 -0700 (PDT)
Received: from [192.168.0.120] ([49.207.219.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4e9fe7sm18505035ad.112.2025.08.20.01.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 01:00:46 -0700 (PDT)
Message-ID: <8f2d162f-8110-4e13-9f83-45314668e975@gmail.com>
Date: Wed, 20 Aug 2025 13:30:41 +0530
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] generic/563: Increase the iosize to to cover for
 btrfs
Content-Language: en-US
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
 fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, ritesh.list@gmail.com,
 ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
 fdmanana@kernel.org
References: <cover.1755604735.git.nirjhar.roy.lists@gmail.com>
 <ecdd04bce98bb0d1393289e84cf8913ae10cb222.1755604735.git.nirjhar.roy.lists@gmail.com>
 <26059372-f900-4348-997e-d6c379c685f8@suse.com>
 <0ca943e2-10fb-42b4-b111-d6f619d7b702@gmail.com>
 <fa0dc9e3-2025-49f2-9f20-71190382fce5@gmx.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <fa0dc9e3-2025-49f2-9f20-71190382fce5@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/20/25 11:15, Qu Wenruo wrote:
>
>
> 在 2025/8/20 14:30, Nirjhar Roy (IBM) 写道:
>>
>> On 8/20/25 03:59, Qu Wenruo wrote:
>>>
>>>
>>> 在 2025/8/19 21:30, Nirjhar Roy (IBM) 写道:
>>>> When tested with block size/node size 64K on btrfs, then the test 
>>>> fails
>>>> with the folllowing error:
>>>>       QA output created by 563
>>>>       read/write
>>>>       read is in range
>>>>      -write is in range
>>>>      +write has value of 8855552
>>>>      +write is NOT in range 7969177.6 .. 8808038.4
>>>>       write -> read/write
>>>>      ...
>>>> The slight increase in the amount of bytes that are written is because
>>>> of the increase in the the nodesize(metadata) and hence it exceeds
>>>> the tolerance limit slightly. Fix this by increasing the iosize.
>>>> Increasing the iosize increases the tolerance range and covers the
>>>> tolerance for btrfs higher node sizes.
>>>>
>>>> Reported-by: Disha Goel <disgoel@linux.ibm.com>
>>>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>>>
>>> Looks good to me.
>>>
>>> Just want to add some more analyze for the failure case.
>>>
>>> For the test it writes 8M data with 5% tolerance (around 408K) with 
>>> the total writes.
>>>
>>> With 64K block size (and it implies 64K metadata size) for btrfs, it 
>>> mean we can have at most 7 tree blocks of writes plus two super 
>>> blocks updated.
>>>
>>> Considering the default metadata profile is DUP, doubling the 
>>> metadata writes, the real limit is only 3 tree blocks.
>>>
>>> And when doing fsync, btrfs will create at least 2 new tree blocks, 
>>> one for the log tree root, and one for the log tree of the subvolume.
>>>
>>> This is still inside the tolerance, thus the test case can still 
>>> pass for a lot of cases.
>>>
>>> But if a full transaction commit is triggered, btrfs will need to 
>>> create at least 3 new tree blocks for root, extent and subvolume tree.
>>> Depending on the mkfs config, it will increase to 7 tree blocks 
>>> (free space tree, block group tree, csum tree and uuid tree created 
>>> at mount).
>>>
>>> All are exceeding the tolerance limit.
>>>
>>> Doubling the io size will make the tolerance to be 8 tree blocks, 
>>> covering the worst case of 64K metadata sized btrfs, at least for now.
>>
>> Thank you for the detailed analysis. I will add this analysis in the 
>> commit message and address the comment for generic/274[1] and add 
>> your RBs in the next revision.
>>
>> A couple of questions for the above explanation:
>>
>> Doubling the iosize to 16M with 5% tolerance is around 819k. So, with 
>> 64k blocks, it turns out to be 819k/64k = 12. Considering DUP, it 
>> should be approximately 12/2=6 blocks, but you are saying 8. Can you 
>> please explain this part a bit?
>
> My bad, wrong calculation.
>
> The original 8M tolerance is only for 6 tree blocks, with DUP it 
> reduced to 3. Thus a full commit transaction will always fail the 
> tolerance check.
>
> Doubled to 16M iosize, the tolerance is exactly what you said, 12 tree 
> blocks not 16, and with DUP into consideration it's 6.
>
> With 6 tree blocks tolerance, it's borderline for a full commit 
> transaction.
>
> The recent default mkfs config means 5 tree blocks (root, extent, 
> subvolume, csum and free space), and with incoming new default bgt 
> free it will be exactly at the boundary, but should still pass for now.
>
Okay, it makes sense now. Thank you for the detailed explanation.

--NR

> Thanks,
> Qu
>
>
>>
>> [1] https://lore.kernel.org/all/0a10a9b0-a55c-4607- 
>> be0b-7f7f01c2d729@suse.com/
>>
>> --NR
>>
>>>
>>> Reviewed-by: Qu Wenruo <wqu@suse.com>
>>>
>>> Thanks,
>>> Qu
>>>
>>>> ---
>>>>   tests/generic/563 | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/tests/generic/563 b/tests/generic/563
>>>> index 89a71aa4..6cb9ddb0 100755
>>>> --- a/tests/generic/563
>>>> +++ b/tests/generic/563
>>>> @@ -43,7 +43,7 @@ _require_block_device $SCRATCH_DEV
>>>>   _require_non_zoned_device ${SCRATCH_DEV}
>>>>     cgdir=$CGROUP2_PATH
>>>> -iosize=$((1024 * 1024 * 8))
>>>> +iosize=$((1024 * 1024 * 16))
>>>>     # Check cgroup read/write charges against expected values. 
>>>> Allow for some
>>>>   # tolerance as different filesystems seem to account slightly 
>>>> differently.
>>>
>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


