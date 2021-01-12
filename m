Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04652F2DE7
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Jan 2021 12:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbhALL2k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Jan 2021 06:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbhALL2j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Jan 2021 06:28:39 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34082C061575
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jan 2021 03:27:59 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id b64so1477392qkc.12
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Jan 2021 03:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=4lDHSAyNMX4m9tBUlOC+mc2wXgMUbNsavLNBluCzDt4=;
        b=bXeL9E3kbflamz5/xxx5MJKtLCVBbH0nQfldr6RSmOrcuKTLqIymVjbNVegnvz6f32
         y+OLPkiGXqPfc6Mk8CcMC8r4rw+Bntfnlv4mvyBB/Vrs/jO46mSqzwmq9r6vtUEpTxWz
         2SRrkpkHbkbblMLkfPkZBKXZelKONjbKmBeYupGyVXA4Hm+dd3wSPjrUlaiFRF/+89Lv
         J/Q4pz8yvUPGEjvpbD2GUvvXYQRt5Cgy5xBdGY/TbuyaQfmrQsVTexaHaOrO4/Ej/ysD
         wDaxEmUJQ5IcMt/pMhjM2o44CtYzKdaJkmKpB316m3XxxgxBMc2KerI0StUia09II6fU
         7yTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=4lDHSAyNMX4m9tBUlOC+mc2wXgMUbNsavLNBluCzDt4=;
        b=gPjF+OesOdbTk1MDB5b2qNLvH6GfWJ3GM+CzPCn3tb5lMM5XE03Ql9k27XT5rzZ4y9
         9m6tIJSacO+g1YuBI8L6+YoGpH0y/6IL5OW0lCf55qbYkzJyhaxxgU6FuoAN7oMwQ1qN
         ZFWAPwkzO+bZgiKNi+lcw4cggtsFrtoSRM8jRvKLec7LpXrKD+B08j7RFFk+1CfOVu9d
         2Yn5JwvOnczh6BHDbWfRTa2Va/5SSr2dNQ85GgBnwpFVqN8haf91yAdZ532M7R0HwxyI
         mmStQ55RU7ddWchv7JoVroPaw1U5j+GmSB9XbgTcv02MznuUW0tnzR9g4PDwqrEQBnZr
         oxQw==
X-Gm-Message-State: AOAM531c25L5bwx27JmkFeZQUt8ADKqcMpqGMwXXGiSlStnlrOoeNUFX
        Dktjf6eaGMmqovstDhUJkAkH3XgmWlAAF9txruLgpnAYVUE=
X-Google-Smtp-Source: ABdhPJyQsczMIxy8aEStsacn1bOjmU+wyYCvlxGKdz+wl9NyTo8ovNgP6gKk1i1O84VN/DS75Ct4FfGGnIaLcB9B110=
X-Received: by 2002:ae9:e8c5:: with SMTP id a188mr3944074qkg.479.1610450878358;
 Tue, 12 Jan 2021 03:27:58 -0800 (PST)
MIME-Version: 1.0
References: <20210111190243.4152-1-roman.anasal@bdsu.de> <20210111190243.4152-3-roman.anasal@bdsu.de>
 <9e177865-0408-c321-951e-ce0f3ff33389@gmail.com> <424d62853024d8b0bc5ca03206eeca35be6014a2.camel@bdsu.de>
In-Reply-To: <424d62853024d8b0bc5ca03206eeca35be6014a2.camel@bdsu.de>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 12 Jan 2021 11:27:47 +0000
Message-ID: <CAL3q7H6YOPgcdgJKX8OETqrKqmfz8GRkQykPOQBMmnNSsc4sxw@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: send: fix invalid commands for inodes with
 changed type but same gen
To:     "Roman Anasal | BDSU" <roman.anasal@bdsu.de>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "arvidjaar@gmail.com" <arvidjaar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 12, 2021 at 9:42 AM Roman Anasal | BDSU
<roman.anasal@bdsu.de> wrote:
>
> On Mon, 2021-01-11 at 22:30 +0300, Andrei Borzenkov wrote:
> > 11.01.2021 22:02, Roman Anasal =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > > When doing a send, if a new inode has the same number as an inode
> > > in the
> > > parent subvolume it will only be detected as to be recreated when
> > > the
> > > genrations differ. But with inodes in the same generation the
> > > emitted
> > > commands will cause the receiver to fail.
> > >
> > > This case does not happen when doing incremental sends with
> > > snapshots
> > > that are kept read-only by the user all the time, but it may happen
> > > if
> > > - a snapshot was modified after it was created
> > > - the subvol used as parent was created independently from the sent
> > > subvol
> > >
> > > Example reproducers:
> > >
> > >   # case 1: same ino at same path
> > >   btrfs subvolume create subvol1
> > >   btrfs subvolume create subvol2
> > >   mkdir subvol1/a
> > >   touch subvol2/a
> >
> > What happens in case of
> >
> > echo foo > subvol1/a
> > echo bar > subvol2/a
> >
> > ?
>
> `echo foo > subvol1/a` wouldn't work since subvol1/a is a directory.
> However, replacing both preceding lines with:
>
>   mkdir subvol1/a
>   echo bar > subvol2/a
>
> =3D> same as before with/without the patch, plus an additional write
> command for the content
>
> And with both lines as
>
>   echo foo > subvol1/a
>   echo bar > subvol2/a
>
> =3D> produces an invalid stream (with and without this patch) with a
> `link a -> a` followed by `unlink a` as seen in the example output
> quoted further below.
>
> So there is another bug here. The conditions for this seem to roughly
> be: changed/new inode with same number, type and generation, since
> reordering the commands so the inodes have different generations
> produces a valid stream.
>
> Changing the name to subvol2/b like in the second case below produces a
> valid stream with a `link b -> a` followed by `unlink a`.
>
> I'll take a look into this, too, and if possible provide another patch
> for that case.
>
>
> > >   btrfs property set subvol1 ro true
> > >   btrfs property set subvol2 ro true
> > >   btrfs send -p subvol1 subvol2 | btrfs receive --dump

