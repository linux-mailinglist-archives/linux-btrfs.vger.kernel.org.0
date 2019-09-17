Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EED0B4B86
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2019 12:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfIQKHb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Sep 2019 06:07:31 -0400
Received: from server53-3.web-hosting.com ([198.54.126.113]:34385 "EHLO
        server53-3.web-hosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726181AbfIQKHb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Sep 2019 06:07:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=zedlx.com;
         s=default; h=MIME-Version:Content-Type:In-Reply-To:References:Subject:Cc:To:
        From:Message-ID:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=aHJIa9TtDYFxI6l20eeESM9x8Z4Ocrs6g4WW/WA9XlM=; b=6MJ8ejxx4W0fkUFrweKo+0ZZ4T
        Lyv+CXGOPHy+1ePLYo1x3gmrq88mKwNrxKzB2a0uFHlcHItIIzjCCn2N7kTexzUpdZ15uBt9phdEI
        Gv0ddX2cN8WjFaRhqRK69QGTU+TL6NREJZKNE7GRgAE7gcEjsnEQJ0LkUxOcJ0M0lRfYItEJtqlET
        Tu/v0bIRpgpOXz5BqPQxw2s8EoWYF+4DUKYoCoccOSBtYR+vy7Xbs8FSyfWOYvjmK2ak7zzDW9UGm
        /fmYhybOr2bQq2e++FIS8a1055xqZE28f6RQLOgHvp/ihAr/6FotuZRz6rAeU1XxLcHqL5KsRTzae
        ZdB4vFHw==;
Received: from [::1] (port=46284 helo=server53.web-hosting.com)
        by server53.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <general-zed@zedlx.com>)
        id 1iAAOK-004OTI-P3; Tue, 17 Sep 2019 06:07:29 -0400
Received: from [95.178.242.132] ([95.178.242.132]) by
 server53.web-hosting.com (Horde Framework) with HTTPS; Tue, 17 Sep 2019
 06:07:24 -0400
Date:   Tue, 17 Sep 2019 06:07:24 -0400
Message-ID: <20190917060724.Horde.2JvifSdoEgszEJI8_4CFSH8@server53.web-hosting.com>
From:   General Zed <general-zed@zedlx.com>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Feature requests: online backup - defrag - change RAID level
References: <d958659e-6dc0-fa0a-7da9-2d88df4588f5@gmail.com>
 <20190911132053.Horde._wJd24LqxxXx9ujl2r5i7PQ@server53.web-hosting.com>
 <20190911213704.GB22121@hungrycats.org>
 <20190911192131.Horde.2lTVSt-Ln94dqLGQKg_USXQ@server53.web-hosting.com>
 <20190912051904.GD22121@hungrycats.org>
 <20190912172321.Horde.oyDNseL4IVWz-QYWBqgXqjO@server53.web-hosting.com>
 <20190914041255.GJ22121@hungrycats.org>
 <20190916074251.Horde.bsBwDU_QYlFY0p-a1JzxZrm@server53.web-hosting.com>
 <20190917004916.GD24379@hungrycats.org>
 <20190916223039.Horde.HZvhrBkQsN12DF6IDemvio6@server53.web-hosting.com>
 <20190917053055.GG24379@hungrycats.org>
In-Reply-To: <20190917053055.GG24379@hungrycats.org>
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

> On Mon, Sep 16, 2019 at 10:30:39PM -0400, General Zed wrote:
>> Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:
>> > and I think that's impossible so I start from designs
>> > that make forward progress with a fixed allocation of resources.
>>
>> Well, that's not useless, but it's kind of meh. Waste of time. Solve the
>> problem like a real man! Shoot with thermonuclear weapons only!
>
> I have thermonuclear weapons:  the metadata trees in my filesystems.  ;)
>
>> > > So I think you should all inform yourself a little better about various
>> > > defrag algorithms and solutions that exist. Apparently, you all lost the
>> > > sight of the big picture. You can't see the wood from the trees.
>> >
>> > I can see the woods, but any solution that starts with "enumerate all
>> > the trees" will be met with extreme skepticism, unless it can do that
>> > enumeration incrementally.
>>
>> I think that I'm close to a solution that only needs to scan the free-space
>> tree in the entirety at start. All other trees can be only partially
>> scanned. I mean, at start. As the defrag progresses, it will go through all
>> the trees (except in case of defragging only a part of the partition). If a
>> partition is to be only partially defragged, then the trees do not need to
>> be red in entirety. Only the free space tree needs to be red in entirety at
>> start (and the virtual-physical address translation trees, which are small,
>> I guess).
>
> I doubt that on a 50TB filesystem you need to read the whole tree...are
> you going to globally optimize 50TB at once?  That will take a while.

I need to read the whole free-space tree to find a few regions with  
most free space. Those will be used as destinations for defragmented  
data.

If a mostly free region of sufficient size (a few GB) can be found  
faster, then there is no need to read the entire free-space tree. But,  
on a disk with less than 15% free space, it would be advisable to read  
the entire free space tree to find the less-crowded regions of the  
filesystem.

> Start with a 100GB sliding window, maybe.

There will be something similar to a sliding window (in virtual  
address space). The likely size of the window for "typical" desktops  
is just around 1 GB, no more. In complicated filesystems, it will be  
smaller. Really, you don't need a very big sliding window (little can  
be gained by enlarging it), for a 256 GB drive a small sliding window  
is quite fine. The size of the sliding window can be dynamically  
adjusted, depending on several factors, but mostly: available RAM and  
filesystem complexity (number of extents and reflinks in the sliding  
window).

