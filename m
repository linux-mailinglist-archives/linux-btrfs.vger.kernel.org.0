Return-Path: <linux-btrfs+bounces-16167-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F23F6B2D341
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Aug 2025 07:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 935C3A0067E
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Aug 2025 05:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2F821C9ED;
	Wed, 20 Aug 2025 05:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="al9HKkaQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2511624C5;
	Wed, 20 Aug 2025 05:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755666071; cv=none; b=HEHn7S/pRuytDBbfNUkr3ElZRwYaK8DxPt4ik/gzrlM03H9eYa99LSqd0Z6PqPHxqY3zQqwLAvZ82NnQbGY0zkFZseeWJnIVAncJOH0PFRqTyYqJkyadSZxB7mnzT/AzFwc0+YfFswn+bIjGpGvocJ1O3CvF9EtfKr16OeQK9hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755666071; c=relaxed/simple;
	bh=IQmvmI7pQLnMJ9fhsZ0TC5ag4sT9engjk5AzAPfWwCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pdw60xi4QFLmeQj6wCC4mNOfebK3y1+vtqeJBQI9Z2QFxx4zSnk7WnAVjqbS7AjBlVDKHLdJ6B8EKriCvL2/CNnKFT/AlC8Fb78ouc924hZDw+L1oHAdG/hSMjg6SZsraAQaRPSUL9fQQRvQQZBVnkAyifXAMx48dtBaUsRrlWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=al9HKkaQ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so568122b3a.1;
        Tue, 19 Aug 2025 22:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755666069; x=1756270869; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9mhxFAX1Qa/c5h4OFAhbpVkt8nRHyMbmgVYuQZag1No=;
        b=al9HKkaQzqHcFPT+i8f3kGs11NbmWyFQzBxu5EKgb+5axJ3NBHnpOEPLo42W6yE/j0
         U2PY97GsvOZfSfV4Fq77pXFc+57BSgKlwUYPoYl1h8JxvAmABnF/vKSN8Vjj/j5PUDDH
         S//oQDnnQAftX/ozqra+i7YwWZ+ssF32CdCc0PaPc8P/KDYNlg3a1O71x/c++3KDIH3b
         PXl46FivLI4mQx4uI2doX37P1u+Popx1r7iMKii6ZEkiWxMhMphKr2JQZ129Il9awQ5L
         C3hcJPRxKZrtv5W+J1qFte0mMgSH4qZ9uldeJOrKiRt12gcVaIztutC6mNmRLil1F/TJ
         /Yvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755666069; x=1756270869;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9mhxFAX1Qa/c5h4OFAhbpVkt8nRHyMbmgVYuQZag1No=;
        b=nALtMey5u1G+cr6W8Y+buvLdTyPJjGOM0bbfqazOOzdonLIw4OVO/awYvaZj43r+se
         aB1epMwWRk0plZrP7SS+1SFPsvd8ahR2CvqktwqF5WMeytVRhsInefnZ1PwckiEnprTZ
         YNRlKp2e+Uk+OTFwOICKViBWBK5hWMUC/7sU6rtSVXPTch3lI55BhaCl69fvotA3kNlr
         iPpYpJJj+16AbAkXKGfICluVkHCvtQIB5s2t3PrTOFUGf7tJ5y4M0if5fXiVXutW/d5T
         V7xdZKLKPiEAB5XnJRiksFm5gGw6ZWFYTR3wnVJ8gzz9EVQTpJ6sVu+F4PPY51wHuZo4
         JmeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHpVGHTij+NWSYWTX2VIpo5krKNSp0PxmfmBm6u3kKE2qKeoZVs/7vradi0anb3/2svDE8wKgs@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq3nhrSY78eFtHXjoTUToaYweWhv0xz/FZHDMYLb20yZybq00m
	mYCStoTd2A1jlagjem6rMPeocKrXe1HQ15+nPgiBeQqwzpwTw+P3b3Kc
X-Gm-Gg: ASbGncshebQqTvKEhbsYN/pTF0t+wQtHKA0vDgO6E+YAHa+qZks1z/j9DnrTiikf3l6
	7qF+ftOLUpYKG1mWWslyrjZoz6pm1u9IVI7AG65slVUz2CNaCgTd0PbFCjUhdpThkGBCZ9dpvAR
	qxIy1nDk5JMlDchm1ID4fnccEE6ykLxM7927FRsdg/W+Ia8jB/CM1+y4iBc5CkcGlMglw5C0SoA
	lh/RBx7d7LXAL7hnotE57tveSnYmY7frqol68lDzxleg4TinYTFbBw7KuqjgUXLnBxzEyFAe7fy
	pz92A7oiEKVpNw4nktErlJr3zzO8zMTjZMgBfZW8VmnnsZPLwKXvBuWficG+POROqBAfLxqcg2F
	1h65midISRyMm009qqdy7S81cHy93LOc0
