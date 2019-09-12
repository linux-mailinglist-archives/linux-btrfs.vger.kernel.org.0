Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 326C1B0DD8
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 13:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731430AbfILLb4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 07:31:56 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]:45438 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731375AbfILLbz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 07:31:55 -0400
Received: by mail-qk1-f174.google.com with SMTP id z67so24000505qkb.12
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Sep 2019 04:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=APTd2I+NkT/5rKFjF+7+phoFHmQvKKUjMQGDRneGxh4=;
        b=ZM45HCsmRrEHe1z4t4vdCi1gTQO4ANXwXif5hhAfjx3VKcMwhiuXGrrDFvtsSXxvG+
         XnjfH7m4nsPAaPYwGwwcfaYUrQksRrrdM/KjyY85UweVJWsIkhobnGsx3KkdpBQqsAKs
         8b8dRKcOpxuzP0bazitJmi4RbXd19TDu5081nKaR6hsnOq6XE+TZzi81o2wCQifMWfzO
         dMXnf6yL7HJRxF+GKgOj7FeLa9fUgnn00yC0AqkSyDLgGAVaFSrbNwfyVKevGzdq45oZ
         vIIBm2m6sUzXBot0qdVKOeXzHQDl7Hlyhizc47eg9djAi2tk9sYVe6ql10FIzB/ff57J
         Pk8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=APTd2I+NkT/5rKFjF+7+phoFHmQvKKUjMQGDRneGxh4=;
        b=GdKbV5zeM7brotIA5175y7hJ5vrhrK7KWEo8yY8HvyJsF/iJqoHCapv+ofi5nV3rwu
         PlK5bF5KSq9OEf5r88Y8diwlgxF82eckqOWgcgl1sySX4ZXbQCPUaHzRB1cOoPTU1RW5
         85009unuiVnBAoKxKlsODus4blPg9v7LfJXvqvip/GEV3hkZaJHvGSX/yjlZCk/O17QP
         DQK/jMHwa51lPmz97eJpmkbYx7xiLtI26XEyndskIs5Y8BRi4Iazj+r7Cd5AkkLtzY/3
         UqMwqEVPktBm7YWz9Ig/AGT3jSgPxie5VsyOhIkb8n58kuxCuLAm5Kb8efbEIX5bpVEQ
         Ujrw==
X-Gm-Message-State: APjAAAWOrQT7u9NAoRuErihNi/jlAh7P7JBJhiZfGT1OAgj4dTDdUGuc
        6VniMe868ol3g3pqG8Pi6MBa9ySuAtE=
X-Google-Smtp-Source: APXvYqw87jq6Qn28Tvy2C8RSD2RmuGTL9268I9HnPcb84qvmjrA3elc/RaNkdyTiRm0EnRX9G+gXEw==
X-Received: by 2002:a37:f50b:: with SMTP id l11mr4036341qkk.347.1568287913555;
        Thu, 12 Sep 2019 04:31:53 -0700 (PDT)
Received: from [191.9.209.46] (rrcs-70-62-41-24.central.biz.rr.com. [70.62.41.24])
        by smtp.gmail.com with ESMTPSA id a11sm11998117qkc.123.2019.09.12.04.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2019 04:31:52 -0700 (PDT)
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
 <c8da6684-6c16-fc80-8e10-1afc1871d512@gmail.com>
 <20190911173725.Horde.aRGy9hKzg3scN15icIxdbco@server53.web-hosting.com>
