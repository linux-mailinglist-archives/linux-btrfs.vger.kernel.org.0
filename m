Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9110AECB4
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Sep 2019 16:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387973AbfIJOO1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Sep 2019 10:14:27 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:41005 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387967AbfIJOO0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Sep 2019 10:14:26 -0400
Received: by mail-ed1-f42.google.com with SMTP id z9so17244820edq.8
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Sep 2019 07:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NSLLliC04D6hFoT7iWXnu0BD7DPIjIl4mqHu8Gz3b44=;
        b=c6+wHfTIR347P7N2gDD1iVv4oql8SeFq1H0dkKoEWsDLyLtMwYmSbA+fyDb9Uh6Z0j
         d6be+TgrM1PKeIewtGrBSbdn0/DHAhg/MrQpIxBm4e8AYZ65HcoB8ENMYETg/eeik/gv
         R7jGb27wYKuy5DTlIs8MUJdtRQOGgbLpzRUoo09PwWvcLTa0AuJNidxy7ICBd96fB4RK
         YZQxX28lT9oIChkQgwF9n8PkvjhXyGjaThzQeNO2+ZrIuNMXmHGItDaJWeEB6XEO4g4c
         n0vVeHRyWX3FVcCwQS9XumAe2NozFJsvvHuJJXW6XAPybIqdgJ23VgFYt5/hfAQiKupE
         G/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NSLLliC04D6hFoT7iWXnu0BD7DPIjIl4mqHu8Gz3b44=;
        b=J4asEghGScvFMqer+SN5cJ3mCJzNdLbU0lILmKo0bPm7bhj/shDmHxBcN2WQ9vdZFd
         6OeNE+LqH7TZ76q4gn3un2AgZsQydtDCyUWdz4ABiB7yqT/UmS7ilAjVLSjolZAZPMzG
         xoU0INK+hOV2JoT/NPH+cCKKSJt6C1GDr9Ifp2nXNNnLnyBNkv6OqyGxeJIpT/mXTkR6
         /oOiyK1R6LI6gKoD0qRdLuHswku2jrkVDI/Jvk7OMsZAw0MrGfKDfMruH2lVGE7lFzYE
         SGixDPOGYYYau8cA16fRXivSal+FGSJVfAZdKZvxtJ8hVisUnZFiA2NCUIQ7Js2shoIH
         1eWA==
X-Gm-Message-State: APjAAAU7tjgQHKsrFhGiSKB+YiRAmDDBjXWny51Z/s3TO8GlD8Tk65Em
        x2ILpXr/F0N3cFsHlgjYdAZwgSMs
X-Google-Smtp-Source: APXvYqw+7Ch+ub/YSfbpIOB3a+EnhwCHWxSxFIrSk8xi8m0gEYbuNvovwSZJpb2XyXP86CXuwFqi5Q==
X-Received: by 2002:a17:906:6d2:: with SMTP id v18mr8881473ejb.249.1568124864022;
        Tue, 10 Sep 2019 07:14:24 -0700 (PDT)
Received: from [10.20.1.223] (ivokamhome.ddns.nbis.net. [87.120.136.31])
        by smtp.gmail.com with ESMTPSA id h3sm486556ejp.77.2019.09.10.07.14.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 07:14:21 -0700 (PDT)
Subject: Re: Feature requests: online backup - defrag - change RAID level
To:     webmaster@zedlx.com
Cc:     linux-btrfs@vger.kernel.org
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
From:   Nikolay Borisov <n.borisov.lkml@gmail.com>
Message-ID: <0450e0d8-6c37-dc72-5987-bf92eeb8c4ef@gmail.com>
Date:   Tue, 10 Sep 2019 17:14:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190909233248.Horde.lTF4WXM9AzBZdWueqc2vsIZ@server53.web-hosting.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.09.19 г. 6:32 ч., webmaster@zedlx.com wrote:
> 
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
>>           A (subvol 257)     B (Subvol 258, snapshot of 257)
>>           |    \        /    |
>>           |        X         |
>>           |    /        \    |
>>           C                  D
>>          / \                / \
>>         E   F              G   H
>>
>> In extent tree, E is only referred by subvol 257.
>> While C has two referencers, 257 and 258.
>>
>> So in reality, you need to:
>> 1) Do a tree search from subvol 257
>>    You got a path, E -> C -> A
>> 2) Check each node to see if it's shared.
>>    E is only referred by C, no extra referencer.
>>    C is refered by two new tree blocks, A and B.
>>    A is refered by subvol 257.
>>    B is refered by subvol 258.
>>    So E is shared by 257 and 258.
>>
>> Now, you see how things would go mad, for each extent you must go that
>> way to determine the real owner of each extent, not to mention we can
>> have at most 8 levels, tree blocks at level 0~7 can all be shared.
>>
>> If it's shared by 1000 subvolumes, hope you had a good day then.
> 
> Ok, let's do just this issue for the time being. One issue at a time. It
> will be easier.
> 
> The solution is to temporarily create a copy of the entire backref-tree
> in memory. To create this copy, you just do a preorder depth-first
> traversal following only forward references.
> 
> So this preorder depth-first traversal would visit the nodes in the
> following order:
> A,C,E,F,D,G,H,B
> 
> Oh, it is not a tree, it is a DAG in that example of yours. OK, preorder
> is possible on DAG, too. But how did you get a DAG, shouldn't it be all
> trees?
> 
> When you have the entire backref-tree (backref-DAG?) in memory, doing a
> backref-walk is a piece of cake.
> 
> Of course, this in-memory backref tree has to be kept in sync with the
> filesystem, that is it has to be updated whenever there is a write to
> disk. That's not so hard.

Great, now that you have devised a solution and have plenty of
experience writing code why not try and contribute to btrfs?

