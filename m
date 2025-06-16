Return-Path: <linux-btrfs+bounces-14669-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F223AADB5D7
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Jun 2025 17:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97DD03A749A
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Jun 2025 15:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC26262FE5;
	Mon, 16 Jun 2025 15:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUmfEZGn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723D618DB37
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Jun 2025 15:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750088953; cv=none; b=I2uIpm38LE1he1CsYNlgwPE9vhFRETYuiT/uyg3/Kysr309ka3EEakGRyCzuc7yZnaX+OIvkAjC+5nz39/lpWPxPwNtjn9HKcg15VV+rprW4PWjB6fivcDWcjqgiy4kXeZeocWZhy78V/XX+pmwxboP9k4d8ypDOgmPdyopTbdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750088953; c=relaxed/simple;
	bh=DEMJZCGC3gAX6UW973ChNqHFJMn98MwTmkWSjkrkqG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9QuDgry1WYjlX5++xkcimXwxpoxm8S3zSMlMz7zxDqVPY+EYJroXez28ifrMmxOmd5ivTYVFcyp0l5VviACWbwn1hxkixFvUL4D8c1iPplULx+eh7IC/ZdbfmVAe3TPx6atu0of/ggOKDH/RlWJWmcpX9042GtE0QGL4axKelA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUmfEZGn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F120C4CEF0
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Jun 2025 15:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750088953;
	bh=DEMJZCGC3gAX6UW973ChNqHFJMn98MwTmkWSjkrkqG8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uUmfEZGnj0rGi25MZWpcVovSoPuZez/bDD1K+eXcmQQrRYuBdeYk2ac7lINZGVZpb
	 29AOBl+PsPAjvoPmAhmvmX8KcxsLF0wJ5+vgqyoXcqP117XQ7vEobQLfhZY5ezEP3R
	 QzKDfHvEAdUFd9aTITEDfQPuY7t5BlO66lk4H7CpIsau2tWF1N0aAr5lNRyEdlzKv2
	 ONX7akZTM1D6rxfFa/nGLESe5zh4fzEQgXkw7ON2RqyKDItNkDCX3gX52T7Hf0qil7
	 7VCNQdZvv+Fb0I58cVdlTeI6ciEigPF+PzazBpNgqp6AQu+KpW4ZN7FQX+0w0NpyIr
	 iCTVG8ZuQwrLA==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-adb5cb6d8f1so861294466b.3
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Jun 2025 08:49:13 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz5zhlbjNqs4j2wXVTJZG0YJNIbbGiQZV67VKlJwMbGk+wPhJZL
	XSxArxrHf39KlVKfPOwEGzGdCU1KNvddkEc6Olj9VVbPhqCQE1EnYZIwAWkqA7nehcf2hrtJIFt
	3+tB2WFaS3gP2jpgnuyZC4cnwMH5qTR0=
X-Google-Smtp-Source: AGHT+IEs3b5gUyDz5adEv7WZ0filATQaXRW4ASiEqeCv+SxAlx325LyGtOZiMnm/C2uguHOUsrm8qGJxb4GJltFhz9g=
X-Received: by 2002:a17:907:7291:b0:adf:7740:9284 with SMTP id
 a640c23a62f3a-adfad4f65e8mr1030566866b.57.1750088951633; Mon, 16 Jun 2025
 08:49:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749421865.git.fdmanana@suse.com> <40dd299a0b7551fb8163da00a6ed716a8f8c3d46.1749421865.git.fdmanana@suse.com>
 <20250616154458.GA812359@zen.localdomain>
