Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D31EAAF2F5
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 00:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbfIJWfw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Sep 2019 18:35:52 -0400
Received: from server53-3.web-hosting.com ([198.54.126.113]:38765 "EHLO
        server53-3.web-hosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725942AbfIJWfw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Sep 2019 18:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=zedlx.com;
         s=default; h=Content-Transfer-Encoding:MIME-Version:Content-Type:Reply-to:
        In-Reply-To:References:Subject:Cc:To:From:Message-ID:Date:Sender:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=y+SmcSIhT98aOwyS6ipyF/8BpHjMmcNydVHNu5Vk5IE=; b=PTjOIhghKGcD8btPE0O1RaB1xs
        j21oJRzYIyM5ZXNhLs3wlScvB1mCrm9V2EUvU8E/IjDCvmYLV0jF1KhGq80zceZFDDQ0qB88NYSwe
        sCE23Kykl/oqvgdvMtTpMzFHShIaFi/OllrDncFcN8hkYy5CW/Coc7x6j3NAW2B5NNZ3dQtj7WKko
        P+SB8BH9AgCHjoNuRho/gqOteJH78Xj8UzaL04BfFboDuf0z8s/viNNXpyP0lp+634PbPhs6bErE4
        FG3rlPAvS9s2tVg1wNXDZ83X2AR69h0wK9uXrGPWEDGGRVNAJxo4qk18B6tIk554qkTp6QTXXZWum
        4hmJ1fDw==;
Received: from [::1] (port=53992 helo=server53.web-hosting.com)
        by server53.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <webmaster@zedlx.com>)
        id 1i7oji-002hzq-EW; Tue, 10 Sep 2019 18:35:51 -0400
Received: from [95.178.242.92] ([95.178.242.92]) by server53.web-hosting.com
 (Horde Framework) with HTTPS; Tue, 10 Sep 2019 18:35:46 -0400
Date:   Tue, 10 Sep 2019 18:35:46 -0400
Message-ID: <20190910183546.Horde.QoJ4NOAAxdCw46gLRejnHRv@server53.web-hosting.com>
From:   webmaster@zedlx.com
To:     Nikolay Borisov <n.borisov.lkml@gmail.com>
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
 <20190909212434.Horde.S2TAotDdK47dqQU5ejS2402@server53.web-hosting.com>
 <3978da3b-bb62-4995-bc46-785446d59265@gmx.com>
 <20190909233248.Horde.lTF4WXM9AzBZdWueqc2vsIZ@server53.web-hosting.com>
 <0450e0d8-6c37-dc72-5987-bf92eeb8c4ef@gmail.com>
In-Reply-To: <0450e0d8-6c37-dc72-5987-bf92eeb8c4ef@gmail.com>
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


Quoting Nikolay Borisov <n.borisov.lkml@gmail.com>:


>>>
>>> You're exactly in the pitfall of btrfs backref walk.
>>>
>>> For btrfs, it's definitely not an easy work to do backref walk.
>>> btrfs uses hidden backref, that means, under most case, one extent
>>> shared by 1000 snapshots, in extent tree (shows the backref) it can
>>> completely be possible to only have one ref, for the initial subvolume.
>>>
>>> For btrfs, you need to walk up the tree to find how it's shared.
>>>
>>> It has to be done like that, that's why we call it backref-*walk*.
>>>
>>> E.g
>>>           A (subvol 257)     B (Subvol 258, snapshot of 257)
>>>           |    \        /    |
>>>           |        X         |
>>>           |    /        \    |
>>>           C                  D
>>>          / \                / \
>>>         E   F              G   H
>>>
>>> In extent tree, E is only referred by subvol 257.
>>> While C has two referencers, 257 and 258.
>>>
>>> So in reality, you need to:
>>> 1) Do a tree search from subvol 257
>>>    You got a path, E -> C -> A
>>> 2) Check each node to see if it's shared.
>>>    E is only referred by C, no extra referencer.
>>>    C is refered by two new tree blocks, A and B.
>>>    A is refered by subvol 257.
>>>    B is refered by subvol 258.
>>>    So E is shared by 257 and 258.
>>>
>>> Now, you see how things would go mad, for each extent you must go that
>>> way to determine the real owner of each extent, not to mention we can
>>> have at most 8 levels, tree blocks at level 0~7 can all be shared.
>>>
>>> If it's shared by 1000 subvolumes, hope you had a good day then.
>>
>> Ok, let's do just this issue for the time being. One issue at a time. It
>> will be easier.
>>
>> The solution is to temporarily create a copy of the entire backref-tree
>> in memory. To create this copy, you just do a preorder depth-first
>> traversal following only forward references.
>>
>> So this preorder depth-first traversal would visit the nodes in the
>> following order:
>> A,C,E,F,D,G,H,B
>>
>> Oh, it is not a tree, it is a DAG in that example of yours. OK, preorder
>> is possible on DAG, too. But how did you get a DAG, shouldn't it be all
>> trees?
>>
>> When you have the entire backref-tree (backref-DAG?) in memory, doing a
>> backref-walk is a piece of cake.
>>
>> Of course, this in-memory backref tree has to be kept in sync with the
>> filesystem, that is it has to be updated whenever there is a write to
>> disk. That's not so hard.
>
> Great, now that you have devised a solution and have plenty of
> experience writing code why not try and contribute to btrfs?

First, that is what I'm just doing. I'm contributing to discussion on  
most needed features of btrfs. I'm helping you to get on the right  
track and waste less time on unimportant stuff.

You might appreciate my help, or not, but I am trying to help.

What you probaby wanted to say is that you would like me to contribute  
by writing code, pro bono. Unfortunately, I work for money as does the  
99% of the population. Why not contribute for free? For the same  
reason why the rest of the population doesn't work for free. And, I'm  
not going from door to door and buggin everyone with "why don't you  
work for free", "why don't you help this noble cause..." blah. Makes  
no sense to me.


