Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D51EDFD047
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2019 22:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfKNVZU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Nov 2019 16:25:20 -0500
Received: from smtp-32.italiaonline.it ([213.209.10.32]:57640 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726592AbfKNVZU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Nov 2019 16:25:20 -0500
Received: from venice.bhome ([94.38.75.109])
        by smtp-32.iol.local with ESMTPA
        id VMc8imWskhCYOVMc8iLTvo; Thu, 14 Nov 2019 22:25:16 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1573766716; bh=v+Dnhwv584IVyb+8KDZ7HFgfCGq7I7MX8Wmn23+FMgA=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fO0pdpo/KpMwO4uUKgy5CK60seaHYo2aPwI7zZRkJWkaVpTBazSP+O8vZBeS5a0Nh
         eeLZbg/Qlx2jlp14aaUIoOtO+8lnXqsf2tCOOLx1xlZegmJQ2LAP+5fP5Mi549CCLz
         SSLJyk499GwuPb1cHcCzICWPjLCte55vSs5hgvELCOw4VWLFRMN/CK/vzwFsUGX5FI
         RGxyCrMWtibtCyVMSQI45ABds8iYY4fTnrKhiS82ncGcwvKRhlBEhEdhROAMzmTcfu
         qlDrIf+PB1TGr1IU2+e2xZ9hyMuDqoNNpE9uDgF4KNpa3iJtDJzEuuZGnGBg7ltBQg
         OZbTW5MOt09UQ==
X-CNFS-Analysis: v=2.3 cv=D9k51cZj c=1 sm=1 tr=0
 a=KzXHLLuG32F0DtnFfJanyA==:117 a=KzXHLLuG32F0DtnFfJanyA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=tmJeersEAAAA:8
 a=eCm-_6X5T2AWVwlZWdsA:9 a=J7rCvmjSHPd1gTYB:21 a=EwN_fFeeWJBL_lVw:21
 a=QEXdDO2ut3YA:10 a=6_NLHW3UfdglaTMwbppD:22
Reply-To: kreijack@inwind.it
Subject: Re: Avoiding BRTFS RAID5 write hole
To:     Hubert Tonneau <hubert.tonneau@fullpliant.org>
Cc:     linux-btrfs@vger.kernel.org
References: <0JGAX5Q12@briare1.fullpliant.org>
From:   Goffredo Baroncelli <kreijack@libero.it>
Message-ID: <7723feea-c3cd-b1eb-b882-aa782bbc6e2a@libero.it>
Date:   Thu, 14 Nov 2019 22:25:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <0JGAX5Q12@briare1.fullpliant.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPr9S6OE4LIDx4fKZIl0gxBVYiMGo3ZmDFcQoNpXQyI8TmmOLI2JY0DCY/an5hZQ1oUWxyShbYJkU90wMrfVdLhevdYAP5kvXsAZd7FcSLSRFb7yKiUC
 7bqMuhiJu25UpmC8/CF3KieYZ9Q6U0bQ7BQfAQNt9jgWGCWtKvb8SYLqrxQIXH0E2QtrjkEHAOI4wAkmI8SLE6QLp1+AeVG51i1k3TmEsRIA/SKHkmIib2Nk
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13/11/2019 23.29, Hubert Tonneau wrote:
> Goffredo Baroncelli wrote:
>>
>>> What I am suggesting is to write it as RAID1 instead of RAID5, so that if it's changed a lot of times, you pay only once.
>> I am not sure to understand what are you saying. Could you elaborate ?
> 
> The safety problem with RAID5 is that between the time you start to overwrite a stripe and the time you finish, disk safety is disabled because parity is broken.
> On the other hand, with RAID1, disk safety more or less remains all the time, so overwriting is no issue.
> 
> There are several possible strategies to keep RAID5 disk safety all the time:
> 
> 1) Use a journal
> This is the MDADM solution because it's the only resonable one if the RAID layer is separated from the filesystem (because you don't whan to add another sectors mapping layer).
> The problem is that it's IO expensive.
> This is the solution implemented in Liu Bo 2017 patch, as far as I can understand it.
> 
> 2) Never overwrite the RAID5 stripe
> This is stripe COW. The new stripe is stored at different disks positions.
> The problem is that it's even more IO expensive.

Why do you think that this approach is more IO expensive ?

Supposing to have n+1 disks, configured as raid5 Raid5

The problem is only when you have to update a portion of stripe. So I consider of an amount of data in the range 0..n -> n/2 in average (I omit the size of the disk-stripe which is constant)

1) stripe update in place (current BTRFS behavior)
The data to write is  ~ n/2 +1 (in average half of the stripe size + parity)

2) COW stripe (my idea)
The data to write is ~ n + 1 (the full stripe size + parity)

3) Your solution (cache in RAID1)
The data to write is
	a) write data to raid1: ~ n/2 * 2 = n (data written on two disks)
	b) update the RAID5 stripe: ~ n/2 + 1

Total:	~ 3 * n/2 + 1

(for the case 2 and 3 I don't consider the metadata update because it is several order of magnitude lower)




> This is the solution you are suggesting, as far as I can understand it.
> 
> What I'm suggesting is to use your COW solution, but also write the new (set of) stripe(s) as RAID1.
> Let me call this operation stripe COW RAID5 to RAID1.
> The key advantage is that if you have to overwrite it again a few seconds (or hours) later, then it can be fast, because it's already RAID1.

On the basis of my simulation, I can't agree: COW-ing a stripe requires to write the full stripe; instead if you want to write the data in a RAID1 before updating the stripe, in average first you have to write an amount of data equal to 'n', then you have to update the raid5....

You can see this in another way: raid5 is more space friendly than raid1, this means that in raid5 you have to write less data....


> 
> Morever, new stripes resulting from writing a new file, or appending, would be created as RAID1, even if the filesystem DATA is configured as RAID5, each time the stripe is not full or is likely to be modified soon.
> This will reduce the number of stripe COW RAID5 to RAID1 operations.
> 
> The final objective is to have few stripe COW operations, because they are IO expensive, and many RAID1 stripe overwrite operations.
> The price to pay for the reduced number of stripe COW operations is consuming more disk space, because RAID1 stripes consumes more disk space than RAID5 ones, and that is why we would have a background process that does stripe COW from RAID1 to RAID5 in order to reclaim disk space, and we could make it more aggressive when we lack disk space.
> 
> What I'm trying to provide is the idea that seeing the DATA as RAID1 or RAID5 is not a good idea when we have BTRFS flexibility. We should rather see it as RAID1 and RAID5, RAID5 beeing just a way to reclaim disk space (same for RAID1C3 and RAID6).
> Having METADATA as RAID1 and DATA as RAID5 was a first step, but BTRFS flexibility probably allows to do more.
> 
> Please notice that I understand the BTRFS and RAID principles, but on the other hand, I have not read the code, so can hardly say what is easy to implement.
> Sorry about that. I've written a full new operating system (see www.fullpliant.org) but the kernel :-)
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
