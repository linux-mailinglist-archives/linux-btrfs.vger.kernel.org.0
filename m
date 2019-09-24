Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCB0BCA21
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 16:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394211AbfIXOXT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 10:23:19 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:33715 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389459AbfIXOXS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 10:23:18 -0400
Received: by mail-vk1-f194.google.com with SMTP id q186so441334vkb.0
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2019 07:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=B1yqv7XmdxdzOQN6EKETSu5O6DxQlDV6R/ZHZ1cKepI=;
        b=soxWLw5pSm/ysmCR8kZT51HpFSvhnRT5RLKV9EPzXxZxuyaMoXY9NAZEb5fALjwqER
         jHjy6vk+BH6iJSsnpe+sXsXbg4nI8FBLH4J0SYOWvaJJAEmw2Bnk3uZ5hRx49QZMl4HF
         yHbE8g6OL2eIG/ipXwyLdWozs5GiAnNWmwWS8ZvjwpeFBk94tbvcXG1QNdgHaXTWLBIf
         kwgJYjq47srMX+BwJDcXXV0dNmWHcNzek/4uZ2oNBWnhaV8AYa1yKXzKzxOEjdnZj+xl
         cHc8R3bBsl98cnzAfIr84Dtqey1RHVJGBztRuz+7z3izlJaAFqgzDGi+tRJzlC78MQNe
         rkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=B1yqv7XmdxdzOQN6EKETSu5O6DxQlDV6R/ZHZ1cKepI=;
        b=akWhS7PqLmA8AsfFYg0c3vN8bHAcUhgNz4VJldxvzTnS//PUokl+cf89p1t7qSeID7
         7e+QWT09MMUACPPJn4MaoEoRZCug/tTFiTSX3DZBPCCZ41mhphFyDGj5ALaMbhQbIt3g
         7HFf8URR5ov2UJTncILyCMQfua+Ron/ppRgwJ1nRNNqcBFdkbHYqu7+/7b2PgcobfeWa
         AnhKsngdrzMyi8Lcwb4pb0rimFsvSab7IGxKEWYqAOVbWYePYkRAVpwa3Zw0LLpT2PRz
         sJKOqjJno2I/STgCX7y2w/KfXOkdh1XoQorJ3VYjcidUqvP8u2CqBCyjFCPGaSFvraSw
         yCaw==
X-Gm-Message-State: APjAAAVauTtokg9fFap9FRTZy66QRxMyAnF+K1016+VVH3NB0bWkz9Ub
        wggbxGCFZ2QoButJbGpZlz6nTewJKoycouTDsLQ=
X-Google-Smtp-Source: APXvYqxbAfDYaoTw/ilccX9pjX4kwbsrJf3QH+yfqi6dzE5fS0jQtOVhXfqSD5OuyJ+JB7kyWgXd8QrIJ1xaDOCOH1I=
X-Received: by 2002:a1f:c2c3:: with SMTP id s186mr1609259vkf.88.1569334997695;
 Tue, 24 Sep 2019 07:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <CA+X5Wn7Rtw4rTqXTG8wrEc883uFV7JpGo-zD8FhhD9gM+_Vpfg@mail.gmail.com>
 <CAL3q7H41BpuVTHOAMOFcVvVsJuc4iR10KKPDVfgEsG=ZEpwmWw@mail.gmail.com>
 <CAL3q7H4wDdzfA+H0HPk7oKNO3PDiN1nYHpRu5v6rRXvxQFVLbQ@mail.gmail.com>
 <CA+X5Wn4ZmwnJry0zjyAYow-jEU7PSdE16ROSqfaKyGavLoGVQQ@mail.gmail.com>
 <20190924132118.egtvk6mxmh37wl3h@macbook-pro-91.dhcp.thefacebook.com>
 <CAL3q7H4ZUdhZEyUsVFOmzF=L7890MxHndrXwJ=KPR1vwdNQPWQ@mail.gmail.com> <20190924141935.2qsfljijmv76door@macbook-pro-91.dhcp.thefacebook.com>
