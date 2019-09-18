Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7DFB5A7B
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2019 06:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbfIREht (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Sep 2019 00:37:49 -0400
Received: from server53-3.web-hosting.com ([198.54.126.113]:33985 "EHLO
        server53-3.web-hosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725842AbfIREht (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Sep 2019 00:37:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=zedlx.com;
         s=default; h=MIME-Version:Content-Type:In-Reply-To:References:Subject:Cc:To:
        From:Message-ID:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=G5F5l0AGob83wEwe+VFVluATbEbm1p3I0cNh+FDcKKE=; b=htFlwjsmNo6HdSlR40zWQXr32P
        djaMXAh9ejGWvNtC3500rBZQf1axjFpHGsF8hTSlN2RWLuZCnJBn732aeduUlNpn1voS7N7UxfWzb
        LRH4mgty9PBrnKWugq+f6IVbBE7nbVK1wSMJilJ/wicL9STYujYyb/KgG9qkafgnvqP5pEh2tZj5f
        CFXdPcQNcLBK9bN42hVsF1D57GhWZO0xAOOQi8pqzryCMe/YHoIvkWS+vlVhYBvA8ocS6Vgxz4Ksb
        VG9BL2lbTJSDO6rI2EjcQ8piZ1OG75SxALHPAL87X6LafB9cIWa7iqWJXxKNecljnr629GgKTIweD
        ObAy712g==;
Received: from [::1] (port=58946 helo=server53.web-hosting.com)
        by server53.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <general-zed@zedlx.com>)
        id 1iARio-0006P0-Ny; Wed, 18 Sep 2019 00:37:47 -0400
Received: from [95.178.242.132] ([95.178.242.132]) by
 server53.web-hosting.com (Horde Framework) with HTTPS; Wed, 18 Sep 2019
 00:37:42 -0400
Date:   Wed, 18 Sep 2019 00:37:42 -0400
Message-ID: <20190918003742.Horde.uCadf9qXuYdCVqBfASzDeuN@server53.web-hosting.com>
From:   General Zed <general-zed@zedlx.com>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Feature requests: online backup - defrag - change RAID level
References: <20190911213704.GB22121@hungrycats.org>
 <20190911192131.Horde.2lTVSt-Ln94dqLGQKg_USXQ@server53.web-hosting.com>
 <20190912051904.GD22121@hungrycats.org>
 <20190912172321.Horde.oyDNseL4IVWz-QYWBqgXqjO@server53.web-hosting.com>
 <20190914041255.GJ22121@hungrycats.org>
 <20190916074251.Horde.bsBwDU_QYlFY0p-a1JzxZrm@server53.web-hosting.com>
 <20190917004916.GD24379@hungrycats.org>
 <20190916223039.Horde.HZvhrBkQsN12DF6IDemvio6@server53.web-hosting.com>
 <20190917053055.GG24379@hungrycats.org>
 <20190917060724.Horde.2JvifSdoEgszEJI8_4CFSH8@server53.web-hosting.com>
 <20190917234044.GH24379@hungrycats.org>
In-Reply-To: <20190917234044.GH24379@hungrycats.org>
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

> On Tue, Sep 17, 2019 at 06:07:24AM -0400, General Zed wrote:
>>
>> Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:
>> > I doubt that on a 50TB filesystem you need to read the whole tree...are
>> > you going to globally optimize 50TB at once?  That will take a while.
>>
>> I need to read the whole free-space tree to find a few regions with most
>> free space. Those will be used as destinations for defragmented data.
>
> Hmmm...I have some filesystems with 2-4 million FST entries, but
> they can be read in 30 seconds or less, even on the busy machines.
>
>> If a mostly free region of sufficient size (a few GB) can be found faster,
>> then there is no need to read the entire free-space tree. But, on a disk
>> with less than 15% free space, it would be advisable to read the entire free
>> space tree to find the less-crowded regions of the filesystem.
>
> A filesystem with 15% free space still has 6 TB of contiguous.
> Not hard to find some room!  You can just look in the chunk tree, all
> the unallocated space there is multi-GB contiguous chunks.

If there is a free chunk, defrag can take it. If there isn't, then it can't.

> Every btrfs
> is guaranteed to have a chunk tree, but some don't have free space trees
> (though the ones that don't should probably be strongly encouraged to
> enable that feature).  So you probably don't even need to look for free
> space if there is unallocated space.

Yes, but only in that specific case. The free space tree scan can be  
skipped in that lucky situation.

We are talking about pre-defrag situation. It has to be assumed that  
the free space is badly fragmented.

> On the other hand, you do need to measure fragmentation of the existing
> free space, in order to identify the highest-priority areas for defrag.
> So maybe you read the whole FST anyway, sort, and spit out a short list.
> It's not nearly as expensive as I thought.

The primary purpose of the free-space tree scan is in the low-free  
space situation (<10% free space) to find an above-average empty area.

> I did notice one thing while looking at filesystem metadata vs commit
> latency the other day:  btrfs's allocation performance seems to be
> correlated to the amount of free space _in the block groups_, not _on the
> filesystem_.  So after deleting 2% of the files on a 50% full filesystem,
> it runs as slowly a 98% full one.  Then when you add 3% more data to fill
> the free space and allocate some new block groups, it goes fast again.
> Then you delete things and it gets slow again.  Rinse and repeat.

Obviously, more work has to be done to improve that allocator.

>> > My dedupe runs continuously (well, polling with incremental scan).
>> > It doesn't shut down.
>>
>> Ah... so I suggest that the defrag should temporarily shut down dedupe, at
>> least in the initial versions of defrag. Once both defrag and dedupe are
>> working standalone, the merging effort can begin.
>
> Pausing dedupe just postpones the inevitable.  The first thing dedupe
> will do when it resumes is a new-data scan that will find all the new
> defrag extents, because dedupe has to discover what's in them and update
> the now out-of-date physical location data in the hash table.

It just postpones the inevitable, but you missed the point. The point  
of shutting down dedupe is to avoid nasty bugs caused by dedupe-defrag  
interaction.

> When defrag
> and dedupe are integrated, the hash table gets updated by defrag in
> place--same table entries in a different location.
>
> I have that problem _right now_ when using balance to defragment free
> space in block groups.  Dedupe performance drops while the old relocated
> data is rescanned--since it's old, we already found all the duplicates,
> so the iops of the rescan are just repairing the damage to the hash
> table that balance did.
>
> That said...I also have a plan to make dedupe's new-data scans about
> two orders of magnitude faster under common conditions.  So maybe in the
> future dedupe won't care as much about rereading stuff, as rereading will
> add at most 1% redundant read iops.  That still requires running dedupe
> first (or in the kernel so it's in the write path), or have some way for
> defrag to avoid touching recently added data before dedupe gets to it,
> due to the extent-splitting duplicate work problem.

The share-preserving defrag shouldn't interfere with dedupe because  
defrag is run on-demand, and it should then shut down dedupe until it  
has completed. Therefore, the issues it causes to dedupe are only  
temporary (and minor, really).

>> I think that this kind of close dedupe-defrag integration should mostly be
>> left to dedupe developers.
>
> That's reasonable--dedupe creates a specific form of fragmentation
> problems.  Not fixing those is bad for dedupe performance (and performance
> in general) so it's a logical extension of the dedupe function to take
> care of them as we go.  I was working on it already.
>
>> First, both defrag and dedupe should work
>> perfectly on their own.
>
> You use the word "perfectly" in a strange way...

What I meant by "perfectly" is that there are no serious bugs and  
issues in either of them. They can work sub-optimally, but they must  
work, not crash or hang. So, perhaps I should have said "both defrag  
and dedupe should work without issues on their own".

Previously, I used the word "perfectly" in a different sense, but I  
thought that this time the modified meaning will be understood from  
the context.

> There are lots of btrfs dedupers that are optimized for different cases:
> some are very fast for ad-hoc full-file dedupe, others are traditional
> block-oriented filesystem-tree scanners that run on multiple filesystems.
> There's an in-kernel one under development that...runs in the kernel
> (honestly, running in the kernel is not as much of an advantage as you
> might think).  I wrote a deduper that was designed to merely not die when
> presented with a large filesystem and a 50%+ dupe hit rate (it ended
> up being faster and more efficient than the others purely by accident,
> but maybe that says more about the state of the btrfs dedupe art than
> about the quality of my implementation).  I wouldn't call any of these
> "perfect"--there are always some subset of users for which any of them
> are unusable or there is a more suitable tool that performs better for
> some special case.

Oh, I didn't mean "perfect" in the sense "best possible results". So,  
just a slight misunderstanding there.
The point is that dedupe-defrag integration should be attempted only  
after it is determined that both defrag and dedupe are working  
*without issues* on their own.

> There is similar specialization and variation among defrag algorithms
> as well.  At best, any of them is "a good result given some choice
> of constraints."

>> Then, an interface to defrag should be made
>> available to dedupe developers. In particular, I think that the batch-update
>> functionality (it takes lots of extents and an empty free space region, then
>> writes defragmented extents to the given region) is of particular interest
>> to dedupe.
>
> Yeah, I have a wishlist item for a kernel call that takes a list of
> (virtual address, length) pairs and produces a single contiguous physical
> extent containing the content of those pairs, updating all the reflinks
> in the process.  Same for dedupe, but that one replaces all the extents
> with reflinks to the first entry in the list instead of making a copy.
>
> I guess the extent-merge call could be augmented with an address hint
> for allocation, but experiments so far have indicated that the possible
> gains are marginal at best given the current btrfs allocator behaviour,
> so I haven't bothered pursuing that.

The "batch-update" from defrag should certainly trumps any  
"extent-merge". The defrag will do it all for you, you just supply the  
defrag with a list of extents that need to be defragmented.



