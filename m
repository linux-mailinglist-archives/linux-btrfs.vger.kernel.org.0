Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92DBA227CB3
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 12:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgGUKPv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 06:15:51 -0400
Received: from bang.steev.me.uk ([81.2.120.65]:56535 "EHLO smtp.steev.me.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgGUKPv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 06:15:51 -0400
Received: from smtp.steev.me.uk ([2001:8b0:162c:10::25] helo=webmail.steev.me.uk)
        by smtp.steev.me.uk with esmtp (Exim 4.93.0.4)
        id 1jxpJI-006nLS-6u; Tue, 21 Jul 2020 11:15:44 +0100
MIME-Version: 1.0
Date:   Tue, 21 Jul 2020 11:15:44 +0100
From:   Steven Davies <btrfs-list@steev.me.uk>
To:     kreijack@inwind.it
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        John Petrini <john.d.petrini@gmail.com>,
        John Petrini <me@johnpetrini.com>, linux-btrfs@vger.kernel.org
Subject: Re: Filesystem Went Read Only During Raid-10 to Raid-6 Data
 Conversion
In-Reply-To: <507b649c-ac60-0b5c-222f-192943c50f16@libero.it>
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
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <e058a1d9aea61756db2296b0a26051cc@steev.me.uk>
X-Sender: btrfs-list@steev.me.uk
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-07-20 18:57, Goffredo Baroncelli wrote:
> On 7/18/20 12:36 PM, Steven Davies wrote:
>> On 17/07/2020 06:57, Zygo Blaxell wrote:
>>> On Thu, Jul 16, 2020 at 09:11:17PM -0400, John Petrini wrote:
>> 
>> --snip--
>> 
>>>> /dev/sdf, ID: 12
>>>>     Device size:             9.10TiB
>>>>     Device slack:              0.00B
>>>>     Data,RAID10:           784.31GiB
>>>>     Data,RAID10:             4.01TiB
>>>>     Data,RAID10:             3.34TiB
>>>>     Data,RAID6:            458.56GiB
>>>>     Data,RAID6:            144.07GiB
>>>>     Data,RAID6:            293.03GiB
>>>>     Metadata,RAID10:         4.47GiB
>>>>     Metadata,RAID10:       352.00MiB
>>>>     Metadata,RAID10:         6.00GiB
>>>>     Metadata,RAID1C3:        5.00GiB
>>>>     System,RAID1C3:         32.00MiB
>>>>     Unallocated:            85.79GiB
>>> 
> [...]
>> 
>> RFE: improve 'dev usage' to show these details.
>> 
>> As a user I'd look at this output and assume a bug in btrfs-tools 
>> because of the repeated conflicting information.
> 
> What would be the expected output ?
> What about the example below ?
> 
>  /dev/sdf, ID: 12
>      Device size:             9.10TiB
>      Device slack:              0.00B
>      Data,RAID10:           784.31GiB
>      Data,RAID10:             4.01TiB
>      Data,RAID10:             3.34TiB
>      Data,RAID6[3]:         458.56GiB
>      Data,RAID6[5]:         144.07GiB
>      Data,RAID6[7]:         293.03GiB
>      Metadata,RAID10:         4.47GiB
>      Metadata,RAID10:       352.00MiB
>      Metadata,RAID10:         6.00GiB
>      Metadata,RAID1C3:        5.00GiB
>      System,RAID1C3:         32.00MiB
>      Unallocated:            85.79GiB

That works for me for RAID6. There are three lines for RAID10 too - 
what's the difference between these?

> Another possibility (but the output will change drastically, I am
> thinking to another command)
> 
> Filesystem '/'
> 	Data,RAID1:		123.45GiB
> 		/dev/sda	 12.34GiB
> 		/dev/sdb	 12.34GiB
> 	Data,RAID1:		123.45GiB
> 		/dev/sde	 12.34GiB
> 		/dev/sdf	 12.34GiB

Is this showing that there's 123.45GiB of RAID1 data which is mirrored 
between sda and sdb, and 123.45GiB which is mirrored between sde and 
sdf? I'm not sure how useful that would be if there are a lot of disks 
in a RAID1 volume with different blocks mirrored between different ones. 
For RAID1 (and RAID10) I would keep it simple.

> 	Data,RAID6:		123.45GiB
> 		/dev/sda	 12.34GiB
> 		/dev/sdb	 12.34GiB
> 		/dev/sdc	 12.34GiB
> 	Data,RAID6:		123.45GiB
> 		/dev/sdb	 12.34GiB
> 		/dev/sdc	 12.34GiB
> 		/dev/sdd	 12.34GiB
> 		/dev/sde	 12.34GiB
> 		/dev/sdf	 12.34GiB

Here there would need to be something which shows what the difference in 
the RAID6 blocks is - if it's the chunk size then I'd do the same as the 
above example with e.g. Data,RAID6[3].

> The number are the chunks sizes (invented). Note: for RAID5/RAID6 a
> chunk will uses near all disks; however for (e.g.) RAID1  there is the
> possibility that CHUNKS use different disks pairs (see the two RAID1
> instances).

-- 
Steven Davies
