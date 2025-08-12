Return-Path: <linux-btrfs+bounces-16010-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2B4B21E4B
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 08:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B35B5033DA
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 06:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93002DECD6;
	Tue, 12 Aug 2025 06:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MK5mitQw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC1C254B19;
	Tue, 12 Aug 2025 06:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754980070; cv=none; b=llw+lIoflmX7MNINngUlVLpR4s7hAJKW8ClMQbLiENfjDQowR5K69UAGaHdDXPq28Xa/k+3YXfcQQFmFEIFC/uDPThlS3kCCACYi1hI5XboufILQmCVKVgXd5bQaZ1pSmTVkECEJhB3na9hIMIy1CXTFFQln85JwYgXVYTQDZOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754980070; c=relaxed/simple;
	bh=yOw8Lc1RcNDVf0Uy83lnCZH3TuwhGY2w7A4jjhSnZtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXERw5qSahnYvC4vFi2ZppRLJVwp/IKwAuy8ZIIxJGjYR1G289w+u+s/Ppu6ErL67n6Ro2PHgpanxFRpJMR539Eqt4QjH4wvXHLMRWyKvtJcCHopV70tmNAHFkvZUK2S489ZZ9eMnapheQPneuIwJuXVA3uSuN0VriKCn/ofXdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MK5mitQw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24306318aeeso157815ad.1;
        Mon, 11 Aug 2025 23:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754980068; x=1755584868; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sHCuaYoVgPzLxVGTDw0inOk/RByubuRCOCFtbPBAG/Y=;
        b=MK5mitQwa4OsET0BwoxYUOzsF/oTy7uIz4roAeJ5qDoL7TdZCzoMQGhiHvyYHPjhKD
         WQpHY5pOYeiW/usLpAodZGy6jg/CEmRsyPqgymb1CX5J7G9N1o0AKJ1ABVOEQ7THxxlo
         9hpRsQpEjgAFayqOqeS2tz9KFacKx/YHrNzCrmqnS+WJgwvj+8w0V0W6hLz3EQeWGNLO
         xm5ZH9nD8MzOL8c1M0JNvIe0DA34nIrCqllKXgpufQOPViEYIlrWJdTGUfWKwapLCuwt
         iA8P1iaNrKy2bMEVE6wlmmDui6o2J6eOa4jydplHChIf3SQBqwmhlk9ZEHyeP7XQs42L
         j49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754980068; x=1755584868;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sHCuaYoVgPzLxVGTDw0inOk/RByubuRCOCFtbPBAG/Y=;
        b=SfUg1HFMtTyYbuqlk/liCfQ93st+lz13jpFQK6wIwX18Yy5Ezel44MQ8IChEa6jPv5
         WAbkgKa6hO/Yr8uH+E0vTifP94GD1T9rzWTRH91E8fBFd9V4TtBBpKUmTneA/7hoGf2+
         MG9u6YZfzSNesE1k8BMWK+b6n5yoBGhykAQSiITUFuYW03e6hmwMMytRg48EWqRDA6gf
         frbmFSlTSS4lykE1q/7yU16GiSmzNUgWawPRf0saDFZi+zjtSh3yHG5m+rnnL+zCTGxt
         TqqCpFhUvmuD4UEfO9mHbKEM5W/7ZDecTZyIYZYJp6aozBBlzUdUJF3usehGmzQ+QUka
         Beiw==
X-Forwarded-Encrypted: i=1; AJvYcCXNqZz6xDnYQk4+NUu7UQlprIk9iZWsv8zR49MBOC0ZtfQ8QQ56H+O7wcD+CzDSqWCvdU7h//HZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzL1ZJNaJ5fATM3kKFq7lVhiPMCgnUqAYMN9e4aYK1aDeB7jQ8W
	tX0zJwQdiSjnK1VIKCScNf4ufUxXjvAyHx23hOQv705UxdwT1jniVB7P
X-Gm-Gg: ASbGncuhna0wzLKmPRA7BVNQJ2NJ6+tA1IWGrfn1tEANhW4UHYQYh0W1Nj4JmnRBRjN
	cC1Qfqvy+xOypCjweG/zDQkacU31JpYsJOz4zzeUbAd5HAN/o7N2yWIQXiTGpXQwacX7ndtPle4
	B91NECyGssLM4GNVCwOBO0fI5WzYQaa9mD1Q29O1vVbXl55pS15+CpX4En1FLVgBB7v0zSEztsL
	fNz/WZSjS+nyTvFXcYNzZcW42kto2E4AkPtcC804Vq6vSstFGqUAnn17HgZriVikZhpV2z3cezH
	F+RyWQfYBizGRUaJ6WQXTYcrYkMd4NFgHVc+thNyGElVFri+LwN3YL4AQ8+9XgEtBLZ2aHiIwSF
	j23lDd25YEzgTbjKZ8pM2S4gBcsSoDGb9n8LEd9TMs2Q=
