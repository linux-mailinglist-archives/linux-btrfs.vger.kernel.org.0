Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B903824202A
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 21:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgHKTSP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 15:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgHKTSP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 15:18:15 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFBCC06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 12:18:14 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id x5so3560005wmi.2
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 12:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cm4GYzj31Vb5mZqK2sFHSgXVBOjK40Kr6hrzIqIMNQ4=;
        b=u3ebswhZFSz4gg6i1mFzU2jPAXxE+0XACEwxpM5JL+c4dFR06v8+WQituIs70TAKMt
         qF/kdSCcE/JJmOqx4i+Pd3pBl0FKPqPioYkOBfUwtH63ZDD06x/LLN/vu846yvDiq3Al
         2NicWTjL2Dt+ALRW/DRO7CjDf0k+VjI5GHy8PmZBg/eTKVtkpMjfjleJOoWOcsw9cxfC
         S4AtiUbh7Vbpfwc/wMAsHyAqeGmluFKTizYemOVWSmMhYsMwpKal+FWA8mAZtuIA5XwF
         x88AeiI4KjfY+R2CEzdPkIpHXd2D9CP6BfdYK4BbHt4/APw/fiaHoUaudAT89iEo0MT+
         nwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cm4GYzj31Vb5mZqK2sFHSgXVBOjK40Kr6hrzIqIMNQ4=;
        b=flCvUFjrI1QJLpUGx0u3yx/cxu0NVOnqxPiqNLUWJS31cnfIx2yM31yXZs6JIHfjWq
         oEqYWqWW3/i9j3tuaAvUsNWLGN6QyO4mVAyVTl+s0sKZcgdwIUWIF2+qK+gI79fZitQY
         Ga4dJPgb8MBuDK4SY+JFSwWoq6RVy7kpLcEfFAniGv1n0FRM6YAyhyizveedrLnnfC2b
         mpk6fxs6jtanEp2ria61c8a+fI3HDU1w08ujm+wYC4L8BpRhrDyXPTS5ZJ7zBGjqtZul
         mf6bs37pgVjPupTDQ649rVe8MH+0mr2oPk7lJcX65qGGrpLDH5x+ybwjUqNJqrVykeDP
         6ggA==
X-Gm-Message-State: AOAM533IxHWIUSkDU4z70JD8DFnAOHCtpOOIBh1OxPpk/PMlTxhTB0mM
        sNI/q30tIK/2sXm0v1szT4Lfhd+LtFUi6EUxxGP4lZLKgYU=
X-Google-Smtp-Source: ABdhPJwuCDlmG/YCzfoGxOg8WPgpdLU9XAoKqX1VIJHK9DMcqCtfDbQqWpa3UCeqfjfteO20rJqIp2Xa7Zkfx4oA3CY=
X-Received: by 2002:a1c:e0c2:: with SMTP id x185mr5171658wmg.124.1597173493563;
 Tue, 11 Aug 2020 12:18:13 -0700 (PDT)
MIME-Version: 1.0
References: <3dc4d28e81b3336311c979bda35ceb87b9645606.camel@dallalba.com.ar>
 <CAJCQCtReHKtyjHL2SXZXeZ4TwdXf-Ag2KysSS0Oan5ZDMzm8OQ@mail.gmail.com> <dc0bea2ee916ce4d1a53fe59869b7b7d8868f617.camel@dallalba.com.ar>
