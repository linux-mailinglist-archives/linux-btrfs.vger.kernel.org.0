Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 872B014BC96
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jan 2020 16:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgA1PIZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jan 2020 10:08:25 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:39974 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgA1PIZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jan 2020 10:08:25 -0500
Received: by mail-vk1-f194.google.com with SMTP id c129so3713576vkh.7
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Jan 2020 07:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=8my/dSJqjTW5jiGX1eBr678dfyFMSgl+Zf0aYdJUCu4=;
        b=regJ7GcaUcl8brpuDSGuiUcYWFJ78RgXh36jlzCHml7oVMKMldzFbr//9EWlM2zU3H
         tQ8Fhze8LyEgKoPtSU6EpnBzgCebZ5QaYReosmoCpAOuun79zHvYJ1CyBxV1t6tTG96x
         8Oy0T+mTNQQ0zfR/++qYDU+fF/8c1YEFhmLKME27N6Tsz6U+2ZhiYUD3Z41JgmyTm8XZ
         8oaCPcyiuY1siEZRN0YvrkX7qVf7rC8RrgB4GaZ+5JNgTP2nURcb5xJnZcF+4IFX6gOo
         DCPXTth9SORPP4axpD0eCI2yKMv6jGlg2KR8Ev0yaIVzLRz3eqsGwoElkv2zhLZZ0PVu
         YeMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=8my/dSJqjTW5jiGX1eBr678dfyFMSgl+Zf0aYdJUCu4=;
        b=VrWgajAJi8rcnRdVpadqygrnTWQ5LOdtwUDL3ektSpApGtqZyWm+1sjgRD2rcprt1w
         sbK5MD+jIjyGxBLKyMvRkZScG9Lnvx9fjVdStnmSkgjUEmCHt5cNrBPXx/aaAgAtM+Wq
         8ljSEihuuuACKyDJfEbp1MLiTYufI6l+5uAIDjt2pLqAZ2q37zcqBNHJQdMmbOwolopM
         aTHgORGnTRYRMVki6CVpsjwy+FWvRnmdaANLeUNRDxBuaVKIdU9AN3kKb4mQL+7Fp1Am
         +bk4dQe+jn9KZT7hCmiOch9gnrBC0kFJkPeJyx/05IQgf7ReuPjnAyPHZQW7P/SXU2DG
         LQMA==
X-Gm-Message-State: APjAAAXgjokaCKxPVt/Le1rkXP3TIDRLoh2K4j63P/4mqUywU6LEl4n+
        BjjSs1JGGM3mM8c6PmL1phtCa3DXu6067K5vnQYMaw==
X-Google-Smtp-Source: APXvYqynXNZzg+CBm7mi4602sY8r02iZVvL/WbC6Gp8q/+QQV+iw9+08v//EDJri/+Ebk1s0O8/YRksz5TkMCHm48I0=
X-Received: by 2002:a05:6122:1065:: with SMTP id k5mr13023650vko.14.1580224103995;
 Tue, 28 Jan 2020 07:08:23 -0800 (PST)
MIME-Version: 1.0
References: <5ba0716449eb4f838699fc0b1fb5b024@integralblue.com>
 <20200113133741.GU3929@twin.jikos.cz> <7e7e4f63a89b6bb8a270d4c4ec676835@integralblue.com>
 <8254df450ca61dd4cbc455f19ee28c01@lesimple.fr> <CAL3q7H4-3Mg2GUf2JMMFem77sSQR5opN9dxdvHz2kk1Qd=RD=A@mail.gmail.com>
 <06639bb0a512aff6ed8a41bffb033f35@integralblue.com> <CAL3q7H5FHc9ooNOP3CnXas=_H_BEZN5mzegVMuvtoXgT9nxL6A@mail.gmail.com>
 <f2ca887d98c1b5aacc4dde88cba74d98@integralblue.com>
In-Reply-To: <f2ca887d98c1b5aacc4dde88cba74d98@integralblue.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 28 Jan 2020 15:08:12 +0000
Message-ID: <CAL3q7H62m7CR53zHJVY1S_YuPS7V1CJK=5C7AHqir_WWBXbvNQ@mail.gmail.com>
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

On Tue, Jan 28, 2020 at 3:05 PM Craig Andrews <candrews@integralblue.com> w=
rote:
>
> On 2020-01-28 10:02, Filipe Manana wrote:
> > On Tue, Jan 28, 2020 at 2:46 PM Craig Andrews
> > <candrews@integralblue.com> wrote:
> >>
> >> On 2020-01-27 08:44, Filipe Manana wrote:
> >> > On Sat, Jan 25, 2020 at 11:18 AM St=C3=A9phane Lesimple
> >> > <stephane_btrfs2@lesimple.fr> wrote:
> >> >>
> >> >> > ERROR: failed to clone extents to var/amavis/db/__db.001: Invalid=
 argument
> >> >>
> >> >> If I may add another data point here, I'm also encountering this is=
sue
> >> >> on a 5.5.0-rc6, with the btrfs-rc7 patches applied to it (so as far=
 as
> >> >> btrfs is concerned, this is an rc7).
> >> >>
> >> >> On the first time, it happened after sending ~90 Gb worth of data, =
and
> >> >> aborted (as I didn't specify the -E option to btrfs send). Then, I
> >> >> retried with btrfs send -E 0, and it encountered the exact same err=
or
> >> >> on the same file.
> >> >>
> >> >> # btrfs send -v /tank/backups/.snaps/incoming/sendme/ | pv
> >> >> 2>/dev/pts/23 | btrfs rec -E 0 /newfs/
> >> >> At subvol /tank/backups/.snaps/incoming/sendme/
> >> >> At subvol sendme
> >> >> ERROR: failed to clone extents to
> >> >> retroarch/x86_64/cores/mednafen_saturn_libretro.dll: Invalid argume=
nt
> >> >> ERROR: failed to clone extents to
> >> >> retroarch/x86_64/cores/mednafen_saturn_libretro.dll: Invalid argume=
nt
> >> >
> >> > This is probably the same case for which I sent a fix last week:
> >> >
> >> > https://patchwork.kernel.org/patch/11350129/
> >> >
> >> > Thanks.
> >>
> >> I applied that patch to 5.5.0-rc7 and that solved the problem. I can
> >> now
> >> do backups (which is a send/receive) successfully.
> >>
> >> >
> >> >>
> >> >> The send/receive is still going on for now, currently around the ~2=
00
> >> >> Gb mark.
> >> >>
> >> >> Bees is running on this FS (but I stopped it before doing the
> >> >> send/receive).
> >> >>
> >> >> I can test patches if needed.
> >> >>
> >> >> --
> >> >> St=C3=A9phane.
> >>
> >> The patch appears to have fixed my problems - thank you!
> >
> > Great!
> >
> > Can you reply to the patch's thread with a:
> >
> > Tested-by: Your Name <email@foo.bar>
> >
> > ?
> >
> > Or I can reply to it myself with that if you agree.
> >
> > Thanks!
> >
> >> ~Craig
>
>
> Can you please send the reply?
> Tested-by: Craig Andrews <candrews@integralblue.com>

No problem, done. Thanks.

>
> And again, thank you!
> ~Craig



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
