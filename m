Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81AC238C448
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 12:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbhEUKDV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 06:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbhEUKCb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 06:02:31 -0400
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69194C0611A6
        for <linux-btrfs@vger.kernel.org>; Fri, 21 May 2021 02:55:23 -0700 (PDT)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 937F89C3BA; Fri, 21 May 2021 10:55:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1621590916;
        bh=1LqCDrZSi0lEb8kQjtxS6DRdpOqTgVF8NybRvk4eGrQ=;
        h=From:To:Cc:References:Subject:Date:In-Reply-To:From;
        b=IMiCkwmR0Cn+kq19cEeXcD5MVt5y7bNHPYGgjdWL/AWMUU1Mj1wC56fYqOYNpVLAy
         ZZ9UCYEVM9/MJTESzUg6oxaT4Tip8aj3Mbfea/PbpCX7igpHMZ3UdOp+JE3kbQKDPH
         BDkIiofWECkBt8j0lorfszH9XiJ/eXOCCw/rUBo4q0BRXctk4Z5YtMA52YDJYBNhpO
         sUTdZDwm2INwKdz5oQC9znN+HjtKhzIkulnvcPD108Y4HdDfZChZOny5mXr1+pZeMl
         o5gV3BDngqqiipM/cPoog+iGAJbsQv/8aAqPnRQKSRTQY1D5KRZeLl9KczyNDdEO8w
         chZWHp8kZU9hg==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-3.0 required=12.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id DAD489B8C5;
        Fri, 21 May 2021 10:55:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1621590909;
        bh=1LqCDrZSi0lEb8kQjtxS6DRdpOqTgVF8NybRvk4eGrQ=;
        h=From:To:Cc:References:Subject:Date:In-Reply-To:From;
        b=UjBWpWGafTt+Udfp5iqWIDMJhfF6yuIr2jaW3aPfRA8XvNqmVGfMWnfTY54MEF6db
         PxZXGjoEq8X9GGBw/wIkjwnOF5rKuEbLpSp8pUsULhk5Fnb7SdO+kYmLbwsI0NT6CJ
         TqCxnLr9AH9fQfj9fVgwz9ISjyM18BXJ80LAkj8mdr0vfLiNa3P1dPY+gqHxiVs62s
         gBrSj9o1b981f+CpP3Kgq2qlnXTABj9LsYGUAgq7eNX6QsjSj6x6KszlQ/g0B6T4Xu
         5wAMwEZSmVZ0GRuygfIOOAwI9sidvCX523Y0b/7WkDFw1aww0eSrGMYMeMNop5LdmR
         BR5Kimu5EvAiw==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id B1CEC240D9E;
        Fri, 21 May 2021 10:55:09 +0100 (BST)
From:   Graham Cobb <g.btrfs@cobb.uk.net>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <20210518144935.15835-1-dsterba@suse.com>
 <PH0PR04MB741663051770A577220C0C539B2B9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20210519142612.GW7604@twin.jikos.cz>
 <PH0PR04MB74165244AB3C1AC48DF8DF379B2B9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <29d4c680-e484-f0d0-3b25-a64b11f93230@cobb.uk.net>
 <20210521071810.GA11733@hungrycats.org>
Subject: Re: [PATCH] btrfs: scrub: per-device bandwidth control
Message-ID: <cb435867-f054-c2b4-686a-be841eb2157f@cobb.uk.net>
Date:   Fri, 21 May 2021 10:55:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210521071810.GA11733@hungrycats.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/05/2021 08:18, Zygo Blaxell wrote:
> On Wed, May 19, 2021 at 05:20:50PM +0100, Graham Cobb wrote:
>> On 19/05/2021 16:32, Johannes Thumshirn wrote:
>>> On 19/05/2021 16:28, David Sterba wrote:
>>>> On Wed, May 19, 2021 at 06:53:54AM +0000, Johannes Thumshirn wrote:
>>>>> On 18/05/2021 16:52, David Sterba wrote:
>>>>> I wonder if this interface would make sense for limiting balance
>>>>> bandwidth as well?
>>>>
>>>> Balance is not contained to one device, so this makes the scrub case
>>>> easy. For balance there are data and metadata involved, both read and
>>>> write accross several threads so this is really something that the
>>>> cgroups io controler is supposed to do.
>>>>
>>>
>>> For a user initiated balance a cgroups io controller would work well, yes.
> 
> Don't throttle balance.  You can only make _everything_ slower with
> throttling.  You can't be selective, e.g. making balance slower than
> the mail server.
> 
>> Hmmm. I might give this a try. On my main mail server balance takes a
>> long time and a lot of IO, which is why I created my "balance_slowly"
>> script which shuts down mail (and some other services) then runs balance
>> for 20 mins, then cancels the balance and allows mail to run for 10
>> minutes, then resumes the balance for 20 mins, etc. 
>> Using this each month, a balance takes over 24 hours
> 
> My question here is:  wait?  What?  Are you running full balances
> every...ever?  Why?

