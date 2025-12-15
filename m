Return-Path: <linux-btrfs+bounces-19724-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4FFCBC893
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 06:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5BCED3005027
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 05:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1E92D543E;
	Mon, 15 Dec 2025 05:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsXDAcJa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F85C28CF5F
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 05:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765775062; cv=none; b=ft4uJV8z4mxkYKw1/lCFpIaSPnCeeOb04dRopJgE9409de8ijAVckTM/BHs+12DiS+rXwIqlfLQ0px4N1rqrjkKuAD6HfSYBxwq3/OMb6VvVxnZgyHOFKvWR4Hqs2UJ68pfzxDz2jju/tV4NCczKTVFuvBqG052Dbey7VJi99sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765775062; c=relaxed/simple;
	bh=6QmFm5BOXTEHjRAylnBJN5wt96Vr9CRtAMegcywyyJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BvG2MLq7kZ+SV3kXmWLIEEs4V8lVamUdqMwLT08zOWYnz5GKERLBRj2XD9MRwB6gbxTfxsXtfuGmhr6LCDYahw99VoCtk2tWxMBgXKEljjV/gXOBHLQjh6q8Y1hp049URxrDjJO2CMVUGF+yzMdDAqrgW9UGLjKtdeya4n7nlYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsXDAcJa; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7aad4823079so2679585b3a.0
        for <linux-btrfs@vger.kernel.org>; Sun, 14 Dec 2025 21:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765775060; x=1766379860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tZGyA7pBdSvrHmzYabMFoB6rBogwUp86ekQykEwOfOE=;
        b=KsXDAcJal21zACibSvKYUqkap8c/wpfX8xAp8Css6X5b3LTtF/payNlYVNmRB2z5a/
         cTALxa8zxjsi69Wqsnn9c7jR+d5WOG8PRoFaCuBTh9peCaW82OyKZATemy8rTzY0FxhC
         aBQwXm/83zjfMHKgDW6q2V0GjFx3F8bMBLxJ5WMwlhMHZv0Vmygm4oABNrCco14P2OKw
         LsrC/xWjF67qnWMiz3RP6XMwAsXRfOIOccJhkJo7JSNhvgkJN248ijMvcmSUccRyx5b5
         sHzNEzjBd/NqTI+BtOUpE7TxVgJH7j0iPOP86WMRHo5QB27f5pE70pfKf1jNpMQrdxUt
         9R/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765775060; x=1766379860;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tZGyA7pBdSvrHmzYabMFoB6rBogwUp86ekQykEwOfOE=;
        b=toClT5rIW1HFAGVZ6Kw3qLdMjh/P8F+85+uzxyC1YyrAxN/fwW+9+/2tpmZO912Cg4
         eW+P/hJvtdeC1PWyq7eGjalEe2hb4fs+HdxJeiPVJN1K8gLNLjGzCn5nzFjavI8tc80U
         iQT/0MB3GReuMqQM25Dsqkt6GFrkdyDAU8JrIQ4EVHujKycugt69Sljr+WEMpK3IuUBJ
         aPqvMNZGEjZkGouA+2q7qfQpSshpJxQAtIPVDBSKMmBbXrWOafrmIMl0PS+67FtpI7Fu
         fNHYMl6FWh5vwEnP/MtVk498v5TpiFMd9Eb8AOWiuzywd/6Mm/S+JGVk4koz4q4YOZwu
         ZR3g==
X-Forwarded-Encrypted: i=1; AJvYcCW2Lva3rklxppfuMGeCYaPFCkoAh06Z7EGLppGmltulM/HsgE2HbunJdNW6gPuxSRUXVEFMhy/Bv+5Y1w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yye4NhGA6VKD7Vz0fofxnDRBdsj8qluEmHrVhbDqjYGUw4H2loY
	XtaisN3CGseN65aNI/ce27dH23xwhfb3xos3bSMG+Sa4RUqzvmtKE/PmdY8/Qg==
X-Gm-Gg: AY/fxX59X5XAExEs3waRR8llF5O19MZJo2dv+lY0EhIM+pKEZb1+zngG7T7dxi5j6cv
	CNQS/DSG7Uor7ETqgmUdgo8O7+ur+u522DiXhHB6VxLzrFkAP04dgJdNM4/qWPMeYn2xWQdUmtz
	ggpjQ6Jrx+DiAv5Qe9TnYSrO3Bxiycne5cG8USDfTMPZRrJGP7Kkr0OQ0oJejx2TPq1MyQwJsCu
	7gxgJQkLKrC8cjYXD30eV7WtwhbIzmfJ9uY53xz1v4J5XCFKkHufcajS3grwk6ySxJ6n4Yw7xtm
	Ym8xGz6b1RzKH1sITaFvXaQqsmcUyWVEfVypmdwQUa3uPtvm4RHf+BvhtBZn3aWsOUOuzST2+Za
	GD5j2ep7fOiiJm6GTY6n03tPn48yd3c23+2QQAuhMEMXYKio4wJyGSGeKSqXHga5M2Z++GUgU+9
	mcBDD36R3sQjoicitlPxabIQ==
