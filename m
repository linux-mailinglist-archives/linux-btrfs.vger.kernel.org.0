Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E3A2DA35F
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Dec 2020 23:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407337AbgLNW25 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Dec 2020 17:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733021AbgLNW2o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Dec 2020 17:28:44 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947CFC0613D3
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Dec 2020 14:28:04 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id b9so13155976qtr.2
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Dec 2020 14:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZmLCxgA9V60iX/JLVIC9gK9UFmRq79R7D1pZCc8eUwA=;
        b=Cze6M9ZaflPABEctRVpKSXGw6xQxP2Bvk++SpBqXofToixGi9Bdjzrcl+AjuLbrKxb
         VNPLX4ZIJfHmQ124DkGtYdG2m4WF9jy+Q4ITRQ+H1dTl1Zsf9+Yb4KoywMU3mLPICE7Y
         VTV8PPrMLqr9Yg2O6mpJFaSOkpjrphLypLvMQT4436jtBOwXgcRffJVCBAocze4N33en
         8o3IrQtFruhuiWKCmzz3gj6T4iE9gEObfs8NKjvgpyu7WmPbMF8EfW6U/WQQOD21m39s
         FsqxzuEcnzraSzmdcaxSWlvQ+ImIe4J0IPuoA0KIAug5TZtRvlLU2WIniuVN2LJ4Hwpy
         z1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZmLCxgA9V60iX/JLVIC9gK9UFmRq79R7D1pZCc8eUwA=;
        b=kicaKdBp7GGCDCdVqARN5sCppe+ikBXqd/3SmNdacyoQt5/bse2xNSByxdTTczh4Wg
         +RA6Jws3ELV8laA19N2jJSf02QiOOMpy+IlK6RVVqWxcIO2SxT6HFzekwRr9+hCJVizw
         L1TA5IG7vrvpQ9Fqct0fmm4+Yr/b5huaiFB6Hbhd5KB1t99vCrFI9yekn6LdE5T6JdkD
         qHw4PlUQiQOHXfLvt93Y4ldgdo4/VFc+4i9bSEqH7hantQKk7kmA4nlelWIiRdZgrNTC
         Lxtiu3mvh9kXuv68BX7Jc2M5Y2QhiFGkKlTCRoGyObPcyQVtNaHd7lO+H+mJTmfWFEFh
         mGEQ==
X-Gm-Message-State: AOAM531lWwZjlbvASsbRsyqIpBoKMKy++kuSgDkNbIZDQlUQLaQWmT8X
        8Cy87EWxCv3kkYuWKNapih5e72gpJDaGqjuSLLZYBdSSD+En/A==
X-Google-Smtp-Source: ABdhPJxRkUnuFifBh7frCGEtYJ0gI14mI2DBs5qGHRtflMoWvDqAi7J2s2AFzT+815Rtylbv9poSmSZYq546CL8a7fE=
X-Received: by 2002:ac8:4e47:: with SMTP id e7mr33938270qtw.262.1607984882953;
 Mon, 14 Dec 2020 14:28:02 -0800 (PST)
MIME-Version: 1.0
References: <CAA85sZtU1dAYMSUR4fXbcuS4i=gU=ukC-9Y7io3pUMUt3S+Bjw@mail.gmail.com>
 <ccb8c05e-fa56-c88b-c211-f250fe85d815@applied-asynchrony.com>
 <CAA85sZvFBMad6N8hHR5YM56X9DxKE_3CyOT3xEnp9KsWX=fuHQ@mail.gmail.com>
 <CAA85sZt_deCX-jwtwfT_izf_6nsQXbroe=ksKfNErCwjFXWu_g@mail.gmail.com> <CAA85sZseX5FLT-RBFRHjZ0_F0V3X9fFEG4faU02KLaXwgaV=PA@mail.gmail.com>
In-Reply-To: <CAA85sZseX5FLT-RBFRHjZ0_F0V3X9fFEG4faU02KLaXwgaV=PA@mail.gmail.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Mon, 14 Dec 2020 23:27:51 +0100
Message-ID: <CAA85sZs6_tj-vE8Yve5ixTez7-9sompG4P24FKmbpZ3ZOY_HnQ@mail.gmail.com>
Subject: Re: Odd filesystem issue, reading beyond device
To:     =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Aaaand sorry, turns out that my raid device was 1 fifth of its
original size and it had to be manually remedied...

