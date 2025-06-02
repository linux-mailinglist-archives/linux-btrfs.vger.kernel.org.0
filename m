Return-Path: <linux-btrfs+bounces-14379-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D3CACAEFE
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 15:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D72A63A378D
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 13:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1636421CC7B;
	Mon,  2 Jun 2025 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpzjOswr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8651FF61E
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 13:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748870923; cv=none; b=WdeNfcKAq0iXg6vKC0vo9IkUnQH1aOA9kyzCe9edGTUPRqj7+OWXWFapso6uFo3Mf42NatSuH/aNT09ExVzVhOaQGUOyT5rlbc82C4T3wgo+e1u2RiaGwAvPjlRv1NQK0qPjZV6sgramTKxduZxcFwXjjcayS1Kb5cK2CpxHv9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748870923; c=relaxed/simple;
	bh=FwWu4BMZv0FH3wfvihbSnk5pjOJpOGmuKVA6ArEcAfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DnmTniW85xpdqUNCprQj390E+W5mKeDOjEtt9uuFTkHCWNXbZ3RZMb+HSOhO3w0GWRObiV05JhOzQGUYKmKurOsYP+dM2+xX2fDeVPKz4TVqwyAVckueAjz6tTSfO5C27jloRswJX+2Q6jFxVEn+Bwu1POSsfyN9bKXwQEIymQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpzjOswr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5C1C4CEEB
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 13:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748870921;
	bh=FwWu4BMZv0FH3wfvihbSnk5pjOJpOGmuKVA6ArEcAfc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kpzjOswreD0coWk+d5ryGYPFJKhrrWs+SF6iYR6BM6n/ucUaE1ntsxn4Y1/Fv5Fpd
	 tKrlEjMHviHR4G95lwcBUPUgtn3LIEwujOPT4bil13EjrWUvMJi3uA8G1xyCo1OHl9
	 rnhUPLs9Tpj7Rds4G3HHBBZrBFvJNIbPVwo3cZGBC3MljsGBtCsUcwci/wN326fZ+N
	 FzojPpP02SQgKExQ/lb1FiJ/g4AaTvrIqENFSAofkGybAQYglGXb+XJrWOQKfnGrNw
	 A+YTqFg7ntlTpekE/9qKwlfMinYaIPwS3QaRhfLdXzlYcIPqd7ICq7XRcclIX4haiB
	 76xwmNoeJTO5g==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-602c3f113bbso8558978a12.0
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Jun 2025 06:28:41 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz/T8DBzXgRrVqrsJ1fZ6NATmF7NE8fzaoCf0ehIxWYD4tDypJm
	sqTUr++X0NZqkPnIEfTsgVYKNLuhkGBZxZcOWtEvC2c9eg+g3bu6PGCU1sQDPqqUx/Icr3RLzu+
	ZZApvDL8+qmRYcHUo31lnpbr9T1STPSY=
X-Google-Smtp-Source: AGHT+IEtHQFGxh4G8YI/awo3Ylax9wo9+xiykXxifbzvTBlwShSbBHR7Jzch+Zhur4hukI5SyFJC5yp/W/lWxdNnc1M=
X-Received: by 2002:a17:907:2ce2:b0:ad9:16c8:9ff4 with SMTP id
 a640c23a62f3a-adb493ab9d8mr737600766b.11.1748870920403; Mon, 02 Jun 2025
 06:28:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <14d1a4a5621f5059dae764a8bfc9b114b6df029c.1748789125.git.fdmanana@suse.com>
 <6172770.lOV4Wx5bFT@saltykitkat>
