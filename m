Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 879CE14BEA3
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jan 2020 18:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgA1Rde (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jan 2020 12:33:34 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:34070 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgA1Rde (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jan 2020 12:33:34 -0500
Received: by mail-vk1-f195.google.com with SMTP id w67so3963572vkf.1
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Jan 2020 09:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=oqcG6VXdy0JgfOhnh+gZkMvpTlPIEktRq35pp0jIPg8=;
        b=XAeYAMSosRlnYKW7b+nDnOoZ2mEDGgfHyVcufFoJIFoH/OMBuRftqiQyoh7YbqYnk5
         KiQBqiVA5bcHEHj14VSriX11Q9Z968+ZU8RftusqjeqkcueQpq2cGOi2msMDywX+HvbZ
         YJyj7e1bKoQx0zXhkcL2cCtPPS0Q1MaCHSG4JyFMzURH53CKuU+5H3TlXspgz1Rv9Gus
         5xp/LCvCM3ulYt3FSrQU5CCBr2xb4CNQIQ1rFO+ofBFE+/7bcdaxNWRpqcPthDj8uncf
         mcjr00xLDVRIjsh5lt5HOt3VHGt2TYPqYhNKzIlPF0+cPeFl+0wsRcUclQ7WsbKXiF0H
         Pbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=oqcG6VXdy0JgfOhnh+gZkMvpTlPIEktRq35pp0jIPg8=;
        b=Z89Wu329cuzWH3DkGF3m6tHRfJ+HHQM4iWUZW+rjPMxsswb2Kmt5XVI8/bptJelld3
         IdQttcwWNOrSeW0ykmwEYcUt3dQK6XDnQAGM+9PDM/kYJ8ILcdxLXmVjsQN1OTXDJwFe
         UdNHIDGRnYWBI3LM0nAGBUYNZF4TIYxcxI93iwSpWn1+A6Z53NBlmVzFm4tLtRU1Jqbd
         keb9We4RNfQttaq1hfNDErEPq+qnaRVfaU+qWFemYsUT31aQ9AR3iaM6jQdwmOvBUWIO
         NFAdTDdSomyA1yhd/TSchvee21XeuHmPzaQUiN4feuDL5cBLviklq35zMe8YPW37Skt+
         GNmw==
X-Gm-Message-State: APjAAAXg+eoO6sq9YRHCNnBL/WAUDnrjrfgPyigLNHXQyoCu1eeTI4vq
        IidckPBY6Ikb+kkxdjY3kGah3FbhSCDFBa9Gwnw=
X-Google-Smtp-Source: APXvYqxSWyOuaynOGHLIN1FTl7gSB8AQ8JCgpmPbCM9Lgm1mU7kNQx4k1z48v5BwRqw3x4pfEo1HbOEYhuWCQEDC6C4=
X-Received: by 2002:a1f:f283:: with SMTP id q125mr13811343vkh.69.1580232812828;
 Tue, 28 Jan 2020 09:33:32 -0800 (PST)
MIME-Version: 1.0
References: <5ba0716449eb4f838699fc0b1fb5b024@integralblue.com>
 <20200113133741.GU3929@twin.jikos.cz> <7e7e4f63a89b6bb8a270d4c4ec676835@integralblue.com>
 <8254df450ca61dd4cbc455f19ee28c01@lesimple.fr> <CAL3q7H4-3Mg2GUf2JMMFem77sSQR5opN9dxdvHz2kk1Qd=RD=A@mail.gmail.com>
 <06639bb0a512aff6ed8a41bffb033f35@integralblue.com> <CAL3q7H5FHc9ooNOP3CnXas=_H_BEZN5mzegVMuvtoXgT9nxL6A@mail.gmail.com>
 <f2ca887d98c1b5aacc4dde88cba74d98@integralblue.com> <CAL3q7H62m7CR53zHJVY1S_YuPS7V1CJK=5C7AHqir_WWBXbvNQ@mail.gmail.com>
In-Reply-To: <CAL3q7H62m7CR53zHJVY1S_YuPS7V1CJK=5C7AHqir_WWBXbvNQ@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 28 Jan 2020 17:33:21 +0000
Message-ID: <CAL3q7H6PyFFP1sM10U51oJs3vAPCED5AT+TfKrTJgsMUSB2qig@mail.gmail.com>
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

On Tue, Jan 28, 2020 at 3:08 PM Filipe Manana <fdmanana@gmail.com> wrote:
>
> On Tue, Jan 28, 2020 at 3:05 PM Craig Andrews <candrews@integralblue.com>=
 wrote:
> >
> > On 2020-01-28 10:02, Filipe Manana wrote:
> > > On Tue, Jan 28, 2020 at 2:46 PM Craig Andrews
> > > <candrews@integralblue.com> wrote:
> > >>
> > >> On 2020-01-27 08:44, Filipe Manana wrote:
> > >> > On Sat, Jan 25, 2020 at 11:18 AM St=C3=A9phane Lesimple
> > >> > <stephane_btrfs2@lesimple.fr> wrote:
> > >> >>
> > >> >> > ERROR: failed to clone extents to var/amavis/db/__db.001: Inval=
id argument
> > >> >>
> > >> >> If I may add another data point here, I'm also encountering this =
issue
> > >> >> on a 5.5.0-rc6, with the btrfs-rc7 patches applied to it (so as f=
ar as
> > >> >> btrfs is concerned, this is an rc7).
> > >> >>
> > >> >> On the first time, it happened after sending ~90 Gb worth of data=
, and
> > >> >> aborted (as I didn't specify the -E option to btrfs send). Then, =
I
> > >> >> retried with btrfs send -E 0, and it encountered the exact same e=
rror
> > >> >> on the same file.
> > >> >>
> > >> >> # btrfs send -v /tank/backups/.snaps/incoming/sendme/ | pv
> > >> >> 2>/dev/pts/23 | btrfs rec -E 0 /newfs/
> > >> >> At subvol /tank/backups/.snaps/incoming/sendme/
> > >> >> At subvol sendme
> > >> >> ERROR: failed to clone extents to
> > >> >> retroarch/x86_64/cores/mednafen_saturn_libretro.dll: Invalid argu=
ment
> > >> >> ERROR: failed to clone extents to
> > >> >> retroarch/x86_64/cores/mednafen_saturn_libretro.dll: Invalid argu=
ment
> > >> >
> > >> > This is probably the same case for which I sent a fix last week:
> > >> >
> > >> > https://patchwork.kernel.org/patch/11350129/
> > >> >
> > >> > Thanks.
> > >>
> > >> I applied that patch to 5.5.0-rc7 and that solved the problem. I can
> > >> now
> > >> do backups (which is a send/receive) successfully.
> > >>
> > >> >
> > >> >>
> > >> >> The send/receive is still going on for now, currently around the =
~200
> > >> >> Gb mark.
> > >> >>
> > >> >> Bees is running on this FS (but I stopped it before doing the
> > >> >> send/receive).
> > >> >>
> > >> >> I can test patches if needed.
> > >> >>
> > >> >> --
> > >> >> St=C3=A9phane.
> > >>
> > >> The patch appears to have fixed my problems - thank you!
> > >
> > > Great!
> > >
> > > Can you reply to the patch's thread with a:
> > >
> > > Tested-by: Your Name <email@foo.bar>
> > >
> > > ?
> > >
> > > Or I can reply to it myself with that if you agree.
> > >
> > > Thanks!
> > >
> > >> ~Craig
> >
> >
> > Can you please send the reply?
> > Tested-by: Craig Andrews <candrews@integralblue.com>
>
> No problem, done. Thanks.

Actually I just realized one chunk of the patch can cause problems
with fallocated extents beyond a file's size and a hole that ends
right at the file's size (unlikely to be a common scenario anyway).
I also don't think it's needed. For my tests at least, removing it
doesn't cause any new problems and solves the problem with the invalid
clone operations.

Can you try it for your use case too?

To be clear, this is the new version of the patch:

https://pastebin.com/raw/vewZiG9J

(A shorter version of the original)

Thanks!



>
> >
> > And again, thank you!
> > ~Craig
>
>
>
> --
> Filipe David Manana,
>
> =E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you'=
re right.=E2=80=9D



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
