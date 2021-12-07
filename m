Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E5946BDBE
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 15:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237871AbhLGOes (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 09:34:48 -0500
Received: from beige.elm.relay.mailchannels.net ([23.83.212.16]:49512 "EHLO
        beige.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232417AbhLGOer (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Dec 2021 09:34:47 -0500
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 8C450461ECA;
        Tue,  7 Dec 2021 14:31:14 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 829C94620D9;
        Tue,  7 Dec 2021 14:31:13 +0000 (UTC)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.100.11.81 (trex/6.4.3);
        Tue, 07 Dec 2021 14:31:14 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Spill-Keen: 60029e72057f759e_1638887474342_1550945569
X-MC-Loop-Signature: 1638887474342:1500887494
X-MC-Ingress-Time: 1638887474342
Received: from p57b045ec.dip0.t-ipconnect.de ([87.176.69.236]:57122 helo=heisenberg.scientia.net)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <calestyo@scientia.org>)
        id 1mubUY-0001vD-O5; Tue, 07 Dec 2021 14:30:54 +0000
Message-ID: <82c5e12ddc69fccbc8329b153224e869713f25cb.camel@scientia.org>
Subject: Re: ENOSPC while df shows 826.93GiB free
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Date:   Tue, 07 Dec 2021 15:30:47 +0100
In-Reply-To: <b68c9739-3c7e-7303-4b21-818b5d28bf25@gmx.com>
References: <f001f3e81d413ea290722c38b14d95f3f1f52249.camel@scientia.org>
         <25d305e5-c75f-3d71-fc5a-c2019e49bed9@gmx.com>
         <c64be50bdc99b993b910a7ab019af8d552eeb0d4.camel@scientia.org>
         <b7b6a6a7-700e-f83d-dae6-581ed6befbef@gmx.com>
         <3239b2307fae4c7f9e8be9f194d5f3ef470ddb8c.camel@scientia.org>
         <b68c9739-3c7e-7303-4b21-818b5d28bf25@gmx.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 2021-12-07 at 12:56 +0800, Qu Wenruo wrote:
> That's the problem with dynamic chunk allocation, and to be honest, I
> don't have any better idea how to make it work just like traditional
> fses.
> 
> You could consider it as something like thin-provisioned device,
> which
> would have the same problem (reporting tons of free space, but will
> hang
> if underlying space is used up).

Well the first thing I don't understand is, that my scenario seems
pretty... simple.

These filesystems have only few files (so 30k to perhaps 200k).
Seems far simpler than e.g. the fs of the system itself, where one can
have many files of completely varying size in /usr, /home, and so on.

Also, these files (apart from some small meta-data files) are *always*
written once and then only read (or deleted).
There is never any random write access... so fragmentation should be
far less than under "normal" systems.

The total size of the fs is obviously known.
You said now, that the likely cause are the csum data... but isn't it
then kinda clear from the beginning how much you'd need (at most) if
the filesystem would be filled up with data?


Just for my understanding:
How is csum data stored?
Is it like one sum per fixed block size of data? Or one sum per (not
fixed) extent size of data?

But in both cases I'd have assumed that the maximum of space needed for
that is kinda predictable?
Unlike e.g. on a thin provisioned device, or when using many (rw)
snapshots,... where one cannot really predict how much storage would be
needed because data is changed from the shared copy.



> Because all chunks are allocated on demand, if 1) your workload has
> every unbalanced data/metadata usage, like this case (almost 1000:1).
> 2) You run out of space, then you will hit this particular problem.

I've described the typical workload above:
rather large files (the data sets from the experiments), written once,
never any further writes to them, only deletions.

I'd have expected that this causes *far* less fragmentation than e.g.
filesystems that contain /home or so, where one has many random writes.


> It won't matter if you reserve 1T or not for the data.
> 
> It can still go the same problem even if there are tons of unused
> data
> space.
> Fragmented data space can still cause the same problem.

Let me try to understand this better:

btrfs allocates data block groups and meta-data block groups (both
dynamically), right?

Are these always of the same size (like e.g. always 1G)?

When I now write a 500M file... it would e.g. fill one such data block
group with 500M (and write some data into a metadata block group).
And when I would write next a 2 G file... it would write the first 500M
to the already allocated data block group,.. and then allocate more to
write the remaining data.

Does that sound kinda right so far (simplified of course)?

The problem I had now, was that the fs filled up more and more and (due
to fragmentation),... all free space is in data block groups... but
since no unallocated storage is left it could not allocate more
metadata block groups.
So from the data PoV it could still write (i.e. the free space) because
all the fragmented data block groups have still some ~800GiB free...
but it cannot write any more meta-data.

Still kinda right?


So my naive assumption(s) would have been:
1) It's a sign that it doesn't allocate meta-data block group
aggressively enough.

2) If I cure the fragmentation (in the data block groups),... and btrfs
could give back those... there would be again some unallocated space,
which it could use for meta-data block groups... and so I could use
more of the remaining 800GB, right?

Would balance already do this? I guess not, cause AFAIU balance just
re-writes block groups as is, right?
So that's the reason, why balancing didn't help in any way?

So the proper way would be to btrfs filesystem defragment... thus
reclaim some unallocated space and get that for the meta-data.
Right?


But still,... that seems all quite a lot of manual work (and thus not
scale for a large data centre):
Would the deframentation work if the meta-data is already out of space?


Why would it not help, if btrfs (pre-)reserves more meta-data block
groups?
So maybe of the ~800GB that are now still free (within data block
groups)... one would use e.g. 100 GB to meta-data...
From these 100 GB... 50 GB might be never used... but overall I could
still use ~700 GB in data block groups - whereas now: both is
effectively lost (the full ~800 GB).



> 

Are there any manual ways to say in e.g. our use case:
don't just allocate 17GB per fs for meta-data... but allocate already
80GB...

And wouldn't that cure our problem... by simply helping to (likely)
never reaching the out-of-metadata space situation?


Thanks,
Chris.
