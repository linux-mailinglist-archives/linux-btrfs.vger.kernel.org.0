Return-Path: <linux-btrfs+bounces-16166-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6079FB2D316
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Aug 2025 06:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F3275612A3
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Aug 2025 04:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987202522BA;
	Wed, 20 Aug 2025 04:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAnsRe46"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5AE78F34;
	Wed, 20 Aug 2025 04:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755664617; cv=none; b=gCic286Z2iO4WI+BaAFBDiv9F91xHg2cFR9QarSdart+Ope4STBw4O/ByfnbF6Ux3gwdccY56y9kgsBAAoILQxG7jqGyk8m45jW9HoRewuSxZkJ27ztRWoCbq8ZkZtHrYlJk9sIkuJehl2JIUxHm4wqJbsU0h4Soy/bQe8/BWno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755664617; c=relaxed/simple;
	bh=oGSgSWRQbWUrK6PrC6AlfJTk+airiWaSw7qpja9+mck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DIZJRpdrWwSUFRy19kDhSiMtaa7M7zuaF5AFe9BueFTxxnOwuIUg+X/nHyLeqh7BK5F290PoHKz4htKA8zuDsVWwkzmPyifOza8HjCoVDSLAeAPjFrrV0AWPZ1X6nTrutL2PpHutwvmqQjWhTVXCU8WxpkdMYjorrflpvT/DKIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAnsRe46; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e563b25c4so2331212b3a.0;
        Tue, 19 Aug 2025 21:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755664616; x=1756269416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yHPk0r8vmS5OhHJBMFssV9sLlQqdeHDtah2tqZC8Brw=;
        b=DAnsRe46tQt6eIV9peMY/sw/gvy5tVCXlR/c44Sc6lOym6RdBwBAbZkO/5+lV/zlDX
         9JqW4bcxcr57Rv520EzvKf1/jDxrcLq6thJc1kw+TKH9CeU2ywwgDIGYLLaK9VWJ8IQy
         A0sUnXFBCgtFK5XOdI7vzdbcYggwf9x0r/+TXfnDQakcYug0Gjwk2ZiIR+lHCmGYfY8T
         ITB7fXZp+qJOlxDnCfmQCBlbnBeX3yUhymPZqr2xhxWoe2elLVO6jZzCftfJVmbzl7Cq
         7asgqnsTLgQVpDpsjF00xhza3NAn3vZ5AhNkscCltKrDYRnHmbyRehWLe3G39ARen1bX
         q68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755664616; x=1756269416;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yHPk0r8vmS5OhHJBMFssV9sLlQqdeHDtah2tqZC8Brw=;
        b=VmHtE8qYqdmCmswvHE7qD3Q6tP5X4aXn0iK/Xv2+LVcTkRGJPGrrfDD8dkNM/rxy/E
         Zpq/mT0TEANjPWRg6t6OCNCZnWEEzVh7KlLxL3AMyZxWcbI7B53OzyYeYJr8/x9qW5Q6
         1zYlzBYA06+sjDEC/7HkeHlFgc/prVsP+lXQUcMxVKH99MeBVvNVkFzDZvY+IFw7PoeJ
         7wTNMIxfO4atiAHiK8BX034e7lOaYCryXCTS/XO3hs72X23siJBbikqNq3Wd82VXncDw
         wOa82QzcGTewk9u+VZ3hKfm/lhWzGhwKWzoIRzb/z0cxvOSSYUcrSbDyd4BJ34+Q9Xgc
         YlqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5J6Q5qQVqAl+yhWpAY2o956OZ9sS0Vaeed8mW2WtsXgaKMfXhTrFmQqhBaFbbXoiNi3LgQdyU@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvqg7asKVMXHZh5Zfh+b9hVjHU7x/zmkWn9ZD43PjuzJC6t0z7
	thF6kBnMJi0osg+t40XFLyfFCpMWeYq4RDIiCfkGff2refLTTT+lGwvS
X-Gm-Gg: ASbGncszNOL/IboP69VnwsVuPvdcN7+AwtH6e/j7SZSP2vC0vmQ06WqvSmaszHWKjhW
	YXj/8k9WeuyCL7X3hvyYp6AnYkeriw5mxkiEvmOtTGMGr+JUojqW70gMbsle+tFd3Qd8ykFoA8u
	i8CuRgefPp/obvpRJ6nlOKrfVX1D1QXuckgj5zguyUCZwTjVym7WLOgnokvYXGCRBMuTe1Yu0h1
	emNUPWRf3qOd9Gj6EMV8BQVAyaOoQCN1CCDUSgml6KzadZwfRc9aHQOKk5hgOcWYHqKl4cxodj7
	2oRfEzYyUMnUR8oKTQfRMIgicBvA3eIPcNCY1N4sH3StVCMIbPiRuB5Vox8ugiYB1myN9/yH+Pv
	/aaN8aeKgCnn3yhkk7h7b+WErtpEkUj8j
X-Google-Smtp-Source: AGHT+IEggaNNUK1nSkAbAtXcWKm7coB8byWT5rD+e9r9d3FjZjMGs5RurS8NHd7s/3WXnAWBngUd6g==
X-Received: by 2002:a05:6a21:328e:b0:240:17d2:c004 with SMTP id adf61e73a8af0-2431b9e997fmr2633071637.43.1755664615642;
        Tue, 19 Aug 2025 21:36:55 -0700 (PDT)
