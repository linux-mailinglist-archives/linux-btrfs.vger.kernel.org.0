Return-Path: <linux-btrfs+bounces-18156-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE65BFAC87
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 10:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF0755061F7
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 08:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40594302CB7;
	Wed, 22 Oct 2025 08:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QcUkncMm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE78830170C
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Oct 2025 08:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120392; cv=none; b=MdaLhk4JY8WZKwrQq8wY75RSmFJ4HJaV1UJ5CkUCNoYT6pT6Z2qLq6toT0rXiZNqe4ycPjcZmGOUNP+scAtucB6EymgTYVMLidPddkzeyaHltkJ2bSeORu8UITEm5oUl2etze0/pmYhHMsS1RkxWzNZ2/eDuBLzL+X4IHNyVjMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120392; c=relaxed/simple;
	bh=i7rr4hr7GlAFwX8ai8F7Xn426QIX0/HemOMZ06kDLAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UYDFssGWKVaf009f9OBB/ugVrP3m7jmhVnpwZZVI3ij7mXx+KXosHWFJ92He+IVvJMAeAPEtgKAH1V9XWrPke4iE7uJmG/19zSDHI7Xj0FS/WU/QMpAMtlrhXXxOnPgFZIbbUQsP3O0381kJn4BbR44ijuIfOkhzICm03tl2CSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QcUkncMm; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42701b29a7eso389526f8f.0
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Oct 2025 01:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761120388; x=1761725188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPT3djXxuwyZG03uZ4DKKGDEQkFViw3ZAiy4XlRf2D8=;
        b=QcUkncMm0e65HlNpbYoPaqeXepP2zhOmiydfNTiXafCZIyIryzkPkyWXN1N81x80Lz
         O51z/Nm3bTZfJ0OrcI/mhw+5N/XXCutz14iiVi6qpRJTE2fmbnqKyEzAh5lsDbbcy6RN
         lzhMYio0MTBDWR48nlV1f84PUjKejwhR9ds9NZmNG1NV3n4ymuVqH91lH4GqlPcc8ak5
         nv1Q+AP4yYi0XpRfT6eENd2wAQZXkIs0KLspM29IkkSJyZmzYnFkWiks2kJF7mVLvlBb
         ak02Ta6WIqRtt4xp8LJcoEwfRUAEcrk1jIa9bN8TNlzyXELpNNctUMcBhqHFhOhVA36Z
         4NMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120388; x=1761725188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPT3djXxuwyZG03uZ4DKKGDEQkFViw3ZAiy4XlRf2D8=;
        b=Q7s1TTRI4h6+Ox3F3yfKwjPCVRMIO2WVzrHD4+I4m5kd0GnOlR7CKDj6HXFo386ONq
         5VUFWsWN2ehcWs8M6EVcChTNMV4v+8N9GRq1pEKODnXcsIUhsaPQINZyJuveaVBBPQNs
         79qhgvBoiV7q0QDcc/IpAQYj1q24POUbzxlrLqAhig1VpnqoQ3SMr6TcbZ6tDknLAoli
         h9gAL2Z1DJ2dQ7mqlW1HS9cb65YG9hQ8U6Q4F1tSwY5ZAlvBBJSAjICBTdLwzp1tHzPG
         VZrMeSsHePy04/YI0l6wzkE1Sk2t4jb9GQTxvSrVCNPDQfsgMUKDxDVuXSBWhWyivAGZ
         jl1w==
X-Forwarded-Encrypted: i=1; AJvYcCVJ9QCGq+dwF2AAL259vacWMbBMylMaayfU5xmo2EsxxcUxVwaAk0xFUJH02tZXupGgagS6f50fiED4Ug==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZTxXWaNMsQAPClEmZuhKu0EwXY0uZArKPWFJwR5fPwImMQ3Iu
	PmTchQS7KcVZYuSuZhPyuhV+D12XdYGV2gsrIaGVD3JQ+KWejnFgd3RL1vw7VuJQK8Dcw/h2qWi
	tfVG8nTU0HIKEO2BxHWTcM0jAxhLxlUYY1dqyPfeSLA==
X-Gm-Gg: ASbGncvVuj/dHkpD+xISRUiYIP9lmrzIwtHKD/+Xf3UItwO6vQxGHUbyyzRh0zN3L6Z
	i9/qPTWdsqxz775hWvFaKLMkwZpec2U/sjbdPiNLMcKELSV4dHdSMHWI65iDe0AGXGDlqFK1zTV
	/ImavYK8vUi1e4omui44cJ7WN5cBrlG0u0YVxHoYWQjbX4NH2QiwyWYNw8/Z5tYLcrkTXjyh8sL
	q2LcvZ+KpUKhHp7G27d1oxjompWEICCeop68fbuegSrLrO1XYuyq0id/5w=
