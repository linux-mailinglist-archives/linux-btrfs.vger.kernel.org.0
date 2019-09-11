Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6FCFB05E2
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 01:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfIKXVi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 19:21:38 -0400
Received: from server53-3.web-hosting.com ([198.54.126.113]:36992 "EHLO
        server53-3.web-hosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727093AbfIKXVi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 19:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=zedlx.com;
         s=default; h=Content-Transfer-Encoding:MIME-Version:Content-Type:Reply-to:
        In-Reply-To:References:Subject:Cc:To:From:Message-ID:Date:Sender:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=AWRBnqvt80CZAA2o7rG5kHMGdJN5usUTDP40rVuj42g=; b=M83QQ0kc7qFI+3Bw0isL/ODuwB
        yycKoKuVRamvYCofA15TmCVjV2cA/2NWnR9VJJX4ssMFcAAmtjiJXBImxSNukyOp53Ik4g8q4XZ4B
        8jTJxT96+A1y4LtFnSXeCc7BcKtKR9jzBuKdzK1VW5HVY5WSpiwDXOXvT2YaAHlVjAWh1BJqxSCr0
        zyxXKHXjZJzCyBKhCDlJWl5nDbVQxtzKKYhW3y4UPQJV0ilq+750nLw+lM8ctH+U1fiUNEoax6D1t
        dEoVerJia6DFwQ/LGzSYw82ExGu+m64qFMez/9oJ79cGAjUMXun583g4EAuCuedujrxT7soT8QSjK
        pt09Qoew==;
Received: from [::1] (port=40678 helo=server53.web-hosting.com)
        by server53.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <webmaster@zedlx.com>)
        id 1i8BvX-001QnO-4T; Wed, 11 Sep 2019 19:21:35 -0400
Received: from [95.178.242.92] ([95.178.242.92]) by server53.web-hosting.com
 (Horde Framework) with HTTPS; Wed, 11 Sep 2019 19:21:31 -0400
Date:   Wed, 11 Sep 2019 19:21:31 -0400
Message-ID: <20190911192131.Horde.2lTVSt-Ln94dqLGQKg_USXQ@server53.web-hosting.com>
From:   webmaster@zedlx.com
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        linux-btrfs@vger.kernel.org
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
 <20190911213704.GB22121@hungrycats.org>
In-Reply-To: <20190911213704.GB22121@hungrycats.org>
Reply-to: webmaster@zedlx.com
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
X-Authenticated-Sender: server53.web-hosting.com: webmaster@zedlx.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, already matched
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Quoting Zygo Blaxell <ce3g8jdj@umail.furryterror.org>:

