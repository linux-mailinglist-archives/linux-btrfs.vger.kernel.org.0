Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17671E8E34
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 May 2020 08:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbgE3GlK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 May 2020 02:41:10 -0400
Received: from smtp-34.italiaonline.it ([213.209.10.34]:60402 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725851AbgE3GlJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 May 2020 02:41:09 -0400
Received: from venice.bhome ([78.12.136.199])
        by smtp-34.iol.local with ESMTPA
        id evB4j0HYXtrlwevB4jV6D7; Sat, 30 May 2020 08:41:06 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1590820866; bh=4ZfYGEr0ZrJ2HHnUlcxa2MLIfPMvRCAQ/+aVbOF/mOs=;
        h=From;
        b=Y0QXlNL4qbsv8meCux1HYInMIbh8u9vfNxPRdUOu4M1wQ5jLvNDHtO5d8yGORKwhY
         OuDDde1FHxt8LO9OEMFoJ8HioaYdw4ZUPwyWRoP1Vsp/7FPTh2i0ABmczJMZHL0COI
         6Sbtt+13K4gg93Gf4tlSCAISS04gD+Khxsuk1T90WWa3uzQ4mWM9AJcbUMiQn1H6Ev
         xIxsn6gzEWpou5ARKWeVqBrWgHJA1g/7XwjGPOPLWC9et5ZFLWW805OMd5ISJ37CBw
         NDPyjbNKSfwyTL7eB1Z+K5Lfhm6afNNyz/9ON0TUJMOfDU6mYsvGIo5kH+C13FEvNw
         3tQGytGwuexjg==
X-CNFS-Analysis: v=2.3 cv=TOE7tGta c=1 sm=1 tr=0
 a=kx39m2EDZI1V9vDwKCQCcA==:117 a=kx39m2EDZI1V9vDwKCQCcA==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=kfhXlpVrltliFI1O_qcA:9
 a=QgSgOy6-Sm4Jr8P4:21 a=TdvWm61jP1TnPU5S:21 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH rfc v3] New ioctl BTRFS_IOC_GET_CHUNK_INFO.
To:     Hans van Kranenburg <hans@knorrie.org>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20200319203913.3103-1-kreijack@libero.it>
 <20200319203913.3103-2-kreijack@libero.it>
 <20200525171430.GX18421@twin.jikos.cz>
 <f1a34303-3b1a-dcda-8e67-458b3522e863@libero.it>
 <c879054a-c002-8b9b-4db5-e32caf8a732b@knorrie.org>
 <5d757a91-503b-64b7-3416-5a26bb03022f@inwind.it>
 <f5f75774-0a35-bd35-7d80-71d1f1a285a1@knorrie.org>
From:   Goffredo Baroncelli <kreijack@inwind.it>
Message-ID: <3ca4a81a-5009-2a8c-5604-2d4e07d90155@inwind.it>
Date:   Sat, 30 May 2020 08:41:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <f5f75774-0a35-bd35-7d80-71d1f1a285a1@knorrie.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMeZHXTnAjefvFy928SVCa/tM6blF+u4BfUYuZetCXW5eZjYL2bVhUjFVA7ItI5N6X6HSUf6MnwFqP0fGVG+KEHLhiB4ikYF7qCTHLrhO+wOPXYW+Xcg
 hsmHJSvl/0RJXyQZSsmiHV7WGJP7e4P3RpMfokmd0V4Ip22VXdcuT4YDeb+dpArwnvSbGj6wo+W2cQ/LBGMRfXAWR57lPttt6JI4AOGMZOSBNpLbZFFL/W0Y
 Z91t42scl+vwxLkvyisPxJKLxL8IAEqsHZBZk+dL/is=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/29/20 8:54 PM, Hans van Kranenburg wrote:
