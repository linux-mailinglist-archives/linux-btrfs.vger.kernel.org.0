Return-Path: <linux-btrfs+bounces-16009-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DD9B21E42
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 08:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CB797AF92F
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 06:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B392DECD2;
	Tue, 12 Aug 2025 06:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KI4D1A0z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DD2254B19;
	Tue, 12 Aug 2025 06:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754979980; cv=none; b=jgKCRp5KKUa5bOxBuko5V5pWoWp9aYgOFhv92P+QPT2hf6y0xEY4TcGkYCARzBwOdp7u407Z6beGmzP2gwQn1VgcJhumHr5PdteLiC0qcCSwRDDYbD5vJ+WSAagYoVgnCzibQZey6+/iTwJWZXsiwtXy8irlFDmX9VKnp955/UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754979980; c=relaxed/simple;
	bh=fagAGhD6knNRjCnia45MPVgEmsT25Tj/ySaQCijsYAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NOchbxyYaDkcUahxLHVThHVNEALBEhRc5ZICXNsU3cjCUH9tZaQnjnvDwXyOVn4Nwxjj/PlbGtXmNWEDCBeWOJKXcTa4KV8FEILhZivJrMGmxC9QViPs77UXXgSAMeWKjJtbT25jICHEn9H3pbHGalnvZnFUnKFsOI6cnDkoiWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KI4D1A0z; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76b8d289f73so4754111b3a.1;
        Mon, 11 Aug 2025 23:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754979978; x=1755584778; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z6wwZVI/G5KFWpQUWb0JlFKCIbhA9zNw/i/s8geHaTo=;
        b=KI4D1A0zshLLibNhE3OQyBq39YE6MkJUGc/monDmLJrNkuUiEzu+Dj0kuc4lZEMkul
         s8OgIqwACP9dEAzKRWhjX+JVDS551wzWH3D/6tfLyYrQtzxeXFy4iwiUj72W9Xsu/2SS
         OYIo2H6jm6I03skRgz9RuvPHVhRI4bZpjfoPfRFJyxQI7LESoWtY4ZJnIpN4Bpkj52Up
         JynN9SeMYBPMQnmmEoCjt6K98+qgObOPDP8xeIVvl6XIMIX60TGSt2QS2tcdKkUBOdCP
         e23+14AzLM7ez4CvxCBP6j97KrrAOq0atekd9NQsf8rKqMtM3p9y/Itf8udrv8aNtB0b
         LKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754979978; x=1755584778;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z6wwZVI/G5KFWpQUWb0JlFKCIbhA9zNw/i/s8geHaTo=;
        b=h2pLIM/FEO2xT75U9XVyyUzNIilIxen7qBbDidCj8vbNnQ8uR329+eAhCcq89AtGWf
         py4zN/9LWsqMJUfoQYzGjCEIvXALvoBUKFmNEsondjPHyn0XDmM0AsA+yIvH4oJW72Ax
         0lLMiQ2WL9cCy164exLRS0/dSyNY9JZ18GwOuwtQ1ld0+LmochWtyT5jkzCZzH8/PZpT
         0Gg6VcGn5EDlmH8Hl/8a9O9d/5mwfdZbpOD2KOHveK0TKZvYkdYmFbi0uXg41ge7u5lN
         DKEvoeayqukmNj4/dMGFq7vh8336e87AinsHlnzLmEyrquULi31azK4SYLx7HWF+rdA1
         tdPw==
X-Forwarded-Encrypted: i=1; AJvYcCUSFZE4D2GadhMg7Gis34F9WcXTt80UV7N9OGnCbSYUf5saNkRbHGqc1UddBMddowQulIvs0c3XJh/xXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSa+sN+kWxP+qorMFxILgLr85O/vcTCVVREICJOKgDZd7kA9q1
	yiKHPTqd0dOwgCetIOcZPfLsEG7UKViYozsGIZibZdkqMchuKz/NSMMz
