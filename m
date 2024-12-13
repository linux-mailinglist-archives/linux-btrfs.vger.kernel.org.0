Return-Path: <linux-btrfs+bounces-10364-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 576C09F191C
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 23:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99311188EDD3
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Dec 2024 22:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E1D19343E;
	Fri, 13 Dec 2024 22:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/KrpNkZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1958194C77
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2024 22:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734129003; cv=none; b=jnVqG4ZHL/QCNnC/RqP5hwZUAB3zkHunaXutqJ7C5EghQ5mpLoiXvDlJAqEjN++pWJMKaHnbwTIOdQahheOMWhpf8fAqxfXabVC0z9iQtCicvaJjKIolne0ubheTtKGie4nlIYpuifOJIuU9SMasXi7m3adqbqJ4xXhSXhxb/+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734129003; c=relaxed/simple;
	bh=gcoOK/RYIgAR75kYkT3QDvNFSGIuh9OBvLVTn9X1A6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJ4fcFMCqu2Kur0X1Y/m+XiGa235r3+imivkSQ0Gocf8bUBuabJAQdNoJdfLc+uhn4+rqMkrxGwNkdvdwOaSEIt/W2crhP08HWtrXuk19rt1KDzI3K3bNvmWMykUOuwuh/YkBYUKfHUqAbNRV0X2MhkDPl7Mf8CvPWiHcIgsXto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/KrpNkZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B0AC4CED0
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2024 22:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734129002;
	bh=gcoOK/RYIgAR75kYkT3QDvNFSGIuh9OBvLVTn9X1A6M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P/KrpNkZBMHN22Tur9O619MtZgnrNdmwau0OupKxbZ8hzfKGOdUDIay2OVYTcjNmD
	 +XWLj5QYHlbgN5aC/FhOq+wuHl8rwGsjc+eeifqy9M3QWhx5rU/2IWjUueTZf4vt6a
	 Jcy9jhScW1NrxXucOTgORCEF8oYVm9r5Mi6VHo5HBcwGKckkPtYskrRcQ9v1+lDG/Y
	 5v77mGc+5wxjCDKGsofiBiiGJNRXEWOLNd2Z6zbOnYUvrfUIg4gjDP+iWG/fDJOu7e
	 Zsq4N3d72mJOhUGsV24+oiSAM45bb7963OLnhV8ViFuSMA3nCz5XlOFOz1cPwa2WBT
	 MQ79CIkaqNq5g==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa689a37dd4so415424666b.3
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Dec 2024 14:30:02 -0800 (PST)
X-Gm-Message-State: AOJu0YyW3GAovAU4EL8vGTpSTjiNb4aTSxhmZCtrArh7Xh+auSznJdfo
	eVrOaa5iDqS46XLEhAHROuDO3RxOz2CwcIFjWcRnux+4++JctVvTdyPQ/+YD/2z1eOTHlX+3HnF
	5vdk9LjOvUTuB2yNcR7mYvqN7PAE=
X-Google-Smtp-Source: AGHT+IEpbc+P6I4oY9h5a3msezyj9QO3ag9wul1ak7tinQq51fTHvdVYUPDUcoPHt+sUOlC6wrbzz5s11SvqoBMp8xY=
X-Received: by 2002:a17:906:3147:b0:aa6:9198:75a6 with SMTP id
 a640c23a62f3a-aab7790a05emr374667966b.21.1734129001141; Fri, 13 Dec 2024
 14:30:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733929327.git.fdmanana@suse.com> <4d5d175428bb38d17fc2214f8f31f511298ba67f.1733929328.git.fdmanana@suse.com>
 <003eb5c9-188c-4235-9700-32bc0257ad41@gmx.com>
