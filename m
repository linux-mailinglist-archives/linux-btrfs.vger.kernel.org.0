Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065A7228A37
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 22:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbgGUU5M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 16:57:12 -0400
Received: from smtp-32.italiaonline.it ([213.209.10.32]:52538 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726658AbgGUU5L (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 16:57:11 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Jul 2020 16:57:09 EDT
Received: from venice.bhome ([78.12.13.37])
        by smtp-32.iol.local with ESMTPA
        id xzC7j1yUCzS33xzC7jYP2r; Tue, 21 Jul 2020 22:48:59 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1595364539; bh=ERg5X856V2UNf7ZPzFf4eFMBETFo1rsSY7yAi7VphVg=;
        h=From;
        b=MlidzMLdLDuTkv2tSp39pOcyUjj1wpXVYsyz7SZfyZggGFYS79oE5NWY3nx6f+VtZ
         EJPrAoLLSX9iH/7gbawQLJHMN4aC+Rm6qfykJ/mTc17q/LSPPFhlbKGk4kubIvNict
         9GuomO4nKRTw4Q6cg1XDRsdDuRGLVIYDcwAADytW30KoKXRN/RV+mJ4C2QrQcnYppV
         w50yBhTz7C+43wbE+Sa70g4WJbd/l8G9w5qgJARDy8YYD0aTpnmOVWD+VwBwE/3S2w
         VuVp+kDjJUULo3iNF71RERnzrrOdq6lGPrsnfmOFLMv1qRSLGXMYKztfPhisnzSBEq
         qvC6oCXfyj1NA==
X-CNFS-Analysis: v=2.3 cv=PLVxBsiC c=1 sm=1 tr=0
 a=XJAbuhTEZzHZh8gzL9OeLg==:117 a=XJAbuhTEZzHZh8gzL9OeLg==:17
 a=IkcTkHD0fZMA:10 a=9w9HwanDGAe0UTdKf8wA:9 a=kMwnWgNSgqROuhZ0:21
 a=BrDsu5iqdLwZEsOY:21 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: Filesystem Went Read Only During Raid-10 to Raid-6 Data
 Conversion
To:     Steven Davies <btrfs-list@steev.me.uk>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        John Petrini <john.d.petrini@gmail.com>,
        John Petrini <me@johnpetrini.com>, linux-btrfs@vger.kernel.org
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
From:   Goffredo Baroncelli <kreijack@inwind.it>
Message-ID: <f7771864-9503-646d-dbda-63a43844d230@inwind.it>
Date:   Tue, 21 Jul 2020 22:48:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e058a1d9aea61756db2296b0a26051cc@steev.me.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfKXgcQVp/gOMlA8d58uwoQ3nEL6LZmC7g9MB1A6+vD5EbTQ1pDFHi+TtZ7Qz7ko4902HIKx8H9LRFUgph9rbnRJUYTonQ9mo1EC8kKwTwVBASsj30RXe
 Gbk0USGi1S2CMjEWj7I9utLEGJ1CCY/4iuC7EDOXo6EUIMGobsIlkXbKvz4XNITVvOPjRNDFc1YByTErqaM6cNNTG70dFzf2K2JLxV2eVM9Z5SAYyXmCC+Hf
 owCe2n49en4B6XZmtcg9wu21lsoh+lZcSAUSwAq99eU1utEd3DFjDwLBzETkKIkUnHoKOFYtEmVICzRNdGhaIQ==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/21/20 12:15 PM, Steven Davies wrote:
> On 2020-07-20 18:57, Goffredo Baroncelli wrote:
>> On 7/18/20 12:36 PM, Steven Davies wrote:
>>> On 17/07/2020 06:57, Zygo Blaxell wrote:
>>>> On Thu, Jul 16, 2020 at 09:11:17PM -0400, John Petrini wrote:
>>>
>>> --snip--
>>>
>>>>> /dev/sdf, ID: 12
>>>>>     Device size:             9.10TiB
>>>>>     Device slack:              0.00B
>>>>>     Data,RAID10:           784.31GiB
>>>>>     Data,RAID10:             4.01TiB
>>>>>     Data,RAID10:             3.34TiB
>>>>>     Data,RAID6:            458.56GiB
>>>>>     Data,RAID6:            144.07GiB
>>>>>     Data,RAID6:            293.03GiB
>>>>>     Metadata,RAID10:         4.47GiB
>>>>>     Metadata,RAID10:       352.00MiB
>>>>>     Metadata,RAID10:         6.00GiB
>>>>>     Metadata,RAID1C3:        5.00GiB
>>>>>     System,RAID1C3:         32.00MiB
>>>>>     Unallocated:            85.79GiB
>>>>
>> [...]
>>>
>>> RFE: improve 'dev usage' to show these details.
>>>
>>> As a user I'd look at this output and assume a bug in btrfs-tools because of the repeated conflicting information.
>>
>> What would be the expected output ?
>> What about the example below ?
>>
>>  /dev/sdf, ID: 12
>>      Device size:             9.10TiB
>>      Device slack:              0.00B
>>      Data,RAID10:           784.31GiB
>>      Data,RAID10:             4.01TiB
>>      Data,RAID10:             3.34TiB
>>      Data,RAID6[3]:         458.56GiB
>>      Data,RAID6[5]:         144.07GiB
>>      Data,RAID6[7]:         293.03GiB
>>      Metadata,RAID10:         4.47GiB
>>      Metadata,RAID10:       352.00MiB
>>      Metadata,RAID10:         6.00GiB
>>      Metadata,RAID1C3:        5.00GiB
>>      System,RAID1C3:         32.00MiB
>>      Unallocated:            85.79GiB
> 
> That works for me for RAID6. There are three lines for RAID10 too - what's the difference between these?

The differences is the number of the disks involved. In raid10, the first 64K are on the first disk, the 2nd 64K are in the 2nd disk and so until the last disk. Then the n+1 th 64K are again in the first disk... and so on.. (ok I missed the RAID1 part, but I think the have giving the idea )

So the chunk layout depends by the involved number of disk, even if the differences is not so dramatic.


> 
>> Another possibility (but the output will change drastically, I am
>> thinking to another command)
>>
>> Filesystem '/'
>>     Data,RAID1:        123.45GiB
>>         /dev/sda     12.34GiB
>>         /dev/sdb     12.34GiB
>>     Data,RAID1:        123.45GiB
>>         /dev/sde     12.34GiB
>>         /dev/sdf     12.34GiB
> 
> Is this showing that there's 123.45GiB of RAID1 data which is mirrored between sda and sdb, and 123.45GiB which is mirrored between sde and sdf? I'm not sure how useful that would be if there are a lot of disks in a RAID1 volume with different blocks mirrored between different ones. For RAID1 (and RAID10) I would keep it simple.
> 
>>     Data,RAID6:        123.45GiB
>>         /dev/sda     12.34GiB
>>         /dev/sdb     12.34GiB
>>         /dev/sdc     12.34GiB
>>     Data,RAID6:        123.45GiB
>>         /dev/sdb     12.34GiB
>>         /dev/sdc     12.34GiB
>>         /dev/sdd     12.34GiB
>>         /dev/sde     12.34GiB
>>         /dev/sdf     12.34GiB
> 
> Here there would need to be something which shows what the difference in the RAID6 blocks is - if it's the chunk size then I'd do the same as the above example with e.g. Data,RAID6[3].

We could add a '[n]' for the profile where it matters, e.g. raid0, raid10, raid5, raid6.
What do you think ?
> 
>> The number are the chunks sizes (invented). Note: for RAID5/RAID6 a
>> chunk will uses near all disks; however for (e.g.) RAID1  there is the
>> possibility that CHUNKS use different disks pairs (see the two RAID1
>> instances).
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