X-Gm-Gg: ASbGncuzZJU8uIXImtMGc5zxmugRURzjliGk74PHwROdIIJ8uMU4k1P7AzUv0E7/9wB
	W6cio6AM7nAhfcPgan0pmFrViX5N5FkEzfXHF7woe0msm/Ina4P8NY6vF6Bhv5eNkUfo9oKGM04
	zNwtIX6+bzvwh2HEVeeH625r8gi/GmpiVzl75SZrKWx1TowymXhlnzlc5xLSZaEZ6y0NS3R8XnS
	DyV0v23aZKi03r5VL8J/WID0IEKv6sdOldiuBA5abTJ7tDVIxTU2sz4eyXM5lfimxvGsHgPavh3
	W750I9Aybz9qcjghS9e6UMU7vEuo95UbkjwpibS9U9iK+HuJRQ4i7KWn/FVceVmqaZ1DcqP/Yxn
	y/9OnG4efKZhkPrd6pwnhaRcwanAIxr6C
X-Google-Smtp-Source: AGHT+IHUB1RxqRuQk/i7gc+6JBrAFY57dk/v+2yaM5d9gvDrHgNaSNErDBkfaSAggd8ZVDL3Jbx6/Q==
X-Received: by 2002:a05:6a00:1821:b0:748:323f:ba21 with SMTP id d2e1a72fcca58-76e0ddf2100mr2843598b3a.1.1754979978153;
        Mon, 11 Aug 2025 23:26:18 -0700 (PDT)
Received: from [192.168.0.120] ([49.207.198.59])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c0e86f3c6sm19417320b3a.5.2025.08.11.23.26.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 23:26:17 -0700 (PDT)
Message-ID: <3e54fad0-70f4-4762-9fc4-229688fa2e9c@gmail.com>
Date: Tue, 12 Aug 2025 11:56:14 +0530
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] btrfs/200: Make this test scale with the block size
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
 ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
 zlang@kernel.org
References: <cover.1753769382.git.nirjhar.roy.lists@gmail.com>
 <ec81b0ed49ebfe203d7923f3886776fb74fbaf32.1753769382.git.nirjhar.roy.lists@gmail.com>
 <CAL3q7H6QxUNCY443AVfwFQ0X3zr6g+Wq=r0Xb3mq0tECEw_yTA@mail.gmail.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <CAL3q7H6QxUNCY443AVfwFQ0X3zr6g+Wq=r0Xb3mq0tECEw_yTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/29/25 12:23, Filipe Manana wrote:
> On Tue, Jul 29, 2025 at 7:24 AM Nirjhar Roy (IBM)
> <nirjhar.roy.lists@gmail.com> wrote:
>> For large block sizes like 64k on powerpc with 64k
>> pagesize it failed because this test was hardcoded
>> to work with 4k blocksize.
> Where exactly is it hardcoded with 4K blocksize expectations?
>
> The test does 64K writes and reflinks at offsets multiples of 64K (0 and 64K).
> In fact that's why the test is doing 64K writes and using only the
> file offsets 0 and 64K, so that it works with any block size.
>
>> With blocksize 4k and the existing file lengths,
>> we are getting 2 extents but with 64k page size
>> number of extents is not exceeding 1(due to lower
>> file size).
> Due to lower file size? How?
> The file sizes should be independent of the block size, and be 64K and
> 128K everywhere.
>
> Please provide more details in the changelog.
> Thanks.

Yes, I think I mis-interpreted the actual issue. I am looking into this. 
For now, I will remove this patch in the next version and once I am 
aware of the actual root cause, I will re-send with a proper fix and an 
explanation.

--NR

