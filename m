Return-Path: <linux-btrfs+bounces-1281-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEFA825ED7
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jan 2024 09:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9B0284C99
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jan 2024 08:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632815393;
	Sat,  6 Jan 2024 08:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nc9rlzZ7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C574523E
	for <linux-btrfs@vger.kernel.org>; Sat,  6 Jan 2024 08:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50eb24d3ccbso106490e87.1
        for <linux-btrfs@vger.kernel.org>; Sat, 06 Jan 2024 00:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704528766; x=1705133566; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QUw/ieh283lNBjx6w7rOI7URkqoqNNmpbKGaV/PWUJA=;
        b=nc9rlzZ79XJ3fm/nBiYNHhyrcsL0SJ6iCWohg0jWJ3f7y/elyQq34LhIMZWrgi9D5z
         RBI1R4LkRju1gveyEDicpEK9HJZnatHwwYuGXvEX0V7bd1//bI5BtZlDktRf2//8zx2u
         2QUp6OohVvHIexYp/rKT3veqmnCOCEOpdm/9TzK85yq+zb5zhgZLFgZeHf1qXFR4vYIP
         5fJA6PWn1gCVQeZdZR/x/ZTxIbX2gbAisrGR2dWGClwN7lD/Q32BFkKuEQrfNR/IkYIe
         RFrVA088URxyM74OPBkToZcc7+yQ0iM6njOwlaSSeTRnwwysagw+oAphA+jYQsRccJ3n
         fY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704528766; x=1705133566;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QUw/ieh283lNBjx6w7rOI7URkqoqNNmpbKGaV/PWUJA=;
        b=klT4/E3sBXzYKqeHa9KVJhtUBdVaB13fTSeISgZD2HWZbTEV5VoQw7PVzYqy+x5nEk
         XIebyzR4QaU/tz905bb69c5zRrR2YKyktfVxWIPYVYW+Xf4KZ+U9cFGPzxd2fOHe0C9J
         KfwYKY+vy+L+mAv3YdrY4n/V6hB4yC/Uvdzx37K/9Wd7hzjD4L63BsfrNX2ZzEyIC45n
         eBUHxcLqrodt9NdOk0vdY/PJv5iFvZuTQNBuju1E6z3HjsFsa0g5Yohg/HiXTh93X8NX
         Sl9oMnCz/uttpPyn5iIsTJmsj0aue+vICrlc+6Pa+EfVex4PKT01OkwwXTKbjMlDPNwN
         sN7w==
X-Gm-Message-State: AOJu0YwruNYHF3yg/cCedMdlHjma0R/PbGFsFjzxsMK5li/TYl2l5Z3K
	Qqa7G05CZD+HpxsEJb3eGb8=
X-Google-Smtp-Source: AGHT+IFtdn9nmhMckhpemOU+xNtvVmQIEuyhQRHRpNHJ9HGuwM0+MEZas6cXgj1SGdraZtLO5acpwA==
X-Received: by 2002:a05:6512:a8f:b0:50e:b380:61a8 with SMTP id m15-20020a0565120a8f00b0050eb38061a8mr587751lfu.4.1704528765904;
        Sat, 06 Jan 2024 00:12:45 -0800 (PST)
Received: from [192.168.1.109] ([176.124.146.164])
        by smtp.gmail.com with ESMTPSA id r11-20020ac24d0b000000b0050e7bb8c7d9sm460019lfi.239.2024.01.06.00.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jan 2024 00:12:45 -0800 (PST)
Message-ID: <f7211b06-085d-445a-9934-ebaacf280821@gmail.com>
Date: Sat, 6 Jan 2024 11:12:37 +0300
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs thinks fs is full, though 11GB should be still free
Content-Language: en-US, ru-RU
To: Qu Wenruo <quwenruo.btrfs@gmx.com>,
 Christoph Anton Mitterer <calestyo@scientia.org>
Cc: linux-btrfs@vger.kernel.org
References: <0f4a5a08fe9c4a6fe1bfcb0785691a7532abb958.camel@scientia.org>
 <62e9ad23d4829f30600ea6e611d2cd4636f080cc.camel@scientia.org>
 <7acc8ea1-079d-42bb-8880-dbd9bbfa100b@libero.it>
 <fecad7ce2cea1ff125a842d8c53f1fbfe4f1d231.camel@scientia.org>
 <CAA91j0VNf9UQTYOn688eboGB_bw4YeKOXnKAt1uAYRZwYA3UPg@mail.gmail.com>
 <b47ed92f14edde7db5c1037a75b38652afa6c1c1.camel@scientia.org>
 <e6ef9ab3-06ab-4360-b205-3a7559b6b388@gmx.com>
 <979fd68a4a766f823366797eab1060e5c515a776.camel@scientia.org>
 <ba9556f9-4784-4bf8-8fa1-49b17df6d31e@gmx.com>
 <c085dabb449f8088156d906062db0b9fa0f7fe32.camel@scientia.org>
 <aa69e84f-d466-457d-9b29-47043c2aef53@suse.com>
 <bf5726d2a30996d06204b17d05daec9c77b7d769.camel@scientia.org>
 <57a0f910-a100-4f31-ad22-762e8c0ecb39@gmx.com>
 <513dfa2b00cf496e6f682508037616b6165fcc53.camel@scientia.org>
 <494daef3-c180-4529-befb-325a46a3eeeb@gmx.com>
 <156b27d5ea42ed4afa6d73dec8e2f479d346786d.camel@scientia.org>
 <b849c107-c3d5-4dae-a03f-c7575eee157b@gmx.com>