Now lets see if data survives this...

On Mon, Dec 14, 2020 at 10:18 PM Ian Kumlien <ian.kumlien@gmail.com> wrote:
>
> On Mon, Dec 14, 2020 at 9:33 PM Ian Kumlien <ian.kumlien@gmail.com> wrote=
:
> >
> > On Mon, Dec 14, 2020 at 8:57 PM Ian Kumlien <ian.kumlien@gmail.com> wro=
te:
> > >
> > > On Mon, Dec 14, 2020 at 5:50 PM Holger Hoffst=C3=A4tte
> > > <holger@applied-asynchrony.com> wrote:
> > > >
> > > > On 2020-12-14 17:28, Ian Kumlien wrote:
> > > > > Hi,
> > > > >
> > > > > Upgraded from 5.9.6 to 5.10 and now I get this:
> > > > > [  581.665506] BTRFS: device fsid 3c16de2d-33b6-436a-ba17-38b917a=
e3e33
> > > > > devid 1 transid 258057 /dev/dm-0 scanned by systemd-udevd (1043)
> > > > > [  589.602444] BTRFS info (device dm-0): use lzo compression, lev=
el 0
> > > > > [  589.602459] BTRFS info (device dm-0): enabling auto defrag
> > > > > [  589.602465] BTRFS info (device dm-0): using free space tree
> > > > > [  589.602470] BTRFS info (device dm-0): has skinny extents
> > > > > [  589.603082] attempt to access beyond end of device
> > > > >                 dm-0: rw=3D4096, want=3D36461289632, limit=3D1097=
1543296
> > > > > [  589.603108] attempt to access beyond end of device
> > > > >                 dm-0: rw=3D4096, want=3D36461355168, limit=3D1097=
1543296
> > > > > [  589.603125] BTRFS error (device dm-0): failed to read chunk ro=
ot
> > > > > [  589.603412] BTRFS error (device dm-0): open_ctree failed
> > > > > [  834.619193] BTRFS info (device dm-0): use lzo compression, lev=
el 0
> > > > > [  834.619209] BTRFS info (device dm-0): enabling auto defrag
> > > > > [  834.619214] BTRFS info (device dm-0): using free space tree
> > > > > [  834.619219] BTRFS info (device dm-0): has skinny extents
> > > > > [  834.619825] attempt to access beyond end of device
> > > > >                 dm-0: rw=3D4096, want=3D36461289632, limit=3D1097=
1543296
> > > > > [  834.619844] attempt to access beyond end of device
> > > > >                 dm-0: rw=3D4096, want=3D36461355168, limit=3D1097=
1543296
> > > > > [  834.619858] BTRFS error (device dm-0): failed to read chunk ro=
ot
> > > > > [  834.620205] BTRFS error (device dm-0): open_ctree failed
> > > > >
> > > > > Any ideas?
> > > > >
> > > >
> > > > See https://lore.kernel.org/lkml/20201214053147.GA24093@codemonkey.=
org.uk/
> > > > + followups. Nothing to do with btrfs.
> > >
> > > Thank you! and 5.0.1 has been released with the patches reverted, FYI=
 =3D)
> >
> > No, I'm sad to report that that's not it... or there are other deeper
> > raid issues...
> >
> > [  108.688424] BTRFS info (device dm-0): use lzo compression, level 0
> > [  108.688439] BTRFS info (device dm-0): enabling auto defrag
> > [  108.688444] BTRFS info (device dm-0): using free space tree
> > [  108.688449] BTRFS info (device dm-0): has skinny extents
> > [  108.688955] attempt to access beyond end of device
> >                dm-0: rw=3D4096, want=3D36461289632, limit=3D10971543296
> > [  108.688978] attempt to access beyond end of device
> >                dm-0: rw=3D4096, want=3D36461355168, limit=3D10971543296
> > [  108.688994] BTRFS error (device dm-0): failed to read chunk root
> > [  108.689310] BTRFS error (device dm-0): open_ctree failed
> >
> > This is with 5.0.1
>
> As an update, 5.9.6 can't mount it either
>
> > > > -h
