Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBE4B24F6
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2019 20:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389348AbfIMSUS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Sep 2019 14:20:18 -0400
Received: from server53-3.web-hosting.com ([198.54.126.113]:54839 "EHLO
        server53-3.web-hosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389336AbfIMSUS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Sep 2019 14:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=zedlx.com;
         s=default; h=MIME-Version:Content-Type:In-Reply-To:References:Subject:Cc:To:
        From:Message-ID:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=g8DSVshVl8Qb+oqHwXoil/1oROTw5NTVPIA839Sv6RE=; b=5jSCKYl/lGD+78KRL9VXP7Sm5M
        BOLLZy3XR/py12b0PDtkFI5KxMCXG2R4RoGTD1sY+VgigQ+094zPWt6t9ay2bQq9/4B3ZeqLHvrOf
        HP1QmqgtFGK/s5105cdgKHpuKA5I0giewvnwNucqSCmzBarcCjEHj3sekSc7YcSzCwB3PU2uzaz2A
        VxDCXzMXGn1nVEsNi3TrAc1hO7yi7wZw5127scDDY7pw6zHn/K5KLvbvTbwG8H8+a77w9+xrg7IFX
        oRdhhzKv8GPRd9jlEpRgINJfn8YdwFEGd9MclLXwMcrhL+7OCsZOLAIf1T3ZzNUuFjx4sWH7mv2I7
        1Fb5o5iQ==;
Received: from [::1] (port=42604 helo=server53.web-hosting.com)
        by server53.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <general-zed@zedlx.com>)
        id 1i8qB2-000qdj-VQ; Fri, 13 Sep 2019 14:20:17 -0400
Received: from [95.178.242.92] ([95.178.242.92]) by server53.web-hosting.com
 (Horde Framework) with HTTPS; Fri, 13 Sep 2019 14:20:12 -0400
Date:   Fri, 13 Sep 2019 14:20:12 -0400
Message-ID: <20190913142012.Horde.whO8BwkauYeBN5sI0Hz_xcC@server53.web-hosting.com>
From:   General Zed <general-zed@zedlx.com>
To:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Feature requests: online backup - defrag - change RAID level
References: <20190908225508.Horde.51Idygc4ykmhqRn316eLdRO@server53.web-hosting.com>
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
 <CAJCQCtQbRCdVOknOo6vusG+fQu1SB3=h8r=qDcZHUu+EFe480A@mail.gmail.com>
 <20190912173440.Horde.WmxNqLlw7nsFNa-Ux9TTgbz@server53.web-hosting.com>
 <CAJCQCtS8i5rTOYgEM2DFjoiZJBFsL6sgOGwp-1shMs859-r=qg@mail.gmail.com>
 <20190912185726.Horde.HMciH9Z16kV4fK10AfUeRA8@server53.web-hosting.com>
 <2d952392-4677-e9f8-7a24-44a617eb5275@gmail.com>
 <20190913132036.Horde.FOsOfG4U-p_Hi-9Jg4Mqj0E@server53.web-hosting.com>
In-Reply-To: <20190913132036.Horde.FOsOfG4U-p_Hi-9Jg4Mqj0E@server53.web-hosting.com>
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
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


Quoting General Zed <general-zed@zedlx.com>:

> Quoting "Austin S. Hemmelgarn" <ahferroin7@gmail.com>:
>
>> On 2019-09-12 18:57, General Zed wrote:
>>>
>>> Quoting Chris Murphy <lists@colorremedies.com>:
>>>
>>>> On Thu, Sep 12, 2019 at 3:34 PM General Zed <general-zed@zedlx.com> wrote:
>>>>>
>>>>>
>>>>> Quoting Chris Murphy <lists@colorremedies.com>:
>>>>>
>>>>>> On Thu, Sep 12, 2019 at 1:18 PM <webmaster@zedlx.com> wrote:
>>>>>>>
>>>>>>> It is normal and common for defrag operation to use some disk space
>>>>>>> while it is running. I estimate that a reasonable limit would be to
>>>>>>> use up to 1% of total partition size. So, if a partition size is 100
>>>>>>> GB, the defrag can use 1 GB. Lets call this "defrag operation space".
>>>>>>
>>>>>> The simplest case of a file with no shared extents, the minimum free
>>>>>> space should be set to the potential maximum rewrite of the file, i.e.
>>>>>> 100% of the file size. Since Btrfs is COW, the entire operation must
>>>>>> succeed or fail, no possibility of an ambiguous in between state, and
>>>>>> this does apply to defragment.
>>>>>>
>>>>>> So if you're defragging a 10GiB file, you need 10GiB minimum free
>>>>>> space to COW those extents to a new, mostly contiguous, set of exents,
>>>>>
>>>>> False.
>>>>>
>>>>> You can defragment just 1 GB of that file, and then just write out to
>>>>> disk (in new extents) an entire new version of b-trees.
>>>>> Of course, you don't really need to do all that, as usually only a
>>>>> small part of the b-trees need to be updated.
>>>>
>>>> The `-l` option allows the user to choose a maximum amount to
>>>> defragment. Setting up a default defragment behavior that has a
>>>> variable outcome is not idempotent and probably not a good idea.
>>>
>>> We are talking about a future, imagined defrag. It has no -l  
>>> option yet, as we haven't discussed it yet.
>>>
>>>> As for kernel behavior, it presumably could defragment in portions,
>>>> but it would have to completely update all affected metadata after
>>>> each e.g. 1GiB section, translating into 10 separate rewrites of file
>>>> metadata, all affected nodes, all the way up the tree to the super.
>>>> There is no such thing as metadata overwrites in Btrfs. You're
>>>> familiar with the wandering trees problem?
>>>
>>> No, but it doesn't matter.
>
>> No, it does matter.  Each time you update metadata, you have to  
>> update _the entire tree up to the tree root_.  Even if you batch  
>> your updates, you still have to propagate the update all the way up  
>> to the root of the tree.
>
> Yes, you have to update ALL the way up to the root of the tree, but  
> that is certainly not the ENTIRE b-tree. The "way up to the root" is  
> just a small tiny part of any large b-tree.

Why are you posting this misleading statements? You certainly know  
that the metadata can be only partially updatated.

Why did you say "_the entire tree up to the tree root_"? That sounds  
like you have to update the entire tree.

Why did you say "it does matter" when you know it doesn't matter?

> Therefore, an non-issue.
>
>>> At worst, it just has to completely write-out "all metadata", all  
>>> the way up to the super. It needs to be done just once, because  
>>> what's the point of writing it 10 times over? Then, the super is  
>>> updated as the final commit.
>>>
>>> On my comouter the ENTIRE METADATA is 1 GB. That would be very  
>>> tolerable and doable.
>
>> You sound like you're dealing with a desktop use case.  It's not  
>> unusual for very large arrays (double digit TB or larger) to have  
>> metadata well into the hundreds of GB.  Hell, I've got a 200GB  
>> volume with bunches of small files that's got almost 5GB of  
>> metadata space used.

Why are you trying to imply that I'm just thinking of desktops? If I  
said that I have 1 GB metadata on my computer, it doesn't mean that my  
defrag is supposed to work only on my computer and similars.

It appears as if you are relentless in attempts to make me look wrong,  
to the point of trying to misuse and misinterpret every statement that  
I make.

> I just mentioned this "full-metadata-writeout" as some kind of  
> imagined pathological case. This should never happen in a real  
> defrag. A real defrag always updates only a small part of the  
> metadata.
>
> So, still no problem.



