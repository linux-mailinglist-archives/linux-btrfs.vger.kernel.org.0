Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A303DBCA3C
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 16:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441364AbfIXO3r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 10:29:47 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:41438 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393954AbfIXO3r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 10:29:47 -0400
Received: by mail-ua1-f66.google.com with SMTP id l13so620486uap.8
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2019 07:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=ok6m/AFKKFz2y+Kf6rDIdsTHjl8JgqHgWF2h8JeVuhM=;
        b=TkOtcmg/mgz4erL98+vehOuZcTwJwAS6MM09IxRKNHuLDTKLkO/8GToQiZeuWP6AGy
         Yh5RKLbNZdLF/OHG0JmdaP6MkK0pTg9iPEKR/lfFpIRmNo2t5lLA8LTqoHH+BP5O1sPm
         fPHt50W/t9zYunZTyvpqrX27emOEs+4gu5KfbsZsc+0RvA1LeJnqfUszAczKJjKmRCSv
         C11YLFHmLVDXnL8Mx8YSg2hoPq2ohTy3pg3m/P1Zyh+tHbqFBsYg4T1IGSV6O68FNVFq
         L6VfS+KC/SpY5KT8LFpoSH9pp52BH9Egiim+edOVRuPT+Fs0nDQBdveeDDrKoyDU7vsx
         veeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=ok6m/AFKKFz2y+Kf6rDIdsTHjl8JgqHgWF2h8JeVuhM=;
        b=UZlzZ3VCDZMX1dCbOo4om1ZLbzKa3bpyVPFbfCIXtTRDGwMl6fD4QfXMuGQ4l2rVeM
         D5i32XCjcRP8KKhHESgoNAIA2MFIHl7tSzMH3tmgzwwmdvrqcoIJ9zwin5oI7YDpf83j
         hQWe7HCdbBSgok8rE3h1I6mDOREH5o1jR7e/H9bjne7CGwo8dEcyJSR8l43SEDd9NWAz
         vI2K+u90dvb3WNYGh/RfQcs5qEti2edMK3qGFD/hDI3/d0YoD+zmjxEr0z395sgmoRhR
         sEua5pL6YXN8j9RrwkEpgGpW5/K1Ze1/ELzfNV3EpGtWs9TVt4CfTMy5fbIoAnD8WYPZ
         ia7A==
X-Gm-Message-State: APjAAAW7lqOLIaXOvaDxhucfwSoULPjhz5AW2bwJ4+umG3H4cFwIJsNr
        Tf1N5ZJ22q2MhIdVwhIZjHIGSvpXUebJZgn6LT76sw==
X-Google-Smtp-Source: APXvYqxbSp6TMvw2VUl5DdIrCcVNraVzz2VhmDJpPP5bOuJhMX1naz0o68lS7JXARq/Q0JgMsK2nnDXonpbvTllIQLw=
X-Received: by 2002:ab0:70a2:: with SMTP id q2mr1571283ual.83.1569335385746;
 Tue, 24 Sep 2019 07:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <CA+X5Wn7Rtw4rTqXTG8wrEc883uFV7JpGo-zD8FhhD9gM+_Vpfg@mail.gmail.com>
 <CAL3q7H41BpuVTHOAMOFcVvVsJuc4iR10KKPDVfgEsG=ZEpwmWw@mail.gmail.com>
 <CAL3q7H4wDdzfA+H0HPk7oKNO3PDiN1nYHpRu5v6rRXvxQFVLbQ@mail.gmail.com>
 <CA+X5Wn4ZmwnJry0zjyAYow-jEU7PSdE16ROSqfaKyGavLoGVQQ@mail.gmail.com>
 <20190924132118.egtvk6mxmh37wl3h@macbook-pro-91.dhcp.thefacebook.com>
 <CAL3q7H4ZUdhZEyUsVFOmzF=L7890MxHndrXwJ=KPR1vwdNQPWQ@mail.gmail.com>
 <20190924141935.2qsfljijmv76door@macbook-pro-91.dhcp.thefacebook.com>
 <CAL3q7H7GHui8hdMO_grffhsoVo8mbDFK=mvbf8usHrFqxxNgcA@mail.gmail.com> <20190924142805.n4k4skgbx5mwwf2b@macbook-pro-91.dhcp.thefacebook.com>