In-Reply-To: <20190924141935.2qsfljijmv76door@macbook-pro-91.dhcp.thefacebook.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 24 Sep 2019 15:23:06 +0100
Message-ID: <CAL3q7H7GHui8hdMO_grffhsoVo8mbDFK=mvbf8usHrFqxxNgcA@mail.gmail.com>
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

On Tue, Sep 24, 2019 at 3:19 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On Tue, Sep 24, 2019 at 03:16:56PM +0100, Filipe Manana wrote:
> > On Tue, Sep 24, 2019 at 2:21 PM Josef Bacik <josef@toxicpanda.com> wrot=
e:
> > >
> > > On Tue, Sep 24, 2019 at 07:07:41AM -0400, James Harvey wrote:
> > > > On Tue, Sep 24, 2019 at 5:58 AM Filipe Manana <fdmanana@gmail.com> =
wrote:
> > > > >
> > > > > On Sun, Sep 15, 2019 at 2:55 PM Filipe Manana <fdmanana@gmail.com=
> wrote:
> > > > > >
> > > > > > On Sun, Sep 15, 2019 at 1:46 PM James Harvey <jamespharvey20@gm=
ail.com> wrote:
> > > > > > > ...
> > > > > > > You'll see they're different looking backtraces than without =
the
> > > > > > > patch, so I don't actually know if it's related to the origin=
al
> > > > > > > regression that several others reported or not.
> > > > > >
> > > > > > It's a different problem.
> > > > >
> > > > > So the good news is that on upcoming 5.4 the problem can't happen=
, due
> > > > > to a large patch series from Josef regarding space reservation
> > > > > handling which, as a side effect, solves that problem and doesn't
> > > > > introduce new ones with concurrent fsyncs.
> > > > >
> > > > > However that's a large patch set which depends on a lot of previo=
us
> > > > > cleanups, some of which landed in the 5.3 merge window,
> > > > > Backporting all those patches is against the backport policies fo=
r
> > > > > stable release [1], since many of the dependencies are cleanup pa=
tches
> > > > > and many are large (well over the 100 lines limit).
> > > > >
> > > > > On the other it's not possible to send a fix for stable releases =
that
> > > > > doesn't land on Linus' tree first, as there's nothing to fix on t=
he
> > > > > current merge window (5.4) since that deadlock can't happen there=
.
> > > > >
> > > > > So it seems like a dead end to me.
> > > > >
> > > > > Fortunately, as you told me privately, you only hit this once and=
 it's
> > > > > not a frequent issue for you (unlike the 5.2 regression which
> > > > > caused you the hang very often). You can workaround it by mountin=
g the
> > > > > fs with "-o notreelog", which makes fsyncs more expensive,
> > > > > so you'll likely see some performance degradation for your
> > > > > applications (higher latency, less throughput).
> > > > >
> > > > > [1] https://www.kernel.org/doc/html/v4.15/process/stable-kernel-r=
ules.html
> > > >
> > > >
> > > > All understood, thanks for letting me know.  Not a problem.  I have
> > > > still only ran into this crash once, about 9 days ago.  I haven't h=
ad
> > > > another btrfs problem since then, unlike the hourly hangs on 5.2 wi=
th
> > > > heavy I/O.
> > >
> > > We are seeing this crash internally on our testing tier, we're still =
running it
> > > down but it's pretty elusive.  I'll CC you when we find it and fix it=
.  Thanks,
> >
> > Which crash?
> > There are 2 different deadlocks being mentioned in this thread.
> >
>
> The BUG_ON(!PageLocked(page)) crash, we're hunting that guy right now.  T=
hanks,

I'm confused.
Where is that BUG_ON() mentioned in this thread? Only 2 deadlocks are
mentioned, neither of them involves page locks nor a BUG_ON().

>
> Josef



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
