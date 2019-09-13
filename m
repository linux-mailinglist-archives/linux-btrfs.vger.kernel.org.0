Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE296B1CAE
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2019 13:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbfIMLx6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Sep 2019 07:53:58 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]:37198 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbfIMLx6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Sep 2019 07:53:58 -0400
Received: by mail-qk1-f171.google.com with SMTP id u184so24926446qkd.4
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Sep 2019 04:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YeBbseuSFKEAongUsZAsrG81XCOrOov2THu68YD7SaA=;
        b=X4Q7+dVakkoW+EDzxMG6WeJ1mHHPXTZvQyh1I2RjLA2irvPYEU/oNiJIjt2Nzyc4zT
         TZRShUPu8ep5GFCBgxXo581gLfchOWT56eH3aGapF/tEE9ItE8FLlT8VIBxf2M1KDxvH
         5gW5oRapNafqR84CIF49H18beOlXf9IWgSp060K2myGj4JfgG5+9NHsP63T2ePeqxCBs
         2WF9oZvoj/uu3ccsF3Xvu5oQmIGlnLFEzpb4OqvZG5l64GBTcdMX9FhA2POPTw0O+0M4
         tZGhMPOGHAHsWXM1+7tSBfS3a4VW4Doy63bZp58TZUTgjffkR0aZxzVeMI2X6o8K1z30
         8Xvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YeBbseuSFKEAongUsZAsrG81XCOrOov2THu68YD7SaA=;
        b=G/gIRLneUyhxe0w/C+fJM7HuZo/7i0wf8aUvvnZ/6jzCB4VFy6ak/FN/n0w1igoO7y
         32Hxhfab+6l7SbBxjbCykm2rvGA5GRJyel5ttAa34mRVbBpd60WB6zGLCeqzCB/XES/v
         4dilidYkTfmACs/38vLbhYsqaAq2I+2ecz9TxRaNzcFwKfv1UPqcA6favpNuhhYTdkAh
         SsH4KWX2SX01W2nFWW62KHaM4TND1ztO7QjmpqjH0EMA63XTU6IowVZrxp4MBsCEDWbN
         sGskuVvO+vt5/PWbC90KMkurUcmp3WJW7PgdCBoFSUT9ckCJuV9095sJfj1cuBkTEDTT
         2Fuw==
X-Gm-Message-State: APjAAAV55/kyFdzBIeq1jGc8zq9RahRc9LU5a372iEnCW1cS5L+/5Mrh
        tHqqEsjkJCHkhJrOo1rPhXzLoXGKu8s=
X-Google-Smtp-Source: APXvYqxmgejyJV48QHq1KHU/ta1Y9vQNENfr9SneBeSJm68imKPXbrPljZbzBRGm3H/FbgXVJvC1/w==
X-Received: by 2002:a37:714:: with SMTP id 20mr46411857qkh.32.1568375636583;
        Fri, 13 Sep 2019 04:53:56 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id h184sm750904qkf.89.2019.09.13.04.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2019 04:53:55 -0700 (PDT)
Subject: Re: Feature requests: online backup - defrag - change RAID level
To:     General Zed <general-zed@zedlx.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
 <5e6a9092-b9f9-58d2-d638-9e165d398747@gmx.com>
 <20190909072518.Horde.c4SobsfDkO6FUtKo3e_kKu0@server53.web-hosting.com>
 <fb80b97a-9bcd-5d13-0026-63e11e1a06b5@gmx.com>
 <c4f05241-77d4-3ae4-9773-795351a26a8e@cobb.uk.net>
 <20190909152625.Horde.fICzOssZXCnCZS2vVHBK-sn@server53.web-hosting.com>
 <fc81fcf2-f8e9-1a08-52f8-136503e40494@gmail.com>
 <20190910193221.Horde.HYrKYqNVgQ10jshWWA1Gxxu@server53.web-hosting.com>
 <d958659e-6dc0-fa0a-7da9-2d88df4588f5@gmail.com>
 <20190911132053.Horde._wJd24LqxxXx9ujl2r5i7PQ@server53.web-hosting.com>
 <c8da6684-6c16-fc80-8e10-1afc1871d512@gmail.com>
 <20190911173725.Horde.aRGy9hKzg3scN15icIxdbco@server53.web-hosting.com>
 <81f4870e-3ee9-7780-13aa-918d24ca10d8@gmail.com>
 <20190912151841.Horde.-wdqt-14W0sbNwBxzhWVB6B@server53.web-hosting.com>
 <5e25ea36-0c96-2770-d3b9-56b1b9f4066d@gmail.com>
 <20190912182159.Horde.PAbf_RFELal1G_hKMz9Lcr7@server53.web-hosting.com>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <82e62e0b-fe19-100b-fdc6-45c8b5858971@gmail.com>
