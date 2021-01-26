Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943DF304D34
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 00:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731705AbhAZXEo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 18:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbhAZEzK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jan 2021 23:55:10 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6909EC061788
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jan 2021 20:54:30 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id m187so1352242wme.2
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jan 2021 20:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rkjnsn-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=MPmCQXWKSTe1cJLnEO8jNShLQ8wkO39ZYX/ENh9wByE=;
        b=Pjm09QXfgTxtD9dCeDpreWDU3uecONSs3FmOSxy+kAPVdT9O4WRtUHtJ2cIYhLBdIV
         FWXESixfykdntFRuiKhaD3UZkTGC4uDrQfGc6WwoYIfIconl4gcvnQk+oG1rpJyFo8Ea
         sC+AqeqX2gBHX5L+2j4A2EZ+fpZB1qM2qWmlZjQF2s6DzFkPYsaXNDIncn4LIoF/sulk
         MSxI1V3F4jlb5h+S0vXxBFZ6E+LCb5dSHVNCeeu6ovRh9kGLsMEVRohhpQRDFf87vu36
         7kR3H+jZ6qeUnUd/9X9G4ECUrL+hrtXQ9eKZ8wFDvsj3FpeG3eMxqn3NZWMhgprCiU6f
         k2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=MPmCQXWKSTe1cJLnEO8jNShLQ8wkO39ZYX/ENh9wByE=;
        b=l6l24U06kPursRvOVE24gnjQmTF/b+YPjLoycP431jH7oZ1CBKzIJj1TgYmSMlzo+Z
         8AgV9bXedihoDGBMuWIqioUEHhbhbvQ08268LPOk3jvTbc8fBo5E7cutVbDnoNZkY5ej
         z3VXpa0hpSVk8Qwd/fhcNS/QTRSSN/Y7mdx8ex5ZyP7/vKbyFpfxHVxDlPudfnvMonBJ
         UhMN12WCRMB+95W8oCBB/QM2tWou5NDjU0GsO+NFSeEfXMilWQmT+3H3lx2ze6Iz+l1n
         tpF9twqmMKh45RKvim0c2K2GgVIo5HNb58UfLrMqJ/FdyNXgpFSeJKd5/I0k9LdLvdHB
         z99Q==
X-Gm-Message-State: AOAM533SmsKEeggX0KcVUKqgu9+zOE0jJ9o4XKfprFTIAWKPqeezjs3b
        zIOc+YQ8bDupnWhIdMBEFse9/9Q3Elzu/k40UVU/BXW+sCqUxA==
X-Google-Smtp-Source: ABdhPJxIu41ZXYmQTu48t3mzrpsVs6yBF5LhcetEr71P52gCK0Vh+DYEE2KrLgwl8o7lOMJGY2YyM1Sp0FuS2hdXx3s=
X-Received: by 2002:a1c:2341:: with SMTP id j62mr2937455wmj.34.1611636869004;
 Mon, 25 Jan 2021 20:54:29 -0800 (PST)
MIME-Version: 1.0
References: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
 <20190521091842.GS1667@carfax.org.uk> <CAMj6ewPKbRA_eT7JYA9ob9Qk9ZROoshOqaJE=4N_X9bPaskLUw@mail.gmail.com>
 <CAMj6ewOHrJVdwfKrgXZxwfwE=eoTaB9MS57zha33yb1_iOLWiw@mail.gmail.com>
 <8aa09a61-aa1c-5dcd-093f-ec096a38a7b5@gmx.com> <CAMj6ewO229vq6=s+T7GhUegwDADv4dzhqPiM0jo10QiKujvytA@mail.gmail.com>
 <684e89f3-666f-6ae6-5aa2-a4db350c1cd4@gmx.com> <CAMj6ewMqXLtrBQgTJuz04v3MBZ0W95fU4pT0jP6kFhuP830TuA@mail.gmail.com>
 <218f6448-c558-2551-e058-8a69caadcb23@gmx.com> <CAMj6ewPR8hVYmUSoNWVk6gZvy-HyKnmtMXexAr2f4VQU_7bbUw@mail.gmail.com>
 <3b2fe3d7-1919-d236-e6bb-483593287cc5@gmx.com> <CAMj6ewNDQFzXsvF5c1=raJc11iMvMKcHH=AbkUkrNeV2e3XGVg@mail.gmail.com>
 <CAMj6ewPiEvXbtHC1auSfRag5QGtYJxwH_Hvoi2t_18uDSxzm8w@mail.gmail.com>
 <CAMj6ewNjSs-_3akOquO1Zry5RBNEPqQWf7ZKjs8JOzTA7ZGZ7w@mail.gmail.com>
 <2abb2701-5dde-cd5d-dd25-084682313b11@gmx.com> <b2bbff7d-22d0-84c2-7749-ac9e27d4ab3d@gmx.com>
 <CAMj6ewOqCJTGjykDijun9_LWYELA=92HrE+KjGo-ehJTutR_+w@mail.gmail.com>
