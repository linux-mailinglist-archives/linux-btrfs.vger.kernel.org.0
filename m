Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80B9AB4582
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2019 04:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390612AbfIQCaq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Sep 2019 22:30:46 -0400
Received: from server53-3.web-hosting.com ([198.54.126.113]:46942 "EHLO
        server53-3.web-hosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728639AbfIQCaq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Sep 2019 22:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=zedlx.com;
         s=default; h=MIME-Version:Content-Type:In-Reply-To:References:Subject:Cc:To:
        From:Message-ID:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=IPSG0Cs9YbFI78Mf3p4fUE2ze18XYbL4rjyf3N6az6Y=; b=VqI3+fYdJJztnCCJdBeAeHkYv1
        EW2jrIZktzd92kpJx2nGHi8sLWphzgVCJXwjn62khdxdHlNgu0VQ8iPxGw7Ifxy5Nw7N50Gv93J7k
        GuJZwPBX0mLJKdmqHLKVj5nG+XIfvXu3hXMhpYrb41IpoqdK1RpFuALvVl7evhmGhv1CVaVRs+P8L
        LYQZflPviE8La8TPKidW2XQuTyrwdWaqSUAMd0D5jI6DgYGpi35MzCwxu/kmKXqOKcznfc6R1wfOA
        1XlMKt4Z3V/82qtodt4wCwPHQFnfxh6AOW3JLG6nEdAFnx85T3cjLxnK3kbyMhANVhgd08hGzWEAB
        2ona6Amg==;
Received: from [::1] (port=50090 helo=server53.web-hosting.com)
        by server53.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <general-zed@zedlx.com>)
        id 1iA3GJ-0009LL-Bj; Mon, 16 Sep 2019 22:30:43 -0400
Received: from [95.178.242.132] ([95.178.242.132]) by
 server53.web-hosting.com (Horde Framework) with HTTPS; Mon, 16 Sep 2019
 22:30:39 -0400
Date:   Mon, 16 Sep 2019 22:30:39 -0400
Message-ID: <20190916223039.Horde.HZvhrBkQsN12DF6IDemvio6@server53.web-hosting.com>
From:   General Zed <general-zed@zedlx.com>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Feature requests: online backup - defrag - change RAID level
References: <fc81fcf2-f8e9-1a08-52f8-136503e40494@gmail.com>
 <20190910193221.Horde.HYrKYqNVgQ10jshWWA1Gxxu@server53.web-hosting.com>
 <d958659e-6dc0-fa0a-7da9-2d88df4588f5@gmail.com>
 <20190911132053.Horde._wJd24LqxxXx9ujl2r5i7PQ@server53.web-hosting.com>
 <20190911213704.GB22121@hungrycats.org>
 <20190911192131.Horde.2lTVSt-Ln94dqLGQKg_USXQ@server53.web-hosting.com>
 <20190912051904.GD22121@hungrycats.org>
 <20190912172321.Horde.oyDNseL4IVWz-QYWBqgXqjO@server53.web-hosting.com>
 <20190914041255.GJ22121@hungrycats.org>
 <20190916074251.Horde.bsBwDU_QYlFY0p-a1JzxZrm@server53.web-hosting.com>
 <20190917004916.GD24379@hungrycats.org>
In-Reply-To: <20190917004916.GD24379@hungrycats.org>
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