From:   "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Message-ID: <81f4870e-3ee9-7780-13aa-918d24ca10d8@gmail.com>
Date:   Thu, 12 Sep 2019 07:31:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190911173725.Horde.aRGy9hKzg3scN15icIxdbco@server53.web-hosting.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019-09-11 17:37, webmaster@zedlx.com wrote:
> 
> Quoting "Austin S. Hemmelgarn" <ahferroin7@gmail.com>:
> 
>> On 2019-09-11 13:20, webmaster@zedlx.com wrote:
>>>
>>> Quoting "Austin S. Hemmelgarn" <ahferroin7@gmail.com>:
>>>
>>>> On 2019-09-10 19:32, webmaster@zedlx.com wrote:
>>>>>
>>>>> Quoting "Austin S. Hemmelgarn" <ahferroin7@gmail.com>:
>>>>>
> 
>>>> Given this, defrag isn't willfully unsharing anything, it's just a 
>>>> side-effect of how it works (since it's rewriting the block layout 
>>>> of the file in-place).
>>>
>>> The current defrag has to unshare because, as you said, because it is 
>>> unaware of the full reflink structure. If it doesn't know about all 
>>> reflinks, it has to unshare, there is no way around that.
>>>
>>>> Now factor in that _any_ write will result in unsharing the region 
>>>> being written to, rounded to the nearest full filesystem block in 
>>>> both directions (this is mandatory, it's a side effect of the 
>>>> copy-on-write nature of BTRFS, and is why files that experience 
>>>> heavy internal rewrites get fragmented very heavily and very quickly 
>>>> on BTRFS).
>>>
>>> You mean: when defrag performs a write, the new data is unshared 
>>> because every write is unshared? Really?
>>>
>>> Consider there is an extent E55 shared by two files A and B. The 
>>> defrag has to move E55 to another location. In order to do that, 
>>> defrag creates a new extent E70. It makes it belong to file A by 
>>> changing the reflink of extent E55 in file A to point to E70.
>>>
>>> Now, to retain the original sharing structure, the defrag has to 
>>> change the reflink of extent E55 in file B to point to E70. You are 
>>> telling me this is not possible? Bullshit!
>>>
>>> Please explain to me how this 'defrag has to unshare' story of yours 
>>> isn't an intentional attempt to mislead me.
> 
>> As mentioned in the previous email, we actually did have a (mostly) 
>> working reflink-aware defrag a few years back.  It got removed because 
>> it had serious performance issues.  Note that we're not talking a few 
>> seconds of extra time to defrag a full tree here, we're talking 
>> double-digit _minutes_ of extra time to defrag a moderate sized (low 
>> triple digit GB) subvolume with dozens of snapshots, _if you were 
>> lucky_ (if you weren't, you would be looking at potentially multiple 
>> _hours_ of runtime for the defrag).  The performance scaled inversely 
>> proportionate to the number of reflinks involved and the total amount 
>> of data in the subvolume being defragmented, and was pretty bad even 
>> in the case of only a couple of snapshots.
> 
> You cannot ever make the worst program, because an even worse program 
> can be made by slowing down the original by a factor of 2.
> So, you had a badly implemented defrag. At least you got some 
> experience. Let's see what went wrong.
> 
>> Ultimately, there are a couple of issues at play here:
>>
>> * Online defrag has to maintain consistency during operation.  The 
>> current implementation does this by rewriting the regions being 
>> defragmented (which causes them to become a single new extent (most of 
>> the time)), which avoids a whole lot of otherwise complicated logic 
>> required to make sure things happen correctly, and also means that 
>> only the file being operated on is impacted and only the parts being 
>> modified need to be protected against concurrent writes.  Properly 
>> handling reflinks means that _every_ file that shares some part of an 
>> extent with the file being operated on needs to have the reflinked 
>> regions locked for the defrag operation, which has a huge impact on 
>> performance. Using your example, the update to E55 in both files A and 
>> B has to happen as part of the same commit, which can contain no other 
>> writes in that region of the file, otherwise you run the risk of 
>> losing writes to file B that occur while file A is being defragmented.
> 
> Nah. I think there is a workaround. You can first (atomically) update A, 
> then whatever, then you can update B later. I know, your yelling "what 
> if E55 gets updated in B". Doesn't matter. The defrag continues later by 
> searching for reflink to E55 in B. Then it checks the data contained in 
> E55. If the data matches the E70, then it can safely update the reflink 
> in B. Or the defrag can just verify that neither E55 nor E70 have been 
> written to in the meantime. That means they still have the same data.
So, IOW, you don't care if the total space used by the data is 
instantaneously larger than what you started with?  That seems to be at 
odds with your previous statements, but OK, if we allow for that then 
this is indeed a non-issue.

