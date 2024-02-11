Return-Path: <linux-btrfs+bounces-2305-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC628507A6
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Feb 2024 04:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DCAE1C225C4
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Feb 2024 03:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9922BDF4F;
	Sun, 11 Feb 2024 03:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5JpxjZf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAD823A3;
	Sun, 11 Feb 2024 03:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707621232; cv=none; b=R5PbmbCblLQCoNW5wUa9P3vxRnXaRDy23DfXZoZJJMuvC2t9PNqJadZ5OmvB9tZOPClr9NlGOSptGKU2srLvDjOc2QNuhPTCKc5OPkxQ08yJCjTAaFVhjjs+stxRXmrOOyyJ3Z/O9lZZe20aMuz+jCLaE0wwV3kftQAkxsKAQZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707621232; c=relaxed/simple;
	bh=x84n/2w4JvLcHrEBE5NUKz5qywxqmkIhTiloRi5dhHs=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=I4hP+2WKOQzyciTl9OP7iu/D22W/UJqD0YPeV3wQANjwvTs25QnO51G8m0yPfjH94FMwEeXmkDoXC2+eni0nKKqqwDtMUxc1MgAEf/D9a/SiuhZLw6Uz9FaPEguHnupvurrXvzD5+iiiVAillBe8pA5tZNU/oiuEq0y+2uF9hgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5JpxjZf; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-5d8b519e438so1860353a12.1;
        Sat, 10 Feb 2024 19:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707621230; x=1708226030; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2N9wy+XHTqk/bKuRYddF7chtEtJDXYRh+U5N1MNqftU=;
        b=R5JpxjZfAKn+/40U+ZsSaScEhIAkLvX2yn8EvcmxVsFaHaRSEvf5CbrWVc8Fq/Ha8S
         aZwZpfMbsVRffWTnxgzl5Ld/DYKLvRuiR2Je+Pq3Rr/YszAqJKErt7ms0Y/+zfuKBRzy
         QC/NPYZkkAtoyT8XNinb+SKiPtgE7X1NElFaJrumW8mWTJH8XG4uHA81WCDsgUdsoaMd
         1ThI/7ASuvmtpLiP7TcvXGt6SwW+mkiMgrY7rnyWTYmYOdwLuU33OwKy9CVLG1jyg1fv
         nPKz01WmvkzGyF8MTAbYjeUZu4UNSfv3KMGJEwbVol+BCpbJNIgkuRn9YMEd2QUhueXv
         P6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707621230; x=1708226030;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2N9wy+XHTqk/bKuRYddF7chtEtJDXYRh+U5N1MNqftU=;
        b=BVtuQGFI5Vi22CBvUBNtYYEPexAZTnTx/Uic5I8DySroUuDGik2PlL3j/iyXtWnS6E
         8WkYV7X6r6LA35IYk5pVS9otCSTicMtH4tZCmJfp3Nu8QHSUzXeUfSZ7HGHRGMgiKTKn
         PF3c6xpeFqfMbMbmURb3tBCzyHK/XQpo3G31C0h+KJQ8hQqkvtC+9NKTGmg3cOWj59cj
         dUMzowDWPbfElRPbnC0jNAPxFnUPHR0eISR20CxI55nsMmjR7OML3dRg51vY7SrNK6ea
         WKOKbgS87uldAy6+HBmk1WjhHiet67JgdKGNS0HZ4Z0KbjqiXb7NBsuraMLg5A1AI2hk
         4zaw==
X-Gm-Message-State: AOJu0Yxnm6MD6bpc2TzV0cHFbspS9/EVTz36qfamK0hWukNnac6rnK9a
	49iwYjiYSa1Qqf2guRItBf8jJJKQMeBK68PQVcgqAhrcxggfdSpy
X-Google-Smtp-Source: AGHT+IFNlFCkvUYbm/KobGvtpiio3fZbegrlImmMeF6yWBX0dEfw8vGW6IAvdpiXn9+5LCeGtGagTg==
X-Received: by 2002:a05:6a00:1d1f:b0:6dd:b12f:c394 with SMTP id a31-20020a056a001d1f00b006ddb12fc394mr3606387pfx.32.1707621230460;
        Sat, 10 Feb 2024 19:13:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW4wLxcBRS7OjTmHnTiz6XNtNA0JbcC01wTTi1vwU9W5Z57rebEG9CE6Toy8xFKXn7wSXRmRjl9Gtt1cMWtkZWF4kMjA4T5Haro1dqWmxTzkaBgzRQ=
