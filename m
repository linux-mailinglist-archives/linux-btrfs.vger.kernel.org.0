Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21404478386
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Dec 2021 04:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbhLQDKu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Dec 2021 22:10:50 -0500
Received: from bee.birch.relay.mailchannels.net ([23.83.209.14]:54963 "EHLO
        bee.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229471AbhLQDKu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Dec 2021 22:10:50 -0500
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 60AF5621310;
        Fri, 17 Dec 2021 03:10:49 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 362CD6226C8;
        Fri, 17 Dec 2021 03:10:48 +0000 (UTC)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.114.196.210 (trex/6.4.3);
        Fri, 17 Dec 2021 03:10:49 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Battle-Arch: 1c7ffa0e669d40c6_1639710649029_3108255308
X-MC-Loop-Signature: 1639710649029:3131773081
X-MC-Ingress-Time: 1639710649029
Received: from ppp-88-217-34-119.dynamic.mnet-online.de ([88.217.34.119]:59922 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <calestyo@scientia.org>)
        id 1my3dr-0008Pj-PD; Fri, 17 Dec 2021 03:10:46 +0000
Message-ID: <36245dcfd13d23eee0add6719b1da0c23e7c3936.camel@scientia.org>
Subject: Re: ENOSPC while df shows 826.93GiB free
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
Date:   Fri, 17 Dec 2021 04:10:39 +0100
In-Reply-To: <6ed64808-1161-6cea-214c-88a1ac883101@gmx.com>
References: <f001f3e81d413ea290722c38b14d95f3f1f52249.camel@scientia.org>
         <25d305e5-c75f-3d71-fc5a-c2019e49bed9@gmx.com>
         <c64be50bdc99b993b910a7ab019af8d552eeb0d4.camel@scientia.org>
         <b7b6a6a7-700e-f83d-dae6-581ed6befbef@gmx.com>
         <3239b2307fae4c7f9e8be9f194d5f3ef470ddb8c.camel@scientia.org>
         <20211207072128.GL17148@hungrycats.org>
         <b913833639d11a0242f781d94452e5e31d7cbf1b.camel@scientia.org>
         <20211207181437.GM17148@hungrycats.org>
         <2e0f4856d8132f39e5d668929f77aac7ed01d476.camel@scientia.org>
         <6ed64808-1161-6cea-214c-88a1ac883101@gmx.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 2021-12-17 at 10:00 +0800, Qu Wenruo wrote:
> Or, let's change how we output our vanilla `df` command output, by
> taking metadata free space and unallocated space into consideration,
> like:

Actually I was thinking about this before as well, but that would
rather just remedy the consequences of that particular ENOSPC situation
and not prevent it.



> - If there is no more unallocated space can be utilized
>    Then take metadata free space into consideration, like if there is
>    only 1G free metadata space, while several tera free data space,
>    we only report free metadata space * some ratio as free data
> space.

Not sure whether this is so good... because then the shown free space
is completely made up... it could be like that value if the remaining
unallocated space and the remaining meta-data space are eaten up as
"anticipated"... but it could also be much more or much less (depending
on what actually happens), right?

What I'd rather do is:
*If* btrfs realises that there's still free space in the data block
groups... but really nothing at all (that isn't reserved for special
operations) is left in the meta-data block groups AND nothing more
could be allocated... then suddenly drop the shown free space to
exactly 0.

Because from a classic programs point of view, that's what the case, it
cannot further add any files (not even empty ones).


This would also allow programs like dCache to better deal with that
situation.
What dCache does is laid out here:
https://github.com/dCache/dcache/issues/5352#issuecomment-989793555

Perhaps some background... dCache is a distributed storage system, so
it runs on multiple nodes managing files placed in many filesystems (on
so called pools).
Clients first connect via some protocol to a "door node", from which
they are (at least if the respective protocol supports it) redirected
to a pool, where dCache thinks the file could be written to (in the
write case, obviously).

dCache decides that by known all it's pools and monitoring their
(filesystems') free space. It also has a configurable gap value
(defaulting to 4GB), which it will try to leave free on a pool.

If the file is expected to fit in (I think it again depends on the
protocol, whether it really knows in advance how much the client will
write) while still observing the gap,... plus several more load
balancing metrics... a pool may be selected and the client redirected.

Seems to me like a fairly reasonable process.


So as things are currently with btrfs and when that particular
situation arises that I've had now (plenty free space in data block
groups, but zero in meta-data block groups plus zero unallocated
space), then dCache cannot really deal properly with that:

- df (respectively the usual syscalls) will show it that much more
space is available than what the gap would help against

- the client tries to write to the pool, there's immediately ENOSPC and
the transfer is properly aborted with some failure

- but dCache cannot really tell whether the situation is still there or
not... so it will run into broken write transfers over and over

- typically also, once a client is redirected to a pool, there is no
going back and retrying the same on another one (at least not
automatically from within the protocol)... so the failure is really
"permanent", unless the client itself tries again and then (by chance)
lands on another pool where the btrfs is still good


If df respectively the syscalls would return 0 free space in that
situation, we'd still have ~800 GB lost (without manual
intervention)... but at least the middleware should be able to deal
with that.



> By this, we under-report the amount of available space, although
> users
> may (and for most cases, they indeed can) write way more space than
> the
> reported available space, we have done our best to show end users
> that
> they need to take care of the fs.
> Either by deleting unused data, or do proper maintenance before
> reported
> available space reaches 0.

Well but at least when the problem has happened, then - without any
further intervention - no further writes (of new files respectively new
data) will be possible... so the "under-reporting" is only true if one
assumes that this intervention will happen.

If it does, like by a some maintenance "minimal" balance as Zygo
suggested, then the whole situation should anyway not happen, AFAIU.
And if its by some intervention after the ENOSPC, then the "under-
reporting" would also go away, as soon as the problem was fixed
(manually).




But what do you think about my idea of btrfs automatically solving the
situation by doing a balance on it's own, once the problem of arose?


One could also think of something like the following:
Add some 2nd level global reserve, which is much bigger than the
current one... at least enough that one could manually balance the fs
(or btrfs to that automatically if it decided it needs to)

If the problem of this mail thread occurs it could be used to more
easily solve it without the need to move data to somewhere else (which
may not always be feasible), because it would be reserved to be e.g.
used for such a balance.

One could make its dependent on the size of the fs. If the fs has e.g.
1TB, then reserving e.g. 4GB is barely noticeably. And if the fs should
be too small, one simply doesn't have the 2nd level global reserve.

If(!) the fs runs full in a proper way (i.e. no more unallocated space
an meta-data and data block groups are equally full) then btrfs could
decide to release that 2nd level global reserve back to be used, to
squeeze out as much space as possible not loosing too much.

Once it's really full, it's full and not much new could happen
anyway... and the normal global reserve would be still there for the
*very* important things.

If files should later on be deleted, btrfs could decide to try to re-
establish the 2nd level global reserve... again to be "reserved" until
the fs is again really really full and it would be just wasted space.


Cheers,
Chris.
