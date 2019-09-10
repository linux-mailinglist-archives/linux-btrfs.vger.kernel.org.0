Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99E11AF306
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 00:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfIJWsx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Sep 2019 18:48:53 -0400
Received: from server53-3.web-hosting.com ([198.54.126.113]:41535 "EHLO
        server53-3.web-hosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725937AbfIJWsx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Sep 2019 18:48:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=zedlx.com;
         s=default; h=Content-Transfer-Encoding:MIME-Version:Content-Type:Reply-to:
        In-Reply-To:References:Subject:To:From:Message-ID:Date:Sender:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=vPXNuZpRc0jlCuxv+qdZuRR8K1ADlxVlgXhcsSnP8lA=; b=lfyHJg6qtlWCTLRyCi6qzAPVfD
        RAPx22RTNh4yXOm41x4pt7tLckwM+so0BrxvuB67+qnF2yv2e4HVFercqOwl19WsOBPlk29Kgnon5
        CnGjU0au8yJUFyYWV3BsyppEBza+uE/Z30A9MexCsytv8D1E3M863jRVJnP5Hvg9OUGi2yP3u0Dit
        GbWLpRyg3q9lmwZ99hFIodQYqH9P+f6nwHmG6AFTQc2A6i2egd8V0IVQe9L/UZNfV9XxTrqsI0qYL
        dN3yK7twPdG17i/WstH2tqqAgOgFxjLbKGWZaxjdoIarpWgg91VJV+QiAYClkuj0/FSE38cfjh/Y8
        BZgv8vDg==;
Received: from [::1] (port=56090 helo=server53.web-hosting.com)
        by server53.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <webmaster@zedlx.com>)
        id 1i7owK-002pbw-I2; Tue, 10 Sep 2019 18:48:52 -0400
Received: from [95.178.242.92] ([95.178.242.92]) by server53.web-hosting.com
 (Horde Framework) with HTTPS; Tue, 10 Sep 2019 18:48:48 -0400
Date:   Tue, 10 Sep 2019 18:48:48 -0400
Message-ID: <20190910184848.Horde.rBGwfijOZ6nuE9QjuRAmbp4@server53.web-hosting.com>
From:   webmaster@zedlx.com
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re: Feature requests: online backup - defrag - change RAID level
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
 <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com>
 <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
 <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com>
 <20190909123818.Horde.dbl-yi_cNi8aKDaW_QYXVij@server53.web-hosting.com>
 <ba5f9d6c-aa6c-c9b2-76d2-3ca56606fcc5@gmx.com>
 <20190909200638.Horde.GlzWP3_SqKPkxpAfp05Rsz7@server53.web-hosting.com>
 <3666d54b-76f7-9eee-4fb6-36c1dcc37fe9@gmx.com>
 <20190909212434.Horde.S2TAotDdK47dqQU5ejS2402@server53.web-hosting.com>
 <3978da3b-bb62-4995-bc46-785446d59265@gmx.com>
 <20190909233248.Horde.lTF4WXM9AzBZdWueqc2vsIZ@server53.web-hosting.com>
In-Reply-To: <20190909233248.Horde.lTF4WXM9AzBZdWueqc2vsIZ@server53.web-hosting.com>
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


Quoting webmaster@zedlx.com:

> Quoting Qu Wenruo <quwenruo.btrfs@gmx.com>:
>
>> On 2019/9/10 上午9:24, webmaster@zedlx.com wrote:
>>>
>>> Quoting Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>>
>>>>>> Btrfs defrag works by creating new extents containing the old data.
>>>>>>
>>>>>> So if btrfs decides to defrag, no old extents will be used.
>>>>>> It will all be new extents.
>>>>>>
>>>>>> That's why your proposal is freaking strange here.
>>>>>
>>>>> Ok, but: can the NEW extents still be shared?
>>>>
>>>> Can only be shared by reflink.
>>>> Not automatically, so if btrfs decides to defrag, it will not be shared
>>>> at all.
>>>>
>>>>> If you had an extent E88
>>>>> shared by 4 files in different subvolumes, can it be copied to another
>>>>> place and still be shared by the original 4 files?
>>>>
>>>> Not for current btrfs.
>>>>
>>>>> I guess that the
>>>>> answer is YES. And, that's the only requirement for a good defrag
>>>>> algorithm that doesn't shrink free space.
>>>>
>>>> We may go that direction.
>>>>
>>>> The biggest burden here is, btrfs needs to do expensive full-backref
>>>> walk to determine how many files are referring to this extent.
>>>> And then change them all to refer to the new extent.
>>>
>>> YES! That! Exactly THAT. That is what needs to be done.
>>>
>>> I mean, you just create an (perhaps associative) array which links an
>>> extent (the array index contains the extent ID) to all the files that
>>> reference that extent.
>>
>> You're exactly in the pitfall of btrfs backref walk.
>>
>> For btrfs, it's definitely not an easy work to do backref walk.
>> btrfs uses hidden backref, that means, under most case, one extent
>> shared by 1000 snapshots, in extent tree (shows the backref) it can
>> completely be possible to only have one ref, for the initial subvolume.
>>
>> For btrfs, you need to walk up the tree to find how it's shared.
>>
>> It has to be done like that, that's why we call it backref-*walk*.
>>
>> E.g
>>          A (subvol 257)     B (Subvol 258, snapshot of 257)
>>          |    \        /    |
>>          |        X         |
>>          |    /        \    |
>>          C                  D
>>         / \                / \
>>        E   F              G   H
>>
>> In extent tree, E is only referred by subvol 257.
>> While C has two referencers, 257 and 258.
>>
>> So in reality, you need to:
>> 1) Do a tree search from subvol 257
>>   You got a path, E -> C -> A
>> 2) Check each node to see if it's shared.
>>   E is only referred by C, no extra referencer.
>>   C is refered by two new tree blocks, A and B.
>>   A is refered by subvol 257.
>>   B is refered by subvol 258.
>>   So E is shared by 257 and 258.
>>
>> Now, you see how things would go mad, for each extent you must go that
>> way to determine the real owner of each extent, not to mention we can
>> have at most 8 levels, tree blocks at level 0~7 can all be shared.
>>
>> If it's shared by 1000 subvolumes, hope you had a good day then.
>
> Ok, let's do just this issue for the time being. One issue at a  
> time. It will be easier.
>
> The solution is to temporarily create a copy of the entire  
> backref-tree in memory. To create this copy, you just do a preorder  
> depth-first traversal following only forward references.
>
> So this preorder depth-first traversal would visit the nodes in the  
> following order:
> A,C,E,F,D,G,H,B
>
> Oh, it is not a tree, it is a DAG in that example of yours. OK,  
> preorder is possible on DAG, too. But how did you get a DAG,  
> shouldn't it be all trees?
>
> When you have the entire backref-tree (backref-DAG?) in memory,  
> doing a backref-walk is a piece of cake.
>
> Of course, this in-memory backref tree has to be kept in sync with  
> the filesystem, that is it has to be updated whenever there is a  
> write to disk. That's not so hard.

Oh, I get why you have a DAG there. Because there are multiple trees,  
one for each subvolume. Each subvolume is a tree, but when you combine  
all subvolumes it is not a tree anymore.

So, I guess this solves this big performance-problem.

I would make this backref-tree an associative array. So, for your  
example, it would contain:

backref['A'] = {subvol 257}
backref['C'] = {'A','B'}
backref['E'] = {'C'}
backref['F'] = {'C'}
backref['D'] = {'A','B'}
backref['G'] = {'D'}
backref['H'] = {'D'}
backref['B'] = {subvol 258}