X-Google-Smtp-Source: AGHT+IGCxPpj/+ZlGgaLnL92SemtmZ9bg1o7bpPUXZQfeNn1WhaCHlhp0a8dZrp8y+9ZzViCc97Fvw==
X-Received: by 2002:a05:6a00:4c97:b0:7e8:4471:8dd with SMTP id d2e1a72fcca58-7f66a07d110mr10010040b3a.62.1765775059493;
        Sun, 14 Dec 2025 21:04:19 -0800 (PST)
Received: from [192.168.0.120] ([49.207.205.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c547e720sm11312785b3a.57.2025.12.14.21.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Dec 2025 21:04:18 -0800 (PST)
Message-ID: <b3d93d75-9c39-44ac-9c7e-0346b3a970cf@gmail.com>
Date: Mon, 15 Dec 2025 10:34:14 +0530
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] generic/371: Fix the test to be compatible block
 sizes upto 64k
To: Zorro Lang <zlang@redhat.com>, linux-btrfs <linux-btrfs@vger.kernel.org>
Cc: fstests@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
 djwong@kernel.org, fdmanana@kernel.org, quwenruo.btrfs@gmx.com,
 zlang@kernel.org
References: <cover.1758036285.git.nirjhar.roy.lists@gmail.com>
 <a44d80e30dca7e71e701ec90d75717a0581def4d.1758036285.git.nirjhar.roy.lists@gmail.com>
 <20250926163758.hrg4bbyvk3xipcqo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <ef8b27aa-9ae9-4f5c-9798-38197c327df9@gmail.com>
 <20251101113625.zyq4gsf6d63q6dti@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <20251101113625.zyq4gsf6d63q6dti@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/1/25 17:06, Zorro Lang wrote:
> On Tue, Oct 21, 2025 at 02:27:46PM +0530, Nirjhar Roy (IBM) wrote:
>> On 9/26/25 22:07, Zorro Lang wrote:
>>> On Tue, Sep 16, 2025 at 03:30:09PM +0000, Nirjhar Roy (IBM) wrote:
>>>> When this test was ran with btrfs with 64k sector/block size, it
>>>> failed with
>>>>
>>>>        QA output created by 371
>>>>        Silence is golden
>>>>       +fallocate: No space left on device
>>>>       +pwrite: No space left on device
>>>>       +fallocate: No space left on device
>>>>       +pwrite: No space left on device
>>>>       +pwrite: No space left on device
>>>>       ...
>>>>
>>>> This is what is going on:
>>>>
>>>> Let us see the following set of operations:
>>>>
>>>> --- With 4k sector size ---
>>>> $ mkfs.btrfs -f -b 256m -s 4k -n 4k /dev/loop0
>>>> $ mount /dev/loop0 /mnt1/scratch/
>>>> $ df -h /dev/loop0
>>>> Filesystem      Size  Used Avail Use% Mounted on
>>>> /dev/loop0      256M  1.5M  175M   1% /mnt1/scratch
>>>>
>>>> $ xfs_io -f -c "pwrite 0 80M" /mnt1/scratch/t1
>>>> wrote 83886080/83886080 bytes at offset 0
>>>> 80 MiB, 20480 ops; 0.4378 sec (182.693 MiB/sec and 46769.3095 ops/sec)
>>>>
>>>> $ df -h /dev/loop0
>>>> Filesystem      Size  Used Avail Use% Mounted on
>>>> /dev/loop0      256M  1.5M  175M   1% /mnt1/scratch
>>>>
>>>> $ sync
>>>> $ df -h /dev/loop0
>>>> Filesystem      Size  Used Avail Use% Mounted on
>>>> /dev/loop0      256M   82M   95M  47% /mnt1/scratch
>>>>
>>>> $ xfs_io -f -c "pwrite 0 80M" /mnt1/scratch/t2
>>>> wrote 83886080/83886080 bytes at offset 0
>>>> 80 MiB, 20480 ops; 0:00:01.25 (63.881 MiB/sec and 16353.4648 ops/sec)
>>>>
>>>> $ df -h /dev/loop0
>>>> Filesystem      Size  Used Avail Use% Mounted on
>>>> /dev/loop0      256M  137M   40M  78% /mnt1/scratch
>>>>
>>>> $ sync
>>>> $ df -h /dev/loop0
>>>> Filesystem      Size  Used Avail Use% Mounted on
>>>> /dev/loop0      256M  162M   15M  92% /mnt1/scratch
>>>>
>>>> Now let us repeat with 64k sector size
>>>> --- With 64k sector size ---
>>>> $ mkfs.btrfs -f -b 256m -s 64k -n 64k /dev/loop0
>>>> $ mount /dev/loop0 /mnt1/scratch/
>>>> $ df -h /dev/loop0
>>>> Filesystem      Size  Used Avail Use% Mounted on
>>>> /dev/loop0      256M   24M  175M  12% /mnt1/scratch
>>>>
>>>> $ xfs_io -f -c "pwrite 0 80M" /mnt1/scratch/t1
>>>> wrote 83886080/83886080 bytes at offset 0
>>>> 80 MiB, 20480 ops; 0.8460 sec (94.553 MiB/sec and 24205.4914 ops/sec)
>>>> $
>>>> $ df -h /dev/loop0
>>>> Filesystem      Size  Used Avail Use% Mounted on
>>>> /dev/loop0      256M   24M  175M  12% /mnt1/scratch
>>>>
>>>> $ sync
>>>> $ df -h /dev/loop0
>>>> Filesystem      Size  Used Avail Use% Mounted on
>>>> /dev/loop0      256M  104M   95M  53% /mnt1/scratch
>>>>
>>>> $ xfs_io -f -c "pwrite 0 80M" /mnt1/scratch/t2
>>>> pwrite: No space left on device
>>>>
>>>> Now, we can see that with 64k node size, 256M is not sufficient
>>>> to hold 2 files worth 80M. For 64k, we can also see that the initial
>>>> space usage on a fresh filesystem is 24M and for 4k its 1.5M. So
>>>> because of higher node size, more metadata space is getting used.
>>>> This test requires the size of the filesystem to be at least capable
>>>> to hold 2 80M files.
>>>> Fix this by increasing the fs size from 256M to 330M.
>>> Thanks for this detailed explanation. As this's a ENOSPC test, so we
>>> must make sure this case still can uncover the original bug, before
>>> increasing the fs size. Can you make sure that? Or maybe we can replace
>>> that "80M" with a variable (according to "Avail" size).
>> Hi Filipe, Zorro, Wang,
>>
>> The original commit message of generic/371 says that this test catches some
>> excess space usage issues. Is(Are) there any patch(es) that fix this issue -
>> so that I can remove the commits and check if the test expectedly fails with
>> slightly large fssize i.e, 330M?
>>
>> I did find some related commits [1] and I ran the test with 330M and
>> 256M(the default size) after removing the commits[1] but the test passes
>> with both the filesystem sizes. So I am guessing, this is not the patch that
>> can test generic/371.
>>
>> [1] https://lore.kernel.org/linux-btrfs/cover.1610747242.git.josef@toxicpanda.com/
> Hi,
>
> I'm not familiar with btrfs patches, but from the commit history, I suspect
> it *might* be related with below commit:
>
> commit 18513091af9483ba84328d42092bd4d42a3c958f
> Author: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
> Date:   Mon Jul 25 15:51:40 2016 +0800
>
>      btrfs: update btrfs_space_info's bytes_may_use timely
>
> Or "c0d2f6104e8ab2eb75e58e72494ad4b69c5227f8" :)
>
> Thanks,
> Zorro

