Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 099FA199C5F
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Mar 2020 19:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730672AbgCaRBV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 Mar 2020 13:01:21 -0400
Received: from mail-yb1-f180.google.com ([209.85.219.180]:37401 "EHLO
        mail-yb1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730770AbgCaRBV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 Mar 2020 13:01:21 -0400
Received: by mail-yb1-f180.google.com with SMTP id n2so10191082ybg.4
        for <linux-btrfs@vger.kernel.org>; Tue, 31 Mar 2020 10:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qCicQcpfz8+jX95gi4jItfPMClmHaBDhnq+2wbYn+1U=;
        b=UHyWsVSXQ3+1HY4pQj/keS4897mRAxsTHMutN0atkvg3Fv2e5d52wJ5TMFZuWxZrh6
         FqWB9STRKVOXNVL3Vp+oPshdBbXZg1uKT3Y9je3Q2jPwFtAAOpf6aDG9eUqOY9WWNnbM
         sq8Tg7g5Im/kQLnBqQ5WI4SIfzq9c3Xbsj6S3gSVXSDwEFF0JKQd4C4GCkgrY5YJxAGP
         dLSKRFuWfKUN4Od24SrLt/3RQsoZSBDVv1WFDElRAjHMpIyK9ymyNok8zb++wwW1q2OC
         7tU14PBasmiOJNizPsaAFHbDBM+ynQf4dfCSofIt9VmU0DocXtHduQyuRCOSVEVhMpSF
         XH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qCicQcpfz8+jX95gi4jItfPMClmHaBDhnq+2wbYn+1U=;
        b=Iby1VeonWtq/8DjOGVw3/yad5Jq8ksGOD4LBTNp9eHe49dvC18jGpBysThRxgs45x3
         5+sQqIhNZ//wZa/W3I+8Y25RhBMI/YKv7tgq0yCMvViej+tnx5YAQwRxB6xBC9g6m84y
         vO5MMicO6f96SPbLE3eQQDheVPtVDfcmUmLI3j1I7ktgiYeCU7JoCSyKYqoIvzVrF6OT
         bEKKXACjuc1ztdbO2+Ps4LTdUhqViJUh22m1vN2aEgp0WbidDggYQGe5XBfXFEdmi5wg
         M/SzYxJ2eD3HqPdfw8nJY08S9MrCg51rpuuX7VXbFPuUbQXHyQ8KneWnaZHZjIcOQ0Wu
         jcvw==
X-Gm-Message-State: ANhLgQ2q5BcoH4hrINxXZ9vrtRLBpQ48uo5gelDP5+UNp65GAtCPMVUb
        ag1amnKU6LVQu42EcRnxBz5NRp62ZzDkaNyZKHw=
X-Google-Smtp-Source: ADFU+vvethKGB5A0Yb9pqeVishLN1zLWEbjK0hk2C2imoxcJpLDIRV5QIVNvnY9bjz0xP5dNJrJXAPc2ozHf1Ml9iVw=
X-Received: by 2002:a25:338a:: with SMTP id z132mr28389589ybz.430.1585674080484;
 Tue, 31 Mar 2020 10:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAMnnoULAX9Oc+O3gRbVow54H2p_aAENr8daAtyLR_0wi8Tx7xg@mail.gmail.com>
 <a9b73920-65d5-b973-8578-9659717434b5@gmail.com> <SYBPR01MB38978D6654705941C50AF95E9ECB0@SYBPR01MB3897.ausprd01.prod.outlook.com>
In-Reply-To: <SYBPR01MB38978D6654705941C50AF95E9ECB0@SYBPR01MB3897.ausprd01.prod.outlook.com>
From:   Eli V <eliventer@gmail.com>
Date:   Tue, 31 Mar 2020 13:01:09 -0400
Message-ID: <CAJtFHUSjwBKGyjSQfB-aZwsvV=4AcnG+-h5uF_4zmBOESxd=hA@mail.gmail.com>
Subject: Re: Using Intel Optane to accelerate a BTRFS array? (equivalent of
 ZLOG/SIL for ZFS?)
To:     Paul Jones <paul@pauljones.id.au>
Cc:     Andrei Borzenkov <arvidjaar@gmail.com>,
        Victor Hooi <victorhooi@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 30, 2020 at 2:02 AM Paul Jones <paul@pauljones.id.au> wrote:
>
> > -----Original Message-----
> > From: linux-btrfs-owner@vger.kernel.org <linux-btrfs-
> > owner@vger.kernel.org> On Behalf Of Andrei Borzenkov
> > Sent: Monday, 30 March 2020 4:46 PM
> > To: Victor Hooi <victorhooi@gmail.com>; linux-btrfs <linux-
> > btrfs@vger.kernel.org>
> > Subject: Re: Using Intel Optane to accelerate a BTRFS array? (equivalen=
t of
> > ZLOG/SIL for ZFS?)
> >
> > 30.03.2020 01:30, Victor Hooi =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > > Hi,
> > >
> > > I have a small 12-bay SuperMicro server I'm using as a local NAS, wit=
h
> > > FreeNAS/ZFS.
> > >
> > > Each drive is a 12TB HDD.
> > >
> > > I'm in the process of moving it to Linux - and I thought this might b=
e
> > > a good chance to try out BTRFS again =3D).
> > >
> > > (I'd previously tried BTRFS many years a go, and hit some issues -
> > > it's possible this may have been made worse by my inexperience with
> > > BTRFS at the time - e.g.
> > > https://www.spinics.net/lists/linux-btrfs/msg04240.html)
> > >
> > > Anyhow - currently the server has a 750GB Intel Optane drive, that
> > > we're using as a ZLOG/SIL drive:
> > >
> >
> > Do you mean ZIL/SLOG? ZIL =3D=3D ZFS Intent Log, SLOG =3D=3D SSD Log.
> >
> > > https://www.ixsystems.com/community/threads/how-best-to-use-960gb-
> > opta
> > > ne-in-freenas-build.75798/#post-527264
> > >
> > > My question is - what's the equivalent in BTRFS-land?
> > >
> >
> > Not on btrfs level. I guess using bcache on top of btrfs may achieve so=
me
> > similar effects.
> >
> > > Or what is the best way to use an ultra-fast Intel Optane drive to
> > > accelerate reads/writes on a BTRFS array?
> > >
> >
> >
> > ZIL is *write* intent log, it does not directly accelerates reads. ZFS =
supports
> > SSD as second-level read cache, but as far as I remember it is physical=
ly
> > separate from ZIL.
>
> I have used caching with lvm under btrfs. It's a pain to setup correctly =
for a btrfs raid1 setup (need separate volume groups with separate logical =
volumes to ensure it's impossible to have two raid1 stripes on the same phy=
sical disk without noticing it) but it did work quite well and I never had =
any strange problems with it.
>
> Paul.

Another option is to put the 12TB drives in an mdadm RAID, and then
use the mdadm raid & the ssd for btrfs RAID1 metadata, with SINGLE
data on the the array. Currently, this will make roughly half of the
meta data lookups run at SSD speed, but there is a pending patch to
allow all the metadata reads to go to the SSD. This option is, of
course, only useful for speeding up metadata operations. It can make
large btrfs filesystems feel much more responsive in interactive use
however.
