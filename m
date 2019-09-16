Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE24B39A6
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2019 13:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731258AbfIPLnA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Sep 2019 07:43:00 -0400
Received: from server53-3.web-hosting.com ([198.54.126.113]:45939 "EHLO
        server53-3.web-hosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725912AbfIPLm7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Sep 2019 07:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=zedlx.com;
         s=default; h=MIME-Version:Content-Type:In-Reply-To:References:Subject:Cc:To:
        From:Message-ID:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=fzBMKoRXnYE7aMWYt6cvKGuOaIFdku7IwfHMkhSYXbo=; b=ZMshI+frRLyLDyXSeydpAZwcC/
        OlrWmYmxpFXO/sdPcxBCq5VKI7Qf90CpC+5AiKl1iatJDMaDooxeBLrtYL5BpL9SXTPPaHoe33SMV
        +2BZmOuvjjfBL67y75HvUMosoxcR66Ng8Mj87NMzh0EzfruyejPVhwPFd+mPonAZDjeMcxxIoHqj4
        Mwp7cNsbJI7abT3zHflHV2qq+I8cZJHKK1DzciTy4kHbUAqgWsjY8HPRv9it5i5eKXnl0mCC/0OtP
        V7xBtODqLMlqH+unYDcRm5ghMbtHxpHkv+W8Zy1l3KqOVOp2RKsFwPe+iQ+i4fm+QQ1dQ8GsSux7b
        mYBgJbOg==;
Received: from [::1] (port=57820 helo=server53.web-hosting.com)
        by server53.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <general-zed@zedlx.com>)
        id 1i9pP9-001NXy-Qq; Mon, 16 Sep 2019 07:42:56 -0400
Received: from [95.178.242.132] ([95.178.242.132]) by
 server53.web-hosting.com (Horde Framework) with HTTPS; Mon, 16 Sep 2019
 07:42:51 -0400
Date:   Mon, 16 Sep 2019 07:42:51 -0400
Message-ID: <20190916074251.Horde.bsBwDU_QYlFY0p-a1JzxZrm@server53.web-hosting.com>
From:   General Zed <general-zed@zedlx.com>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: Feature requests: online backup - defrag - change RAID level
References: <c4f05241-77d4-3ae4-9773-795351a26a8e@cobb.uk.net>
 <20190909152625.Horde.fICzOssZXCnCZS2vVHBK-sn@server53.web-hosting.com>
 <fc81fcf2-f8e9-1a08-52f8-136503e40494@gmail.com>
 <20190910193221.Horde.HYrKYqNVgQ10jshWWA1Gxxu@server53.web-hosting.com>
 <d958659e-6dc0-fa0a-7da9-2d88df4588f5@gmail.com>
 <20190911132053.Horde._wJd24LqxxXx9ujl2r5i7PQ@server53.web-hosting.com>
 <20190911213704.GB22121@hungrycats.org>
 <20190911192131.Horde.2lTVSt-Ln94dqLGQKg_USXQ@server53.web-hosting.com>
 <20190912051904.GD22121@hungrycats.org>
 <20190912172321.Horde.oyDNseL4IVWz-QYWBqgXqjO@server53.web-hosting.com>
 <20190914041255.GJ22121@hungrycats.org>
In-Reply-To: <20190914041255.GJ22121@hungrycats.org>
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

> On Thu, Sep 12, 2019 at 05:23:21PM -0400, General Zed wrote:
>>
>> Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:
>>
>> > On Wed, Sep 11, 2019 at 07:21:31PM -0400, webmaster@zedlx.com wrote:
>> > >
>> > > Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:
> [...etc...]
>> > > > On Wed, Sep 11, 2019 at 01:20:53PM -0400, webmaster@zedlx.com wrote:
>> > It's the default for GNU coreutils, and for 'mv' across subvols there
>> > is currently no option to turn reflink copies off.  Maybe for 'cp'
>> > you still have to explicitly request reflink, but that will presumably
>> > change at some point as more filesystems get the CLONE_RANGE ioctl and
>> > more users expect it to just work by default.
>>
>> Yes, thank you for posting another batch of arguments that support the use
>> of my vision of defrag instead of the current one.
>>
>> The defrag that I'm proposing will preserve all those reflinks that were
>> painstakingly created by the user. Therefore, I take that you agree with me
>> on the utmost importance of implementing this new defrag that I'm proposing.
>
> I do not agree that improving the current defrag is of utmost importance,
> or indeed of any importance whatsoever.  The current defrag API is a
> clumsy, unscalable hack that cannot play well with other filesystem layout
> optimization tools no matter what you do to its internal implementation
> details.  It's better to start over with a better design, and spend only
> the minimal amount of effort required to keep the old one building until
> its replacement(s) is (are) proven in use and ready for deployment.
>
> I'm adding extent-merging support to an existing tool that already
> performs several other filesystem layout optimizations.  The goal is to
> detect degenerate extent layout on filesystems as it appears, and repair
> it before it becomes a more severe performance problem, without wasting
> resources on parts of the filesystem that do not require intervention.

Oh, I get it. So, the current defrag isn't particularly good, so you  
are going to produce a solution which mitigates the fragmentation  
problem in some cases (but not all of them). Well, that's a good quick  
fix, but not a true solution.

> Your defrag ideas are interesting, but you should spend a lot more
> time learning the btrfs fundamentals before continuing.  Right now
> you do not understand what btrfs is capable of doing easily, and what
> requires such significant rework in btrfs to implement that the result
> cannot be considered the same filesystem.  This is impairing the quality
> of your design proposals and reducing the value of your contribution
> significantly.

