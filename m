Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55ED8B1931
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2019 09:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbfIMHvr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Sep 2019 03:51:47 -0400
Received: from server53-3.web-hosting.com ([198.54.126.113]:39830 "EHLO
        server53-3.web-hosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726822AbfIMHvq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Sep 2019 03:51:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=zedlx.com;
         s=default; h=MIME-Version:Content-Type:In-Reply-To:References:Subject:Cc:To:
        From:Message-ID:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=OxRwm8RXhFubALPdyyPixNZhF0Z3tgVD6VXc9L9BXu8=; b=uS2GI20bx5F93GyNWyETeXsIFn
        3SwYOuZ91hOLqKXCmQ2iBG2XLdEvasAZIijBPHjEL6gPIjQBu1s/JTVAPU3yVvlUMWlLELiUU6CAQ
        u0q9+0a7mPdLWFf3gMODIHmXvRwd8+7Lt3snM+VkoO5l97A1pCZhHIquQioqqbw7LU6yuf1icQQ9s
        QE/ORDzbAOWOscVR7PKV0YECnIZ3jz7HuS5hPg+/U4gZm0mFzpkhMaJECWrELtDeauf+i060+iczW
        niQCG0zGKcH8YMF3p4Ms7f50BTrZyo5Iasz4joAPl51qPjuf/4djP8QqRTlQeheuUyClpF58FvKye
        5d7UTsIw==;
Received: from [::1] (port=57818 helo=server53.web-hosting.com)
        by server53.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <general-zed@zedlx.com>)
        id 1i8gMm-0043ZY-El; Fri, 13 Sep 2019 03:51:44 -0400
Received: from [95.178.242.92] ([95.178.242.92]) by server53.web-hosting.com
 (Horde Framework) with HTTPS; Fri, 13 Sep 2019 03:51:40 -0400
Date:   Fri, 13 Sep 2019 03:51:40 -0400
Message-ID: <20190913035140.Horde.k8lI3sTYGIOTQdvJaEBUlpG@server53.web-hosting.com>
From:   General Zed <general-zed@zedlx.com>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Chris Murphy <lists@colorremedies.com>,
        "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: Feature requests: online backup - defrag - change RAID level
References: <c8da6684-6c16-fc80-8e10-1afc1871d512@gmail.com>
 <20190911173725.Horde.aRGy9hKzg3scN15icIxdbco@server53.web-hosting.com>
 <81f4870e-3ee9-7780-13aa-918d24ca10d8@gmail.com>
 <20190912151841.Horde.-wdqt-14W0sbNwBxzhWVB6B@server53.web-hosting.com>
 <CAJCQCtQbRCdVOknOo6vusG+fQu1SB3=h8r=qDcZHUu+EFe480A@mail.gmail.com>
 <20190912173440.Horde.WmxNqLlw7nsFNa-Ux9TTgbz@server53.web-hosting.com>
 <CAJCQCtS8i5rTOYgEM2DFjoiZJBFsL6sgOGwp-1shMs859-r=qg@mail.gmail.com>
 <20190912185726.Horde.HMciH9Z16kV4fK10AfUeRA8@server53.web-hosting.com>
 <20190912235427.GE22121@hungrycats.org>
 <20190912202604.Horde.2Cvnicewbvpdb39q5eBASP7@server53.web-hosting.com>
 <20190913031242.GF22121@hungrycats.org>
In-Reply-To: <20190913031242.GF22121@hungrycats.org>
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

