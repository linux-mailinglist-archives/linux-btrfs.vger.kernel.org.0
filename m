Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308461A6AED
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Apr 2020 19:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732361AbgDMRFy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Apr 2020 13:05:54 -0400
Received: from smtp-35.italiaonline.it ([213.209.10.35]:58114 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732378AbgDMRFm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Apr 2020 13:05:42 -0400
Received: from venice.bhome ([94.37.173.46])
        by smtp-35.iol.local with ESMTPA
        id O2WhjE1uBMAUpO2Whj8dwi; Mon, 13 Apr 2020 19:05:39 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1586797539; bh=bzh69x2C/btQ9qaVecF/INaIz+UAyJUdtwVPccWNhNY=;
        h=From;
        b=ffrwfna348QOVmRNyHwjRNtR/V4zvv6HYtAbQiCovRZzliqXvAioqwpusa37mjyW7
         oE3qCgA+RsZJLb0fJ3IUVToJ0dGZuXkRRPtREwvsmYJdRWfbzi59CQKYv75nFyKidR
         v3BVSqNjbr0FGdxaCggElxE1Kbi5n5lWxOEa18smRFBjyxXZutQVZzoKAaIPfBTe6w
         GxBKc9vVUseh6QN7vPSl40zupX55HnyVKERF1a+kP29QNgqyi+JIip1v/H8vnntg7U
         b71TBsdk1/fWdeeL+vVBmTmxMz7DBbBFPY0sECqCyj/avbr+3MOUMdXN+bjjxZQDVk
         lczT8MWvh2wvw==
X-CNFS-Analysis: v=2.3 cv=B/fHL9lM c=1 sm=1 tr=0
 a=TpQr5eyM7/bznjVQAbUtjA==:117 a=TpQr5eyM7/bznjVQAbUtjA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=iY6COnj-0Yg3XHqBsK4A:9
 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH] btrfs-progs: add RAID5/6 support to btrfs fi us
To:     Joshua Houghton <joshua.houghton@yandex.ru>,
        linux-btrfs@vger.kernel.org
Cc:     DanglingPointer <danglingpointerexception@gmail.com>,
        Torstein Eide <torsteine@gmail.com>
References: <20200318211157.11090-1-kreijack@libero.it>
 <4521727.GXAFRqVoOG@arch> <2017238.irdbgypaU6@arch>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <913f6db9-29a5-5b13-eef0-5924503bd935@libero.it>
