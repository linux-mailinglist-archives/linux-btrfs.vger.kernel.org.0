Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAC7CB166F
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2019 00:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfILWrZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 18:47:25 -0400
Received: from server53-3.web-hosting.com ([198.54.126.113]:32845 "EHLO
        server53-3.web-hosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726032AbfILWrZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 18:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=zedlx.com;
         s=default; h=Content-Transfer-Encoding:MIME-Version:Content-Type:In-Reply-To
        :References:Subject:Cc:To:From:Message-ID:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=0YN3BUWktvubW85d06iNYwSgoxAglwKrW8AEd5tVKtE=; b=SvImK0jz82TUcXDhoFIW8HNTGD
        3iH6ShOMBze+r754HnOH6dhK4DG74ooBnDQX+iBO5u3K/6/IjUbBNzxYL+Ik9vIe+gZ2nGTcY9GRQ
        gsRmfn+9k9dVY0JopRePVW4wy5TaRCNoDO05Wx67wNs3fmKKu3SNBsg9iaQJzFSSgkKyXm38STrGj
        QoiEqryqfDz+19zmf34Ug464vSF9fd+MLR9W2HQQ5ngx1KqYxtcrT6cbYWpPc4Z9xduK05AKt8kRS
        CgcgReoSvpQbfMtlcRk8hX2/KraVBrNXw4Ou3MSMTzti2pNLhW49VgpHuLLSMK4TB8EaX9mGy8a7p
        RyfwGYRw==;
Received: from [::1] (port=36886 helo=server53.web-hosting.com)
        by server53.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <general-zed@zedlx.com>)
        id 1i8Xrz-003zXu-My; Thu, 12 Sep 2019 18:47:24 -0400
Received: from [95.178.242.92] ([95.178.242.92]) by server53.web-hosting.com
 (Horde Framework) with HTTPS; Thu, 12 Sep 2019 18:47:19 -0400
Date:   Thu, 12 Sep 2019 18:47:19 -0400
Message-ID: <20190912184719.Horde.Hl_ez-nVt2rCMxFVw4Zy7XQ@server53.web-hosting.com>
From:   General Zed <general-zed@zedlx.com>
To:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Feature requests: online backup - defrag - change RAID level
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
In-Reply-To: <5e25ea36-0c96-2770-d3b9-56b1b9f4066d@gmail.com>
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server53.web-hosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - zedlx.com
X-Get-Message-Sender-Via: server53.web-hosting.com: authenticated_id: zedlryqc/from_h
X-Authenticated-Sender: server53.web-hosting.com: general-zed@zedlx.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, already matched
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Quoting "Austin S. Hemmelgarn" <ahferroin7@gmail.com>:

> On 2019-09-12 15:18, webmaster@zedlx.com wrote:
>>
>> Quoting "Austin S. Hemmelgarn" <ahferroin7@gmail.com>:
>>
>>> On 2019-09-11 17:37, webmaster@zedlx.com wrote:
>>>>
>>>> Quoting "Austin S. Hemmelgarn" <ahferroin7@gmail.com>:
>>>>
>>>>> On 2019-09-11 13:20, webmaster@zedlx.com wrote:
>>>>>>
>>>>>> Quoting "Austin S. Hemmelgarn" <ahferroin7@gmail.com>:
>>>>>>
>>>>>>> On 2019-09-10 19:32, webmaster@zedlx.com wrote:
>>>>>>>>
>>>>>>>> Quoting "Austin S. Hemmelgarn" <ahferroin7@gmail.com>:
>>>>>>>>
>>>>