Received: from [127.0.0.1] ([212.107.28.51])
        by smtp.gmail.com with ESMTPSA id j25-20020aa783d9000000b006e0826bf44csm3053158pfn.172.2024.02.10.19.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Feb 2024 19:13:50 -0800 (PST)
From: Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
Message-ID: <36af140d-63fd-4339-a4ed-b0068bfb5918@gmail.com>
Date: Sun, 11 Feb 2024 11:13:46 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: handle missing chunk mapping more gracefully
Content-Language: en-GB-large
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, wqu@suse.com
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org
References: <9b53f585503429f5c81eeb222f1e2cb8014807f5.1677722020.git.wqu@suse.com>
 <20240210143411.393544-1-CoelacanthusHex@gmail.com>
 <4fc1b0c6-f84d-43c7-b396-695658c7fcb4@gmx.com>
In-Reply-To: <4fc1b0c6-f84d-43c7-b396-695658c7fcb4@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-02-11 03:58, Qu Wenruo wrote:

> 
> 
> On 2024/2/11 01:04, Celeste Liu wrote:
>> On 3/2/23 09:54, Qu Wenruo wrote:
>>> [BUG]
>>> During my scrub rework, I did a stupid thing like this:
>>>
>>>           bio->bi_iter.bi_sector = stripe->logical;
>>>           btrfs_submit_bio(fs_info, bio, stripe->mirror_num);
>>>
>>> Above bi_sector assignment is using logical address directly, which
>>> lacks ">> SECTOR_SHIFT".
>>>
>>> This results a read on a range which has no chunk mapping.
>>>
>>> This results the following crash:
>>>
>>>    BTRFS critical (device dm-1): unable to find logical 11274289152 length 65536
>>>    assertion failed: !IS_ERR(em), in fs/btrfs/volumes.c:6387
>>>    ------------[ cut here ]------------
>>>
>>> Sure this is all my fault, but this shows a possible problem in real
>>> world, that some bitflip in file extents/tree block can point to
>>> unmapped ranges, and trigger above ASSERT(), or if CONFIG_BTRFS_ASSERT
>>> is not configured, cause invalid pointer.
>>>
>>> [PROBLEMS]
>>> In above call chain, we just don't handle the possible error from
>>> btrfs_get_chunk_map() inside __btrfs_map_block().
>>>
>>> [FIX]
>>> The fix is pretty straightforward, just replace the ASSERT() with proper
>>> error handling.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>> Changelog:
>>> v2:
>>> - Rebased to latest misc-next
>>>     The error path in bio.c is already fixed, thus only need to replace
>>>     the ASSERT() in __btrfs_map_block().
>>> ---
>>>    fs/btrfs/volumes.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index 4d479ac233a4..93bc45001e68 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -6242,7 +6242,8 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
>>>            return -EINVAL;
>>>
>>>        em = btrfs_get_chunk_map(fs_info, logical, *length);
>>> -    ASSERT(!IS_ERR(em));
>>> +    if (IS_ERR(em))
>>> +        return PTR_ERR(em);
>>>
>>>        map = em->map_lookup;
>>>        data_stripes = nr_data_stripes(map);
>>
>> This bug affects 6.1.y LTS branch but no backport commit of this fix in
>> 6.1.y branch. Please include it. Thanks.
>>
> Just want to make sure, are you hitting the ASSERT()?

No, in non-debug build, ASSERT() is noop. So em will be a pointer whose
value is errno and there is no any error handle for it. And then it
trigger kernel NULL Pointer Dereference exception in btrfs_get_io_geometry()
with em->map_lookup (Of course, it's not 0 but 0x5a
(-EINVAL + offsetof(map_lookup)). But it still is a illegal memory access),
this kernel thread was killed but the lock hold by this thread are not
released. After that, all fs operations was block by the lock.

> 
> If so, please provide the calltrace and btrfs-check output to pin down
> the cause.

It doesn't happen on my machine, I've notified the finder to send a
backtrace to the mailing list

> Just backporting the patch is only to make it a little more graceful,
> but won't solve the root problem.

No. In non debug build, ASSERT() is noop so it lead that there is no any
error handle code. There is no RAII/SBRM, unexpected exit will lead the
resources will not be released correctly. If it has unique holder (e.g. mutex),
it will break all other code that need this resource!

> 
> Thanks,
> Qu


