Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B56E302007
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jan 2021 02:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbhAYBuK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Jan 2021 20:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbhAYBuF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Jan 2021 20:50:05 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C941C061574
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Jan 2021 17:41:51 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id f1so5618609lfu.3
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Jan 2021 17:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X3lwaq+cuPq9aFZYoFrdILVD0KLTusX8jmhGeq2dJik=;
        b=Ia6vb1rdmgpctFD5fkAsNiNE7ZSFCtMFo/obFjEbsSUP3MpSds+9MyEBJkL27TG25M
         TMw62IctpJCnW4ocG44i/2pK4Mh5kyqTlQK4O7bEg92HgaPmsNwGRdDAWeYxUZvaTCRO
         ZJvi5+lZBtwr0fLs3RR8/JAgP01jRozFXZUGFJrt03Xu+wJfSmGQyYNlhouR7ABYBy6o
         G6NCpsmSzi55eVlqUbz58fOzLBSvWZJL45RCPG/fuBgGQzxkSzNPJZy1okWARiDYspkA
         kBoKofquv+HVYe3NWsLlvsFBUg12cz9zglAP49H1sgEg/msV+7excr44iyWdAcHfsVpr
         Mdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X3lwaq+cuPq9aFZYoFrdILVD0KLTusX8jmhGeq2dJik=;
        b=rEuaqnaDde9NRtcMe1hd4DVohePQOgcHCgVFvV9s9G7lmQ9GukNoiWjfIRXqo5zDQp
         stpyWcvYwrJi4QSt10HnY/2z9BxrMV1vqx9F8+IaxiiuXmYtEGuLdOu2KpkCkuyvPC1u
         fcOV1SKZOeWNUrRFqUgtVtRRsEKZTsSIm/T+RqKhQZL2PdZSbB2muXZzPMW1+2X2YhqH
         3lIv1z6qL6mXQfPifEezi4Scok83E1eJrB8MuYrz9XF3+9iPw4WaznPRohRvcNgjdvZD
         3oLLZRfjnKhHNO7U3+SvojcHpIKNgQkwGGuWly5n4ug3lVMgrkhVOTFdnu4uuir6ha6Z
         743g==
X-Gm-Message-State: AOAM531NjT6x8MUdwYthlo/MHEI9m/7kqxyQvlsn9k1pNJum7r1CD0qT
        IlyOILfrCEZLvs0gAFnOfJgxThVbARaB1++HN5APmm46RKg=
X-Google-Smtp-Source: ABdhPJyDwNmatbqog8aPDn4zpNbdP5wXQzcqSOhdMqcy4yGfA7jHfAaE7c4xYVP6oPwthYxL1Dk62elYYBx+9F/7cMk=
X-Received: by 2002:a05:6512:94f:: with SMTP id u15mr426607lft.389.1611538909804;
 Sun, 24 Jan 2021 17:41:49 -0800 (PST)
MIME-Version: 1.0
References: <CAD6NJSxNmWQ42HrC5oUyZtS+MgEn7b=kmV46qx40x9=v6SMwAA@mail.gmail.com>
 <20210123172743.GP31381@hungrycats.org>
In-Reply-To: <20210123172743.GP31381@hungrycats.org>
From:   =?UTF-8?Q?H=C3=A9rikz_Nawarro?= <herikz.nawarro@gmail.com>
Date:   Sun, 24 Jan 2021 22:41:38 -0300
Message-ID: <CAD6NJSwMQFx1Mf=w+Vsj=RNNEUKfMHFFscDQ+Ty9Lu-wH6hB2Q@mail.gmail.com>
Subject: Re: Recover data from damage disk in "array"
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> OK, that's weird.  Multiple disks should always have metadata in a raid1*
> profile (raid1, raid10, raid1c3, or raid1c4).  dup metadata on multiple
> disks, especially spinners, is going to be slow and brittle with no
> upside.

I didn't know about this.