X-Google-Smtp-Source: AGHT+IFPrO/WTMn4senb4drJnrfqdgFafPG7+NsFbHhb0oGEPCNE550A+G8cKVoOo5fSdX0QApPnnQ==
X-Received: by 2002:a05:6a20:258c:b0:243:78a:82c8 with SMTP id adf61e73a8af0-2430d82f262mr6918397637.29.1755666068908;
        Tue, 19 Aug 2025 22:01:08 -0700 (PDT)
Received: from [192.168.0.120] ([49.207.219.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b47640d508esm1203849a12.58.2025.08.19.22.01.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 22:01:08 -0700 (PDT)
Message-ID: <0ca943e2-10fb-42b4-b111-d6f619d7b702@gmail.com>
Date: Wed, 20 Aug 2025 10:30:56 +0530
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
To: Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, ritesh.list@gmail.com,
 ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
 fdmanana@kernel.org, quwenruo.btrfs@gmx.com
References: <cover.1755604735.git.nirjhar.roy.lists@gmail.com>
 <ecdd04bce98bb0d1393289e84cf8913ae10cb222.1755604735.git.nirjhar.roy.lists@gmail.com>
 <26059372-f900-4348-997e-d6c379c685f8@suse.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <26059372-f900-4348-997e-d6c379c685f8@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/20/25 03:59, Qu Wenruo wrote:
>
>
> 在 2025/8/19 21:30, Nirjhar Roy (IBM) 写道:
>> When tested with block size/node size 64K on btrfs, then the test fails
>> with the folllowing error:
>>       QA output created by 563
>>       read/write
>>       read is in range
>>      -write is in range
>>      +write has value of 8855552
>>      +write is NOT in range 7969177.6 .. 8808038.4
>>       write -> read/write
>>      ...
>> The slight increase in the amount of bytes that are written is because
>> of the increase in the the nodesize(metadata) and hence it exceeds
>> the tolerance limit slightly. Fix this by increasing the iosize.
>> Increasing the iosize increases the tolerance range and covers the
>> tolerance for btrfs higher node sizes.
>>
>> Reported-by: Disha Goel <disgoel@linux.ibm.com>
>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>
> Looks good to me.
>
> Just want to add some more analyze for the failure case.
>
> For the test it writes 8M data with 5% tolerance (around 408K) with 
> the total writes.
>
> With 64K block size (and it implies 64K metadata size) for btrfs, it 
> mean we can have at most 7 tree blocks of writes plus two super blocks 
> updated.
>
> Considering the default metadata profile is DUP, doubling the metadata 
> writes, the real limit is only 3 tree blocks.
>
> And when doing fsync, btrfs will create at least 2 new tree blocks, 
> one for the log tree root, and one for the log tree of the subvolume.
>
> This is still inside the tolerance, thus the test case can still pass 
> for a lot of cases.
>
> But if a full transaction commit is triggered, btrfs will need to 
> create at least 3 new tree blocks for root, extent and subvolume tree.
> Depending on the mkfs config, it will increase to 7 tree blocks (free 
> space tree, block group tree, csum tree and uuid tree created at mount).
>
> All are exceeding the tolerance limit.
>
> Doubling the io size will make the tolerance to be 8 tree blocks, 
> covering the worst case of 64K metadata sized btrfs, at least for now.

Thank you for the detailed analysis. I will add this analysis in the 
commit message and address the comment for generic/274[1] and add your 
RBs in the next revision.

A couple of questions for the above explanation:

Doubling the iosize to 16M with 5% tolerance is around 819k. So, with 
64k blocks, it turns out to be 819k/64k = 12. Considering DUP, it should 
be approximately 12/2=6 blocks, but you are saying 8. Can you please 
explain this part a bit?

[1] 
https://lore.kernel.org/all/0a10a9b0-a55c-4607-be0b-7f7f01c2d729@suse.com/

--NR

>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
> Thanks,
> Qu
>
>> ---
>>   tests/generic/563 | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/generic/563 b/tests/generic/563
>> index 89a71aa4..6cb9ddb0 100755
>> --- a/tests/generic/563
>> +++ b/tests/generic/563
>> @@ -43,7 +43,7 @@ _require_block_device $SCRATCH_DEV
>>   _require_non_zoned_device ${SCRATCH_DEV}
>>     cgdir=$CGROUP2_PATH
>> -iosize=$((1024 * 1024 * 8))
>> +iosize=$((1024 * 1024 * 16))
>>     # Check cgroup read/write charges against expected values. Allow 
>> for some
>>   # tolerance as different filesystems seem to account slightly 
>> differently.
>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