So, the defrag will be tunable by supplying the amount of RAM to use.  
If you supply it with insufficient RAM, it will slow down  
considerably. 400 MB minimum RAM usage recommended for typical  
desktops. But, this should be tested on an actual implementation, I'm  
just guessing at this point. Could be better or worse.

This sliding window won't be a perfect one (it can have  
discontinuities, fragments), and also a small amount of data which is  
not in the sliding window but in logically adjacent areas will also be  
scanned.

So, I'm designing a defrag that is fast, can use little RAM, and can  
work in low free-space conditions. Can work on huge filesystems and  
can take on a good amount of pathological cases. Preserves all file  
data sharing.

I hope that at least someone will be satisfied.

>> > This is fairly common on btrfs:  the btrfs words don't mean the same as
>> > other words, causing confusion.  How many copies are there in a btrfs
>> > 4-disk raid1 array?
>>
>> 2 copies of everything, except the superblock which has 2-6 copies.
>
> Good, you can enter the clubhouse.  A lot of new btrfs users are surprised
> it's less than 4.
>
>> > > > > This is sovled simply by always running defrag before dedupe.
>> > > > Defrag and dedupe in separate passes is nonsense on btrfs.
>> > > Defrag can be run without dedupe.
>> > Yes, but if you're planning to run both on the same filesystem, they
>> > had better be aware of each other.
>>
>> On-demand defrag doesn't need to be aware of on-demand dedupe. Or, only in
>> the sense that dedupe should be shut down while defrag is running.
>>
>> Perhaps you were referring to an on-the-fly dedupe. In that case, yes.
>
> My dedupe runs continuously (well, polling with incremental scan).
> It doesn't shut down.

Ah... so I suggest that the defrag should temporarily shut down  
dedupe, at least in the initial versions of defrag. Once both defrag  
and dedupe are working standalone, the merging effort can begin.

>> > > Now, how to organize dedupe? I didn't think about it yet. I'll  
>> leave it to
>> > > you, but it seems to me that defrag should be involved there.  
>> And, my defrag
>> > > solution would help there very, very much.
>> >
>> > I can't see defrag in isolation as anything but counterproductive to
>> > dedupe (and vice versa).
>>
>> Share-preserving defrag can't be harmful to dedupe.
>
> Sure it can.  Dedupe needs to split extents by content, and btrfs only
> supports that by copying.  If defrag is making new extents bigger before
> dedupe gets to them, there is more work for dedupe when it needs to make
> extents smaller again.
>
>> I would suggest one of the two following simple solutions:
>>    a) the on-demand defrag should be run BEFORE AND AFTER the on-demand
>> dedupe.
>> or b) the on-demand defrag should be run BEFORE the on-demand dedupe, and
>> on-demand dedupe uses defrag functionality to defrag while dedupe is in
>> progress.
>>
>> So I guess you were thinking about the solution b) all the time when you
>> said that dedupe and defrag need to be related.
>
> Well, both would be running continuously in the same process, so
> they would negotiate with each other as required.  Dedupe runs first
> on new extents to create a plan for increasing extent sharing, then
> defrag creates a plan for sufficient logical/physical contiguity of
> those extents after dedupe has cut them into content-aligned pieces.
> Extents that are entirely duplicate simply disappear and do not form
> part of the defrag workload (at least until it is time to defragment
> free space...).  Both plans are combined and optimized, then the final
> data relocation command sequence is sent to the filesystem.

I think that this kind of close dedupe-defrag integration should  
mostly be left to dedupe developers. First, both defrag and dedupe  
should work perfectly on their own. Then, an interface to defrag  
should be made available to dedupe developers. In particular, I think  
that the batch-update functionality (it takes lots of extents and an  
empty free space region, then writes defragmented extents to the given  
region) is of particular interest to dedupe.

>> > > > Extent splitting in-place is not possible on btrfs, so extent boundary
>> > > > changes necessarily involve data copies.  Reference counting is done
>> > > > by extent in btrfs, so it is only possible to free complete extents.
>> > >
>> > > Great, there is reference counting in btrfs. That helps. Good design.
>> >
>> > Well, I say "reference counting" because I'm simplifying for an audience
>> > that does not yet all know the low-level details.  The counter, such as
>> > it is, gives values "zero" or "more than zero."  You never know exactly
>> > how many references there are without doing the work to enumerate them.
>> > The "is extent unique" function in btrfs runs the enumeration loop until
>> > the second reference is found or the supply of references is exhausted,
>> > whichever comes first.  It's a tradeoff to make snapshots fast.
>>
>> Well, that's a disappointment.
>>
>> > When a reference is created to a new extent, it refers to the entire
>> > extent.  References can refer to parts of extents (the reference has an
>> > offset and length field), so when an extent is partially overwritten, the
>> > extent is not modified.  Only the reference is modified, to make it refer
>> > to a subset of the extent (references in other snapshots are not changed,
>> > and the extent data itself is immutable).  This makes POSIX fast, but it
>> > creates some headaches related to garbage collection, dedupe, defrag, etc.
>>
>> Ok, got it. Thaks.
>>
>>
>>
>>