In-Reply-To: <CAMj6ewOqCJTGjykDijun9_LWYELA=92HrE+KjGo-ehJTutR_+w@mail.gmail.com>
From:   Erik Jensen <erikjensen@rkjnsn.net>
Date:   Mon, 25 Jan 2021 20:54:17 -0800
Message-ID: <CAMj6ewP-NK3g1xzHNF+fKt6M+_W-ec29Sq+CBtwcb1dcqc7dNA@mail.gmail.com>
Subject: Re: "bad tree block start" when trying to mount on ARM
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Hugo Mills <hugo@carfax.org.uk>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 20, 2021 at 1:08 AM Erik Jensen <erikjensen@rkjnsn.net> wrote:
>
> On Wed, Jan 20, 2021 at 12:31 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
> > On 2021/1/20 =E4=B8=8B=E5=8D=884:21, Qu Wenruo wrote:
> > > On 2021/1/19 =E4=B8=8B=E5=8D=885:28, Erik Jensen wrote:
> > >> On Mon, Jan 18, 2021 at 9:22 PM Erik Jensen <erikjensen@rkjnsn.net>
> > >> wrote:
> > >>>
> > >>> On Mon, Jan 18, 2021 at 4:12 AM Erik Jensen <erikjensen@rkjnsn.net>
> > >>> wrote:
> > >>>>
> > >>>> The offending system is indeed ARMv7 (specifically a Marvell ARMAD=
A=C2=AE
> > >>>> 388), but I believe the Broadcom BCM2835 in my Raspberry Pi is
> > >>>> actually ARMv6 (with hardware float support).
> > >>>
> > >>> Using NBD, I have verified that I receive the same error when
> > >>> attempting to mount the filesystem on my ARMv6 Raspberry Pi:
> > >>> [ 3491.339572] BTRFS info (device dm-4): disk space caching is enab=
led
> > >>> [ 3491.394584] BTRFS info (device dm-4): has skinny extents
> > >>> [ 3492.385095] BTRFS error (device dm-4): bad tree block start, wan=
t
> > >>> 26207780683776 have 3395945502747707095
> > >>> [ 3492.514071] BTRFS error (device dm-4): bad tree block start, wan=
t
> > >>> 26207780683776 have 3395945502747707095
> > >>> [ 3492.553599] BTRFS warning (device dm-4): failed to read tree roo=
t
> > >>> [ 3492.865368] BTRFS error (device dm-4): open_ctree failed
> > >>>
> > >>> The Raspberry Pi is running Linux 5.4.83.
> > >>>
> > >>
> > >> Okay, after some more testing, ARM seems to be irrelevant, and 32-bi=
t
> > >> is the key factor. On a whim, I booted up an i686, 5.8.14 kernel in =
a
> > >> VM, attached the drives via NBD, ran cryptsetup, tried to mount, and=
=E2=80=A6
> > >> I got the exact same error message.
> > >>
> > > My educated guess is on 32bit platforms, we passed incorrect sector i=
nto
> > > bio, thus gave us garbage.
> >
> > To prove that, you can use bcc tool to verify it.
> > biosnoop can do that:
> > https://github.com/iovisor/bcc/blob/master/tools/biosnoop_example.txt
> >
> > Just try mount the fs with biosnoop running.
> > With "btrfs ins dump-tree -t chunk <dev>", we can manually calculate th=
e
> > offset of each read to see if they matches.
> > If not match, it would prove my assumption and give us a pretty good
> > clue to fix.
> >
> > Thanks,
> > Qu
> >
> > >
> > > Is this bug happening only on the fs, or any other btrfs can also
> > > trigger similar problems on 32bit platforms?
> > >
> > > Thanks,
> > > Qu
>
> I have only observed this error on this file system. Additionally, the
> error mounting with the NAS only started after I did a `btrfs replace`
> on all five 8TB drives using an x86_64 system. (Ironically, I did this
> with the goal of making it faster to use the filesystem on the NAS by
> re-encrypting the drives to use a cipher supported by my NAS's crypto
> accelerator.)
>
> Maybe this process of shuffling 40TB around caused some value in the
> filesystem to increment to the point that a calculation using it
> overflows on 32-bit systems?
>
> I should be able to try biosnoop later this week, and I'll report back
> with the results.

Okay, I tried running biosnoop, but I seem to be running into this
bug: https://github.com/iovisor/bcc/issues/3241 (That bug was reported
for cpudist, but I'm seeing the same error when I try to run
biosnoop.)

Anything else I can try?