X-Google-Smtp-Source: AGHT+IErIGWqnC+YrEzurKE07CGgJ2SXF5rw5ePxfegDakBTc4QMm8JUStUPPbJ2lzOoyOwJPTHQ6yaW4KGCVun/x0E=
X-Received: by 2002:a5d:584e:0:b0:407:d776:4434 with SMTP id
 ffacd0b85a97d-42856a89d28mr492690f8f.30.1761120387951; Wed, 22 Oct 2025
 01:06:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021142749.642956-1-mssola@mssola.com> <20251021142749.642956-2-mssola@mssola.com>
 <20251022073138.GX13776@twin.jikos.cz>
In-Reply-To: <20251022073138.GX13776@twin.jikos.cz>
From: Daniel Vacek <neelx@suse.com>
Date: Wed, 22 Oct 2025 10:06:17 +0200
X-Gm-Features: AS18NWAW65wMT_NPMRH8zH-Chtb0tobvWzCUv7MCRWOtED9hj5Ie9fAvPfEpkiU
Message-ID: <CAPjX3Fcd2MgzhRtDEGRsNNZ1qARiaT0edfnqPA-5HAchwf1gAg@mail.gmail.com>
Subject: Re: [PATCH 1/4] btrfs: declare free_ipath() via DEFINE_FREE() instead
To: dsterba@suse.cz
Cc: =?UTF-8?B?TWlxdWVsIFNhYmF0w6kgU29sw6A=?= <mssola@mssola.com>, 
	linux-btrfs@vger.kernel.org, clm@fb.com, dsterba@suse.com, 
	johannes.thumshirn@wdc.com, fdmanana@suse.com, boris@bur.io, wqu@suse.com, 
	neal@gompa.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 22 Oct 2025 at 09:32, David Sterba <dsterba@suse.cz> wrote:
>
> On Tue, Oct 21, 2025 at 04:27:46PM +0200, Miquel Sabat=C3=A9 Sol=C3=A0 wr=
ote:
> > This transforms the signature to __free_ipath() instead of the original
> > free_ipath(), but this function was only being used as a cleanup
> > function anyways. Hence, define it as a helper and use it via the
> > __free() attribute on all uses. This change also means that
> > __free_ipath() will be inlined whereas that wasn't the case for the
> > original one, but this shouldn't be a problem.
> >
> > A follow up macro like we do with BTRFS_PATH_AUTO_FREE() has been
> > discarded as the usage of this struct is not as widespread as that.
>
> The point of adding the macros or at least the freeing wrappers is to
> force the NULL initialization and to make it visible in the declarations
> (typed all in capitals). The number of use should not be the main factor
> and in this case it's 4 files.
>
> > Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mssola@mssola.com>
> > ---
> >  fs/btrfs/backref.c | 10 +---------
> >  fs/btrfs/backref.h |  7 ++++++-
> >  fs/btrfs/inode.c   |  4 +---
> >  fs/btrfs/ioctl.c   |  3 +--
> >  fs/btrfs/scrub.c   |  4 +---
> >  5 files changed, 10 insertions(+), 18 deletions(-)
> >
> > diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> > index e050d0938dc4..a1456402752a 100644
> > --- a/fs/btrfs/backref.c
> > +++ b/fs/btrfs/backref.c
> > @@ -2785,7 +2785,7 @@ struct btrfs_data_container *init_data_container(=
u32 total_bytes)
> >   * allocates space to return multiple file system paths for an inode.
> >   * total_bytes to allocate are passed, note that space usable for actu=
al path
> >   * information will be total_bytes - sizeof(struct inode_fs_paths).
> > - * the returned pointer must be freed with free_ipath() in the end.
> > + * the returned pointer must be freed with __free_ipath() in the end.
> >   */
> >  struct inode_fs_paths *init_ipath(s32 total_bytes, struct btrfs_root *=
fs_root,
> >                                       struct btrfs_path *path)
> > @@ -2810,14 +2810,6 @@ struct inode_fs_paths *init_ipath(s32 total_byte=
s, struct btrfs_root *fs_root,
> >       return ifp;
> >  }
> >
> > -void free_ipath(struct inode_fs_paths *ipath)
> > -{
> > -     if (!ipath)
> > -             return;
> > -     kvfree(ipath->fspath);
> > -     kfree(ipath);
> > -}
> > -
> >  struct btrfs_backref_iter *btrfs_backref_iter_alloc(struct btrfs_fs_in=
fo *fs_info)
> >  {
> >       struct btrfs_backref_iter *ret;
> > diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
> > index 25d51c246070..d3b1ad281793 100644
> > --- a/fs/btrfs/backref.h
> > +++ b/fs/btrfs/backref.h
> > @@ -241,7 +241,12 @@ char *btrfs_ref_to_path(struct btrfs_root *fs_root=
, struct btrfs_path *path,
> >  struct btrfs_data_container *init_data_container(u32 total_bytes);
> >  struct inode_fs_paths *init_ipath(s32 total_bytes, struct btrfs_root *=
fs_root,
> >                                       struct btrfs_path *path);
> > -void free_ipath(struct inode_fs_paths *ipath);
> > +
> > +DEFINE_FREE(ipath, struct inode_fs_paths *,
> > +     if (_T) {
>
> You can drop the if() as kvfree/kfree handles NULL pointers and we don't
> do that in the struct btrfs_path either.

But it's being dereferenced right on the next line. I think the check
is still needed due to that.

> > +             kvfree(_T->fspath);
> > +             kfree(_T);
> > +     })
> >
> >  int btrfs_find_one_extref(struct btrfs_root *root, u64 inode_objectid,
> >                         u64 start_off, struct btrfs_path *path,
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 79732756b87f..4d154209d70b 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -130,7 +130,7 @@ static int data_reloc_print_warning_inode(u64 inum,=
 u64 offset, u64 num_bytes,
> >       struct btrfs_fs_info *fs_info =3D warn->fs_info;
> >       struct extent_buffer *eb;
> >       struct btrfs_inode_item *inode_item;
> > -     struct inode_fs_paths *ipath =3D NULL;
> > +     struct inode_fs_paths *ipath __free(ipath) =3D NULL;
>
> I'd spell the name in full, like __free(free_ipath) or
> __free(inode_fs_paths) so it matches the type not the variable name.
>
> >       struct btrfs_root *local_root;
> >       struct btrfs_key key;
> >       unsigned int nofs_flag;
> > @@ -193,7 +193,6 @@ static int data_reloc_print_warning_inode(u64 inum,=
 u64 offset, u64 num_bytes,
> >       }
> >
> >       btrfs_put_root(local_root);
> > -     free_ipath(ipath);
> >       return 0;
> >
> >  err:
> > @@ -201,7 +200,6 @@ static int data_reloc_print_warning_inode(u64 inum,=
 u64 offset, u64 num_bytes,
> >  "checksum error at logical %llu mirror %u root %llu inode %llu offset =
%llu, path resolving failed with ret=3D%d",
> >                  warn->logical, warn->mirror_num, root, inum, offset, r=
et);
> >
> > -     free_ipath(ipath);
> >       return ret;
> >  }
> >
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index 692016b2b600..453832ded917 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -3298,7 +3298,7 @@ static long btrfs_ioctl_ino_to_path(struct btrfs_=
root *root, void __user *arg)
> >       u64 rel_ptr;
> >       int size;
> >       struct btrfs_ioctl_ino_path_args *ipa =3D NULL;
> > -     struct inode_fs_paths *ipath =3D NULL;
> > +     struct inode_fs_paths *ipath __free(ipath) =3D NULL;
> >       struct btrfs_path *path;
> >
> >       if (!capable(CAP_DAC_READ_SEARCH))
> > @@ -3346,7 +3346,6 @@ static long btrfs_ioctl_ino_to_path(struct btrfs_=
root *root, void __user *arg)
> >
> >  out:
> >       btrfs_free_path(path);
> > -     free_ipath(ipath);
> >       kfree(ipa);
> >
> >       return ret;
> > diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> > index fe266785804e..74d8af1ff02d 100644
> > --- a/fs/btrfs/scrub.c
> > +++ b/fs/btrfs/scrub.c
> > @@ -505,7 +505,7 @@ static int scrub_print_warning_inode(u64 inum, u64 =
offset, u64 num_bytes,
> >       struct btrfs_inode_item *inode_item;
> >       struct scrub_warning *swarn =3D warn_ctx;
> >       struct btrfs_fs_info *fs_info =3D swarn->dev->fs_info;
> > -     struct inode_fs_paths *ipath =3D NULL;
> > +     struct inode_fs_paths *ipath __free(ipath) =3D NULL;
> >       struct btrfs_root *local_root;
> >       struct btrfs_key key;
> >
> > @@ -569,7 +569,6 @@ static int scrub_print_warning_inode(u64 inum, u64 =
offset, u64 num_bytes,
> >                                 (char *)(unsigned long)ipath->fspath->v=
al[i]);
> >
> >       btrfs_put_root(local_root);
> > -     free_ipath(ipath);
> >       return 0;
> >
> >  err:
> > @@ -580,7 +579,6 @@ static int scrub_print_warning_inode(u64 inum, u64 =
offset, u64 num_bytes,
> >                         swarn->physical,
> >                         root, inum, offset, ret);
> >
> > -     free_ipath(ipath);
> >       return 0;
> >  }
> >
> > --
> > 2.51.1
> >
>