In-Reply-To: <003eb5c9-188c-4235-9700-32bc0257ad41@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 13 Dec 2024 22:29:24 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5fYu6vypgzgNHrGb3h0_gentH2mnTT2F2o4rOTDPVR6A@mail.gmail.com>
Message-ID: <CAL3q7H5fYu6vypgzgNHrGb3h0_gentH2mnTT2F2o4rOTDPVR6A@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] btrfs: add assertions and comment about path
 expectations to btrfs_cross_ref_exist()
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 9:04=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/12/12 01:35, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > We should always call check_delayed_ref() with a path having a locked l=
eaf
> > from the extent tree where either the extent item is located or where i=
t
> > should be located in case it doesn't exist yet (when there's a pending
> > unflushed delayed ref to do it), as we need to lock any existing delaye=
d
> > ref head while holding such leaf locked in order to avoid races with
> > flushing delayed references, which could make us think an extent is not
> > shared when it really is.
> >
> > So add some assertions and a comment about such expectations to
> > btrfs_cross_ref_exist(), which is the only caller of check_delayed_ref(=
).
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Just a small nitpick.
> > ---
> >   fs/btrfs/extent-tree.c | 25 +++++++++++++++++++++++++
> >   fs/btrfs/locking.h     |  5 +++++
> >   2 files changed, 30 insertions(+)
> >
> > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > index bd13059299e1..0f30f53f51b9 100644
> > --- a/fs/btrfs/extent-tree.c
> > +++ b/fs/btrfs/extent-tree.c
> > @@ -2426,6 +2426,31 @@ int btrfs_cross_ref_exist(struct btrfs_inode *in=
ode, u64 offset,
> >               if (ret && ret !=3D -ENOENT)
> >                       goto out;
> >
> > +             /*
> > +              * The path must have a locked leaf from the extent tree =
where
> > +              * the extent item for our extent is located, in case it =
exists,
> > +              * or where it should be located in case it doesn't exist=
 yet
> > +              * because it's new and its delayed ref was not yet flush=
ed.
> > +              * We need to lock the delayed ref head at check_delayed_=
ref(),
> > +              * if one exists, while holding the leaf locked in order =
to not
> > +              * race with delayed ref flushing, missing references and
> > +              * incorrectly reporting that the extent is not shared.
> > +              */
> > +             if (IS_ENABLED(CONFIG_BTRFS_ASSERT)) {
>
> I think we can just get rid of the CONFIG_BTRFS_ASSERT() check.
>
> All the assert functions have already done the check anyway.
> We only skip the btrfs_item_key_to_cpu() call which shouldn't be that
> costly.

It's done this way because otherwise it may trigger warnings from
compilers or static analysis tools if assertions are disabled.
As in that case we write to the key structure but never read from it.

Thanks.

>
> Thanks,
> Qu
> > +                     struct extent_buffer *leaf =3D path->nodes[0];
> > +
> > +                     ASSERT(leaf !=3D NULL);
> > +                     btrfs_assert_tree_read_locked(leaf);
> > +
> > +                     if (ret !=3D -ENOENT) {
> > +                             struct btrfs_key key;
> > +
> > +                             btrfs_item_key_to_cpu(leaf, &key, path->s=
lots[0]);
> > +                             ASSERT(key.objectid =3D=3D bytenr);
> > +                             ASSERT(key.type =3D=3D BTRFS_EXTENT_ITEM_=
KEY);
> > +                     }
> > +             }
> > +
> >               ret =3D check_delayed_ref(inode, path, offset, bytenr);
> >       } while (ret =3D=3D -EAGAIN && !path->nowait);
> >
> > diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
> > index 35036b151bf5..c69e57ff804b 100644
> > --- a/fs/btrfs/locking.h
> > +++ b/fs/btrfs/locking.h
> > @@ -199,8 +199,13 @@ static inline void btrfs_assert_tree_write_locked(=
struct extent_buffer *eb)
> >   {
> >       lockdep_assert_held_write(&eb->lock);
> >   }
> > +static inline void btrfs_assert_tree_read_locked(struct extent_buffer =
*eb)
> > +{
> > +     lockdep_assert_held_read(&eb->lock);
> > +}
> >   #else
> >   static inline void btrfs_assert_tree_write_locked(struct extent_buffe=
r *eb) { }
> > +static inline void btrfs_assert_tree_read_locked(struct extent_buffer =
*eb) { }
> >   #endif
> >
> >   void btrfs_unlock_up_safe(struct btrfs_path *path, int level);
>

