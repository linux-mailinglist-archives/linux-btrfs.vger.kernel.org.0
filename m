Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937AC3B1EB3
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jun 2021 18:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhFWQcM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Jun 2021 12:32:12 -0400
Received: from a4-4.smtp-out.eu-west-1.amazonses.com ([54.240.4.4]:58249 "EHLO
        a4-4.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229660AbhFWQcM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Jun 2021 12:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=vbsgq4olmwpaxkmtpgfbbmccllr2wq3g; d=urbackup.org; t=1624465793;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=G+dLdEys3CHk7RnA7ttqZbFHf5LWC644M49Vfh9cvtg=;
        b=C7MuIdAlUS27PnhttZOC1O4oREgZ2XhPIA2vfAbu/HmziTEzSacmKdp4ZTzEJw87
        GS/mwj4oXgEBDjfQI/r4oSIHdHh8VkiXQM55jxezsBZm5eBwg+6Dq825dh7/LFXH7ui
        ZqtNDdqV3m3KuoHFJ12L9FZwR74oi89XQ3wNzGTE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1624465793;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=G+dLdEys3CHk7RnA7ttqZbFHf5LWC644M49Vfh9cvtg=;
        b=S9opb7sKthZsWIU9pame8MhLcxwpZgaaRKa0iTaDMIqWUvf9liLtYETy/ze4uM/u
        cuVUWVYaxVqpInrHiAK+3ecPH11/Agqa3ZRRV0fKIgnWyowpz1ES+f6LSrvyQP8QjoE
        qUGxEFNAspANFQwCzAc87pw9sL+oUmDJ5p6uaZwo=
Subject: Re: Filesystem goes readonly soon after mount, cannot free space or
 rebalance
To:     Asif Youssuff <yoasif@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <2bb832db-3c33-d3ba-d9ae-4ebd44c1c7f3@gmail.com>
 <1b89f8a3-42a4-3c6d-aec8-1b91a7b43713@gmx.com>
 <CAHw5_hk9Uy-q=9n+TvtiCtLH5A08gVo=G4rUhpuQyZwzuF68dQ@mail.gmail.com>
 <60a9b119-c842-9fea-3fb3-5cd29a8869ef@gmx.com>
 <CAHw5_hmN3XTYDhRy4jMfV4YN6jcRZsKs-Q_+K-o3fLhC9MXHJA@mail.gmail.com>
 <06661dd5-520b-c1b5-061e-748e695f98a6@suse.com>
 <CAHw5_hkUhV8OvrdZOWTnQU_ksh3z94+ivskyw_h069HwYhvNXg@mail.gmail.com>
 <CAHw5_hmUda4hO7=sNQNWtSxyyzm7i9MU50nsQkrZRw7fsAW3NA@mail.gmail.com>
 <e12010fe-6881-c01c-f05f-899b8b76c4fd@gmx.com>
 <CAHw5_hmeUWf0RdqXcFjfSEEeK4+jTb1yxRuRB5JSnK1Avha0JQ@mail.gmail.com>
 <83e8fa57-fc20-bc5b-8a63-3153327961a6@gmx.com>
 <CAHw5_hm+UX2EHSdZHcMXWMNYxOtccKMQ1qtfbu1gKUm-WZFXYg@mail.gmail.com>
 <CAJCQCtTW0tR-55UkkE=r0ONQucCO7_An2ASOQeBjZiZXtPrLSg@mail.gmail.com>
 <CAHw5_hnLSwMBqNxE6pPvau+-9LQoCmWp7fy6vuxtT-UPPLL4Fw@mail.gmail.com>
 <4d1f2c32-521a-aab4-7da9-6a0a8d3ecdc6@gmx.com>
 <CAHw5_h=izT2+AzXFK03uETYM2go=mKnSWYkW_5ki-36fkoYaNg@mail.gmail.com>
From:   Martin Raiber <martin@urbackup.org>
Message-ID: <0102017a39b4dff8-4a504c52-d06d-4b60-9a8f-bc606aeab4cc-000000@eu-west-1.amazonses.com>
Date:   Wed, 23 Jun 2021 16:29:53 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHw5_h=izT2+AzXFK03uETYM2go=mKnSWYkW_5ki-36fkoYaNg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
X-SES-Outgoing: 2021.06.23-54.240.4.4
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 23.06.2021 18:24 Asif Youssuff wrote:
> On Wed, Jun 23, 2021 at 5:38 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2021/6/23 下午5:32, Asif Youssuff wrote:
>>> On Tue, Jun 22, 2021 at 5:33 PM Chris Murphy <lists@colorremedies.com> wrote:
>>>> On Tue, Jun 22, 2021 at 12:37 AM Asif Youssuff <yoasif@gmail.com> wrote:
>>>>
>>>>> I went ahead and also created two partitions each on the two new usb
>>>>> disks (for a two of four new partitions) and added them to the btrfs
>>>>> filesystem using "btrfs device add", then removing a snapshot followed
>>>>> by a "btrfs fi sync". The filesystem still goes ro after a while.
>>>> Yeah Qu is correct, and I had it wrong. Two devices have enough space
>>>> for a new metadata BG, but no other disks. And it requires four. All
>>>> you need is to add two but it won't even let you add one before it
>>>> goes ro. So it's stuck. Until there is a kernel fix for this, it's
>>>> permanently read-only (unless we're missing some other work around).
>>> Hmm, would this be something that would be fixed in the near term?
>>> Just wondering how long I'd have to leave this as ro.
>>>
>>> Happy to continue to try any other ideas of course, but I'd rather not
>>> destroy the fs and start over.
>> The problem is, I don't see why we can't do anything, including adding a
>> new device.
>>
>>  From the fi df output, we still have around 512M metadata free space,
>> it means unless there is something wrong with globalrsv, we should be
>> able to add new devices, which doesn't require much new space.
>>
>> For the worst case, I can craft a btrfs-progs program to manually
>> degrade all your RAID1C3/C4 chunks to SINGLE.
>>
>> By that you can have tons of space left, but that should be the last
>> thing to do IMHO.
>>
>> Currently I prefer to find a way to stop all background work like
>> balance/subvolume deletion, and try to add two new devices to the array,
>> then continue.
>>
>> I still can't get why "btrfs device add" would success while "btrfs fi
>> show" shows no new device.
>>
>> The new devices to add are really blank new devices, right? Not some
>> disks already used by btrfs?
> Yes, absolutely. I even formatted them as ext4 and rebooted in order
> to ensure that btrfs processes would not be acting on them until I did
> btrfs device add.
>
> Once I run btrfs device add, the filesystem type shows up in gparted
> as "unknown" - eg:
>
> /dev/sdk1           2048 15187967 15185920  7.2G 83 Linux
> /dev/sdk2       15187968 30375935 15187968  7.2G 83 Linux
>
> I am also adding the devices like what Paul jones suggested - like:
>
> sudo mount /media/camino/ && sudo btrfs device add -f /dev/sdl1
> /dev/sdl2 /dev/sdk1 /dev/sdk2 /media/camino/

Probably not going to help (it's probably a different issue): Maybe try the ENOSPC work-around I currently have to use: https://lore.kernel.org/linux-btrfs/01020178b23f5d07-a1361e3a-6d78-4de6-90bc-4244c38aad89-000000@eu-west-1.amazonses.com/ . I had to double the values again (2 -> 4, 4->8) to make it work reliably.

>
>> Thanks,
>> Qu
>>>>
>>>>> Would mounting as degraded make it possible to add the disks and have
>>>>> it stick?
>>>> No, that's even more fragile and you're sure to run into myriad
>>>> degraded raid5 bugs, not least of which are the bogus errors. And it
>>>> won't be obvious which ones are important and which ones are not.
>>>>
>>>>
>>>> --
>>>> Chris Murphy
>>>
>>>
>
>

