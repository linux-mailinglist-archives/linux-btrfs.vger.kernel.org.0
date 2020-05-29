Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCCE1E8391
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 May 2020 18:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgE2QXh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 May 2020 12:23:37 -0400
Received: from smtp-34.italiaonline.it ([213.209.10.34]:35406 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726857AbgE2QXg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 May 2020 12:23:36 -0400
Received: from venice.bhome ([78.12.136.199])
        by smtp-34.iol.local with ESMTPA
        id ehnBjvpuctrlwehnBjTJcJ; Fri, 29 May 2020 18:23:34 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inwind.it; s=s2014;
        t=1590769414; bh=SJ6vm2X0x2Ye79fvIWIqVDjKaukILN2glS1WIyVmCUg=;
        h=From;
        b=OH0n6EohULPmUXmC0XemhF09+Dwy4aMB38aoc8OR2JcT8JxwydRvJMrcI9hAv/bX+
         VmoLbUG1cAtO7yvzs+DfRoYp7ycyzndDVwQ3TXG4JIHtmgqEB+MvJm1DI3U119IuM8
         nt3RYNo6DgXxJd8xYyo23qAA9gVKpvB49mHpf3bPi4Py6hhyLn01XcTcOcfoTiIcCm
         0eQW7Z/kZw9S7wOAZewXkDIMx1gaMjckGfBehHhYrQrXtQn/OyhZqCuO28rS7Jsa/n
         tAgYsVPfzrf+M0l6qRHs9h2ZSpLV563xCDntrdT3c2muGuvZcdRsClcmF8EFwAFllx
         N+ZenmOsEbwxw==
X-CNFS-Analysis: v=2.3 cv=TOE7tGta c=1 sm=1 tr=0
 a=kx39m2EDZI1V9vDwKCQCcA==:117 a=kx39m2EDZI1V9vDwKCQCcA==:17
 a=IkcTkHD0fZMA:10 a=9ToffA4dipSxU6f7oOYA:9 a=QEXdDO2ut3YA:10
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH rfc v3] New ioctl BTRFS_IOC_GET_CHUNK_INFO.
To:     Hans van Kranenburg <hans@knorrie.org>, dsterba@suse.cz,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20200319203913.3103-1-kreijack@libero.it>
 <20200319203913.3103-2-kreijack@libero.it>
 <20200525171430.GX18421@twin.jikos.cz>
 <f1a34303-3b1a-dcda-8e67-458b3522e863@libero.it>
 <c879054a-c002-8b9b-4db5-e32caf8a732b@knorrie.org>
From:   Goffredo Baroncelli <kreijack@inwind.it>
Message-ID: <5d757a91-503b-64b7-3416-5a26bb03022f@inwind.it>
Date:   Fri, 29 May 2020 18:23:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <c879054a-c002-8b9b-4db5-e32caf8a732b@knorrie.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfO41Ndvaw/mpcdM0vKwsqf2wf51HbozsUDFXl5eDe0SDV5/u+y/n7X2j8NjADsKlf6K7wOrSMEawGvjfv5wq9vhmDaHhNtePzN0fhOVJw14E6JWBv9P2
 8Izu0kDnrZqFRoKVl8uPHyg575m2FZzJmnIwrnwP4oENXGX993guVgakTlWbQNvLzGABYZusn6BZuQFn7WFbzSuhyvGdhe8wFGKuTX/o9CMhaGgKN3cDaBji
 NSvnhp1jxE9Z+6bPQRKYGDVd+XQVrzdB/D87gDiuJeM=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/28/20 11:03 PM, Hans van Kranenburg wrote:
> Hi,
> 
> On 5/26/20 10:19 PM, Goffredo Baroncelli wrote:
>> On 5/25/20 7:14 PM, David Sterba wrote:
>>> I'll start with the data structures
[...]
>>>
>>> This looks like a copy of btrfs_chunk and stripe, only removing items
>>> not needed for the chunk information. Rather than copying the
>>> unnecessary fileds like dev_uuid in stripe, this should be designed for
>>> data exchange with the usecase in mind.
>>
>> There are two clients for this api:
>> - btrfs fi us
>> - btrfs dev us
>>
>> We can get rid of:
>> 	- "offset" fields (2x)
>> 	- "uuid" fields
>>
>> However the "offset" fields can be used to understand where a logical map
>> is on the physical disks. I am thinking about a graphical tool to show this
>> mapping, which doesn't exits yet -).
>> The offset field may be used as key to get further information (like the chunk
>> usage, see below)
>>
>> Regarding the UUID field, I agree it can be removed because it is redundant (there
>> is already the devid)
>>
>>
>>>
>>> The format does not need follow the exact layout that kernel uses, ie.
>>> chunk info with one embedded stripe and then followed by variable length
>>> array of further stripes. This is convenient in one way but not in
>>> another one. Alternatively each chunk can be emitted as a single entry,
>>> duplicating part of the common fields and adding the stripe-specific
>>> ones. This is for consideration.
>>>
>>> I've looked at my old code doing the chunk dump based on the search
>>> ioctl and found that it also allows to read the chunk usage, with one
>>> extra search to the block group item where the usage is stored. As this
>>> is can be slow, it should be optional. Ie. the main ioctl structure
>>> needs flags where this can be requested.
>>
>> This info could be very useful. I think to something like a balance of
>> chunks which are near filled (or near empty). The question is if we
>> should have a different ioctl.
> 
> Do you mean that you want to allow to a non root user to run btrfs balance?
No at all. The balance is an expensive operation that IMHO need root
privileges to be started.

> 
> Otherwise, no. IMO convenience functions for quickly retrieving a
> specific subset of data should be created as reusable library functions
> in the calling code, not as a redundant extra IOCTL that has to be
> maintained.

I think that there is a misunderstood. There is no intention to take the
place of the current balance ioctl.
The aim of this ioctl is only to get information about the chunk distribution.
Getting the chunk information could help to perform a better balance.
I.e. a balance which start from the chunk more empty the go forward
processing the chunk more filled. Another case use is to visulize how
the chunk are filled, or how the disks are used..


> 
> Hans
> 


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