In-Reply-To: <20250616154458.GA812359@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 16 Jun 2025 16:48:34 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6Ojtu5zYuSVyZ+NrWhhPyYEKdrX4d4d3W6BVcfmKi1rQ@mail.gmail.com>
X-Gm-Features: AX0GCFs4FL-H8uKmop77gwqA6QEx0lDBk8qZOry3Zqy6eG2zytYTfjOFrrloaEE
Message-ID: <CAL3q7H6Ojtu5zYuSVyZ+NrWhhPyYEKdrX4d4d3W6BVcfmKi1rQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] btrfs: check BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE at __add_block_group_free_space()
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 4:45=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Sun, Jun 08, 2025 at 11:43:34PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Every caller of __add_block_group_free_space() is checking if the flag
> > BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE is set before calling it. This is
> > duplicate code and it's prone to some mistake in case we add more calle=
rs
> > in the future. So move the check for that flag into the start of
> > __add_block_group_free_space().
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/free-space-tree.c | 58 ++++++++++++++++++--------------------
> >  1 file changed, 28 insertions(+), 30 deletions(-)
> >
> > diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> > index af005fb4b676..f03f3610b713 100644
> > --- a/fs/btrfs/free-space-tree.c
> > +++ b/fs/btrfs/free-space-tree.c
> > @@ -816,11 +816,9 @@ int __remove_from_free_space_tree(struct btrfs_tra=
ns_handle *trans,
> >       u32 flags;
> >       int ret;
> >
> > -     if (test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &block_group->run=
time_flags)) {
> > -             ret =3D __add_block_group_free_space(trans, block_group, =
path);
> > -             if (ret)
> > -                     return ret;
> > -     }
> > +     ret =3D __add_block_group_free_space(trans, block_group, path);
> > +     if (ret)
> > +             return ret;
> >
> >       info =3D search_free_space_info(NULL, block_group, path, 0);
> >       if (IS_ERR(info))
> > @@ -1011,11 +1009,9 @@ int __add_to_free_space_tree(struct btrfs_trans_=
handle *trans,
> >       u32 flags;
> >       int ret;
> >
> > -     if (test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &block_group->run=
time_flags)) {
> > -             ret =3D __add_block_group_free_space(trans, block_group, =
path);
> > -             if (ret)
> > -                     return ret;
> > -     }
> > +     ret =3D __add_block_group_free_space(trans, block_group, path);
> > +     if (ret)
> > +             return ret;
> >
> >       info =3D search_free_space_info(NULL, block_group, path, 0);
> >       if (IS_ERR(info))
> > @@ -1403,9 +1399,12 @@ static int __add_block_group_free_space(struct b=
trfs_trans_handle *trans,
> >                                       struct btrfs_block_group *block_g=
roup,
> >                                       struct btrfs_path *path)
> >  {
> > +     bool own_path =3D false;
> >       int ret;
> >
> > -     clear_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &block_group->runtim=
e_flags);
> > +     if (!test_and_clear_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE,
> > +                             &block_group->runtime_flags))
> > +             return 0;
> >
> >       /*
> >        * While rebuilding the free space tree we may allocate new metad=
ata
> > @@ -1430,10 +1429,19 @@ static int __add_block_group_free_space(struct =
btrfs_trans_handle *trans,
> >        */
> >       set_bit(BLOCK_GROUP_FLAG_FREE_SPACE_ADDED, &block_group->runtime_=
flags);
> >
> > +     if (!path) {
> > +             path =3D btrfs_alloc_path();
> > +             if (!path) {
> > +                     btrfs_abort_transaction(trans, -ENOMEM);
> > +                     return -ENOMEM;
> > +             }
> > +             own_path =3D true;
> > +     }
> > +
>
> Is the "own_path" change intended to be bundled with this one? If so,
> can you mention it in the commit message as well?

Yes it's supposed, why wouldn't it?
This is because the path allocation from add_block_group_free_space()
has to be gone and done in this function now if it receives a NULL
path.

I would think this is obvious since the diff for
add_block_group_free_space() removes the path allocation.

Thanks.

>
> >       ret =3D add_new_free_space_info(trans, block_group, path);
> >       if (ret) {
> >               btrfs_abort_transaction(trans, ret);
> > -             return ret;
> > +             goto out;
> >       }
> >
> >       ret =3D __add_to_free_space_tree(trans, block_group, path,
> > @@ -1441,33 +1449,23 @@ static int __add_block_group_free_space(struct =
btrfs_trans_handle *trans,
> >       if (ret)
> >               btrfs_abort_transaction(trans, ret);
> >
> > -     return 0;
> > +out:
> > +     if (own_path)
> > +             btrfs_free_path(path);
> > +
> > +     return ret;
> >  }
> >
> >  int add_block_group_free_space(struct btrfs_trans_handle *trans,
> >                              struct btrfs_block_group *block_group)
> >  {
> > -     struct btrfs_fs_info *fs_info =3D trans->fs_info;
> > -     struct btrfs_path *path =3D NULL;
> > -     int ret =3D 0;
> > +     int ret;
> >
> > -     if (!btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
> > +     if (!btrfs_fs_compat_ro(trans->fs_info, FREE_SPACE_TREE))
> >               return 0;
> >
> >       mutex_lock(&block_group->free_space_lock);
> > -     if (!test_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &block_group->ru=
ntime_flags))
> > -             goto out;
> > -
> > -     path =3D btrfs_alloc_path();
> > -     if (!path) {
> > -             ret =3D -ENOMEM;
> > -             btrfs_abort_transaction(trans, ret);
> > -             goto out;
> > -     }
> > -
> > -     ret =3D __add_block_group_free_space(trans, block_group, path);
> > -out:
> > -     btrfs_free_path(path);
> > +     ret =3D __add_block_group_free_space(trans, block_group, NULL);
> >       mutex_unlock(&block_group->free_space_lock);
> >       return ret;
> >  }
> > --
> > 2.47.2
> >