> On Wed, Sep 11, 2019 at 01:20:53PM -0400, webmaster@zedlx.com wrote:
>>
>> Quoting "Austin S. Hemmelgarn" <ahferroin7@gmail.com>:
>>
>> > On 2019-09-10 19:32, webmaster@zedlx.com wrote:
>> > >
>> > > Quoting "Austin S. Hemmelgarn" <ahferroin7@gmail.com>:
>> > >
>>
>> > >
>> > > === I CHALLENGE you and anyone else on this mailing list: ===
>> > >
>> > >  - Show me an exaple where splitting an extent requires unsharing,
>> > > and this split is needed to defrag.
>> > >
>> > > Make it clear, write it yourself, I don't want any machine-made outputs.
>> > >
>> > Start with the above comment about all writes unsharing the region being
>> > written to.
>> >
>> > Now, extrapolating from there:
>> >
>> > Assume you have two files, A and B, each consisting of 64 filesystem
>> > blocks in single shared extent.  Now assume somebody writes a few bytes
>> > to the middle of file B, right around the boundary between blocks 31 and
>> > 32, and that you get similar writes to file A straddling blocks 14-15
>> > and 47-48.
>> >
>> > After all of that, file A will be 5 extents:
>> >
>> > * A reflink to blocks 0-13 of the original extent.
>> > * A single isolated extent consisting of the new blocks 14-15
>> > * A reflink to blocks 16-46 of the original extent.
>> > * A single isolated extent consisting of the new blocks 47-48
>> > * A reflink to blocks 49-63 of the original extent.
>> >
>> > And file B will be 3 extents:
>> >
>> > * A reflink to blocks 0-30 of the original extent.
>> > * A single isolated extent consisting of the new blocks 31-32.
>> > * A reflink to blocks 32-63 of the original extent.
>> >
>> > Note that there are a total of four contiguous sequences of blocks that
>> > are common between both files:
>> >
>> > * 0-13
>> > * 16-30
>> > * 32-46
>> > * 49-63
>> >
>> > There is no way to completely defragment either file without splitting
>> > the original extent (which is still there, just not fully referenced by
>> > either file) unless you rewrite the whole file to a new single extent
>> > (which would, of course, completely unshare the whole file).  In fact,
>> > if you want to ensure that those shared regions stay reflinked, there's
>> > no way to defragment either file without _increasing_ the number of
>> > extents in that file (either file would need 7 extents to properly share
>> > only those 4 regions), and even then only one of the files could be
>> > fully defragmented.
>> >
>> > Such a situation generally won't happen if you're just dealing with
>> > read-only snapshots, but is not unusual when dealing with regular files
>> > that are reflinked (which is not an uncommon situation on some systems,
>> > as a lot of people have `cp` aliased to reflink things whenever
>> > possible).
>>
>> Well, thank you very much for writing this example. Your example is
>> certainly not minimal, as it seems to me that one write to the file A and
>> one write to file B would be sufficient to prove your point, so there we
>> have one extra write in the example, but that's OK.
>>
>> Your example proves that I was wrong. I admit: it is impossible to perfectly
>> defrag one subvolume (in the way I imagined it should be done).
>> Why? Because, as in your example, there can be files within a SINGLE
>> subvolume which share their extents with each other. I didn't consider such
>> a case.
>>
>> On the other hand, I judge this issue to be mostly irrelevant. Why? Because
>> most of the file sharing will be between subvolumes, not within a subvolume.
>> When a user creates a reflink to a file in the same subvolume, he is
>> willingly denying himself the assurance of a perfect defrag. Because, as
>> your example proves, if there are a few writes to BOTH files, it gets
>> impossible to defrag perfectly. So, if the user creates such reflinks, it's
>> his own whish and his own fault.
>>
>> Such situations will occur only in some specific circumstances:
>> a) when the user is reflinking manually
>> b) when a file is copied from one subvolume into a different file in a
>> different subvolume.
>>
>> The situation a) is unusual in normal use of the filesystem. Even when it
>> occurs, it is the explicit command given by the user, so he should be
>> willing to accept all the consequences, even the bad ones like imperfect
>> defrag.
>>
>> The situation b) is possible, but as far as I know copies are currently not
>> done that way in btrfs. There should probably be the option to reflink-copy
>> files fron another subvolume, that would be good.
>
> Reflink copies across subvolumes have been working for years.  They are
> an important component that makes dedupe work when snapshots are present.

I take that what you say is true, but what I said is that when a user  
(or application) makes a
normal copy from one subvolume to another, then it won't be a  
reflink-copy. To make such a reflink-copy, you need btrfs-aware cp or  
btrfs-aware applications.

So, the reflik-copy is a special case, usually explicitly requested by  
the user.

>> But anyway, it doesn't matter. Because most of the sharing will be between
>> subvolumes, not within subvolume.
>
> Heh.  I'd like you to meet one of my medium-sized filesystems:
>
> 	Physical size:  8TB
> 	Logical size:  16TB
> 	Average references per extent:  2.03 (not counting snapshots)
> 	Workload:  CI build server, VM host
>
> That's a filesystem where over half of the logical data is reflinks to the
> other physical data, and 94% of that data is in a single subvol.  7.5TB of
> data is unique, the remaining 500GB is referenced an average of 17 times.
>
> We use ordinary applications to make ordinary copies of files, and do
> tarball unpacks and source checkouts with reckless abandon, all day long.
> Dedupe turns the copies into reflinks as we go, so every copy becomes
> a reflink no matter how it was created.
>
> For the VM filesystem image files, it's not uncommon to see a high
> reflink rate within a single file as well as reflinks to other files
> (like the binary files in the build directories that the VM images are
> constructed from).  Those reference counts can go into the millions.