You get all these issues because you are using an incremental send in
a way it's not supposed to.
You are using two subvolumes that are completely unrelated.

My surprise here is that we actually allow a user to try that, instead
of giving an error complaining that subvol1 and subvol2 aren't
snapshots of the same subvolume.

An incremental is supposed to work on snapshots of the same subvolume
(hence, have the same parent uuid).
That's what the entire code relies on to work correctly, and that's
what makes sense - to compute and send the differences between two
points in time of a subvolume.
That's why the code base assumes that inodes with the same number and
same generation must refer to the same inode in both the parent and
the send root.

What I think that needs to be answered is:

1) Are there actually people using incremental sends in that way?
(It's the first time I see such use case)

2) If so, why? That is completely unreliable, not only it can lead to
failure to apply the streams, but can result in all sorts of weirdness
(logical inconsistencies, etc) if applying such streams doesn't cause
an error.

3) Making sure such use cases work reliably would require many, many
changes to the send implementation, as it goes against what it
currently expects.
    Snapshot a subvolume, change the subvolume, snapshot it again,
then use both snapshots for the incremental send, that's the expected
scenario.

In other words, what I think we should have is a check that forbids
using two roots for an incremental send that are not snapshots of the
same subvolume (have different parent uuids).

Thanks.


> > >
> > > The produced tree state here is:
> > >   |-- subvol1
> > >   |   `-- a/        (ino 257)
> > >   |
> > >   `-- subvol2
> > >       `-- a         (ino 257)
> > >
> > >   Where subvol1/a/ is a directory and subvol2/a is a file with the
> > > same
> > >   inode number and same generation.
> > >
> > > Example output of the receive command:
> > >   At subvol subvol2
> > >   snapshot        ./subvol2                       uuid=3D19d2be0a-
> > > 5af1-fa44-9b3f-f21815178d00 transid=3D9 parent_uuid=3D1bac8b12-ddb2-
> > > 6441-8551-700456991785 parent_transid=3D9
> > >   utimes          ./subvol2/                      atime=3D2021-01-
> > > 11T13:41:36+0000 mtime=3D2021-01-11T13:41:36+0000 ctime=3D2021-01-
> > > 11T13:41:36+0000
> > >   link            ./subvol2/a                     dest=3Da
> > >   unlink          ./subvol2/a
> > >   utimes          ./subvol2/                      atime=3D2021-01-
> > > 11T13:41:36+0000 mtime=3D2021-01-11T13:41:36+0000 ctime=3D2021-01-
> > > 11T13:41:36+0000
> > >   chmod           ./subvol2/a                     mode=3D644
> > >   utimes          ./subvol2/a                     atime=3D2021-01-
> > > 11T13:41:36+0000 mtime=3D2021-01-11T13:41:36+0000 ctime=3D2021-01-
> > > 11T13:41:36+0000
> > >
> > > =3D> the `link` command causes the receiver to fail with:
> > >    ERROR: link a -> a failed: File exists
> > >
> > > Second example:
> > >   # case 2: same ino at different path
> > >   btrfs subvolume create subvol1
> > >   btrfs subvolume create subvol2
> > >   mkdir subvol1/a
> > >   touch subvol2/b
> > >   btrfs property set subvol1 ro true
> > >   btrfs property set subvol2 ro true
> > >   btrfs send -p subvol1 subvol2 | btrfs receive --dump
> > >
> > > The produced tree state here is:
> > >   |-- subvol1
> > >   |   `-- a/        (ino 257)
> > >   |
> > >   `-- subvol2
> > >       `-- b         (ino 257)
> > >
> > >   Where subvol1/a/ is a directory and subvol2/b is a file with the
> > > same
> > >   inode number and same generation.
> > >
> > > Example output of the receive command:
> > >   At subvol subvol2
> > >   snapshot        ./subvol2                       uuid=3Dea93c47a-
> > > 5f47-724f-8a43-e15ce745aef0 transid=3D20 parent_uuid=3Df03578ef-5bca-
> > > 1445-a480-3df63677fddf parent_transid=3D20
> > >   utimes          ./subvol2/                      atime=3D2021-01-
> > > 11T13:58:00+0000 mtime=3D2021-01-11T13:58:00+0000 ctime=3D2021-01-
> > > 11T13:58:00+0000
> > >   link            ./subvol2/b                     dest=3Da
> > >   unlink          ./subvol2/a
> > >   utimes          ./subvol2/                      atime=3D2021-01-
> > > 11T13:58:00+0000 mtime=3D2021-01-11T13:58:00+0000 ctime=3D2021-01-
> > > 11T13:58:00+0000
> > >   chmod           ./subvol2/b                     mode=3D644
> > >   utimes          ./subvol2/b                     atime=3D2021-01-
> > > 11T13:58:00+0000 mtime=3D2021-01-11T13:58:00+0000 ctime=3D2021-01-
> > > 11T13:58:00+0000
> > >
> > > =3D> the `link` command causes the receiver to fail with:
> > >    ERROR: link b -> a failed: Operation not permitted
> > >
> > > Signed-off-by: Roman Anasal <roman.anasal@bdsu.de>



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
