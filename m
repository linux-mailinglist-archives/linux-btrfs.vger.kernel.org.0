Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94BB822AB2C
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jul 2020 10:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgGWI57 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jul 2020 04:57:59 -0400
Received: from bang.steev.me.uk ([81.2.120.65]:34039 "EHLO smtp.steev.me.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbgGWI57 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jul 2020 04:57:59 -0400
Received: from smtp.steev.me.uk ([2001:8b0:162c:10::25] helo=webmail.steev.me.uk)
        by smtp.steev.me.uk with esmtp (Exim 4.93.0.4)
        id 1jyX31-008jW0-4K; Thu, 23 Jul 2020 09:57:51 +0100
MIME-Version: 1.0
Date:   Thu, 23 Jul 2020 09:57:50 +0100
From:   Steven Davies <btrfs-list@steev.me.uk>
To:     kreijack@inwind.it
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        John Petrini <john.d.petrini@gmail.com>,
        John Petrini <me@johnpetrini.com>, linux-btrfs@vger.kernel.org
Subject: Re: Filesystem Went Read Only During Raid-10 to Raid-6 Data
 Conversion
In-Reply-To: <f7771864-9503-646d-dbda-63a43844d230@inwind.it>
References: <CADvYWxeiNynEWUYwfQxP7fQTK4k2Q+eDZsA8j7rLcaTSeND9fg@mail.gmail.com>
 <20200715011843.GH10769@hungrycats.org>
 <CADvYWxcq+-Fg0W9dmc-shwszF-7sX+GDVig0GncpvwKUDPfT7g@mail.gmail.com>
 <20200716042739.GB8346@hungrycats.org>
 <CADvYWxdvy5n3Tsa+MG9sSB2iAu-eA+W33ApzQ3q9D6sdGR9UYA@mail.gmail.com>
 <CAJix6J9kmQjfFJJ1GwWXsX7WW6QKxPqpKx86g7hgA4PfbH5Rpg@mail.gmail.com>
 <20200716225731.GI10769@hungrycats.org>
 <CADvYWxcMCEvOg8C-gbGRC1d02Z6TCypvsan7mi+8U2PVKwfRwQ@mail.gmail.com>
 <20200717055706.GJ10769@hungrycats.org>
 <de9a3d52-0147-255c-4c39-09bf734e1435@steev.me.uk>
 <507b649c-ac60-0b5c-222f-192943c50f16@libero.it>
 <e058a1d9aea61756db2296b0a26051cc@steev.me.uk>
 <f7771864-9503-646d-dbda-63a43844d230@inwind.it>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <20a7c0211b2d9336b69d48fa5c3d0c5c@steev.me.uk>
X-Sender: btrfs-list@steev.me.uk
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-07-21 21:48, Goffredo Baroncelli wrote:
> On 7/21/20 12:15 PM, Steven Davies wrote:
>> On 2020-07-20 18:57, Goffredo Baroncelli wrote:
>>> On 7/18/20 12:36 PM, Steven Davies wrote:

>>>>>> /dev/sdf, ID: 12
>>>>>>     Device size:             9.10TiB
>>>>>>     Device slack:              0.00B
>>>>>>     Data,RAID10:           784.31GiB
>>>>>>     Data,RAID10:             4.01TiB
>>>>>>     Data,RAID10:             3.34TiB
>>>>>>     Data,RAID6:            458.56GiB
>>>>>>     Data,RAID6:            144.07GiB
>>>>>>     Data,RAID6:            293.03GiB
>>>>>>     Metadata,RAID10:         4.47GiB
>>>>>>     Metadata,RAID10:       352.00MiB
>>>>>>     Metadata,RAID10:         6.00GiB
>>>>>>     Metadata,RAID1C3:        5.00GiB
>>>>>>     System,RAID1C3:         32.00MiB
>>>>>>     Unallocated:            85.79GiB
>>>>> 
>>> [...]
>>>> 
>>>> RFE: improve 'dev usage' to show these details.
>>>> 
>>>> As a user I'd look at this output and assume a bug in btrfs-tools 
>>>> because of the repeated conflicting information.
>>> 
>>> What would be the expected output ?
>>> What about the example below ?
>>> 
>>>  /dev/sdf, ID: 12
>>>      Device size:             9.10TiB
>>>      Device slack:              0.00B
>>>      Data,RAID10:           784.31GiB
>>>      Data,RAID10:             4.01TiB
>>>      Data,RAID10:             3.34TiB
>>>      Data,RAID6[3]:         458.56GiB
>>>      Data,RAID6[5]:         144.07GiB
>>>      Data,RAID6[7]:         293.03GiB
>>>      Metadata,RAID10:         4.47GiB
>>>      Metadata,RAID10:       352.00MiB
>>>      Metadata,RAID10:         6.00GiB
>>>      Metadata,RAID1C3:        5.00GiB
>>>      System,RAID1C3:         32.00MiB
>>>      Unallocated:            85.79GiB
>> 
>> That works for me for RAID6. There are three lines for RAID10 too - 
>> what's the difference between these?
> 
> The differences is the number of the disks involved. In raid10, the
> first 64K are on the first disk, the 2nd 64K are in the 2nd disk and
> so until the last disk. Then the n+1 th 64K are again in the first
> disk... and so on.. (ok I missed the RAID1 part, but I think the have
> giving the idea )
> 
> So the chunk layout depends by the involved number of disk, even if
> the differences is not so dramatic.

Is this information that the user/sysadmin needs to be aware of in a 
similar manner to the original problem that started this thread? If not 
I'd be tempted to sum all the RAID10 chunks into one line (each for data 
and metadata).

>>>     Data,RAID6:        123.45GiB
>>>         /dev/sda     12.34GiB
>>>         /dev/sdb     12.34GiB
>>>         /dev/sdc     12.34GiB
>>>     Data,RAID6:        123.45GiB
>>>         /dev/sdb     12.34GiB
>>>         /dev/sdc     12.34GiB
>>>         /dev/sdd     12.34GiB
>>>         /dev/sde     12.34GiB
>>>         /dev/sdf     12.34GiB
>> 
>> Here there would need to be something which shows what the difference 
>> in the RAID6 blocks is - if it's the chunk size then I'd do the same 
>> as the above example with e.g. Data,RAID6[3].
> 
> We could add a '[n]' for the profile where it matters, e.g. raid0,
> raid10, raid5, raid6.
> What do you think ?

So like this? That would make sense to me, as long as the meaning of [n] 
is explained in --help or the manpage.
      Data,RAID6[3]:     123.45GiB
          /dev/sda     12.34GiB
          /dev/sdb     12.34GiB
          /dev/sdc     12.34GiB
      Data,RAID6[5]:     123.45GiB
          /dev/sdb     12.34GiB
          /dev/sdc     12.34GiB
          /dev/sdd     12.34GiB
          /dev/sde     12.34GiB
          /dev/sdf     12.34GiB

-- 
Steven Davies
