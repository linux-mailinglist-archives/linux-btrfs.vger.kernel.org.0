Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA473FF88A
	for <lists+linux-btrfs@lfdr.de>; Sun, 17 Nov 2019 09:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbfKQIxm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 17 Nov 2019 03:53:42 -0500
Received: from smtp-32.italiaonline.it ([213.209.10.32]:48706 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726007AbfKQIxm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 17 Nov 2019 03:53:42 -0500
Received: from venice.bhome ([94.38.75.109])
        by smtp-32.iol.local with ESMTPA
        id WGJOiLE4yhCYOWGJOiZ1NN; Sun, 17 Nov 2019 09:53:38 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1573980818; bh=3LwASlAQkKaN0riKWpb2fggiP26I1eVbaasYze9XMKE=;
        h=From:Subject:Reply-To:To:Cc:References:Date:In-Reply-To;
        b=kEdlXiPywBC55Cdqr8AMLYkbCOEh7njBXRu4dbz0aV/XytJPMBT4RuMYVeDzl7X/W
         hxgLUjvcObqo+P2qxybgt+3oNCimuVbMpiQap2FlaViqW890tCm2XPEdPD+/rsPL23
         dM1p2SmN6eWsMEKnl1Xx2JI8yXj8IOICSW07o87p1CM52PnmLFT5L8qNeapVAbyPI8
         ndNrWPq/w/t9m241Yisk5I8V8LUzqqceJZW+8+ca9GtbwfusniDcYP+e39uFFmMRPI
         2IftnkLv1KVH8qoR5jFbW0aropdKpn/0LD+IzGN0x0YXiThyRK67x7LTFCqkTwGftB
         x+tCU1mHVpRbw==
X-CNFS-Analysis: v=2.3 cv=D9k51cZj c=1 sm=1 tr=0
 a=KzXHLLuG32F0DtnFfJanyA==:117 a=KzXHLLuG32F0DtnFfJanyA==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=FAYuSiQjT8wHOrn6wT0A:9
 a=QEXdDO2ut3YA:10
From:   Goffredo Baroncelli <kreijack@libero.it>
Subject: Re: Avoiding BRTFS RAID5 write hole
Reply-To: kreijack@inwind.it
To:     Hubert Tonneau <hubert.tonneau@fullpliant.org>
Cc:     linux-btrfs@vger.kernel.org
References: <0JGAX5Q12@briare1.fullpliant.org>
 <7723feea-c3cd-b1eb-b882-aa782bbc6e2a@libero.it>
 <hubert_tonneau/4RYCU6X4/0JGEB54@hubert-tonneau.storga.com>
Message-ID: <ba3a73e8-d009-48f6-a6b0-e6ba57752798@libero.it>
Date:   Sun, 17 Nov 2019 09:53:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <hubert_tonneau/4RYCU6X4/0JGEB54@hubert-tonneau.storga.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPB17lPtqdzzfGO5s3iBfU83M+pnU3L7ym0G6a5CwpmNmtLeRZCr2OCQM1dLgd/1yGw3OFSq/OKXrBhAx5nWd1nTx7/Jcruyt4BjxBfgJQ1As1MyJ5hT
 EuCoBM9XlL+dcrMPQ76Fde2BlX+Km1o7OpXmTTxHGx+gcft05Jv3/tBHexUELH+50E4WvSBKxEaqwoAI0SGtuuIaJzDsgqaFucC7ZzQHU1zrLU1V4xExY/3l
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/11/2019 21.41, Hubert Tonneau wrote:
> Goffredo Baroncelli wrote:
>>
>> Why do you think that this approach is more IO expensive ?
>>
>> Supposing to have n+1 disks, configured as raid5 Raid5
>>
>> The problem is only when you have to update a portion of stripe. So I consider of an amount of data in the range 0..n -> n/2 in average (I omit the size of the disk-stripe which is constant)
> 
> Your approche is way too optimistic.
> If the application is doing random writes on a nocow file, or doing append sync append sync append sync on a log, then it will rather be something like n/10 (10 is arbitrary number, but it will be much more than 2)

We need data to prove which is the best model: n/2 or n/10.... Otherwise we have only assumption. What it is true, is that in case of small repeated in same stripe writes your approach is better. In case the writes are all spread on the disks you have more writes.
> 
>> 1) stripe update in place (current BTRFS behavior)
>> The data to write is  ~ n/2 +1 (in average half of the stripe size + parity)
> 
> You have forgotten that you have to do a read of the parity before being abble to write, and this is what is going to take the server to a crawl if it does not write full RAID5 stripes.

