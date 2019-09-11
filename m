Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 123FCAF5F9
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 08:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfIKGk6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 02:40:58 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:42865 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfIKGk5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 02:40:57 -0400
Received: by mail-ed1-f53.google.com with SMTP id y91so19557693ede.9
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Sep 2019 23:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vbsILZVQzmzGl7/1bzyiwGGvRROUlsvpnz5J46UysDE=;
        b=Q6YtWRIbEQIDr8zubUuFkbTwbODOTPFqVB6dhJsN0Zhg1AVLQLx+Siln4zvsuELBwr
         C8odOWpmLgvQQ1GAgRY0o9Mixm/l7wNrXn5fAcsOlTm3DVHz5YQVfQ2AvNPeCox/tkUm
         aXRURakFsWDCp42TMuW+fd8MVii16t7oZ3Y/MwmlbznZQILHdc2WpHgm9vcHKf1u7dPk
         ggZ2aQ6F9LbIQWSsL1L+pZFYkN2E64hKfKSjDaRc74Mz3TEoympk7HNSFCO20Xc01Sb/
         92dfjUVg65P0anolelWiqg4HTVPZNlxWn8Yb4XbwMCHT1bnYldCNuuBfYJrvx+g9+6ng
         3NKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vbsILZVQzmzGl7/1bzyiwGGvRROUlsvpnz5J46UysDE=;
        b=UHV3K2E8D7OZcgOIdhDUYGR6xZjTkkK/QVTIX0R9FAdkaY5i5+RMfwLpF9VZ/qqh/O
         s6XRTyfQwLCjQrmm4hyvOpq2eJUjt/C5+86oUQG0FaVMY3TQmUUawCUdnv+/wbNWpINQ
         PwTzlDpTcUzPOIzTZx3yjYQQ7sW8Cvfnkr3B1FR2ajit85vlQiWLi3PuwDSgf2LFGztX
         HXgUD8A973CGbOsEnJMJGFIDcy0nGlsu+BHmZS8YNcRPZD4euxkNZpeF1oYv4BvgTBWt
         kzwlagWaeeFs7uh4MxLWN/SNGCNnuTAzOzTEc8cdFA/OoRpx5t3yaWjBIqCyDwgYsjFj
         FCnw==
X-Gm-Message-State: APjAAAURDlgO0aLtQsoVNQIy4ksm0w8sa1tVV/53nPsf4Qje30VGYnnk
        6B+jNg0qYDxep7olVlf1ahV76Sun
X-Google-Smtp-Source: APXvYqwdJuE8Pd/9CenOFlqJ4Q5hJAsLtfz+K9IVYX2EECdw/HyWjPSw955Y5+IqAD/9sQ/W9wfknQ==
X-Received: by 2002:a17:906:804d:: with SMTP id x13mr27998261ejw.134.1568184054745;
        Tue, 10 Sep 2019 23:40:54 -0700 (PDT)
Received: from [10.20.1.223] (ivokamhome.ddns.nbis.net. [87.120.136.31])
        by smtp.gmail.com with ESMTPSA id x17sm3987320edl.64.2019.09.10.23.40.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 23:40:53 -0700 (PDT)
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
 <0450e0d8-6c37-dc72-5987-bf92eeb8c4ef@gmail.com>
 <20190910183546.Horde.QoJ4NOAAxdCw46gLRejnHRv@server53.web-hosting.com>
