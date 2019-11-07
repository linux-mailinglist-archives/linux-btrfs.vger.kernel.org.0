Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24A2AF27FA
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Nov 2019 08:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfKGHRU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Nov 2019 02:17:20 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35834 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfKGHRT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Nov 2019 02:17:19 -0500
Received: by mail-pf1-f196.google.com with SMTP id d13so1881915pfq.2
        for <linux-btrfs@vger.kernel.org>; Wed, 06 Nov 2019 23:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LzUdAAM8a5dOR7yqqZfNOhtvgGaXLAK/BAuvg5tjD44=;
        b=IXgQPHmUXXqRyfO5EGG3cpYkQw3GCJNhEAM6wM+fZwsi+DyA8r/Dd8ReVgrNPo+W8v
         A6DbQhoiJX52NActQ0S0o+4G8NNs8/JZmAvbHlFkT/Ur5K55xMC/aszhKGkOr7hS7hbl
         XBR3/CuJom6pvdG40cx35fUg1zMKzTYoxMqjaS0PoACZhZQ9bMqU2jS4Mbrcxk4fAKgZ
         Ty/Lt/5s6bS7mCtxZAXD9IDXvi4OXQHW03rW2Tbu2pLT/DBlL5vdnd/J5/mdKRjQeqXj
         LPJKzCE0YkLULblqZPOqXaPTBBGeYrmBG3/A+MPIrjBxHTDUxso8NZFgUvEWYHtHsNaX
         UBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LzUdAAM8a5dOR7yqqZfNOhtvgGaXLAK/BAuvg5tjD44=;
        b=nU82c3PYg360a0UltonQDbVNNDBeyAuMrl8t6dWM11yedV1SphgCoCjmpornzhs/1Y
         l2fFlRaWzhOtMjFY8inL1CsbsbjdS7j4k5KKOxr4XMHIDTLuYxKdv2bjvqUdSxv1A0Ya
         Pl9Q3nue/L2WdLedVLciPFf0CUZPoA+ca2dk9zKT5OMhPfN850fRR4kkuTBhvXGujFtz
         wYkCsmrtHZwWA/zreceDqqM7KG3ITeeS5pZRjghHjTjxmMKk6nkqt5FLgmGPjExs5Gg0
         G46s7LgKtY6XHWzXrCS3vju5fsji2lfgKE61bkd3IzWKG1g/ho+nNY2t29jQAo9qxxVS
         NMTg==
X-Gm-Message-State: APjAAAVNik5+HG+L/WubQWVipRCgy9kbQRmLkLWL9XkIWBsFsmNl+mx0
        r6Tgu1VZvJoRfxGflA/T/zlk5rq8jwBQXAJszLo=
X-Google-Smtp-Source: APXvYqye4hruOoUiWEjgy3emBSwok9l1/GKGr3nJINshwxnf6hh+phCK5fTGfbd0Kk294Gz992MlokyVWEgF+ofvS7Y=
X-Received: by 2002:a17:90a:c082:: with SMTP id o2mr3072106pjs.94.1573111038373;
 Wed, 06 Nov 2019 23:17:18 -0800 (PST)
MIME-Version: 1.0
References: <CAJjG=74frVNMRaUabyBckJcJwHYk33EQnFRZRa+dE3g-Wqp5Bg@mail.gmail.com>
 <187ab271-f2be-9e96-e73a-0f6f3e97655a@gmx.com> <CAJjG=77Csw5P4q1sPeinoT=y=9Gy=FUr88NK2mJH72OBExnHgQ@mail.gmail.com>
 <1e600b1e-f61b-ab7a-85bc-8bd1710c2ea9@gmx.com>
In-Reply-To: <1e600b1e-f61b-ab7a-85bc-8bd1710c2ea9@gmx.com>
From:   Sergiu Cozma <lssjbrolli@gmail.com>
Date:   Thu, 7 Nov 2019 09:16:42 +0200
Message-ID: <CAJjG=74LUiRLbJiJ_BwgirqkA=i72t0GfJB0Masgkg0NHY0ozA@mail.gmail.com>
Subject: Re: fix for ERROR: cannot read chunk root
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Well nothing to lose now so if you come up with any exotic ideas you
wanna try please let me know, I will keep the partition for the next
couple of days.

Thank you for your time.

On Thu, Nov 7, 2019 at 2:44 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2019/11/6 =E4=B8=8B=E5=8D=8811:52, Sergiu Cozma wrote:
> > Hi, thanks for taking the time to help me out with this.
> >
> > The history is kinda bad, I tried to resize the partition but gparted
> > failed saying that the the fs has errors and after throwing some
> > commands found on the internet at it now I'm here :(
>
> Not sure how gparted handle resize, but I guess it should use
> btrfs-progs to do the resize?
>
> >
> > Any chance to recover or rebuild the chunk tree?
>
> I don't think so. Since it's wiped, there is no guarantee that only
> chunk tree is wiped.
>
> THanks,
> Qu
>
>
> >
> >
> > On Wed, Nov 6, 2019, 13:34 Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >>
> >>
> >>
> >> On 2019/11/5 =E4=B8=8B=E5=8D=8811:04, Sergiu Cozma wrote:
> >>> hi, i need some help to recover a btrfs partition
> >>> i use btrfs-progs v5.3.1
> >>>
> >>> btrfs rescue super-recover https://pastebin.com/mGEp6vjV
> >>> btrfs inspect-internal dump-super -a https://pastebin.com/S4WrPQm1
> >>> btrfs inspect-internal dump-tree https://pastebin.com/yX1zUDxa
> >>>
> >>> can't mount the partition with
> >>> BTRFS error (device sdb4): bad tree block start, want 856119312384 ha=
ve 0
> >>
> >> Something wiped your fs on-disk data.
> >> And the wiped one belongs to one of the most essential tree, chunk tre=
e.
> >>
> >> What's the history of the fs?
> >> It doesn't look like a bug in btrfs, but some external thing wiped it.
> >>
> >> Thanks,
> >> Qu
> >>
> >>> [ 2295.237145] BTRFS error (device sdb4): failed to read chunk root
> >>> [ 2295.301067] BTRFS error (device sdb4): open_ctree failed
> >>>
> >>
>