From: Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <b849c107-c3d5-4dae-a03f-c7575eee157b@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.01.2024 08:40, Qu Wenruo wrote:
> 
> 
> On 2024/1/6 11:12, Christoph Anton Mitterer wrote:
>> On Fri, 2024-01-05 at 17:37 +1030, Qu Wenruo wrote:
>>> but pretty hard to find a
>>> good way to improve:
>>
>> I guess it would not be an alternative to do the work on truncate (i.e.
>> check whether a lot is wasted and if so, create a new extent with just
>> the right size), because that would need a full re-write of the
>> extent... or would it?
> 
> I'm not sure if it's a valid idea to do all these on truncation.
> It would involve doing all the backref walk to determine if it's needed
> to do the COW.
> 
>>
>> Also, a while ago in one of my mails I saw that:
>> $ cat affected-file > new-file
>> would also cause new-file to be affected... which I found pretty
>> strange.
>>
>> Any idea why that happens?
> 
> Initially I thought that's impossible, until I tired it:
> 
> mkfs.btrfs -f $dev1
> mount $dev1 $mnt
> xfs_io -f -c "pwrite 0 128m" $mnt/file
> sync
> truncate -s 4k $mnt/file
> sync
> cat $mnt/file > $mnt/new
> sync
> 
> Then dump tree indeed show the new file is sharing the same large extent:
> 
> 
>           item 6 key (257 INODE_ITEM 0) itemoff 15817 itemsize 160
>                   generation 7 transid 8 size 4096 nbytes 4096
>                   block group 0 mode 100600 links 1 uid 0 gid 0 rdev 0
>                   sequence 32770 flags 0x0(none)
>           item 7 key (257 INODE_REF 256) itemoff 15803 itemsize 14
>                   index 2 namelen 4 name: file
>           item 8 key (257 EXTENT_DATA 0) itemoff 15750 itemsize 53
>                   generation 7 type 1 (regular)
>                   extent data disk byte 298844160 nr 134217728 <<<
>                   extent data offset 0 nr 4096 ram 134217728
>                   extent compression 0 (none)
>           item 9 key (258 INODE_ITEM 0) itemoff 15590 itemsize 160
>                   generation 9 transid 9 size 4096 nbytes 4096
>                   block group 0 mode 100644 links 1 uid 0 gid 0 rdev 0
>                   sequence 1 flags 0x0(none)
>           item 10 key (258 INODE_REF 256) itemoff 15577 itemsize 13
>                   index 3 namelen 3 name: new
>           item 11 key (258 EXTENT_DATA 0) itemoff 15524 itemsize 53
>                   generation 7 type 1 (regular)
>                   extent data disk byte 298844160 nr 134217728 <<<
>                   extent data offset 0 nr 4096 ram 134217728
>                   extent compression 0 (none)
> 
> My guess is bash is doing something weird thus making the whole cat +
> redirection into reflink.
> 

It is not bash (which just opens file and dup's it). It is cat from GNU 
coreutils which defaults to using copy_file_range

10393 openat(AT_FDCWD, "/mnt/file", O_RDONLY) = 3
10393 fstat(3, {st_mode=S_IFREG|0644, st_size=4096, ...}) = 0
10393 fadvise64(3, 0, 0, POSIX_FADV_SEQUENTIAL) = 0
10393 uname({sysname="Linux", nodename="tw", ...}) = 0
10393 copy_file_range(3, NULL, 1, NULL, 9223372035781033984, 0) = 4096
10393 copy_file_range(3, NULL, 1, NULL, 9223372035781033984, 0) = 0

In case of btrfs this ends in btrfs_remap_file_range(). So it is more or 
less self inflicted wound. May be btrfs should not reflink partial 
extents in such cases.

> But at least dd works as expected by creating a new extent.
> 
>>
>>
>>
>>> My previous guess is totally wrong, it has nothing to do with
>>> NODATACOW/PREALLOC flags at all.
>>>
>>> It's a defrag only problem.
>>
>> Sure, but I meant, if a file is NODATACOW and would be prealloced to a
>> large size and then truncated - would it also loose the extra space?
> 
> That would be the same.
> 
>>
>>
>> And do you think that other CoW fs would be affected, too? IIRC XFS is
>> also about to get CoW features... so may it's simply an IO pattern that
>> developers need to avoid with modern filesystems.
> 
> Not sure, maybe XFS would do extra extent split to solve the problem.
> 
> Thanks,
> Qu
> 
>>
>>
>> Cheers,
>> Chris-
>>
> 


