Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF24CAE199
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2019 02:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731991AbfIJAGo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Sep 2019 20:06:44 -0400
Received: from server53-3.web-hosting.com ([198.54.126.113]:40908 "EHLO
        server53-3.web-hosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727351AbfIJAGo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Sep 2019 20:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=zedlx.com;
         s=default; h=Content-Transfer-Encoding:MIME-Version:Content-Type:Reply-to:
        In-Reply-To:References:Subject:Cc:To:From:Message-ID:Date:Sender:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=SpxLmh25kGCYIPf2zkSyS6rmkyXsNVeTQYAeFQv36os=; b=O1QNgIDSQ5nROP9y+n2FpXOLoJ
        2XeFgzMreGJJsO5T9bEMkMrv00tNNSkHsne5U3bNth97DY+lZyIVtjohYI45fZsgdK2qVS+x91Jvu
        +Gd3sBozMr1A8JoUUK5BCfkOSdRLlk1PQWVcQUlSpNBZmIWPVj5ee302vV5eH5PqEzrA99u0Rczqf
        lEUwIg5ELtoyV8PCAAby6M2ENOUKC7MDw7PHRE7KVgfUaxPUv9UDnzhFJ1u4as0rAO+DbCNRg6H9K
        JM6v7YVgzb1lzIoULHozlE2V9dXET4P+nma+S2Ud3WPl3zIBRZOmcTcbX+FsuOgMaNpGT2SiUK9up
        iG0j7dxg==;
Received: from [::1] (port=53790 helo=server53.web-hosting.com)
        by server53.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <webmaster@zedlx.com>)
        id 1i7Tg6-000NcF-WE; Mon, 09 Sep 2019 20:06:43 -0400
Received: from [95.178.242.92] ([95.178.242.92]) by server53.web-hosting.com
 (Horde Framework) with HTTPS; Mon, 09 Sep 2019 20:06:38 -0400
Date:   Mon, 09 Sep 2019 20:06:38 -0400
Message-ID: <20190909200638.Horde.GlzWP3_SqKPkxpAfp05Rsz7@server53.web-hosting.com>
From:   webmaster@zedlx.com
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Feature requests: online backup - defrag - change RAID level
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
 <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com>
 <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
 <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com>
 <20190909123818.Horde.dbl-yi_cNi8aKDaW_QYXVij@server53.web-hosting.com>
 <ba5f9d6c-aa6c-c9b2-76d2-3ca56606fcc5@gmx.com>
In-Reply-To: <ba5f9d6c-aa6c-c9b2-76d2-3ca56606fcc5@gmx.com>
Reply-to: webmaster@zedlx.com
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server53.web-hosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - zedlx.com
X-Get-Message-Sender-Via: server53.web-hosting.com: authenticated_id: zedlryqc/from_h
X-Authenticated-Sender: server53.web-hosting.com: webmaster@zedlx.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, already matched
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Quoting Qu Wenruo <quwenruo.btrfs@gmx.com>:

> On 2019/9/10 上午12:38, webmaster@zedlx.com wrote:
>>
>> Quoting Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>
>>>>>> 2) Sensible defrag
>>>>>> The defrag is currently a joke.
>>>>
>>>> Maybe there are such cases, but I would say that a vast majority of
>>>> users (99,99%) in a vast majority of cases (99,99%) don't want the
>>>> defrag operation to reduce free disk space.
>>>>
>>>>> What's wrong with current file based defrag?
>>>>> If you want to defrag a subvolume, just iterate through all files.
>>>>
>>>> I repeat: The defrag should not decrease free space. That's the 'normal'
>>>> expectation.
>>>
>>> Since you're talking about btrfs, it's going to do CoW for metadata not
>>> matter whatever, as long as you're going to change anything, btrfs will
>>> cause extra space usage.
>>> (Although the final result may not cause extra used disk space as freed
>>> space is as large as newly allocated space, but to maintain CoW, newly
>>> allocated space can't overlap with old data)
>>
>> It is OK for defrag to temporarily decrease free space while defrag
>> operation is in progress. That's normal.
>>
>>> Further more, talking about snapshots with space wasted by extent
>>> booking, it's definitely possible user want to break the shared extents:
>>>
>>> Subvol 257, inode 257 has the following file extents:
>>> (257 EXTENT_DATA 0)
>>> disk bytenr X len 16M
>>> offset 0 num_bytes 4k  << Only 4k is referred in the whole 16M extent.
>>>
>>> Subvol 258, inode 257 has the following file extents:
>>> (257 EXTENT_DATA 0)
>>> disk bytenr X len 16M
>>> offset 0 num_bytes 4K  << Shared with that one in subv 257
>>> (257 EXTENT_DATA 4K)
>>> disk bytenr Y len 16M
>>> offset 0 num_bytes 4K  << Similar case, only 4K of 16M is used.
>>>
>>> In that case, user definitely want to defrag file in subvol 258, as if
>>> that extent at bytenr Y can be freed, we can free up 16M, and allocate a
>>> new 8K extent for subvol 258, ino 257.
>>> (And will also want to defrag the extent in subvol 257 ino 257 too)
>>
>> You are confusing the actual defrag with a separate concern, let's call
>> it 'reserved space optimization'. It is about partially used extents.
>> The actual name 'reserved space optimization' doesn't matter, I just
>> made it up.
>
> Then when it's not snapshotted, it's plain defrag.
>
> How things go from "reserved space optimization" to "plain defrag" just
> because snapshots?

I'm not sure that I'm still following you here.

I'm just saying that when you have some unused space within an extent  
and you want the defrag to free it up, that is OK, but such thing is  
not the main focus of the defrag operation. So you are giving me some  
edge case here which is half-relevant and it can be easily solved. The  
extent just needs to be split up into pieces, it's nothing special.

>> 'reserved space optimization' is usually performed as a part of the
>> defrag operation, but it doesn't have to be, as the actual defrag is
>> something separate.
>>
>> Yes, 'reserved space optimization' can break up extents.
>>
>> 'reserved space optimization' can either decrease or increase the free
>> space. If the algorithm determines that more space should be reserved,
>> than free space will decrease. If the algorithm determines that less
>> space should be reserved, than free space will increase.
>>
>> The 'reserved space optimization' can be accomplished such that the free
>> space does not decrease, if such behavior is needed.
>>
>> Also, the defrag operation can join some extents. In my original example,
>> the extents e33 and e34 can be fused into one.
>
> Btrfs defrag works by creating new extents containing the old data.
>
> So if btrfs decides to defrag, no old extents will be used.
> It will all be new extents.
>
> That's why your proposal is freaking strange here.

Ok, but: can the NEW extents still be shared? If you had an extent E88  
shared by 4 files in different subvolumes, can it be copied to another  
place and still be shared by the original 4 files? I guess that the  
answer is YES. And, that's the only requirement for a good defrag  
algorithm that doesn't shrink free space.

Perhaps the metadata extents need to be unshared. That is OK. But I  
guess that after a typical defrag, the sharing ratio in metadata  
woudn't change much.

>>> That's why knowledge in btrfs tech details can make a difference.
>>> Sometimes you may find some ideas are brilliant and why btrfs is not
>>> implementing it, but if you understand btrfs to some extent, you will
>>> know the answer by yourself.
>>
>> Yes, it is true, but what you are posting so far are all 'red
>> herring'-type arguments. It's just some irrelevant concerns, and you
>> just got me explaining thinks like I would to a little baby. I don't
>> know whether I stumbled on some rookie member of btrfs project, or you
>> are just lazy and you don't want to think or consider my proposals.
>
> Go check my name in git log.

I didn't check yet. Ok, let's just try to communicate here, I'm dead serious.

I can't understand a defrag that substantially decreases free space. I  
mean, each such defrag is a lottery, because you might end up with  
practically unusable file system if the partition fills up.

CURRENT DEFRAG IS A LOTTERY!

How bad is that?