OK, but that cannot be helped: either you retain the sharing structure  
with imperfect defrag, or you unshare and produce a perfect defrag  
which should have somewhat better performance (and pray that the disk  
doesn't fill up).

>> So, if there is some in-subvolume sharing,
>> the defrag wont be 100% perfect, that a minor point. Unimportant.
>
> It's not unimportant; however, the implementation does have to take this
> into account, and make sure that defrag can efficiently skip extents that
> are too expensive to relocate.  If we plan to read an extent fewer than
> 100 times, it makes no sense to update 20000 references to it--we spend
> less total time just doing the 100 slower reads.

Not necesarily. Because you can defrag in the time-of-day when there  
is a low pressure on the disk IO, so updating 20000 references is  
esentially free.

You are just making those later 100 reads faster.

OK, you are right, there is some limit, but this is such a rare case,  
that such a heavily-referenced extents are best left untouched.
I suggest something along these lines: if there are more than XX  
(where XX defaults to 1000) reflinks to an extent, then one or more  
copies of the extent should be made such that each has less than XX  
reflinks to it. The number XX should be user-configurable.

> If the numbers are
> reversed then it's better to defrag the extent--100 reference updates
> are easily outweighed by 20000 faster reads.  The kernel doesn't have
> enough information to make good decisions about this.

So, just make the number XX user-provided.

> Dedupe has a similar problem--it's rarely worth doing a GB of IO to
> save 4K of space, so in practical implementations, a lot of duplicate
> blocks have to remain duplicate.
>
> There are some ways to make the kernel dedupe and defrag API process
> each reference a little more efficiently, but none will get around this
> basic physical problem:  some extents are just better off where they are.

OK. If you don't touch those extents, they are still shared. That's  
what I wanted.

> Userspace has access to some extra data from the user, e.g.  "which
> snapshots should have their references excluded from defrag because
> the entire snapshot will be deleted in a few minutes."  That will allow
> better defrag cost-benefit decisions than any in-kernel implementation
> can make by itself.

Yes, but I think that we are going into too much details which are  
diverting the attention from the overall picture and from big problems.

And the big problem here is: what do we want defrag to do in general,  
most common cases. Because we haven't still agreed on that one since  
many of the people here are ardent followers of the  
defrag-by-unsharing ideology.

> 'btrfs fi defrag' is just one possible userspace implementation, which
> implements the "throw entire files at the legacy kernel defrag API one
> at a time" algorithm.  Unfortunately, nobody seems to have implemented
> any other algorithms yet, other than a few toy proof-of-concept demos.

I really don't have a clue what's happening, but if I were to start  
working on it (which I won't), then the first things should be:
- creating a way for btrfs to split large extents into smaller ones  
(for easier defrag, as first phase).
- creating a way for btrfs to merge small adjanced extents shared by  
the same files into larger extents (as the last phase of defragmenting  
a file).
- create a structure (associative array) for defrag that can track  
backlinks. Keep the structure updated with each filesystem change, by  
placing hooks in filesystem-update routines.

You can't go wrong with this. Whatever details change about defrag  
operation, the given three things will be needed by defrag.

>> Now, to retain the original sharing structure, the defrag has to change the
>> reflink of extent E55 in file B to point to E70. You are telling me this is
>> not possible? Bullshit!
>
> This is already possible today and userspace tools can do it--not as
> efficiently as possible, but without requiring more than 128M of temporary
> space.  'btrfs fi defrag' is not one of those tools.
>
>> Please explain to me how this 'defrag has to unshare' story of yours isn't
>> an intentional attempt to mislead me.
>
> Austin is talking about the btrfs we have, not the btrfs we want.

OK, but then, you agree with me that current defrag is a joke. I mean,  
something is better than nothing, and the current defrag isn't  
completely useless, but it is in most circumstances either unusable or  
not good enough.

I mean, the snapshots are a prime feature of btrfs. If not, then why  
bother with b-trees? If you wanted subvolumes, checksums and RAID,  
then you should have made ext5. B-trees are in btrfs so that there can  
be snapshots. But, the current defrag works bad with snaphots. It  
doesn't defrag them well, it also unshares data. Bad bad bad.

And if you wanted to be honest to your users, why don't you place this  
info in the wiki? Ok, the wiki says "defrag will unshare", but it  
doesn't say that it also doesn't defragment well.

For example, lets examine the typical home user. If he is using btrfs,  
it means he probably wants snapshots of his data. And, after a few  
snapshots, his data is fragmented, and the current defrag can't help  
because it does a terrible job in this particualr case.

So why don't you write on the wiki "the defrag is practically unusable  
in case you use snapshots". Because that is the truth. Be honest.