> There are other ways to do this, but they take longer, in some cases
> orders of magnitude longer (and therefore higher risk):
>
> 1.  convert the metadata to raid1, starting with the faulty drive
> (in these examples I'm just going to call it device 3, use the
> correct device ID for your array):
>
>        # Remove metadata from broken device first
>        btrfs balance start -mdevid=3D3,convert=3Draid1,soft /array
>
>        # Continue converting all other metadata in the array:
>        btrfs balance start -mconvert=3Draid1,soft /array
>
> After metadata is converted to raid1, an intermittent drive connection is
> a much more recoverable problem, and you can replace the broken disk at
> your leisure.  You'll get csum and IO errors when the drive disconnects,
> but these errors will not be fatal to the filesystem as a whole because
> the metadata will be safely written on other devices.
>
> 2.  convert the metadata to raid1 as in option 1, then delete the missing
> device.  This is by far the slowest option, and only works if you have
> sufficient space on the other drives for the new data.
>
> 3.  convert the metadata to raid1 as in option 1, add more disks so that
> there is enough space for the device delete in option 2, then proceed
> with the device delete in option 2.  This is probably worse than option
> 2 in terms of potential failure modes, but I put it here for completeness=
.
>
> 4.  when the replacement disk arrives, run 'btrfs replace' from the broke=
n
> disk to the new disk, then convert the metadata to raid1 as in option 1
> so you're not using dup metadata any more.  This is as fast as the 'dd'
> solution, but there is a slightly higher risk as the broken disk might
> disconnect during a write and abort the replace operation.

Thanks for the options, i'll try soon.


Em s=C3=A1b., 23 de jan. de 2021 =C3=A0s 14:27, Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> escreveu:
>
> On Mon, Jan 18, 2021 at 09:00:58PM -0300, H=C3=A9rikz Nawarro wrote:
> > Hello everyone,
> >
> > I got an array of 4 disks with btrfs configured with data single and
> > metadata dup
>
> OK, that's weird.  Multiple disks should always have metadata in a raid1*
> profile (raid1, raid10, raid1c3, or raid1c4).  dup metadata on multiple
> disks, especially spinners, is going to be slow and brittle with no
> upside.
>
> > , one disk of this array was plugged with a bad sata cable
> > that broke the plastic part of the data port (the pins still intact),
> > i still can read the disk with an adapter, but there's a way to
> > "isolate" this disk, recover all data and later replace the fault disk
> > in the array with a new one?
>
> There's no redundancy in this array, so you will have to keep the broken
> disk online (or the filesystem unmounted) until a solution is implemented=
.
>
> I wouldn't advise running with a broken connector at all, especially
> without raid1 metadata.
>
> Ideally, boot from rescue media, copy the broken device to a replacement
> disk with dd, then remove the broken disk and mount the filesystem with
> 4 healthy disks.
>
> If you try to operate with a broken connector, you could get disconnects
> and lost writes.  With dup metadata there is no redundancy across
> drives, so a lost metadata write on a single disk is a fatal error.
> That will be a stress-test for btrfs's lost write detection, and even
> if it works, it will force the filesystem read-only whenever it occurs
> in a metadata write.  In the worst case, the disconnection resets the
> drive and prevents its write cache from working properly, so a write is
> lost in metadata, and the filesystem is unrecoverably damaged.
>
> There are other ways to do this, but they take longer, in some cases
> orders of magnitude longer (and therefore higher risk):
>
> 1.  convert the metadata to raid1, starting with the faulty drive
> (in these examples I'm just going to call it device 3, use the
> correct device ID for your array):
>
>         # Remove metadata from broken device first
>         btrfs balance start -mdevid=3D3,convert=3Draid1,soft /array
>
>         # Continue converting all other metadata in the array:
>         btrfs balance start -mconvert=3Draid1,soft /array
>
> After metadata is converted to raid1, an intermittent drive connection is
> a much more recoverable problem, and you can replace the broken disk at
> your leisure.  You'll get csum and IO errors when the drive disconnects,
> but these errors will not be fatal to the filesystem as a whole because
> the metadata will be safely written on other devices.
>
> 2.  convert the metadata to raid1 as in option 1, then delete the missing
> device.  This is by far the slowest option, and only works if you have
> sufficient space on the other drives for the new data.
>
> 3.  convert the metadata to raid1 as in option 1, add more disks so that
> there is enough space for the device delete in option 2, then proceed
> with the device delete in option 2.  This is probably worse than option
> 2 in terms of potential failure modes, but I put it here for completeness=
.
>
> 4.  when the replacement disk arrives, run 'btrfs replace' from the broke=
n
> disk to the new disk, then convert the metadata to raid1 as in option 1
> so you're not using dup metadata any more.  This is as fast as the 'dd'
> solution, but there is a slightly higher risk as the broken disk might
> disconnect during a write and abort the replace operation.
>
> > Cheers,
