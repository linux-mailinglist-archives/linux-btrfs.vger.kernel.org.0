Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34681407366
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Sep 2021 00:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbhIJWgQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Sep 2021 18:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhIJWgL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Sep 2021 18:36:11 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9679FC061574
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Sep 2021 15:34:59 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id x137so2980799vsx.1
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Sep 2021 15:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mAY2NbUwY1hhoUaKYJNq2HZPXPSg7YQRCWn2WDac6jw=;
        b=ImyzOA90R60D0W12anS6n7q1XzwdjS47aCxsUpoiBHTlveyiQP2xVBZI5Z+mA7Jogy
         pbC052/9Yimyw3/xq7hWitNwq9dWIWP/4UOGif5HMyJ/s47Q/529F4TtgN3KmQZA3EeC
         4EI6+CUVyA2a/alXSm4lkwbiyqDpHiXlH9NUTx99dxUMA6Ibpw0SmaEq9g07OjIgPflq
         DRPcXpFov//oKlHsIPgQIvDGwpY/4CLbYmjGmHxzcdJ/0y5RXdA/ucqR3fxrxNtFDKBo
         2INGDpn/77ZlC3zIrUHYz1TdzDeFo1G2oJkFoRaA6H2cVG0fCclP4QudSk8QlPpG5C6+
         Wrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mAY2NbUwY1hhoUaKYJNq2HZPXPSg7YQRCWn2WDac6jw=;
        b=flXBn7n6cVooSN7saZPiOk+iklAdym/j8QHy6knN95DeLimwlTtepAhHUZDoFf3Fmj
         sPa6ETps+MrEj3bpNqDIBLuq1zPhpaP8jtRXO9Yzurt/2LTYSoH68SQbffPZw1r1DF0r
         muFzEGZ/9z97vlJWX0IVmw2JXy+/AhKyjliYTgqVGrFYrI+Qj7Wc10E65lAAtCv/3Jiu
         WCpTX6eYHExuV5Vq+1RUu/k6E46u03pOsAZp/2B9Hb+uZ4v29tnrnPUT+UWl6RQnhsLZ
         EWkhiKW2mdWv4R6ClslvY8vX96os8lyDX2luLliKsyLGrAlbSqr6/+6Z/tdnQS2194rD
         IKbQ==
X-Gm-Message-State: AOAM532Fe9y+g4jJKa6I+u1nK2kIhGe0QvFq8h590ghXAovvorfiNVAc
        DJR/8xSP2acEfUYFhK7CGbpdCPwvGVabf0SkpG2B0L76xt38Kg==
X-Google-Smtp-Source: ABdhPJyoyYWzavQ4XeAweq3Nt0hZMYgHFY0K8kq/M4CX6JmSD2ot3MINAzNww7ai3PJYeX2zvB/DuTPLvKf1+R0LLeM=
X-Received: by 2002:a05:6102:282c:: with SMTP id ba12mr8262424vsb.56.1631313298611;
 Fri, 10 Sep 2021 15:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAH5Ym4h9ffTSx_EuBOvfkCkagf5QHLOM1wBzBukAACCVwNxj0g@mail.gmail.com>
 <CAH5Ym4i25_VsQZoy5_gURuUJiNZGQM84aWqn5YJuQxtXW+DAgg@mail.gmail.com>
 <aed0ec2b-3fe0-3574-b7e5-24f2e3da27ce@gmx.com> <CAH5Ym4gd7UhT=cSAjb-zMQ3baU08+SzKnGmXmAVD_8FdhzqF9w@mail.gmail.com>
 <c9c46006-32d3-7de7-bd0b-ff7380c684e6@gmx.com>
In-Reply-To: <c9c46006-32d3-7de7-bd0b-ff7380c684e6@gmx.com>
From:   Sam Edwards <cfsworks@gmail.com>
Date:   Fri, 10 Sep 2021 16:34:47 -0600
Message-ID: <CAH5Ym4gZgGLuL8svHLmOaqACLfQJpXCGLmfP3bK0NCic9E_LdQ@mail.gmail.com>
Subject: Re: Corruption suspiciously soon after upgrade to 5.14.1; filesystem
 less than 5 weeks old
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 10, 2021 at 2:31 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
> If you have hit read-only problem, then it's definitely btrfs' problem,
> and we're very interesting to see what's the cause.

I'm in full agreement that RO is a sign of a malfunction; but I was
saying that the malfunction may be deeper in the stack, meaning the RO
is not necessarily due to a design/implementation error in btrfs, but
is rather the only sensible course of action when faced with certain
circumstances outside of its control.

> Checksum error doesn't sound correct. Can be another indication of
> missing writes.
>
> But this also means, the corruption is even older.

Here is the checksum error (the very first indication of something
amiss on the day in question):
BTRFS warning (device dm-0): checksum verify failed on 1065332064256
wanted 0x04ca393a found 0xd5f0b823 level 0
BTRFS error (device dm-0): parent transid verify failed on
1065332064256 wanted 66552 found 66543

Since it's coupled directly with a transid mismatch, I think this just
means the csum tree is current while the node is not. That is,
0x04ca393a is the correct checksum for generation 66552 of leaf
1065332064256, but that generation has gone missing and instead we
find generation 66543, which has checksum 0xd5f0b823.

> As long as you don't do forced shutdown, nor btrfs check --repair, the
> v1 cache should not mismatch.