> On 5/29/20 6:23 PM, Goffredo Baroncelli wrote:
>> On 5/28/20 11:03 PM, Hans van Kranenburg wrote:
>>> Hi,
>>>
>>> On 5/26/20 10:19 PM, Goffredo Baroncelli wrote:
>>>> On 5/25/20 7:14 PM, David Sterba wrote:
>>>>> I'll start with the data structures
>> [...]
>>>>>
>>>>> This looks like a copy of btrfs_chunk and stripe, only removing items
>>>>> not needed for the chunk information. Rather than copying the
>>>>> unnecessary fileds like dev_uuid in stripe, this should be designed for
>>>>> data exchange with the usecase in mind.
>>>>
>>>> There are two clients for this api:
>>>> - btrfs fi us
>>>> - btrfs dev us
>>>>
>>>> We can get rid of:
>>>> 	- "offset" fields (2x)
>>>> 	- "uuid" fields
>>>>
>>>> However the "offset" fields can be used to understand where a logical map
>>>> is on the physical disks. I am thinking about a graphical tool to show this
>>>> mapping, which doesn't exits yet -).
>>>> The offset field may be used as key to get further information (like the chunk
>>>> usage, see below)
>>>>
>>>> Regarding the UUID field, I agree it can be removed because it is redundant (there
>>>> is already the devid)
>>>>
>>>>
>>>>>
>>>>> The format does not need follow the exact layout that kernel uses, ie.
>>>>> chunk info with one embedded stripe and then followed by variable length
>>>>> array of further stripes. This is convenient in one way but not in
>>>>> another one. Alternatively each chunk can be emitted as a single entry,
>>>>> duplicating part of the common fields and adding the stripe-specific
>>>>> ones. This is for consideration.
>>>>>
>>>>> I've looked at my old code doing the chunk dump based on the search
>>>>> ioctl and found that it also allows to read the chunk usage, with one
>>>>> extra search to the block group item where the usage is stored. As this
>>>>> is can be slow, it should be optional. Ie. the main ioctl structure
>>>>> needs flags where this can be requested.
>>>>
>>>> This info could be very useful. I think to something like a balance of
>>>> chunks which are near filled (or near empty). The question is if we
>>>> should have a different ioctl.
>>>
>>> Do you mean that you want to allow to a non root user to run btrfs balance?
>> No at all. The balance is an expensive operation that IMHO need root
>> privileges to be started.
>>
>>>
>>> Otherwise, no. IMO convenience functions for quickly retrieving a
>>> specific subset of data should be created as reusable library functions
>>> in the calling code, not as a redundant extra IOCTL that has to be
>>> maintained.
>>
>> I think that there is a misunderstood. There is no intention to take the
>> place of the current balance ioctl.
> 
> Ok, I'll rephrase. Using it to improve balance is not an argument for
> adding a new IOCTL, since it has to run as root anyway, and then you can
> use the SEARCH IOCTL. And as long as there's a few helper functions
> which do the plumbing, SEARCH isn't that bad at just getting some chunk
> and block group info.

Obviously using SEARCH IOCTL you can get rid of all other "read" btrfs ioctl(s).
However SEARCH IOCTL has some disadvantages:
1) it is a quite complex API
2) it exposes a lot of internal of a BTRFS filesystem, which could prevent
   future BTRFS evolution
3) it requires root privileges

May be that you missed my other patches sets "btrfs-progs:
use the new ioctl BTRFS_IOC_GET_CHUNK_INFO" [*] which is the use case for
which this ioctl was born.

Basically we need the chunk layout info in order to run the command
"btrfs fi us". And now as non root user this is impossible because this
command uses SEARCH IOCTL if raid5/raid6 is used.

And due to 2), I think that we should get rid of all the IOCTL SEARCH.

The discussion with David, was about which information should be exposed:
- if you exposed too much information, there is the risk that you will
have the problem 2)
- if you expose too few information, you ends to add another (similar)
ioctl or you have to extend the ioctl
- of course the other factor that has to be considered is the
composeability of the api(s)

IMHO, we need an api that exposes the CHUNK layout. And I think that we should
remove all the SEARCH IOCTL instance for more reasonable api.

BR
G.Baroncelli

[*]https://lore.kernel.org/linux-btrfs/20200315152430.7532-1-kreijack@libero.it/#t

> 
> -# python3
>>>> import btrfs
>>>> with btrfs.FileSystem('/') as fs:
> ...     for chunk in fs.chunks():
> ...         print(fs.block_group(chunk.vaddr))
> ...
> block group vaddr 13631488 length 8388608 flags DATA used 8388608
> used_pct 100
> block group vaddr 22020096 length 8388608 flags SYSTEM|DUP used 114688
> used_pct 1
> block group vaddr 30408704 length 1073741824 flags METADATA|DUP used
> 889061376 used_pct 83
> block group vaddr 1104150528 length 1073741824 flags DATA used
> 1073741824 used_pct 100
> block group vaddr 2177892352 length 1073741824 flags DATA used
> 1073741824 used_pct 100
> [...]
> 
>> The aim of this ioctl is only to get information about the chunk distribution.
>> Getting the chunk information could help to perform a better balance.
>> I.e. a balance which start from the chunk more empty the go forward
>> processing the chunk more filled.
> 
> An example of this is the existing btrfs-balance-least-used program.
> 
>> Another case use is to visulize how
>> the chunk are filled, or how the disks are used..
> 
> An example of that is btrfs-heatmap.
> 
> Hfgl,
> Hans
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