In-Reply-To: <20190924142805.n4k4skgbx5mwwf2b@macbook-pro-91.dhcp.thefacebook.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 24 Sep 2019 15:29:34 +0100
Message-ID: <CAL3q7H7h7+o2U1-j-uu7H2hgnYhgTc8O5va29KNUMf1Gnqzi+A@mail.gmail.com>
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

On Tue, Sep 24, 2019 at 3:28 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On Tue, Sep 24, 2019 at 03:23:06PM +0100, Filipe Manana wrote:
> > On Tue, Sep 24, 2019 at 3:19 PM Josef Bacik <josef@toxicpanda.com> wrot=
e:
> > >
> > > On Tue, Sep 24, 2019 at 03:16:56PM +0100, Filipe Manana wrote:
> > > > On Tue, Sep 24, 2019 at 2:21 PM Josef Bacik <josef@toxicpanda.com> =
wrote:
> > > > >
> > > > > On Tue, Sep 24, 2019 at 07:07:41AM -0400, James Harvey wrote:
> > > > > > On Tue, Sep 24, 2019 at 5:58 AM Filipe Manana <fdmanana@gmail.c=
om> wrote:
> > > > > > >
> > > > > > > On Sun, Sep 15, 2019 at 2:55 PM Filipe Manana <fdmanana@gmail=
.com> wrote:
> > > > > > > >
> > > > > > > > On Sun, Sep 15, 2019 at 1:46 PM James Harvey <jamespharvey2=
0@gmail.com> wrote:
> > > > > > > > > ...
> > > > > > > > > You'll see they're different looking backtraces than with=
out the
> > > > > > > > > patch, so I don't actually know if it's related to the or=
iginal
> > > > > > > > > regression that several others reported or not.
> > > > > > > >
> > > > > > > > It's a different problem.
> > > > > > >
> > > > > > > So the good news is that on upcoming 5.4 the problem can't ha=
ppen, due
> > > > > > > to a large patch series from Josef regarding space reservatio=
n
> > > > > > > handling which, as a side effect, solves that problem and doe=
sn't
> > > > > > > introduce new ones with concurrent fsyncs.
> > > > > > >
> > > > > > > However that's a large patch set which depends on a lot of pr=
evious
> > > > > > > cleanups, some of which landed in the 5.3 merge window,
> > > > > > > Backporting all those patches is against the backport policie=
s for
> > > > > > > stable release [1], since many of the dependencies are cleanu=
p patches
> > > > > > > and many are large (well over the 100 lines limit).
> > > > > > >
> > > > > > > On the other it's not possible to send a fix for stable relea=
ses that
> > > > > > > doesn't land on Linus' tree first, as there's nothing to fix =
on the
> > > > > > > current merge window (5.4) since that deadlock can't happen t=
here.
> > > > > > >
> > > > > > > So it seems like a dead end to me.
> > > > > > >
> > > > > > > Fortunately, as you told me privately, you only hit this once=
 and it's
> > > > > > > not a frequent issue for you (unlike the 5.2 regression which
> > > > > > > caused you the hang very often). You can workaround it by mou=
nting the
> > > > > > > fs with "-o notreelog", which makes fsyncs more expensive,
> > > > > > > so you'll likely see some performance degradation for your
> > > > > > > applications (higher latency, less throughput).
> > > > > > >
> > > > > > > [1] https://www.kernel.org/doc/html/v4.15/process/stable-kern=
el-rules.html
> > > > > >
> > > > > >
> > > > > > All understood, thanks for letting me know.  Not a problem.  I =
have
> > > > > > still only ran into this crash once, about 9 days ago.  I haven=
't had
> > > > > > another btrfs problem since then, unlike the hourly hangs on 5.=
2 with
> > > > > > heavy I/O.
> > > > >
> > > > > We are seeing this crash internally on our testing tier, we're st=
ill running it
> > > > > down but it's pretty elusive.  I'll CC you when we find it and fi=
x it.  Thanks,
> > > >
> > > > Which crash?
> > > > There are 2 different deadlocks being mentioned in this thread.
> > > >
> > >
> > > The BUG_ON(!PageLocked(page)) crash, we're hunting that guy right now=
.  Thanks,
> >
> > I'm confused.
> > Where is that BUG_ON() mentioned in this thread? Only 2 deadlocks are
> > mentioned, neither of them involves page locks nor a BUG_ON().
> >
>
> Fuuuck sorry, that was a different thread, IDK how I got them confused.  =
Sorry
> about that,

Hehe, no worries. Thanks!

>
> Josef



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