X-Google-Smtp-Source: AGHT+IH3axpSy7DvOTJu9KiRrklIdcbeobSkt2/O+kp3PhhZGjGimp+YPwMKZlzEiJCJcOY50URhHQ==
X-Received: by 2002:a17:902:e54f:b0:23f:d861:bd4a with SMTP id d9443c01a7336-242c21dd44cmr215155265ad.27.1754980067944;
        Mon, 11 Aug 2025 23:27:47 -0700 (PDT)
Received: from [192.168.0.120] ([49.207.198.59])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63ee49e0sm33358243a91.24.2025.08.11.23.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 23:27:47 -0700 (PDT)
Message-ID: <e4866dba-b665-404b-9b48-a01301f02d23@gmail.com>
Date: Tue, 12 Aug 2025 11:57:43 +0530
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] generic/563: Increase the write tolerance to 6% for
 larger nodesize
Content-Language: en-US
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, ritesh.list@gmail.com,
 ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
 fdmanana@kernel.org
References: <cover.1753769382.git.nirjhar.roy.lists@gmail.com>
 <f48538de3ce4a98a2128f48aa0f005f51eb552ee.1753769382.git.nirjhar.roy.lists@gmail.com>
 <d1b32c8f-6d9b-441b-85c4-3a4b6b91ce15@gmx.com>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <d1b32c8f-6d9b-441b-85c4-3a4b6b91ce15@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/4/25 09:58, Qu Wenruo wrote:
>
>
> 在 2025/7/29 15:51, Nirjhar Roy (IBM) 写道:
>> When tested with blocksize/nodesize 64K on powerpc
>> with 64k  pagesize on btrfs, then the test fails
>> with the folllowing error:
>>       QA output created by 563
>>       read/write
>>       read is in range
>>      -write is in range
>>      +write has value of 8855552
>>      +write is NOT in range 7969177.6 .. 8808038.4
>
> I can reproduce the failure, although it's not 100% reliable, and 
> indeed with one tree block's size removed, it's back into the 
> tolerance range.
>
>>       write -> read/write
>>      ...
>> The slight increase in the amount of bytes that
>> are written is because of the increase in the
>> the nodesize(metadata) and hence it exceeds the tolerance limit 
>> slightly.
>> Fix this by increasing the write tolerance limit from 5% from 6%
>> for 64k blocksize btrfs.
>>
>> Reported-by: Disha Goel <disgoel@linux.ibm.com>
>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>> ---
>>   tests/generic/563 | 17 ++++++++++++++++-
>>   1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/generic/563 b/tests/generic/563
>> index 89a71aa4..efcac1ec 100755
>> --- a/tests/generic/563
>> +++ b/tests/generic/563
>> @@ -119,7 +119,22 @@ $XFS_IO_PROG -c "pread 0 $iosize" -c "pwrite -b 
>> $blksize 0 $iosize" -c fsync \
>>       $SCRATCH_MNT/file >> $seqres.full 2>&1
>>   switch_cg $cgdir
>>   $XFS_IO_PROG -c fsync $SCRATCH_MNT/file
>> -check_cg $cgdir/$seq-cg $iosize $iosize 5% 5%
>> +blksz=`_get_block_size $SCRATCH_MNT`
>> +
>> +# On higher node sizes on btrfs, we observed slightly more
>> +# writes, due to increased metadata sizes.
>> +# Hence have a higher write tolerance for btrfs and when
>> +# node size is greater than 4k.
>> +if [[ "$FSTYP" == "btrfs" ]]; then
>> +    nodesz=$(_get_btrfs_node_size "$SCRATCH_DEV")
>> +    if [[ "$nodesz" -gt 4096 ]]; then
>> +        check_cg $cgdir/$seq-cg $iosize $iosize 5% 6%
>> +    else
>> +        check_cg $cgdir/$seq-cg $iosize $iosize 5% 5%
>> +    fi
>> +else
>> +    check_cg $cgdir/$seq-cg $iosize $iosize 5% 5%
>> +fi
>
> Instead of the btrfs specific hack, I'd recommend to just enlarge iosize.
>
> Double the iosize will easily make it to cover the tolerance of even 
> btrfs, but you still need a proper explanation of the change.

Okay. I can try the above and will come up with more detailed explantion.

--NR

>
> Thanks,
> Qu
>
>>     # Write from one cgroup then read and write from a second. Writes 
>> are charged to
>>   # the first group and nothing to the second.
>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