> On Mon, Sep 16, 2019 at 07:42:51AM -0400, General Zed wrote:
>>
>> Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:
>> > Your defrag ideas are interesting, but you should spend a lot more
>> > time learning the btrfs fundamentals before continuing.  Right now
>> > you do not understand what btrfs is capable of doing easily, and what
>> > requires such significant rework in btrfs to implement that the result
>> > cannot be considered the same filesystem.  This is impairing the quality
>> > of your design proposals and reducing the value of your contribution
>> > significantly.
>>
>> Ok, that was a shot at me; and I admit, guilty as charged. I barely have a
>> clue about btrfs.
>> Now it's my turn to shoot. Apparently, the people which are implementing the
>> btrfs defrag, or at least the ones that responded to my post, seem to have
>> no clue about how on-demand defrag solutions typically work. I had to
>> explain the usual tricks involved in the defragmentation, and it was like
>> talking to complete rookies. None of you even considered a full-featured
>> defrag solution, all that you are doing are some partial solutions.
>
> Take a look at btrfs RAID5/6 some time, if you want to see rookie mistakes...
>
>> And, you all got lost in implementation details. How many times have I been
>> told here that some operation cannot be performed, and then it turned out
>> the opposite. You have all sunk into some strange state of mind where every
>> possible excuse is being made in order not to start working on a better,
>> hollistic defrag solution.
>>
>> And you even misunderstood me when I said "hollistic defrag", you thought I
>> was talking about a full defrag. No. A full defrag is a defrag performed on
>> all the data. A holistic defrag can be performed on only some data, but it
>> is hollistic in the sense that it uses whole information about a filesystem,
>> not just a partial view of it. A holistic defrag is better than a partial
>> defrag: it is faster and produces better results, and it can defrag a wider
>> spectrum of cases. Why? Because a holistic defrag takes everything into
>> account.
>
> What I'm looking for is a quantitative approach.  Sort the filesystem
> regions by how bad they are (in terms of measurable negative outcomes
> like poor read performance, pathological metadata updates, and future
> allocation performance), then apply mitigation in increasing order of
> cost-benefit ratio (or at least filter by cost-benefit ratio if you can't
> sort without reading the whole filesystem) until a minimum threshold
> is reached, then stop.  This lets the mitigation scale according to
> the available maintenance window, i.e. if you have 5% of a day for
> maintenance, you attack the worst 5% of the filesystem, then stop.

Any good defrag solution should be able to prioritize to work on most  
fragmented parts of the filesystem. That's a given.

> In that respect I think we might be coming toward the same point, but
> from different directions:  you seem to think the problem is easy to
> solve at scale,

Yes!

> and I think that's impossible so I start from designs
> that make forward progress with a fixed allocation of resources.

Well, that's not useless, but it's kind of meh. Waste of time. Solve  
the problem like a real man! Shoot with thermonuclear weapons only!

>> So I think you should all inform yourself a little better about various
>> defrag algorithms and solutions that exist. Apparently, you all lost the
>> sight of the big picture. You can't see the wood from the trees.
>
> I can see the woods, but any solution that starts with "enumerate all
> the trees" will be met with extreme skepticism, unless it can do that
> enumeration incrementally.

I think that I'm close to a solution that only needs to scan the  
free-space tree in the entirety at start. All other trees can be only  
partially scanned. I mean, at start. As the defrag progresses, it will  
go through all the trees (except in case of defragging only a part of  
the partition). If a partition is to be only partially defragged, then  
the trees do not need to be red in entirety. Only the free space tree  
needs to be red in entirety at start (and the virtual-physical address  
translation trees, which are small, I guess).

>> Well, no. Perhaps the word "defrag" can have a wider and narrower sense. So
>> in a narrower sense, "defrag" means what you just wrote. In that sense, the
>> word "defrag" means practically the same as "merge", so why not just use the
>> word "merge" to remove any ambiguities. The "merge" is the only operation
>> that decreases the number of fragments (besides "delete"). Perhaps you meant
>> move&merge. But, commonly, the word "defrag" is used in a wider sense, which
>> is not the one you described.
>
> This is fairly common on btrfs:  the btrfs words don't mean the same as
> other words, causing confusion.  How many copies are there in a btrfs
> 4-disk raid1 array?

2 copies of everything, except the superblock which has 2-6 copies.
>
>> > > > Dedupe on btrfs also requires the ability to split and merge extents;
>> > > > otherwise, we can't dedupe an extent that contains a combination of
>> > > > unique and duplicate data.  If we try to just move references around
>> > > > without splitting extents into all-duplicate and all-unique extents,
>> > > > the duplicate blocks become unreachable, but are not  
>> deallocated.  If we
>> > > > only split extents, fragmentation overhead gets bad.  Before creating
>> > > > thousands of references to an extent, it is worthwhile to  
>> merge it with
>> > > > as many of its neighbors as possible, ideally by picking the biggest
>> > > > existing garbage-free extents available so we don't have to do defrag.
>> > > > As we examine each extent in the filesystem, it may be best to send
>> > > > to defrag, dedupe, or garbage collection--sometimes more than one of
>> > > > those.
>> > >
>> > > This is sovled simply by always running defrag before dedupe.
>> >
>> > Defrag and dedupe in separate passes is nonsense on btrfs.
>>
>> Defrag can be run without dedupe.
>
> Yes, but if you're planning to run both on the same filesystem, they
> had better be aware of each other.

