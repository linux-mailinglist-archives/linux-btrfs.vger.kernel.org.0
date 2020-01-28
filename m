Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36B4414BC8F
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jan 2020 16:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgA1PDL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jan 2020 10:03:11 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:35786 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgA1PDK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jan 2020 10:03:10 -0500
Received: by mail-ua1-f66.google.com with SMTP id y23so4921642ual.2
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Jan 2020 07:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=2awP3v6H3pqYHdu0NAn+3oYl+WSaRkDm+ISMO6ciUtg=;
        b=le5tXtCWPlnFEllTL/h8ebShfSNEZuKb8UrK/WH6r33cI3ouaRyJFd98cmhSVUdk7Z
         QzhN6S9j7PQDfpCoriUjz+nlX8eO2H8aJ8Wj01mxPg9/ME7Ja51aveWHnnFpcQg2YLC3
         wNJPKLrZ41Zn4AT56/7kMKX9yYTEEfTT1vypSPSfztimhq8A6TFS3Mu8DiuAa0EiZ3r8
         3u12/2tcZLsK27/DLDjS4lv7CBpI2TAITWsKC/NDFUV3ucE7lA3vsMWCVFImNqtDytBc
         0E7FBZimH2xzuyBy7HKf4LVtLYenzeXI20xgiLKXxxygAABoNhY9knKpb29Oe7RiWKH1
         0yWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=2awP3v6H3pqYHdu0NAn+3oYl+WSaRkDm+ISMO6ciUtg=;
        b=BSy1kMtm0aZDtD/WDQ0hPwKGFKOZpGl57I4gp57Dey2Pap4VFspN2/vJEZ1x7p6OVM
         fwRYJrs0cezo2yg8iTDoDEZDYZTGJjXqOUrOfG62Hvyn0i4QJFq2e2waLJAHCem+DtAH
         EiXAd2jFMhpFUjrtxrJlwJKnt6kYNSkYt522izUjkL9wU04Z9Y+tIV1NAc/d35bh8YNy
         oIjKGNghGx5nKw/I3Ni1s/S+jMFB2TWUvx9y0uZxGpyC7sNW180CloZgGCICniJslpRx
         oVKC+ydaqm42723yJDO5ZBrK1TIRF/KunqFftXgP3FKlZ9VdtTSv8jDsq8rp38QNEaQJ
         ma+g==
X-Gm-Message-State: APjAAAU42urWfpsqvRyLO95ACi6WOJgSGStElKeYK9KZJns191s9ysSl
        3Px1dxpgPswHPb4Xww4UBsKjPuvtB/tuLVh2Dxw=
X-Google-Smtp-Source: APXvYqzzI4qTAQviUhHXXc8nwxWPrPCfSTxz4U7nYfCpK2Gwb6BGoZnN+I49RMfJ5PTvx5+UunN/idgS8Ce/5zVKYe4=
X-Received: by 2002:ab0:2a93:: with SMTP id h19mr13024223uar.27.1580223789526;
 Tue, 28 Jan 2020 07:03:09 -0800 (PST)
MIME-Version: 1.0
References: <5ba0716449eb4f838699fc0b1fb5b024@integralblue.com>
 <20200113133741.GU3929@twin.jikos.cz> <7e7e4f63a89b6bb8a270d4c4ec676835@integralblue.com>
 <8254df450ca61dd4cbc455f19ee28c01@lesimple.fr> <CAL3q7H4-3Mg2GUf2JMMFem77sSQR5opN9dxdvHz2kk1Qd=RD=A@mail.gmail.com>
 <06639bb0a512aff6ed8a41bffb033f35@integralblue.com>
In-Reply-To: <06639bb0a512aff6ed8a41bffb033f35@integralblue.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 28 Jan 2020 15:02:57 +0000
Message-ID: <CAL3q7H5FHc9ooNOP3CnXas=_H_BEZN5mzegVMuvtoXgT9nxL6A@mail.gmail.com>
Subject: Re: Regression in Linux 5.5.0-rc[1-5]: btrfs send/receive out of memory
To:     Craig Andrews <candrews@integralblue.com>
Cc:     =?UTF-8?Q?St=C3=A9phane_Lesimple?= <stephane_btrfs2@lesimple.fr>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 28, 2020 at 2:46 PM Craig Andrews <candrews@integralblue.com> w=
rote:
>
> On 2020-01-27 08:44, Filipe Manana wrote:
> > On Sat, Jan 25, 2020 at 11:18 AM St=C3=A9phane Lesimple
> > <stephane_btrfs2@lesimple.fr> wrote:
> >>
> >> > ERROR: failed to clone extents to var/amavis/db/__db.001: Invalid ar=
gument
> >>
> >> If I may add another data point here, I'm also encountering this issue
> >> on a 5.5.0-rc6, with the btrfs-rc7 patches applied to it (so as far as
> >> btrfs is concerned, this is an rc7).
> >>
> >> On the first time, it happened after sending ~90 Gb worth of data, and
> >> aborted (as I didn't specify the -E option to btrfs send). Then, I
> >> retried with btrfs send -E 0, and it encountered the exact same error
> >> on the same file.
> >>
> >> # btrfs send -v /tank/backups/.snaps/incoming/sendme/ | pv
> >> 2>/dev/pts/23 | btrfs rec -E 0 /newfs/
> >> At subvol /tank/backups/.snaps/incoming/sendme/
> >> At subvol sendme
> >> ERROR: failed to clone extents to
> >> retroarch/x86_64/cores/mednafen_saturn_libretro.dll: Invalid argument
> >> ERROR: failed to clone extents to
> >> retroarch/x86_64/cores/mednafen_saturn_libretro.dll: Invalid argument
> >
> > This is probably the same case for which I sent a fix last week:
> >
> > https://patchwork.kernel.org/patch/11350129/
> >
> > Thanks.
>
> I applied that patch to 5.5.0-rc7 and that solved the problem. I can now
> do backups (which is a send/receive) successfully.
>
> >
> >>
> >> The send/receive is still going on for now, currently around the ~200
> >> Gb mark.
> >>
> >> Bees is running on this FS (but I stopped it before doing the
> >> send/receive).
> >>
> >> I can test patches if needed.
> >>
> >> --
> >> St=C3=A9phane.
>
> The patch appears to have fixed my problems - thank you!

Great!

Can you reply to the patch's thread with a:

Tested-by: Your Name <email@foo.bar>

?

Or I can reply to it myself with that if you agree.

Thanks!

> ~Craig



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
