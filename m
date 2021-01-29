Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24FEE3085F5
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Jan 2021 07:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbhA2Gkv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Jan 2021 01:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbhA2Gkn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Jan 2021 01:40:43 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27E9C06174A
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Jan 2021 22:40:01 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id o10so6398594wmc.1
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Jan 2021 22:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rkjnsn-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=r95UlAKxafnW5n6rrmpXbLqtBt4L0M/zWu/3MUTkda0=;
        b=i532M32cUFAcI7xWSAkikVsN//mWvzX5QRWhaqbx381OkbaFHU78kbgIdgDPfK7K7s
         zCInRPZDHkw5C6G8LfWsSd8weGo76JeJgIk9umO6LV+FPqF1CUrHQC0Hbi782veWaxf5
         dCIngBJKczKp19CvicqW0fl/2zTDqGCQgW4fnuXB24fwFTE/biC2KMR6R74U03CPgh4R
         GgwZORQpCyVAcWZdPvAFfO60uoYrxTT+Xl9IpYARU26RaGmCicQhfmRFi5qu0L+YAYTN
         B9HiNx+S/dTaxn0/Ubh6XBZRzZcT+kdy7cfA5Kt+fTdUHBAMrlfdHst9jQYWugSJZU4Y
         x+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=r95UlAKxafnW5n6rrmpXbLqtBt4L0M/zWu/3MUTkda0=;
        b=PC4YkEIZuoX5XttiNVNXWpvkvCWZof6jFwByzKyULet+BEraW+O1uqE1zf8d2GX2at
         ZHCj0aHUpik/EkYh5C9xqtdZTer6GcDqOrkJlPHTqsT5Ci4hYa69f9THOi6uC+g0lCmq
         R6pwEbsm3t9lVx7SfbG4fn9vrG342Stqxx9oDGwx37t90OhDbAjIfmIyfn2q4EbqzuAk
         Zu9BSlMGnVfH1/sJePB/+swkSrEsr7z+BdW9X3KdgX/5lBf21v2g5ZMolh0Wrw6gOV1M
         09Ed0lJfodCCDUmQ/hlrjLe5wMkrQlkJq/lvyE/R8Y9Ros2ZtyOYdhDfmrsxDGq6A/rg
         C50A==
X-Gm-Message-State: AOAM532EDxH+cLSrDl5wzJG1F/p9J9T5uOYOQMuf7JrFIzDEPYXUF03H
        pEqMnbzO2r/aVpdRxrROxVHCOhlW8tn+TreZWAVlIg==
X-Google-Smtp-Source: ABdhPJxjWfYV8PAqKJtbXEcnJOfwVWNHBNXY9ZC/4/v1SDPsOo2dSLwdnd2en5xtDMsKOUYsD90Pkol0bj0j2Z0Nbqs=
X-Received: by 2002:a05:600c:220a:: with SMTP id z10mr2256962wml.54.1611902400686;
 Thu, 28 Jan 2021 22:40:00 -0800 (PST)
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
 <CAMj6ewOqCJTGjykDijun9_LWYELA=92HrE+KjGo-ehJTutR_+w@mail.gmail.com> <CAMj6ewP-NK3g1xzHNF+fKt6M+_W-ec29Sq+CBtwcb1dcqc7dNA@mail.gmail.com>