From:   Nikolay Borisov <n.borisov.lkml@gmail.com>
Message-ID: <2c88205a-37a3-afdb-fa67-c7962cb308ed@gmail.com>
Date:   Wed, 11 Sep 2019 09:40:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910183546.Horde.QoJ4NOAAxdCw46gLRejnHRv@server53.web-hosting.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11.09.19 г. 1:35 ч., webmaster@zedlx.com wrote:
> 
> Quoting Nikolay Borisov <n.borisov.lkml@gmail.com>:
> 
> 
>>>>
>>>> You're exactly in the pitfall of btrfs backref walk.
>>>>
>>>> For btrfs, it's definitely not an easy work to do backref walk.
>>>> btrfs uses hidden backref, that means, under most case, one extent
>>>> shared by 1000 snapshots, in extent tree (shows the backref) it can
>>>> completely be possible to only have one ref, for the initial subvolume.
>>>>
>>>> For btrfs, you need to walk up the tree to find how it's shared.
>>>>
>>>> It has to be done like that, that's why we call it backref-*walk*.
>>>>
>>>> E.g
>>>>           A (subvol 257)     B (Subvol 258, snapshot of 257)
>>>>           |    \        /    |
>>>>           |        X         |
>>>>           |    /        \    |
>>>>           C                  D
>>>>          / \                / \
>>>>         E   F              G   H
>>>>
>>>> In extent tree, E is only referred by subvol 257.
>>>> While C has two referencers, 257 and 258.
>>>>
>>>> So in reality, you need to:
>>>> 1) Do a tree search from subvol 257
>>>>    You got a path, E -> C -> A
>>>> 2) Check each node to see if it's shared.
>>>>    E is only referred by C, no extra referencer.
>>>>    C is refered by two new tree blocks, A and B.
>>>>    A is refered by subvol 257.
>>>>    B is refered by subvol 258.
>>>>    So E is shared by 257 and 258.
>>>>
>>>> Now, you see how things would go mad, for each extent you must go that
>>>> way to determine the real owner of each extent, not to mention we can
>>>> have at most 8 levels, tree blocks at level 0~7 can all be shared.
>>>>
>>>> If it's shared by 1000 subvolumes, hope you had a good day then.
>>>
>>> Ok, let's do just this issue for the time being. One issue at a time. It
>>> will be easier.
>>>
>>> The solution is to temporarily create a copy of the entire backref-tree
>>> in memory. To create this copy, you just do a preorder depth-first
>>> traversal following only forward references.
>>>
>>> So this preorder depth-first traversal would visit the nodes in the
>>> following order:
>>> A,C,E,F,D,G,H,B
>>>
>>> Oh, it is not a tree, it is a DAG in that example of yours. OK, preorder
>>> is possible on DAG, too. But how did you get a DAG, shouldn't it be all
>>> trees?
>>>
>>> When you have the entire backref-tree (backref-DAG?) in memory, doing a
>>> backref-walk is a piece of cake.
>>>
>>> Of course, this in-memory backref tree has to be kept in sync with the
>>> filesystem, that is it has to be updated whenever there is a write to
>>> disk. That's not so hard.
>>
>> Great, now that you have devised a solution and have plenty of
>> experience writing code why not try and contribute to btrfs?
> 
> First, that is what I'm just doing. I'm contributing to discussion on
> most needed features of btrfs. I'm helping you to get on the right track

"most needed" according to your needs. Again, "right track" according to
you.

> and waste less time on unimportant stuff.

Who decides whether something is important or unimportant?

> 
> You might appreciate my help, or not, but I am trying to help.
> 
> What you probaby wanted to say is that you would like me to contribute
> by writing code, pro bono. Unfortunately, I work for money as does the
> 99% of the population. Why not contribute for free? For the same reason
> why the rest of the population doesn't work for free. And, I'm not going
> from door to door and buggin everyone with "why don't you work for
> free", "why don't you help this noble cause..." blah. Makes no sense to me.

Correct, this boils down there are essentially 2 ways to get something
done in open source - code or money. So far you haven't provided either.
By the same token - why should anyone do, in essence, pro-bono work for
features *you* are specifically interested? Let's not kid ourselves -
that's what this is all about.

So while the discussion you spurred could be somewhat beneficial the
style you use is definitely not. It's, at the very least, grating and
somewhat aggressive. You haven't done any technical work on btrfs yet
when more knowledgeable people, who have spent years(!!!) working on the
code base tell you that there are technical reasons why things are the
way they are you are brisk to dismiss their opinion. Of course they
might very well be wrong - prove it to them, ideally with code.

Given this how do you expect people to be interested in engaging in a
meaningful conversation with you?


