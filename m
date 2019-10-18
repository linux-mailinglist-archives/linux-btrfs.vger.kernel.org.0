Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8D76DD3C8
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Oct 2019 00:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbfJRWUB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Oct 2019 18:20:01 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36234 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393759AbfJRWT7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Oct 2019 18:19:59 -0400
Received: by mail-ed1-f68.google.com with SMTP id h2so5746162edn.3
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Oct 2019 15:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7FjU9zX9vDsvrqNjczjsjF6JWilGS2I7ebztFSdcJlI=;
        b=hzwgtyP1tWv1zzRwAxgIR2tzrof0fZT4lhS3Oxgy7YwLtIubp101e24tH1AeQjzaJV
         Mr9RVKlAtsy9wBfVjZJly2UmqErb8qxmC9eCZqW1688GxiGmTzH7yT/VznWivrwKASSo
         e588y8lX82YSm/Rne6bwXDY2/Id6RUPLdLRW+xmZBjYrwGbYVjbhow+1gbLwyeqSbsJi
         VrpGddK8tWKKuNCQEs8Z6WZbEzV4PzHHarU34BWzC2dDTBrDCJhmFRfVqfatDcndSv4C
         +xhFLFhjSlp9hwaKMZITMIiZm9rSQ7iH1eY/jN45ggXTXViJzFbje3/4YXsBA7uelRpx
         tX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7FjU9zX9vDsvrqNjczjsjF6JWilGS2I7ebztFSdcJlI=;
        b=Qu4nZHjsADYBxEpBqe/yA9mJufoPHOcNzqZknXreD4J51h79q9KN8Yr4h8e+uzWdSn
         z/qEYLsP6ajxXlgyQevDw2R8SkPcx8gGL52pApzw5XDvP35UPM1Ovc2Xl2js9ddIAF2m
         8nNi/raqP1BuX0YiyClxNDt+Rnl4zsFv1EPyA4PTXacEsCsM8Qnyky+xZlN4HjtNNxyE
         qaZo+kNXKz/NSOkHkPfPuiqqU8aMRNEvYurgLXy9qNyeMQDED3XPEPQ6NLPha9ERnNKH
         CYbHwN0Q0UhH78PWJaAtWSTDEkdUgJjauQUC6lDCbBfiBtyl6apxO7A7KKG3uk09lpxy
         PTig==
X-Gm-Message-State: APjAAAWfi2oqxo+COqJg6lHLln0U76CTvtFzsN3WmTPRd/70xpUxRDEc
        zHE9GBV+IQ0kWtXNG4gSFDv314yetED6EVsg9q6SQgASotk=
X-Google-Smtp-Source: APXvYqxW+iHHUwD1ORvkNv+UiTYkfcxSi2wdeucfamxfJT8RmS8bG6FWJxdgIfMDe2G7tOAq5sOhtyymRG9KbtT1lwc=
X-Received: by 2002:aa7:df0d:: with SMTP id c13mr12017053edy.61.1571437196978;
 Fri, 18 Oct 2019 15:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <b665710c-5171-487b-ce38-5ea7075492e4@liland.com>
 <CACa3q1wUmgY9uTygYFVBer=QgZjtwX2NOvVT68kAYKAgoLpXRg@mail.gmail.com> <CAJCQCtR=NQd6uovvAhuTdxRNJtnMFDtkTma9u8-Ep9Nq+YQY=A@mail.gmail.com>
In-Reply-To: <CAJCQCtR=NQd6uovvAhuTdxRNJtnMFDtkTma9u8-Ep9Nq+YQY=A@mail.gmail.com>
From:   Supercilious Dude <supercilious.dude@gmail.com>
Date:   Fri, 18 Oct 2019 23:19:47 +0100
Message-ID: <CAGmvKk67D--TSRa-BMnoAEzMEaoDMS9MnVUgun_VEfPEfhT11A@mail.gmail.com>
Subject: Re: MD RAID 5/6 vs BTRFS RAID 5/6
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It would be be useful to have the ability to scrub only the metadata.
In many cases the data is so large that a full scrub is not feasible.
In my "little" test system of 34TB a full scrub takes many hours and
the IOPS saturate the disks to the extent that the volume is unusable
due to the high latencies. Ideally there would be a way to rate limit
the scrub operation I/Os so that it can happen in the background
without impacting the normal workload.


On Fri, 18 Oct 2019 at 21:38, Chris Murphy <lists@colorremedies.com> wrote:
>
> On Wed, Oct 16, 2019 at 10:07 PM Jon Ander MB <jonandermonleon@gmail.com> wrote:
> >
> > It would be interesting to know the pros and cons of this setup that
> > you are suggesting vs zfs.
> > +zfs detects and corrects bitrot (
> > http://www.zfsnas.com/2015/05/24/testing-bit-rot/ )
> > +zfs has working raid56
> > -modules out of kernel for license incompatibilities (a big minus)
> >
> > BTRFS can detect bitrot but... are we sure it can fix it? (can't seem
> > to find any conclusive doc about it right now)
>
> Yes. Active fixups with scrub since 3.19. Passive fixups since 4.12.
>
> > I'm one of those that is waiting for the write hole bug to be fixed in
> > order to use raid5 on my home setup. It's a shame it's taking so long.
>
> For what it's worth, the write hole is considered to be rare.
> https://lwn.net/Articles/665299/
>
> Further, the write hole means a) parity is corrupt or stale compared
> to data stripe elements which is caused by a crash or powerloss during
> writes, and b) subsequently there is a missing device or bad sector in
> the same stripe as the corrupt/stale parity stripe element. The effect
> of b) is that reconstruction from parity is necessary, and the effect
> of a) is that it's reconstructed incorrectly, thus corruption. But
> Btrfs detects this corruption, whether it's metadata or data. The
> corruption isn't propagated in any case. But it makes the filesystem
> fragile if this happens with metadata. Any parity stripe element
> staleness likely results in significantly bad reconstruction in this
> case, and just can't be worked around, even btrfs check probably can't
> fix it. If the write hole problem happens with data block group, then
> EIO. But the good news is that this isn't going to result in silent
> data or file system metadata corruption. For sure you'll know about
> it.
>
> This is why scrub after a crash or powerloss with raid56 is important,
> while the array is still whole (not degraded). The two problems with
> that are:
>
> a) the scrub isn't initiated automatically, nor is it obvious to the
> user it's necessary
> b) the scrub can take a long time, Btrfs has no partial scrubbing.
>
> Wheras mdadm arrays offer a write intent bitmap to know what blocks to
> partially scrub, and to trigger it automatically following a crash or
> powerloss.
>
> It seems Btrfs already has enough on-disk metadata to infer a
> functional equivalent to the write intent bitmap, via transid. Just
> scrub the last ~50 generations the next time it's mounted. Either do
> this every time a Btrfs raid56 is mounted. Or create some flag that
> allows Btrfs to know if the filesystem was not cleanly shutdown. It's
> possible 50 generations could be a lot of data, but since it's an
> online scrub triggered after mount, it wouldn't add much to mount
> times. I'm also picking 50 generations arbitrarily, there's no basis
> for that number.
>
> The above doesn't cover the case where partial stripe write (which
> leads to write hole problem), and a crash or powerloss, and at the
> same time one or more device failures. In that case there's no time
> for a partial scrub to fix the problem leading to the write hole. So
> even if the corruption is detected, it's too late to fix it. But at
> least an automatic partial scrub, even degraded, will mean the user
> would be flagged of the uncorrectable problem before they get too far
> along.
>
>
> --
> Chris Murphy