On-demand defrag doesn't need to be aware of on-demand dedupe. Or,  
only in the sense that dedupe should be shut down while defrag is  
running.

Perhaps you were referring to an on-the-fly dedupe. In that case, yes.

>> Now, how to organize dedupe? I didn't think about it yet. I'll leave it to
>> you, but it seems to me that defrag should be involved there. And, my defrag
>> solution would help there very, very much.
>
> I can't see defrag in isolation as anything but counterproductive to
> dedupe (and vice versa).

Share-preserving defrag can't be harmful to dedupe.

> A critical feature of the dedupe is to do extent splits along duplicate
> content boundaries, so that you're not limited to deduping only
> whole-extent matches.  This is especially necessary on btrfs because
> you can't split an extent in place--if you find a partial match,
> you have to find a new home for the unique data, which means you
> get a lot of little fragments that are inevitably distant from their
> logically adjacent neighbors which themselves were recently replaced
> with a physically distant identical extent.
>
> Sometimes both copies of the data suck (both have many fragments
> or uncollected garbage), and at that point you want to do some
> preprocessing--copy the data to make the extent you want, then use
> dedupe to replace both bad extents with your new good one.  That's an
> opportunistic extent merge and it needs some defrag logic to do proper
> cost estimation.
>
> If you have to copy 64MB of unique data to dedupe a 512K match, the extent
> split cost is far higher than if you have a 2MB extent with 512K match.
> So there should be sysadmin-tunable parameters that specify how much
> to spend on diminishing returns:  maybe you don't deduplicate anything
> that saves less than 1% of the required copy bytes, because you have
> lots of duplicates in the filesystem and you are willing to spend 1% of
> your disk space to not be running dedupe all day.  Similarly you don't
> defragment (or move for any reason) extents unless that move gives you
> significantly better read performance or consolidate diffuse allocations
> across metadata pages, because there are millions of extents to choose
> from and it's not necessary to optimize them all.
>
> On the other hand, if you find you _must_ move the 64MB of data for
> other reasons (e.g. to consolidate free space) then you do want to do
> the dedupe because it will make the extent move slightly faster (63.5MB
> of data + reflink instead of 64MB copy).  So you definitely want one
> program looking at both things.
>
> Maybe there's a way to plug opportunistic dedupe into a defrag algorithm
> the same way there's a way to plug opportunistic defrag into a dedupe
> algorithm.  I don't know, I'm coming at this from the dedupe side.
> If the solution looks anything like "run both separately" then I'm
> not interested.

I would suggest one of the two following simple solutions:
    a) the on-demand defrag should be run BEFORE AND AFTER the  
on-demand dedupe.
or b) the on-demand defrag should be run BEFORE the on-demand dedupe,  
and on-demand dedupe uses defrag functionality to defrag while dedupe  
is in progress.

So I guess you were thinking about the solution b) all the time when  
you said that dedupe and defrag need to be related.

>> > Extent splitting in-place is not possible on btrfs, so extent boundary
>> > changes necessarily involve data copies.  Reference counting is done
>> > by extent in btrfs, so it is only possible to free complete extents.
>>
>> Great, there is reference counting in btrfs. That helps. Good design.
>
> Well, I say "reference counting" because I'm simplifying for an audience
> that does not yet all know the low-level details.  The counter, such as
> it is, gives values "zero" or "more than zero."  You never know exactly
> how many references there are without doing the work to enumerate them.
> The "is extent unique" function in btrfs runs the enumeration loop until
> the second reference is found or the supply of references is exhausted,
> whichever comes first.  It's a tradeoff to make snapshots fast.

Well, that's a disappointment.

> When a reference is created to a new extent, it refers to the entire
> extent.  References can refer to parts of extents (the reference has an
> offset and length field), so when an extent is partially overwritten, the
> extent is not modified.  Only the reference is modified, to make it refer
> to a subset of the extent (references in other snapshots are not changed,
> and the extent data itself is immutable).  This makes POSIX fast, but it
> creates some headaches related to garbage collection, dedupe, defrag, etc.

Ok, got it. Thaks.



