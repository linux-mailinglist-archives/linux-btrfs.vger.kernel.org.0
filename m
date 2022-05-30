Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9E25388C2
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 May 2022 00:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242406AbiE3WBC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 May 2022 18:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237737AbiE3WBB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 May 2022 18:01:01 -0400
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [213.138.97.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A956A02B
        for <linux-btrfs@vger.kernel.org>; Mon, 30 May 2022 15:00:56 -0700 (PDT)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id 263F89B8C9; Mon, 30 May 2022 23:00:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1653948054;
        bh=QP1fu4dme3G44qKSBDjChsuWzkjECocLrEkcpN6p6Dg=;
        h=Date:From:Subject:To:References:In-Reply-To:From;
        b=Q87+ZImg0mtxy7KQwk+oU7kg3opgaoMQipNMOkVzWdqXaWk5QdQZsCnBFzlgg+ah6
         NdrNoxmwE3wIvz7KEnemtv1TWHl8+P3h2UnRxnPfWei31nHWRfG73RxSyLJLohgxB3
         pl2CEoLH5+X8foEnyOYY+BN9jShBz9ebXJorEcXiAkdzZF/DqLGqnFoEdC7UmUs/jT
         Bpk9gnjLHaQEYyayXZB0BNzKz5JtKEAilSYopNBypMZMFFtmV+uPHV4QIk+7SgFjEM
         b6kn+Bg2HNHf6ArnA11YgsoDDbYLY+aI0R4XmvksBpbMVtcLibk9eLbsfCHY070x6F
         7vDfqtdTKd/Qg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id 527DF9B707;
        Mon, 30 May 2022 22:59:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1653947997;
        bh=QP1fu4dme3G44qKSBDjChsuWzkjECocLrEkcpN6p6Dg=;
        h=Date:From:Subject:To:References:In-Reply-To:From;
        b=UeAOe+qcdtabP9QJqf7URpaVw1w99k6Pf971P7u0jHdjFdOAUtjhBwnDMlyPI+TG7
         uGIu5jutO6YbfypNXmDquBrLNo8Ds37qpVFDZid7h8jwhbXblwWcAp4eEHT8ZVr5HO
         SvmdbhzqxQZ35grap4BW4IPhmA9VAZpt6/MQEMSD2UeehHyOb9YHU+PN7gm7F873Xo
         3RKFzKLZbOirvaVVADrng5oWYKqETnJtIP1VAjE+vyxx1oK7cFW2Vg2r0Q//IgL6vG
         Fxqz2Q4sXnrXieYfIM5Aq3mFti7UdjaiUmN+byfG9P7s/qNcjxfFecN8FOiTr6A7KN
         ExeWBZ+pJRrdg==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id 160EB1764E0;
        Mon, 30 May 2022 22:59:57 +0100 (BST)
Message-ID: <fbc263ea-1d85-50b2-1968-f37065e8bb97@cobb.uk.net>
Date:   Mon, 30 May 2022 22:59:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Graham Cobb <g.btrfs@cobb.uk.net>
Subject: Re: Tried to replace a drive in a raid 1 and all hell broke loose
Content-Language: en-US
To:     Forza <forza@tnonline.net>, efkf <efkf@firemail.cc>,
        Nicholas D Steeves <nsteeves@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <9a9d16a133c13bed724f2a6a406bd3b6@firemail.cc>
 <5fd50e9.def5d621.180f273d002@tnonline.net>
 <f39a23c9fe32b5ae79ddbe67e1edb7a8@firemail.cc>
 <af34ef558ea7bbd414b5a076128b1011@firemail.cc>
 <b713b9540ad29a83a3c2c672139d6e6f@firemail.cc>
 <CAJCQCtT_PjKprryxHwsyn3qXc06qFFmnMR48CxZuvav8aQUOQQ@mail.gmail.com>
 <87tu99h0ic.fsf@DigitalMercury.freeddns.org>
 <6685a5e4-6d03-6108-1394-0f75f6433c9e@firemail.cc>
 <4bad94f3-7cf2-6224-6876-7a1e3fe5abcd@tnonline.net>
In-Reply-To: <4bad94f3-7cf2-6224-6876-7a1e3fe5abcd@tnonline.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On 30/05/2022 21:47, Forza wrote:
> 
> 
> On 2022-05-29 22:48, efkf wrote:
>> On 5/28/22 21:20, Nicholas D Steeves wrote:
>>> Efkf, would you please confirm if the filesystem was created with Linux
>>> and btrfs-progs 5.10.x? (please keep me in CC)
>> It was created under linux and I'm 99% sure kernel 5.10.0 and
>> btrfs-progs 5.10.1
>> It was surely that configuration when I started messing with it.
>> Now that i think about it i had mounted degraded when i had initially
>> created the filesystem so maybe single metadata got created and has
>> been bitrotting away since.
>> If that's the case though it didn't cause any problems before running
>> the first balance command after which everything went downhill.
>>
>>
>> On 5/27/22 22:37, Forza wrote:
>>>> Anyway, is there a way to check the data is really redundant without
>>>> trusting the filesystem telling me it's so?
>>>
>>> Yes, you use 'btrfs scrub' to read all data and metadata blocks from
>>> all devices and compare the checksums. If there are problems, scrub
>>> will tell you.
>>>
>>> https://btrfs.readthedocs.io/en/latest/btrfs-scrub.html
>>> https://wiki.tnonline.net/w/Btrfs/Scrub
>>>
>>
>> Yeah but that relies on me having actually set up RAID1.
>> The point I'm trying to make is that as a beginner who learns as they
>> go you don't know what you don't know so maybe there is some detail
>> you don't know about that's making your data unsafe . (in this case
>> scrubbing without checking if the whole filesystem is raid1, I assumed
>> it was set in stone from the fs's creation)
> 
> Indeed. Btrfs supports multiple profiles, and a combination of profiles
> as you discovered. Some Btrfs tools do show a warning on multiple
> profiles detected.
> 
>> I should have read more about it but i think there will be more new
>> users that will try what i did to sanity check their setup so in my
>> opinion it would be important to make it so that if you don't write to
>> the FS, especially if you mount it read only it should be safe to
>> mount degraded and not put any data in jeopardy.
>>
> 
> I had a discussion with some Windows users, and they did exactly the
> same thing - yanked the mirror out and then inserted it again. 4 times
> out of 5 it "worked" and they got upset when it didn't work the last time.
> 
> So, with that said, there is room to improve documentation, man pages
> and guides to help users find the information they need to check their
> system correctly.
> 
> For now, mounting each mirror independently and then combine them again
> is not good for Btrfs. This use-case seems to be unhandled.

Sounds like btrfs should do something like assign the filesystem a
completely new UUID (updated onto all the superblocks present at the
time) if you mount degraded. To prevent any disks not present at that
time from being reintroduced later.

A bit drastic but that is what is really happening with a degraded
mount: you are creating a new filesystem, with some of the contents
inherited from an old one, and some missing.

Graham
