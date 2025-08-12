Return-Path: <linux-btrfs+bounces-16012-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F88B21E53
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 08:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 540AA1A20EFF
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 06:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEF91A9FA2;
	Tue, 12 Aug 2025 06:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jm1yuMEB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838298F54;
	Tue, 12 Aug 2025 06:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754980264; cv=none; b=gP8ZoLJbpSWBv6KoHzNhCMToTBIxfsxDkeabOpWnEYrpKWuL6T9i2uxuXCmtAGLA8rW189j+uUeMoc75zLHC8uN44Mbvgw/DoXibTwGiYmrbeUCW5Zi8PBFfux4S6hGwV0h7W0VOCkLAwCQKzmTzZP43JL/GnA1Bc3O/rSaWx/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754980264; c=relaxed/simple;
	bh=hu8//yQ8KXsbPqP35nxmOdrVKCw22sm7KEGsUoUtKak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P31ObQy6/UewuM4ITlFGHnI1mxMXE9ZXQsWOuSGrdG78OiFrU/ioFchPgUabng2ZFkzaypTn5ltsTisMpn2w/svrCWbQAH/u5Cw5wgMRGfeEgoMG0rtlnUQ8w8lKpJrfkD7P5n3RA9KSwcao4RN8yNOb6AXcc8uu88PG2btBDTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jm1yuMEB; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76b8d289f73so4756594b3a.1;
        Mon, 11 Aug 2025 23:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754980262; x=1755585062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=94cEdyy4r3LyuaJtMXvHbOcGdYOgQSDh8Lbib+DQ8LU=;
        b=jm1yuMEBDzQb5cKN51nHb+QFBH5fi9NniK+UN17xO7vy76mcm3n+ZvknyJpN3hbK7j
         GimQtAXC64zedE/l1l1ag7A7xxHWmY/jjOSMe3VB4MWeVsyPq+u/Wmu/7kQMwVkhfYLt
         B8Argu8gRLSlO5REJNqDOMxlQmuwlCEI68kl57x/JJUWG2IXCPwQhTSSDbCi+9KS3vIq
         T/UJFHx3LniK1oUeoUO6Pif0WTXEn4nKlv3iKPbm7QnN2wQix0RqR10ksst47NxmSZQV
         YaVvzT1gfn4X1Q8446+PJf/NnTabK1eQu+a02g2Xv5XzEMBA21XvJkkynAviCYXvwENx
         MZeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754980262; x=1755585062;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=94cEdyy4r3LyuaJtMXvHbOcGdYOgQSDh8Lbib+DQ8LU=;
        b=uEbaZLkn50W2jvnPSjhO9/wFh9P3xonAKNnstifQ5noBChULh0LzmYPSB37WaCkmCW
         MWiwm7KLGp9xHUrRcvkLJAFeIHH+NjPrp91TCB+q4VPApcoqjjkAlK0to6iHxOuCFHir
         l9tH3beotVrl2MAXRDITFfCQptWVZbZfmR02munrm9meIjWy72VPWB08S5xPgSBNxrT8
         u4zOTX5qJxfm/NuLyoenvP3uWaelW+lMBoParaAKpACZXkTL2EMdaCct2bcqKWTy40tu
         idmwIK74J2E43+w6C6G+Ul4lASqMmDesEXwF0peDR7Ua2lewnTm++ZP36zNzCW7/dTSx
         cHMw==
X-Forwarded-Encrypted: i=1; AJvYcCUKF77DHCFTfKVkSNFEWHTN0uOQUU7SGr8zEDhO+jR7WZSIwvJ++rTyYMBBJrYsVRqqI+VUPfyg@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlb1kKO1KCYvetTCzYDLtADciqNt5/fef9HKPhMogcF6ZePByx
	8plWgYb8EATQ2T6pbVty1EPliraoaXfePApQqSWXzjYT3hvDZwnSxKsn
