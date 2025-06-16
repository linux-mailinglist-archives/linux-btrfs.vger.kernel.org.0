Return-Path: <linux-btrfs+bounces-14686-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA35ADBC43
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Jun 2025 23:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1BA73B3932
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Jun 2025 21:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A016227E8A;
	Mon, 16 Jun 2025 21:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3KHqhdh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABD8215787
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Jun 2025 21:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750110467; cv=none; b=lnnF/yFndMH7QrDiKmLG/vwetUn4srihgA+ztUvGteLwTRFivygIv+JToBjFuzRp2Mi25ni/5lx/iPM3eN0MGNdq4lmHxVOs3UySfrVSJ6Rs6rJ+LpK0N1QAZAI3BtJj1qU5zNPvEWJdg7CHIEnsxO8Rc7pDqOMMTF56MmC+0tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750110467; c=relaxed/simple;
	bh=L8d5hi1dAavoymFqJPp6YCohy86GfAoxkplFIMgFfHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WxuaCJsj3ptyFrCLS0eYbWZuN0v926na1j0rh0ziWs036r5ItVzwR7JFqDtZkXgfMQeOlhi0OvEJOeATUXrHEeKWxl2TovoKPD/g8M7X+iwDS1qm8ZqoccaEMR0JEoUREDzm5bvlfJLUIkbIviRZjSRWraLo59QVUMj7iH0KhVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3KHqhdh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35400C4CEEA
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Jun 2025 21:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750110467;
	bh=L8d5hi1dAavoymFqJPp6YCohy86GfAoxkplFIMgFfHs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S3KHqhdharR00ETibV0mB7H7/hfUVCzOKrPJBj+JZh8mfBtVnrVsKuzGYu4X9sWF7
	 0s1UzrjxrFjCfBkj4B3CzNJQQ4ZAnZukfvpxa+UJ17gYfNfE3SXjxihGDJ+EfDEjDS
	 8UI+l3XO3aX/gcdECotp+g+2WSSxpcV+sN4WGN2TiNdJo/SmnzFXbWth18tnC0pThy
	 oVdeuTRnsQog1QsLJSXabJ/V8hdGmEqgBmoQubv0iWMMXWsSLbYthKaCzvUx/JudkV
	 M8IsCLULfCC4SFWmpM5i05v+Udl8xLaNOe/5WAa1KPKh451XfyeB78QKvm/PeOaxP+
	 JvoaGWGH0bl/Q==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-adfb562266cso357289366b.0
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jun 2025 14:47:47 -0700 (PDT)
X-Gm-Message-State: AOJu0YyzqeTtmgUu/pF7K5FDj/p0kvYuIRxeCNmZfdH0BCAM7Rl96GCi
	YxZgNcdIrrb5zX4+KeeVr1CF3Qu9hzORubfUZaZzHr1PCLo4fIZFCdmwJfNqHExC2A7pXx0UWCH
	tLOQiwj9xxiA0ukMB3vIlA9+z1s87qz4=
X-Google-Smtp-Source: AGHT+IGxwwNgf6AwooCX8L/WoMmQ4fHCblCd+mPSiuH9B4KR8K1+PxY9WqhJfnAesLE2aGag+W8r3zfmx1McfXHmLlQ=
X-Received: by 2002:a17:907:3c83:b0:acb:5c83:25b with SMTP id
 a640c23a62f3a-adfad29e462mr1131709566b.7.1750110465716; Mon, 16 Jun 2025
 14:47:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749421865.git.fdmanana@suse.com> <40dd299a0b7551fb8163da00a6ed716a8f8c3d46.1749421865.git.fdmanana@suse.com>
 <20250616154458.GA812359@zen.localdomain> <CAL3q7H6Ojtu5zYuSVyZ+NrWhhPyYEKdrX4d4d3W6BVcfmKi1rQ@mail.gmail.com>
 <20250616164900.GA838931@zen.localdomain>
