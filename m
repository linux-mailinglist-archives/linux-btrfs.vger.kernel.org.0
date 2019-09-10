Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72557AE1E2
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2019 03:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390458AbfIJBYk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Sep 2019 21:24:40 -0400
Received: from server53-3.web-hosting.com ([198.54.126.113]:42219 "EHLO
        server53-3.web-hosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727115AbfIJBYk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Sep 2019 21:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=zedlx.com;
         s=default; h=MIME-Version:Content-Type:Reply-to:In-Reply-To:References:
        Subject:Cc:To:From:Message-ID:Date:Sender:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=tFQ92xVkvBIlsa/PCQ/4iV+6XFgPscH5hT3d21CGtRw=; b=KJOAbWiG6CTks0dSd8jPb+r08P
        sOVDnbPGvimJZO9GQeMYdqBgSQSDoDK0AMw8Vno+HPIOm7LfTe+FxibsgTtzn82OytHAJg0i2eNXd
        2IavRHAsRGUGSgFNAFR3OxNRUBkqsc6g3JJi+5bCOyOIkVUcKEDLb4Yy6EFCj6+vGYvNI5Yo1KnAU
        0oMoJnkWnNfU4Mw+nSgnssMDrnPqt0so+MeZe0ysJTK9ss4E/2oXVizgJF5TAueZ6F4dVXupnWYEb
        Y7GkQJikXmUYEdsiB9YLBV9glvtvvSSbtOLuOV8pD8GS950ITCNxWFLhIjLtxZcfueaKXrbS+3oHT
        0qLgIbKg==;
Received: from [::1] (port=60342 helo=server53.web-hosting.com)
        by server53.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <webmaster@zedlx.com>)
        id 1i7UtW-000xZp-ME; Mon, 09 Sep 2019 21:24:39 -0400
Received: from [95.178.242.92] ([95.178.242.92]) by server53.web-hosting.com
 (Horde Framework) with HTTPS; Mon, 09 Sep 2019 21:24:34 -0400
Date:   Mon, 09 Sep 2019 21:24:34 -0400
Message-ID: <20190909212434.Horde.S2TAotDdK47dqQU5ejS2402@server53.web-hosting.com>
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
 <20190909200638.Horde.GlzWP3_SqKPkxpAfp05Rsz7@server53.web-hosting.com>
 <3666d54b-76f7-9eee-4fb6-36c1dcc37fe9@gmx.com>
In-Reply-To: <3666d54b-76f7-9eee-4fb6-36c1dcc37fe9@gmx.com>
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

>>> Btrfs defrag works by creating new extents containing the old data.
>>>
>>> So if btrfs decides to defrag, no old extents will be used.
>>> It will all be new extents.
>>>
>>> That's why your proposal is freaking strange here.
>>
>> Ok, but: can the NEW extents still be shared?
>
> Can only be shared by reflink.
> Not automatically, so if btrfs decides to defrag, it will not be shared
> at all.
>
>> If you had an extent E88
>> shared by 4 files in different subvolumes, can it be copied to another
>> place and still be shared by the original 4 files?
>
> Not for current btrfs.
>
>> I guess that the
>> answer is YES. And, that's the only requirement for a good defrag
>> algorithm that doesn't shrink free space.
>
> We may go that direction.
>
> The biggest burden here is, btrfs needs to do expensive full-backref
> walk to determine how many files are referring to this extent.
> And then change them all to refer to the new extent.

YES! That! Exactly THAT. That is what needs to be done.

I mean, you just create an (perhaps associative) array which links an  
extent (the array index contains the extent ID) to all the files that  
reference that extent.

To initialize it, you do one single walk through the entire b-tree.

Than the data you require can be retrieved in an instant.

> It's feasible if the extent is not shared by many.
> E.g the extent only get shared by ~10 or ~50 subvolumes/files.
>
> But what will happen if it's shared by 1000 subvolumes? That would be a
> performance burden.
> And trust me, we have already experienced such disaster in qgroup,
> that's why we want to avoid such case.

Um, I don't quite get where this 'performance burden' is comming from.  
If you mean that moving a single extent requires rewriting a lot of  
b-trees, than perhaps it could be solved by moving extents in bigger  
batches. So, fo example, you move(create new) extents, but you do that  
for 100 megabytes of extents at the time, then you update the b-trees.  
So then, there would be much less b-tree writes to disk.

Also, if the defrag detects 1000 subvolumes, it can warn the user.

By the way, isn't the current recommendation to stay below 100  
subvolumes?. So if defrag can do 100 subvolumes, that is great. The  
defrag doesn't need to do 1000. If there are 1000 subvolumes, than the  
user should delete most of them before doing defrag.

> Another problem is, what if some of the subvolumes are read-only, should
> we touch it or not? (I guess not)

I guess YES. Except if the user overrides it with some switch.

> Then the defrag will be not so complete. Bad fragmented extents are
> still in RO subvols.

Let the user choose!

> So the devil is still in the detail, again and again.

Ok, let's flesh out some details.

>> I can't understand a defrag that substantially decreases free space. I
>> mean, each such defrag is a lottery, because you might end up with
>> practically unusable file system if the partition fills up.
>>
>> CURRENT DEFRAG IS A LOTTERY!
>>
>> How bad is that?
>>
>
> Now you see why btrfs defrag has problem.
>
> On one hand, guys like you don't want to unshare extents. I understand
> and it makes sense to some extents. And used to be the default behavior.
>
> On the other hand, btrfs has to CoW extents to do defrag, and we have
> extreme cases where we want to defrag shared extents even it's going to
> decrease free space.
>
> And I have to admit, my memory made the discussion a little off-topic,
> as I still remember some older kernel doesn't touch shared extents at all.
>
> So here what we could do is: (From easy to hard)
> - Introduce an interface to allow defrag not to touch shared extents
>   it shouldn't be that difficult compared to other work we are going
>   to do.
>   At least, user has their choice.

That defrag wouldn't acomplish much. You can call it defrag, but it is  
more like nothing happens.

> - Introduce different levels for defrag
>   Allow btrfs to do some calculation and space usage policy to
>   determine if it's a good idea to defrag some shared extents.
>   E.g. my extreme case, unshare the extent would make it possible to
>   defrag the other subvolume to free a huge amount of space.
>   A compromise, let user to choose if they want to sacrifice some space.

Meh. You can always defrag one chosen subvolume perfectly, without  
unsharing any file extents.
So, since it can be done perfectly without unsharing, why unshare at all?

> - Ultimate super-duper cross subvolume defrag
>   Defrag could also automatically change all the referencers.
>   That's why we call it ultimate super duper, but as I already mentioned
>   it's a big performance problem, and if Ro subvolume is involved, it'll
>   go super tricky.

Yes, that is what's needed. I don't really see where the big problem  
is. I mean, it is just a defrag, like any other. Nothing special.
The usual defrag algorithm is somewhat complicated, but I don't see  
why this one is much worse.

OK, if RO subvolumes are tricky, than exclude them for the time being.  
So later, after many years, maybe someone will add the code for this  
tricky RO case.



