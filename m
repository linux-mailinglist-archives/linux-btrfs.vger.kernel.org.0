Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 052DE9DA06
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 01:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfHZXfr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Aug 2019 19:35:47 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:39311 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfHZXfq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Aug 2019 19:35:46 -0400
Received: by mail-wm1-f45.google.com with SMTP id i63so1075821wmg.4
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 16:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y80E0YVJkLaDR7Uf9nhOFdN4IupufXwTe7jwE/KJJKc=;
        b=E7hPeQ2uIMdW9CAf6oMD6zWKllJhF1Asl80wFCfzsx9APk6g4eBsEl/KMNfrfkys68
         1QQCsythbsQzUDlt6pi53gL3h2WuLIb47pj/64KhzGDNw6rHcordyfUyn0RuPCCpQkV1
         1lRHCrq7IrV4aHXShfsbZLHsSk1sjF/qaGFVM84tFzDbylXfoaRyrYRDBNMeXYzgZy6A
         Ew0jgMmT/rbXF6cStOQoJc6ko7AsMzwRTMAiWi+CQ12/1wl4aLSJkbjFpqojX/Jw02q1
         bHe4HOpPX2/3DQ48kC4a8CZx+HTRicw8pyvgXnxizuCpFUHefd49HBmbSvaHBFrw58PF
         ubKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y80E0YVJkLaDR7Uf9nhOFdN4IupufXwTe7jwE/KJJKc=;
        b=kf/tkUkPjVK7EHKdcljGJzCA45lUFv4HXFpTe8hd+ZjZDUY4/5yUGDtutdjaPXA687
         ZGBB75wOz8Y9LHIs11I/lrcPIr4T8m21J84Ir5bNxAfxWwPSF/spW7p29GF5PFE0rY9R
         9rJ2V29CVxPyBCImF1SGp2Cc5cYHqNTuSYkdYgvPL6YrDnfktDeBfapdruHtKxESLg1w
         BzL8DVmvh62MlrX0KtFbphxrj14KlIj/zJ/FaPPNXhTBk4Pcgpl66L5ed0ltnjzhk8RA
         Mr8lg5uO/+O1B+wEUTXpYsE/5r4bhT30JB1QI6XYsrdscOvhqXSWu+4/nZkX9l6Xvdgq
         TMaQ==
X-Gm-Message-State: APjAAAU1Se3Dj8KBgVwQLbuVHzKmDTKY0yBrdLAx/ETFzkeFgTLxKdNe
        FJsYZ2NmKhpS9mFIxlOOYOoNG5skDpG4HVd7nzuRPw==
X-Google-Smtp-Source: APXvYqwdLW1uV2NmgMjMPgxy9kGiqeiGJCQc80UNXXtB/j7Crk+J3ZcHDH0FSQnKP27iJzUL+B9i+HuJbrDkaoYlVns=
X-Received: by 2002:a1c:9ec5:: with SMTP id h188mr24583167wme.176.1566862544559;
 Mon, 26 Aug 2019 16:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtRij3ENFW3Gam+-JThg8LhewdpHKzJSfgcR-OPnvrSL=Q@mail.gmail.com>
 <CAJCQCtQZ-BH3vHaV6canyi+HA_Q2Ny_QryKFLtddyR7YME4dzQ@mail.gmail.com> <c5a80940-463b-ee5f-6c70-e13156c8e1ec@gmail.com>
In-Reply-To: <c5a80940-463b-ee5f-6c70-e13156c8e1ec@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 26 Aug 2019 17:35:33 -0600
Message-ID: <CAJCQCtR0EwJ05GEB_C8EpqyXTztAoGj_G0BrWGGsdpQarhoOYA@mail.gmail.com>
Subject: Re: shared extents, but no snapshots or reflinks
To:     Andrei Borzenkov <arvidjaar@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Aug 25, 2019 at 2:14 AM Andrei Borzenkov <arvidjaar@gmail.com> wrot=
e:
>
> 23.08.2019 6:19, Chris Murphy =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Thu, Aug 22, 2019 at 8:38 PM Chris Murphy <lists@colorremedies.com> =
wrote:
> >>
> >> There have previously been snapshots, typically prior to doing system
> >> updates. Is this an example of extents being pinned due to snapshots,
> >> and then extents updated and are now "stuck"? I'm kinda surprised, in
> >> that I'd expect most programs, especially RPM, are writing out new
> >> files entirely, then deleting obsolete files, then renaming. But...
> >> this suggests something is doing partial overwrites of file extents
> >> rather than replacements.
> >
> > It's databases. Databases are updating their files with block
> > overwrites, btrfs COWs them. And if there's a snapshot that exists
> > while COW happens, partial extents get pinned. This affects the
> > firefox database files, and also RPM's. It's a small effect on my
> > system, but it's a curious issue in particular if the files were much
> > larger.
> >
> >
>
> What exactly "pinned" means, why it happens and when it goes away?

Pinned by a snapshot, which seems to have prevented stale extents in a file
from being deleted (expected) but then upon subsequence deletion of the
snapshot, those pinned extents are not released. And yet several
database like files have "shared" extents reported by
filefrag -v.

The file must be completely replaced (cp, then rm, then mv)


> Comparing situation with and without shared extents - when you simply
> delete snapshot, it disappears:
>
>
>
> -       item 12 key (257 ROOT_ITEM 7) itemoff 13188 itemsize 439
> -               generation 7 root_dirid 256 bytenr 30670848 level 0 refs =
1
> -               lastsnap 7 byte_limit 0 bytes_used 16384 flags 0x1(RDONLY=
)
> -               uuid 5357e159-c577-d34b-8e0e-815767568a89
> -               parent_uuid 1dfec531-ef6e-4d2e-a93b-2a4e4c0e4682
> -               ctransid 6 otransid 7 stransid 0 rtransid 0
> -               ctime 1566719522.371361184 (2019-08-25 10:52:02)
> -               otime 1566719541.289249684 (2019-08-25 10:52:21)
> -               drop key (0 UNKNOWN.0 0) level 0
> -       item 13 key (257 ROOT_BACKREF 5) itemoff 13166 itemsize 22
> -               root backref key dirid 258 sequence 2 name snap
>
>
> but when there was shared extent (caused by partial overwrite) it is stuc=
k:
>
> -       item 12 key (257 ROOT_ITEM 7) itemoff 13188 itemsize 439
> -               generation 7 root_dirid 256 bytenr 30670848 level 0 refs =
1
> -               lastsnap 7 byte_limit 0 bytes_used 16384 flags 0x1(RDONLY=
)
> +       item 11 key (257 ROOT_ITEM 7) itemoff 13210 itemsize 439
> +               generation 7 root_dirid 256 bytenr 30670848 level 0 refs =
0
> +               lastsnap 7 byte_limit 0 bytes_used 16384 flags
> 0x1000000000001(RDONLY)
>
>
> Now the undecoded flag is
>
> /*
>  * Internal in-memory flag that a subvolume has been marked for deletion =
but
>  * still visible as a directory
>  */
> #define BTRFS_ROOT_SUBVOL_DEAD          (1ULL << 48)
>
> but it does not agree with comment - this flag is not "in memory", it is
> persistent (output above is from inspect-internal after filesystem is
> unmounted).
>
> So when this dead subvolume is going to be removed? This can cause quite
> real memory leak if it is stuck as long as original extent reference
> remains.

I didn't have any stale subvolumes only marked for deletion, they were
long gone (hours).

--=20
Chris Murphy