X-Gm-Gg: ASbGncsXkc4GRVAb49pi4eRXHMnTiaYiLu/QcsNPVBTVRgnkXVeA74pAsUkuTMu6b87
	EXIJ4+oWu2FLhPm3afRvkHqpIqAmHTuQXt8UK7OEInMsGnAi7kgiSCHpb3DL48k1WlyqDWXS8VD
	9S2R93EgnaEt0wlhp1vuawjGUa5Vka648RacQevg0XQgpOhKxpHDQ32CRqoR6bLFfGAlB7TaYsW
	gJGdF9/ME7eFw7jKB9jQagnBLW/nImcIWm2j+jikWTyVVJNtOsxK1zhTF5jLsvPpM1bAv9e5qlW
	YozfGfoOIl6h/kPXDmBCEs/9PN8G0eldoK/BWLpONJ63yGwi8/kjRH5bgfM04YX0TbhBhXI1G9j
	7w5ALsLOXPYiSZYn2mZFGMWaz9JQ1jZyd
X-Google-Smtp-Source: AGHT+IE+PxBsbopNfD6b7fkdUuK+sL1DDdZZj1kEf9hVkwMushN+qWHz5ExRNJYLd2LaMHig+KOHrg==
X-Received: by 2002:a05:6a00:39a1:b0:76b:f260:8614 with SMTP id d2e1a72fcca58-76e0ddf1eddmr3403125b3a.3.1754980261723;
        Mon, 11 Aug 2025 23:31:01 -0700 (PDT)
Received: from [192.168.0.120] ([49.207.198.59])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbf07fsm28585170b3a.86.2025.08.11.23.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 23:31:01 -0700 (PDT)
Message-ID: <98188746-d549-4d4c-840c-3a7c6379866a@gmail.com>
Date: Tue, 12 Aug 2025 12:00:57 +0530
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] generic/274: Make the test compatible with all
 blocksizes.
Content-Language: en-US
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, ritesh.list@gmail.com,
 ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
 fdmanana@kernel.org
References: <cover.1753769382.git.nirjhar.roy.lists@gmail.com>
 <0a9f6e6d2018c6d505be192031aeb9e656b23bd3.1753769382.git.nirjhar.roy.lists@gmail.com>
 <18dbfdb1-57cb-425a-bbfb-bac8a658441d@gmx.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <18dbfdb1-57cb-425a-bbfb-bac8a658441d@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/4/25 10:05, Qu Wenruo wrote:
>
>
> 在 2025/7/29 15:51, Nirjhar Roy (IBM) 写道:
>> On btrfs with 64k blocksize on powerpc with 64k pagesize
>> it failed with the following error:
>>
>>       ------------------------------
>>       preallocation test
>>       ------------------------------
>>      -done
>>      +failed to write to test file
>>      +(see /home/xfstests-dev/results//btrfs_64k/generic/274.full for 
>> details)
>>      ...
>> So, this test is written with 4K block size in mind. As we can see,
>> it first creates a file of size 4K and then fallocates 4MB beyond the
>> EOF.
>> Then there are 2 loops - one that fragments at alternate blocks and
>> the other punches holes in the remaining alternate blocks. Hence,
>> the test fails in 64k block size due to incorrect calculations.
>>
>> Fix this test by making the test scale with the block size, that is
>> the offset, filesize and the assumed blocksize matches/scales with
>> the actual blocksize of the underlying filesystem.
>
> Again, just enlarge the block size from 4K to 64K, then all block size 
> will work.

Okay.

--NR

