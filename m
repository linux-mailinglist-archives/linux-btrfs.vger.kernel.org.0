Return-Path: <linux-btrfs+bounces-5067-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E3B8C8707
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2024 15:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2DF1F21C5E
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2024 13:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D5052F6D;
	Fri, 17 May 2024 13:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0V6wftd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C4D51004
	for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2024 13:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715951713; cv=none; b=rwzSedZzLQ2cisLpfE27c/XZQSd/LcAV/AVjaGgNw2qH/Yp1Arjvia/YoJfL/iq7IcCQ2CIo4VvMItoiiXcInV7J4wB/danKzwvBD9RWIQmSZ3Sw1dt5tbqHQvY+65TNw9ZOVbRsjTpFOMmJFxvKxwud024MswQToOKxDR30wdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715951713; c=relaxed/simple;
	bh=pdrOV5ljP0tTJUMHqAnxcHj46EyqxdwHcfFrRy9CAvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QK173sg1/v3MteSrdKubdwWR4T3DQ9LMKhg7f9uWFN/KcUQBRDSYZgwaQbszdJ8O9qGhKJBBOeSngJXYUe1TMMsFfdAqb0RIzgAKT0jUxHHoKudkF/GMEezjX12dYIsI6qKH3iOWnOQ3+Oo4T5u5ssb1XTycg4du1G8j0r3cuMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0V6wftd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0D8C2BD11
	for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2024 13:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715951713;
	bh=pdrOV5ljP0tTJUMHqAnxcHj46EyqxdwHcfFrRy9CAvo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P0V6wftdmCY+U0yASRYqYOb0lZjanKyAs3zoQEK4o5JIp96tU6Xm9zy1U3WvhpXSd
	 M1CEAsO+aeQ25caXK548LkaXPU/seR5CFWmfevumv3hzb5ptQ1R97oAhlLJ8DiwIdu
	 IltW7+/7tFyieLeoDR9+66hOP36kq8FsxtQquTB5qWQPe92fwfdHnIdkZLlP9vm7r2
	 A0lGbRiRK5aFLIynIQFoL9RjV/6PVPDtsQKDnIojpowaVRwQXo/69T6GEU/VZFJWBo
	 nZ+spVwIhCrlu3T1Yn5ryk+FMQRupc+74705AyszPXwQDtijZZrag1eSQJLwBjvAVs
	 k5/ZTpbO/dxAA==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-574f7c0bab4so5447474a12.0
        for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2024 06:15:13 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxkid/7eVDW/f3sHdeOJPjcMfHl/UkDNqzW1YYpL1vmnEMDW9oU
	e4QV7Q6XuxvWHAG77BuFM42ynuHzZcjEPLvlrBsI4K21oLCzjYgtjGhnKnoxHU+8dHM+7wnm0A/
	JZVDkZ6VoivndLeRtacR8cf4ODuw=
X-Google-Smtp-Source: AGHT+IH2XZqT7zEura0MgI6eCW8jJ0c7BScVCJs2Q51/yqWHzK24/S/7aiSCVNIaC8FPynvHk2XSFdJw01309sNC2pM=
X-Received: by 2002:a17:906:8315:b0:a59:c807:72d3 with SMTP id
 a640c23a62f3a-a5a2d1ddfebmr1903302166b.17.1715951711968; Fri, 17 May 2024
 06:15:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a4dfaf8ca94754560f4d9196b04ba763256124ce.1715873248.git.fdmanana@suse.com>
 <dd41526a-c594-4a1f-b535-d7869882fe4d@gmx.com>
In-Reply-To: <dd41526a-c594-4a1f-b535-d7869882fe4d@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 17 May 2024 14:14:34 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5JHmTsj8Go6x9u=KXR21qsbgh07TBAcc6zGRZv4S=rEQ@mail.gmail.com>
Message-ID: <CAL3q7H5JHmTsj8Go6x9u=KXR21qsbgh07TBAcc6zGRZv4S=rEQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: always set an inode's delayed_inode with WRITE_ONCE()
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 12:17=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com>=
 wrote:
>
>
>
> =E5=9C=A8 2024/5/17 00:58, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Currently we have a couple places using READ_ONCE() to access an inode'=
s
> > delayed_inode without taking the lock that protects the xarray for dela=
yed
> > inodes, while all the other places access it while holding the lock.
> >
> > However we never update the delayed_inode pointer of an inode with
> > WRITE_ONCE(), making the use of READ_ONCE() pointless since it should
> > always be paired with a WRITE_ONCE() in order to protect against issues
> > such as write tearing for example.
> >
> > So change all the places that update struct btrfs_inode::delayed_inode =
to
> > use WRITE_ONCE() instead of simple assignments.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> A quick search shows that we still have one call site not using READ_ONCE=
():
>
> Inside btrfs_dirty_inode() of inode.c we have
>
>         btrfs_end_transaction(trans);
>         if (inode->delayed_inode)
>                 btrfs_balance_delayed_items(fs_info);
>
> I guess we should also use READ_ONCE() for it?

Yep, however it may be harmless in that case I think, but still things
like KCSAN are likely to detect and report a data race there.
Just sent a patchset to cover that as well:
https://lore.kernel.org/linux-btrfs/cover.1715951291.git.fdmanana@suse.com/

Thanks.

>
> Thanks,
> Qu
>
> > ---
> >   fs/btrfs/delayed-inode.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> > index 483c141dc488..6df7e44d9d31 100644
> > --- a/fs/btrfs/delayed-inode.c
> > +++ b/fs/btrfs/delayed-inode.c
> > @@ -106,7 +106,7 @@ static struct btrfs_delayed_node *btrfs_get_delayed=
_node(
> >                */
> >               if (refcount_inc_not_zero(&node->refs)) {
> >                       refcount_inc(&node->refs);
> > -                     btrfs_inode->delayed_node =3D node;
> > +                     WRITE_ONCE(btrfs_inode->delayed_node, node);
> >               } else {
> >                       node =3D NULL;
> >               }
> > @@ -161,7 +161,7 @@ static struct btrfs_delayed_node *btrfs_get_or_crea=
te_delayed_node(
> >       ASSERT(xa_err(ptr) !=3D -EINVAL);
> >       ASSERT(xa_err(ptr) !=3D -ENOMEM);
> >       ASSERT(ptr =3D=3D NULL);
> > -     btrfs_inode->delayed_node =3D node;
> > +     WRITE_ONCE(btrfs_inode->delayed_node, node);
> >       xa_unlock(&root->delayed_nodes);
> >
> >       return node;
> > @@ -1312,7 +1312,7 @@ void btrfs_remove_delayed_node(struct btrfs_inode=
 *inode)
> >       if (!delayed_node)
> >               return;
> >
> > -     inode->delayed_node =3D NULL;
> > +     WRITE_ONCE(inode->delayed_node, NULL);
> >       btrfs_release_delayed_node(delayed_node);
> >   }
> >

