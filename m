Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0AC646BEAD
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 16:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238439AbhLGPLY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 10:11:24 -0500
Received: from beige.elm.relay.mailchannels.net ([23.83.212.16]:3204 "EHLO
        beige.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238387AbhLGPLX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Dec 2021 10:11:23 -0500
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 7D6AA822081;
        Tue,  7 Dec 2021 15:07:48 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 08546821D8A;
        Tue,  7 Dec 2021 15:07:40 +0000 (UTC)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.97.65.145 (trex/6.4.3);
        Tue, 07 Dec 2021 15:07:48 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Spot-Reign: 4181f6ed58ea58d9_1638889668054_1900351620
X-MC-Loop-Signature: 1638889668054:545785664
X-MC-Ingress-Time: 1638889668054
Received: from p57b045ec.dip0.t-ipconnect.de ([87.176.69.236]:57124 helo=heisenberg.scientia.net)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <calestyo@scientia.org>)
        id 1muc48-0006tM-1S; Tue, 07 Dec 2021 15:07:38 +0000
Message-ID: <b913833639d11a0242f781d94452e5e31d7cbf1b.camel@scientia.org>
Subject: Re: ENOSPC while df shows 826.93GiB free
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Date:   Tue, 07 Dec 2021 16:07:32 +0100
In-Reply-To: <20211207072128.GL17148@hungrycats.org>
References: <f001f3e81d413ea290722c38b14d95f3f1f52249.camel@scientia.org>
         <25d305e5-c75f-3d71-fc5a-c2019e49bed9@gmx.com>
         <c64be50bdc99b993b910a7ab019af8d552eeb0d4.camel@scientia.org>
         <b7b6a6a7-700e-f83d-dae6-581ed6befbef@gmx.com>
         <3239b2307fae4c7f9e8be9f194d5f3ef470ddb8c.camel@scientia.org>
         <20211207072128.GL17148@hungrycats.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 2021-12-07 at 02:21 -0500, Zygo Blaxell wrote:
> If you minimally balance data (so that you keep 2GB unallocated at
> all
> times) then it works much better: you can allocate the last metadata
> chunk that you need to expand, and it requires only a few minutes of
> IO
> per day.  After a while you don't need to do this any more, as a
> large
> buffer of allocated but unused metadata will form.

Hm I've already asked Qu in the other mail just before, whether/why
balancing would help there at all.

Doesn't it just re-write the block groups (but not defragment them...)
would that (and why) help to gain back unallocated space (which could
then be allocated for meta-data)?

And what exactly do you mean with "minimally"? I mean of course I can
use -dusage=20 or so... is it that?


But I guess all that wouldn't help now, when the unallocated space is
already used up, right?



> If you need a drastic intervention, you can mount with
> metadata_ratio=1
> for a short(!) time to allocate a lot of extra metadata block groups.
> Combine with a data block group balance for a few blocks (e.g. -
> dlimit=9).

All that seems rather impractical do to, to be honest. At least for an
non-expert admin.

First, these systems are production systems... so one doesn't want to
unmount (and do this procedure) when one sees that unallocated space
runs out.
One would rather want some way that if one sees: unallocated space gets
low -> allocate so and so much for meta data

I guess there are no real/official tools out there for such
surveillance? Like Nagios/Icinga checks, that look at the unallocated
space?



> You need about (3 + number_of_disks) GB of allocated but unused
> metadata
> block groups to handle the worst case (balance, scrub, and discard
> all
> active at the same time, plus the required free metadata space). 
> Also
> leave room for existing metadata to expand by about 50%, especially
> if
> you have snapshots.



> Never balance metadata.  Balancing metadata will erase existing
> metadata
> allocations, leading directly to this situation.

Wouldn't that only unallocated such allocations, that are completely
empty?

> > So if csum data needs so much space... why can't it simply reserve
> > e.g. 60 GB for metadata instead of just 17 GB?
> 
> It normally does.  Are you:
> 
>         - running metadata balances?  (Stop immediately.)

Nope, I did once accidentally (-musage=0 ... copy&pasted the wrong one)
but only *after* the filesystem got stuck...


>         - preallocating large files?  Checksums are allocated later,
> and
>         naive usage of prealloc burns metadata space due to
> fragmentation.

Hmm... not so sure about that... (I mean I don't know what the storage
middleware, which is www.dcache.org, does)... but it would probably do
this only for 1 to few such large files at once, if at all.


>         - modifying snapshots?  Metadata size increases with each
>         modified snapshot.

No snapshots are used at all on these filesystems.


>         - replacing large files with a lot of very small ones?  Files
>         below 2K are stored in metadata.  max_inline=0 disables this.

I guess you mean here:
First many large files were written... unallocated space is used up
(with data and meta-data block groups).
Then, large files are deleted... data block groups get fragmented (but
not unallocated acagain, because they're not empty.

Then loads of small files would be written (inline)... which then fails
as meta-data space would fill up even faster, right?


Well we do have filesystems, where there may be *many* small files..
but I guess still all around the range of 1MB or more. I don't think we
have lots of files below 2K.. if at all.


So I don't think that we have this IO pattern.

It rather seems simply as if btrfs wouldn't reserve meta-data
aggressively enough (at least not in our case)... and that to much is
allocated for data.. and when that is actually filled, it cannot
allocate anymore enough for metadata.



Thanks,
Chris.