>
> Thanks,
> Qu
>
>>
>> Reported-by: Disha Goel <disgoel@linux.ibm.com>
>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>> ---
>>   tests/generic/274 | 21 +++++++++++----------
>>   1 file changed, 11 insertions(+), 10 deletions(-)
>>
>> diff --git a/tests/generic/274 b/tests/generic/274
>> index 916c7173..4ea42f30 100755
>> --- a/tests/generic/274
>> +++ b/tests/generic/274
>> @@ -40,30 +40,31 @@ _scratch_unmount 2>/dev/null
>>   _scratch_mkfs_sized $((2 * 1024 * 1024 * 1024)) >>$seqres.full 2>&1
>>   _scratch_mount
>>   -# Create a 4k file and Allocate 4M past EOF on that file
>> -$XFS_IO_PROG -f -c "pwrite 0 4k" -c "falloc -k 4k 4m" 
>> $SCRATCH_MNT/test \
>> -    >>$seqres.full 2>&1 || _fail "failed to create test file"
>> +blksz=`_get_block_size $SCRATCH_MNT`
>> +scale=$(( blksz / 1024 ))
>> +# Create a blocksize worth file and Allocate a large file past EOF 
>> on that file
>> +$XFS_IO_PROG -f -c "pwrite -b $blksz 0 $blksz" -c "falloc -k $blksz 
>> $(( 1 * 1024 * 1024 * scale ))" \
>> +    $SCRATCH_MNT/test >>$seqres.full 2>&1 || _fail "failed to create 
>> test file"
>>     # Fill the rest of the fs completely
>>   # Note, this will show ENOSPC errors in $seqres.full, that's ok.
>>   echo "Fill fs with 1M IOs; ENOSPC expected" >> $seqres.full
>>   dd if=/dev/zero of=$SCRATCH_MNT/tmp1 bs=1M >>$seqres.full 2>&1
>> -echo "Fill fs with 4K IOs; ENOSPC expected" >> $seqres.full
>> -dd if=/dev/zero of=$SCRATCH_MNT/tmp2 bs=4K >>$seqres.full 2>&1
>> +echo "Fill fs with $blksz K IOs; ENOSPC expected" >> $seqres.full
>> +dd if=/dev/zero of=$SCRATCH_MNT/tmp2 bs=$blksz >>$seqres.full 2>&1
>>   _scratch_sync
>>   # Last effort, use O_SYNC
>> -echo "Fill fs with 4K DIOs; ENOSPC expected" >> $seqres.full
>> -dd if=/dev/zero of=$SCRATCH_MNT/tmp3 bs=4K oflag=sync >>$seqres.full 
>> 2>&1
>> +echo "Fill fs with $blksz DIOs; ENOSPC expected" >> $seqres.full
>> +dd if=/dev/zero of=$SCRATCH_MNT/tmp3 bs=$blksz oflag=sync 
>> >>$seqres.full 2>&1
>>   # Save space usage info
>>   echo "Post-fill space:" >> $seqres.full
>>   df $SCRATCH_MNT >>$seqres.full 2>&1
>> -
>>   # Now attempt a write into all of the preallocated space -
>>   # in a very nasty way, badly fragmenting it and then filling it in.
>>   echo "Fill in prealloc space; fragment at offsets:" >> $seqres.full
>>   for i in `seq 1 2 1023`; do
>>       echo -n "$i " >> $seqres.full
>> -    dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=4K count=1 
>> conv=notrunc \
>> +    dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=$blksz count=1 
>> conv=notrunc \
>>           >>$seqres.full 2>/dev/null || _fail "failed to write to 
>> test file"
>>   done
>>   _scratch_sync
>> @@ -71,7 +72,7 @@ echo >> $seqres.full
>>   echo "Fill in prealloc space; fill holes at offsets:" >> $seqres.full
>>   for i in `seq 2 2 1023`; do
>>       echo -n "$i " >> $seqres.full
>> -    dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=4K count=1 
>> conv=notrunc \
>> +    dd if=/dev/zero of=$SCRATCH_MNT/test seek=$i bs=$blksz count=1 
>> conv=notrunc \
>>           >>$seqres.full 2>/dev/null || _fail "failed to fill test file"
>>   done
>>   _scratch_sync
>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