Date:   Fri, 13 Sep 2019 07:53:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190912182159.Horde.PAbf_RFELal1G_hKMz9Lcr7@server53.web-hosting.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-09-12 18:21, General Zed wrote:
> 
> Quoting "Austin S. Hemmelgarn" <ahferroin7@gmail.com>:
> 
>> On 2019-09-12 15:18, webmaster@zedlx.com wrote:
>>>
>>> Quoting "Austin S. Hemmelgarn" <ahferroin7@gmail.com>:
>>>
>>>> On 2019-09-11 17:37, webmaster@zedlx.com wrote:
>>>>>
>>>>> Quoting "Austin S. Hemmelgarn" <ahferroin7@gmail.com>:
>>>>>
>>>>>> On 2019-09-11 13:20, webmaster@zedlx.com wrote:
>>>>>>>
>>>>>>> Quoting "Austin S. Hemmelgarn" <ahferroin7@gmail.com>:
>>>>>>>
>>>>>>>> On 2019-09-10 19:32, webmaster@zedlx.com wrote:
>>>>>>>>>
>>>>>>>>> Quoting "Austin S. Hemmelgarn" <ahferroin7@gmail.com>:
>>>>>>>>>
>>>>>
>>>>>>>> Given this, defrag isn't willfully unsharing anything, it's just 
>>>>>>>> a side-effect of how it works (since it's rewriting the block 
>>>>>>>> layout of the file in-place).
>>>>>>>
>>>>>>> The current defrag has to unshare because, as you said, because 
>>>>>>> it is unaware of the full reflink structure. If it doesn't know 
>>>>>>> about all reflinks, it has to unshare, there is no way around that.
>>>>>>>
>>>>>>>> Now factor in that _any_ write will result in unsharing the 
>>>>>>>> region being written to, rounded to the nearest full filesystem 
>>>>>>>> block in both directions (this is mandatory, it's a side effect 
>>>>>>>> of the copy-on-write nature of BTRFS, and is why files that 
>>>>>>>> experience heavy internal rewrites get fragmented very heavily 
>>>>>>>> and very quickly on BTRFS).
>>>>>>>
>>>>>>> You mean: when defrag performs a write, the new data is unshared 
>>>>>>> because every write is unshared? Really?
>>>>>>>
>>>>>>> Consider there is an extent E55 shared by two files A and B. The 
>>>>>>> defrag has to move E55 to another location. In order to do that, 
>>>>>>> defrag creates a new extent E70. It makes it belong to file A by 
>>>>>>> changing the reflink of extent E55 in file A to point to E70.
>>>>>>>
>>>>>>> Now, to retain the original sharing structure, the defrag has to 
>>>>>>> change the reflink of extent E55 in file B to point to E70. You 
>>>>>>> are telling me this is not possible? Bullshit!
>>>>>>>
>>>>>>> Please explain to me how this 'defrag has to unshare' story of 
>>>>>>> yours isn't an intentional attempt to mislead me.
>>>>>
>>>>>> As mentioned in the previous email, we actually did have a 
>>>>>> (mostly) working reflink-aware defrag a few years back.  It got 
>>>>>> removed because it had serious performance issues.  Note that 
>>>>>> we're not talking a few seconds of extra time to defrag a full 
>>>>>> tree here, we're talking double-digit _minutes_ of extra time to 
>>>>>> defrag a moderate sized (low triple digit GB) subvolume with 
>>>>>> dozens of snapshots, _if you were lucky_ (if you weren't, you 
>>>>>> would be looking at potentially multiple _hours_ of runtime for 
>>>>>> the defrag).  The performance scaled inversely proportionate to 
>>>>>> the number of reflinks involved and the total amount of data in 
>>>>>> the subvolume being defragmented, and was pretty bad even in the 
>>>>>> case of only a couple of snapshots.
>>>>>
>>>>> You cannot ever make the worst program, because an even worse 
>>>>> program can be made by slowing down the original by a factor of 2.
>>>>> So, you had a badly implemented defrag. At least you got some 
>>>>> experience. Let's see what went wrong.
>>>>>
>>>>>> Ultimately, there are a couple of issues at play here:
>>>>>>
>>>>>> * Online defrag has to maintain consistency during operation.  The 
>>>>>> current implementation does this by rewriting the regions being 
>>>>>> defragmented (which causes them to become a single new extent 
>>>>>> (most of the time)), which avoids a whole lot of otherwise 
>>>>>> complicated logic required to make sure things happen correctly, 
>>>>>> and also means that only the file being operated on is impacted 
>>>>>> and only the parts being modified need to be protected against 
>>>>>> concurrent writes.  Properly handling reflinks means that _every_ 
>>>>>> file that shares some part of an extent with the file being 
>>>>>> operated on needs to have the reflinked regions locked for the 
>>>>>> defrag operation, which has a huge impact on performance. Using 
>>>>>> your example, the update to E55 in both files A and B has to 
>>>>>> happen as part of the same commit, which can contain no other 
>>>>>> writes in that region of the file, otherwise you run the risk of 
>>>>>> losing writes to file B that occur while file A is being 
>>>>>> defragmented.
>>>>>
>>>>> Nah. I think there is a workaround. You can first (atomically) 
>>>>> update A, then whatever, then you can update B later. I know, your 
>>>>> yelling "what if E55 gets updated in B". Doesn't matter. The defrag 
>>>>> continues later by searching for reflink to E55 in B. Then it 
>>>>> checks the data contained in E55. If the data matches the E70, then 
>>>>> it can safely update the reflink in B. Or the defrag can just 
>>>>> verify that neither E55 nor E70 have been written to in the 
>>>>> meantime. That means they still have the same data.
>>>
>>>> So, IOW, you don't care if the total space used by the data is 
>>>> instantaneously larger than what you started with?  That seems to be 
>>>> at odds with your previous statements, but OK, if we allow for that 
>>>> then this is indeed a non-issue.
>>>
>>> It is normal and common for defrag operation to use some disk space 
>>> while it is running. I estimate that a reasonable limit would be to 
>>> use up to 1% of total partition size. So, if a partition size is 100 
>>> GB, the defrag can use 1 GB. Lets call this "defrag operation space".
>>>
>>> The defrag should, when started, verify that there is "sufficient 
>>> free space" on the partition. In the case that there is no sufficient 
>>> free space, the defrag should output the message to the user and 
>>> abort. The size of "sufficient free space" must be larger than the 
>>> "defrag operation space". I would estimate that a good limit would be 
>>> 2% of the partition size. "defrag operation space" is a part of 
>>> "sufficient free space" while defrag operation is in progress.
>>>
>>> If, during defrag operation, sufficient free space drops below 2%, 
>>> the defrag should output a message and abort. Another possibility is 
>>> for defrag to pause until the user frees some disk space, but this is 
>>> not common in other defrag implementations AFAIK.
>>>
>>>>>> It's not horrible when it's just a small region in two files, but 
>>>>>> it becomes a big issue when dealing with lots of files and/or 
>>>>>> particularly large extents (extents in BTRFS can get into the GB 
>>>>>> range in terms of size when dealing with really big files).
>>>>>
>>>>> You must just split large extents in a smart way. So, in the 
>>>>> beginning, the defrag can split large extents (2GB) into smaller 
>>>>> ones (32MB) to facilitate more responsive and easier defrag.
>>>>>
>>>>> If you have lots of files, update them one-by one. It is possible. 
>>>>> Or you can update in big batches. Whatever is faster.
>>>
>>>> Neither will solve this though.  Large numbers of files are an issue 
>>>> because the operation is expensive and has to be done on each file, 
>>>> not because the number of files somehow makes the operation more 
>>>> espensive. It's O(n) relative to files, not higher time complexity.
>>>
>>> I would say that updating in big batches helps a lot, to the point 
>>> that it gets almost as fast as defragging any other file system. What 
>>> defrag needs to do is to write a big bunch of defragged file (data) 
>>> extents to the disk, and then update the b-trees. What happens is 
>>> that many of the updates to the b-trees would fall into the same disk 
>>> sector/extent, so instead of many writes there will be just one write.
>>>
>>> Here is the general outline for implementation:
>>>     - write a big bunch of defragged file extents to disk
>>>         - a minimal set of updates of the b-trees that cannot be 
>>> delayed is performed (this is nothing or almost nothing in most 
>>> circumstances)
>>>         - put the rest of required updates of b-trees into "pending 
>>> operations buffer"
>>>     - analyze the "pending operations buffer", and find out 
>>> (approximately) the biggest part of it that can be flushed out by 
>>> doing minimal number of disk writes
>>>         - flush out that part of "pending operations buffer"
>>>     - repeat
> 
>> It helps, but you still can't get around having to recompute the new 
>> tree state, and that is going to take time proportionate to the number 
>> of nodes that need to change, which in turn is proportionate to the 
>> number of files.
> 
> Yes, but that is just a computation. The defrag performance mostly 
> depends on minimizing disk I/O operations, not on computations.
You're assuming the defrag is being done on a system that's otherwise 
perfectly idle.  In the real world, that rarely, if ever, will be the 
case,  The system may be doing other things at the same time, and the 
more computation the defrag operation has to do, the more likely it is 
to negatively impact those other things.
> 
> In the past many good and fast defrag computation algorithms have been 
> produced, and I don't see any reason why this project wouldn't be also 
> able to create such a good algorithm.
Because it's not just the new extent locations you have to compute, you 
also need to compute the resultant metadata tree state, and the 
resultant extent tree state, and after all of that the resultant 
checksum tree state.  Yeah, figuring out optimal block layouts is 
solved, but you can't get around the overhead of recomputing the new 
tree state and all the block checksums for it.