In-Reply-To: <CAMj6ewP-NK3g1xzHNF+fKt6M+_W-ec29Sq+CBtwcb1dcqc7dNA@mail.gmail.com>
From:   Erik Jensen <erikjensen@rkjnsn.net>
Date:   Thu, 28 Jan 2021 22:39:49 -0800
Message-ID: <CAMj6ewPtDJdkQ=H3DO6BSPucdkqSoHOkeb-xgTd8mo+AaUWhkA@mail.gmail.com>
Subject: Re: "bad tree block start" when trying to mount on ARM
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Hugo Mills <hugo@carfax.org.uk>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 25, 2021 at 8:54 PM Erik Jensen <erikjensen@rkjnsn.net> wrote:
> On Wed, Jan 20, 2021 at 1:08 AM Erik Jensen <erikjensen@rkjnsn.net> wrote=
:
> > On Wed, Jan 20, 2021 at 12:31 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
> > > On 2021/1/20 =E4=B8=8B=E5=8D=884:21, Qu Wenruo wrote:
> > > > On 2021/1/19 =E4=B8=8B=E5=8D=885:28, Erik Jensen wrote:
> > > >> On Mon, Jan 18, 2021 at 9:22 PM Erik Jensen <erikjensen@rkjnsn.net=
>
> > > >> wrote:
> > > >>>
> > > >>> On Mon, Jan 18, 2021 at 4:12 AM Erik Jensen <erikjensen@rkjnsn.ne=
t>
> > > >>> wrote:
> > > >>>>
> > > >>>> The offending system is indeed ARMv7 (specifically a Marvell ARM=
ADA=C2=AE
> > > >>>> 388), but I believe the Broadcom BCM2835 in my Raspberry Pi is
> > > >>>> actually ARMv6 (with hardware float support).
> > > >>>
> > > >>> Using NBD, I have verified that I receive the same error when
> > > >>> attempting to mount the filesystem on my ARMv6 Raspberry Pi:
> > > >>> [ 3491.339572] BTRFS info (device dm-4): disk space caching is en=
abled
> > > >>> [ 3491.394584] BTRFS info (device dm-4): has skinny extents
> > > >>> [ 3492.385095] BTRFS error (device dm-4): bad tree block start, w=
ant
> > > >>> 26207780683776 have 3395945502747707095
> > > >>> [ 3492.514071] BTRFS error (device dm-4): bad tree block start, w=
ant
> > > >>> 26207780683776 have 3395945502747707095
> > > >>> [ 3492.553599] BTRFS warning (device dm-4): failed to read tree r=
oot
> > > >>> [ 3492.865368] BTRFS error (device dm-4): open_ctree failed
> > > >>>
> > > >>> The Raspberry Pi is running Linux 5.4.83.
> > > >>>
> > > >>
> > > >> Okay, after some more testing, ARM seems to be irrelevant, and 32-=
bit
> > > >> is the key factor. On a whim, I booted up an i686, 5.8.14 kernel i=
n a
> > > >> VM, attached the drives via NBD, ran cryptsetup, tried to mount, a=
nd=E2=80=A6
> > > >> I got the exact same error message.
> > > >>
> > > > My educated guess is on 32bit platforms, we passed incorrect sector=
 into
> > > > bio, thus gave us garbage.
> > >
> > > To prove that, you can use bcc tool to verify it.
> > > biosnoop can do that:
> > > https://github.com/iovisor/bcc/blob/master/tools/biosnoop_example.txt
> > >
> > > Just try mount the fs with biosnoop running.
> > > With "btrfs ins dump-tree -t chunk <dev>", we can manually calculate =
the
> > > offset of each read to see if they matches.
> > > If not match, it would prove my assumption and give us a pretty good
> > > clue to fix.
> > >
> > > Thanks,
> > > Qu
> > >
> > > >
> > > > Is this bug happening only on the fs, or any other btrfs can also
> > > > trigger similar problems on 32bit platforms?
> > > >
> > > > Thanks,
> > > > Qu
> >
> > I have only observed this error on this file system. Additionally, the
> > error mounting with the NAS only started after I did a `btrfs replace`
> > on all five 8TB drives using an x86_64 system. (Ironically, I did this
> > with the goal of making it faster to use the filesystem on the NAS by
> > re-encrypting the drives to use a cipher supported by my NAS's crypto
> > accelerator.)
> >
> > Maybe this process of shuffling 40TB around caused some value in the
> > filesystem to increment to the point that a calculation using it
> > overflows on 32-bit systems?
> >
> > I should be able to try biosnoop later this week, and I'll report back
> > with the results.
>
> Okay, I tried running biosnoop, but I seem to be running into this
> bug: https://github.com/iovisor/bcc/issues/3241 (That bug was reported
> for cpudist, but I'm seeing the same error when I try to run
> biosnoop.)
>
> Anything else I can try?

Is it possible to add printks to retrieve the same data?
