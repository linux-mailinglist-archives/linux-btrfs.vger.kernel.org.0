Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374BC2119FC
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 04:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgGBCOA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jul 2020 22:14:00 -0400
Received: from mail.nethype.de ([5.9.56.24]:41173 "EHLO mail.nethype.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbgGBCOA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Jul 2020 22:14:00 -0400
Received: from [10.0.0.5] (helo=doom.schmorp.de)
        by mail.nethype.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1jqojc-002EaY-4e; Thu, 02 Jul 2020 02:13:56 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
        by doom.schmorp.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1jqojc-0006lD-0b; Thu, 02 Jul 2020 02:13:56 +0000
Received: from root by cerebro.laendle with local (Exim 4.92)
        (envelope-from <root@schmorp.de>)
        id 1jqojc-0001xF-0D; Thu, 02 Jul 2020 04:13:56 +0200
Date:   Thu, 2 Jul 2020 04:13:55 +0200
From:   Marc Lehmann <schmorp@schmorp.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: first mount(s) after unclean shutdown always fail
Message-ID: <20200702021355.GA6648@schmorp.de>
References: <20200701005116.GA5478@schmorp.de>
 <36fcfc97-ce4c-cce8-ee96-b723a1b68ec7@gmx.com>
 <20200701201419.GB1889@schmorp.de>
 <cc42d4dc-b46f-7868-6a05-187949136eae@gmx.com>
 <20200701235512.GA3231@schmorp.de>
 <25e94ec6-842c-310f-e105-6d8f1e6dfdce@gmx.com>
 <20200702011134.GA5037@schmorp.de>
 <b0618fd7-e45f-a73b-a618-cd65cfa042df@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0618fd7-e45f-a73b-a618-cd65cfa042df@gmx.com>
OpenPGP: id=904ad2f81fb16978e7536f726dea2ba30bc39eb6;
 url=http://pgp.schmorp.de/schmorp-pgpkey.txt; preference=signencrypt
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 02, 2020 at 09:28:39AM +0800, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > explain that the mount fails, then succeeds, in the cases where the message
> > is _not_ logged, as reported?
> 
> When the error is logged, this snippet get triggered and abort mount.
> 
> And you have reported this at least happened once.

I reported that it sometimes happens, sometimes not.

> Then for that case, you should go btrfs rescue fix-device-size.

I have done this in the past, it doesn't fix the issue I reported.

Again, the problem is spurious mount failures, and *sometimes*,
*occasionally*, *not always*, I also get the super_total_bytes message,
but subsequent mount attempts succeed. Until the next crash.

> Nope, it get executed once and that specific problem will be gone.

Until one of the next unclean shutdowns, yes.

That specific problem is, of course, also going away by doing nothing, as
reported.

That command has no visible effect on the problem.

> As said, that's caused by some older kernel, newer kernel has extra safe
> net to ensure the accounting numbers are safe.

You haven't said that, but it's wrong either way: linux 5.4 and 5.6 are
NOT older than 4.11 - the code was introduced in 4.11, according to the
btrfs-rescue manpage, while the filesystem has never seen an older kernel
than 5.4, and the problem most recently happened with 5.6.

> > Spurious mount failures are a bug in the btrfs kernel driver.
> 
> Then report them as separate bugs.

That's what I did in the beginning of this thread. I can re-send a copy of
the mail, but that seems silly.

> The bugs of that message is well known and we have solution for a while.

And what is the solution? The problem clearly is still in linux 5.6.

> > The code proves only that you are wrong - the code _always_ prints the
> > message. Unless btrfs_super_total_bytes does more than just read some
> > data, it cannot explain the bug I reported, simply because the message is
> > not always produced, and the mount is not always aborted.
> 
> Solve one problem and go on to solve the next one.

Yup. The problem I reported is spurious mount errors after a crash.

> If you don't even bother the solution to that specific problem, you
> won't bother any debug procedure provided by any developer.

You haven't given me a solution to any problem I reported, you only made a
lot of provably wrong claims.

> > btrfs has problems, and I reported one, that's all that has happened.
> 
> You reported several problem

No, I only reported one problem, spurious mount failures.

> without proper reproducer.

Define "proper reproducer"? What's missing?

> You can reproduce it on your system is not a proper reproducer.

That's fine - but that's all I can do - reproduce it on my syytems,
because I don't have ay other systems to reproduce it on.

So in effect, what you are saying is that I cannot possibly provide a
"proper reproducer", while at the same time refusing to even think about a
btrfs bug because I didn't provide one.

Doesn't this strike you as farcical? Do you realise that it is impossible to
report bugs according to your standard?

> I provided one solution to one of your problems, you ignored and that's
> your problem.

No, you haven't. You provided something that you claim would fix it, but
it doesn't fix it, as pointed out multiple times.

> I don't see any point to debug any bugs reported by the one who doesn't
> even want to try a known solution but insists on whatever he believe is
> correct.

You have never provided a solution, of course.

> > I slowly get the distinct feeling that reporting bugs in btrfs us a futile
> > exercise, though.

What is wrong with this list? In the last decades I have reported dozens
of bugs in ext2/3/4, xfs and even udf. In all cases, filesystem developers
were open to fixing bugs and were interested in details. All except one
(which was a known but extremely rare bug) of the bugs I reported have
been fixed.

What is so different with btrfs that each time I report an actual bug, I get
attacked instead?

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\
