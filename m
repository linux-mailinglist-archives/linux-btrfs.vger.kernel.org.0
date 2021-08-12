Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296FA3EA4E2
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Aug 2021 14:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237191AbhHLMtm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Aug 2021 08:49:42 -0400
Received: from ciao.gmane.io ([116.202.254.214]:59574 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232200AbhHLMtm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Aug 2021 08:49:42 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Aug 2021 08:49:41 EDT
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcfb-btrfs-devel-moved1-3@m.gmane-mx.org>)
        id 1mEA4A-000A38-Ke
        for linux-btrfs@vger.kernel.org; Thu, 12 Aug 2021 14:44:10 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-btrfs@vger.kernel.org
From:   Duncan <1i5t5.duncan@cox.net>
Subject: Re: Corruption errors on Samsung 980 Pro
Date:   Thu, 12 Aug 2021 12:44:06 -0000 (UTC)
Message-ID: <pan$d7160$be118b91$75073519$60595d6a@cox.net>
References: <2729231.WZja5ltl65@ananda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
User-Agent: Pan/0.147 (Sweet Solitude; 77d1c18ae)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Martin Steigerwald posted on Fri, 16 Jul 2021 17:05:59 +0200 as excerpted:

> (both Baloo and Akonadi have very crazy I/O patterns

OK so this is OT for this list (tho there's an on-topic remark below), 
but as another kde user, this is one of my hotbuttons, FWIW...

I've always considered both baloo and akonadi more trouble than they're 
worth, and at quite some personal hassle and trouble switched off of both 
them -- they're now blacklisted and won't touch my machines!

Akonadi is of course used by kdepim-based applications, including both 
kmail and akregator, which I previously used.  These days I use claws-
mail for both (tho I prefer them separate so I run two instances, one for 
mail, another as my feed-reader, with a different HOME and TMPDIR set to 
avoid interfering with the first one).  Quite a shame really, as pre-
akonadi I was really happy with kmail, which I had used since I switched 
from MS back at the turn of the century, and wasn't /unhappy/ with 
akregator either.  Ironically I had chosen kmail over (then) sylpheed 
claws back then.  Had that choice gone the other direction I'd have never 
had to hassle with getting off of kmail.  Oh, well...

As for baloo, luckily I run gentoo, and thus have USE=-semantic-desktop 
to turn it off at build-time.  For a couple years the gentoo/kde folks 
did try to force it on (did away with the semantic-desktop flag as an 
option), but I was able to continue carrying the necessary patches to 
turn it off locally.  Eventually they switched back to supporting the 
semantic-desktop flag and I was able to drop my local patches.

If they hadn't or if kde had ultimately forced semantic-desktop upstream, 
I'd have almost certainly found some other desktop to use, because in my 
experience it's simply not worth its cost in lost system performance and 
stability, and I won't have it on my system, at least beyond some minimal 
transitional upgrade period until I can find an alternative solution.

> It is BTRFS single profile on LVM on LUKS. Mount options are:
> 
> rw,relatime,lazytime,compress=zstd:3,
> ssd,space_cache=v2,subvolid=1054,subvol=/home

Unless you have a known reason not to, I'd strongly suggest switching 
from relatime to noatime, tho lazytime does mitigate the problem 
somewhat.  Here I actually carry a kernel patch that switches the default 
to noatime (from relatime).

Once noatime is set the need for lazytime decreases and I actually prefer 
having ctime/mtime synced to storage here, tho for file-rewrite-in-place 
heavy workloads like databases and vm-images it's still going to cut down 
on inode rewrite churn quite a bit, and I'd consider keeping it both in 
that case and if you're making use of btrfs snapshotting at under 24-hour 
intervals.

And if you /do/ need atime for something I'd consider putting the files 
that need it on a different filesystem where atime updates aren't so 
expensive.  Altho of course multi-partitioning in ordered to have 
multiple filesystems isn't entirely hassle-free either, so there's a 
tradeoff.

-- 
Duncan - List replies preferred.   No HTML msgs.
"Every nonfree program has a lord, a master --
and if you use the program, he is your master."  Richard Stallman