>>>>> * Reflinks can reference partial extents.  This means,  
>>>>> ultimately, that you may end up having to split extents in odd  
>>>>> ways during defrag if you want to preserve reflinks, and might  
>>>>> have to split extents _elsewhere_ that are only tangentially  
>>>>> related to the region being defragmented. See the example in my  
>>>>> previous email for a case like this, maintaining the shared  
>>>>> regions as being shared when you defragment either file to a  
>>>>> single extent will require splitting extents in the other file  
>>>>> (in either case, whichever file you don't defragment to a single  
>>>>> extent will end up having 7 extents if you try to force the one  
>>>>> that's been defragmented to be the canonical version).  Once you  
>>>>> consider that a given extent can have multiple ranges reflinked  
>>>>> from multiple other locations, it gets even more complicated.
>>>>
>>>> I think that this problem can be solved, and that it can be  
>>>> solved perfectly (the result is a perfectly-defragmented file).  
>>>> But, if it is so hard to do, just skip those problematic extents  
>>>> in initial version of defrag.
>>>>
>>>> Ultimately, in the super-duper defrag, those partially-referenced  
>>>> extents should be split up by defrag.
>>>>
>>>>> * If you choose to just not handle the above point by not  
>>>>> letting defrag split extents, you put a hard lower limit on the  
>>>>> amount of fragmentation present in a file if you want to  
>>>>> preserve reflinks.  IOW, you can't defragment files past a  
>>>>> certain point.  If we go this way, neither of the two files in  
>>>>> the example from my previous email could be defragmented any  
>>>>> further than they already are, because doing so would require  
>>>>> splitting extents.
>>>>
>>>> Oh, you're reading my thoughts. That's good.
>>>>
>>>> Initial implementation of defrag might be not-so-perfect. It  
>>>> would still be better than the current defrag.
>>>>
>>>> This is not a one-way street. Handling of partially-used extents  
>>>> can be improved in later versions.
>>>>
>>>>> * Determining all the reflinks to a given region of a given  
>>>>> extent is not a cheap operation, and the information may  
>>>>> immediately be stale (because an operation right after you fetch  
>>>>> the info might change things).  We could work around this by  
>>>>> locking the extent somehow, but doing so would be expensive  
>>>>> because you would have to hold the lock for the entire defrag  
>>>>> operation.
>>>>
>>>> No. DO NOT LOCK TO RETRIEVE REFLINKS.
>>>>
>>>> Instead, you have to create a hook in every function that updates  
>>>> the reflink structure or extents (for exaple, write-to-file  
>>>> operation). So, when a reflink gets changed, the defrag is  
>>>> immediately notified about this. That way the defrag can keep its  
>>>> data about reflinks in-sync with the filesystem.
>>
>>> This doesn't get around the fact that it's still an expensive  
>>> operation to enumerate all the reflinks for a given region of a  
>>> file or extent.
>>
>> No, you are wrong.
>>
>> In order to enumerate all the reflinks in a region, the defrag  
>> needs to have another array, which is also kept in memory and in  
>> sync with the filesystem. It is the easiest to divide the disk into  
>> regions of equal size, where each region is a few MB large. Lets  
>> call this array "regions-to-extents" array. This array doesn't need  
>> to be associative, it is a plain array.
>> This in-memory array links regions of disk to extents that are in  
>> the region. The array in initialized when defrag starts.
>>
>> This array makes the operation of finding all extents of a region  
>> extremely fast.
> That has two issues:
>
> * That's going to be a _lot_ of memory.  You still need to be able  
> to defragment big (dozens plus TB) arrays without needing multiple  
> GB of RAM just for the defrag operation, otherwise it's not  
> realistically useful (remember, it was big arrays that had issues  
> with the old reflink-aware defrag too).

> * You still have to populate the array in the first place.  A sane  
> implementation wouldn't be keeping it in memory even when defrag is  
> not running (no way is anybody going to tolerate even dozens of MB  
> of memory overhead for this), so you're not going to get around the  
> need to enumerate all the reflinks for a file at least once (during  
> startup, or when starting to process that file), so you're just  
> moving the overhead around instead of eliminating it.

Nope, I'm not just "moving the overhead around instead of eliminating  
it", I am eliminating it.

The only overhead is at defrag startup, when the entire b-tree  
structure has to be loaded and examined. That happens in a few seconds.

After this point, there is no more "overhead" because the running  
defrag is always notified of any changes to the b-trees (by hookc in  
b-tree update routines). Whenever there is such a change,  
region-extents array gets updated. Since this region-extents array is  
in-memory, the update is so fast that it can be considered a zero  
overhead.