The current defrag has to deal with this too, but it doesn't need to do 
as much computation because it's not worried about preserving reflinks 
(and therefore defragmenting a single file won't require updates to any 
other files).
> 
>>>>> The point is that the defrag can keep a buffer of a "pending 
>>>>> operations". Pending operations are those that should be performed 
>>>>> in order to keep the original sharing structure. If the defrag gets 
>>>>> interrupted, then files in "pending operations" will be unshared. 
>>>>> But this should really be some important and urgent interrupt, as 
>>>>> the "pending operations" buffer needs at most a second or two to 
>>>>> complete its operations.
>>>
>>>> Depending on the exact situation, it can take well more than a few 
>>>> seconds to complete stuff. Especially if there are lots of reflinks.
>>>
>>> Nope. You are quite wrong there.
>>> In the worst case, the "pending operations buffer" will update (write 
>>> to disk) all the b-trees. So, the upper limit on time to flush the 
>>> "pending operations buffer" equals the time to write the entire 
>>> b-tree structure to the disk (into new extents). I estimate that 
>>> takes at most a few seconds.
> 
>> So what you're talking about is journaling the computed state of 
>> defrag operations.  That shouldn't be too bad (as long as it's done in 
>> memory instead of on-disk) if you batch the computations properly.  I 
>> thought you meant having a buffer of what operations to do, and then 
>> computing them on-the-fly (which would have significant overhead)
> 
> Looks close to what I was thinking. Soon we might be able to 
> communicate. I'm not sure what you mean by "journaling the computed 
> state of defrag operations". Maybe it doesn't matter.
Essentially, doing a write-ahead log of pending operations.  Journaling 
is just the common term for such things when dealing with Linux 
filesystems because of ext* and XFS.  Based on what you say below, it 
sounds like we're on the same page here other than the terminology.
> 
> What happens is that file (extent) data is first written to disk 
> (defragmented), but b-tree is not immediately updated. It doesn't have 
> to be. Even if there is a power loss, nothing happens.
> 
> So, the changes that should be done to the b-trees are put into 
> pending-operations-buffer. When a lot of file (extent) data is written 
> to disk, such that defrag-operation-space (1 GB) is close to being 
> exhausted, the pending-operations-buffer is examined in order to attempt 
> to free as much of defrag-operation-space as possible. The simplest 
> algorithm is to flush the entire pending-operations-buffer at once. This 
> reduces the number of writes that update the b-trees because many 
> changes to the b-trees fall into the same or neighbouring disk sectors.
> 
>>>>>> * Reflinks can reference partial extents.  This means, ultimately, 
>>>>>> that you may end up having to split extents in odd ways during 
>>>>>> defrag if you want to preserve reflinks, and might have to split 
>>>>>> extents _elsewhere_ that are only tangentially related to the 
>>>>>> region being defragmented. See the example in my previous email 
>>>>>> for a case like this, maintaining the shared regions as being 
>>>>>> shared when you defragment either file to a single extent will 
>>>>>> require splitting extents in the other file (in either case, 
>>>>>> whichever file you don't defragment to a single extent will end up 
>>>>>> having 7 extents if you try to force the one that's been 
>>>>>> defragmented to be the canonical version).  Once you consider that 
>>>>>> a given extent can have multiple ranges reflinked from multiple 
>>>>>> other locations, it gets even more complicated.
>>>>>
>>>>> I think that this problem can be solved, and that it can be solved 
>>>>> perfectly (the result is a perfectly-defragmented file). But, if it 
>>>>> is so hard to do, just skip those problematic extents in initial 
>>>>> version of defrag.
>>>>>
>>>>> Ultimately, in the super-duper defrag, those partially-referenced 
>>>>> extents should be split up by defrag.
>>>>>
>>>>>> * If you choose to just not handle the above point by not letting 
>>>>>> defrag split extents, you put a hard lower limit on the amount of 
>>>>>> fragmentation present in a file if you want to preserve reflinks.  
>>>>>> IOW, you can't defragment files past a certain point.  If we go 
>>>>>> this way, neither of the two files in the example from my previous 
>>>>>> email could be defragmented any further than they already are, 
>>>>>> because doing so would require splitting extents.
>>>>>
>>>>> Oh, you're reading my thoughts. That's good.
>>>>>
>>>>> Initial implementation of defrag might be not-so-perfect. It would 
>>>>> still be better than the current defrag.
>>>>>
>>>>> This is not a one-way street. Handling of partially-used extents 
>>>>> can be improved in later versions.
>>>>>
>>>>>> * Determining all the reflinks to a given region of a given extent 
>>>>>> is not a cheap operation, and the information may immediately be 
>>>>>> stale (because an operation right after you fetch the info might 
>>>>>> change things).  We could work around this by locking the extent 
>>>>>> somehow, but doing so would be expensive because you would have to 
>>>>>> hold the lock for the entire defrag operation.
>>>>>
>>>>> No. DO NOT LOCK TO RETRIEVE REFLINKS.
>>>>>
>>>>> Instead, you have to create a hook in every function that updates 
>>>>> the reflink structure or extents (for exaple, write-to-file 
>>>>> operation). So, when a reflink gets changed, the defrag is 
>>>>> immediately notified about this. That way the defrag can keep its 
>>>>> data about reflinks in-sync with the filesystem.
>>>
>>>> This doesn't get around the fact that it's still an expensive 
>>>> operation to enumerate all the reflinks for a given region of a file 
>>>> or extent.
>>>
>>> No, you are wrong.
>>>
>>> In order to enumerate all the reflinks in a region, the defrag needs 
>>> to have another array, which is also kept in memory and in sync with 
>>> the filesystem. It is the easiest to divide the disk into regions of 
>>> equal size, where each region is a few MB large. Lets call this array 
>>> "regions-to-extents" array. This array doesn't need to be 
>>> associative, it is a plain array.
>>> This in-memory array links regions of disk to extents that are in the 
>>> region. The array in initialized when defrag starts.
>>>
>>> This array makes the operation of finding all extents of a region 
>>> extremely fast.
>> That has two issues:
>>
>> * That's going to be a _lot_ of memory.  You still need to be able to 
>> defragment big (dozens plus TB) arrays without needing multiple GB of 
>> RAM just for the defrag operation, otherwise it's not realistically 
>> useful (remember, it was big arrays that had issues with the old 
>> reflink-aware defrag too).
> 
> Ok, but let's get some calculations there. If regions are 4 MB in size, 
> the region-extents array for an 8 TB partition would have 2 million 
> entries. If entries average 64 bytes, that would be:
> 
>   - a total of 128 MB memory for an 8 TB partition.
> 
> Of course, I'm guessing a lot of numbers there, but it should be doable.
Even if we assume such an optimistic estimation as you provide (I 
suspect it will require more than 64 bytes per-entry), that's a lot of 
RAM when you look at what it's potentially displacing.  That's enough 
RAM for receive and transmit buffers for a few hundred thousand network 
connections, or for caching multiple hundreds of thousands of dentries, 
or a few hundred thousand inodes.  Hell, that's enough RAM to run all 
the standard network services for a small network (DHCP, DNS, NTP, TFTP, 
mDNS relay, UPnP/NAT-PMP, SNMP, IGMP proxy, VPN of your choice) at least 
twice over.
> 
>> * You still have to populate the array in the first place.  A sane 
>> implementation wouldn't be keeping it in memory even when defrag is 
>> not running (no way is anybody going to tolerate even dozens of MB of 
>> memory overhead for this), so you're not going to get around the need 
>> to enumerate all the reflinks for a file at least once (during 
>> startup, or when starting to process that file), so you're just moving 
>> the overhead around instead of eliminating it.
> 
> Yes, when the defrag starts, the entire b-tree structure is examined in 
> order for region-extents array and extents-backref associative array to 
> be populated.
So your startup is going to take forever on any reasonably large volume. 
  This isn't eliminating the overhead, it's just moving it all to one 
place.  That might make it a bit more efficient than it would be 
interspersed throughout the operation, but only because it is reading 
all the relevant data at once.
> 
> Of course, those two arrays exist only during defrag operation. When 
> defrag completes, those arrays are deallocated.
> 
>>>> It also allows a very real possibility of a user functionally 
>>>> delaying the defrag operation indefinitely (by triggering a 
>>>> continuous stream of operations that would cause reflink changes for 
>>>> a file being operated on by defrag) if not implemented very carefully.
>>>
>>> Yes, if a user does something like that, the defrag can be paused or 
>>> even aborted. That is normal.
>> Not really.  Most defrag implementations either avoid files that could 
>> reasonably be written to, or freeze writes to the file they're 
>> operating on, or in some other way just sidestep the issue without 
>> delaying the defragmentation process.
>>>
>>> There are many ways around this problem, but it really doesn't 
>>> matter, those are just details. The initial version of defrag can 
>>> just abort. The more mature versions of defrag can have a better 
>>> handling of this problem.
> 
>> Details like this are the deciding factor for whether something is 
>> sanely usable in certain use cases, as you have yourself found out 
>> (for a lot of users, the fact that defrag can unshare extents is 'just 
>> a detail' that's not worth worrying about).
> 
> I wouldn't agree there.
> 
> Not every issue is equal. Some issues are more important, some are 
> trivial, some are tolerable etc...
> 
> The defrag is usually allowed to abort. It can easily be restarted 
> later. Workaround: You can make a defrag-supervisor program, which 
> starts a defrag, and if defrag aborts then it is restarted after some 
> (configurable) amount of time.
The fact that the defrag can be functionally deferred indefinitely by a 
user means that a user can, with a bit of effort, force degraded 
performance for everyone using the system.  Aborting the defrag doesn't 
solve that, and it's a significant issue for anybody doing shared hosting.
> 
> On the other hand, unsharing is not easy to get undone.
But, again, it this just doesn't matter for some people.
> 
> So, those issues are not equals.