In-Reply-To: <6172770.lOV4Wx5bFT@saltykitkat>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 2 Jun 2025 14:28:03 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4j_W0rANN8oJdzk1x36oOYLJB1=TSAsEA90vKeKX=7Rg@mail.gmail.com>
X-Gm-Features: AX0GCFvMwHGr4ijf4BNKbC5uOe_KfF0iV4fv1EuAbX0l5BMWWODyIUWY9nwri7Q
Message-ID: <CAL3q7H4j_W0rANN8oJdzk1x36oOYLJB1=TSAsEA90vKeKX=7Rg@mail.gmail.com>
Subject: Re: [PATCH 03/14] btrfs: free path sooner at __btrfs_unlink_inode()
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 2:25=E2=80=AFPM Sun YangKai <sunk67188@gmail.com> wr=
ote:
>
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > After calling btrfs_delete_one_dir_name() there's no need for the path
> > anymore so we can free it immediately after. After that point we do
> > some btree operations that take time and in those call chains we end up
> > allocating paths for these operations, so we're unnecessarily holding o=
n
> > to the path we allocated early at __btrfs_unlink_inode().
> >
> > So free the path as soon as we don't need it and add a comment. This
> > also allows to simplify the error path, removing two exit labels and
> > returning directly when an error happens.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >
> >  fs/btrfs/inode.c | 31 ++++++++++++++-----------------
> >  1 file changed, 14 insertions(+), 17 deletions(-)
> >
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 7bad21ec41f8..a9a37553bc45 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -4215,20 +4215,22 @@ static int __btrfs_unlink_inode(struct
> > btrfs_trans_handle *trans,>
> >       u64 dir_ino =3D btrfs_ino(dir);
> >
> >       path =3D btrfs_alloc_path();
> >
> > -     if (!path) {
> > -             ret =3D -ENOMEM;
> > -             goto out;
> > -     }
> > +     if (!path)
> > +             return -ENOMEM;
> >
> >       di =3D btrfs_lookup_dir_item(trans, root, path, dir_ino, name, -1=
);
> >       if (IS_ERR_OR_NULL(di)) {
> >
> > -             ret =3D di ? PTR_ERR(di) : -ENOENT;
> > -             goto err;
> > +             btrfs_free_path(path);
> > +             return di ? PTR_ERR(di) : -ENOENT;
>
> Maybe we could define the path using `BTRFS_PATH_AUTO_FREE(path);` so tha=
t we
> don't need to write btrfs_free_path before every return statement like th=
is.
>
> Forgive me if I'm mistaken, as I'm not completely familiar with this.

For the error case only, yes. But the goal here is to free the path as
soon as it's not needed for the expected, non-error case.
So no, it wouldn't do it.

>
> >
> >       }
> >       ret =3D btrfs_delete_one_dir_name(trans, root, path, di);
> >
> > +     /*
> > +      * Down the call chains below we'll also need to allocate a path,=
 so no
> > +      * need to hold on to this one for longer than necessary.
> > +      */
> > +     btrfs_free_path(path);
> >
> >       if (ret)
> >
> > -             goto err;
> > -     btrfs_release_path(path);
> > +             return ret;
> >
> >       /*
> >
> >        * If we don't have dir index, we have to get it by looking up
> >
> > @@ -4254,7 +4256,7 @@ static int __btrfs_unlink_inode(struct
> > btrfs_trans_handle *trans,>
> >          "failed to delete reference to %.*s, root %llu inode %llu pare=
nt
> %llu",
> >
> >                          name->len, name->name, btrfs_root_id(root), in=
o, dir_ino);
> >
> >               btrfs_abort_transaction(trans, ret);
> >
> > -             goto err;
> > +             return ret;
> >
> >       }
> >
> >  skip_backref:
> >       if (rename_ctx)
> >
> > @@ -4263,7 +4265,7 @@ static int __btrfs_unlink_inode(struct
> > btrfs_trans_handle *trans,>
> >       ret =3D btrfs_delete_delayed_dir_index(trans, dir, index);
> >       if (ret) {
> >
> >               btrfs_abort_transaction(trans, ret);
> >
> > -             goto err;
> > +             return ret;
> >
> >       }
> >
> >       /*
> >
> > @@ -4287,19 +4289,14 @@ static int __btrfs_unlink_inode(struct
> > btrfs_trans_handle *trans,>
> >        * holding.
> >        */
> >
> >       btrfs_run_delayed_iput(fs_info, inode);
> >
> > -err:
> > -     btrfs_free_path(path);
> > -     if (ret)
> > -             goto out;
> >
> >       btrfs_i_size_write(dir, dir->vfs_inode.i_size - name->len * 2);
> >       inode_inc_iversion(&inode->vfs_inode);
> >       inode_set_ctime_current(&inode->vfs_inode);
> >       inode_inc_iversion(&dir->vfs_inode);
> >
> >       inode_set_mtime_to_ts(&dir->vfs_inode,
> >       inode_set_ctime_current(&dir->vfs_inode));>
> > -     ret =3D btrfs_update_inode(trans, dir);
> > -out:
> > -     return ret;
> > +
> > +     return btrfs_update_inode(trans, dir);
> >
> >  }
> >
> >  int btrfs_unlink_inode(struct btrfs_trans_handle *trans,
> >
> > --
> > 2.47.2
>
>

