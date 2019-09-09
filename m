Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46E74ADD62
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Sep 2019 18:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbfIIQib (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Sep 2019 12:38:31 -0400
Received: from server53-3.web-hosting.com ([198.54.126.113]:52557 "EHLO
        server53-3.web-hosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727953AbfIIQia (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Sep 2019 12:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=zedlx.com;
         s=default; h=MIME-Version:Content-Type:Reply-to:In-Reply-To:References:
        Subject:To:From:Message-ID:Date:Sender:Cc:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=p+xfhS5zaiDw7FhVFE/bX+C04aiqGXDBEVjNn5zgzZo=; b=NbpFRyLRJ/9G9HVLrn2cDutIFe
        NzpagFaEuQ/uIlYrAVNryboKt6GWM6anb67cA9znYdQ2ugEniZ7GAKfve8NnuWPnShJByZJx6ldJb
        OGj5EbgQUzqt4JjMkga9wLI32aea9QQFszQb/LhytKV7w5SceqFDsPCtjW2Ek+To5eZEZdAhZYWZ+
        N9NzMuvE+7gtvh2QGjFx41GH8azyjQUuvPs+UNBntGoy0CRqNwAtVTrWL2pLFskkSjP/tnKAstS0F
        5FaHcnC9a2myc9Ae8s6GxQbGScg+yImU8xPe77Bl3wuvSMEdidQwykoVjHH3fkyMIkupVCfp6vsRm
        SdVJ+xVQ==;
Received: from [::1] (port=58904 helo=server53.web-hosting.com)
        by server53.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <webmaster@zedlx.com>)
        id 1i7MgE-001KhY-JJ
        for linux-btrfs@vger.kernel.org; Mon, 09 Sep 2019 12:38:25 -0400
Received: from [95.178.242.92] ([95.178.242.92]) by server53.web-hosting.com
 (Horde Framework) with HTTPS; Mon, 09 Sep 2019 12:38:18 -0400
Date:   Mon, 09 Sep 2019 12:38:18 -0400
Message-ID: <20190909123818.Horde.dbl-yi_cNi8aKDaW_QYXVij@server53.web-hosting.com>
From:   webmaster@zedlx.com
To:     linux-btrfs@vger.kernel.org
Subject: Re: Feature requests: online backup - defrag - change RAID level
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
 <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com>
 <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
 <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com>
In-Reply-To: <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com>
Reply-to: webmaster@zedlx.com
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
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

>>>> 2) Sensible defrag
>>>> The defrag is currently a joke.
>>
>> Maybe there are such cases, but I would say that a vast majority of
>> users (99,99%) in a vast majority of cases (99,99%) don't want the
>> defrag operation to reduce free disk space.
>>
>>> What's wrong with current file based defrag?
>>> If you want to defrag a subvolume, just iterate through all files.
>>
>> I repeat: The defrag should not decrease free space. That's the 'normal'
>> expectation.
>
> Since you're talking about btrfs, it's going to do CoW for metadata not
> matter whatever, as long as you're going to change anything, btrfs will
> cause extra space usage.
> (Although the final result may not cause extra used disk space as freed
> space is as large as newly allocated space, but to maintain CoW, newly
> allocated space can't overlap with old data)

It is OK for defrag to temporarily decrease free space while defrag  
operation is in progress. That's normal.

> Further more, talking about snapshots with space wasted by extent
> booking, it's definitely possible user want to break the shared extents:
>
> Subvol 257, inode 257 has the following file extents:
> (257 EXTENT_DATA 0)
> disk bytenr X len 16M
> offset 0 num_bytes 4k  << Only 4k is referred in the whole 16M extent.
>
> Subvol 258, inode 257 has the following file extents:
> (257 EXTENT_DATA 0)
> disk bytenr X len 16M
> offset 0 num_bytes 4K  << Shared with that one in subv 257
> (257 EXTENT_DATA 4K)
> disk bytenr Y len 16M
> offset 0 num_bytes 4K  << Similar case, only 4K of 16M is used.
>
> In that case, user definitely want to defrag file in subvol 258, as if
> that extent at bytenr Y can be freed, we can free up 16M, and allocate a
> new 8K extent for subvol 258, ino 257.
> (And will also want to defrag the extent in subvol 257 ino 257 too)

You are confusing the actual defrag with a separate concern, let's  
call it 'reserved space optimization'. It is about partially used  
extents. The actual name 'reserved space optimization' doesn't matter,  
I just made it up.

'reserved space optimization' is usually performed as a part of the  
defrag operation, but it doesn't have to be, as the actual defrag is  
something separate.

Yes, 'reserved space optimization' can break up extents.

'reserved space optimization' can either decrease or increase the free  
space. If the algorithm determines that more space should be reserved,  
than free space will decrease. If the algorithm determines that less  
space should be reserved, than free space will increase.

The 'reserved space optimization' can be accomplished such that the  
free space does not decrease, if such behavior is needed.

Also, the defrag operation can join some extents. In my original example,
the extents e33 and e34 can be fused into one.

> That's why knowledge in btrfs tech details can make a difference.
> Sometimes you may find some ideas are brilliant and why btrfs is not
> implementing it, but if you understand btrfs to some extent, you will
> know the answer by yourself.

Yes, it is true, but what you are posting so far are all 'red  
herring'-type arguments. It's just some irrelevant concerns, and you  
just got me explaining thinks like I would to a little baby. I don't  
know whether I stumbled on some rookie member of btrfs project, or you  
are just lazy and you don't want to think or consider my proposals.

When I post an explanation, please try to UNDERSTAND HOW IT CAN WORK,  
fill in the missing gaps, because there are tons of them, because I  
can't explain everything via three e-mail posts. Don't just come up  
with some half-baked, forced, illogical reason why things are better  
as they are.

>>>> - I think it would be wrong to use a general deduplication algorithm for
>>>> this. Instead, the information about the shared extents should be
>>>> analyzed given the starting state of the filesystem, and than the
>>>> algorithm should produce an optimal solution based on the currently
>>>> shared extents.
>>>
>>> Please be more specific, like giving an example for it.
>>
>> Let's say that there is a file FFF with extents e11, e12, e13, e22, e23,
>> e33, e34
>> - in subvolA the file FFF consists of e11, e12, e13
>> - in subvolB the file FFF consists of e11, e22, e23
>> - in subvolC the file FFF consists of e11, e22, e33, e34
>>
>> After defrag, where 'selected subvolume' is subvolC, the extents are
>> ordered on disk as follows:
>>
>> e11,e22,e33,e34 - e23 - e12,e13
>
> Inode FFF in different subvolumes are different inodes. They have no
> knowledge of other inodes in other subvolumes.

You can easily notice that, if necessary, the defrag algorithm can  
work without this knowledge, that is, without knowledge of other  
versions of FFF.

This time I'm leaving it to you to figure out how.

Another red herring.

> If FFF in subvol C is e11, e22, e33, e34, then that's it.
> I didn't see the point still.

Now I need to explain like I would to a baby.

If the extents e11, e22, e33, e34 are stored in neighbouring sectors,  
then the disk data reads are faster because they become sequential, as  
opposed to spread out.

So, while the file FFF in subvolC still has 4 extents like it had  
before defrag, reading of those 4 extents is much faster than before  
because the read can be sequential.

So, the defrag can actually be performed without fusing any extents.  
It would still have a noticeable performance benefit.

As I have already said, the defrag operation can join(fuse) some  
extents. In my original example,
the extents e33 and e34 can be fused into one.

> And what's the on-disk bytenr of all these extents? Which has larger
> bytenr and length?

For the sake of simplicity, let's say that all the extents in the  
example have equal length (so, you can choose ANY size), and are fully  
used.

> Please provide a better description like xfs_io -c "fiemap -v" output
> before and after.

No. My example is simple and clear. Nit-picking, like this you are  
doing, is not helpful. Concentrate, think, try to figure it out.

>>> That's a shortcut for chunk profile change.
>>> My first idea of this is, it could cause more problem than benefit.
>>> (It only benefits profile downgrade, thus only makes sense for
>>> RAID1->SINGLE, DUP->SINGLE, and RAID10->RAID0, nothing else)
>>
>> Those listed cases are exactly the ones I judge to be most important.
>> Three important cases.
>
> I'd argue it's downgrade, not that important. As most users want to
> replace the missing/bad device and maintain the raid profile.
>
>> What I am complaining about is that at one point in time, after issuing
>> the command:
>>     btrfs balance start -dconvert=single -mconvert=single
>> and before issuing the 'btrfs delete', the system could be in a too
>> fragile state, with extents unnecesarily spread out over two drives,
>> which is both a completely unnecessary operation, and it also seems to
>> me that it could be dangerous in some situations involving potentially
>> malfunctioning drives.
>
> In that case, you just need to replace that malfunctioning device other
> than fall back to SINGLE.

You are assuming that user has the time and money to replace the  
malfunctioning drive. In A LOT of cases, this is not true.

What if the drive is failing, but the user has some important work to  
do finish.
He has a presentation to perform. He doesn't want the presentation to  
be interrupted by a failing disk drive.

What if the user doesn't have any spare SATA cables on hand?

What if user doesn't have any space space in the case? What if it is a  
laptop computer?

While a user might want to maintain a RAID1 long-term, in the short  
term he might want to perform a downgrade.




