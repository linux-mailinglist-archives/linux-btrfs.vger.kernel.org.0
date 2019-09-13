Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54641B16E0
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2019 02:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfIMA0K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 20:26:10 -0400
Received: from server53-3.web-hosting.com ([198.54.126.113]:54486 "EHLO
        server53-3.web-hosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725775AbfIMA0K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 20:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=zedlx.com;
         s=default; h=MIME-Version:Content-Type:In-Reply-To:References:Subject:Cc:To:
        From:Message-ID:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=IHxm5zmCqADx1NqyAiOLiUv55WF6QLu7e0/YUjmwwDI=; b=fDZcTSrPVXRgBOA+tJw1lNpw5L
        eRa6mGMwWIPoqkIa8IDwMfKUIVnsGzwN3yXf/Iqn4MAvBNYLWjq90moEWSEdK/gsiYV9XUz/fa5J3
        /jiWtUWHRnpS0dkXVG46wyHkU32DPjr/NA0Jw01w4Fe68HS9u32RGEGMJ+Zzy1+N0jKGQymXej+Yf
        6Y/W9rbgrIHaD6bDAyrWUPqj6nQoy/U+FcuBp9AbLR1UCY5K57f1lqYjzK0AAewuVqTX/ldih+G4O
        uNfb5gG71ac0mBm79y9TEWYVlAo5GPWltKDokTYInUOYRGI4qtnQ/UytyYx1DuhhCMEDa/7H31OJH
        mkDLAXww==;
Received: from [::1] (port=57046 helo=server53.web-hosting.com)
        by server53.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <general-zed@zedlx.com>)
        id 1i8ZPY-000MSB-Cg; Thu, 12 Sep 2019 20:26:08 -0400
Received: from [95.178.242.92] ([95.178.242.92]) by server53.web-hosting.com
 (Horde Framework) with HTTPS; Thu, 12 Sep 2019 20:26:04 -0400
Date:   Thu, 12 Sep 2019 20:26:04 -0400
Message-ID: <20190912202604.Horde.2Cvnicewbvpdb39q5eBASP7@server53.web-hosting.com>
From:   General Zed <general-zed@zedlx.com>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Chris Murphy <lists@colorremedies.com>,
        "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Feature requests: online backup - defrag - change RAID level
References: <d958659e-6dc0-fa0a-7da9-2d88df4588f5@gmail.com>
 <20190911132053.Horde._wJd24LqxxXx9ujl2r5i7PQ@server53.web-hosting.com>
 <c8da6684-6c16-fc80-8e10-1afc1871d512@gmail.com>
 <20190911173725.Horde.aRGy9hKzg3scN15icIxdbco@server53.web-hosting.com>
 <81f4870e-3ee9-7780-13aa-918d24ca10d8@gmail.com>
 <20190912151841.Horde.-wdqt-14W0sbNwBxzhWVB6B@server53.web-hosting.com>
 <CAJCQCtQbRCdVOknOo6vusG+fQu1SB3=h8r=qDcZHUu+EFe480A@mail.gmail.com>
 <20190912173440.Horde.WmxNqLlw7nsFNa-Ux9TTgbz@server53.web-hosting.com>
 <CAJCQCtS8i5rTOYgEM2DFjoiZJBFsL6sgOGwp-1shMs859-r=qg@mail.gmail.com>
 <20190912185726.Horde.HMciH9Z16kV4fK10AfUeRA8@server53.web-hosting.com>
 <20190912235427.GE22121@hungrycats.org>
In-Reply-To: <20190912235427.GE22121@hungrycats.org>
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


Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:

> On Thu, Sep 12, 2019 at 06:57:26PM -0400, General Zed wrote:
>>
>> Quoting Chris Murphy <lists@colorremedies.com>:
>>
>> > On Thu, Sep 12, 2019 at 3:34 PM General Zed <general-zed@zedlx.com> wrote:
>> > >
>> > >
>> > > Quoting Chris Murphy <lists@colorremedies.com>:
>> > >
>> > > > On Thu, Sep 12, 2019 at 1:18 PM <webmaster@zedlx.com> wrote:
>> > > >>
>> > > >> It is normal and common for defrag operation to use some disk space
>> > > >> while it is running. I estimate that a reasonable limit would be to
>> > > >> use up to 1% of total partition size. So, if a partition size is 100
>> > > >> GB, the defrag can use 1 GB. Lets call this "defrag operation space".
>> > > >
>> > > > The simplest case of a file with no shared extents, the minimum free
>> > > > space should be set to the potential maximum rewrite of the file, i.e.
>> > > > 100% of the file size. Since Btrfs is COW, the entire operation must
>> > > > succeed or fail, no possibility of an ambiguous in between state, and
>> > > > this does apply to defragment.
>> > > >
>> > > > So if you're defragging a 10GiB file, you need 10GiB minimum free
>> > > > space to COW those extents to a new, mostly contiguous, set of exents,
>> > >
>> > > False.
>> > >
>> > > You can defragment just 1 GB of that file, and then just write out to
>> > > disk (in new extents) an entire new version of b-trees.
>> > > Of course, you don't really need to do all that, as usually only a
>> > > small part of the b-trees need to be updated.
>> >
>> > The `-l` option allows the user to choose a maximum amount to
>> > defragment. Setting up a default defragment behavior that has a
>> > variable outcome is not idempotent and probably not a good idea.
>>
>> We are talking about a future, imagined defrag. It has no -l option yet, as
>> we haven't discussed it yet.
>>
>> > As for kernel behavior, it presumably could defragment in portions,
>> > but it would have to completely update all affected metadata after
>> > each e.g. 1GiB section, translating into 10 separate rewrites of file
>> > metadata, all affected nodes, all the way up the tree to the super.
>> > There is no such thing as metadata overwrites in Btrfs. You're
>> > familiar with the wandering trees problem?
>>
>> No, but it doesn't matter.
>>
>> At worst, it just has to completely write-out "all metadata", all the way up
>> to the super. It needs to be done just once, because what's the point of
>> writing it 10 times over? Then, the super is updated as the final commit.
>
> This is kind of a silly discussion.  The biggest extent possible on
> btrfs is 128MB, and the incremental gains of forcing 128MB extents to
> be consecutive are negligible.  If you're defragging a 10GB file, you're
> just going to end up doing 80 separate defrag operations.

Ok, then the max extent is 128 MB, that's fine. Someone here  
previously said that it is 2 GB, so he has disinformed me (in order to  
further his false argument).

I didn't ever said that I would force extents larger than 128 MB.

If you are defragging a 10 GB file, you'll likely have to do it in 10  
steps, because the defrag is usually allowed to only use a limited  
amount of disk space while in operation. That has nothing to do with  
the extent size.

> 128MB is big enough you're going to be seeking in the middle of reading
> an extent anyway.  Once you have the file arranged in 128MB contiguous
> fragments (or even a tenth of that on medium-fast spinning drives),
> the job is done.

Ok. When did I say anything different?

>> On my comouter the ENTIRE METADATA is 1 GB. That would be very tolerable and
>> doable.
>
> You must have a small filesystem...mine range from 16 to 156GB, a bit too
> big to fit in RAM comfortably.

You mean: all metadata size is 156 GB on one of your systems. However,  
you don't typically have to put ALL metadata in RAM.
You need just some parts needed for defrag operation. So, for defrag,  
what you really need is just some large metadata cache present in RAM.  
I would say that if such a metadata cache is using 128 MB (for 2 TB  
disk) to 2 GB (for 156 GB disk), than the defrag will run sufficiently  
fast.

> Don't forget you have to write new checksum and free space tree pages.
> In the worst case, you'll need about 1GB of new metadata pages for each
> 128MB you defrag (though you get to delete 99.5% of them immediately
> after).

Yes, here we are debating some worst-case scenaraio which is actually  
imposible in practice due to various reasons.

So, doesn't matter.


