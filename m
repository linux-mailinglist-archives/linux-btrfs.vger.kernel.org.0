Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45D3714FF0A
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Feb 2020 21:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgBBUFF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 2 Feb 2020 15:05:05 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37206 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbgBBUFF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 2 Feb 2020 15:05:05 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so15323491wru.4
        for <linux-btrfs@vger.kernel.org>; Sun, 02 Feb 2020 12:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nechk3aSujdjHV5SwKPZZ+VK53GUhbiiid1bPz0kk68=;
        b=j5oWGcsEHsdSLKZeO47EdqFPtKq/oJ2VZdLcwInIrXB25/INEgtZhcTrPRMoSeNUMT
         kQGXB+t8ztg9/NCjwrRdvY+3DWvXrag6wrhlAcgniUQDrtMiUSLALYVuo+CDyPaCSfh3
         qAUNnMcN6NCIsQcvZwhlxI7ybKhAYChYt0N71z9quH1Zi/QX2cyPK/pOOVh5SUfaMBXk
         tDLwUo8PuZhBotSBnJl2cSv1iko7uDWpclanBJ9aRDmtfzYuQ2qUv2qhz/8JiXV19OAu
         vvSy2Bo6OXNH2BEGnMXRo1OtOITFVARQ9ETxX9qQzr8706m5lyqug++Nw1M3CLyNyDa+
         hMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nechk3aSujdjHV5SwKPZZ+VK53GUhbiiid1bPz0kk68=;
        b=Fp2n8150UphMluqB6ZkYfBG9Q2YC/HHclCapCxS2WOGvfrsik76drsRW+M89h0C7p8
         jxtHGUGRB/4RMEwRdMooeOWQwxTjAQVsW0U6X1C9m2XUd+97ymTxdyAoa8psOU5I55Pa
         Q+IiZ15h/d4cPbm8Xn3UVta+W4xdnrzTRJGuznPuMMUQemgBXTsFPPxmTxS9cAIunHQ8
         uc9YbBx5kn8N/f0PBJK/n/r75A9fBx5s02KWcvYBFSSfqTGS/D9xovaSHQxzxLcMj3XV
         bZ6QRyWb7IHh2tyAlXC3vQLHRBTCQ9jqLKaPv9DggwqTHodH89NcT5ZnaP4UbgvZNLo+
         BY6w==
X-Gm-Message-State: APjAAAUNoiZqv5+t5Gro3UdgIq+Ogr5VdQ7RY8YLGATSv3FQ3tdB4tj7
        Bt9CIFJT7UC9mYc//7CPPPax2FbvG/Gt/TP4qlA18T6IPRQ=
X-Google-Smtp-Source: APXvYqziu0Y9v+Drbvym+yb+KV0RmLwrtviryJEoyDlDFstN2C153FBbKB1BzhxSQAetNYDPk61rKvfI4nAUdrNAocg=
X-Received: by 2002:adf:8564:: with SMTP id 91mr11710698wrh.252.1580673903072;
 Sun, 02 Feb 2020 12:05:03 -0800 (PST)
MIME-Version: 1.0
References: <CACN+yT_AYiLc29M41U+WrQHtk4t==D-4AkH+wRROKJY=WstGAA@mail.gmail.com>
 <cd628b1f-25b7-0f3b-0b31-2122acdfcd36@gmx.com> <20200202142246.1f4c36e3@ithnet.com>
In-Reply-To: <20200202142246.1f4c36e3@ithnet.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 2 Feb 2020 13:04:47 -0700
Message-ID: <CAJCQCtQs0MGSQ=VGGbjpnUM+QrD7SpWj2EcS6vMQUYLE6VShjg@mail.gmail.com>
Subject: Re: My first attempt to use btrfs failed miserably
To:     Stephan von Krawczynski <skraw.ml@ithnet.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Feb 2, 2020 at 6:29 AM Stephan von Krawczynski
<skraw.ml@ithnet.com> wrote:
>
> On Sun, 2 Feb 2020 20:56:20 +0800
> Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
> > On 2020/2/2 =E4=B8=8B=E5=8D=888:45, Skibbi wrote:
> > > Hello,
> > > So I decided to try btrfs on my new portable WD Password Drive
> > > attached to Raspberry Pi 4. I created GPT partition, created luks2
> > > volume and formatted it with btrfs. Then I created 3 subvolumes and
> > > started copying data from other disks to one of the subvolumes. After
> > > writing around 40GB of data my filesystem crashed. That was super fas=
t
> > > and totally discouraged me from next attempts to use btrfs :(
> > > But I would like to help with development so before I reformat my
> > > drive I can help you identifying potential issues with this filesyste=
m
> > > by providing some debugging info.
> > >
> > > Here are some details:
> > >
> > > root@rpi4b:~# uname -a
> > > Linux rpi4b 4.19.93-v7l+ #1290 SMP Fri Jan 10 16:45:11 GMT 2020 armv7=
l
> > > GNU/Linux
> >
> > Pretty old kernel, nor recently enough backports.
>
> Exactly this kind of answer made me leave btrfs and never come back again=
.
> 4.19.93 is not very far away from the _latest_ longterm kernel released (=
which
> is 4.19.101).
> What you are saying here is that there is no stable working btrfs in long=
term
> kernels at all.

No, Qu means there's not enough tree checking information to do
anything other than speculate what the problem is. There's a lot more
information provided by recent kernels about fs corruption causes, and
that's just not going to be backported, it's too much work.

> Hear, hear.
> My advice to the OP: use ZFS. Great performance, absolutely stable, no cr=
ash
> in years.

Based on the available information, it would probably spectacularly
fail too because of underlying storage betrayal. And if those kernel
messages were likewise filtered, it'd suggests ZFS confusion.
Unsurprising. ZFS doesn't let you magically use a failing storage
stack.

--=20
Chris Murphy
