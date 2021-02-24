Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8AE3324313
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Feb 2021 18:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhBXRUG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Feb 2021 12:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhBXRUE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Feb 2021 12:20:04 -0500
Received: from smtp.steev.me.uk (smtp.steev.me.uk [IPv6:2001:8b0:162c:10::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9F9C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Feb 2021 09:19:22 -0800 (PST)
Received: from smtp.steev.me.uk ([2001:8b0:162c:10::25] helo=webmail.steev.me.uk)
        by smtp.steev.me.uk with esmtp (Exim 4.93.0.4)
        id 1lExof-004NGN-8h; Wed, 24 Feb 2021 17:19:13 +0000
MIME-Version: 1.0
Date:   Wed, 24 Feb 2021 17:19:13 +0000
From:   Steven Davies <btrfs-list@steev.me.uk>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, dsterba@suse.cz,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: 5.11.0: open ctree failed: devide total_bytes should be at most X
 but found Y
In-Reply-To: <d75bcf2d-dbee-ed1f-5602-23ed7d5597b0@oracle.com>
References: <34d881ab-7484-6074-7c0b-b5c8d9e46379@steev.me.uk>
 <PH0PR04MB7416AA577A3ED39E4C5833819B809@PH0PR04MB7416.namprd04.prod.outlook.com>
 <PH0PR04MB74167CACC7802BA85638105F9B809@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20210223143020.GW1993@twin.jikos.cz>
 <457bf37240392e63a84c7e1546f7d47a@steev.me.uk>
 <PH0PR04MB741625481C6DAC65BB52857E9B809@PH0PR04MB7416.namprd04.prod.outlook.com>
 <d75bcf2d-dbee-ed1f-5602-23ed7d5597b0@oracle.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <42d37a6393db7ad5d83bc167459c8a5c@steev.me.uk>
X-Sender: btrfs-list@steev.me.uk
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021-02-24 01:20, Anand Jain wrote:
> On 24/02/2021 01:35, Johannes Thumshirn wrote:
>> On 23/02/2021 18:20, Steven Davies wrote:
>>> On 2021-02-23 14:30, David Sterba wrote:
>>>> On Tue, Feb 23, 2021 at 09:43:04AM +0000, Johannes Thumshirn wrote:
>>>>> On 23/02/2021 10:13, Johannes Thumshirn wrote:
>>>>>> On 22/02/2021 21:07, Steven Davies wrote:

>>>>>>> Booted my system with kernel 5.11.0 vanilla with the first time 
>>>>>>> and received this:
>>>>>>> 
>>>>>>> BTRFS info (device nvme0n1p2): has skinny extents
>>>>>>> BTRFS error (device nvme0n1p2): device total_bytes should be at 
>>>>>>> most 964757028864 but found
>>>>>>> 964770336768
>>>>>>> BTRFS error (device nvme0n1p2): failed to read chunk tree: -22
>>>>>>> 
>>>>>>> Booting with 5.10.12 has no issues.


>>>>> So the bdev inode's i_size must have changed between mkfs and 
>>>>> mount.
>>> 
> 
> 
>>> That's likely, this is my development/testing machine and I've 
>>> changed
>>> partitions (and btrfs RAID levels) around more than once since mkfs
>>> time. I can't remember if or how I've modified the fs to take account 
>>> of
>>> this.
>>> 
> 
>  What you say matches with the kernel logs.
> 
>>>>> Steven, can you please run:
>>>>> blockdev --getsize64 /dev/nvme0n1p2
>>> 
>>> # blockdev --getsize64 /dev/nvme0n1p2
>>> 964757028864
> 
> 
>  Size at the time of mkfs is 964770336768. Now it is 964757028864.
> 
> 

>>> Is there a simple way to fix this partition so that btrfs and the
>>> partition table agree on its size?
>>> 
>> 
>> Unless someone's yelling at me that this is a bad advice (David, 
>> Anand?),
> 
> 
>> I'd go for:
>> btrfs filesystem resize max /
> 
>  I was thinking about the same step when I was reading above.
> 
>> I've personally never shrinked a device but looking at the code it 
>> will
>> write the blockdevice's inode i_size to the device extents, and 
>> possibly
>> relocate data.
> 
> 
>  Shrink works. I have tested it before.
>  I hope shrink helps here too. Please let us know.
> 
> Thanks, Anand

Yes, this worked - at least there's no panic on boot (albeit this single 
device fs is devid 3 now so I had to use 3:max).

-- 
Steven Davies
