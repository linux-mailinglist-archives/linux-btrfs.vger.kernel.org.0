Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84BA73B174B
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jun 2021 11:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhFWJze convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 23 Jun 2021 05:55:34 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:55086 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbhFWJzd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Jun 2021 05:55:33 -0400
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 767D13F3E9;
        Wed, 23 Jun 2021 11:53:14 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 tagged_above=-999 required=6.31
        tests=[BAYES_00=-1.9, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vXQ4w92QQyD1; Wed, 23 Jun 2021 11:53:13 +0200 (CEST)
Received: by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 1FD283F3D0;
        Wed, 23 Jun 2021 11:53:12 +0200 (CEST)
Received: from [2a00:801:743:75d8::e25b:4359] (port=50332 helo=[10.235.211.81])
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1lvzZH-0006vs-7J; Wed, 23 Jun 2021 11:53:12 +0200
Date:   Wed, 23 Jun 2021 11:53:03 +0200 (GMT+02:00)
From:   Forza <forza@tnonline.net>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Asif Youssuff <yoasif@gmail.com>,
        Chris Murphy <lists@colorremedies.com>
Cc:     Qu Wenruo <wqu@suse.com>, Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Message-ID: <ca5a469.7aece1b4.17a38499062@tnonline.net>
In-Reply-To: <4d1f2c32-521a-aab4-7da9-6a0a8d3ecdc6@gmx.com>
References: <2bb832db-3c33-d3ba-d9ae-4ebd44c1c7f3@gmail.com> <1b89f8a3-42a4-3c6d-aec8-1b91a7b43713@gmx.com> <CAHw5_hk9Uy-q=9n+TvtiCtLH5A08gVo=G4rUhpuQyZwzuF68dQ@mail.gmail.com> <60a9b119-c842-9fea-3fb3-5cd29a8869ef@gmx.com> <CAHw5_hmN3XTYDhRy4jMfV4YN6jcRZsKs-Q_+K-o3fLhC9MXHJA@mail.gmail.com> <06661dd5-520b-c1b5-061e-748e695f98a6@suse.com> <CAHw5_hkUhV8OvrdZOWTnQU_ksh3z94+ivskyw_h069HwYhvNXg@mail.gmail.com> <CAHw5_hmUda4hO7=sNQNWtSxyyzm7i9MU50nsQkrZRw7fsAW3NA@mail.gmail.com> <e12010fe-6881-c01c-f05f-899b8b76c4fd@gmx.com> <CAHw5_hmeUWf0RdqXcFjfSEEeK4+jTb1yxRuRB5JSnK1Avha0JQ@mail.gmail.com> <83e8fa57-fc20-bc5b-8a63-3153327961a6@gmx.com> <CAHw5_hm+UX2EHSdZHcMXWMNYxOtccKMQ1qtfbu1gKUm-WZFXYg@mail.gmail.com> <CAJCQCtTW0tR-55UkkE=r0ONQucCO7_An2ASOQeBjZiZXtPrLSg@mail.gmail.com> <CAHw5_hnLSwMBqNxE6pPvau+-9LQoCmWp7fy6vuxtT-UPPLL4Fw@mail.gmail.com> <4d1f2c32-521a-aab4-7da9-6a0a8d3ecdc6@gmx.com>
Subject: Re: Filesystem goes readonly soon after mount, cannot free space or
 rebalance
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Mailer: R2Mail2
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Would it be possible to be really quick to add new devices? Something like :

 mount /mnt/foo && btrfs device add -K /dev/newdisk1 /dev/newdisk2 /mnt/foo

---- From: Qu Wenruo <quwenruo.btrfs@gmx.com> -- Sent: 2021-06-23 - 11:37 ----

> 
> 
> On 2021/6/23 下午5:32, Asif Youssuff wrote:
>> On Tue, Jun 22, 2021 at 5:33 PM Chris Murphy <lists@colorremedies.com> wrote:
>>>
>>> On Tue, Jun 22, 2021 at 12:37 AM Asif Youssuff <yoasif@gmail.com> wrote:
>>>
>>>> I went ahead and also created two partitions each on the two new usb
>>>> disks (for a two of four new partitions) and added them to the btrfs
>>>> filesystem using "btrfs device add", then removing a snapshot followed
>>>> by a "btrfs fi sync". The filesystem still goes ro after a while.
>>>
>>> Yeah Qu is correct, and I had it wrong. Two devices have enough space
>>> for a new metadata BG, but no other disks. And it requires four. All
>>> you need is to add two but it won't even let you add one before it
>>> goes ro. So it's stuck. Until there is a kernel fix for this, it's
>>> permanently read-only (unless we're missing some other work around).
>>
>> Hmm, would this be something that would be fixed in the near term?
>> Just wondering how long I'd have to leave this as ro.
>>
>> Happy to continue to try any other ideas of course, but I'd rather not
>> destroy the fs and start over.
> 
> The problem is, I don't see why we can't do anything, including adding a
> new device.
> 
>  From the fi df output, we still have around 512M metadata free space,
> it means unless there is something wrong with globalrsv, we should be
> able to add new devices, which doesn't require much new space.
> 
> For the worst case, I can craft a btrfs-progs program to manually
> degrade all your RAID1C3/C4 chunks to SINGLE.
> 
> By that you can have tons of space left, but that should be the last
> thing to do IMHO.
> 
> Currently I prefer to find a way to stop all background work like
> balance/subvolume deletion, and try to add two new devices to the array,
> then continue.
> 
> I still can't get why "btrfs device add" would success while "btrfs fi
> show" shows no new device.
> 
> The new devices to add are really blank new devices, right? Not some
> disks already used by btrfs?
> 
> Thanks,
> Qu
>>
>>>
>>>
>>>> Would mounting as degraded make it possible to add the disks and have
>>>> it stick?
>>>
>>> No, that's even more fragile and you're sure to run into myriad
>>> degraded raid5 bugs, not least of which are the bogus errors. And it
>>> won't be obvious which ones are important and which ones are not.
>>>
>>>
>>> --
>>> Chris Murphy
>>
>>
>>


