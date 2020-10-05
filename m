Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF18D283F84
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Oct 2020 21:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgJETWp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Oct 2020 15:22:45 -0400
Received: from cryptearth.de ([91.121.4.115]:48368 "EHLO cryptearth.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgJETWp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Oct 2020 15:22:45 -0400
MIME-Version: 1.0
X-UserIsAuth: true
Received: from 2a0c:d242:3803:9400:ec14:863c:b9cb:c16f (EHLO [IPv6:2a0c:d242:3803:9400:ec14:863c:b9cb:c16f]) ([2a0c:d242:3803:9400:ec14:863c:b9cb:c16f])
          by cryptearth.de (JAMES SMTP Server ) with ESMTPA ID 215071160
          for <linux-btrfs@vger.kernel.org>;
          Mon, 05 Oct 2020 21:22:43 +0200 (CEST)
Subject: Re: using raid56 on a private machine
To:     linux-btrfs@vger.kernel.org
References: <dbf47c42-932c-9cf0-0e50-75f1d779d024@cryptearth.de>
 <91a18b63-6211-08e1-6cd9-8ef403db1922@libero.it>
From:   cryptearth <cryptearth@cryptearth.de>
Message-ID: <beb2862b-a5fa-c9eb-53a6-c964b849da75@cryptearth.de>
Date:   Mon, 5 Oct 2020 21:22:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <91a18b63-6211-08e1-6cd9-8ef403db1922@libero.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Goffredo,

thank you for the quick reply, I didn't expected one this late.

Thanks for the provided information.
I'm a bit surprised of the current status of support for RAID5/6 as I 
thought it to be already more advanced to at least a "relaible" state 
where data-recovery is as straight forward as with a "regular" array 
when a drive fails. But reading that there's still the risk of 
catastrophic total data loss is not what I was ready for to read.

As I tried to set up a test array in a VM I was unable to set raid1c3/4 
for metadata as I got the error it's an unknown profile. I'm using 
OpenSuSE Leap 15.2 running kernel 5.3.18. According to zypper the btrfs 
package version is 4.19.1 - so I'm at the state of december 2018. 
According to the changelog raid1c3/4 were added with 5.4 in december 
2019. As I'm using Linux only on my server, and OpenSuSE more specificly 
for its "easy to use thanks to it's overall 'control center' YaST", I'm 
unsure if it's possible to simply "upgrade" to a more recent version as 
like installing a newer version of some software on windows. Maybe a 
different distribution with more recent kernel and packages would fit me 
requirements better than rely on the rather outdated stuff the SuSE devs 
put together, although it would be a rather steep learning curve and 
most likely much copy'n'paste from some wikis.

As for your suggestions: Some good advices in there - but some are 
currently just not feaseable (like running a UPS). As for the increased 
risk of failure due to number of drives: I'm currently running a 5 drive 
RAID5 on a so called "fakeraid" provided by the chipset of my 
motherboard (specificly AMD SB950 / FX990 - AM3+ platform) which relies 
on a windows7-only driver from AMD (don't ask me why - but I'm not able 
to get it running with windows10) - and already had at least 3 or even 4 
failures (can't exactly remember right now). The provided software has 
the advantage of active drive monitoring. So, when something goes wrong 
the failing drive is put offline and the array into a critical mode. As 
it's only RAID5 it's kind of a gamble to hopefully not encounter another 
failure while rebuilding, that's why I plan to change over to RAID6. 
Going up to 8 drives is just an unrelated choice as that's the number of 
drive bays my case has and as it seem many HBAs to mostly offer ports in 
increments of powers of 2 (like 2, 4, 8, 16 - and so on). Do you see any 
problem with that? Or would run a RAID6 with only 6 drives be any 
beneficial over a 8 drive array?

Although this is the btrfs list - as it seems btrfs not really ready for 
running in RAID-like modes - and ZFS is also quite wide spread - would 
it be a better idea to use that instead?


Greetings,

Matt

Am 05.10.2020 um 19:57 schrieb Goffredo Baroncelli:
> On 10/5/20 6:59 PM, cryptearth wrote:
>> Hello there,
>>
>> as I plan to use a 8 drive RAID6 with BtrFS I'd like to ask about the 
>> current status of BtrFS RAID5/6 support or if I should go with a more 
>> traditional mdadm array.
>>
>> The general status page on the btrfs wiki shows "unstable" for 
>> RAID5/6, and it's specific pages mentions some issue marked as "not 
>> production ready". It also says to not use it for the metadata but 
>> only for the actual data.
>>
>> I plan to use it for my own personal system at home - and I do 
>> understand that RAID is no replacement for a backup, but I'd rather 
>> like to ask upfront if it's ready to use before I encounter issues 
>> when I use it.
>> I already had the plan about using a more "traditional" mdadm setup 
>> and just format the resulting volume with ext4, but as I asked about 
>> that many actually suggested to me to rather use modern filesystems 
>> like BtrFS or ZFS instead of "old school RAID".
>>
>> Do you have any help for me about using BtrFS with RAID6 vs mdadm or 
>> ZFS?
>
> Zygo collected some useful information about RAID5/6:
>
> https://lore.kernel.org/linux-btrfs/20200627032414.GX10769@hungrycats.org/ 
>
>
> However more recently Josef (one of the main developers), declared 
> that BTRFS with RAID5/6 has  "...some dark and scary corners..."
>
> https://lore.kernel.org/linux-btrfs/bf9594ea55ce40af80548888070427ad97daf78a.1598374255.git.josef@toxicpanda.com/ 
>
>
>>
>> I also don't really understand why and what's the difference between 
>> metadata, data, and system.
>> When I set up a volume only define RAID6 for the data it sets 
>> metadata and systemdata default to RAID1, but doesn't this mean that 
>> those important metadata are only stored on two drives instead of 
>> spread accross all drives like in a regular RAID6? This would 
>> somewhat negate the benefit of RAID6 to withstand a double failure 
>> like a 2nd drive fail while rebuilding the first failed one.
>
> Correct. In fact Zygo suggested to user RAID6 + RAID1C3.
>
> I have only few suggestions:
> 1) don't store valuable data on BTRFS with raid5/6 profile. Use it if 
> you want to experiment and want to help the development of BTRFS. But 
> be ready to face the lost of all data. (very unlikely, but more the 
> size of the filesystem is big, more difficult is a restore of the data 
> in case of problem).
> 2) doesn't fill the filesystem more than 70-80%. If you go further 
> this limit the likelihood to catch the "dark and scary corners" 
> quickly increases.
> 3) run scrub periodically and after a power failure ; better to use an 
> uninterruptible power supply (this is true for all the RAID, even the 
> MD one).
> 4) I don't have any data to support this; but as occasional reader of 
> this mailing list I have the feeling that combing BTRFS with LUCKS(or 
> bcache) raises the likelihood of a problem.
> 5) pay attention that having an 8 disks raid, raises the likelihood of 
> a failure of about an order of magnitude more than a single disk ! 
> RAID6 (or any other RAID) mitigates that, in the sense that it creates 
> a time window where it is possible to make maintenance (e.g. a disk 
> replacement) before the lost of data.
> 6) leave the room in the disks array for an additional disk (to use 
> when a disk replacement is needed)
> 7) avoid the USB disks, because these are not reliable
>
>
>>
>> Any information appreciated.
>>
>>
>> Greetings from Germany,
>>
>> Matt
>
>