With exception of having a missing device, it is not needed to read the parity. However you have to read the *full* stripe (but this is true for every solution) to calculate the parity.
> 
>> 2) COW stripe (my idea)
>> The data to write is ~ n + 1 (the full stripe size + parity)
> 
> Same, you have to do read before write, in order to get the unchanged part of the stripe.
> 
>> 3) Your solution (cache in RAID1)
>> The data to write is
>> 	a) write data to raid1: ~ n/2 * 2 = n (data written on two disks)
>> 	b) update the RAID5 stripe: ~ n/2 + 1
>>
>> Total:	~ 3 * n/2 + 1
> 
> Your count shows that I did not express properly what I'm suggesting. Sorry about that.
> What I'm suggesting, with something closer to your wording, is
> a) copy the RAID5 stripe to a new RAID1 one at a different place: n * 2 (and need to read before write)
> b) in place overwrite the new RAID1 stripe: n/2 * 2
> Of course, you could optimize and do a) and b) in one step, so the overall cost would be n * 2 instead of n * 3

I wrote 3/2 *n not n*3... Pay attention that this includes also the updating of the RAID5...

Anyway I was wrong: you have to cache the full stripe, before updating the raid5 stripe. Why ? If you don't update the full stripe (so the parity is not aligned to the data) AND lose one disk (not involved int the update), you cannot rebuild the missing data.

So the corrected calculation is:
[...]
3) Your solution (cache in RAID1)
The data to write is
	a) write data to raid1: ~ n * 2  (data written on two disks)
	b) update the RAID5 stripe: ~ n/2 + 1

Total:	~ (2+1/2) * n + 1
[...]

> What is important is that what I'm suggesting is to NEVER update in place a RAID5 stripe. If you need to update a RAID5 stripe, first turn it to some RAID stripes at a different place of the disks. This is what a) does.
> Also, since all active parts are already RAID1, a) is a fairly rare operation.
> 
> ---
> 
> Let me get back to the basic:
> With RAID5, if you want good performances and data safety, you have to do only full new stripes writes (no in place overwrite), because it avoids the read before write need, and the write hole.
> It means that you need variable size stripes. This is ZFS way, as far as I understand it, and it brings a lot of complexity and makes it harder to deal with fragmentation, so this is what we would like to avoid it for BTRFS.
> 
> On the other hand, with RAID1, you can update in place, so everything is simple and fast.
> This is why current BTRFS RAID1 is satisfying.
> Only large file sequencial write on RAID5 is faster than RAID1, but we can assume that if people switch to RAID5, for all but very special use cases, it is not for faster sequencial write speed, but for more storage space available to the application.
> 
> As a summary, the only problem with current RAID1 BTRFS implementation, is that it provides a poor usable versus raw disk space ratio, just as any pure RAID1 implementation.
> So, I see RAID5 as just a way to improve this ratio (same for RAID6 and RAID1C3).
> That is why you need a background process that will select some large files that don't have the nocow flag set, and convert (not in place) them from RAID1 to RAID5 in order to consume less disk space.
> The same process should convert (not in place) the file from RAID5 to RAID1 if the nocow flag has been set.
> For any new files, use RAID1.
> This is also why a) costy operation will be rare.
> In the end, you get RAID1 performances and data safety, but a better usable versus raw disk space ratio, and this is just what most of us expect from the filesystem.

If I understood correctly, ZFS acts like you describe: it has a cache called L2ARC, where the data are written on disks before updating the filesystem. You are suggesting to keep the "hot" data in a RAID1 block group, and write/update the RADID5 block group only when the data is "cold" in the RAID1 cache.
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
