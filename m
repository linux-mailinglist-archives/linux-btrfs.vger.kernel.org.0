Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 134BDB0376
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 20:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbfIKSTM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 14:19:12 -0400
Received: from mail-qk1-f176.google.com ([209.85.222.176]:36357 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbfIKSTM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 14:19:12 -0400
Received: by mail-qk1-f176.google.com with SMTP id s18so21839582qkj.3
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2019 11:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i1T19SkPU+cFnelKdy9GHyeldabdUHMUXqyEchdHFpc=;
        b=CFOnNSq7QCWS7sNw3xCh+nQ1D4lB4c/PdzIlqiwUUDTK151rSu/hNWoVTs+BIuIuDT
         FZArvqhgBN5imEh54rWjeYLvY13bP72Lg1ctBRlWjR3ONBhBkwHIDaD1IH+tJ79Ak2MK
         vq2isH51aMEVROUpHRGk2lXlGsIEdToUOKe1PcYb6el9yLOViLfZSIqOG6pG1UUw2n45
         T53Shzt3ee3qRD3qT+PujigaMQhSs3kLOQz2XrFbnfxTt5EvKn797UqvOsB5g4wZDMG+
         O8DyT0YiZYqCFaGJ7AXmQM+vdc5kXqAgArxE7xpzRMV3vbYjbeeX0aaiK73qfLYHGzvF
         05wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i1T19SkPU+cFnelKdy9GHyeldabdUHMUXqyEchdHFpc=;
        b=FApvcMel8XABQ6IAVtSPSeG9G92WoP4nTE8E3OcAQY6az/nL+5M8pVo4XjRPuEbmmN
         TZj/AVVqZRNoTSr6+xjPZCqA+eoIFpnJjCQVduk1a8dJKyVE4Yz1gNLDWXtZklZA5n5f
         42bbvse5PaFXn83MIvNwi4cdlkXsclYcoxkqabPRSBMKcW1d9oDbvpC0YvBFKEzn6Fzt
         PjIwgTGK03kJov2Ze66pjlk8GJ7GSm8E6mLjAGpFfyvSN7z68xo/NzbsBOCtEiD7CS+Q
         5hOZq26vi2mjf0C03Blp4hsT3xz+eEA4TGY5rfUlvyxQHpEciCaiJw0ESHs8/7q8XUVX
         H+tQ==
X-Gm-Message-State: APjAAAX4nWQiOxpqdDqIwX5qqtYg+UlHQ/EhNn8e4fDekHmAoXa2+FP0
        nmPagTRGhtY/tALL/eFRhAtXjTHK+I0=
X-Google-Smtp-Source: APXvYqwUBCevTlRddNxEVVZei0TMBak6FeWvix+x29Ir6lB53wtdT3gWBnyxT/eXBCUuoygHH+0tPQ==
X-Received: by 2002:a37:b981:: with SMTP id j123mr32921517qkf.201.1568225949604;
        Wed, 11 Sep 2019 11:19:09 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id x5sm9784150qkn.102.2019.09.11.11.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2019 11:19:09 -0700 (PDT)
Subject: Re: Feature requests: online backup - defrag - change RAID level
To:     webmaster@zedlx.com
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
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <c8da6684-6c16-fc80-8e10-1afc1871d512@gmail.com>
Date:   Wed, 11 Sep 2019 14:19:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190911132053.Horde._wJd24LqxxXx9ujl2r5i7PQ@server53.web-hosting.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-09-11 13:20, webmaster@zedlx.com wrote:
> 
> Quoting "Austin S. Hemmelgarn" <ahferroin7@gmail.com>:
> 
>> On 2019-09-10 19:32, webmaster@zedlx.com wrote:
>>>
>>> Quoting "Austin S. Hemmelgarn" <ahferroin7@gmail.com>:
>>>
> 
>>>
>>> === I CHALLENGE you and anyone else on this mailing list: ===
>>>
>>>  - Show me an exaple where splitting an extent requires unsharing, 
>>> and this split is needed to defrag.
>>>
>>> Make it clear, write it yourself, I don't want any machine-made outputs.
>>>
>> Start with the above comment about all writes unsharing the region 
>> being written to.
>>
>> Now, extrapolating from there:
>>
>> Assume you have two files, A and B, each consisting of 64 filesystem 
>> blocks in single shared extent.  Now assume somebody writes a few 
>> bytes to the middle of file B, right around the boundary between 
>> blocks 31 and 32, and that you get similar writes to file A straddling 
>> blocks 14-15 and 47-48.
>>
>> After all of that, file A will be 5 extents:
>>
>> * A reflink to blocks 0-13 of the original extent.
>> * A single isolated extent consisting of the new blocks 14-15
>> * A reflink to blocks 16-46 of the original extent.
>> * A single isolated extent consisting of the new blocks 47-48
>> * A reflink to blocks 49-63 of the original extent.
>>
>> And file B will be 3 extents:
>>
>> * A reflink to blocks 0-30 of the original extent.
>> * A single isolated extent consisting of the new blocks 31-32.
>> * A reflink to blocks 32-63 of the original extent.
>>
>> Note that there are a total of four contiguous sequences of blocks 
>> that are common between both files:
>>
>> * 0-13
>> * 16-30
>> * 32-46
>> * 49-63
>>
>> There is no way to completely defragment either file without splitting 
>> the original extent (which is still there, just not fully referenced 
>> by either file) unless you rewrite the whole file to a new single 
>> extent (which would, of course, completely unshare the whole file).  
>> In fact, if you want to ensure that those shared regions stay 
>> reflinked, there's no way to defragment either file without 
>> _increasing_ the number of extents in that file (either file would 
>> need 7 extents to properly share only those 4 regions), and even then 
>> only one of the files could be fully defragmented.
>>
>> Such a situation generally won't happen if you're just dealing with 
>> read-only snapshots, but is not unusual when dealing with regular 
>> files that are reflinked (which is not an uncommon situation on some 
>> systems, as a lot of people have `cp` aliased to reflink things 
>> whenever possible).
> 
> Well, thank you very much for writing this example. Your example is 
> certainly not minimal, as it seems to me that one write to the file A 
> and one write to file B would be sufficient to prove your point, so 
> there we have one extra write in the example, but that's OK.
> 
> Your example proves that I was wrong. I admit: it is impossible to 
> perfectly defrag one subvolume (in the way I imagined it should be done).
> Why? Because, as in your example, there can be files within a SINGLE 
> subvolume which share their extents with each other. I didn't consider 
> such a case.
> 
> On the other hand, I judge this issue to be mostly irrelevant. Why? 
> Because most of the file sharing will be between subvolumes, not within 
> a subvolume.
Not necessarily. Even ignoring the case of data deduplication (which 
needs to be considered if you care at all about enterprise usage, and is 
part of the whole point of using a CoW filesystem), there are existing 
applications that actively use reflinks, either directly or indirectly 
(via things like the `copy_file_range` system call), and the number of 
such applications is growing.

> When a user creates a reflink to a file in the same 
> subvolume, he is willingly denying himself the assurance of a perfect 
> defrag. Because, as your example proves, if there are a few writes to 
> BOTH files, it gets impossible to defrag perfectly. So, if the user 
> creates such reflinks, it's his own whish and his own fault.
The same argument can be made about snapshots.  It's an invalid argument 
in both cases though because it's not always the user who's creating the 
reflinks or snapshots.
> 
> Such situations will occur only in some specific circumstances:
> a) when the user is reflinking manually
> b) when a file is copied from one subvolume into a different file in a 
> different subvolume.
> 
> The situation a) is unusual in normal use of the filesystem. Even when 
> it occurs, it is the explicit command given by the user, so he should be 
> willing to accept all the consequences, even the bad ones like imperfect 
> defrag.
> 
> The situation b) is possible, but as far as I know copies are currently 
> not done that way in btrfs. There should probably be the option to 
> reflink-copy files fron another subvolume, that would be good.
> 
> But anyway, it doesn't matter. Because most of the sharing will be 
> between subvolumes, not within subvolume. So, if there is some 
> in-subvolume sharing, the defrag wont be 100% perfect, that a minor 
> point. Unimportant.
You're focusing too much on your own use case here.  Not everybody uses 
snapshots, and there are many people who are using reflinks very 
actively within subvolumes, either for deduplication or because it saves 
time and space when dealing with multiple copies of mostly identical 
tress of files.
> 
>>> About merging extents: a defrag should merge extents ONLY when both 
>>> extents are shared by the same files (and when those extents are 
>>> neighbours in both files). In other words, defrag should always merge 
>>> without unsharing. Let's call that operation "fusing extents", so 
>>> that there are no more misunderstandings.
> 
>> And I reiterate: defrag only operates on the file it's passed in.  It 
>> needs to for efficiency reasons (we had a reflink aware defrag for a 
>> while a few years back, it got removed because performance limitations 
>> meant it was unusable in the cases where you actually needed it). 
>> Defrag doesn't even know that there are reflinks to the extents it's 
>> operating on.
> 
> If the defrag doesn't know about all reflinks, that's bad in my view. 
> That is a bad defrag. If you had a reflink-aware defrag, and it was 
> slow, maybe that happened because the implementation was bad. Because, I 
> don't see any reason why it should be slow. So, you will have to explain 
> to me what was causing this performance problems.
> 
>> Given this, defrag isn't willfully unsharing anything, it's just a 
>> side-effect of how it works (since it's rewriting the block layout of 
>> the file in-place).
> 
> The current defrag has to unshare because, as you said, because it is 
> unaware of the full reflink structure. If it doesn't know about all 
> reflinks, it has to unshare, there is no way around that.
> 
>> Now factor in that _any_ write will result in unsharing the region 
>> being written to, rounded to the nearest full filesystem block in both 
>> directions (this is mandatory, it's a side effect of the copy-on-write 
>> nature of BTRFS, and is why files that experience heavy internal 
>> rewrites get fragmented very heavily and very quickly on BTRFS).
> 
> You mean: when defrag performs a write, the new data is unshared because 
> every write is unshared? Really?
> 
> Consider there is an extent E55 shared by two files A and B. The defrag 
> has to move E55 to another location. In order to do that, defrag creates 
> a new extent E70. It makes it belong to file A by changing the reflink 
> of extent E55 in file A to point to E70.
> 
> Now, to retain the original sharing structure, the defrag has to change 
> the reflink of extent E55 in file B to point to E70. You are telling me 
> this is not possible? Bullshit!
> 
> Please explain to me how this 'defrag has to unshare' story of yours 
> isn't an intentional attempt to mislead me.
As mentioned in the previous email, we actually did have a (mostly) 
working reflink-aware defrag a few years back.  It got removed because 
it had serious performance issues.  Note that we're not talking a few 
seconds of extra time to defrag a full tree here, we're talking 
double-digit _minutes_ of extra time to defrag a moderate sized (low 
triple digit GB) subvolume with dozens of snapshots, _if you were lucky_ 
(if you weren't, you would be looking at potentially multiple _hours_ of 
runtime for the defrag).  The performance scaled inversely proportionate 
to the number of reflinks involved and the total amount of data in the 
subvolume being defragmented, and was pretty bad even in the case of 
only a couple of snapshots.

Ultimately, there are a couple of issues at play here:

* Online defrag has to maintain consistency during operation.  The 
current implementation does this by rewriting the regions being 
defragmented (which causes them to become a single new extent (most of 
the time)), which avoids a whole lot of otherwise complicated logic 
required to make sure things happen correctly, and also means that only 
the file being operated on is impacted and only the parts being modified 
need to be protected against concurrent writes.  Properly handling 
reflinks means that _every_ file that shares some part of an extent with 
the file being operated on needs to have the reflinked regions locked 
for the defrag operation, which has a huge impact on performance. Using 
your example, the update to E55 in both files A and B has to happen as 
part of the same commit, which can contain no other writes in that 
region of the file, otherwise you run the risk of losing writes to file 
B that occur while file A is being defragmented.  It's not horrible when 
it's just a small region in two files, but it becomes a big issue when 
dealing with lots of files and/or particularly large extents (extents in 
BTRFS can get into the GB range in terms of size when dealing with 
really big files).

* Reflinks can reference partial extents.  This means, ultimately, that 
you may end up having to split extents in odd ways during defrag if you 
want to preserve reflinks, and might have to split extents _elsewhere_ 
that are only tangentially related to the region being defragmented. 
See the example in my previous email for a case like this, maintaining 
the shared regions as being shared when you defragment either file to a 
single extent will require splitting extents in the other file (in 
either case, whichever file you don't defragment to a single extent will 
end up having 7 extents if you try to force the one that's been 
defragmented to be the canonical version).  Once you consider that a 
given extent can have multiple ranges reflinked from multiple other 
locations, it gets even more complicated.

* If you choose to just not handle the above point by not letting defrag 
split extents, you put a hard lower limit on the amount of fragmentation 
present in a file if you want to preserve reflinks.  IOW, you can't 
defragment files past a certain point.  If we go this way, neither of 
the two files in the example from my previous email could be 
defragmented any further than they already are, because doing so would 
require splitting extents.

* Determining all the reflinks to a given region of a given extent is 
not a cheap operation, and the information may immediately be stale 
(because an operation right after you fetch the info might change 
things).  We could work around this by locking the extent somehow, but 
doing so would be expensive because you would have to hold the lock for 
the entire defrag operation.