No, not any more - that was how it worked years ago but nowadays my
scripts are based on btrfs-balance-least-used and end up only balancing
empty or almost empty block groups, data only. It still sometimes slows
disk access for other processes down quite a lot, though. Probably
because I still have some on-disk snapshots causing extra work (although
most are now moved onto a separate disk after about 24 hours).

And I was wrong - my slow balances don't take 24 hours (that is scrub) -
they take a couple of hours.

...

> I run btrfs on some mail servers with crappy spinning drives.
> 
> One balance block group every day--on days when balance runs at all--only
> introduces a one-time 90-second latency.  Not enough to kill a SMTP
> transaction.

Although it happens, the *much* bigger problem than SMTP timeouts is the
error messages that dovecot mail delivery (with or without lmtp)
generates when things get very slow. Sometimes these make it into an
error report confusing the sender significantly! I prefer to just shut
mail down for a while doing the balance. The script uses a timeout to
stop sending block groups to be balanced once a time limit has been
reached, then when the in-progress block group has finished it restarts
mail for a while.

> Backup snapshot deletes generate more latency (2-4 minutes once a day).
> That is long enough to kill a SMTP transaction, but pretty much every
> non-spammer sender will retry sooner than the next backup.
> 
>> Before I did this, the impact was horrible: btrfs spent all its time
>> doing backref searches and any process which touched the filesystem (for
>> example to deliver a tiny email) could be stuck for over an hour.
>>
>> I am wondering whether the cgroups io controller would help, or whether
>> it would cause a priority inversion because the backrefs couldn't do the
>> IO they needed so the delays to other processes locked out would get
>> even **longer**. Any thoughts?
> 
> Yes that is pretty much exactly what happens.
> 
> Balance spends a tiny fraction of its IO cost moving data blocks around.
> Each data extent that is relocated triggers a reference update,
> which goes into a queue for the current btrfs transaction.  On its
> way through that queue, each ref update cascades into updates on other
> tree pages for parent nodes, csum tree items, extent tree items, and
> (if using space_cache=v2) free space tree items.  These are all small
> random writes that have performance costs even on non-rotating media,
> much more expensive than the data reads and writes which are mostly
> sequential and consecutive.  Worst-case write multipliers are 3-digit
> numbers for each of the trees.  It is not impossible for one block group
> relocation--balance less than 1GB of data--to run for _days_.
> 
> On a filesystem with lots of tiny extents (like a mail server), the
> data blocks will be less than 1% of the balance IO.  The other 99%+ are
> metadata updates.  If there is throttling on those, any thread trying
> to write to the filesystem stops dead in the next transaction commit,
> and stays blocked until the throttled IO completes.
> 
> If other threads are writing to the filesystem, it gets even worse:
> the running time of delayed ref flushes is bounded only by available
> disk space, because only running out of disk space can make btrfs stop
> queueing up more work for itself in transaction commit.
> 
> Even threads that aren't writing to the throttled filesystem can get
> blocked on malloc() because Linux MM shares the same pool of pages for
> malloc() and disk writes, and will block memory allocations when dirty
> limits are exceeded anywhere.  This causes most applications (i.e. those
> which call malloc()) to stop dead until IO bandwidth becomes available
> to btrfs, even if the processes never touch any btrfs filesystem.
> Add in VFS locks, and even reading threads block.
> 
> The best currently available approach is to minimize balancing.  Don't do
> it at all if you can avoid it, and do only the bare minimum if you can't.
> 
> On the other hand, a lot of these problems can maybe be reduced or
> eliminated by limiting the number of extents balance processes each time
> it goes through its extent iteration loop.  Right now, balance tries to
> relocate an entire block group in one shot, but maybe that's too much.
> Instead, balance could move a maximum of 100 extents (or some number
> chosen to generate about a second's worth of IO), then do a transaction
> commit to flush out the delayed refs queue while it's still relatively
> small, then repeat.  This would be very crude throttling since we'd have
> to guess how many backrefs each extent has, but it will work far better
> for reducing latency than any throttling based on block IO.
> 

Thanks for the useful analysis Zygo. I think I will stick with my
current approach, for balance at least. I look forward to playing with
the new controls for scrub, though (where I currently use a similar script).