> 
>> It's not horrible when it's just a small region in two files, but it 
>> becomes a big issue when dealing with lots of files and/or 
>> particularly large extents (extents in BTRFS can get into the GB range 
>> in terms of size when dealing with really big files).
> 
> You must just split large extents in a smart way. So, in the beginning, 
> the defrag can split large extents (2GB) into smaller ones (32MB) to 
> facilitate more responsive and easier defrag.
> 
> If you have lots of files, update them one-by one. It is possible. Or 
> you can update in big batches. Whatever is faster.
Neither will solve this though.  Large numbers of files are an issue 
because the operation is expensive and has to be done on each file, not 
because the number of files somehow makes the operation more espensive. 
It's O(n) relative to files, not higher time complexity.
> 
> The point is that the defrag can keep a buffer of a "pending 
> operations". Pending operations are those that should be performed in 
> order to keep the original sharing structure. If the defrag gets 
> interrupted, then files in "pending operations" will be unshared. But 
> this should really be some important and urgent interrupt, as the 
> "pending operations" buffer needs at most a second or two to complete 
> its operations.
Depending on the exact situation, it can take well more than a few 
seconds to complete stuff. Especially if there are lots of reflinks.
> 
>> * Reflinks can reference partial extents.  This means, ultimately, 
>> that you may end up having to split extents in odd ways during defrag 
>> if you want to preserve reflinks, and might have to split extents 
>> _elsewhere_ that are only tangentially related to the region being 
>> defragmented. See the example in my previous email for a case like 
>> this, maintaining the shared regions as being shared when you 
>> defragment either file to a single extent will require splitting 
>> extents in the other file (in either case, whichever file you don't 
>> defragment to a single extent will end up having 7 extents if you try 
>> to force the one that's been defragmented to be the canonical 
>> version).  Once you consider that a given extent can have multiple 
>> ranges reflinked from multiple other locations, it gets even more 
>> complicated.
> 
> I think that this problem can be solved, and that it can be solved 
> perfectly (the result is a perfectly-defragmented file). But, if it is 
> so hard to do, just skip those problematic extents in initial version of 
> defrag.
> 
> Ultimately, in the super-duper defrag, those partially-referenced 
> extents should be split up by defrag.
> 
>> * If you choose to just not handle the above point by not letting 
>> defrag split extents, you put a hard lower limit on the amount of 
>> fragmentation present in a file if you want to preserve reflinks.  
>> IOW, you can't defragment files past a certain point.  If we go this 
>> way, neither of the two files in the example from my previous email 
>> could be defragmented any further than they already are, because doing 
>> so would require splitting extents.
> 
> Oh, you're reading my thoughts. That's good.
> 
> Initial implementation of defrag might be not-so-perfect. It would still 
> be better than the current defrag.
> 
> This is not a one-way street. Handling of partially-used extents can be 
> improved in later versions.
> 
>> * Determining all the reflinks to a given region of a given extent is 
>> not a cheap operation, and the information may immediately be stale 
>> (because an operation right after you fetch the info might change 
>> things).  We could work around this by locking the extent somehow, but 
>> doing so would be expensive because you would have to hold the lock 
>> for the entire defrag operation.
> 
> No. DO NOT LOCK TO RETRIEVE REFLINKS.
> 
> Instead, you have to create a hook in every function that updates the 
> reflink structure or extents (for exaple, write-to-file operation). So, 
> when a reflink gets changed, the defrag is immediately notified about 
> this. That way the defrag can keep its data about reflinks in-sync with 
> the filesystem.
This doesn't get around the fact that it's still an expensive operation 
to enumerate all the reflinks for a given region of a file or extent.

It also allows a very real possibility of a user functionally delaying 
the defrag operation indefinitely (by triggering a continuous stream of 
operations that would cause reflink changes for a file being operated on 
by defrag) if not implemented very carefully.
> 
> Also note, this defrag should run as a part of the kernel, not in 
> userspace. Defrag-from-userspace is a nightmare. Defrag has to serialize 
> its operations properly, and it must have knowledge of all other 
> operations in progress. So, it can only operate efficiently as part of 
> the kernel.
Agreed on this point.