Hi Zorro, Filipe and Qu

Thank you for the pointers. I tried running the test reverting the above 
2 mentioned commits, but the test seems to pass without these commits, 
so probably these are not the ones. I am not able to find any other 
relevant commits and the test case is also very old. Any further ideas?

--NR

>
>> --NR
>>
>>> Thanks,
>>> Zorro
>>>
>>>> Reported-by: Disha Goel <disgoel@linux.ibm.com>
>>>> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
>>>> ---
>>>>    tests/generic/371 | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/tests/generic/371 b/tests/generic/371
>>>> index b312c450..95af308e 100755
>>>> --- a/tests/generic/371
>>>> +++ b/tests/generic/371
>>>> @@ -19,7 +19,7 @@ _require_scratch
>>>>    _require_xfs_io_command "falloc"
>>>>    test "$FSTYP" = "xfs" && _require_xfs_io_command "extsize"
>>>> -_scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1
>>>> +_scratch_mkfs_sized $((330 * 1024 * 1024)) >> $seqres.full 2>&1
>>>>    _scratch_mount
>>>>    # Disable speculative post-EOF preallocation on XFS, which can grow fast enough
>>>> -- 
>>>> 2.34.1
>>>>
>> -- 
>> Nirjhar Roy
>> Linux Kernel Developer
>> IBM, Bangalore
>>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore


