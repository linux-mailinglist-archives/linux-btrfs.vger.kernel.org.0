Return-Path: <linux-btrfs+bounces-14384-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C19CACB989
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 18:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68924189B03E
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 16:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8720D227E94;
	Mon,  2 Jun 2025 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Mf6CeCEM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B57227E8A
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 16:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748881233; cv=none; b=cb4v5BvOWBCKxQNSxMLz1s+Zq3FxnTydhB413GCValuMhL/xxMK8IftoCUx0F6f0j4KMTH+QaddluHykrYhML7dZmi1WwhhmB1iK7WaqXvWj/OZfthS53v+G2MRhrrJx6FeYiLNOph5nQ6MgcgxFj/A9xFcjQp1kY/T+DMj2Gvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748881233; c=relaxed/simple;
	bh=DsZcXrH0q1cyTGbvTIUopMG4Kh4tREueZn/GnGsnq58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XuP01fltV1FO5fID8vZuC6rYgO915pCjBiQPcAvFgYoziOZwlxyFzBlFQXLrz9Z7iauwpyTCSdeUZnYpm0TtKfnG4dg3zEO4bXK3J3q9+T7QAgRZAuPSe3tW6r6lPfmJtmdJinFURMklrEy61LZLc1llLlIrNeAlQPfcPDj+hb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Mf6CeCEM; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-adb2e9fd208so744157366b.3
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Jun 2025 09:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748881229; x=1749486029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQoqbZmXiqjyKHCA9hno/RCliaWCvmNN/QoAh8wKk88=;
        b=Mf6CeCEM+J4TLxTUuv4tR9BN7rsXPinePRSbSFERs6dTH+wSAE6wpMTpDIUUrrtBta
         1t9+lQGwCmRY2nl+yOGEtZ/3mDrmKKZW7pbuTv+nLRAZ8AEmHx647rUvDbfDCW3CSpjZ
         ezBlZYyT67ERzqL0hhnS+yF6L4Is2w/QzQ+K1VrtemjhwZS/Cyv2RxG2kU1FXXKf9O5M
         ZLjLy8Vyv0qR8VSrJGeBMEx5mumIPkU9L9ODLSHjzFN+qmg6FRf2PdpcObPWqdPoxXMn
         U677Ft2agMGHRT3ruy0m1UAK+VMmb7O9GVuTR7mugh+FjUZhUK7Iqh5wLo3kCttzxVtf
         z+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748881229; x=1749486029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQoqbZmXiqjyKHCA9hno/RCliaWCvmNN/QoAh8wKk88=;
        b=iHX/hiB3XnkRHCTMbck03Sp34ykAtWfAsSwasrqg9LaFYrWDs104H3hQ+acCLCsm2e
         0ZLcgMTc9WOdBjZRQDH7blxqSbAkBiWEOFZptUJ/Bg5ME3VcPUaeP5RJAznKboi1NHTn
         njgz2CGrU7zi8/uOWbxcJ9s1w5/kFWmjznSZ3DggxWmozND3G70G0PnuGeRKK6p3a9I8
         7pCIv8zNXloytsp8mnT8osT5RzGRdSSxig3P+uefizq2j4GbndSozKia0Rv0d/brGsdO
         r/Y0khXq9E+OG+GYd0cnhYRDGXoR3It5V92gWI+QB2beeNtYEEepYJlVFxPu9Uy2mNWF
         cT6g==
X-Forwarded-Encrypted: i=1; AJvYcCXlV7TCwMINSUn9H4QevomuE7KXvRA6gVc4gVDkoEkNWZdbSED/tlHCO2P9Dr8f4JrVVo3H0UbvELKHMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yznwg9E/lKF1IBs/mb2RlMkqX9pM5l/xwPuGDb65++WgmPI3F3P
	M+zKCEj5S1K86baacWyL5ZqMTUNvSHa3R8RA2T/EWVDDKyFnpY5shWskLJOM9AXivZPltKCbKJm
	e3RJCtjjE0kPNfko5ipQiyAK85p94uSCfmkzwJEcN8aOUuLKMhNX//BoWXA==
X-Gm-Gg: ASbGncvUD77a28LN0dmJDzqxsq4Ykf/C6VPPZdCc8xjUfg5fhlYbyb87072nrfh0zjk
	vP7onPLbefxtipepCDcUTscV18/YkZ3kmvcajysjGFqkyBGShpKCpJHjjGvdz4shPSKkS1BklFd
	UsQSlNOHfC1vYpc1fb1qt417wkYdCX8dg=
X-Google-Smtp-Source: AGHT+IEbhydfFm+QJHG3z3+ijrBqI/pxE8xv0hyEwM2GzyFEpHnQLZ462dO/1xCNDT6GH77lT3T9a2mqEWflI9dMvkE=
X-Received: by 2002:a17:907:2d27:b0:ad5:55db:e411 with SMTP id
 a640c23a62f3a-adb322afc89mr1429636266b.27.1748881229480; Mon, 02 Jun 2025
 09:20:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <14d1a4a5621f5059dae764a8bfc9b114b6df029c.1748789125.git.fdmanana@suse.com>
 <6172770.lOV4Wx5bFT@saltykitkat> <CAL3q7H4j_W0rANN8oJdzk1x36oOYLJB1=TSAsEA90vKeKX=7Rg@mail.gmail.com>
In-Reply-To: <CAL3q7H4j_W0rANN8oJdzk1x36oOYLJB1=TSAsEA90vKeKX=7Rg@mail.gmail.com>
From: Daniel Vacek <neelx@suse.com>
Date: Mon, 2 Jun 2025 18:20:18 +0200
X-Gm-Features: AX0GCFttCj5xkJyhYraUPJePm34YJIs67oq2BGVVP99bikSt_lViNjpwTbFz-ZE
Message-ID: <CAPjX3FeiJSXaPZxhKNmq0o7tzOvQ+58oBHOf8qR=y+JAh7T8cQ@mail.gmail.com>
Subject: Re: [PATCH 03/14] btrfs: free path sooner at __btrfs_unlink_inode()
To: Filipe Manana <fdmanana@kernel.org>
Cc: Sun YangKai <sunk67188@gmail.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Jun 2025 at 15:28, Filipe Manana <fdmanana@kernel.org> wrote:
>
> On Mon, Jun 2, 2025 at 2:25=E2=80=AFPM Sun YangKai <sunk67188@gmail.com> =
wrote:
> >
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > After calling btrfs_delete_one_dir_name() there's no need for the pat=
h
> > > anymore so we can free it immediately after. After that point we do
> > > some btree operations that take time and in those call chains we end =
up
> > > allocating paths for these operations, so we're unnecessarily holding=
 on
> > > to the path we allocated early at __btrfs_unlink_inode().
> > >
> > > So free the path as soon as we don't need it and add a comment. This
> > > also allows to simplify the error path, removing two exit labels and
> > > returning directly when an error happens.
> > >
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > ---
> > >
> > >  fs/btrfs/inode.c | 31 ++++++++++++++-----------------
> > >  1 file changed, 14 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > > index 7bad21ec41f8..a9a37553bc45 100644
> > > --- a/fs/btrfs/inode.c
> > > +++ b/fs/btrfs/inode.c
> > > @@ -4215,20 +4215,22 @@ static int __btrfs_unlink_inode(struct
> > > btrfs_trans_handle *trans,>
> > >       u64 dir_ino =3D btrfs_ino(dir);
> > >
> > >       path =3D btrfs_alloc_path();
> > >
> > > -     if (!path) {
> > > -             ret =3D -ENOMEM;
> > > -             goto out;
> > > -     }
> > > +     if (!path)
> > > +             return -ENOMEM;
> > >
> > >       di =3D btrfs_lookup_dir_item(trans, root, path, dir_ino, name, =
-1);
> > >       if (IS_ERR_OR_NULL(di)) {
> > >
> > > -             ret =3D di ? PTR_ERR(di) : -ENOENT;
> > > -             goto err;
> > > +             btrfs_free_path(path);
> > > +             return di ? PTR_ERR(di) : -ENOENT;
> >
> > Maybe we could define the path using `BTRFS_PATH_AUTO_FREE(path);` so t=
hat we
> > don't need to write btrfs_free_path before every return statement like =
this.
> >
> > Forgive me if I'm mistaken, as I'm not completely familiar with this.
>
> For the error case only, yes. But the goal here is to free the path as
> soon as it's not needed for the expected, non-error case.
> So no, it wouldn't do it.

You can actually combine explicit btrfs_free_path(path) with auto free
if you follow with path =3D NULL. In such a case the second free will
result in nop.
Of course, a comment would be proper at such a location if you really
wanted to use it.

> > >       }
> > >       ret =3D btrfs_delete_one_dir_name(trans, root, path, di);
> > >
> > > +     /*
> > > +      * Down the call chains below we'll also need to allocate a pat=
h, so no
> > > +      * need to hold on to this one for longer than necessary.
> > > +      */
> > > +     btrfs_free_path(path);
> > >
> > >       if (ret)
> > >
> > > -             goto err;
> > > -     btrfs_release_path(path);
> > > +             return ret;
> > >
> > >       /*
> > >
> > >        * If we don't have dir index, we have to get it by looking up
> > >
> > > @@ -4254,7 +4256,7 @@ static int __btrfs_unlink_inode(struct
> > > btrfs_trans_handle *trans,>
> > >          "failed to delete reference to %.*s, root %llu inode %llu pa=
rent
> > %llu",
> > >
> > >                          name->len, name->name, btrfs_root_id(root), =
ino, dir_ino);
> > >
> > >               btrfs_abort_transaction(trans, ret);
> > >
> > > -             goto err;
> > > +             return ret;
> > >
> > >       }
> > >
> > >  skip_backref:
> > >       if (rename_ctx)
> > >
> > > @@ -4263,7 +4265,7 @@ static int __btrfs_unlink_inode(struct
> > > btrfs_trans_handle *trans,>
> > >       ret =3D btrfs_delete_delayed_dir_index(trans, dir, index);
> > >       if (ret) {
> > >
> > >               btrfs_abort_transaction(trans, ret);
> > >
> > > -             goto err;
> > > +             return ret;
> > >
> > >       }
> > >
> > >       /*
> > >
> > > @@ -4287,19 +4289,14 @@ static int __btrfs_unlink_inode(struct
> > > btrfs_trans_handle *trans,>
> > >        * holding.
> > >        */
> > >
> > >       btrfs_run_delayed_iput(fs_info, inode);
> > >
> > > -err:
> > > -     btrfs_free_path(path);
> > > -     if (ret)
> > > -             goto out;
> > >
> > >       btrfs_i_size_write(dir, dir->vfs_inode.i_size - name->len * 2);
> > >       inode_inc_iversion(&inode->vfs_inode);
> > >       inode_set_ctime_current(&inode->vfs_inode);
> > >       inode_inc_iversion(&dir->vfs_inode);
> > >
> > >       inode_set_mtime_to_ts(&dir->vfs_inode,
> > >       inode_set_ctime_current(&dir->vfs_inode));>
> > > -     ret =3D btrfs_update_inode(trans, dir);
> > > -out:
> > > -     return ret;
> > > +
> > > +     return btrfs_update_inode(trans, dir);
> > >
> > >  }
> > >
> > >  int btrfs_unlink_inode(struct btrfs_trans_handle *trans,
> > >
> > > --
> > > 2.47.2
> >
> >
>