In-Reply-To: <dc0bea2ee916ce4d1a53fe59869b7b7d8868f617.camel@dallalba.com.ar>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 11 Aug 2020 13:17:44 -0600
Message-ID: <CAJCQCtSdJVw5o2hJ3OyE6-nvM2xpx=nRHLVNSgf9ydD2O--vMQ@mail.gmail.com>
Subject: Re: raid10 corruption while removing failing disk
To:     =?UTF-8?Q?Agust=C3=ADn_Dall=CA=BCAlba?= <agustin@dallalba.com.ar>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 10, 2020 at 11:06 PM Agust=C3=ADn Dall=CA=BCAlba
<agustin@dallalba.com.ar> wrote:
>
> On Mon, 2020-08-10 at 20:34 -0600, Chris Murphy wrote:
> > On Mon, Aug 10, 2020 at 1:03 AM Agust=C3=ADn Dall=CA=BCAlba
> > <agustin@dallalba.com.ar> wrote:
> > > Hello!
> > >
> > > The last quarterly scrub on our btrfs filesystem found a few bad
> > > sectors in one of its devices (/dev/sdd), and because there's nobody =
on
> > > site to replace the failing disk I decided to remove it from the arra=
y
> > > with `btrfs device remove` before the problem could get worse.
> >
> > It doesn't much matter if it gets worse, because you still have
> > redundancy on that dying drive until the moment it's completely toast.
> > And btrfs doesn't care if it's spewing read errors.
>
> By 'get worse', I mean another drive failing, and then we'd definitely
> lose data. Because of the pandemic there was (and still is) nobody on
> site to replace the drive, and I won't be able to go there for who
> knows how many months.

Fair point.

> I have a _partial_ dmesg of this time period. It's got a lot of gaps in
> between reboots. I'll send it to you without ccing the list. The
> failing drive is an atrocious WD green for which I forgot to set the
> idle3 timer, that doesn't support SCT ERC and lately just hangs forever
> and requires a power cycle. So there's no way around the slowness. It
> was added on a pinch a year ago because we needed more space. I
> probably should have ask someone to disconnect it and used 'remove
> missing'.

That drive should have '/sys/block/sda/device/timeout' at least 120.
Although I've seen folks on linux-raid@ suggest 180. I don't know what
the actual maximum time for "deep recovery" these drives could have.

As the signal in a sector weakens, the reads get slower. You can
freshen the signal simply by rewriting data. Btrfs doesn't ever do
overwrites, but you can use 'btrfs balance' for this task. Once a year
seems reasonable, or as you notice reads becoming slower. And use a
filtered balance to avoid doing it all at once.


>
> > > # btrfs check --force --readonly /dev/sda
> > > WARNING: filesystem mounted, continuing because of --force
> > > Checking filesystem on /dev/sda
> > > UUID: 4d3acf20-d408-49ab-b0a6-182396a9f27c
> > > checksum verify failed on 10919566688256 found BAB1746E wanted A8A482=
66
> > > checksum verify failed on 10919566688256 found BAB1746E wanted A8A482=
66
> >
> > So they aren't at all the same, that's unexpected.
>
> What do you mean by this?

I only fully understood what you meant by this:
>instead of `found BAB1746E wanted A8A48266` it prints `found 0000006E want=
ed 00000066`

once I re-read the first email that had the full 'btrfs check' output
from the old version. And yeah I don't know why they're different now.


> > My advice is to mount ro, backup (or two copies for important info),
> > and start with a new Btrfs file system and restore. It's not worth
> > repairing.
>
> Sigh, I was expecting I'd have to do this. At least no data was lost,
> and the system still functions even though it's read-only. Do you think
> check --repair is not worth trying? Everything of value is already
> backed up, but restoring it would take many hours of work.

Metadata, RAID10: total=3D9.00GiB, used=3D7.57GiB

Ballpark 8 hours for --repair given metadata size and spinning drives.
It'll add some time adding --init-extent-tree which... is decently
likely to be needed here. So the gotcha is, see if --repair works, and
it fixes some stuff but still needs extent tree repaired anyway. Now
you have to do that and it could be another 8 hours. Or do you go with
the heavy hammer right away to save time and do both at once? But the
heavy hammer is riskier.

Whether repair or start over, you need to have the backup plus 2x for
important stuff. To do the repair you need to be prepared for the
possibility tihngs get worse. I'll argue strongly that it's a bug if
things get worse (i.e. now you can't mount ro at all) but as a risk
assessment, it has to be considered.


--
Chris Murphy