>
>> The first few lines of the error message is as follows:
>>       At snapshot incr
>>       OK
>>       OK
>>      +File foo does not have 2 shared extents in the base snapshot
>>      +/mnt/scratch/base/foo:
>>      +   0: [0..255]: 26624..26879
>>      +File foo does not have 2 shared extents in the incr snapshot
>>      ...
>>
>> Fix this by scaling the size and offsets to scale with the block
>> size by a factor of (blocksize/4k).
>>
>> Reported-by: Disha Goel <disgoel@linux.ibm.com>
>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>> ---
>>   tests/btrfs/200     | 24 ++++++++++++++++--------
>>   tests/btrfs/200.out |  8 ++++----
>>   2 files changed, 20 insertions(+), 12 deletions(-)
>>
>> diff --git a/tests/btrfs/200 b/tests/btrfs/200
>> index e62937a4..fd2c2026 100755
>> --- a/tests/btrfs/200
>> +++ b/tests/btrfs/200
>> @@ -35,18 +35,26 @@ mkdir $send_files_dir
>>   _scratch_mkfs >>$seqres.full 2>&1
>>   _scratch_mount
>>
>> +blksz=`_get_block_size $SCRATCH_MNT`
>> +echo "block size = $blksz" >> $seqres.full
>> +
>> +# Scale the test with any block size starting from 1k
>> +scale=$(( blksz / 1024 ))
>> +offset=$(( 16 * 1024 * scale ))
>> +size=$(( 16 * 1024 * scale ))
>> +
>>   # Create our first test file, which has an extent that is shared only with
>>   # itself and no other files. We want to verify a full send operation will
>>   # clone the extent.
>> -$XFS_IO_PROG -f -c "pwrite -S 0xb1 -b 64K 0 64K" $SCRATCH_MNT/foo \
>> -       | _filter_xfs_io
>> -$XFS_IO_PROG -c "reflink $SCRATCH_MNT/foo 0 64K 64K" $SCRATCH_MNT/foo \
>> -       | _filter_xfs_io
>> +$XFS_IO_PROG -f -c "pwrite -S 0xb1 -b $size 0 $size" $SCRATCH_MNT/foo \
>> +       | _filter_xfs_io | _filter_xfs_io_size_offset 0 $size
>> +$XFS_IO_PROG -c "reflink $SCRATCH_MNT/foo 0 $offset $size" $SCRATCH_MNT/foo \
>> +       | _filter_xfs_io | _filter_xfs_io_size_offset $offset $size
>>
>>   # Create out second test file which initially, for the first send operation,
>>   # only has a single extent that is not shared.
>> -$XFS_IO_PROG -f -c "pwrite -S 0xc7 -b 64K 0 64K" $SCRATCH_MNT/bar \
>> -       | _filter_xfs_io
>> +$XFS_IO_PROG -f -c "pwrite -S 0xc7 -b $size 0 $size" $SCRATCH_MNT/bar \
>> +       | _filter_xfs_io | _filter_xfs_io_size_offset 0 $size
>>
>>   _btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/base
>>
>> @@ -56,8 +64,8 @@ $BTRFS_UTIL_PROG send -f $send_files_dir/1.snap $SCRATCH_MNT/base 2>&1 \
>>   # Now clone the existing extent in file bar to itself at a different offset.
>>   # We want to verify the incremental send operation below will issue a clone
>>   # operation instead of a write operation.
>> -$XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 0 64K 64K" $SCRATCH_MNT/bar \
>> -       | _filter_xfs_io
>> +$XFS_IO_PROG -c "reflink $SCRATCH_MNT/bar 0 $offset $size" $SCRATCH_MNT/bar \
>> +       | _filter_xfs_io | _filter_xfs_io_size_offset $offset $size
>>
>>   _btrfs subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/incr
>>
>> diff --git a/tests/btrfs/200.out b/tests/btrfs/200.out
>> index 306d9b24..4a10e506 100644
>> --- a/tests/btrfs/200.out
>> +++ b/tests/btrfs/200.out
>> @@ -1,12 +1,12 @@
>>   QA output created by 200
>> -wrote 65536/65536 bytes at offset 0
>> +wrote SIZE/SIZE bytes at offset OFFSET
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -linked 65536/65536 bytes at offset 65536
>> +linked SIZE/SIZE bytes at offset OFFSET
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -wrote 65536/65536 bytes at offset 0
>> +wrote SIZE/SIZE bytes at offset OFFSET
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>   At subvol SCRATCH_MNT/base
>> -linked 65536/65536 bytes at offset 65536
>> +linked SIZE/SIZE bytes at offset OFFSET
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>   At subvol SCRATCH_MNT/incr
>>   At subvol base
>> --
>> 2.34.1
>>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