Received: from [192.168.0.120] ([49.207.219.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fea78dsm1131648a12.13.2025.08.19.21.36.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 21:36:55 -0700 (PDT)
Message-ID: <38b18de1-dcbe-4084-ac60-1b8dfd74d4b9@gmail.com>
Date: Wed, 20 Aug 2025 10:06:50 +0530
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] generic/274: Make the pwrite block sizes and
 offsets to 64k
Content-Language: en-US
To: Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, ritesh.list@gmail.com,
 ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
 fdmanana@kernel.org, quwenruo.btrfs@gmx.com
References: <cover.1755604735.git.nirjhar.roy.lists@gmail.com>
 <49bd135f95d50fd4b8db41593551b1958ed380a7.1755604735.git.nirjhar.roy.lists@gmail.com>
 <0a10a9b0-a55c-4607-be0b-7f7f01c2d729@suse.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <0a10a9b0-a55c-4607-be0b-7f7f01c2d729@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/20/25 03:39, Qu Wenruo wrote:
>
>
> 在 2025/8/19 21:30, Nirjhar Roy (IBM) 写道:
>> This test was written with 4k block size in mind and it fails with
>> 64k block size when tested with btrfs.
>> The test first does pre-allocation, then fills up the
>> filesystem. After that it tries to fragment and fill holes at offsets
>> of 4k(i.e, 1 fsblock) - which works fine with 4k block size, but with
>> 64k block size, the test tries to fragment and fill holes within
>> 1 fsblock(of size 64k). This results in overwrite of 64k fsblocks
>> and the write fails. The reason for this failure is that during
>> overwrite, there is no more space available for COW.
>> Fix this by changing the pwrite block size and offsets to 64k
>> so that the test never tries to punch holes or overwrite within 1 
>> fsblock
>> and the test becomes compatible with all block sizes.
>>
>> For non-COW filesystems/files, this test should work even if the
>> underlying filesytem block size > 64k.
>>
>> Reported-by: Disha Goel <disgoel@linux.ibm.com>
>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>
> Overall looks good to me.
>
> Although still a minor concern inlined below.
>
> [...]>
>>   # Fill the rest of the fs completely
>>   # Note, this will show ENOSPC errors in $seqres.full, that's ok.
>>   echo "Fill fs with 1M IOs; ENOSPC expected" >> $seqres.full
>>   dd if=/dev/zero of=$SCRATCH_MNT/tmp1 bs=1M >>$seqres.full 2>&1
>> -echo "Fill fs with 4K IOs; ENOSPC expected" >> $seqres.full
>> -dd if=/dev/zero of=$SCRATCH_MNT/tmp2 bs=4K >>$seqres.full 2>&1
>> +echo "Fill fs with 64K IOs; ENOSPC expected" >> $seqres.full
>> +dd if=/dev/zero of=$SCRATCH_MNT/tmp2 bs=64K >>$seqres.full 2>&1
>
> Not sure if using 64K block size to fill the fs is the correct way.
>
> For example on a fs with 4K block size, but at end of filling there 
> are only 60K left.
>
> This will fail the filling as we can not reserve 64K data space anymore.
> But it's not 100% filling the data space either.
> This may not matter that much as in the preallocated filling stage, 
> every operation is still in 64K block size though.
>
> I'd prefer to keep the old 4K as block size (as it's the minimal 
> support one), or use the fs block size for filling.
> This will ensure we really use up all the data space.
>
> Thanks,
> Qu

Okay, makes sense. I will revert it to the older 4k size and send an 
updated version.

--NR

>
>>   _scratch_sync
>>   # Last effort, use O_SYNC
>> -echo "Fill fs with 4K DIOs; ENOSPC expected" >> $seqres.full
>> -dd if=/dev/zero of=$SCRATCH_MNT/tmp3 bs=4K oflag=sync >>$seqres.full 
>> 2>&1
>> +echo "Fill fs with 64K DIOs; ENOSPC expected" >> $seqres.full
>> +dd if=/dev/zero of=$SCRATCH_MNT/tmp3 bs=64K oflag=sync 
>> >>$seqres.full 2>&1
>>   # Save space usage info
>>   echo "Post-fill space:" >> $seqres.full
>>   df $SCRATCH_MNT >>$seqres.full 2>&1
>> @@ -63,7 +63,7 @@ df $SCRATCH_MNT >>$seqres.full 2>&1
>>   echo "Fill in prealloc space; fragment at offsets:" >> $seqres.full
>>   for i in `seq 1 2 1023`; do
>>       echo -n "$i " >> $seqres.full
>> -    dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=4K count=1 
>> conv=notrunc \
>> +    dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=64K count=1 
>> conv=notrunc \
>>           >>$seqres.full 2>/dev/null || _fail "failed to write to 
>> test file"
>>   done
>>   _scratch_sync
>> @@ -71,7 +71,7 @@ echo >> $seqres.full
>>   echo "Fill in prealloc space; fill holes at offsets:" >> $seqres.full
>>   for i in `seq 2 2 1023`; do
>>       echo -n "$i " >> $seqres.full
>> -    dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=4K count=1 
>> conv=notrunc \
>> +    dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=64K count=1 
>> conv=notrunc \
>>           >>$seqres.full 2>/dev/null || _fail "failed to fill test file"
>>   done
>>   _scratch_sync
>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


