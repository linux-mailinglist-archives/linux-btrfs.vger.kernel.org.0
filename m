Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF53478061
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Dec 2021 00:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237094AbhLPXQd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Dec 2021 18:16:33 -0500
Received: from beige.elm.relay.mailchannels.net ([23.83.212.16]:56779 "EHLO
        beige.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234193AbhLPXQc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Dec 2021 18:16:32 -0500
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 10113861A18;
        Thu, 16 Dec 2021 23:16:32 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id D2CF1861914;
        Thu, 16 Dec 2021 23:16:30 +0000 (UTC)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.97.65.154 (trex/6.4.3);
        Thu, 16 Dec 2021 23:16:31 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Glossy-Grain: 1cc825d12c2f33ef_1639696591710_1812184599
X-MC-Loop-Signature: 1639696591710:2585811879
X-MC-Ingress-Time: 1639696591710
Received: from ppp-88-217-34-119.dynamic.mnet-online.de ([88.217.34.119]:59866 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <calestyo@scientia.org>)
        id 1mxzz7-0000aj-Td; Thu, 16 Dec 2021 23:16:28 +0000
Message-ID: <2e0f4856d8132f39e5d668929f77aac7ed01d476.camel@scientia.org>
Subject: Re: ENOSPC while df shows 826.93GiB free
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Date:   Fri, 17 Dec 2021 00:16:21 +0100
In-Reply-To: <20211207181437.GM17148@hungrycats.org>
References: <f001f3e81d413ea290722c38b14d95f3f1f52249.camel@scientia.org>
         <25d305e5-c75f-3d71-fc5a-c2019e49bed9@gmx.com>
         <c64be50bdc99b993b910a7ab019af8d552eeb0d4.camel@scientia.org>
         <b7b6a6a7-700e-f83d-dae6-581ed6befbef@gmx.com>
         <3239b2307fae4c7f9e8be9f194d5f3ef470ddb8c.camel@scientia.org>
         <20211207072128.GL17148@hungrycats.org>
         <b913833639d11a0242f781d94452e5e31d7cbf1b.camel@scientia.org>
         <20211207181437.GM17148@hungrycats.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 2021-12-07 at 13:14 -0500, Zygo Blaxell wrote:
> It coalesces the free space in each block group into big contiguous
> regions, eventually growing them to regions over 1GB in size. 
> Usually
> this gives back unallocated space.

Ah, I see... an yes that worked.

Not sure if I missed anything, but I think this should be somehow
explained in the btrfs-balance(8).
I mean there *is* the section "MAKING BLOCK GROUP LAYOUT MORE COMPACT",
but that also kinda misses the point that this can be used to get
unallocated space back, doesn't it?


Is there some way to see a distribution of the space usage of block
groups?
Like some print out that shows me:
- there are n block groups
- xx = 100%
- xx > 90%
- xx > 80%
...
- xx = 0%
?

That would also give some better idea on how worth it is to balance,
and which options to use.


> If balance can't pack the extents in 1GB units without changing their
> sizes or crossing a block group boundary, then balance might not be
> able to free any block groups this way, so this tends to fail when
> the
> filesystem is over about 97% full.

So that's basically the point when one can only move data away... do
the balance and move it back afterwards.

Which btw. worked quite nicely. (so thanks to all involved people for
the help with that).


> Minimal balance is exactly one data block group, i.e.
> 
>         btrfs balance start -dlimit=1 /fs
> 
> Run it when unallocated space gets low.  The exact threshold is low
> enough that the time between new data block group allocations is less
> than the balance time.

What the sysadmin of large storage farms needs is something that one
can run basically always (so even if unallocated space is NOT low),
which kinda works out of the box and automatically (run via cron?) and
doesn't impact the IO too much.
Or one would need some daemon, which monitors unallocated space and
kicks in if necessary.

Does it make sense to use -dusage=xx in addition to -dlimit?
I mean if space is already tight... would just -dlimit=1 try to find a
block group that it can balance (because it's usage is low enough)...
or might it just fail when the first tried one is nearly fully (and not
enough space is left for that in other block groups)?


> It has to be run for a short time because metadata_ratio=1 means 1:1
> metadata to data allocation.  You only want to do this to rescue a
> filesystem that has become stuck with too little metadata.  Once the
> required amount of metadata is allocated, remove the metadata_ratio
> option and do minimal data balancing going forward.

But that's also something rather only suitable for "rescuing"... one
wouldn't want to do that in big storage systems on hundreds of
filesystems, just to make sure that btrfs doesn't run into that
situation in the first place.

For that it would be much nicer if one had other means to tell btrfs to
allocate more for metadata,... like either a command to reserve xx GB,
that one can run when one sees that space get tight... or by some
bother logic when btrfs does that automatically.


> You can set metadata_ratio=30, which will allocate (100 / 30) = ~3%
> of the space for metadata, if you are starting with an empty
> filesystem.

Okay that sounds more like a way...


> TBH it's never been a problem--but I run the minimal data balance
> daily,
> and scrub every month, and never balance metadata, and have snapshots
> and dedupe.  Between these they trigger all the necessary metadata
> allocations.

I'm also still not really sure why this happened here.

I've asked the developers of our storage middleware software in the
meantime, and it seems in fact that dCache does pre-allocate the space
of files that it wants to write.

But even then, shouldn't btrfs be able to know how much it will
generally need for csum metadata?

I can only think of IO patterns where one would end up with too
aggressive meta-data allocation (e.g. when writing lots of directories
or XATTRS) and where not enough data block groups are left.

But the other way round?
If one writes very small files (so that they are inlined) -> meta-data
should grow.

If one writes non-inlined files, regardless of whether small or big...
shouldn't it always be clear how much space could be needed for csum
meta-data, when a new block group is allocated for data and if that
would be fully written?


> In theory if the average file size decreases drastically it can
> change
> the amount of metadata required and maybe require an increase in
> metadata ratio after the metadata has been allocated.

I cannot totally rule this out, but it's pretty unlikely.


> Another case happens when you suddenly start using a lot of reflinks
> when the filesystem is already completely allocated.

That I can rule out, we didn't make any snapshots or ref-copies.


> That's possible (and there are patches attempting to address it).
> We don't want to be too aggressive, or the disk fills up with unused
> metadata allocations...but we need to be about 5 block groups more
> aggressive than we are now to handle special cases like "mount and
> write until full without doing any backups or maintenance."

Wouldn't a "simple" (at least in my mind ;-) ) solution be, that:
- if the case arises, that either data or meta-data block groups are
  full
- and not unallocated space is left
- and if the other kind of block groups has plenty of free space left
  (say in total something like > 10 times the size of a block group...
  or maybe more (depending on the total filesystem size), cause one
  probably doesn't want to shuffle loads of data around, just for the
  last 0.005% to be squeezed out.)
then:
- btrfs automatically does the balance?
  Or maybe something "better" that also works when it would need to
  break up extents?

If there are cases where one doesn't like that automatic shuffling, one
could make it opt-in via some mount option.


> A couple more suggestions (more like exploitable side-effects):
> 
>         - Run regular scrubs.  If a write occurs to a block group
>         while it's being scrubbed, there's an extra metadata block
>         group allocation.

But writes during scrubs would only happen when it finds and corrupted
blocks?


Thanks,
Chris.
