Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDD39BC9F7
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 16:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390765AbfIXORI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 10:17:08 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36187 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfIXORI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 10:17:08 -0400
Received: by mail-vs1-f65.google.com with SMTP id v19so1430406vsv.3
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2019 07:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=xrrWTaizkSqwuzvuPCIc42frnywfJG3OQrgJvbUYHLo=;
        b=JYGwZ/RAJJR6i/5vZuS+NRWSci265t1YTlexyRXKbQyfZaV0oZNTvGUkK2NwvVCw0L
         iLc9sCe1bRRLvog4i45aXzfNCVoc1b1VsGdRCghusY0LxPksmmk7a0SQxn2lxxU/FM/L
         0PYTOZMTzjl956QIIEYBwIFvCu/j9ODAnvSh6RLTlWbK7lAOHLGdgielqVgcn/ejxlgn
         ngHhOruqZ6IORSo9Y4X6/34DbYyBfJdkaCCLmCDt3uC3L6jcCXqR+DqA3ufS5HwSfdgz
         0LSqVGL8Ta5HqMw8cseeZ2/DMcdYVzRoBSTbILAlrANNcaR/9vlNh64cFh0fjUWLlaUz
         hsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=xrrWTaizkSqwuzvuPCIc42frnywfJG3OQrgJvbUYHLo=;
        b=RdjtjrdLBo3LxigSOBpYxl/fdofHaF8lV304RYyjMntfP3ZYZaycP5zq4ui8aMdewO
         PlLrh9kbdAq5SJRx6oL2T7RPzDvPFMqnjxsTC2+tkNcn4Mx/IxxyEJz9MFvNTiNt6wjV
         M+Bg0PPEsr1n1dbE21bFXSFU7spM+l80Lemt6iLmVbdHp5WWjjR9z9pT6USGHaMyO7y8
         1t6CNc/PDQ4/N5StaWlpWkgvSF8nE/WOb37o3CTQjQ4vAa6BZkLgWd1dF6A3cHRRS2AR
         2ezDrC5AdZs7OBPTh01p7hh65LRtOss75CiogaTM7RrccwuJNhILLWw6wgCNIugrvR9W
         b4UQ==
X-Gm-Message-State: APjAAAWlCrR5t+n9G4ywybkLDPPlqJkBfx6F0u4ylBn7qO3g2eMCZBKy
        aFnVIp8D8D2bwfdIrOcVroU4Qj2oDLGq3dywcB0=
X-Google-Smtp-Source: APXvYqyttWyIxVxJrDbYeOIv54CP5v8DkIPq0AxL/JmUomIe6mJkx2zAzimEwbGFtFkFypinG/AmjolLJfi4VpTgUm4=
X-Received: by 2002:a67:2d13:: with SMTP id t19mr1417302vst.99.1569334627524;
 Tue, 24 Sep 2019 07:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <CA+X5Wn7Rtw4rTqXTG8wrEc883uFV7JpGo-zD8FhhD9gM+_Vpfg@mail.gmail.com>
 <CAL3q7H41BpuVTHOAMOFcVvVsJuc4iR10KKPDVfgEsG=ZEpwmWw@mail.gmail.com>
 <CAL3q7H4wDdzfA+H0HPk7oKNO3PDiN1nYHpRu5v6rRXvxQFVLbQ@mail.gmail.com>
 <CA+X5Wn4ZmwnJry0zjyAYow-jEU7PSdE16ROSqfaKyGavLoGVQQ@mail.gmail.com> <20190924132118.egtvk6mxmh37wl3h@macbook-pro-91.dhcp.thefacebook.com>
In-Reply-To: <20190924132118.egtvk6mxmh37wl3h@macbook-pro-91.dhcp.thefacebook.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 24 Sep 2019 15:16:56 +0100
Message-ID: <CAL3q7H4ZUdhZEyUsVFOmzF=L7890MxHndrXwJ=KPR1vwdNQPWQ@mail.gmail.com>
Subject: Re: WITH regression patch, still btrfs-transacti blocked for... (forever)
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     James Harvey <jamespharvey20@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 24, 2019 at 2:21 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On Tue, Sep 24, 2019 at 07:07:41AM -0400, James Harvey wrote:
> > On Tue, Sep 24, 2019 at 5:58 AM Filipe Manana <fdmanana@gmail.com> wrot=
e:
> > >
> > > On Sun, Sep 15, 2019 at 2:55 PM Filipe Manana <fdmanana@gmail.com> wr=
ote:
> > > >
> > > > On Sun, Sep 15, 2019 at 1:46 PM James Harvey <jamespharvey20@gmail.=
com> wrote:
> > > > > ...
> > > > > You'll see they're different looking backtraces than without the
> > > > > patch, so I don't actually know if it's related to the original
> > > > > regression that several others reported or not.
> > > >
> > > > It's a different problem.
> > >
> > > So the good news is that on upcoming 5.4 the problem can't happen, du=
e
> > > to a large patch series from Josef regarding space reservation
> > > handling which, as a side effect, solves that problem and doesn't
> > > introduce new ones with concurrent fsyncs.
> > >
> > > However that's a large patch set which depends on a lot of previous
> > > cleanups, some of which landed in the 5.3 merge window,
> > > Backporting all those patches is against the backport policies for
> > > stable release [1], since many of the dependencies are cleanup patche=
s
> > > and many are large (well over the 100 lines limit).
> > >
> > > On the other it's not possible to send a fix for stable releases that
> > > doesn't land on Linus' tree first, as there's nothing to fix on the
> > > current merge window (5.4) since that deadlock can't happen there.
> > >
> > > So it seems like a dead end to me.
> > >
> > > Fortunately, as you told me privately, you only hit this once and it'=
s
> > > not a frequent issue for you (unlike the 5.2 regression which
> > > caused you the hang very often). You can workaround it by mounting th=
e
> > > fs with "-o notreelog", which makes fsyncs more expensive,
> > > so you'll likely see some performance degradation for your
> > > applications (higher latency, less throughput).
> > >
> > > [1] https://www.kernel.org/doc/html/v4.15/process/stable-kernel-rules=
.html
> >
> >
> > All understood, thanks for letting me know.  Not a problem.  I have
> > still only ran into this crash once, about 9 days ago.  I haven't had
> > another btrfs problem since then, unlike the hourly hangs on 5.2 with
> > heavy I/O.
>
> We are seeing this crash internally on our testing tier, we're still runn=
ing it
> down but it's pretty elusive.  I'll CC you when we find it and fix it.  T=
hanks,

Which crash?
There are 2 different deadlocks being mentioned in this thread.

>
> Josef



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