Date:   Mon, 13 Apr 2020 19:05:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <2017238.irdbgypaU6@arch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBUTU3eRHdZcH8bahJPOmqIPM9LOvPFb6tb1y8MblN3N+YeHXfUCz9EX34zclmYG3ioBXdXt5kgeGf3eSSPqdNsOyRdk9fmR5TziX2v4gLrTmj1lcP/W
 If+lVcQ1fSsLbeirhxPurWaWbxID3YlFMKS91IXr+tazKrGFIYY7dE2QeJDDdr8Tsj1jH0NlaT5hDqbZxlvu183ys5YnnPMxTtKclJGDGHdcnaNAGF06CFrO
 wvtksBQbm8paLHVncfeKxXkNe6NrCgIhAGokay5RFbmIRoGy0GLmmJo+m9vmampQ
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/13/20 12:28 PM, Joshua Houghton wrote:
> On Monday, 13 April 2020 10:08:50 UTC Joshua Houghton wrote:
>> On Wednesday, 18 March 2020 21:11:56 UTC Goffredo Baroncelli wrote:
>>> Hi all,
>>>
>>> this patch adds support for the raid5/6 profiles in the command
>>> 'btrfs filesystem usage'.
[...]
[...]
>>
>> Hi Goffredo
>>
>> Thanks you for this. It's something I've been wanting for a while. Do
>> you know why I get significantly different results in the overall summary
>> when I do not run it as root. I'm not sure if this is a bug or a
>> limitation.
>>
>> When I run it as root it looks to be showing the correct values.
>>
>> joshua@r2400g:~/development/btrfs-progs$ colordiff -u <(./btrfs fi us
>> /mnt/raid/) <(sudo ./btrfs fi us /mnt/raid/) WARNING: cannot read detailed
>> chunk info, per-device usage will not be shown, run as root --- /dev/fd/63
>> 2020-04-13 10:54:26.833747190 +0100
>> +++ /dev/fd/62  2020-04-13 10:54:26.843746984 +0100
>> @@ -1,17 +1,32 @@
>>   Overall:
>>       Device size:                 29.11TiB
>> -    Device allocated:           284.06GiB
>> -    Device unallocated:                  28.83TiB
>> -    Device missing:              29.11TiB
>> -    Used:                       280.99GiB
>> -    Free (estimated):               0.00B      (min: 14.95TiB)
>> -    Data ratio:                              0.00
>> +    Device allocated:            19.39TiB
>> +    Device unallocated:                   9.72TiB
>> +    Device missing:                 0.00B
>> +    Used:                        18.67TiB
>> +    Free (estimated):             7.82TiB      (min: 5.39TiB)
>> +    Data ratio:                              1.33
>>       Metadata ratio:                  2.00
>>       Global reserve:             512.00MiB      (used: 0.00B)
>>
>>   Data,RAID5: Size:14.33TiB, Used:13.80TiB (96.27%)
>> +   /dev/mapper/traid3     4.78TiB
>> +   /dev/mapper/traid1     4.78TiB
>> +   /dev/mapper/traid2     4.78TiB
>> +   /dev/mapper/traid4     4.78TiB
>>
>>   Metadata,RAID1: Size:142.00GiB, Used:140.49GiB (98.94%)
>> +   /dev/mapper/traid3    63.00GiB
>> +   /dev/mapper/traid1    64.00GiB
>> +   /dev/mapper/traid2    63.00GiB
>> +   /dev/mapper/traid4    94.00GiB
>>
>>   System,RAID1: Size:32.00MiB, Used:1.00MiB (3.12%)
>> +   /dev/mapper/traid1    32.00MiB
>> +   /dev/mapper/traid4    32.00MiB
>>
>> +Unallocated:
>> +   /dev/mapper/traid3     2.44TiB
>> +   /dev/mapper/traid1     2.44TiB
>> +   /dev/mapper/traid2     2.44TiB
>> +   /dev/mapper/traid4     2.41TiB
>>
>>
>> This is in contrast to raid1 which seems to be mostly correct, irrespective
>> of what user I run as.
>>
>>
>> joshua@arch:/var/joshua$ colordiff -u <(btrfs fi us raid/) <(sudo btrfs fi
>> us raid/) WARNING: cannot read detailed chunk info, per-device usage will
>> not be shown, run as root --- /dev/fd/63  2020-04-13 09:52:54.630750079
>> +0000
>> +++ /dev/fd/62  2020-04-13 09:52:54.637416835 +0000
>> @@ -2,7 +2,7 @@
>>       Device size:                  8.00GiB
>>       Device allocated:             1.32GiB
>>       Device unallocated:                   6.68GiB
>> -    Device missing:               8.00GiB
>> +    Device missing:                 0.00B
>>       Used:                       383.40MiB
>>       Free (estimated):             3.55GiB      (min: 3.55GiB)
>>       Data ratio:                              2.00
>> @@ -10,8 +10,17 @@
>>       Global reserve:               3.25MiB      (used: 0.00B)
>>
>>   Data,RAID1: Size:409.56MiB, Used:191.28MiB (46.70%)
>> +   /dev/loop0   409.56MiB
>> +   /dev/loop1   409.56MiB
>>
>>   Metadata,RAID1: Size:256.00MiB, Used:416.00KiB (0.16%)
>> +   /dev/loop0   256.00MiB
>> +   /dev/loop1   256.00MiB
>>
>>   System,RAID1: Size:8.00MiB, Used:16.00KiB (0.20%)
>> +   /dev/loop0     8.00MiB
>> +   /dev/loop1     8.00MiB
>>
>> +Unallocated:
>> +   /dev/loop0     3.34GiB
>> +   /dev/loop1     3.34GiB
>>
>> Does anyone know if this is something we can fix? I'm happy to take a look.
>>
>> Joshua Houghton
> 
> Sorry missed this last bit never mind
> 
>> If both are merged we will have a 'btrfs fi us'
>> commands with full support a raid5/6 filesystem without needing root
>> capability.
> 

Unfortunately we need root to access the chunks information.
Thanks for giving an eye to that. I will "ping" the status of this patch

BR
G.Baroncelli

> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
