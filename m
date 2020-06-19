Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEFA4200603
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jun 2020 12:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732276AbgFSKH2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Jun 2020 06:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732048AbgFSKHX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Jun 2020 06:07:23 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914BDC06174E
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Jun 2020 03:07:23 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id dr13so9589936ejc.3
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Jun 2020 03:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kJki3F3uFplINFLRVxtYkIcQdfNvKAruqVYKU7CNbpQ=;
        b=Idj4fMCdfsXcqfQjbPL9v/Umfp/nXxWU9afoxupdKLkw64Mv0B/z+XDi1aUP2DKbob
         CyLchA/aCRrnEjVRmP9dF2ZAaIjPaNRlLleJzDguhkXgwiXJ3Uq+eWLoCXW9xCCjCDRc
         S8FlFD/21f9SWWUxJ2lKafwsjqCmmJ1U3AGf9aBM3zisKgybFbFH0ZtiZKhd2mRW4SO1
         6FJ6LYA44pkuygSoS3wd+5+cVFM5kOK+mU5QVP7PanOdbuSOi1iWi/jP/VlSOU+FmJHO
         uq/6yqtd8fUfNgUe+Cp04B1Ym7IJuztb28GXVYBe2U64CuuSwwCZqXrE3raso5gIdv1j
         x/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kJki3F3uFplINFLRVxtYkIcQdfNvKAruqVYKU7CNbpQ=;
        b=lrC5k6KdC41Du2gqlBgR4DhxMkInu6EELr7DDDcuzha9Sy1N4y4vMSQBcLjE5mTsxM
         pZjtlVMHlsDmsi5Gn/gBTaiPZDLavppmkONZbJj+aThOmWRSjBF06sJsYdl5Q/b0gdjx
         TywiBthS4IA29Vas2OLfbjfJkOeeBQ83DObQTywHZw/7936lDifLDeea0PYI1Y6+WCFM
         RdWamMskMj2c4eZ/DvSz+H79jpATb/yyZDwfLdkdHw1xWxpWGXrveePEghCzawfLkbp1
         vpPGSIlsisCinPcVt79TmaW6S3Q8IDlIi19G5pRaYVZNLxT/suPso3KBz/FbDAMQ+1AP
         ORjQ==
X-Gm-Message-State: AOAM533VP5IowcoR7CEvfXcCyWrL8vKuRCyFYZlwOqcc5rT85Bcx4JMI
        oYaaQEbfELwOOxbvm8/IF0MYiSM6RdS3bMfARB1CQu4r
X-Google-Smtp-Source: ABdhPJx33ioJgmsvrs8dPcGNHn9oKyR7WiRpSc0z3srGyyYZM0ho8fj1x7cXkO6E6kDm4EXp1IhXRmoDPV2ShGxx7i8=
X-Received: by 2002:a17:906:148b:: with SMTP id x11mr3041311ejc.282.1592561242165;
 Fri, 19 Jun 2020 03:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAHnuAezOHbwpuVM6=bJRRtORpdHy=rVPFD+jeAQVz3xUTEsUpQ@mail.gmail.com>
 <20200619124505.586f2b63@natsu> <CAHnuAez0+4LR=Z=+z-bFFj2Z=Jf24YCHZ3CjHGwgsSn8mZU1eA@mail.gmail.com>
 <20200619143148.1ec669e9@natsu>
In-Reply-To: <20200619143148.1ec669e9@natsu>
From:   Daniel Smedegaard Buus <danielbuus@gmail.com>
Date:   Fri, 19 Jun 2020 12:06:45 +0200
Message-ID: <CAHnuAexb-p=xbX5YzSCCv4faeLL-5Q=k1roUpeo6SSCRMZnhTw@mail.gmail.com>
Subject: Re: Behavior after encountering bad block
To:     Roman Mamedov <rm@romanrm.net>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 19 Jun 2020 at 11:31, Roman Mamedov <rm@romanrm.net> wrote:
>
> On Fri, 19 Jun 2020 10:08:43 +0200
> Daniel Smedegaard Buus <danielbuus@gmail.com> wrote:
>
> > Well, that's why I wrote having the *data* go bad, not the drive
>
> But data going bad wouldn't pass unnoticed like that (with reads resultin=
g in
> bad data), since drives have end-to-end CRC checking, including on-disk a=
nd
> through the SATA interface. If data on-disk is somehow corrupted, that wi=
ll be
> a CRC failure on read, and still an I/O error for the host.
>
> I only heard of some bad SSDs (SiliconMotion-based) returning corrupted d=
ata
> as if nothing happened, and only when their flash lifespan is close to
> depletion.
>
> > even though either scenario should still effectively end up yielding th=
e
> > same behavior from btrfs
>
> I believe that's also an assumption you'd want to test, if you want to be
> through in verifying its behavior on failures or corruptions. And anyways=
 it's
> better to set up a scenario which is as close as possible to ones you'd g=
et in
> real-life.
>

All good and valid points =E2=80=94 but only presupposing that each piece i=
s
behaving as advertised. For instance, a few years back, I discovered
that some sort of bug allowed my SiI PMP/SATA combo to randomly read
or write data incorrectly at a staggering rate when running at SATA 2
speeds under Linux, with no IO errors, and thus no warnings anywhere.
I was running a zpool on the disks attached to it, and ZFS silently
just kept retrying reads =E2=80=94 and writes as well, as it read back and
verified written data as well =E2=80=94 and thus I lost no data on that
occasion, simply because I was using a data checksumming filesystem.
There's a record of me seeking help about it somewhere on the
interwebs, probably in a Ubuntu forum, and I plugged a hole in the
data destruction by forcing the controllers to run at SATA 1 speeds
only.

At present, I have an old Macbook Pro that is occasionally
experiencing rotted SSD blocks, silently as well. I've discovered it
two or three times. Perhaps due to it having been dropped quite a few
times, or because of what appeared to be a bit of humidity damage
around the SSD socket (I was given it for free, because it wouldn't
recognize its SSD any longer, and thus not boot).

Also at present, I've experienced that the M2 socket in my Ryzen rig
on a B450 board will give garbage data, at least under multiple
kernels, but perhaps not all, for reasons I'm guessing might be a
buggy driver implementation, because I have experienced no issues with
it under Windows. I've just completely stopped accessing that drive
under Linux. Which is not an issue, because the SSD on that controller
is for my Windows gaming needs anyway.

And finally, again at present, I've seen silent data corruption on
that same rig, with ZFS as the underlying FS, but my suspicion is that
these are the result of overclocking the memory and stressing out the
system for very long stretches, producing par2 and rar files for my
archiving needs.

My point is, yes, the drive and/or controller should tell me if what's
being read back isn't what was once written, but my experience tells
me to never actually rely on this being the case, lest I may end up
with bad, unrecoverable data (had I been running md raid instead of
ZFS on that bad SiI rig, my entire data archive would have been
severely, silently, and irrevocably damaged at that point in time).
And the fact that ZFS and btrfs both implement checksumming underlines
the reality of that risk. Don't trust, check :)

To be fair, I'm not trying to "fix" any of the mentioned hardware
issues with ZFS or btrfs here. I just pick a data checksumming FS by
default when I can, and right now I'm using ZFS on a scratch disk and
getting fed up with the poor performance of ZFS, so I'm looking to use
btrfs instead, as my only need right here is data checksumming, and
AFAIR btrfs performs significantly better than ZFS. That's why I was
verifying that it does indeed have functional data checksumming :)

Cheers for the input!

Daniel :)

> With respect,
> Roman