In-Reply-To: <20250616164900.GA838931@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 16 Jun 2025 22:47:09 +0100
X-Gmail-Original-Message-ID: <CAL3q7H77vqkhtO5Gtyvn+nf3J4Qmayd5PGw-Q1ZVYG+-u9hBKg@mail.gmail.com>
X-Gm-Features: AX0GCFsyEUNFvxaCXF7X4QL75vvWbrOpCUBPjW_kLnogGsYsS7Y7wbzDih1ioEA
Message-ID: <CAL3q7H77vqkhtO5Gtyvn+nf3J4Qmayd5PGw-Q1ZVYG+-u9hBKg@mail.gmail.com>
Subject: Re: [PATCH 3/3] btrfs: check BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE at __add_block_group_free_space()
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 5:49=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Mon, Jun 16, 2025 at 04:48:34PM +0100, Filipe Manana wrote:
> > On Mon, Jun 16, 2025 at 4:45=E2=80=AFPM Boris Burkov <boris@bur.io> wro=
te:
> > >
> > > On Sun, Jun 08, 2025 at 11:43:34PM +0100, fdmanana@kernel.org wrote:
> > > > From: Filipe Manana <fdmanana@suse.com>
> > > >
> > > > Every caller of __add_block_group_free_space() is checking if the f=
lag
> > > > BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE is set before calling it. This is
> > > > duplicate code and it's prone to some mistake in case we add more c=
allers
> > > > in the future. So move the check for that flag into the start of
> > > > __add_block_group_free_space().
> > > >
> > > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > > ---
> > > >  fs/btrfs/free-space-tree.c | 58 ++++++++++++++++++----------------=
----
> > > >  1 file changed, 28 insertions(+), 30 deletions(-)
> > > >
> > > > diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.=
c
> > > > index af005fb4b676..f03f3610b713 100644
> > > > --- a/fs/btrfs/free-space-tree.c
> > > > +++ b/fs/btrfs/free-space-tree.c
> > > > @@ -816,11 +816,9 @@ int __remove_from_free_space_tree(struct btrfs=
_trans_handle *trans,
> > > >       u32 flags;
> > > >       int ret;
> > > >
> > > > -     if (test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &block_group-=
>runtime_flags)) {
> > > > -             ret =3D __add_block_group_free_space(trans, block_gro=
up, path);
> > > > -             if (ret)
> > > > -                     return ret;
> > > > -     }
> > > > +     ret =3D __add_block_group_free_space(trans, block_group, path=
);
> > > > +     if (ret)
> > > > +             return ret;
> > > >
> > > >       info =3D search_free_space_info(NULL, block_group, path, 0);
> > > >       if (IS_ERR(info))
> > > > @@ -1011,11 +1009,9 @@ int __add_to_free_space_tree(struct btrfs_tr=
ans_handle *trans,
> > > >       u32 flags;
> > > >       int ret;
> > > >
> > > > -     if (test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &block_group-=
>runtime_flags)) {
> > > > -             ret =3D __add_block_group_free_space(trans, block_gro=
up, path);
> > > > -             if (ret)
> > > > -                     return ret;
> > > > -     }
> > > > +     ret =3D __add_block_group_free_space(trans, block_group, path=
);
> > > > +     if (ret)
> > > > +             return ret;
> > > >
> > > >       info =3D search_free_space_info(NULL, block_group, path, 0);
> > > >       if (IS_ERR(info))
> > > > @@ -1403,9 +1399,12 @@ static int __add_block_group_free_space(stru=
ct btrfs_trans_handle *trans,
> > > >                                       struct btrfs_block_group *blo=
ck_group,
> > > >                                       struct btrfs_path *path)
> > > >  {
> > > > +     bool own_path =3D false;
> > > >       int ret;
> > > >
> > > > -     clear_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &block_group->ru=
ntime_flags);
> > > > +     if (!test_and_clear_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE,
> > > > +                             &block_group->runtime_flags))
> > > > +             return 0;
> > > >
> > > >       /*
> > > >        * While rebuilding the free space tree we may allocate new m=
etadata
> > > > @@ -1430,10 +1429,19 @@ static int __add_block_group_free_space(str=
uct btrfs_trans_handle *trans,
> > > >        */
> > > >       set_bit(BLOCK_GROUP_FLAG_FREE_SPACE_ADDED, &block_group->runt=
ime_flags);
> > > >
> > > > +     if (!path) {
> > > > +             path =3D btrfs_alloc_path();
> > > > +             if (!path) {
> > > > +                     btrfs_abort_transaction(trans, -ENOMEM);
> > > > +                     return -ENOMEM;
> > > > +             }
> > > > +             own_path =3D true;
> > > > +     }
> > > > +
> > >
> > > Is the "own_path" change intended to be bundled with this one? If so,
> > > can you mention it in the commit message as well?
> >
> > Yes it's supposed, why wouldn't it?
> > This is because the path allocation from add_block_group_free_space()
> > has to be gone and done in this function now if it receives a NULL
> > path.
> >
> > I would think this is obvious since the diff for
> > add_block_group_free_space() removes the path allocation.
>
> That totally makes sense. All I'm asking for is a
> "Since add_block_group_free_space() conditionally allocated the path
> based on the check, move that allocation into
> __add_block_group_free_space() as well" in the commit message.

Ok, I'll add a note to the commit message before pushing to for-next.
Thanks.

>
> (or whatever equivalent you like)
>
> >
> > Thanks.
> >
> > >
> > > >       ret =3D add_new_free_space_info(trans, block_group, path);
> > > >       if (ret) {
> > > >               btrfs_abort_transaction(trans, ret);
> > > > -             return ret;
> > > > +             goto out;
> > > >       }
> > > >
> > > >       ret =3D __add_to_free_space_tree(trans, block_group, path,
> > > > @@ -1441,33 +1449,23 @@ static int __add_block_group_free_space(str=
uct btrfs_trans_handle *trans,
> > > >       if (ret)
> > > >               btrfs_abort_transaction(trans, ret);
> > > >
> > > > -     return 0;
> > > > +out:
> > > > +     if (own_path)
> > > > +             btrfs_free_path(path);
> > > > +
> > > > +     return ret;
> > > >  }
> > > >
> > > >  int add_block_group_free_space(struct btrfs_trans_handle *trans,
> > > >                              struct btrfs_block_group *block_group)
> > > >  {
> > > > -     struct btrfs_fs_info *fs_info =3D trans->fs_info;
> > > > -     struct btrfs_path *path =3D NULL;
> > > > -     int ret =3D 0;
> > > > +     int ret;
> > > >
> > > > -     if (!btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
> > > > +     if (!btrfs_fs_compat_ro(trans->fs_info, FREE_SPACE_TREE))
> > > >               return 0;
> > > >
> > > >       mutex_lock(&block_group->free_space_lock);
> > > > -     if (!test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &block_group=
->runtime_flags))
> > > > -             goto out;
> > > > -
> > > > -     path =3D btrfs_alloc_path();
> > > > -     if (!path) {
> > > > -             ret =3D -ENOMEM;
> > > > -             btrfs_abort_transaction(trans, ret);
> > > > -             goto out;
> > > > -     }
> > > > -
> > > > -     ret =3D __add_block_group_free_space(trans, block_group, path=
);
> > > > -out:
> > > > -     btrfs_free_path(path);
> > > > +     ret =3D __add_block_group_free_space(trans, block_group, NULL=
);
> > > >       mutex_unlock(&block_group->free_space_lock);
> > > >       return ret;
> > > >  }
> > > > --
> > > > 2.47.2
> > > >