> On Thu, Sep 12, 2019 at 08:26:04PM -0400, General Zed wrote:
>>
>> Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:
>>
>> > On Thu, Sep 12, 2019 at 06:57:26PM -0400, General Zed wrote:
>> > >
>> > > Quoting Chris Murphy <lists@colorremedies.com>:
>> > >
>> > > > On Thu, Sep 12, 2019 at 3:34 PM General Zed  
>> <general-zed@zedlx.com> wrote:
>> > > > >
>> > > > >
>> > > > > Quoting Chris Murphy <lists@colorremedies.com>:
>> > > > >
>> > > > > > On Thu, Sep 12, 2019 at 1:18 PM <webmaster@zedlx.com> wrote:
>> > > > > >>
>> > > > > >> It is normal and common for defrag operation to use some  
>> disk space
>> > > > > >> while it is running. I estimate that a reasonable limit  
>> would be to
>> > > > > >> use up to 1% of total partition size. So, if a partition  
>> size is 100
>> > > > > >> GB, the defrag can use 1 GB. Lets call this "defrag  
>> operation space".
>> > > > > >
>> > > > > > The simplest case of a file with no shared extents, the  
>> minimum free
>> > > > > > space should be set to the potential maximum rewrite of  
>> the file, i.e.
>> > > > > > 100% of the file size. Since Btrfs is COW, the entire  
>> operation must
>> > > > > > succeed or fail, no possibility of an ambiguous in  
>> between state, and
>> > > > > > this does apply to defragment.
>> > > > > >
>> > > > > > So if you're defragging a 10GiB file, you need 10GiB minimum free
>> > > > > > space to COW those extents to a new, mostly contiguous,  
>> set of exents,
>> > > > >
>> > > > > False.
>> > > > >
>> > > > > You can defragment just 1 GB of that file, and then just  
>> write out to
>> > > > > disk (in new extents) an entire new version of b-trees.
>> > > > > Of course, you don't really need to do all that, as usually only a
>> > > > > small part of the b-trees need to be updated.
>> > > >
>> > > > The `-l` option allows the user to choose a maximum amount to
>> > > > defragment. Setting up a default defragment behavior that has a
>> > > > variable outcome is not idempotent and probably not a good idea.
>> > >
>> > > We are talking about a future, imagined defrag. It has no -l  
>> option yet, as
>> > > we haven't discussed it yet.
>> > >
>> > > > As for kernel behavior, it presumably could defragment in portions,
>> > > > but it would have to completely update all affected metadata after
>> > > > each e.g. 1GiB section, translating into 10 separate rewrites of file
>> > > > metadata, all affected nodes, all the way up the tree to the super.
>> > > > There is no such thing as metadata overwrites in Btrfs. You're
>> > > > familiar with the wandering trees problem?
>> > >
>> > > No, but it doesn't matter.
>> > >
>> > > At worst, it just has to completely write-out "all metadata",  
>> all the way up
>> > > to the super. It needs to be done just once, because what's the point of
>> > > writing it 10 times over? Then, the super is updated as the  
>> final commit.
>> >
>> > This is kind of a silly discussion.  The biggest extent possible on
>> > btrfs is 128MB, and the incremental gains of forcing 128MB extents to
>> > be consecutive are negligible.  If you're defragging a 10GB file, you're
>> > just going to end up doing 80 separate defrag operations.
>>
>> Ok, then the max extent is 128 MB, that's fine. Someone here previously said
>> that it is 2 GB, so he has disinformed me (in order to further his false
>> argument).
>
> If the 128MB limit is removed, you then hit the block group size limit,
> which is some number of GB from 1 to 10 depending on number of disks
> available and raid profile selection (the striping raid profiles cap
> block group sizes at 10 disks, and single/raid1 profiles always use 1GB
> block groups regardless of disk count).  So 2GB is _also_ a valid extent
> size limit, just not the first limit that is relevant for defrag.
>
> A lot of people get confused by 'filefrag -v' output, which coalesces
> physically adjacent but distinct extents.  So if you use that tool,
> it can _seem_ like there is a 2.5GB extent in a file, but it is really
> 20 distinct 128MB extents that start and end at adjacent addresses.
> You can see the true structure in 'btrfs ins dump-tree' output.
>
> That also brings up another reason why 10GB defrags are absurd on btrfs:
> extent addresses are virtual.  There's no guarantee that a pair of extents
> that meet at a block group boundary are physically adjacent, and after
> operations like RAID array reorganization or free space defragmentation,
> they are typically quite far apart physically.
>
>> I didn't ever said that I would force extents larger than 128 MB.
>>
>> If you are defragging a 10 GB file, you'll likely have to do it in 10 steps,
>> because the defrag is usually allowed to only use a limited amount of disk
>> space while in operation. That has nothing to do with the extent size.
>
> Defrag is literally manipulating the extent size.  Fragments and extents
> are the same thing in btrfs.
>
> Currently a 10GB defragment will work in 80 steps, but doesn't necessarily
> commit metadata updates after each step, so more than 128MB of temporary
> space may be used (especially if your disks are fast and empty,
> and you start just after the end of the previous commit interval).
> There are some opportunities to coalsce metadata updates, occupying up
> to a (arbitrary) limit of 512MB of RAM (or when memory pressure forces
> a flush, whichever comes first), but exploiting those opportunities
> requires more space for uncommitted data.
>
> If the filesystem starts to get low on space during a defrag, it can
> inject commits to force metadata updates to happen more often, which
> reduces the amount of temporary space needed (we can't delete the original
> fragmented extents until their replacement extent is committed); however,
> if the filesystem is so low on space that you're worried about running
> out during a defrag, then you probably don't have big enough contiguous
> free areas to relocate data into anyway, i.e. the defrag is just going to
> push data from one fragmented location to a different fragmented location,
> or bail out with "sorry, can't defrag that."

If the filesystem starts to get low on space during a defrag, it  
should abort and notify the user. The only question is: how low amount  
of free space can be tolerated?

Forcing commits too often (and having a smaller operation area / move  
in area) increases the number of metadata updates.

Technically, you don't really need to have a big enough contiguous  
free areas, those areas can be quite 'dirty', and the defrag will  
still work, albeit at a slower pace.

The question you are posing here is a question of minimal free space  
required in order to not slow down the defrag significantly.  
Unfortunately, there is no simple answer about how to calculate that  
minimal free space. There should be some experimentation, some  
experience.

Certainly, a good idea would be to give the user some options.

For example, if the defrag estimates that it is twice as slow as it  
could be due to low free space, than it should proceed only if the  
user has supplied the option --lowFreeSpace. If the defrag estimates  
that it is six times as slow as it could be due to low free space,  
than it should proceed only if the user has supplied the option  
--veryLowFreeSpace.