Ok, that was a shot at me; and I admit, guilty as charged. I barely  
have a clue about btrfs.
Now it's my turn to shoot. Apparently, the people which are  
implementing the btrfs defrag, or at least the ones that responded to  
my post, seem to have no clue about how on-demand defrag solutions  
typically work. I had to explain the usual tricks involved in the  
defragmentation, and it was like talking to complete rookies. None of  
you even considered a full-featured defrag solution, all that you are  
doing are some partial solutions.

And, you all got lost in implementation details. How many times have I  
been told here that some operation cannot be performed, and then it  
turned out the opposite. You have all sunk into some strange state of  
mind where every possible excuse is being made in order not to start  
working on a better, hollistic defrag solution.

And you even misunderstood me when I said "hollistic defrag", you  
thought I was talking about a full defrag. No. A full defrag is a  
defrag performed on all the data. A holistic defrag can be performed  
on only some data, but it is hollistic in the sense that it uses whole  
information about a filesystem, not just a partial view of it. A  
holistic defrag is better than a partial defrag: it is faster and  
produces better results, and it can defrag a wider spectrum of cases.  
Why? Because a holistic defrag takes everything into account.

So I think you should all inform yourself a little better about  
various defrag algorithms and solutions that exist. Apparently, you  
all lost the sight of the big picture. You can't see the wood from the  
trees.

>> I suggest that btrfs should first try to determine whether it can split an
>> extent in-place, or not. If it can't do that, then it should create new
>> extents to split the old one.
>
> btrfs cannot split extents in place, so it must always create new
> extents by copying data blocks.  It's a hugely annoying and non-trivial
> limitation that makes me consider starting over with some other filesystem
> quite often.

Actually, this has no repercussions for the defrag. The defrag will  
always copy the data to a new place. So, if brtfs can't split  
in-place, that is just fine.

> If you are looking for important btrfs work, consider solving that
> problem first.  It would dramatically improve GC (in the sense that
> it would eliminate the need to perform a separate GC step at all) and
> dedupe performance on btrfs as well as help defrag and other extent
> layout optimizers.

There is no problem there.

>> Therefore, the defrag can free unused parts of any extent, and then the
>> extent can be split is necessary. In fact, both these operations can be done
>> simultaneously.
>
> Sure, but I only call one of these operations "defrag" (the extent merge
> operation).  The other operations increase the total number of fragments
> in the filesystem, so "defrag" is not an appropriate name for them.
> An appropriate name would be something like "enfrag" or "refrag" or
> "split".  In some cases the "defrag" can be performed by doing a "dedupe"
> operation with a single unfragmented identical source extent replacing
> several fragmented destination extents...what do you call that?

Well, no. Perhaps the word "defrag" can have a wider and narrower  
sense. So in a narrower sense, "defrag" means what you just wrote. In  
that sense, the word "defrag" means practically the same as "merge",  
so why not just use the word "merge" to remove any ambiguities. The  
"merge" is the only operation that decreases the number of fragments  
(besides "delete"). Perhaps you meant move&merge. But, commonly, the  
word "defrag" is used in a wider sense, which is not the one you  
described.

In a wider sense, the defrag involves the preparation, analysis, free  
space consolidation, multiple phases, splitting and merging, and final  
passes.

Try looking on Wikipedia for "defrag".

>> > Dedupe on btrfs also requires the ability to split and merge extents;
>> > otherwise, we can't dedupe an extent that contains a combination of
>> > unique and duplicate data.  If we try to just move references around
>> > without splitting extents into all-duplicate and all-unique extents,
>> > the duplicate blocks become unreachable, but are not deallocated.  If we
>> > only split extents, fragmentation overhead gets bad.  Before creating
>> > thousands of references to an extent, it is worthwhile to merge it with
>> > as many of its neighbors as possible, ideally by picking the biggest
>> > existing garbage-free extents available so we don't have to do defrag.
>> > As we examine each extent in the filesystem, it may be best to send
>> > to defrag, dedupe, or garbage collection--sometimes more than one of
>> > those.
>>
>> This is sovled simply by always running defrag before dedupe.
>
> Defrag and dedupe in separate passes is nonsense on btrfs.

Defrag can be run without dedupe.

Now, how to organize dedupe? I didn't think about it yet. I'll leave  
it to you, but it seems to me that defrag should be involved there.  
And, my defrag solution would help there very, very much.

> Defrag burns a lot of iops on defrag moving extent data around to create
> new size-driven extent boundaries.  These will have to be immediately
> moved again by dedupe (except in special cases like full-file matches),
> because dedupe needs to create content-driven extent boundaries to work
> on btrfs.

Defrag can be run without dedupe.

Dedupe probably requires some kind of defrag to produce a good result   
(a result without heavy fragmentation).

> Extent splitting in-place is not possible on btrfs, so extent boundary
> changes necessarily involve data copies.  Reference counting is done
> by extent in btrfs, so it is only possible to free complete extents.

Great, there is reference counting in btrfs. That helps. Good design.

> You have to replace the whole extent with references to data from
> somewhere else, creating data copies as required to do so where no
> duplicate copy of the data is available for reflink.
>
> Note the phrase "on btrfs" appears often here...other filesystems manage
> to solve these problems without special effort.  Again, if you're looking
> for important btrfs things to work on, maybe start with in-place extent
> splitting.

I think that I'll start with "software design document for on-demand  
defrag which preserves sharing structure". I have figure out that you  
don't have it yet. And, how can you even start working on a defrag  
without a software design document?

So I volunteer to write it. Apparently, I'm already half way done.

> On XFS you can split extents in place and reference counting is by
> block, so you can do alternating defrag and dedupe passes.  It's still
> suboptimal (you still waste iops to defrag data blocks that are
> immediately eliminated by the following dedupe), but it's orders of
> magnitude better than btrfs.

I'll reply to the rest of this marathonic post in another reply (when  
I find the time to read it). Because I'm writing the software design  
document.


