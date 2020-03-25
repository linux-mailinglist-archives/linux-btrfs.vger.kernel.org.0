Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A320192EFE
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Mar 2020 18:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbgCYROJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Mar 2020 13:14:09 -0400
Received: from smtp-35.italiaonline.it ([213.209.10.35]:56961 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726102AbgCYROJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Mar 2020 13:14:09 -0400
Received: from venice.bhome ([94.37.173.46])
        by smtp-35.iol.local with ESMTPA
        id H9bSjkcFSMAUpH9bSjT1a0; Wed, 25 Mar 2020 18:14:06 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1585156446; bh=GfSjRyv4kTEZwV9AvIVlF1km0IP+KCSqTOVCA3KubzE=;
        h=From;
        b=gT4hDOUupRX0DBMPonEh9/COA6TcYJXo6lgADUIr4/xTG+rrZvov1W12dQhUbtaEU
         8gYTPcdKL0locpkgmSGTRff9jjSN4oUTY1irDOPuqR7/pt/qUUxjqfe4bIseP6T2L0
         mzv3ffITjvlnEbNE+BJVqYlt+Yhp1fRIShmMGQJLEucA36XVVWlong+LxYSHFKaFLH
         DfO69yd1Fsz3bEPXxyM0oSQhIAY/d1q0xIzqR4aznuiPJ8wpBBCqTdX8AHGx0Sj5Cq
         3ShGfgVtdxiiX3DOSFiokVNuQxjlyBpPr/9gqySl0OoaJNZBhxHA3CDYW//l44WX3E
         JH56b9b7n66HA==
X-CNFS-Analysis: v=2.3 cv=B/fHL9lM c=1 sm=1 tr=0
 a=TpQr5eyM7/bznjVQAbUtjA==:117 a=TpQr5eyM7/bznjVQAbUtjA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8
 a=-6_MQ69qAAAA:8 a=Sbk1kuCJgygMCedwgYkA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=XQXUbi2rnRmgx9BCZzrv:22
Reply-To: kreijack@inwind.it
Subject: Re: Question: how understand the raid profile of a btrfs filesystem
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Anand Jain <anand.jain@oracle.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
References: <517dac49-5f57-2754-2134-92d716e50064@alice.it>
 <2c7f2844-b97d-0e15-6ae6-40c9c935aa77@oracle.com>
 <8977ac3d-7af6-65a7-5515-caab07983672@inwind.it>
 <8a53cf8d-980d-8c41-e35d-c8b70db1bbdc@gmail.com>
From:   Goffredo Baroncelli <kreijack@inwind.it>
Message-ID: <3dfbf173-7ac2-887f-d3eb-ec1b6c610d01@inwind.it>
Date:   Wed, 25 Mar 2020 18:14:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <8a53cf8d-980d-8c41-e35d-c8b70db1bbdc@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfBqdCKtMGNFG7FS1Zo2ByXyITk+mhYPoulfew4HuNprkv9WbrAguF+nCOxXzAfMsS4fb38gkiVmSLeLc67MHDUiCpa8wKHus7T5yAoj3VapdMNyGg0Re
 yRLgn2cBP5q4/mG5lTrOmCidsOD0b0Oh0AhWsHEpVdzsuXhIJFp6q9c6bljsHt0W2G1BS1EQvGr98bJRy+Rhcq8G/N4tRrHYWdUAxFYLvqIHO5+u8eqRS/+a
 AyzmA9N7OXA9lyrAyM7E9RfoNSCpskcFNKVrkq61xKU9jwFwHz/n57+gRvgKq47Y
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/25/20 5:09 AM, Andrei Borzenkov wrote:
> 24.03.2020 20:59, Goffredo Baroncelli пишет:
>> On 3/24/20 5:55 AM, Anand Jain wrote:
>>> On 3/21/20 1:56 AM, Goffredo Baroncelli wrote:
>>>> Hi all,
>> [..]
>>>> Looking at the code it seems to me that the logic is the following
>>>> (from btrfs_reduce_alloc_profile())
>>>>
>>>>           if (allowed & BTRFS_BLOCK_GROUP_RAID6)
>>>>                   allowed = BTRFS_BLOCK_GROUP_RAID6;
>>>>           else if (allowed & BTRFS_BLOCK_GROUP_RAID5)
>>>>                   allowed = BTRFS_BLOCK_GROUP_RAID5;
>>>>           else if (allowed & BTRFS_BLOCK_GROUP_RAID10)
>>>>                   allowed = BTRFS_BLOCK_GROUP_RAID10;
>>>>           else if (allowed & BTRFS_BLOCK_GROUP_RAID1)
>>>>                   allowed = BTRFS_BLOCK_GROUP_RAID1;
>>>>           else if (allowed & BTRFS_BLOCK_GROUP_RAID0)
>>>>                   allowed = BTRFS_BLOCK_GROUP_RAID0;
>>>>
>>>>           flags &= ~BTRFS_BLOCK_GROUP_PROFILE_MASK;
>>>>
>>>> So in the case above the profile will be RAID6. And in the general if
>>>> a RAID6 chunk is a filesystem, it wins !
>>>
>>>    That's arbitrary and doesn't make sense to me, IMO mkfs should save
>>>    default profile in the super-block (which can be changed using ioctl)
>>>    and kernel can create chunks based on the default profile.
>>
>> I'm working on this idea (storing the target profile in super-block).
> 
> What about per-subvolume profile? This comes up every now and then, like
> 
> https://lore.kernel.org/linux-btrfs/cd82d247-5c95-18cd-a290-a911ff69613c@dirtcellar.net/
> 
> May be it could be subvolume property?


The idea is nice. However I fear the mess that it could cause. Even now, with a
more simpler system where there is a "per filesystem" profile, there are a lot of corner
cases when something goes wrong (an interrupted balance, or a disk failed).
In case of multiple profiles on sub-volume basis there is no simple answer in situation like:
- when I make a snapshot of a sub-volumes, and then I change the profile of the original one,
which is the profile of the files contained in the snapshot and in the original subvolumes ?

Frankly speaking, if you want different profiles you need different filesystem...

BR
G.Baroncelli

> 
>> Of
>> course this increase the consistency, but
>> doesn't prevent the possibility that a mixed profiles filesystem could
>> happen. And in this case is the user that
>> has to solve the issue.
>>
>> Zygo, suggested also to add a mixed profile warning to btrfs (prog). And
>> I agree with him. I think that we can use
>> the space info ioctl (which doesn't require root privileges).
>>
>> BR
>> G.Baroncelli
>>
>>> This
>>>    approach also fixes chunk size inconsistency between progs and kernel
>>>    as reported/fixed here
>>>      https://patchwork.kernel.org/patch/11431405/
>>>
>>> Thanks, Anand
>>>
>>>> But I am not sure.. Moreover I expected to see also reference to DUP
>>>> and/or RAID1C[34] ...
>>>>
>>>> Does someone have any suggestion ?
>>>>
>>>> BR
>>>> G.Baroncelli
>>>>
>>>
>>
>>
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