I have never even heard of btrfs check --repair until this incident (a
testament to btrfs's general durability).

I checked and both shutdowns immediately before the "has wrong amount
of free space" warnings were clean. On the 10th, there was an unclean
shutdown a little earlier in the day - there may have been some
leftover issues from that.

> This is too crazy that I can't even imagine what could survive.
>
> [...]
>
> But to me, this is really too crazy...

It is a contrived idea, yes. :)

But the subject it explores is relevant: how btrfs would react to a
slice of an active partition spontaneously reverting to the data it
held several minutes prior.

That is, a "missing writes" problem where the writes don't go missing
until a few minutes *after* they succeed.

> The final protection is the logical bytenr, where btrfs can map its
> chunks at any logical bytenr, thus even at the same physical location,
> they can have different logical bytenr.

THIS is an interesting lead. Until this point I had been interpreting
bytenr as a physical partition offset. Now that I've learned about the
chunk tree, I found that all missing writes were to chunk
1065173909504.

That chunk has a physical offset of 999675658240. So, there is exactly
a 61 GiB difference between bytenr and partition offset. (This seems
to be true of the neighboring chunks as well, and as that's a nice
round number, I think this is the correct offset.)

However, if the physical offset were to change momentarily (i.e. for a
few minutes), then writes to that chunk would end up diverted to some
other location on disk. Once the physical offset changes back, the
chunk will appear to revert back to the same data it held a few
minutes prior. In effect, causing the "retroactive missing writes"
phenomenon I'm seeing.

This would also leave behind evidence, in that the missing writes
would have to have gone *somewhere* on disk, and as long as they
weren't overwritten, I can track them down by scanning the whole disk
for tree nodes with the proper bytenr/transid. I think I'll spend some
time today trying to do that, as that would confirm this idea.

The only remaining question is why the physical offset would have
changed for only a few minutes. I didn't do a rebalance, although I
think I was running low on available space around the time, so maybe
btrfs was making some last-minute adjustments to the chunk tree to
compensate for that? The transid of the chunk tree node describing
this chunk is 58325, which is well before the problems started
happening. Perhaps the chunk tree was updated in-memory, used for
physical writes, but then reverted? Does this sound like something
btrfs might do?

Or maybe a cosmic ray flipped a bit in the in-memory copy of the
physical offset of the chunk. Unlikely, but possible. :)

> I'd say, there is no way to repair.
> Only data salvage is possible for generic transid mismatch.

Bah. Well, not a problem -- but that will take me a fair amount of
time. I'll want to investigate this and figure out what went wrong
*before* I go through the trouble of recreating my filesystem. I don't
want to spend a day restoring backups only to have the same problem
happen again a week later.

> >
> > Or is the whole a sudden power loss, nor do any btrfs check --repair between, the "wrong amount of free space" warning is already an indicator of something FUBAR at this point and I should just zero the
> > partition and restore from backups?
>
> I guess so.
>
> The repair for transid is never ensured to be safe, as core btrfs
> mechanism is already broken.
>
> Thanks,
> Qu
>
> >
> > Thank you for your time,
> > Sam
> >
> >> Thanks,
> >> Qu
> >>
> >>>
> >>> Cheers,
> >>> Sam
> >>>
> >>>
> >>> On Wed, Sep 8, 2021 at 6:47 PM Sam Edwards <cfsworks@gmail.com> wrote:
> >>>>
> >>>> Hello list,
> >>>>
> >>>> First, I should say that there's no urgency here on my part.
> >>>> Everything important is very well backed up, and even the
> >>>> "unimportant" files (various configs) seem readable. I imaged the
> >>>> partition without even attempting a repair. Normally, my inclination
> >>>> would be to shrug this off and recreate the filesystem.
> >>>>
> >>>> However, I'd like to help investigate the root cause, because:
> >>>> 1. This happened suspiciously soon (see my timeline in the link below)
> >>>> after upgrading to kernel 5.14.1, so may be a serious regression.
> >>>> 2. The filesystem was created less than 5 weeks ago, so the possible
> >>>> causes are relatively few.
> >>>> 3. My last successful btrfs scrub was just before upgrading to 5.14.1,
> >>>> hopefully narrowing possible root causes even more.
> >>>> 4. I have imaged the partition and am thus willing to attempt risky
> >>>> experimental repairs. (Mostly for the sake of reporting if they work.)
> >>>>
> >>>> Disk setup: NVMe SSD, GPT partition, dm-crypt, btrfs as root fs (no LVM)
> >>>> OS: Gentoo
> >>>> Earliest kernel ever used: 5.10.52-gentoo
> >>>> First kernel version used for "real" usage: 5.13.8
> >>>> Relevant information: See my Gist,
> >>>> https://gist.github.com/CFSworks/650280371fc266b2712d02aa2f4c24e8
> >>>> Misc. notes: I have run "fstrim /" on occasion, but don't have
> >>>> discards enabled automatically. I doubt TRIM is the culprit, but I
> >>>> can't rule it out.
> >>>>
> >>>> My primary hypothesis is that there's some write bug in Linux 5.14.1.
> >>>> I installed some package updates right before btrfs detected the
> >>>> problem, and most of the files in the `btrfs check` output look like
> >>>> they were created as part of those updates.
> >>>>
> >>>> My secondary hypothesis is that creating and/or using the swapfile
> >>>> caused some kind of silent corruption that didn't become a detectable
> >>>> issue until several further writes later.
> >>>>
> >>>> Let me know if there's anything else I should try/provide!
> >>>>
> >>>> Regards,
> >>>> Sam
